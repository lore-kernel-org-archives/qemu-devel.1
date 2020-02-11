Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_BASE64_TEXT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E8C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B6020714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNW80XD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B6020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Y1Z-0000vt-BA
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0Z-00083l-Ur
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j1Y0V-0005DN-5H
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j1Y0U-0005Ae-QF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581437005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C/C3DFLKOff+u8tqd5nj4EtQC62OiWFmBEjl7KJljQI=;
 b=XNW80XD4p7mZokKteYM0Kl8rJe4c1JWQ5n7PHeZcYr0LXMb61BVLSon5oCDEn+oe110nx9
 guAlxp8HcAbQtn8uLkUv/RAkq9JuXOBQBZueybLN5AdgcMOK5+ZNg0XClza0deaY5H2meo
 /rTIcAyF+b4lRVUU1KwPKWYQxTCd/UI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-xbKoimazMYeUYaxMn_FsfA-1; Tue, 11 Feb 2020 11:03:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB9610054E3;
 Tue, 11 Feb 2020 16:03:22 +0000 (UTC)
Received: from localhost (unknown [10.36.118.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4843426FB6;
 Tue, 11 Feb 2020 16:03:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] luks: add qemu-img measure support
Date: Tue, 11 Feb 2020 16:03:14 +0000
Message-Id: <20200211160318.453650-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xbKoimazMYeUYaxMn_FsfA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

djM6CiAqIE1vdmUgcGF5bG9hZCBvZmZzZXQgY2FsY3VsYXRpb24gZnVuY3Rpb24gdG8gY3J5cHRv
L2Jsb2NrLmMgW01heF0KICogWmVyby91bmFsbG9jYXRlZCBibG9ja3MgYWx3YXlzIHJlcXVpcmUg
ZGlzayBzcGFjZSBvbiBlbmNyeXB0ZWQgZmlsZXMgW01heF0KICogVXBkYXRlIHFlbXUtaW90ZXN0
cyAxNzggb3V0cHV0IHdoZW4gY2hhbmdpbmcgcWVtdS1pbWcgbWVhc3VyZSBjb21tYW5kLWxpbmUK
ICAgb3B0aW9ucwoKdjI6CiAqIEZpeCB1aW50NjRfdCA8LT4gc2l6ZV90IHR5cGUgbWlzbWF0Y2gg
aW4gYmxvY2tfY3J5cHRvX21lYXN1cmUoKSBzbyB0aGF0CiAgIDMyLWJpdCBidWlsZHMgcGFzcwoK
VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBxZW11LWltZyBtZWFzdXJlIHN1cHBvcnQgdG8gdGhlICJs
dWtzIiBibG9jayBkcml2ZXIuICBXZQpqdXN0IG5lZWQgdG8gdGFrZSBpbnRvIGFjY291bnQgdGhl
IExVS1MgaGVhZGVyIHdoZW4gc2l6aW5nIHRoZSBpbWFnZS4KClN0ZWZhbiBIYWpub2N6aSAoNCk6
CiAgbHVrczogZXh0cmFjdCBxY3J5cHRvX2Jsb2NrX2NhbGN1bGF0ZV9wYXlsb2FkX29mZnNldCgp
CiAgbHVrczogaW1wbGVtZW50IC5iZHJ2X21lYXN1cmUoKQogIHFlbXUtaW1nOiBhbGxvdyBxZW11
LWltZyBtZWFzdXJlIC0tb2JqZWN0IHdpdGhvdXQgYSBmaWxlbmFtZQogIGlvdGVzdHM6IGFkZCAy
ODIgbHVrcyBxZW11LWltZyBtZWFzdXJlIHRlc3QKCiBibG9jay9jcnlwdG8uYyAgICAgICAgICAg
ICAgICAgICB8IDYyICsrKysrKysrKysrKysrKysrKysrKwogYmxvY2svcWNvdzIuYyAgICAgICAg
ICAgICAgICAgICAgfCA3NCArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiBjcnlwdG8vYmxvY2su
YyAgICAgICAgICAgICAgICAgICB8IDQwICsrKysrKysrKysrKysrCiBpbmNsdWRlL2NyeXB0by9i
bG9jay5oICAgICAgICAgICB8IDIyICsrKysrKysrCiBxZW11LWltZy5jICAgICAgICAgICAgICAg
ICAgICAgICB8ICA2ICstLQogdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OCAgICAgICAgICAgfCAgMiAr
LQogdGVzdHMvcWVtdS1pb3Rlc3RzLzE3OC5vdXQucWNvdzIgfCAgOCArLS0KIHRlc3RzL3FlbXUt
aW90ZXN0cy8xNzgub3V0LnJhdyAgIHwgIDggKy0tCiB0ZXN0cy9xZW11LWlvdGVzdHMvMjgyICAg
ICAgICAgICB8IDkzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy9xZW11
LWlvdGVzdHMvMjgyLm91dCAgICAgICB8IDMwICsrKysrKysrKysrCiB0ZXN0cy9xZW11LWlvdGVz
dHMvZ3JvdXAgICAgICAgICB8ICAxICsKIDExIGZpbGVzIGNoYW5nZWQsIDI3OCBpbnNlcnRpb25z
KCspLCA2OCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVz
dHMvMjgyCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcWVtdS1pb3Rlc3RzLzI4Mi5vdXQKCi0t
IAoyLjI0LjEKCg==


