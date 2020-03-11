Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0793C18E5A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC54208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJOVDRJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC54208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0gW-00083w-MZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0fW-0006L7-TV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0fV-0000Bk-JA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45357
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0fV-0000BI-G3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjIHP9UFruVDoydfZu86iPJdLD2gZX7JnMJoEBOXlN0=;
 b=BJOVDRJ9E5XPunYQGnRRkMgRJVk6AF8mdhYKX2mdqJuMggpfTQ9z2/DVXEep3SmSEt8X37
 nsAGBaCfky0xW+NBUkjTmMUm3o8E+Q8/Aw3ctGhurX2kN/y7ekUSkKLaDDDFb4ZDwL6VEC
 LahqQxUggy1fnPTmKlx3IEUIiq7XG3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-B3WmZbWvPfmaMptAT9VXFQ-1; Wed, 11 Mar 2020 08:40:56 -0400
X-MC-Unique: B3WmZbWvPfmaMptAT9VXFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD451477;
 Wed, 11 Mar 2020 12:40:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93571907F7;
 Wed, 11 Mar 2020 12:40:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] qemu/queue.h: clear linked list pointers on remove
Date: Wed, 11 Mar 2020 12:40:37 +0000
Message-Id: <20200311124045.277969-2-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
References: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG8gbm90IGxlYXZlIHN0YWxlIGxpbmtlZCBsaXN0IHBvaW50ZXJzIGFyb3VuZCBhZnRlciByZW1v
dmFsLiAgSXQncwpzYWZlciB0byBzZXQgdGhlbSB0byBOVUxMIHNvIHRoYXQgdXNlLWFmdGVyLXJl
bW92YWwgcmVzdWx0cyBpbiBhbgppbW1lZGlhdGUgc2VnZmF1bHQuCgpUaGUgUkNVIHF1ZXVlIHJl
bW92YWwgbWFjcm9zIGFyZSB1bmNoYW5nZWQgc2luY2Ugbm9kZXMgbWF5IHN0aWxsIGJlCnRyYXZl
cnNlZCBhZnRlciByZW1vdmFsLgoKU3VnZ2VzdGVkLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMDAyMjQxMDM0MDYu
MTg5NDkyMy0yLXN0ZWZhbmhhQHJlZGhhdC5jb20KTWVzc2FnZS1JZDogPDIwMjAwMjI0MTAzNDA2
LjE4OTQ5MjMtMi1zdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvcWVtdS9xdWV1ZS5o
IHwgMTkgKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3F1ZXVlLmggYi9p
bmNsdWRlL3FlbXUvcXVldWUuaAppbmRleCAyOTRkYjU0ZWIxLi40NTZhNWIwMWVlIDEwMDY0NAot
LS0gYS9pbmNsdWRlL3FlbXUvcXVldWUuaAorKysgYi9pbmNsdWRlL3FlbXUvcXVldWUuaApAQCAt
MTQyLDYgKzE0Miw4IEBAIHN0cnVjdCB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAoZWxtKS0+
ZmllbGQubGVfbmV4dC0+ZmllbGQubGVfcHJldiA9ICAgICAgICAgICAgICAgICAgIFwKICAgICAg
ICAgICAgICAgICAgICAgKGVsbSktPmZpZWxkLmxlX3ByZXY7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKICAgICAgICAgKihlbG0pLT5maWVsZC5sZV9wcmV2ID0gKGVsbSktPmZpZWxk
LmxlX25leHQ7ICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgKGVsbSktPmZpZWxkLmxlX25l
eHQgPSBOVUxMOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAg
KGVsbSktPmZpZWxkLmxlX3ByZXYgPSBOVUxMOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKIH0gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQogCiAvKgpAQCAtMjI1LDEyICsyMjcs
MTUgQEAgc3RydWN0IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAogfSB3aGlsZSAoLypDT05TVENPTkQqLzApCiAKICNkZWZp
bmUgUVNMSVNUX1JFTU9WRV9IRUFEKGhlYWQsIGZpZWxkKSBkbyB7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCi0gICAgICAgIChoZWFkKS0+c2xoX2ZpcnN0ID0gKGhlYWQpLT5zbGhfZmly
c3QtPmZpZWxkLnNsZV9uZXh0OyAgICAgICAgICBcCisgICAgICAgIHR5cGVvZigoaGVhZCktPnNs
aF9maXJzdCkgZWxtID0gKGhlYWQpLT5zbGhfZmlyc3Q7ICAgICAgICAgICAgICAgXAorICAgICAg
ICAoaGVhZCktPnNsaF9maXJzdCA9IGVsbS0+ZmllbGQuc2xlX25leHQ7ICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKKyAgICAgICAgZWxtLT5maWVsZC5zbGVfbmV4dCA9IE5VTEw7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiB9IHdoaWxlICgvKkNPTlNUQ09ORCovMCkK
IAogI2RlZmluZSBRU0xJU1RfUkVNT1ZFX0FGVEVSKHNsaXN0ZWxtLCBmaWVsZCkgZG8geyAgICAg
ICAgICAgICAgICAgICAgICAgXAotICAgICAgICAoc2xpc3RlbG0pLT5maWVsZC5zbGVfbmV4dCA9
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAotICAgICAgICAgICAgUVNMSVNU
X05FWFQoUVNMSVNUX05FWFQoKHNsaXN0ZWxtKSwgZmllbGQpLCBmaWVsZCk7ICAgICAgICAgXAor
ICAgICAgICB0eXBlb2Yoc2xpc3RlbG0pIG5leHQgPSAoc2xpc3RlbG0pLT5maWVsZC5zbGVfbmV4
dDsgICAgICAgICAgICAgXAorICAgICAgICAoc2xpc3RlbG0pLT5maWVsZC5zbGVfbmV4dCA9IG5l
eHQtPmZpZWxkLnNsZV9uZXh0OyAgICAgICAgICAgICAgXAorICAgICAgICBuZXh0LT5maWVsZC5z
bGVfbmV4dCA9IE5VTEw7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogfSB3
aGlsZSAoLypDT05TVENPTkQqLzApCiAKICNkZWZpbmUgUVNMSVNUX1JFTU9WRShoZWFkLCBlbG0s
IHR5cGUsIGZpZWxkKSBkbyB7ICAgICAgICAgICAgICAgICAgICAgIFwKQEAgLTI0MSw2ICsyNDYs
NyBAQCBzdHJ1Y3QgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgIHdoaWxlIChjdXJlbG0tPmZpZWxkLnNsZV9u
ZXh0ICE9IChlbG0pKSAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICBjdXJl
bG0gPSBjdXJlbG0tPmZpZWxkLnNsZV9uZXh0OyAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
CiAgICAgICAgIGN1cmVsbS0+ZmllbGQuc2xlX25leHQgPSBjdXJlbG0tPmZpZWxkLnNsZV9uZXh0
LT5maWVsZC5zbGVfbmV4dDsgXAorICAgICAgICAoZWxtKS0+ZmllbGQuc2xlX25leHQgPSBOVUxM
OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgIH0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAog
fSB3aGlsZSAoLypDT05TVENPTkQqLzApCiAKQEAgLTMwNCw4ICszMTAsMTAgQEAgc3RydWN0IHsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXAogfSB3aGlsZSAoLypDT05TVENPTkQqLzApCiAKICNkZWZpbmUgUVNJTVBMRVFfUkVN
T1ZFX0hFQUQoaGVhZCwgZmllbGQpIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLSAg
ICBpZiAoKChoZWFkKS0+c3FoX2ZpcnN0ID0gKGhlYWQpLT5zcWhfZmlyc3QtPmZpZWxkLnNxZV9u
ZXh0KSA9PSBOVUxMKVwKKyAgICB0eXBlb2YoKGhlYWQpLT5zcWhfZmlyc3QpIGVsbSA9IChoZWFk
KS0+c3FoX2ZpcnN0OyAgICAgICAgICAgICAgICAgIFwKKyAgICBpZiAoKChoZWFkKS0+c3FoX2Zp
cnN0ID0gZWxtLT5maWVsZC5zcWVfbmV4dCkgPT0gTlVMTCkgICAgICAgICAgICAgIFwKICAgICAg
ICAgKGhlYWQpLT5zcWhfbGFzdCA9ICYoaGVhZCktPnNxaF9maXJzdDsgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKKyAgICBlbG0tPmZpZWxkLnNxZV9uZXh0ID0gTlVMTDsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKIH0gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQog
CiAjZGVmaW5lIFFTSU1QTEVRX1NQTElUX0FGVEVSKGhlYWQsIGVsbSwgZmllbGQsIHJlbW92ZWQp
IGRvIHsgICAgICAgICAgICBcCkBAIC0zMjksNiArMzM3LDcgQEAgc3RydWN0IHsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAog
ICAgICAgICBpZiAoKGN1cmVsbS0+ZmllbGQuc3FlX25leHQgPSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXAogICAgICAgICAgICAgY3VyZWxtLT5maWVsZC5zcWVfbmV4dC0+Zmll
bGQuc3FlX25leHQpID09IE5VTEwpICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgIChoZWFk
KS0+c3FoX2xhc3QgPSAmKGN1cmVsbSktPmZpZWxkLnNxZV9uZXh0OyAgICAgICAgICAgXAorICAg
ICAgICAoZWxtKS0+ZmllbGQuc3FlX25leHQgPSBOVUxMOyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAogICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogfSB3aGlsZSAoLypDT05TVENPTkQqLzAp
CiAKQEAgLTQ0Niw2ICs0NTUsOCBAQCB1bmlvbiB7ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAoaGVh
ZCktPnRxaF9jaXJjLnRxbF9wcmV2ID0gKGVsbSktPmZpZWxkLnRxZV9jaXJjLnRxbF9wcmV2OyBc
CiAgICAgICAgIChlbG0pLT5maWVsZC50cWVfY2lyYy50cWxfcHJldi0+dHFsX25leHQgPSAoZWxt
KS0+ZmllbGQudHFlX25leHQ7IFwKICAgICAgICAgKGVsbSktPmZpZWxkLnRxZV9jaXJjLnRxbF9w
cmV2ID0gTlVMTDsgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAgICAgKGVsbSktPmZp
ZWxkLnRxZV9jaXJjLnRxbF9uZXh0ID0gTlVMTDsgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
KyAgICAgICAgKGVsbSktPmZpZWxkLnRxZV9uZXh0ID0gTlVMTDsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKIH0gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQogCiAvKiByZW1vdmUg
QGxlZnQsIEByaWdodCBhbmQgYWxsIGVsZW1lbnRzIGluIGJldHdlZW4gZnJvbSBAaGVhZCAqLwot
LSAKMi4yNC4xCgo=


