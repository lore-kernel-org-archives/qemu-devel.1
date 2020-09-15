Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77147C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F8F206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD9YU4ED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F8F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9iU-0006I0-Lo
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI9gd-0004sS-OS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI9gb-0006jM-Gx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600171428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U430QtBsTWFREOkRM85ZbGnYJYkSQ7370e7MvFDRAGw=;
 b=eD9YU4EDDAw9M5AFang9aB9cXCpyje9Thz+7UsrRsAct1p6JGaeTnic8M+1tHDtQy9iyGO
 OKOnljbnGWYvvmS+c9rmk7Cv4SbtbSdL4ZpU80ecuDAjSaaUFQiWUMrk9y8csEykmCxMD1
 B0YPr4uH898CryNfjL/I5v6wHMIX12k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-tUg1l1_KPJmL4HmVFZco0A-1; Tue, 15 Sep 2020 08:03:45 -0400
X-MC-Unique: tUg1l1_KPJmL4HmVFZco0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F8FF1009441;
 Tue, 15 Sep 2020 12:03:44 +0000 (UTC)
Received: from localhost (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7AC8614F5;
 Tue, 15 Sep 2020 12:03:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tests: add test-fdmon-epoll
Date: Tue, 15 Sep 2020 13:03:39 +0100
Message-Id: <20200915120339.702938-3-stefanha@redhat.com>
In-Reply-To: <20200915120339.702938-1-stefanha@redhat.com>
References: <20200915120339.702938-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGVzdCBhaW9fZGlzYWJsZV9leHRlcm5hbCgpLCB3aGljaCBzd2l0Y2hlcyBmcm9tIGZkbW9uLWVw
b2xsIGJhY2sgdG8KZmRtb24tcG9sbC4gVGhpcyByZXN1bHRlZCBpbiBhbiBhc3NlcnRpb24gZmFp
bHVyZSB0aGF0IHdhcyBmaXhlZCBpbiB0aGUKcHJldmlvdXMgcGF0Y2guCgpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogTUFJTlRBSU5FUlMg
ICAgICAgICAgICAgIHwgIDEgKwogdGVzdHMvdGVzdC1mZG1vbi1lcG9sbC5jIHwgNzMgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvbWVzb24uYnVpbGQgICAg
ICAgIHwgIDMgKysKIDMgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RzL3Rlc3QtZmRtb24tZXBvbGwuYwoKZGlmZiAtLWdpdCBhL01BSU5UQUlO
RVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggM2QxN2NhZDE5YS4uOTllNDAxMDYyMyAxMDA2NDQKLS0t
IGEvTUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTIxMzIsNiArMjEzMiw3IEBAIEY6
IG1pZ3JhdGlvbi9ibG9jayoKIEY6IGluY2x1ZGUvYmxvY2svYWlvLmgKIEY6IGluY2x1ZGUvYmxv
Y2svYWlvLXdhaXQuaAogRjogc2NyaXB0cy9xZW11Z2RiL2Fpby5weQorRjogdGVzdHMvdGVzdC1m
ZG1vbi1lcG9sbC5jCiBUOiBnaXQgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0
IGJsb2NrCiAKIEJsb2NrIFNDU0kgc3Vic3lzdGVtCmRpZmYgLS1naXQgYS90ZXN0cy90ZXN0LWZk
bW9uLWVwb2xsLmMgYi90ZXN0cy90ZXN0LWZkbW9uLWVwb2xsLmMKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMC4uMTFmZDhhMmZhOQotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3Rz
L3Rlc3QtZmRtb24tZXBvbGwuYwpAQCAtMCwwICsxLDczIEBACisvKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLworLyoKKyAqIGZkbW9uLWVwb2xsIHRlc3RzCisg
KgorICogQ29weXJpZ2h0IChjKSAyMDIwIFJlZCBIYXQsIEluYy4KKyAqLworCisjaW5jbHVkZSAi
cWVtdS9vc2RlcC5oIgorI2luY2x1ZGUgImJsb2NrL2Fpby5oIgorI2luY2x1ZGUgInFhcGkvZXJy
b3IuaCIKKyNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgorCitzdGF0aWMgQWlvQ29udGV4dCAq
Y3R4OworCitzdGF0aWMgdm9pZCBkdW1teV9mZF9oYW5kbGVyKEV2ZW50Tm90aWZpZXIgKm5vdGlm
aWVyKQoreworICAgIGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFyKG5vdGlmaWVyKTsKK30K
Kworc3RhdGljIHZvaWQgYWRkX2V2ZW50X25vdGlmaWVycyhFdmVudE5vdGlmaWVyICpub3RpZmll
cnMsIHNpemVfdCBuKQoreworICAgIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbjsgaSsrKSB7Cisg
ICAgICAgIGV2ZW50X25vdGlmaWVyX2luaXQoJm5vdGlmaWVyc1tpXSwgZmFsc2UpOworICAgICAg
ICBhaW9fc2V0X2V2ZW50X25vdGlmaWVyKGN0eCwgJm5vdGlmaWVyc1tpXSwgZmFsc2UsCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZHVtbXlfZmRfaGFuZGxlciwgTlVMTCk7CisgICAg
fQorfQorCitzdGF0aWMgdm9pZCByZW1vdmVfZXZlbnRfbm90aWZpZXJzKEV2ZW50Tm90aWZpZXIg
Km5vdGlmaWVycywgc2l6ZV90IG4pCit7CisgICAgZm9yIChzaXplX3QgaSA9IDA7IGkgPCBuOyBp
KyspIHsKKyAgICAgICAgYWlvX3NldF9ldmVudF9ub3RpZmllcihjdHgsICZub3RpZmllcnNbaV0s
IGZhbHNlLCBOVUxMLCBOVUxMKTsKKyAgICAgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmbm90
aWZpZXJzW2ldKTsKKyAgICB9Cit9CisKKy8qIENoZWNrIHRoYXQgZmQgaGFuZGxlcnMgd29yayB3
aGVuIGV4dGVybmFsIGNsaWVudHMgYXJlIGRpc2FibGVkICovCitzdGF0aWMgdm9pZCB0ZXN0X2V4
dGVybmFsX2Rpc2FibGVkKHZvaWQpCit7CisgICAgRXZlbnROb3RpZmllciBub3RpZmllcnNbMTAw
XTsKKworICAgIC8qIGZkbW9uLWVwb2xsIGlzIG9ubHkgZW5hYmxlZCB3aGVuIG1hbnkgZmQgaGFu
ZGxlcnMgYXJlIHJlZ2lzdGVyZWQgKi8KKyAgICBhZGRfZXZlbnRfbm90aWZpZXJzKG5vdGlmaWVy
cywgR19OX0VMRU1FTlRTKG5vdGlmaWVycykpOworCisgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZu
b3RpZmllcnNbMF0pOworICAgIGFzc2VydChhaW9fcG9sbChjdHgsIHRydWUpKTsKKworICAgIGFp
b19kaXNhYmxlX2V4dGVybmFsKGN0eCk7CisgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZub3RpZmll
cnNbMF0pOworICAgIGFzc2VydChhaW9fcG9sbChjdHgsIHRydWUpKTsKKyAgICBhaW9fZW5hYmxl
X2V4dGVybmFsKGN0eCk7CisKKyAgICByZW1vdmVfZXZlbnRfbm90aWZpZXJzKG5vdGlmaWVycywg
R19OX0VMRU1FTlRTKG5vdGlmaWVycykpOworfQorCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCit7CisgICAgLyoKKyAgICAgKiBUaGlzIGNvZGUgcmVsaWVzIG9uIHRoZSBmYWN0IHRo
YXQgZmRtb24taW9fdXJpbmcgZGlzYWJsZXMgaXRzZWxmIHdoZW4KKyAgICAgKiB0aGUgZ2xpYiBt
YWluIGxvb3AgaXMgaW4gdXNlLiBUaGUgbWFpbiBsb29wIHVzZXMgZmRtb24tcG9sbCBhbmQgdXBn
cmFkZXMKKyAgICAgKiB0byBmZG1vbi1lcG9sbCB3aGVuIHRoZSBudW1iZXIgb2YgZmRzIGV4Y2Vl
ZHMgYSB0aHJlc2hvbGQuCisgICAgICovCisgICAgcWVtdV9pbml0X21haW5fbG9vcCgmZXJyb3Jf
ZmF0YWwpOworICAgIGN0eCA9IHFlbXVfZ2V0X2Fpb19jb250ZXh0KCk7CisKKyAgICB3aGlsZSAo
Z19tYWluX2NvbnRleHRfaXRlcmF0aW9uKE5VTEwsIGZhbHNlKSkgeworICAgICAgICAvKiBEbyBu
b3RoaW5nICovCisgICAgfQorCisgICAgZ190ZXN0X2luaXQoJmFyZ2MsICZhcmd2LCBOVUxMKTsK
KyAgICBnX3Rlc3RfYWRkX2Z1bmMoIi9mZG1vbi1lcG9sbC9leHRlcm5hbC1kaXNhYmxlZCIsIHRl
c3RfZXh0ZXJuYWxfZGlzYWJsZWQpOworICAgIHJldHVybiBnX3Rlc3RfcnVuKCk7Cit9CmRpZmYg
LS1naXQgYS90ZXN0cy9tZXNvbi5idWlsZCBiL3Rlc3RzL21lc29uLmJ1aWxkCmluZGV4IGRhZThh
NzdkZjEuLjYyMjc3ZTY4NTggMTAwNjQ0Ci0tLSBhL3Rlc3RzL21lc29uLmJ1aWxkCisrKyBiL3Rl
c3RzL21lc29uLmJ1aWxkCkBAIC0xNjksNiArMTY5LDkgQEAgaWYgaGF2ZV9ibG9jawogICBpZiAn
Q09ORklHX05FVFRMRScgaW4gY29uZmlnX2hvc3Qgb3IgJ0NPTkZJR19HQ1JZUFQnIGluIGNvbmZp
Z19ob3N0CiAgICAgdGVzdHMgKz0geyd0ZXN0LWNyeXB0by1wYmtkZic6IFtpb119CiAgIGVuZGlm
CisgIGlmICdDT05GSUdfRVBPTExfQ1JFQVRFMScgaW4gY29uZmlnX2hvc3QKKyAgICB0ZXN0cyAr
PSB7J3Rlc3QtZmRtb24tZXBvbGwnOiBbdGVzdGJsb2NrXX0KKyAgZW5kaWYKICAgYmVuY2hzICs9
IHsKICAgICAgJ2JlbmNobWFyay1jcnlwdG8taGFzaCc6IFtjcnlwdG9dLAogICAgICAnYmVuY2ht
YXJrLWNyeXB0by1obWFjJzogW2NyeXB0b10sCi0tIAoyLjI2LjIKCg==


