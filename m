Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AEB2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Psn0k8Sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AEB2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKp7-0002xC-Ac
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKal-0007n9-8x
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKah-0008CS-AQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bU7FHmO1Q5IzGNaqrVZ2Y/DmnO8bfXR5LUFvwtPF7FA=;
 b=Psn0k8SqnGl49HZewMTpMmV0ahG5kZ6D4PSTVNaFN12uIIVnMIO/q3+MAZyfwnhFVy3ex/
 3A/O5sd4O+fhXSJKHi46O+Aeni/+u1A/0+rZ0dEs19UPDuxa9y/1o4XUCSSSKklUupJVrE
 V2ROb4cfM7cFuYqxI0veL8SGjURdOlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-enx14_q5OYuWiPnFoIy6Bg-1; Wed, 04 Nov 2020 10:20:44 -0500
X-MC-Unique: enx14_q5OYuWiPnFoIy6Bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2FE96D583;
 Wed,  4 Nov 2020 15:20:42 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 588255D9CC;
 Wed,  4 Nov 2020 15:20:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/33] block/nvme: Simplify nvme_cmd_sync()
Date: Wed,  4 Nov 2020 15:18:13 +0000
Message-Id: <20201104151828.405824-19-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKQXMgYWxs
IGNvbW1hbmRzIHVzZSB0aGUgQURNSU4gcXVldWUsIGl0IGlzIHBvaW50bGVzcyB0byBwYXNzCml0
IGFzIGFyZ3VtZW50IGVhY2ggdGltZS4gUmVtb3ZlIHRoZSBhcmd1bWVudCwgYW5kIHJlbmFtZSB0
aGUKZnVuY3Rpb24gYXMgbnZtZV9hZG1pbl9jbWRfc3luYygpIHRvIG1ha2UgdGhpcyBuZXcgYmVo
YXZpb3IKY2xlYXJlci4KClJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhh
dC5jb20+ClRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+ClJl
dmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2Ut
aWQ6IDIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMTctcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9m
Zi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgfCAxOSAr
KysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5k
ZXggZWVkMTJmNDkzMy4uY2Q4NzU1NTVjYSAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBi
L2Jsb2NrL252bWUuYwpAQCAtNDgxLDE2ICs0ODEsMTcgQEAgc3RhdGljIHZvaWQgbnZtZV9zdWJt
aXRfY29tbWFuZChOVk1lUXVldWVQYWlyICpxLCBOVk1lUmVxdWVzdCAqcmVxLAogICAgIHFlbXVf
bXV0ZXhfdW5sb2NrKCZxLT5sb2NrKTsKIH0KIAotc3RhdGljIHZvaWQgbnZtZV9jbWRfc3luY19j
Yih2b2lkICpvcGFxdWUsIGludCByZXQpCitzdGF0aWMgdm9pZCBudm1lX2FkbWluX2NtZF9zeW5j
X2NiKHZvaWQgKm9wYXF1ZSwgaW50IHJldCkKIHsKICAgICBpbnQgKnByZXQgPSBvcGFxdWU7CiAg
ICAgKnByZXQgPSByZXQ7CiAgICAgYWlvX3dhaXRfa2ljaygpOwogfQogCi1zdGF0aWMgaW50IG52
bWVfY21kX3N5bmMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIE5WTWVRdWV1ZVBhaXIgKnEsCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgTnZtZUNtZCAqY21kKQorc3RhdGljIGludCBudm1lX2FkbWlu
X2NtZF9zeW5jKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBOdm1lQ21kICpjbWQpCiB7CisgICAgQkRS
Vk5WTWVTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7CisgICAgTlZNZVF1ZXVlUGFpciAqcSA9IHMtPnF1
ZXVlc1tJTkRFWF9BRE1JTl07CiAgICAgQWlvQ29udGV4dCAqYWlvX2NvbnRleHQgPSBiZHJ2X2dl
dF9haW9fY29udGV4dChicyk7CiAgICAgTlZNZVJlcXVlc3QgKnJlcTsKICAgICBpbnQgcmV0ID0g
LUVJTlBST0dSRVNTOwpAQCAtNDk4LDcgKzQ5OSw3IEBAIHN0YXRpYyBpbnQgbnZtZV9jbWRfc3lu
YyhCbG9ja0RyaXZlclN0YXRlICpicywgTlZNZVF1ZXVlUGFpciAqcSwKICAgICBpZiAoIXJlcSkg
ewogICAgICAgICByZXR1cm4gLUVCVVNZOwogICAgIH0KLSAgICBudm1lX3N1Ym1pdF9jb21tYW5k
KHEsIHJlcSwgY21kLCBudm1lX2NtZF9zeW5jX2NiLCAmcmV0KTsKKyAgICBudm1lX3N1Ym1pdF9j
b21tYW5kKHEsIHJlcSwgY21kLCBudm1lX2FkbWluX2NtZF9zeW5jX2NiLCAmcmV0KTsKIAogICAg
IEFJT19XQUlUX1dISUxFKGFpb19jb250ZXh0LCByZXQgPT0gLUVJTlBST0dSRVNTKTsKICAgICBy
ZXR1cm4gcmV0OwpAQCAtNTM1LDcgKzUzNiw3IEBAIHN0YXRpYyBib29sIG52bWVfaWRlbnRpZnko
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludCBuYW1lc3BhY2UsIEVycm9yICoqZXJycCkKIAogICAg
IG1lbXNldChpZCwgMCwgc2l6ZW9mKCppZCkpOwogICAgIGNtZC5kcHRyLnBycDEgPSBjcHVfdG9f
bGU2NChpb3ZhKTsKLSAgICBpZiAobnZtZV9jbWRfc3luYyhicywgcy0+cXVldWVzW0lOREVYX0FE
TUlOXSwgJmNtZCkpIHsKKyAgICBpZiAobnZtZV9hZG1pbl9jbWRfc3luYyhicywgJmNtZCkpIHsK
ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRmFpbGVkIHRvIGlkZW50aWZ5IGNvbnRyb2xsZXIi
KTsKICAgICAgICAgZ290byBvdXQ7CiAgICAgfQpAQCAtNTU4LDcgKzU1OSw3IEBAIHN0YXRpYyBi
b29sIG52bWVfaWRlbnRpZnkoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludCBuYW1lc3BhY2UsIEVy
cm9yICoqZXJycCkKICAgICBtZW1zZXQoaWQsIDAsIHNpemVvZigqaWQpKTsKICAgICBjbWQuY2R3
MTAgPSAwOwogICAgIGNtZC5uc2lkID0gY3B1X3RvX2xlMzIobmFtZXNwYWNlKTsKLSAgICBpZiAo
bnZtZV9jbWRfc3luYyhicywgcy0+cXVldWVzW0lOREVYX0FETUlOXSwgJmNtZCkpIHsKKyAgICBp
ZiAobnZtZV9hZG1pbl9jbWRfc3luYyhicywgJmNtZCkpIHsKICAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiRmFpbGVkIHRvIGlkZW50aWZ5IG5hbWVzcGFjZSIpOwogICAgICAgICBnb3RvIG91dDsK
ICAgICB9CkBAIC02NjQsNyArNjY1LDcgQEAgc3RhdGljIGJvb2wgbnZtZV9hZGRfaW9fcXVldWUo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCkKICAgICAgICAgLmNkdzEwID0gY3B1
X3RvX2xlMzIoKChxdWV1ZV9zaXplIC0gMSkgPDwgMTYpIHwgbiksCiAgICAgICAgIC5jZHcxMSA9
IGNwdV90b19sZTMyKE5WTUVfQ1FfSUVOIHwgTlZNRV9DUV9QQyksCiAgICAgfTsKLSAgICBpZiAo
bnZtZV9jbWRfc3luYyhicywgcy0+cXVldWVzW0lOREVYX0FETUlOXSwgJmNtZCkpIHsKKyAgICBp
ZiAobnZtZV9hZG1pbl9jbWRfc3luYyhicywgJmNtZCkpIHsKICAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiRmFpbGVkIHRvIGNyZWF0ZSBDUSBpbyBxdWV1ZSBbJXVdIiwgbik7CiAgICAgICAgIGdv
dG8gb3V0X2Vycm9yOwogICAgIH0KQEAgLTY3NCw3ICs2NzUsNyBAQCBzdGF0aWMgYm9vbCBudm1l
X2FkZF9pb19xdWV1ZShCbG9ja0RyaXZlclN0YXRlICpicywgRXJyb3IgKiplcnJwKQogICAgICAg
ICAuY2R3MTAgPSBjcHVfdG9fbGUzMigoKHF1ZXVlX3NpemUgLSAxKSA8PCAxNikgfCBuKSwKICAg
ICAgICAgLmNkdzExID0gY3B1X3RvX2xlMzIoTlZNRV9TUV9QQyB8IChuIDw8IDE2KSksCiAgICAg
fTsKLSAgICBpZiAobnZtZV9jbWRfc3luYyhicywgcy0+cXVldWVzW0lOREVYX0FETUlOXSwgJmNt
ZCkpIHsKKyAgICBpZiAobnZtZV9hZG1pbl9jbWRfc3luYyhicywgJmNtZCkpIHsKICAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiRmFpbGVkIHRvIGNyZWF0ZSBTUSBpbyBxdWV1ZSBbJXVdIiwgbik7
CiAgICAgICAgIGdvdG8gb3V0X2Vycm9yOwogICAgIH0KQEAgLTg4Nyw3ICs4ODgsNyBAQCBzdGF0
aWMgaW50IG52bWVfZW5hYmxlX2Rpc2FibGVfd3JpdGVfY2FjaGUoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsIGJvb2wgZW5hYmxlLAogICAgICAgICAuY2R3MTEgPSBjcHVfdG9fbGUzMihlbmFibGUgPyAw
eDAxIDogMHgwMCksCiAgICAgfTsKIAotICAgIHJldCA9IG52bWVfY21kX3N5bmMoYnMsIHMtPnF1
ZXVlc1tJTkRFWF9BRE1JTl0sICZjbWQpOworICAgIHJldCA9IG52bWVfYWRtaW5fY21kX3N5bmMo
YnMsICZjbWQpOwogICAgIGlmIChyZXQpIHsKICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRmFp
bGVkIHRvIGNvbmZpZ3VyZSBOVk1lIHdyaXRlIGNhY2hlIik7CiAgICAgfQotLSAKMi4yOC4wCgo=


