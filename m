Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0357DC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4421A2242E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRGVPHVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4421A2242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT4n-000457-SJ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXSty-0006L2-4c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStu-0003NY-29
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jd6UAfhxwBzsTDunBLU1Pc61PjHz9hieyw9w4AUAMPw=;
 b=WRGVPHVwmbFxtGmxUlKDTt0KUtoZwLxedEX5m5HgwFUPjtzch9D21sUI6hsxQb6SwjUbIl
 xQwWO4PmdR5pv4H/nODtyqy43qZO3wBI38XbWCfcvfeSqYX+Qyv/zbzV/1iacyE2G0yibN
 PM7RRo+PSuBfNWn826KInrqgAy+xJ9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-BlZEckjQPRKQNcHGaB3qXQ-1; Tue, 27 Oct 2020 13:36:45 -0400
X-MC-Unique: BlZEckjQPRKQNcHGaB3qXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F21AA108E1AB;
 Tue, 27 Oct 2020 17:36:43 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88ED660C07;
 Tue, 27 Oct 2020 17:36:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/12] vhost-user-blk-test: fix races by using fd passing
Date: Tue, 27 Oct 2020 17:35:28 +0000
Message-Id: <20201027173528.213464-13-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGFzcyB0aGUgUU1QIGFuZCB2aG9zdC11c2VyLWJsayBzZXJ2ZXIgc29ja2V0cyBhcyBmaWxlIGRl
c2NyaXB0b3JzLiBUaGF0CndheSB0aGUgc29ja2V0cyBhcmUgYWxyZWFkeSBvcGVuIGFuZCBpbiBh
IGxpc3RlbiBzdGF0ZSB3aGVuIHRoZSBRRU1VCnByb2Nlc3MgaXMgbGF1bmNoZWQuCgpUaGlzIHNv
bHZlcyB0aGUgcmFjZSB3aXRoIHFlbXUtc3RvcmFnZS1kYWVtb24gc3RhcnR1cCB3aGVyZSB0aGUg
VU5JWApkb21haW4gc29ja2V0cyBtYXkgbm90IGJlIHJlYWR5IHlldCB3aGVuIFFFTVUgYXR0ZW1w
dHMgdG8gY29ubmVjdC4gSXQKYWxzbyBzYXZlcyB1cyBzbGVlcGluZyBmb3IgMSBzZWNvbmQgaWYg
dGhlIHFlbXUtc3RvcmFnZS1kYWVtb24gUU1QCnNvY2tldCBpcyBub3QgcmVhZHkgeWV0LgoKU2ln
bmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHRl
c3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYyB8IDQyICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMgYi90
ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMKaW5kZXggMGQwNTZjYzE4OS4uOTU4OWY5
MGIxNCAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jCisrKyBi
L3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYwpAQCAtNjgzLDggKzY4MywyMiBAQCBz
dGF0aWMgY2hhciAqZHJpdmVfY3JlYXRlKHZvaWQpCiAgICAgcmV0dXJuIHRfcGF0aDsKIH0KIAot
c3RhdGljIGNoYXIgc29ja19wYXRoX3RlbXBhdGVbXSA9ICIvdG1wL3F0ZXN0LnZob3N0X3VzZXJf
YmxrLlhYWFhYWCI7Ci1zdGF0aWMgY2hhciBxbXBfc29ja19wYXRoX3RlbXBhdGVbXSA9ICIvdG1w
L3F0ZXN0LnZob3N0X3VzZXJfYmxrLnFtcC5YWFhYWFgiOworc3RhdGljIGNoYXIgKmNyZWF0ZV9s
aXN0ZW5fc29ja2V0KGludCAqZmQpCit7CisgICAgaW50IHRtcF9mZDsKKyAgICBjaGFyICpwYXRo
OworCisgICAgLyogTm8gcmFjZSBiZWNhdXNlIG91ciBwaWQgbWFrZXMgdGhlIHBhdGggdW5pcXVl
ICovCisgICAgcGF0aCA9IGdfc3RyZHVwX3ByaW50ZigiL3RtcC9xdGVzdC0lZC1zb2NrLlhYWFhY
WCIsIGdldHBpZCgpKTsKKyAgICB0bXBfZmQgPSBta3N0ZW1wKHBhdGgpOworICAgIGdfYXNzZXJ0
X2NtcGludCh0bXBfZmQsID49LCAwKTsKKyAgICBjbG9zZSh0bXBfZmQpOworICAgIHVubGluayhw
YXRoKTsKKworICAgICpmZCA9IHF0ZXN0X3NvY2tldF9zZXJ2ZXIocGF0aCk7CisgICAgZ190ZXN0
X3F1ZXVlX2Rlc3Ryb3koZGVzdHJveV9maWxlLCBwYXRoKTsKKyAgICByZXR1cm4gcGF0aDsKK30K
IAogc3RhdGljIHZvaWQgcXVpdF9zdG9yYWdlX2RhZW1vbih2b2lkICpxbXBfdGVzdF9zdGF0ZSkK
IHsKQEAgLTcwOSwzNyArNzIzLDMzIEBAIHN0YXRpYyB2b2lkIHN0YXJ0X3Zob3N0X3VzZXJfYmxr
KEdTdHJpbmcgKmNtZF9saW5lLCBpbnQgdnVzX2luc3RhbmNlcywKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludCBudW1fcXVldWVzKQogewogICAgIGNvbnN0IGNoYXIgKnZob3N0
X3VzZXJfYmxrX2JpbiA9IHF0ZXN0X3FlbXVfc3RvcmFnZV9kYWVtb25fYmluYXJ5KCk7Ci0gICAg
aW50IGZkLCBxbXBfZmQsIGk7CisgICAgaW50IHFtcF9mZCwgaTsKICAgICBRVGVzdFN0YXRlICpx
bXBfdGVzdF9zdGF0ZTsKICAgICBnY2hhciAqaW1nX3BhdGg7Ci0gICAgY2hhciAqc29ja19wYXRo
ID0gTlVMTDsKLSAgICBjaGFyICpxbXBfc29ja19wYXRoID0gZ19zdHJkdXAocW1wX3NvY2tfcGF0
aF90ZW1wYXRlKTsKKyAgICBjaGFyICpxbXBfc29ja19wYXRoOwogICAgIEdTdHJpbmcgKnN0b3Jh
Z2VfZGFlbW9uX2NvbW1hbmQgPSBnX3N0cmluZ19uZXcoTlVMTCk7CiAKLSAgICBxbXBfZmQgPSBt
a3N0ZW1wKHFtcF9zb2NrX3BhdGgpOwotICAgIGdfYXNzZXJ0X2NtcGludChxbXBfZmQsID49LCAw
KTsKLSAgICBnX3Rlc3RfcXVldWVfZGVzdHJveShkZXN0cm95X2ZpbGUsIHFtcF9zb2NrX3BhdGgp
OworICAgIHFtcF9zb2NrX3BhdGggPSBjcmVhdGVfbGlzdGVuX3NvY2tldCgmcW1wX2ZkKTsKIAog
ICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYoc3RvcmFnZV9kYWVtb25fY29tbWFuZCwKICAgICAg
ICAgICAgICJleGVjICVzICIKLSAgICAgICAgICAgICItLWNoYXJkZXYgc29ja2V0LGlkPXFtcCxw
YXRoPSVzLHNlcnZlcixub3dhaXQgLS1tb25pdG9yIGNoYXJkZXY9cW1wICIsCi0gICAgICAgICAg
ICB2aG9zdF91c2VyX2Jsa19iaW4sIHFtcF9zb2NrX3BhdGgpOworICAgICAgICAgICAgIi0tY2hh
cmRldiBzb2NrZXQsaWQ9cW1wLGZkPSVkLHNlcnZlcixub3dhaXQgLS1tb25pdG9yIGNoYXJkZXY9
cW1wICIsCisgICAgICAgICAgICB2aG9zdF91c2VyX2Jsa19iaW4sIHFtcF9mZCk7CiAKICAgICBn
X3N0cmluZ19hcHBlbmRfcHJpbnRmKGNtZF9saW5lLAogICAgICAgICAgICAgIiAtb2JqZWN0IG1l
bW9yeS1iYWNrZW5kLW1lbWZkLGlkPW1lbSxzaXplPTI1Nk0sc2hhcmU9b24gLU0gbWVtb3J5LWJh
Y2tlbmQ9bWVtICIpOwogCiAgICAgZm9yIChpID0gMDsgaSA8IHZ1c19pbnN0YW5jZXM7IGkrKykg
ewotICAgICAgICBzb2NrX3BhdGggPSBnX3N0cmR1cChzb2NrX3BhdGhfdGVtcGF0ZSk7Ci0gICAg
ICAgIGZkID0gbWtzdGVtcChzb2NrX3BhdGgpOwotICAgICAgICBnX2Fzc2VydF9jbXBpbnQoZmQs
ID49LCAwKTsKLSAgICAgICAgZ190ZXN0X3F1ZXVlX2Rlc3Ryb3koZHJpdmVfZmlsZSwgc29ja19w
YXRoKTsKKyAgICAgICAgaW50IGZkOworICAgICAgICBjaGFyICpzb2NrX3BhdGggPSBjcmVhdGVf
bGlzdGVuX3NvY2tldCgmZmQpOworCiAgICAgICAgIC8qIGNyZWF0ZSBpbWFnZSBmaWxlICovCiAg
ICAgICAgIGltZ19wYXRoID0gZHJpdmVfY3JlYXRlKCk7CiAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZF9wcmludGYoc3RvcmFnZV9kYWVtb25fY29tbWFuZCwKICAgICAgICAgICAgICItLWJsb2NrZGV2
IGRyaXZlcj1maWxlLG5vZGUtbmFtZT1kaXNrJWQsZmlsZW5hbWU9JXMgIgotICAgICAgICAgICAg
Ii0tZXhwb3J0IHR5cGU9dmhvc3QtdXNlci1ibGssaWQ9ZGlzayVkLGFkZHIudHlwZT11bml4LGFk
ZHIucGF0aD0lcywiCisgICAgICAgICAgICAiLS1leHBvcnQgdHlwZT12aG9zdC11c2VyLWJsayxp
ZD1kaXNrJWQsYWRkci50eXBlPWZkLGFkZHIuc3RyPSVkLCIKICAgICAgICAgICAgICJub2RlLW5h
bWU9ZGlzayVpLHdyaXRhYmxlPW9uLG51bS1xdWV1ZXM9JWQgIiwKLSAgICAgICAgICAgIGksIGlt
Z19wYXRoLCBpLCBzb2NrX3BhdGgsIGksIG51bV9xdWV1ZXMpOworICAgICAgICAgICAgaSwgaW1n
X3BhdGgsIGksIGZkLCBpLCBudW1fcXVldWVzKTsKIAogICAgICAgICBnX3N0cmluZ19hcHBlbmRf
cHJpbnRmKGNtZF9saW5lLCAiLWNoYXJkZXYgc29ja2V0LGlkPWNoYXIlZCxwYXRoPSVzICIsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSArIDEsIHNvY2tfcGF0aCk7Ci0tIAoyLjI2
LjIKCg==


