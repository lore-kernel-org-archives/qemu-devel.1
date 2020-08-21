Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B29C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2339B20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqMhfkrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2339B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k944B-0006Zu-6a
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k942w-0005DP-PW
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:13:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k942t-0000JT-8B
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWr0Zb/P5tn5lmfDrRNkAndUcbgT7XDOpIOik5d1buk=;
 b=BqMhfkrVAZiWM1x0ka5lTPukC15qNqjAMuvaRbH94ZPLMvpx/pG0V1cFZYiPz+pcjBLpmd
 +/xianpfchgNqW1Jm5PoH7WOT0BsRlVsrkaVm7cutXeMyW/D0bXaVjIx7jiUPMV6P3D7lU
 6jYfXk3oFOdztRL+VYnDyhFEQ+xi4Tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-WygTYZrNOyWtC_gIuIo4IQ-1; Fri, 21 Aug 2020 06:13:08 -0400
X-MC-Unique: WygTYZrNOyWtC_gIuIo4IQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97B8F107464F;
 Fri, 21 Aug 2020 10:13:07 +0000 (UTC)
Received: from localhost (ovpn-113-166.ams2.redhat.com [10.36.113.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60EB37E318;
 Fri, 21 Aug 2020 10:13:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests: add test-fdmon-epoll
Date: Fri, 21 Aug 2020 11:12:52 +0100
Message-Id: <20200821101252.203056-3-stefanha@redhat.com>
In-Reply-To: <20200821101252.203056-1-stefanha@redhat.com>
References: <20200821101252.203056-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
ICAgICAgICAgICAgIHwgIDEgKwogdGVzdHMvTWFrZWZpbGUuaW5jbHVkZSAgIHwgIDQgKysrCiB0
ZXN0cy90ZXN0LWZkbW9uLWVwb2xsLmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDc4IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy90ZXN0LWZkbW9uLWVwb2xsLmMKCmRpZmYgLS1naXQgYS9NQUlOVEFJ
TkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDA4ODZlYjNkMmIuLjZkMmU5OWI5NGYgMTAwNjQ0Ci0t
LSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0yMTA5LDYgKzIxMDksNyBAQCBG
OiBtaWdyYXRpb24vYmxvY2sqCiBGOiBpbmNsdWRlL2Jsb2NrL2Fpby5oCiBGOiBpbmNsdWRlL2Js
b2NrL2Fpby13YWl0LmgKIEY6IHNjcmlwdHMvcWVtdWdkYi9haW8ucHkKK0Y6IHRlc3RzL3Rlc3Qt
ZmRtb24tZXBvbGwuYwogVDogZ2l0IGh0dHBzOi8vZ2l0aHViLmNvbS9zdGVmYW5oYS9xZW11Lmdp
dCBibG9jawogCiBCbG9jayBTQ1NJIHN1YnN5c3RlbQpkaWZmIC0tZ2l0IGEvdGVzdHMvTWFrZWZp
bGUuaW5jbHVkZSBiL3Rlc3RzL01ha2VmaWxlLmluY2x1ZGUKaW5kZXggYzdlNDY0NmRlZC4uYjc4
NWU0ODdiNyAxMDA2NDQKLS0tIGEvdGVzdHMvTWFrZWZpbGUuaW5jbHVkZQorKysgYi90ZXN0cy9N
YWtlZmlsZS5pbmNsdWRlCkBAIC03OCw2ICs3OCw5IEBAIGNoZWNrLXVuaXQtJChDT05GSUdfU09G
VE1NVSkgKz0gdGVzdHMvdGVzdC1pb3YkKEVYRVNVRikKIGNoZWNrLXVuaXQteSArPSB0ZXN0cy90
ZXN0LWJpdG1hcCQoRVhFU1VGKQogY2hlY2stdW5pdC0kKENPTkZJR19CTE9DSykgKz0gdGVzdHMv
dGVzdC1haW8kKEVYRVNVRikKIGNoZWNrLXVuaXQtJChDT05GSUdfQkxPQ0spICs9IHRlc3RzL3Rl
c3QtYWlvLW11bHRpdGhyZWFkJChFWEVTVUYpCitpZmVxICgkKENPTkZJR19FUE9MTF9DUkVBVEUx
KSx5KQorY2hlY2stdW5pdC0kKENPTkZJR19CTE9DSykgKz0gdGVzdHMvdGVzdC1mZG1vbi1lcG9s
bCQoRVhFU1VGKQorZW5kaWYKIGNoZWNrLXVuaXQtJChDT05GSUdfQkxPQ0spICs9IHRlc3RzL3Rl
c3QtdGhyb3R0bGUkKEVYRVNVRikKIGNoZWNrLXVuaXQtJChDT05GSUdfQkxPQ0spICs9IHRlc3Rz
L3Rlc3QtdGhyZWFkLXBvb2wkKEVYRVNVRikKIGNoZWNrLXVuaXQtJChDT05GSUdfQkxPQ0spICs9
IHRlc3RzL3Rlc3QtaGJpdG1hcCQoRVhFU1VGKQpAQCAtNDA4LDYgKzQxMSw3IEBAIHRlc3RzL3Rl
c3QtY2hhciQoRVhFU1VGKTogdGVzdHMvdGVzdC1jaGFyLm8gJCh0ZXN0LXV0aWwtb2JqLXkpICQo
dGVzdC1pby1vYmoteSkKIHRlc3RzL3Rlc3QtY29yb3V0aW5lJChFWEVTVUYpOiB0ZXN0cy90ZXN0
LWNvcm91dGluZS5vICQodGVzdC1ibG9jay1vYmoteSkKIHRlc3RzL3Rlc3QtYWlvJChFWEVTVUYp
OiB0ZXN0cy90ZXN0LWFpby5vICQodGVzdC1ibG9jay1vYmoteSkKIHRlc3RzL3Rlc3QtYWlvLW11
bHRpdGhyZWFkJChFWEVTVUYpOiB0ZXN0cy90ZXN0LWFpby1tdWx0aXRocmVhZC5vICQodGVzdC1i
bG9jay1vYmoteSkKK3Rlc3RzL3Rlc3QtZmRtb24tZXBvbGwkKEVYRVNVRik6IHRlc3RzL3Rlc3Qt
ZmRtb24tZXBvbGwubyAkKHRlc3QtYmxvY2stb2JqLXkpCiB0ZXN0cy90ZXN0LXRocm90dGxlJChF
WEVTVUYpOiB0ZXN0cy90ZXN0LXRocm90dGxlLm8gJCh0ZXN0LWJsb2NrLW9iai15KQogdGVzdHMv
dGVzdC1iZHJ2LWRyYWluJChFWEVTVUYpOiB0ZXN0cy90ZXN0LWJkcnYtZHJhaW4ubyAkKHRlc3Qt
YmxvY2stb2JqLXkpICQodGVzdC11dGlsLW9iai15KQogdGVzdHMvdGVzdC1iZHJ2LWdyYXBoLW1v
ZCQoRVhFU1VGKTogdGVzdHMvdGVzdC1iZHJ2LWdyYXBoLW1vZC5vICQodGVzdC1ibG9jay1vYmot
eSkgJCh0ZXN0LXV0aWwtb2JqLXkpCmRpZmYgLS1naXQgYS90ZXN0cy90ZXN0LWZkbW9uLWVwb2xs
LmMgYi90ZXN0cy90ZXN0LWZkbW9uLWVwb2xsLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMDAwMC4uMTFmZDhhMmZhOQotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3Rlc3QtZmRt
b24tZXBvbGwuYwpAQCAtMCwwICsxLDczIEBACisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlciAqLworLyoKKyAqIGZkbW9uLWVwb2xsIHRlc3RzCisgKgorICogQ29w
eXJpZ2h0IChjKSAyMDIwIFJlZCBIYXQsIEluYy4KKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIgorI2luY2x1ZGUgImJsb2NrL2Fpby5oIgorI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKKyNp
bmNsdWRlICJxZW11L21haW4tbG9vcC5oIgorCitzdGF0aWMgQWlvQ29udGV4dCAqY3R4OworCitz
dGF0aWMgdm9pZCBkdW1teV9mZF9oYW5kbGVyKEV2ZW50Tm90aWZpZXIgKm5vdGlmaWVyKQorewor
ICAgIGV2ZW50X25vdGlmaWVyX3Rlc3RfYW5kX2NsZWFyKG5vdGlmaWVyKTsKK30KKworc3RhdGlj
IHZvaWQgYWRkX2V2ZW50X25vdGlmaWVycyhFdmVudE5vdGlmaWVyICpub3RpZmllcnMsIHNpemVf
dCBuKQoreworICAgIGZvciAoc2l6ZV90IGkgPSAwOyBpIDwgbjsgaSsrKSB7CisgICAgICAgIGV2
ZW50X25vdGlmaWVyX2luaXQoJm5vdGlmaWVyc1tpXSwgZmFsc2UpOworICAgICAgICBhaW9fc2V0
X2V2ZW50X25vdGlmaWVyKGN0eCwgJm5vdGlmaWVyc1tpXSwgZmFsc2UsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZHVtbXlfZmRfaGFuZGxlciwgTlVMTCk7CisgICAgfQorfQorCitz
dGF0aWMgdm9pZCByZW1vdmVfZXZlbnRfbm90aWZpZXJzKEV2ZW50Tm90aWZpZXIgKm5vdGlmaWVy
cywgc2l6ZV90IG4pCit7CisgICAgZm9yIChzaXplX3QgaSA9IDA7IGkgPCBuOyBpKyspIHsKKyAg
ICAgICAgYWlvX3NldF9ldmVudF9ub3RpZmllcihjdHgsICZub3RpZmllcnNbaV0sIGZhbHNlLCBO
VUxMLCBOVUxMKTsKKyAgICAgICAgZXZlbnRfbm90aWZpZXJfY2xlYW51cCgmbm90aWZpZXJzW2ld
KTsKKyAgICB9Cit9CisKKy8qIENoZWNrIHRoYXQgZmQgaGFuZGxlcnMgd29yayB3aGVuIGV4dGVy
bmFsIGNsaWVudHMgYXJlIGRpc2FibGVkICovCitzdGF0aWMgdm9pZCB0ZXN0X2V4dGVybmFsX2Rp
c2FibGVkKHZvaWQpCit7CisgICAgRXZlbnROb3RpZmllciBub3RpZmllcnNbMTAwXTsKKworICAg
IC8qIGZkbW9uLWVwb2xsIGlzIG9ubHkgZW5hYmxlZCB3aGVuIG1hbnkgZmQgaGFuZGxlcnMgYXJl
IHJlZ2lzdGVyZWQgKi8KKyAgICBhZGRfZXZlbnRfbm90aWZpZXJzKG5vdGlmaWVycywgR19OX0VM
RU1FTlRTKG5vdGlmaWVycykpOworCisgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZub3RpZmllcnNb
MF0pOworICAgIGFzc2VydChhaW9fcG9sbChjdHgsIHRydWUpKTsKKworICAgIGFpb19kaXNhYmxl
X2V4dGVybmFsKGN0eCk7CisgICAgZXZlbnRfbm90aWZpZXJfc2V0KCZub3RpZmllcnNbMF0pOwor
ICAgIGFzc2VydChhaW9fcG9sbChjdHgsIHRydWUpKTsKKyAgICBhaW9fZW5hYmxlX2V4dGVybmFs
KGN0eCk7CisKKyAgICByZW1vdmVfZXZlbnRfbm90aWZpZXJzKG5vdGlmaWVycywgR19OX0VMRU1F
TlRTKG5vdGlmaWVycykpOworfQorCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCit7
CisgICAgLyoKKyAgICAgKiBUaGlzIGNvZGUgcmVsaWVzIG9uIHRoZSBmYWN0IHRoYXQgZmRtb24t
aW9fdXJpbmcgZGlzYWJsZXMgaXRzZWxmIHdoZW4KKyAgICAgKiB0aGUgZ2xpYiBtYWluIGxvb3Ag
aXMgaW4gdXNlLiBUaGUgbWFpbiBsb29wIHVzZXMgZmRtb24tcG9sbCBhbmQgdXBncmFkZXMKKyAg
ICAgKiB0byBmZG1vbi1lcG9sbCB3aGVuIHRoZSBudW1iZXIgb2YgZmRzIGV4Y2VlZHMgYSB0aHJl
c2hvbGQuCisgICAgICovCisgICAgcWVtdV9pbml0X21haW5fbG9vcCgmZXJyb3JfZmF0YWwpOwor
ICAgIGN0eCA9IHFlbXVfZ2V0X2Fpb19jb250ZXh0KCk7CisKKyAgICB3aGlsZSAoZ19tYWluX2Nv
bnRleHRfaXRlcmF0aW9uKE5VTEwsIGZhbHNlKSkgeworICAgICAgICAvKiBEbyBub3RoaW5nICov
CisgICAgfQorCisgICAgZ190ZXN0X2luaXQoJmFyZ2MsICZhcmd2LCBOVUxMKTsKKyAgICBnX3Rl
c3RfYWRkX2Z1bmMoIi9mZG1vbi1lcG9sbC9leHRlcm5hbC1kaXNhYmxlZCIsIHRlc3RfZXh0ZXJu
YWxfZGlzYWJsZWQpOworICAgIHJldHVybiBnX3Rlc3RfcnVuKCk7Cit9Ci0tIAoyLjI2LjIKCg==


