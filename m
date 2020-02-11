Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16229C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D763620873
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/eJBajX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D763620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Y3K-0003wq-UN
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0w-0000Dy-4F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0u-0005i6-PZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1Y0u-0005hs-MA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581437032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cEhmOZ5hoijHuXDp287yCBo9YwJCFSV6bDfCPBv+wM=;
 b=K/eJBajXpuQkNQZXGKxYRFOhlbLmCiz26disMqe/0M2o/tQx2vMc5HYv/F0PYSRNvIsTN8
 Y789j+cY1LIRaqnkRaBJmryopoXx+BVSx4UDFYFuNda2WvIYrJ6cbLsxL9eDlUBzGTJ2Of
 f/DVyy2MmrwnVewf+nuvd1mR8CrTZ8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-UFaDfcP9Oxye97Ut4A288g-1; Tue, 11 Feb 2020 11:03:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281B210054E3;
 Tue, 11 Feb 2020 16:03:33 +0000 (UTC)
Received: from localhost (unknown [10.36.118.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE04626FB2;
 Tue, 11 Feb 2020 16:03:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] qemu-img: allow qemu-img measure --object without a
 filename
Date: Tue, 11 Feb 2020 16:03:17 +0000
Message-Id: <20200211160318.453650-4-stefanha@redhat.com>
In-Reply-To: <20200211160318.453650-1-stefanha@redhat.com>
References: <20200211160318.453650-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: UFaDfcP9Oxye97Ut4A288g-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SW4gbW9zdCBxZW11LWltZyBzdWItY29tbWFuZHMgdGhlIC0tb2JqZWN0IG9wdGlvbiBvbmx5IG1h
a2VzIHNlbnNlIHdoZW4KdGhlcmUgaXMgYSBmaWxlbmFtZS4gIHFlbXUtaW1nIG1lYXN1cmUgaXMg
YW4gZXhjZXB0aW9uIGJlY2F1c2Ugb2JqZWN0cwptYXkgYmUgcmVmZXJlbmNlZCBmcm9tIHRoZSBp
bWFnZSBjcmVhdGlvbiBvcHRpb25zIGluc3RlYWQgb2YgYW4gZXhpc3RpbmcKaW1hZ2UgZmlsZS4g
IEFsbG93IC0tb2JqZWN0IHdpdGhvdXQgYSBmaWxlbmFtZS4KClNpZ25lZC1vZmYtYnk6IFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBxZW11LWltZy5jICAgICAgICAg
ICAgICAgICAgICAgICB8IDYgKystLS0tCiB0ZXN0cy9xZW11LWlvdGVzdHMvMTc4ICAgICAgICAg
ICB8IDIgKy0KIHRlc3RzL3FlbXUtaW90ZXN0cy8xNzgub3V0LnFjb3cyIHwgOCArKysrLS0tLQog
dGVzdHMvcWVtdS1pb3Rlc3RzLzE3OC5vdXQucmF3ICAgfCA4ICsrKystLS0tCiA0IGZpbGVzIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Fl
bXUtaW1nLmMgYi9xZW11LWltZy5jCmluZGV4IDJiNDU2MmI5ZDkuLjBjZWU3YmVkOGIgMTAwNjQ0
Ci0tLSBhL3FlbXUtaW1nLmMKKysrIGIvcWVtdS1pbWcuYwpAQCAtNDkxMiwxMCArNDkxMiw4IEBA
IHN0YXRpYyBpbnQgaW1nX21lYXN1cmUoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogICAgICAgICBm
aWxlbmFtZSA9IGFyZ3Zbb3B0aW5kXTsKICAgICB9CiAKLSAgICBpZiAoIWZpbGVuYW1lICYmCi0g
ICAgICAgIChvYmplY3Rfb3B0cyB8fCBpbWFnZV9vcHRzIHx8IGZtdCB8fCBzbmFwc2hvdF9uYW1l
IHx8IHNuX29wdHMpKSB7Ci0gICAgICAgIGVycm9yX3JlcG9ydCgiLS1vYmplY3QsIC0taW1hZ2Ut
b3B0cywgLWYsIGFuZCAtbCAiCi0gICAgICAgICAgICAgICAgICAgICAicmVxdWlyZSBhIGZpbGVu
YW1lIGFyZ3VtZW50LiIpOworICAgIGlmICghZmlsZW5hbWUgJiYgKGltYWdlX29wdHMgfHwgZm10
IHx8IHNuYXBzaG90X25hbWUgfHwgc25fb3B0cykpIHsKKyAgICAgICAgZXJyb3JfcmVwb3J0KCIt
LWltYWdlLW9wdHMsIC1mLCBhbmQgLWwgcmVxdWlyZSBhIGZpbGVuYW1lIGFyZ3VtZW50LiIpOwog
ICAgICAgICBnb3RvIG91dDsKICAgICB9CiAgICAgaWYgKGZpbGVuYW1lICYmIGltZ19zaXplICE9
IFVJTlQ2NF9NQVgpIHsKZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNzggYi90ZXN0
cy9xZW11LWlvdGVzdHMvMTc4CmluZGV4IDUxYTcwZmU2NjkuLjdjZjBlMjcxNTQgMTAwNzU1Ci0t
LSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNzgKKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OApA
QCAtNTAsNyArNTAsNyBAQCBfbWFrZV90ZXN0X2ltZyAxRwogJFFFTVVfSU1HIG1lYXN1cmUgIyBt
aXNzaW5nIGFyZ3VtZW50cwogJFFFTVVfSU1HIG1lYXN1cmUgLS1zaXplIDJHICIkVEVTVF9JTUci
ICMgb25seSBvbmUgYWxsb3dlZAogJFFFTVVfSU1HIG1lYXN1cmUgIiRURVNUX0lNRyIgYSAjIG9u
bHkgb25lIGZpbGVuYW1lIGFsbG93ZWQKLSRRRU1VX0lNRyBtZWFzdXJlIC0tb2JqZWN0IHNlY3Jl
dCxpZD1zZWMwLGRhdGE9TVRJek5EVTIsZm9ybWF0PWJhc2U2NCAjIG1pc3NpbmcgZmlsZW5hbWUK
KyRRRU1VX0lNRyBtZWFzdXJlIC0tb2JqZWN0IHNlY3JldCxpZD1zZWMwLGRhdGE9TVRJek5EVTIs
Zm9ybWF0PWJhc2U2NCAjIHNpemUgb3IgZmlsZW5hbWUgbmVlZGVkCiAkUUVNVV9JTUcgbWVhc3Vy
ZSAtLWltYWdlLW9wdHMgIyBtaXNzaW5nIGZpbGVuYW1lCiAkUUVNVV9JTUcgbWVhc3VyZSAtZiBx
Y293MiAjIG1pc3NpbmcgZmlsZW5hbWUKICRRRU1VX0lNRyBtZWFzdXJlIC1sIHNuYXAxICMgbWlz
c2luZyBmaWxlbmFtZQpkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OC5vdXQucWNv
dzIgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTc4Lm91dC5xY293MgppbmRleCA5ZTdkOGM0NGRmLi5m
NTliZjRiMmZiIDEwMDY0NAotLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMTc4Lm91dC5xY293Mgor
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTc4Lm91dC5xY293MgpAQCAtNSwxMCArNSwxMCBAQCBG
b3JtYXR0aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMDczNzQxODI0
CiBxZW11LWltZzogRWl0aGVyIC0tc2l6ZSBOIG9yIG9uZSBmaWxlbmFtZSBtdXN0IGJlIHNwZWNp
ZmllZC4KIHFlbXUtaW1nOiAtLXNpemUgTiBjYW5ub3QgYmUgdXNlZCB0b2dldGhlciB3aXRoIGEg
ZmlsZW5hbWUuCiBxZW11LWltZzogQXQgbW9zdCBvbmUgZmlsZW5hbWUgYXJndW1lbnQgaXMgYWxs
b3dlZC4KLXFlbXUtaW1nOiAtLW9iamVjdCwgLS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1sIHJlcXVp
cmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KLXFlbXUtaW1nOiAtLW9iamVjdCwgLS1pbWFnZS1vcHRz
LCAtZiwgYW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KLXFlbXUtaW1nOiAtLW9i
amVjdCwgLS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVu
dC4KLXFlbXUtaW1nOiAtLW9iamVjdCwgLS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1sIHJlcXVpcmUg
YSBmaWxlbmFtZSBhcmd1bWVudC4KK3FlbXUtaW1nOiBFaXRoZXIgLS1zaXplIE4gb3Igb25lIGZp
bGVuYW1lIG11c3QgYmUgc3BlY2lmaWVkLgorcWVtdS1pbWc6IC0taW1hZ2Utb3B0cywgLWYsIGFu
ZCAtbCByZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQuCitxZW11LWltZzogLS1pbWFnZS1vcHRz
LCAtZiwgYW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KK3FlbXUtaW1nOiAtLWlt
YWdlLW9wdHMsIC1mLCBhbmQgLWwgcmVxdWlyZSBhIGZpbGVuYW1lIGFyZ3VtZW50LgogcWVtdS1p
bWc6IEludmFsaWQgb3B0aW9uIGxpc3Q6ICwKIHFlbXUtaW1nOiBJbnZhbGlkIHBhcmFtZXRlciAn
c25hcHNob3QuZm9vJwogcWVtdS1pbWc6IEZhaWxlZCBpbiBwYXJzaW5nIHNuYXBzaG90IHBhcmFt
ICdzbmFwc2hvdC5mb28nCmRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMTc4Lm91dC5y
YXcgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTc4Lm91dC5yYXcKaW5kZXggNjQ3ODM2NTkwNS4uNDA0
Y2E5MDhkOCAxMDA2NDQKLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OC5vdXQucmF3CisrKyBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8xNzgub3V0LnJhdwpAQCAtNSwxMCArNSwxMCBAQCBGb3JtYXR0
aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMDczNzQxODI0CiBxZW11
LWltZzogRWl0aGVyIC0tc2l6ZSBOIG9yIG9uZSBmaWxlbmFtZSBtdXN0IGJlIHNwZWNpZmllZC4K
IHFlbXUtaW1nOiAtLXNpemUgTiBjYW5ub3QgYmUgdXNlZCB0b2dldGhlciB3aXRoIGEgZmlsZW5h
bWUuCiBxZW11LWltZzogQXQgbW9zdCBvbmUgZmlsZW5hbWUgYXJndW1lbnQgaXMgYWxsb3dlZC4K
LXFlbXUtaW1nOiAtLW9iamVjdCwgLS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1sIHJlcXVpcmUgYSBm
aWxlbmFtZSBhcmd1bWVudC4KLXFlbXUtaW1nOiAtLW9iamVjdCwgLS1pbWFnZS1vcHRzLCAtZiwg
YW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KLXFlbXUtaW1nOiAtLW9iamVjdCwg
LS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KLXFl
bXUtaW1nOiAtLW9iamVjdCwgLS1pbWFnZS1vcHRzLCAtZiwgYW5kIC1sIHJlcXVpcmUgYSBmaWxl
bmFtZSBhcmd1bWVudC4KK3FlbXUtaW1nOiBFaXRoZXIgLS1zaXplIE4gb3Igb25lIGZpbGVuYW1l
IG11c3QgYmUgc3BlY2lmaWVkLgorcWVtdS1pbWc6IC0taW1hZ2Utb3B0cywgLWYsIGFuZCAtbCBy
ZXF1aXJlIGEgZmlsZW5hbWUgYXJndW1lbnQuCitxZW11LWltZzogLS1pbWFnZS1vcHRzLCAtZiwg
YW5kIC1sIHJlcXVpcmUgYSBmaWxlbmFtZSBhcmd1bWVudC4KK3FlbXUtaW1nOiAtLWltYWdlLW9w
dHMsIC1mLCBhbmQgLWwgcmVxdWlyZSBhIGZpbGVuYW1lIGFyZ3VtZW50LgogcWVtdS1pbWc6IElu
dmFsaWQgb3B0aW9uIGxpc3Q6ICwKIHFlbXUtaW1nOiBJbnZhbGlkIHBhcmFtZXRlciAnc25hcHNo
b3QuZm9vJwogcWVtdS1pbWc6IEZhaWxlZCBpbiBwYXJzaW5nIHNuYXBzaG90IHBhcmFtICdzbmFw
c2hvdC5mb28nCi0tIAoyLjI0LjEKCg==


