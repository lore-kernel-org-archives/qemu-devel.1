Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1CC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766C52071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIisD3WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766C52071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5QYE-0001bV-L6
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QVf-0005bs-7S
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QVe-0008P8-5M
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QVe-0008Nh-0g
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPXEbqGRhGH26RxEJy1rOn/fUNg6GhatVnHEhVvROOw=;
 b=bIisD3WOredbnC2cRVbz3Fv+uE2oRmf4PkIhGm2BTBHy92m1i3XzvZA5QzPLEYMuIzPOFZ
 SUbE8x9bYiLwWrCdKqaMGlhoTrJy7Je7l6utIWdyKnTjH3gb3XN6I5WzZh/IlaEuVmUxLZ
 OvqUhgh1D5gNKwpM3+R36m7Dv7WA7Z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-Re2sCLdrNgyNTSK99qcwpQ-1; Sat, 22 Feb 2020 03:51:34 -0500
X-MC-Unique: Re2sCLdrNgyNTSK99qcwpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC5188014D0;
 Sat, 22 Feb 2020 08:51:32 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED9A85C1C3;
 Sat, 22 Feb 2020 08:51:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/31] aio-posix: don't pass ns timeout to epoll_wait()
Date: Sat, 22 Feb 2020 08:50:05 +0000
Message-Id: <20200222085030.1760640-7-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

RG9uJ3QgcGFzcyB0aGUgbmFub3NlY29uZCB0aW1lb3V0IGludG8gZXBvbGxfd2FpdCgpLCB3aGlj
aCBleHBlY3RzCm1pbGxpc2Vjb25kcy4KClRoZSBlcG9sbF93YWl0KCkgdGltZW91dCB2YWx1ZSBk
b2VzIG5vdCBtYXR0ZXIgaWYgcWVtdV9wb2xsX25zKCkKZGV0ZXJtaW5lZCB0aGF0IHRoZSBwb2xs
IGZkIGlzIHJlYWR5LCBidXQgcGFzc2luZyBhIHZhbHVlIGluIHRoZSB3cm9uZwp1bml0cyBpcyBz
dGlsbCB1Z2x5LiAgUGFzcyBhIDAgdGltZW91dCB0byBlcG9sbF93YWl0KCkgaW5zdGVhZC4KClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3
ZWQtYnk6IFNlcmdpbyBMb3BleiA8c2xwQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMjE0
MTcxNzEyLjU0MTM1OC0zLXN0ZWZhbmhhQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvYWlvLXBvc2l4LmMgfCAz
ICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3V0aWwv
YWlvLXBvc2l4LmMgYi91dGlsL2Fpby1wb3NpeC5jCmluZGV4IGM5NjQ2MjdhMDMuLjU4NzY1ZTU4
MWUgMTAwNjQ0Ci0tLSBhL3V0aWwvYWlvLXBvc2l4LmMKKysrIGIvdXRpbC9haW8tcG9zaXguYwpA
QCAtMTE3LDYgKzExNyw5IEBAIHN0YXRpYyBpbnQgYWlvX2Vwb2xsKEFpb0NvbnRleHQgKmN0eCwg
aW50NjRfdCB0aW1lb3V0KQogCiAgICAgaWYgKHRpbWVvdXQgPiAwKSB7CiAgICAgICAgIHJldCA9
IHFlbXVfcG9sbF9ucygmcGZkLCAxLCB0aW1lb3V0KTsKKyAgICAgICAgaWYgKHJldCA+IDApIHsK
KyAgICAgICAgICAgIHRpbWVvdXQgPSAwOworICAgICAgICB9CiAgICAgfQogICAgIGlmICh0aW1l
b3V0IDw9IDAgfHwgcmV0ID4gMCkgewogICAgICAgICByZXQgPSBlcG9sbF93YWl0KGN0eC0+ZXBv
bGxmZCwgZXZlbnRzLAotLSAKMi4yNC4xCgo=


