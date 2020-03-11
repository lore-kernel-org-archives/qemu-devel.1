Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25769C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BA5208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uu4ofFWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BA5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0eb-0004R9-1w
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0d0-0001Ms-4C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0cy-0004pI-HL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48325
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0cy-0004lv-DD
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h4N6uuF6VeTZN8iqYzd6Y0h1MwU3ts141iawsEo5kS4=;
 b=Uu4ofFWfBi69wF14/0RWF+Bj/kNLYmDa86LoDq7Oid9RBT1LDwhikIPKz0uMkOQvUsRrsf
 qgH82KbEjGtsJneK5R7XN/t8ygFm2siWozeHHZRM1u7P4jHpPl3JKhKTEuDuPsLO67SjA6
 dlAnuC91sbLADehf4e7ZQOcHBebQGaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-l5hgkbOTMAmD2tLVGloI4w-1; Wed, 11 Mar 2020 08:38:22 -0400
X-MC-Unique: l5hgkbOTMAmD2tLVGloI4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 474908017CC;
 Wed, 11 Mar 2020 12:38:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C87E73865;
 Wed, 11 Mar 2020 12:38:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] thread: add QemuMutex lock guards
Date: Wed, 11 Mar 2020 12:36:24 +0000
Message-Id: <20200311123624.277221-3-stefanha@redhat.com>
In-Reply-To: <20200311123624.277221-1-stefanha@redhat.com>
References: <20200311123624.277221-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Y2FsbHkgdW5sb2NrIGEKUWVtdU11dGV4OgoKICB2b2lkIGYodm9pZCkgewogICAgICBRRU1VX01V
VEVYX0xPQ0tfR1VBUkQoJm11dGV4KTsKICAgICAgaWYgKCFtYXlfZmFpbCgpKSB7CiAgICAgICAg
ICByZXR1cm47IC8qIGF1dG9tYXRpY2FsbHkgdW5sb2NrcyBtdXRleCAqLwogICAgICB9CiAgICAg
IC4uLgogIH0KCmFuZDoKCiAgV0lUSF9RRU1VX01VVEVYX0xPQ0tfR1VBUkQoJm11dGV4KSB7CiAg
ICAgIGlmICghbWF5X2ZhaWwoKSkgewogICAgICAgICAgcmV0dXJuOyAvKiBhdXRvbWF0aWNhbGx5
IHVubG9ja3MgbXV0ZXggKi8KICAgICAgfQogIH0KICAvKiBhdXRvbWF0aWNhbGx5IHVubG9ja3Mg
bXV0ZXggaGVyZSAqLwogIC4uLgoKQ29udmVydCBxZW11LXRpbWVyLmMgZnVuY3Rpb25zIHRoYXQg
YmVuZWZpdCBmcm9tIHRoZXNlIG1hY3JvcyBhcyBhbgpleGFtcGxlLiAgTWFudWFsIHFlbXVfbXV0
ZXhfbG9jay91bmxvY2soKSBjYWxsZXJzIGFyZSBsZWZ0IHVubW9kaWZpZWQgaW4KY2FzZXMgd2hl
cmUgY2xhcml0eSB3b3VsZCBub3QgaW1wcm92ZSBieSBzd2l0Y2hpbmcgdG8gdGhlIG1hY3Jvcy4K
Ck1hbnkgb3RoZXIgUWVtdU11dGV4IHVzZXJzIHJlbWFpbiBpbiB0aGUgY29kZWJhc2UgdGhhdCBt
aWdodCBiZW5lZml0CmZyb20gbG9jayBndWFyZHMuICBPdmVyIHRpbWUgdGhleSBjYW4gYmUgY29u
dmVydGVkLCBpZiB0aGF0IGlzCmRlc2lyYWJsZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpu
b2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL3FlbXUvdGhyZWFkLmggfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKysrKwogdXRpbC9xZW11LXRpbWVyLmMgICAgIHwgMjIg
KysrKysrKysrKy0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvdGhyZWFkLmggYi9p
bmNsdWRlL3FlbXUvdGhyZWFkLmgKaW5kZXggMzk5M2FiN2IyNS4uOGU4MjU0Zjk0ZiAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9xZW11L3RocmVhZC5oCisrKyBiL2luY2x1ZGUvcWVtdS90aHJlYWQuaApA
QCAtMTE5LDYgKzExOSwzMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKHFlbXVfbXV0ZXhfdW5sb2Nr
KShRZW11TXV0ZXggKm11dGV4KQogICAgIHFlbXVfbXV0ZXhfdW5sb2NrKG11dGV4KTsKIH0KIAor
c3RhdGljIGlubGluZSBRZW11TXV0ZXggKnFlbXVfbXV0ZXhfYXV0b19sb2NrKFFlbXVNdXRleCAq
bXV0ZXgpCit7CisgICAgcWVtdV9tdXRleF9sb2NrKG11dGV4KTsKKyAgICByZXR1cm4gbXV0ZXg7
Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBxZW11X211dGV4X2F1dG9fdW5sb2NrKFFlbXVNdXRl
eCAqbXV0ZXgpCit7CisgICAgaWYgKG11dGV4KSB7CisgICAgICAgIHFlbXVfbXV0ZXhfdW5sb2Nr
KG11dGV4KTsKKyAgICB9Cit9CisKK0dfREVGSU5FX0FVVE9QVFJfQ0xFQU5VUF9GVU5DKFFlbXVN
dXRleCwgcWVtdV9tdXRleF9hdXRvX3VubG9jaykKKworI2RlZmluZSBXSVRIX1FFTVVfTVVURVhf
TE9DS19HVUFSRF8obXV0ZXgsIHZhcikgXAorICAgIGZvciAoZ19hdXRvcHRyKFFlbXVNdXRleCkg
dmFyID0gcWVtdV9tdXRleF9hdXRvX2xvY2soKG11dGV4KSk7IFwKKyAgICAgICAgIHZhcjsgcWVt
dV9tdXRleF9hdXRvX3VubG9jayh2YXIpLCB2YXIgPSBOVUxMKQorCisjZGVmaW5lIFdJVEhfUUVN
VV9NVVRFWF9MT0NLX0dVQVJEKG11dGV4KSBcCisgICAgV0lUSF9RRU1VX01VVEVYX0xPQ0tfR1VB
UkRfKG11dGV4LCBxZW11X211dGV4X2F1dG8jI19fQ09VTlRFUl9fKQorCisjZGVmaW5lIFFFTVVf
TVVURVhfTE9DS19HVUFSRChtdXRleCkgXAorICAgIGdfYXV0b3B0cihRZW11TXV0ZXgpIHFlbXVf
bXV0ZXhfYXV0byMjX19DT1VOVEVSX18gPSBcCisgICAgICAgICAgICBxZW11X211dGV4X2F1dG9f
bG9jaygobXV0ZXgpKQorCiBzdGF0aWMgaW5saW5lIHZvaWQgKHFlbXVfcmVjX211dGV4X2xvY2sp
KFFlbXVSZWNNdXRleCAqbXV0ZXgpCiB7CiAgICAgcWVtdV9yZWNfbXV0ZXhfbG9jayhtdXRleCk7
CmRpZmYgLS1naXQgYS91dGlsL3FlbXUtdGltZXIuYyBiL3V0aWwvcWVtdS10aW1lci5jCmluZGV4
IGVmNTJkMjhkMzcuLjRjNDJkMzNjZjUgMTAwNjQ0Ci0tLSBhL3V0aWwvcWVtdS10aW1lci5jCisr
KyBiL3V0aWwvcWVtdS10aW1lci5jCkBAIC0xODYsMTMgKzE4NiwxMiBAQCBib29sIHRpbWVybGlz
dF9leHBpcmVkKFFFTVVUaW1lckxpc3QgKnRpbWVyX2xpc3QpCiAgICAgICAgIHJldHVybiBmYWxz
ZTsKICAgICB9CiAKLSAgICBxZW11X211dGV4X2xvY2soJnRpbWVyX2xpc3QtPmFjdGl2ZV90aW1l
cnNfbG9jayk7Ci0gICAgaWYgKCF0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzKSB7Ci0gICAgICAg
IHFlbXVfbXV0ZXhfdW5sb2NrKCZ0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzX2xvY2spOwotICAg
ICAgICByZXR1cm4gZmFsc2U7CisgICAgV0lUSF9RRU1VX01VVEVYX0xPQ0tfR1VBUkQoJnRpbWVy
X2xpc3QtPmFjdGl2ZV90aW1lcnNfbG9jaykgeworICAgICAgICBpZiAoIXRpbWVyX2xpc3QtPmFj
dGl2ZV90aW1lcnMpIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICAgICAgfQorICAg
ICAgICBleHBpcmVfdGltZSA9IHRpbWVyX2xpc3QtPmFjdGl2ZV90aW1lcnMtPmV4cGlyZV90aW1l
OwogICAgIH0KLSAgICBleHBpcmVfdGltZSA9IHRpbWVyX2xpc3QtPmFjdGl2ZV90aW1lcnMtPmV4
cGlyZV90aW1lOwotICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZ0aW1lcl9saXN0LT5hY3RpdmVfdGlt
ZXJzX2xvY2spOwogCiAgICAgcmV0dXJuIGV4cGlyZV90aW1lIDw9IHFlbXVfY2xvY2tfZ2V0X25z
KHRpbWVyX2xpc3QtPmNsb2NrLT50eXBlKTsKIH0KQEAgLTIyNSwxMyArMjI0LDEyIEBAIGludDY0
X3QgdGltZXJsaXN0X2RlYWRsaW5lX25zKFFFTVVUaW1lckxpc3QgKnRpbWVyX2xpc3QpCiAgICAg
ICogdmFsdWUgYnV0IC0+bm90aWZ5X2NiKCkgaXMgY2FsbGVkIHdoZW4gdGhlIGRlYWRsaW5lIGNo
YW5nZXMuICBUaGVyZWZvcmUKICAgICAgKiB0aGUgY2FsbGVyIHNob3VsZCBub3RpY2UgdGhlIGNo
YW5nZSBhbmQgdGhlcmUgaXMgbm8gcmFjZSBjb25kaXRpb24uCiAgICAgICovCi0gICAgcWVtdV9t
dXRleF9sb2NrKCZ0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzX2xvY2spOwotICAgIGlmICghdGlt
ZXJfbGlzdC0+YWN0aXZlX3RpbWVycykgewotICAgICAgICBxZW11X211dGV4X3VubG9jaygmdGlt
ZXJfbGlzdC0+YWN0aXZlX3RpbWVyc19sb2NrKTsKLSAgICAgICAgcmV0dXJuIC0xOworICAgIFdJ
VEhfUUVNVV9NVVRFWF9MT0NLX0dVQVJEKCZ0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzX2xvY2sp
IHsKKyAgICAgICAgaWYgKCF0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzKSB7CisgICAgICAgICAg
ICByZXR1cm4gLTE7CisgICAgICAgIH0KKyAgICAgICAgZXhwaXJlX3RpbWUgPSB0aW1lcl9saXN0
LT5hY3RpdmVfdGltZXJzLT5leHBpcmVfdGltZTsKICAgICB9Ci0gICAgZXhwaXJlX3RpbWUgPSB0
aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzLT5leHBpcmVfdGltZTsKLSAgICBxZW11X211dGV4X3Vu
bG9jaygmdGltZXJfbGlzdC0+YWN0aXZlX3RpbWVyc19sb2NrKTsKIAogICAgIGRlbHRhID0gZXhw
aXJlX3RpbWUgLSBxZW11X2Nsb2NrX2dldF9ucyh0aW1lcl9saXN0LT5jbG9jay0+dHlwZSk7CiAK
LS0gCjIuMjQuMQoK


