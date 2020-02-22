Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665CCC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAC02071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdRaGwCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAC02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Qaa-0006n2-4T
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QVP-00056N-Ar
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QVO-00085z-7Y
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QVO-00085l-37
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mouUenlt/h9K99Ls7A7wbgC3L2V5tV7SvMj/C9fddnU=;
 b=VdRaGwCvlcfcAW5vmySdJGBVQQe5kYnR+dy9UDn+iLqszl+rBByrwP2+OIE5t2ESQiHoNS
 L44hbJm0GGejdvz78d3U+OgYMf86OQ988sE1UNavNT2A3usPSHbBXXwLSuxmSdCTWbOqge
 JgZI4yVjKBtI7Cq36EJF5PmHIP/ceJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-qKbdODTLPGu42736cZOBjw-1; Sat, 22 Feb 2020 03:51:19 -0500
X-MC-Unique: qKbdODTLPGu42736cZOBjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C83713E2;
 Sat, 22 Feb 2020 08:51:18 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B45060BE0;
 Sat, 22 Feb 2020 08:51:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/31] aio-posix: fix use after leaving scope in aio_poll()
Date: Sat, 22 Feb 2020 08:50:04 +0000
Message-Id: <20200222085030.1760640-6-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
YUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU2VyZ2lvIExvcGV6IDxzbHBAcmVkaGF0LmNvbT4K
TWVzc2FnZS1pZDogMjAyMDAyMTQxNzE3MTIuNTQxMzU4LTItc3RlZmFuaGFAcmVkaGF0LmNvbQpT
aWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQog
dXRpbC9haW8tcG9zaXguYyB8IDIwICsrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91dGlsL2Fp
by1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRleCBmNjdmNWIzNGU5Li5jOTY0NjI3YTAz
IDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisrKyBiL3V0aWwvYWlvLXBvc2l4LmMKQEAg
LTEwNSwxNyArMTA1LDE4IEBAIHN0YXRpYyB2b2lkIGFpb19lcG9sbF91cGRhdGUoQWlvQ29udGV4
dCAqY3R4LCBBaW9IYW5kbGVyICpub2RlLCBib29sIGlzX25ldykKICAgICB9CiB9CiAKLXN0YXRp
YyBpbnQgYWlvX2Vwb2xsKEFpb0NvbnRleHQgKmN0eCwgR1BvbGxGRCAqcGZkcywKLSAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIG5wZmQsIGludDY0X3QgdGltZW91dCkKK3N0YXRpYyBpbnQg
YWlvX2Vwb2xsKEFpb0NvbnRleHQgKmN0eCwgaW50NjRfdCB0aW1lb3V0KQogeworICAgIEdQb2xs
RkQgcGZkID0geworICAgICAgICAuZmQgPSBjdHgtPmVwb2xsZmQsCisgICAgICAgIC5ldmVudHMg
PSBHX0lPX0lOIHwgR19JT19PVVQgfCBHX0lPX0hVUCB8IEdfSU9fRVJSLAorICAgIH07CiAgICAg
QWlvSGFuZGxlciAqbm9kZTsKICAgICBpbnQgaSwgcmV0ID0gMDsKICAgICBzdHJ1Y3QgZXBvbGxf
ZXZlbnQgZXZlbnRzWzEyOF07CiAKLSAgICBhc3NlcnQobnBmZCA9PSAxKTsKLSAgICBhc3NlcnQo
cGZkc1swXS5mZCA9PSBjdHgtPmVwb2xsZmQpOwogICAgIGlmICh0aW1lb3V0ID4gMCkgewotICAg
ICAgICByZXQgPSBxZW11X3BvbGxfbnMocGZkcywgbnBmZCwgdGltZW91dCk7CisgICAgICAgIHJl
dCA9IHFlbXVfcG9sbF9ucygmcGZkLCAxLCB0aW1lb3V0KTsKICAgICB9CiAgICAgaWYgKHRpbWVv
dXQgPD0gMCB8fCByZXQgPiAwKSB7CiAgICAgICAgIHJldCA9IGVwb2xsX3dhaXQoY3R4LT5lcG9s
bGZkLCBldmVudHMsCkBAIC02NjksMTMgKzY3MCw4IEBAIGJvb2wgYWlvX3BvbGwoQWlvQ29udGV4
dCAqY3R4LCBib29sIGJsb2NraW5nKQogCiAgICAgICAgIC8qIHdhaXQgdW50aWwgbmV4dCBldmVu
dCAqLwogICAgICAgICBpZiAoYWlvX2Vwb2xsX2NoZWNrX3BvbGwoY3R4LCBwb2xsZmRzLCBucGZk
LCB0aW1lb3V0KSkgewotICAgICAgICAgICAgQWlvSGFuZGxlciBlcG9sbF9oYW5kbGVyOwotCi0g
ICAgICAgICAgICBlcG9sbF9oYW5kbGVyLnBmZC5mZCA9IGN0eC0+ZXBvbGxmZDsKLSAgICAgICAg
ICAgIGVwb2xsX2hhbmRsZXIucGZkLmV2ZW50cyA9IEdfSU9fSU4gfCBHX0lPX09VVCB8IEdfSU9f
SFVQIHwgR19JT19FUlI7Ci0gICAgICAgICAgICBucGZkID0gMDsKLSAgICAgICAgICAgIGFkZF9w
b2xsZmQoJmVwb2xsX2hhbmRsZXIpOwotICAgICAgICAgICAgcmV0ID0gYWlvX2Vwb2xsKGN0eCwg
cG9sbGZkcywgbnBmZCwgdGltZW91dCk7CisgICAgICAgICAgICBucGZkID0gMDsgLyogcG9sbGZk
c1tdIGlzIG5vdCBiZWluZyB1c2VkICovCisgICAgICAgICAgICByZXQgPSBhaW9fZXBvbGwoY3R4
LCB0aW1lb3V0KTsKICAgICAgICAgfSBlbHNlICB7CiAgICAgICAgICAgICByZXQgPSBxZW11X3Bv
bGxfbnMocG9sbGZkcywgbnBmZCwgdGltZW91dCk7CiAgICAgICAgIH0KLS0gCjIuMjQuMQoK


