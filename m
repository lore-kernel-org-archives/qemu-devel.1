Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD29C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7B208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJL0lfY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0dt-00031d-Di
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0cy-0001IJ-E8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0cx-0004i3-7V
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0cx-0004Uu-2U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nh15vDTrDF7YqOGEJcfqFZtZYBVL088KNsl1qKAeQ4=;
 b=bJL0lfY6yifpawgh5yi7+GA59vHztvvFv5iJDjkjQptLyKu4FwnlOjmeYokE3XcGVJjDZM
 ZsDTSv/3GAI08fAMLPkkvIKHC7Ms+bE+FIa5mNRO9uxRrlrUVWGWLrpBkLAcUT3XiPT0v0
 /2dBGHk3draql8zXaPpjsGiJmgxBEeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-8cb4jjRxM2y74-WD7T16kA-1; Wed, 11 Mar 2020 08:38:17 -0400
X-MC-Unique: 8cb4jjRxM2y74-WD7T16kA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1CF98017CC;
 Wed, 11 Mar 2020 12:38:16 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC16E8F377;
 Wed, 11 Mar 2020 12:38:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] thread: add QemuRecMutex lock guards
Date: Wed, 11 Mar 2020 12:36:23 +0000
Message-Id: <20200311123624.277221-2-stefanha@redhat.com>
In-Reply-To: <20200311123624.277221-1-stefanha@redhat.com>
References: <20200311123624.277221-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHR3byBsb2NrIGd1YXJkIG1hY3JvcyB0aGF0IGF1dG9tYXRp
Y2FsbHkgdW5sb2NrIGEKUWVtdVJlY011dGV4OgoKICB2b2lkIGYodm9pZCkgewogICAgICBRRU1V
X1JFQ19NVVRFWF9MT0NLX0dVQVJEKCZtdXRleCk7CiAgICAgIGlmICghbWF5X2ZhaWwoKSkgewog
ICAgICAgICAgcmV0dXJuOyAvKiBhdXRvbWF0aWNhbGx5IHVubG9ja3MgbXV0ZXggKi8KICAgICAg
fQogICAgICAuLi4KICB9CgphbmQ6CgogIFdJVEhfUUVNVV9SRUNfTVVURVhfTE9DS19HVUFSRCgm
bXV0ZXgpIHsKICAgICAgaWYgKCFtYXlfZmFpbCgpKSB7CiAgICAgICAgICByZXR1cm47IC8qIGF1
dG9tYXRpY2FsbHkgdW5sb2NrcyBtdXRleCAqLwogICAgICB9CiAgfQogIC8qIGF1dG9tYXRpY2Fs
bHkgdW5sb2NrcyBtdXRleCBoZXJlICovCiAgLi4uCgpDb252ZXJ0IFRDRyBwbHVnaW5zIGZ1bmN0
aW9ucyB0aGF0IGJlbmVmaXQgZnJvbSB0aGVzZSBtYWNyb3MuICBNYW51YWwKcWVtdV9yZWNfbXV0
ZXhfbG9jay91bmxvY2soKSBjYWxsZXJzIGFyZSBsZWZ0IHVubW9kaWZpZWQgaW4gY2FzZXMgd2hl
cmUKY2xhcml0eSB3b3VsZCBub3QgaW1wcm92ZSBieSBzd2l0Y2hpbmcgdG8gdGhlIG1hY3Jvcy4K
ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0t
CiBpbmNsdWRlL3FlbXUvdGhyZWFkLmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwog
cGx1Z2lucy9jb3JlLmMgICAgICAgIHwgIDYgKystLS0tCiBwbHVnaW5zL2xvYWRlci5jICAgICAg
fCAxNSArKysrKysrLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3RocmVhZC5oIGIvaW5j
bHVkZS9xZW11L3RocmVhZC5oCmluZGV4IDA0N2RiMDMwN2UuLjM5OTNhYjdiMjUgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvcWVtdS90aHJlYWQuaAorKysgYi9pbmNsdWRlL3FlbXUvdGhyZWFkLmgKQEAg
LTEzMiw2ICsxMzIsMzIgQEAgc3RhdGljIGlubGluZSBpbnQgKHFlbXVfcmVjX211dGV4X3RyeWxv
Y2spKFFlbXVSZWNNdXRleCAqbXV0ZXgpCiAvKiBQcm90b3R5cGVzIGZvciBvdGhlciBmdW5jdGlv
bnMgYXJlIGluIHRocmVhZC1wb3NpeC5oL3RocmVhZC13aW4zMi5oLiAgKi8KIHZvaWQgcWVtdV9y
ZWNfbXV0ZXhfaW5pdChRZW11UmVjTXV0ZXggKm11dGV4KTsKIAorc3RhdGljIGlubGluZSBRZW11
UmVjTXV0ZXggKnFlbXVfcmVjX211dGV4X2F1dG9fbG9jayhRZW11UmVjTXV0ZXggKm11dGV4KQor
eworICAgIHFlbXVfcmVjX211dGV4X2xvY2sobXV0ZXgpOworICAgIHJldHVybiBtdXRleDsKK30K
Kworc3RhdGljIGlubGluZSB2b2lkIHFlbXVfcmVjX211dGV4X2F1dG9fdW5sb2NrKFFlbXVSZWNN
dXRleCAqbXV0ZXgpCit7CisgICAgaWYgKG11dGV4KSB7CisgICAgICAgIHFlbXVfcmVjX211dGV4
X3VubG9jayhtdXRleCk7CisgICAgfQorfQorCitHX0RFRklORV9BVVRPUFRSX0NMRUFOVVBfRlVO
QyhRZW11UmVjTXV0ZXgsIHFlbXVfcmVjX211dGV4X2F1dG9fdW5sb2NrKQorCisjZGVmaW5lIFdJ
VEhfUUVNVV9SRUNfTVVURVhfTE9DS19HVUFSRF8obXV0ZXgsIHZhcikgXAorICAgIGZvciAoZ19h
dXRvcHRyKFFlbXVSZWNNdXRleCkgdmFyID0gcWVtdV9yZWNfbXV0ZXhfYXV0b19sb2NrKChtdXRl
eCkpOyBcCisgICAgICAgICB2YXI7IHFlbXVfcmVjX211dGV4X2F1dG9fdW5sb2NrKHZhciksIHZh
ciA9IE5VTEwpCisKKyNkZWZpbmUgV0lUSF9RRU1VX1JFQ19NVVRFWF9MT0NLX0dVQVJEKG11dGV4
KSBcCisgICAgV0lUSF9RRU1VX1JFQ19NVVRFWF9MT0NLX0dVQVJEXygobXV0ZXgpLCBxZW11X3Jl
Y19tdXRleF9hdXRvIyNfX0NPVU5URVJfXykKKworI2RlZmluZSBRRU1VX1JFQ19NVVRFWF9MT0NL
X0dVQVJEKG11dGV4KSBcCisgICAgZ19hdXRvcHRyKFFlbXVSZWNNdXRleCkgcWVtdV9yZWNfbXV0
ZXhfYXV0byMjX19DT1VOVEVSX18gPSBcCisgICAgICAgICAgICBxZW11X3JlY19tdXRleF9hdXRv
X2xvY2soKG11dGV4KSkKKwogdm9pZCBxZW11X2NvbmRfaW5pdChRZW11Q29uZCAqY29uZCk7CiB2
b2lkIHFlbXVfY29uZF9kZXN0cm95KFFlbXVDb25kICpjb25kKTsKIApkaWZmIC0tZ2l0IGEvcGx1
Z2lucy9jb3JlLmMgYi9wbHVnaW5zL2NvcmUuYwppbmRleCBlZDg2MzAxMWJhLi5jZjhjODVkZTlj
IDEwMDY0NAotLS0gYS9wbHVnaW5zL2NvcmUuYworKysgYi9wbHVnaW5zL2NvcmUuYwpAQCAtMTUw
LDExICsxNTAsMTEgQEAgZG9fcGx1Z2luX3JlZ2lzdGVyX2NiKHFlbXVfcGx1Z2luX2lkX3QgaWQs
IGVudW0gcWVtdV9wbHVnaW5fZXZlbnQgZXYsCiB7CiAgICAgc3RydWN0IHFlbXVfcGx1Z2luX2N0
eCAqY3R4OwogCi0gICAgcWVtdV9yZWNfbXV0ZXhfbG9jaygmcGx1Z2luLmxvY2spOworICAgIFFF
TVVfUkVDX01VVEVYX0xPQ0tfR1VBUkQoJnBsdWdpbi5sb2NrKTsKICAgICBjdHggPSBwbHVnaW5f
aWRfdG9fY3R4X2xvY2tlZChpZCk7CiAgICAgLyogaWYgdGhlIHBsdWdpbiBpcyBvbiBpdHMgd2F5
IG91dCwgaWdub3JlIHRoaXMgcmVxdWVzdCAqLwogICAgIGlmICh1bmxpa2VseShjdHgtPnVuaW5z
dGFsbGluZykpIHsKLSAgICAgICAgZ290byBvdXRfdW5sb2NrOworICAgICAgICByZXR1cm47CiAg
ICAgfQogICAgIGlmIChmdW5jKSB7CiAgICAgICAgIHN0cnVjdCBxZW11X3BsdWdpbl9jYiAqY2Ig
PSBjdHgtPmNhbGxiYWNrc1tldl07CkBAIC0xNzgsOCArMTc4LDYgQEAgZG9fcGx1Z2luX3JlZ2lz
dGVyX2NiKHFlbXVfcGx1Z2luX2lkX3QgaWQsIGVudW0gcWVtdV9wbHVnaW5fZXZlbnQgZXYsCiAg
ICAgfSBlbHNlIHsKICAgICAgICAgcGx1Z2luX3VucmVnaXN0ZXJfY2JfX2xvY2tlZChjdHgsIGV2
KTsKICAgICB9Ci0gb3V0X3VubG9jazoKLSAgICBxZW11X3JlY19tdXRleF91bmxvY2soJnBsdWdp
bi5sb2NrKTsKIH0KIAogdm9pZCBwbHVnaW5fcmVnaXN0ZXJfY2IocWVtdV9wbHVnaW5faWRfdCBp
ZCwgZW51bSBxZW11X3BsdWdpbl9ldmVudCBldiwKZGlmZiAtLWdpdCBhL3BsdWdpbnMvbG9hZGVy
LmMgYi9wbHVnaW5zL2xvYWRlci5jCmluZGV4IDE1ZmM3ZTU1MTUuLjk3NDJjOGQ0MWQgMTAwNjQ0
Ci0tLSBhL3BsdWdpbnMvbG9hZGVyLmMKKysrIGIvcGx1Z2lucy9sb2FkZXIuYwpAQCAtMzY3LDE1
ICszNjcsMTQgQEAgdm9pZCBwbHVnaW5fcmVzZXRfdW5pbnN0YWxsKHFlbXVfcGx1Z2luX2lkX3Qg
aWQsCiAgICAgc3RydWN0IHFlbXVfcGx1Z2luX3Jlc2V0X2RhdGEgKmRhdGE7CiAgICAgc3RydWN0
IHFlbXVfcGx1Z2luX2N0eCAqY3R4OwogCi0gICAgcWVtdV9yZWNfbXV0ZXhfbG9jaygmcGx1Z2lu
LmxvY2spOwotICAgIGN0eCA9IHBsdWdpbl9pZF90b19jdHhfbG9ja2VkKGlkKTsKLSAgICBpZiAo
Y3R4LT51bmluc3RhbGxpbmcgfHwgKHJlc2V0ICYmIGN0eC0+cmVzZXR0aW5nKSkgewotICAgICAg
ICBxZW11X3JlY19tdXRleF91bmxvY2soJnBsdWdpbi5sb2NrKTsKLSAgICAgICAgcmV0dXJuOwor
ICAgIFdJVEhfUUVNVV9SRUNfTVVURVhfTE9DS19HVUFSRCgmcGx1Z2luLmxvY2spIHsKKyAgICAg
ICAgY3R4ID0gcGx1Z2luX2lkX3RvX2N0eF9sb2NrZWQoaWQpOworICAgICAgICBpZiAoY3R4LT51
bmluc3RhbGxpbmcgfHwgKHJlc2V0ICYmIGN0eC0+cmVzZXR0aW5nKSkgeworICAgICAgICAgICAg
cmV0dXJuOworICAgICAgICB9CisgICAgICAgIGN0eC0+cmVzZXR0aW5nID0gcmVzZXQ7CisgICAg
ICAgIGN0eC0+dW5pbnN0YWxsaW5nID0gIXJlc2V0OwogICAgIH0KLSAgICBjdHgtPnJlc2V0dGlu
ZyA9IHJlc2V0OwotICAgIGN0eC0+dW5pbnN0YWxsaW5nID0gIXJlc2V0OwotICAgIHFlbXVfcmVj
X211dGV4X3VubG9jaygmcGx1Z2luLmxvY2spOwogCiAgICAgZGF0YSA9IGdfbmV3KHN0cnVjdCBx
ZW11X3BsdWdpbl9yZXNldF9kYXRhLCAxKTsKICAgICBkYXRhLT5jdHggPSBjdHg7Ci0tIAoyLjI0
LjEKCg==


