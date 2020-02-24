Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0774C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06FA20828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwYpSGHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06FA20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6B4q-0001PO-NR
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j6B4A-0000O1-5t
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j6B48-0007l0-V9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j6B48-0007kl-Ri
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582540460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DuJZhufpf0aFOVc/6GZove5MAyebHMgmt+bclbTTvM=;
 b=KwYpSGHgeMOi0DCyQdRfqt1232ZLa1XNc9C6TgUTlGlBZlQAS8JpMnXa+QgGPoDqhV8pdr
 utxm3XCmu+4Ka4s0Tkp+mC2mJhQx7r243RqSufixq11Ya40mJZHT+6LK812ODXiYc22wwP
 ayM1O0274Yx52nHkfwjmZImQAAmlFek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-KJx8PHpxNPWNMHVN8cecqg-1; Mon, 24 Feb 2020 05:34:16 -0500
X-MC-Unique: KJx8PHpxNPWNMHVN8cecqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4934800D5A;
 Mon, 24 Feb 2020 10:34:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9552A27081;
 Mon, 24 Feb 2020 10:34:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qemu/queue.h: clear linked list pointers on remove
Date: Mon, 24 Feb 2020 10:34:05 +0000
Message-Id: <20200224103406.1894923-2-stefanha@redhat.com>
In-Reply-To: <20200224103406.1894923-1-stefanha@redhat.com>
References: <20200224103406.1894923-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG8gbm90IGxlYXZlIHN0YWxlIGxpbmtlZCBsaXN0IHBvaW50ZXJzIGFyb3VuZCBhZnRlciByZW1v
dmFsLiAgSXQncwpzYWZlciB0byBzZXQgdGhlbSB0byBOVUxMIHNvIHRoYXQgdXNlLWFmdGVyLXJl
bW92YWwgcmVzdWx0cyBpbiBhbgppbW1lZGlhdGUgc2VnZmF1bHQuCgpUaGUgUkNVIHF1ZXVlIHJl
bW92YWwgbWFjcm9zIGFyZSB1bmNoYW5nZWQgc2luY2Ugbm9kZXMgbWF5IHN0aWxsIGJlCnRyYXZl
cnNlZCBhZnRlciByZW1vdmFsLgoKU3VnZ2VzdGVkLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemlu
aUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9xZW11L3F1ZXVlLmggfCAxOSArKysrKysrKysrKysrKyst
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvcXVldWUuaCBiL2luY2x1ZGUvcWVtdS9xdWV1ZS5oCmlu
ZGV4IDI5NGRiNTRlYjEuLjQ1NmE1YjAxZWUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvcWVtdS9xdWV1
ZS5oCisrKyBiL2luY2x1ZGUvcWVtdS9xdWV1ZS5oCkBAIC0xNDIsNiArMTQyLDggQEAgc3RydWN0
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXAogICAgICAgICAgICAgICAgIChlbG0pLT5maWVsZC5sZV9uZXh0LT5maWVsZC5s
ZV9wcmV2ID0gICAgICAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAoZWxtKS0+
ZmllbGQubGVfcHJldjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgICAq
KGVsbSktPmZpZWxkLmxlX3ByZXYgPSAoZWxtKS0+ZmllbGQubGVfbmV4dDsgICAgICAgICAgICAg
ICAgICAgXAorICAgICAgICAoZWxtKS0+ZmllbGQubGVfbmV4dCA9IE5VTEw7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICAoZWxtKS0+ZmllbGQubGVfcHJldiA9
IE5VTEw7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogfSB3aGlsZSAoLypD
T05TVENPTkQqLzApCiAKIC8qCkBAIC0yMjUsMTIgKzIyNywxNSBAQCBzdHJ1Y3QgeyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
CiB9IHdoaWxlICgvKkNPTlNUQ09ORCovMCkKIAogI2RlZmluZSBRU0xJU1RfUkVNT1ZFX0hFQUQo
aGVhZCwgZmllbGQpIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKLSAgICAgICAg
KGhlYWQpLT5zbGhfZmlyc3QgPSAoaGVhZCktPnNsaF9maXJzdC0+ZmllbGQuc2xlX25leHQ7ICAg
ICAgICAgIFwKKyAgICAgICAgdHlwZW9mKChoZWFkKS0+c2xoX2ZpcnN0KSBlbG0gPSAoaGVhZCkt
PnNsaF9maXJzdDsgICAgICAgICAgICAgICBcCisgICAgICAgIChoZWFkKS0+c2xoX2ZpcnN0ID0g
ZWxtLT5maWVsZC5zbGVfbmV4dDsgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICBl
bG0tPmZpZWxkLnNsZV9uZXh0ID0gTlVMTDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKIH0gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQogCiAjZGVmaW5lIFFTTElTVF9SRU1P
VkVfQUZURVIoc2xpc3RlbG0sIGZpZWxkKSBkbyB7ICAgICAgICAgICAgICAgICAgICAgICBcCi0g
ICAgICAgIChzbGlzdGVsbSktPmZpZWxkLnNsZV9uZXh0ID0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCi0gICAgICAgICAgICBRU0xJU1RfTkVYVChRU0xJU1RfTkVYVCgoc2xp
c3RlbG0pLCBmaWVsZCksIGZpZWxkKTsgICAgICAgICBcCisgICAgICAgIHR5cGVvZihzbGlzdGVs
bSkgbmV4dCA9IChzbGlzdGVsbSktPmZpZWxkLnNsZV9uZXh0OyAgICAgICAgICAgICBcCisgICAg
ICAgIChzbGlzdGVsbSktPmZpZWxkLnNsZV9uZXh0ID0gbmV4dC0+ZmllbGQuc2xlX25leHQ7ICAg
ICAgICAgICAgICBcCisgICAgICAgIG5leHQtPmZpZWxkLnNsZV9uZXh0ID0gTlVMTDsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiB9IHdoaWxlICgvKkNPTlNUQ09ORCovMCkK
IAogI2RlZmluZSBRU0xJU1RfUkVNT1ZFKGhlYWQsIGVsbSwgdHlwZSwgZmllbGQpIGRvIHsgICAg
ICAgICAgICAgICAgICAgICAgXApAQCAtMjQxLDYgKzI0Niw3IEBAIHN0cnVjdCB7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
ICAgICAgICAgd2hpbGUgKGN1cmVsbS0+ZmllbGQuc2xlX25leHQgIT0gKGVsbSkpICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgIGN1cmVsbSA9IGN1cmVsbS0+ZmllbGQuc2xl
X25leHQ7ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgY3VyZWxtLT5maWVs
ZC5zbGVfbmV4dCA9IGN1cmVsbS0+ZmllbGQuc2xlX25leHQtPmZpZWxkLnNsZV9uZXh0OyBcCisg
ICAgICAgIChlbG0pLT5maWVsZC5zbGVfbmV4dCA9IE5VTEw7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCiAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiB9IHdoaWxlICgvKkNPTlNUQ09ORCov
MCkKIApAQCAtMzA0LDggKzMxMCwxMCBAQCBzdHJ1Y3QgeyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiB9IHdoaWxlICgvKkNP
TlNUQ09ORCovMCkKIAogI2RlZmluZSBRU0lNUExFUV9SRU1PVkVfSEVBRChoZWFkLCBmaWVsZCkg
ZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgXAotICAgIGlmICgoKGhlYWQpLT5zcWhfZmly
c3QgPSAoaGVhZCktPnNxaF9maXJzdC0+ZmllbGQuc3FlX25leHQpID09IE5VTEwpXAorICAgIHR5
cGVvZigoaGVhZCktPnNxaF9maXJzdCkgZWxtID0gKGhlYWQpLT5zcWhfZmlyc3Q7ICAgICAgICAg
ICAgICAgICAgXAorICAgIGlmICgoKGhlYWQpLT5zcWhfZmlyc3QgPSBlbG0tPmZpZWxkLnNxZV9u
ZXh0KSA9PSBOVUxMKSAgICAgICAgICAgICAgXAogICAgICAgICAoaGVhZCktPnNxaF9sYXN0ID0g
JihoZWFkKS0+c3FoX2ZpcnN0OyAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgIGVsbS0+
ZmllbGQuc3FlX25leHQgPSBOVUxMOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXAogfSB3aGlsZSAoLypDT05TVENPTkQqLzApCiAKICNkZWZpbmUgUVNJTVBMRVFfU1BM
SVRfQUZURVIoaGVhZCwgZWxtLCBmaWVsZCwgcmVtb3ZlZCkgZG8geyAgICAgICAgICAgIFwKQEAg
LTMyOSw2ICszMzcsNyBAQCBzdHJ1Y3QgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAgIGlmICgoY3VyZWxtLT5m
aWVsZC5zcWVfbmV4dCA9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAg
ICAgICAgICBjdXJlbG0tPmZpZWxkLnNxZV9uZXh0LT5maWVsZC5zcWVfbmV4dCkgPT0gTlVMTCkg
ICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgKGhlYWQpLT5zcWhfbGFzdCA9ICYoY3VyZWxt
KS0+ZmllbGQuc3FlX25leHQ7ICAgICAgICAgICBcCisgICAgICAgIChlbG0pLT5maWVsZC5zcWVf
bmV4dCA9IE5VTEw7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgfSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCiB9IHdoaWxlICgvKkNPTlNUQ09ORCovMCkKIApAQCAtNDQ2LDYgKzQ1NSw4IEBA
IHVuaW9uIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgIChoZWFkKS0+dHFoX2NpcmMudHFsX3ByZXYg
PSAoZWxtKS0+ZmllbGQudHFlX2NpcmMudHFsX3ByZXY7IFwKICAgICAgICAgKGVsbSktPmZpZWxk
LnRxZV9jaXJjLnRxbF9wcmV2LT50cWxfbmV4dCA9IChlbG0pLT5maWVsZC50cWVfbmV4dDsgXAog
ICAgICAgICAoZWxtKS0+ZmllbGQudHFlX2NpcmMudHFsX3ByZXYgPSBOVUxMOyAgICAgICAgICAg
ICAgICAgICAgICAgICAgXAorICAgICAgICAoZWxtKS0+ZmllbGQudHFlX2NpcmMudHFsX25leHQg
PSBOVUxMOyAgICAgICAgICAgICAgICAgICAgICAgICAgXAorICAgICAgICAoZWxtKS0+ZmllbGQu
dHFlX25leHQgPSBOVUxMOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogfSB3
aGlsZSAoLypDT05TVENPTkQqLzApCiAKIC8qIHJlbW92ZSBAbGVmdCwgQHJpZ2h0IGFuZCBhbGwg
ZWxlbWVudHMgaW4gYmV0d2VlbiBmcm9tIEBoZWFkICovCi0tIAoyLjI0LjEKCg==


