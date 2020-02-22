Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654BBC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F552071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC5hxCWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F552071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QcZ-0002QE-CG
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QVt-00068N-MO
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QVs-0000H7-EJ
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QVs-0000Fp-9l
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUKq3/ARCCpuk5Uj5F14E13z54NDwFfEVciYGtHeEdc=;
 b=dC5hxCWLj6MtOYUBQEwatbxPZEXvtoNcVyXD7mtiTVmEQiK6aQCJpe/EhIhsCTN3Xnirsy
 qLJ3OR5ryIZeiuniwuEgjSbyR6ROTey0xqxxHCgA985bwECZK+SCDWfjOZwAhcMdQ3hIm2
 yhi2jJuFjQ0Yzde5S7AnAC3VWbBGAGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-DQmcNYr8P0qO1WGxS-ZJng-1; Sat, 22 Feb 2020 03:51:50 -0500
X-MC-Unique: DQmcNYr8P0qO1WGxS-ZJng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBAC2800D50;
 Sat, 22 Feb 2020 08:51:48 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A50B5D9CD;
 Sat, 22 Feb 2020 08:51:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/31] qemu/queue.h: add QLIST_SAFE_REMOVE()
Date: Sat, 22 Feb 2020 08:50:06 +0000
Message-Id: <20200222085030.1760640-8-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUxJU1RfUkVNT1ZFKCkgYXNzdW1lcyB0aGUgZWxlbWVudCBpcyBpbiBhIGxpc3QuICBJdCBhbHNv
IGxlYXZlcyB0aGUKZWxlbWVudCdzIGxpbmtlZCBsaXN0IHBvaW50ZXJzIGRhbmdsaW5nLgoKSW50
cm9kdWNlIGEgc2FmZSB2ZXJzaW9uIG9mIFFMSVNUX1JFTU9WRSgpIGFuZCBjb252ZXJ0IG9wZW4t
Y29kZWQKaW5zdGFuY2VzIG9mIHRoaXMgcGF0dGVybi4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBI
YWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFNlcmdpbyBMb3BleiA8
c2xwQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMjE0MTcxNzEyLjU0MTM1OC00LXN0ZWZh
bmhhQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIGJsb2NrLmMgICAgICAgICAgICAgIHwgIDUgKy0tLS0KIGNoYXJkZXYv
c3BpY2UuYyAgICAgIHwgIDQgKy0tLQogaW5jbHVkZS9xZW11L3F1ZXVlLmggfCAxNCArKysrKysr
KysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jCmluZGV4IDMwOGE5MWM5NmIuLjFiZGI5
YzY3OWQgMTAwNjQ0Ci0tLSBhL2Jsb2NrLmMKKysrIGIvYmxvY2suYwpAQCAtMjYzNiwxMCArMjYz
Niw3IEBAIEJkcnZDaGlsZCAqYmRydl9hdHRhY2hfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqcGFy
ZW50X2JzLAogCiBzdGF0aWMgdm9pZCBiZHJ2X2RldGFjaF9jaGlsZChCZHJ2Q2hpbGQgKmNoaWxk
KQogewotICAgIGlmIChjaGlsZC0+bmV4dC5sZV9wcmV2KSB7Ci0gICAgICAgIFFMSVNUX1JFTU9W
RShjaGlsZCwgbmV4dCk7Ci0gICAgICAgIGNoaWxkLT5uZXh0LmxlX3ByZXYgPSBOVUxMOwotICAg
IH0KKyAgICBRTElTVF9TQUZFX1JFTU9WRShjaGlsZCwgbmV4dCk7CiAKICAgICBiZHJ2X3JlcGxh
Y2VfY2hpbGQoY2hpbGQsIE5VTEwpOwogCmRpZmYgLS1naXQgYS9jaGFyZGV2L3NwaWNlLmMgYi9j
aGFyZGV2L3NwaWNlLmMKaW5kZXggMjQxZTJiNzc3MC4uYmY3ZWExZTI5NCAxMDA2NDQKLS0tIGEv
Y2hhcmRldi9zcGljZS5jCisrKyBiL2NoYXJkZXYvc3BpY2UuYwpAQCAtMjE2LDkgKzIxNiw3IEBA
IHN0YXRpYyB2b2lkIGNoYXJfc3BpY2VfZmluYWxpemUoT2JqZWN0ICpvYmopCiAKICAgICB2bWNf
dW5yZWdpc3Rlcl9pbnRlcmZhY2Uocyk7CiAKLSAgICBpZiAocy0+bmV4dC5sZV9wcmV2KSB7Ci0g
ICAgICAgIFFMSVNUX1JFTU9WRShzLCBuZXh0KTsKLSAgICB9CisgICAgUUxJU1RfU0FGRV9SRU1P
VkUocywgbmV4dCk7CiAKICAgICBnX2ZyZWUoKGNoYXIgKilzLT5zaW4uc3VidHlwZSk7CiAgICAg
Z19mcmVlKChjaGFyICopcy0+c2luLnBvcnRuYW1lKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVt
dS9xdWV1ZS5oIGIvaW5jbHVkZS9xZW11L3F1ZXVlLmgKaW5kZXggZmNlY2I3MDIyOC4uNjBlNzk0
YTRlMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9xZW11L3F1ZXVlLmgKKysrIGIvaW5jbHVkZS9xZW11
L3F1ZXVlLmgKQEAgLTE0NCw2ICsxNDQsMjAgQEAgc3RydWN0IHsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgICAq
KGVsbSktPmZpZWxkLmxlX3ByZXYgPSAoZWxtKS0+ZmllbGQubGVfbmV4dDsgICAgICAgICAgICAg
ICAgICAgXAogfSB3aGlsZSAoLypDT05TVENPTkQqLzApCiAKKy8qCisgKiBMaWtlIFFMSVNUX1JF
TU9WRSgpIGJ1dCBzYWZlIHRvIGNhbGwgd2hlbiBlbG0gaXMgbm90IGluIGEgbGlzdAorICovCisj
ZGVmaW5lIFFMSVNUX1NBRkVfUkVNT1ZFKGVsbSwgZmllbGQpIGRvIHsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCisgICAgICAgIGlmICgoZWxtKS0+ZmllbGQubGVfcHJldiAhPSBOVUxM
KSB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgICAgICAgICAgaWYgKChl
bG0pLT5maWVsZC5sZV9uZXh0ICE9IE5VTEwpICAgICAgICAgICAgICAgICAgICAgICBcCisgICAg
ICAgICAgICAgICAgICAgICAgICAoZWxtKS0+ZmllbGQubGVfbmV4dC0+ZmllbGQubGVfcHJldiA9
ICAgICAgICAgICBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGVsbSktPmZpZWxkLmxl
X3ByZXY7ICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgICAgICAgICAgKihlbG0pLT5m
aWVsZC5sZV9wcmV2ID0gKGVsbSktPmZpZWxkLmxlX25leHQ7ICAgICAgICAgICBcCisgICAgICAg
ICAgICAgICAgKGVsbSktPmZpZWxkLmxlX25leHQgPSBOVUxMOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCisgICAgICAgICAgICAgICAgKGVsbSktPmZpZWxkLmxlX3ByZXYgPSBOVUxMOyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcCisgICAgICAgIH0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCit9IHdoaWxlICgv
KkNPTlNUQ09ORCovMCkKKwogI2RlZmluZSBRTElTVF9GT1JFQUNIKHZhciwgaGVhZCwgZmllbGQp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgICBmb3IgKCh2YXIpID0g
KChoZWFkKS0+bGhfZmlyc3QpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAg
ICAgICAgICAgICAgICh2YXIpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXAotLSAKMi4yNC4xCgo=


