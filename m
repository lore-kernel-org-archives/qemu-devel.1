Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C960FC3B1A1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D79420637
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eG+cIERj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D79420637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ee9-0006Ed-Sb
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2eao-0000bn-Tx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2ean-0007FY-Rr
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2ean-0007Eq-Ns
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581700649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9Ymt1qQx6vp3IXr8OqQ4TVPGWbrPBjiOimPtVWKsWE=;
 b=eG+cIERjQkA6qx+u1d20LV4U54rIwNW6sM+F0lUtQ3QouVYJCw47gnRy+X5AKrKkrYZ8p1
 25gFeotpKZ32mpltbCjpSN7S/jvEM+fYd6Lo4/N3nmFUCN7aW3R7e4bBd9OwS+0QgvXa0c
 Wg29h2kyjya8REcgCDNUOzQnMkmpltg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ch3_E6IMPeOCiv8erYUMFg-1; Fri, 14 Feb 2020 12:17:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DB0F107B273;
 Fri, 14 Feb 2020 17:17:26 +0000 (UTC)
Received: from localhost (ovpn-116-135.ams2.redhat.com [10.36.116.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7527B5DA81;
 Fri, 14 Feb 2020 17:17:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] aio-posix: fix use after leaving scope in aio_poll()
Date: Fri, 14 Feb 2020 17:17:08 +0000
Message-Id: <20200214171712.541358-2-stefanha@redhat.com>
In-Reply-To: <20200214171712.541358-1-stefanha@redhat.com>
References: <20200214171712.541358-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ch3_E6IMPeOCiv8erYUMFg-1
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ZXBvbGxfaGFuZGxlciBpcyBhIHN0YWNrIHZhcmlhYmxlIGFuZCBtdXN0IG5vdCBiZSBhY2Nlc3Nl
ZCBhZnRlciBpdCBnb2VzCm91dCBvZiBzY29wZToKCiAgICAgIGlmIChhaW9fZXBvbGxfY2hlY2tf
cG9sbChjdHgsIHBvbGxmZHMsIG5wZmQsIHRpbWVvdXQpKSB7CiAgICAgICAgICBBaW9IYW5kbGVy
IGVwb2xsX2hhbmRsZXI7CiAgICAgICAgICAuLi4KICAgICAgICAgIGFkZF9wb2xsZmQoJmVwb2xs
X2hhbmRsZXIpOwogICAgICAgICAgcmV0ID0gYWlvX2Vwb2xsKGN0eCwgcG9sbGZkcywgbnBmZCwg
dGltZW91dCk7CiAgICAgIH0gLi4uCgogIC4uLgoKICAvKiBpZiB3ZSBoYXZlIGFueSByZWFkYWJs
ZSBmZHMsIGRpc3BhdGNoIGV2ZW50ICovCiAgaWYgKHJldCA+IDApIHsKICAgICAgZm9yIChpID0g
MDsgaSA8IG5wZmQ7IGkrKykgewogICAgICAgICAgbm9kZXNbaV0tPnBmZC5yZXZlbnRzID0gcG9s
bGZkc1tpXS5yZXZlbnRzOwogICAgICB9CiAgfQoKbm9kZXNbMF0gaXMgJmVwb2xsX2hhbmRsZXIs
IHdoaWNoIGhhcyBhbHJlYWR5IGdvbmUgb3V0IG9mIHNjb3BlLgoKVGhlcmUgaXMgbm8gbmVlZCB0
byB1c2UgcG9sbGZkc1tdIGZvciBlcG9sbC4gIFdlIGRvbid0IG5lZWQgYW4KQWlvSGFuZGxlciBm
b3IgdGhlIGVwb2xsIGZkLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgfCAyMCArKysrKysrKy0tLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdXRpbC9haW8tcG9zaXguYyBiL3V0aWwvYWlvLXBvc2l4LmMKaW5kZXggYTQ5
NzdmNTM4ZS4uMzFhOGUwM2NhNyAxMDA2NDQKLS0tIGEvdXRpbC9haW8tcG9zaXguYworKysgYi91
dGlsL2Fpby1wb3NpeC5jCkBAIC0xMDQsMTcgKzEwNCwxOCBAQCBzdGF0aWMgdm9pZCBhaW9fZXBv
bGxfdXBkYXRlKEFpb0NvbnRleHQgKmN0eCwgQWlvSGFuZGxlciAqbm9kZSwgYm9vbCBpc19uZXcp
CiAgICAgfQogfQogCi1zdGF0aWMgaW50IGFpb19lcG9sbChBaW9Db250ZXh0ICpjdHgsIEdQb2xs
RkQgKnBmZHMsCi0gICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBucGZkLCBpbnQ2NF90IHRp
bWVvdXQpCitzdGF0aWMgaW50IGFpb19lcG9sbChBaW9Db250ZXh0ICpjdHgsIGludDY0X3QgdGlt
ZW91dCkKIHsKKyAgICBHUG9sbEZEIHBmZCA9IHsKKyAgICAgICAgLmZkID0gY3R4LT5lcG9sbGZk
LAorICAgICAgICAuZXZlbnRzID0gR19JT19JTiB8IEdfSU9fT1VUIHwgR19JT19IVVAgfCBHX0lP
X0VSUiwKKyAgICB9OwogICAgIEFpb0hhbmRsZXIgKm5vZGU7CiAgICAgaW50IGksIHJldCA9IDA7
CiAgICAgc3RydWN0IGVwb2xsX2V2ZW50IGV2ZW50c1sxMjhdOwogCi0gICAgYXNzZXJ0KG5wZmQg
PT0gMSk7Ci0gICAgYXNzZXJ0KHBmZHNbMF0uZmQgPT0gY3R4LT5lcG9sbGZkKTsKICAgICBpZiAo
dGltZW91dCA+IDApIHsKLSAgICAgICAgcmV0ID0gcWVtdV9wb2xsX25zKHBmZHMsIG5wZmQsIHRp
bWVvdXQpOworICAgICAgICByZXQgPSBxZW11X3BvbGxfbnMoJnBmZCwgMSwgdGltZW91dCk7CiAg
ICAgfQogICAgIGlmICh0aW1lb3V0IDw9IDAgfHwgcmV0ID4gMCkgewogICAgICAgICByZXQgPSBl
cG9sbF93YWl0KGN0eC0+ZXBvbGxmZCwgZXZlbnRzLApAQCAtNjU4LDEzICs2NTksOCBAQCBib29s
IGFpb19wb2xsKEFpb0NvbnRleHQgKmN0eCwgYm9vbCBibG9ja2luZykKIAogICAgICAgICAvKiB3
YWl0IHVudGlsIG5leHQgZXZlbnQgKi8KICAgICAgICAgaWYgKGFpb19lcG9sbF9jaGVja19wb2xs
KGN0eCwgcG9sbGZkcywgbnBmZCwgdGltZW91dCkpIHsKLSAgICAgICAgICAgIEFpb0hhbmRsZXIg
ZXBvbGxfaGFuZGxlcjsKLQotICAgICAgICAgICAgZXBvbGxfaGFuZGxlci5wZmQuZmQgPSBjdHgt
PmVwb2xsZmQ7Ci0gICAgICAgICAgICBlcG9sbF9oYW5kbGVyLnBmZC5ldmVudHMgPSBHX0lPX0lO
IHwgR19JT19PVVQgfCBHX0lPX0hVUCB8IEdfSU9fRVJSOwotICAgICAgICAgICAgbnBmZCA9IDA7
Ci0gICAgICAgICAgICBhZGRfcG9sbGZkKCZlcG9sbF9oYW5kbGVyKTsKLSAgICAgICAgICAgIHJl
dCA9IGFpb19lcG9sbChjdHgsIHBvbGxmZHMsIG5wZmQsIHRpbWVvdXQpOworICAgICAgICAgICAg
bnBmZCA9IDA7IC8qIHBvbGxmZHNbXSBpcyBub3QgYmVpbmcgdXNlZCAqLworICAgICAgICAgICAg
cmV0ID0gYWlvX2Vwb2xsKGN0eCwgdGltZW91dCk7CiAgICAgICAgIH0gZWxzZSAgewogICAgICAg
ICAgICAgcmV0ID0gcWVtdV9wb2xsX25zKHBvbGxmZHMsIG5wZmQsIHRpbWVvdXQpOwogICAgICAg
ICB9Ci0tIAoyLjI0LjEKCg==


