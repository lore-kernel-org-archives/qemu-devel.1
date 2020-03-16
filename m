Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26954C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C3D20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws3/mY/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C3D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnuN-0000Px-TL
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jDndy-0002q0-6b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jDndw-0004lt-Mm
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:10:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jDndw-0004iq-Gy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584357048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jcU/HCwQAmCeBKP7ipq7laiBGMA1+e7a1zl9eXhO+4=;
 b=Ws3/mY/v8iRWqOe9Y4l6TcL29PRb5IcQaufxbsI+10ovTtdfyCiv/MALwcybEef7cy3NO3
 1rVlGwhGBHfriS3of2VVUU3acj9+pJf6uoXPfq1+otyJQMnwisL2GQ2kn5ijHb1GzWD/oh
 WdOUvtYrxzy7/p6RjQCZWw3pHA3Khv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-Cdc2hFlXOZCg45S3M_k8Uw-1; Mon, 16 Mar 2020 07:10:46 -0400
X-MC-Unique: Cdc2hFlXOZCg45S3M_k8Uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD4D6101FC6A;
 Mon, 16 Mar 2020 11:10:45 +0000 (UTC)
Received: from localhost (unknown [10.36.119.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA5E71036B54;
 Mon, 16 Mar 2020 11:10:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] lockable: add lock guards
Date: Mon, 16 Mar 2020 11:09:56 +0000
Message-Id: <20200316110957.449700-2-stefanha@redhat.com>
In-Reply-To: <20200316110957.449700-1-stefanha@redhat.com>
References: <20200316110957.449700-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHR3byBsb2NrIGd1YXJkIG1hY3JvcyB0aGF0IGF1dG9tYXRp
Y2FsbHkgdW5sb2NrIGEKbG9jayBvYmplY3QgKFFlbXVNdXRleCBhbmQgb3RoZXJzKToKCiAgdm9p
ZCBmKHZvaWQpIHsKICAgICAgUUVNVV9MT0NLX0dVQVJEKCZtdXRleCk7CiAgICAgIGlmICghbWF5
X2ZhaWwoKSkgewogICAgICAgICAgcmV0dXJuOyAvKiBhdXRvbWF0aWNhbGx5IHVubG9ja3MgbXV0
ZXggKi8KICAgICAgfQogICAgICAuLi4KICB9CgphbmQ6CgogIFdJVEhfUUVNVV9MT0NLX0dVQVJE
KCZtdXRleCkgewogICAgICBpZiAoIW1heV9mYWlsKCkpIHsKICAgICAgICAgIHJldHVybjsgLyog
YXV0b21hdGljYWxseSB1bmxvY2tzIG11dGV4ICovCiAgICAgIH0KICB9CiAgLyogYXV0b21hdGlj
YWxseSB1bmxvY2tzIG11dGV4IGhlcmUgKi8KICAuLi4KCkNvbnZlcnQgcWVtdS10aW1lci5jIGZ1
bmN0aW9ucyB0aGF0IGJlbmVmaXQgZnJvbSB0aGVzZSBtYWNyb3MgYXMgYW4KZXhhbXBsZS4gIE1h
bnVhbCBxZW11X211dGV4X2xvY2svdW5sb2NrKCkgY2FsbGVycyBhcmUgbGVmdCB1bm1vZGlmaWVk
IGluCmNhc2VzIHdoZXJlIGNsYXJpdHkgd291bGQgbm90IGltcHJvdmUgYnkgc3dpdGNoaW5nIHRv
IHRoZSBtYWNyb3MuCgpNYW55IG90aGVyIFFlbXVNdXRleCB1c2VycyByZW1haW4gaW4gdGhlIGNv
ZGViYXNlIHRoYXQgbWlnaHQgYmVuZWZpdApmcm9tIGxvY2sgZ3VhcmRzLiAgT3ZlciB0aW1lIHRo
ZXkgY2FuIGJlIGNvbnZlcnRlZCwgaWYgdGhhdCBpcwpkZXNpcmFibGUuCgpTaWduZWQtb2ZmLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9xZW11
L2xvY2thYmxlLmggfCA2NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KwogdXRpbC9xZW11LXRpbWVyLmMgICAgICAgfCAyMyArKysrKysrLS0tLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9xZW11L2xvY2thYmxlLmggYi9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaAppbmRleCA4
NGVhNzk0YmNmLi4yYjUyYzdjMWU1IDEwMDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvbG9ja2FibGUu
aAorKysgYi9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaApAQCAtOTMsNCArOTMsNjkgQEAgc3RhdGlj
IGlubGluZSB2b2lkIHFlbXVfbG9ja2FibGVfdW5sb2NrKFFlbXVMb2NrYWJsZSAqeCkKICAgICB4
LT51bmxvY2soeC0+b2JqZWN0KTsKIH0KIAorc3RhdGljIGlubGluZSBRZW11TG9ja2FibGUgKnFl
bXVfbG9ja2FibGVfYXV0b19sb2NrKFFlbXVMb2NrYWJsZSAqeCkKK3sKKyAgICBxZW11X2xvY2th
YmxlX2xvY2soeCk7CisgICAgcmV0dXJuIHg7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBxZW11
X2xvY2thYmxlX2F1dG9fdW5sb2NrKFFlbXVMb2NrYWJsZSAqeCkKK3sKKyAgICBpZiAoeCkgewor
ICAgICAgICBxZW11X2xvY2thYmxlX3VubG9jayh4KTsKKyAgICB9Cit9CisKK0dfREVGSU5FX0FV
VE9QVFJfQ0xFQU5VUF9GVU5DKFFlbXVMb2NrYWJsZSwgcWVtdV9sb2NrYWJsZV9hdXRvX3VubG9j
aykKKworI2RlZmluZSBXSVRIX1FFTVVfTE9DS19HVUFSRF8oeCwgdmFyKSBcCisgICAgZm9yIChn
X2F1dG9wdHIoUWVtdUxvY2thYmxlKSB2YXIgPSBcCisgICAgICAgICAgICAgICAgcWVtdV9sb2Nr
YWJsZV9hdXRvX2xvY2soUUVNVV9NQUtFX0xPQ0tBQkxFKCh4KSkpOyBcCisgICAgICAgICB2YXI7
IFwKKyAgICAgICAgIHFlbXVfbG9ja2FibGVfYXV0b191bmxvY2sodmFyKSwgdmFyID0gTlVMTCkK
KworLyoqCisgKiBXSVRIX1FFTVVfTE9DS19HVUFSRCAtIExvY2sgYSBsb2NrIG9iamVjdCBmb3Ig
c2NvcGUKKyAqCisgKiBAeDogYSBsb2NrIG9iamVjdCAoY3VycmVudGx5IG9uZSBvZiBRZW11TXV0
ZXgsIENvTXV0ZXgsIFFlbXVTcGluKS4KKyAqCisgKiBUaGlzIG1hY3JvIGRlZmluZXMgYSBsb2Nr
IHNjb3BlIHN1Y2ggdGhhdCBlbnRlcmluZyB0aGUgc2NvcGUgdGFrZXMgdGhlIGxvY2sKKyAqIGFu
ZCBsZWF2aW5nIHRoZSBzY29wZSByZWxlYXNlcyB0aGUgbG9jay4gIFJldHVybiBzdGF0ZW1lbnRz
IGFyZSBhbGxvd2VkCisgKiB3aXRoaW4gdGhlIHNjb3BlIGFuZCByZWxlYXNlIHRoZSBsb2NrLiAg
QnJlYWsgYW5kIGNvbnRpbnVlIHN0YXRlbWVudHMgbGVhdmUKKyAqIHRoZSBzY29wZSBlYXJseSBh
bmQgcmVsZWFzZSB0aGUgbG9jay4KKyAqCisgKiAgIFdJVEhfUUVNVV9MT0NLX0dVQVJEKCZtdXRl
eCkgeworICogICAgICAgLi4uCisgKiAgICAgICBpZiAoZXJyb3IpIHsKKyAqICAgICAgICAgICBy
ZXR1cm47IDwtLSBtdXRleCBpcyBhdXRvbWF0aWNhbGx5IHVubG9ja2VkCisgKiAgICAgICB9Cisg
KgorICogICAgICAgaWYgKGVhcmx5X2V4aXQpIHsKKyAqICAgICAgICAgICBicmVhazsgIDwtLSBs
ZWF2ZSB0aGlzIHNjb3BlIGVhcmx5CisgKiAgICAgICB9CisgKiAgICAgICAuLi4KKyAqICAgfQor
ICovCisjZGVmaW5lIFdJVEhfUUVNVV9MT0NLX0dVQVJEKHgpIFwKKyAgICBXSVRIX1FFTVVfTE9D
S19HVUFSRF8oKHgpLCBxZW11X2xvY2thYmxlX2F1dG8jI19fQ09VTlRFUl9fKQorCisvKioKKyAq
IFFFTVVfTE9DS19HVUFSRCAtIExvY2sgYW4gb2JqZWN0IHVudGlsIHRoZSBlbmQgb2YgdGhlIHNj
b3BlCisgKgorICogQHg6IGEgbG9jayBvYmplY3QgKGN1cnJlbnRseSBvbmUgb2YgUWVtdU11dGV4
LCBDb011dGV4LCBRZW11U3BpbikuCisgKgorICogVGhpcyBtYWNybyB0YWtlcyBhIGxvY2sgdW50
aWwgdGhlIGVuZCBvZiB0aGUgc2NvcGUuICBSZXR1cm4gc3RhdGVtZW50cworICogcmVsZWFzZSB0
aGUgbG9jay4KKyAqCisgKiAgIC4uLiA8LS0gbXV0ZXggbm90IGxvY2tlZAorICogICBRRU1VX0xP
Q0tfR1VBUkQoJm11dGV4KTsgPC0tIG11dGV4IGxvY2tlZCBmcm9tIGhlcmUgb253YXJkcworICog
ICAuLi4KKyAqICAgaWYgKGVycm9yKSB7CisgKiAgICAgICByZXR1cm47IDwtLSBtdXRleCBpcyBh
dXRvbWF0aWNhbGx5IHVubG9ja2VkCisgKiAgIH0KKyAqLworI2RlZmluZSBRRU1VX0xPQ0tfR1VB
UkQoeCkgXAorICAgIGdfYXV0b3B0cihRZW11TG9ja2FibGUpIHFlbXVfbG9ja2FibGVfYXV0byMj
X19DT1VOVEVSX18gPSBcCisgICAgICAgICAgICBxZW11X2xvY2thYmxlX2F1dG9fbG9jayhRRU1V
X01BS0VfTE9DS0FCTEUoKHgpKSkKKwogI2VuZGlmCmRpZmYgLS1naXQgYS91dGlsL3FlbXUtdGlt
ZXIuYyBiL3V0aWwvcWVtdS10aW1lci5jCmluZGV4IGVmNTJkMjhkMzcuLmQ1NDhkM2MxYWQgMTAw
NjQ0Ci0tLSBhL3V0aWwvcWVtdS10aW1lci5jCisrKyBiL3V0aWwvcWVtdS10aW1lci5jCkBAIC0y
NSw2ICsyNSw3IEBACiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgogI2luY2x1ZGUgInFlbXUvbWFp
bi1sb29wLmgiCiAjaW5jbHVkZSAicWVtdS90aW1lci5oIgorI2luY2x1ZGUgInFlbXUvbG9ja2Fi
bGUuaCIKICNpbmNsdWRlICJzeXNlbXUvcmVwbGF5LmgiCiAjaW5jbHVkZSAic3lzZW11L2NwdXMu
aCIKIApAQCAtMTg2LDEzICsxODcsMTIgQEAgYm9vbCB0aW1lcmxpc3RfZXhwaXJlZChRRU1VVGlt
ZXJMaXN0ICp0aW1lcl9saXN0KQogICAgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQogCi0gICAg
cWVtdV9tdXRleF9sb2NrKCZ0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzX2xvY2spOwotICAgIGlm
ICghdGltZXJfbGlzdC0+YWN0aXZlX3RpbWVycykgewotICAgICAgICBxZW11X211dGV4X3VubG9j
aygmdGltZXJfbGlzdC0+YWN0aXZlX3RpbWVyc19sb2NrKTsKLSAgICAgICAgcmV0dXJuIGZhbHNl
OworICAgIFdJVEhfUUVNVV9MT0NLX0dVQVJEKCZ0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzX2xv
Y2spIHsKKyAgICAgICAgaWYgKCF0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzKSB7CisgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgIH0KKyAgICAgICAgZXhwaXJlX3RpbWUgPSB0aW1l
cl9saXN0LT5hY3RpdmVfdGltZXJzLT5leHBpcmVfdGltZTsKICAgICB9Ci0gICAgZXhwaXJlX3Rp
bWUgPSB0aW1lcl9saXN0LT5hY3RpdmVfdGltZXJzLT5leHBpcmVfdGltZTsKLSAgICBxZW11X211
dGV4X3VubG9jaygmdGltZXJfbGlzdC0+YWN0aXZlX3RpbWVyc19sb2NrKTsKIAogICAgIHJldHVy
biBleHBpcmVfdGltZSA8PSBxZW11X2Nsb2NrX2dldF9ucyh0aW1lcl9saXN0LT5jbG9jay0+dHlw
ZSk7CiB9CkBAIC0yMjUsMTMgKzIyNSwxMiBAQCBpbnQ2NF90IHRpbWVybGlzdF9kZWFkbGluZV9u
cyhRRU1VVGltZXJMaXN0ICp0aW1lcl9saXN0KQogICAgICAqIHZhbHVlIGJ1dCAtPm5vdGlmeV9j
YigpIGlzIGNhbGxlZCB3aGVuIHRoZSBkZWFkbGluZSBjaGFuZ2VzLiAgVGhlcmVmb3JlCiAgICAg
ICogdGhlIGNhbGxlciBzaG91bGQgbm90aWNlIHRoZSBjaGFuZ2UgYW5kIHRoZXJlIGlzIG5vIHJh
Y2UgY29uZGl0aW9uLgogICAgICAqLwotICAgIHFlbXVfbXV0ZXhfbG9jaygmdGltZXJfbGlzdC0+
YWN0aXZlX3RpbWVyc19sb2NrKTsKLSAgICBpZiAoIXRpbWVyX2xpc3QtPmFjdGl2ZV90aW1lcnMp
IHsKLSAgICAgICAgcWVtdV9tdXRleF91bmxvY2soJnRpbWVyX2xpc3QtPmFjdGl2ZV90aW1lcnNf
bG9jayk7Ci0gICAgICAgIHJldHVybiAtMTsKKyAgICBXSVRIX1FFTVVfTE9DS19HVUFSRCgmdGlt
ZXJfbGlzdC0+YWN0aXZlX3RpbWVyc19sb2NrKSB7CisgICAgICAgIGlmICghdGltZXJfbGlzdC0+
YWN0aXZlX3RpbWVycykgeworICAgICAgICAgICAgcmV0dXJuIC0xOworICAgICAgICB9CisgICAg
ICAgIGV4cGlyZV90aW1lID0gdGltZXJfbGlzdC0+YWN0aXZlX3RpbWVycy0+ZXhwaXJlX3RpbWU7
CiAgICAgfQotICAgIGV4cGlyZV90aW1lID0gdGltZXJfbGlzdC0+YWN0aXZlX3RpbWVycy0+ZXhw
aXJlX3RpbWU7Ci0gICAgcWVtdV9tdXRleF91bmxvY2soJnRpbWVyX2xpc3QtPmFjdGl2ZV90aW1l
cnNfbG9jayk7CiAKICAgICBkZWx0YSA9IGV4cGlyZV90aW1lIC0gcWVtdV9jbG9ja19nZXRfbnMo
dGltZXJfbGlzdC0+Y2xvY2stPnR5cGUpOwogCi0tIAoyLjI0LjEKCg==


