Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D0AC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843502073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LesQgUd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843502073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Si-0000i5-Mz
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j56R3-0005ly-0Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j56R1-0001dA-BA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j56R1-0001bG-6j
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582284330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Wp+feoApaRedcuxvS3R/XvLKR4dhX67cLkWnuwm0yk=;
 b=LesQgUd7CmwfKua+WDtQUrQ6k+PskNubBkvkA0RJfCv+Ew4nFBarVmzSZBiza17y8Flwvf
 mWDH0vJKn1XW46bVRO7P9NQtNfxDd9pVgidjM7DDqMqr2wVh8CX9MklY8kMgMPjr24ySlW
 rWUa9T8FloRkVLwz9uz7yt5MFsHVxEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-8es5yceoPRerE33itSnxwQ-1; Fri, 21 Feb 2020 06:25:28 -0500
X-MC-Unique: 8es5yceoPRerE33itSnxwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BBA310CE7AE;
 Fri, 21 Feb 2020 11:25:27 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5974A5D9C5;
 Fri, 21 Feb 2020 11:25:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] luks: add qemu-img measure support
Date: Fri, 21 Feb 2020 11:25:18 +0000
Message-Id: <20200221112522.1497712-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

djQ6CiAqIFRoaXMgcmV2aXNpb24gaXMgd2hhdCBHZXJtYW4gc3BlYWtlcnMgY2FsbCAiZGFzIFTD
vHBmZWxjaGVuIGF1ZiBkZW0gSSIuICAiVGhlCiAgIGljaW5nIG9uIHRoZSBjYWtlIiBpcyB0aGUg
RW5nbGlzaCBlcXVpdmFsZW50LiAgU2luY2UgSSBsaWtlIGNha2UgYW5kIGRvbid0CiAgIHdhbnQg
aXQgdG8gYmUgaGFsZi1iYWtlZCwgYW5kIGJlY2F1c2UgSSBsaWtlIG15IG1ldGFwaG9ycyBzaGFr
ZW4sIG5vdAogICBzdGlycmVkLCBJIHdlbnQgYWhlYWQgd2l0aCB0aGUgZXh0cmEgcmV2aXNpb24g
c28gSSBjb3VsZCB3cml0ZSB0aGlzIG1lc3NhZ2UuCiAqIFVzZSBnX2F1dG9wdHIoUUNyeXB0b0Js
b2NrKSB0byBtYWtlIHRoZSBjb2RlIG1vcmUgY29uY2lzZSBbTWF4XQogKiBVc2UgbG9jYWxfZXJy
IGNvbnNpc3RlbnRseSBbTWF4XQogKiBGb2xkZWQgaW4gTWF4J3MgUmV2aWV3ZWQtYnkgdGFncwp2
MzoKICogTW92ZSBwYXlsb2FkIG9mZnNldCBjYWxjdWxhdGlvbiBmdW5jdGlvbiB0byBjcnlwdG8v
YmxvY2suYyBbTWF4XQogKiBaZXJvL3VuYWxsb2NhdGVkIGJsb2NrcyBhbHdheXMgcmVxdWlyZSBk
aXNrIHNwYWNlIG9uIGVuY3J5cHRlZCBmaWxlcyBbTWF4XQogKiBVcGRhdGUgcWVtdS1pb3Rlc3Rz
IDE3OCBvdXRwdXQgd2hlbiBjaGFuZ2luZyBxZW11LWltZyBtZWFzdXJlIGNvbW1hbmQtbGluZQog
ICBvcHRpb25zCgp2MjoKICogRml4IHVpbnQ2NF90IDwtPiBzaXplX3QgdHlwZSBtaXNtYXRjaCBp
biBibG9ja19jcnlwdG9fbWVhc3VyZSgpIHNvIHRoYXQKICAgMzItYml0IGJ1aWxkcyBwYXNzCgpU
aGlzIHBhdGNoIHNlcmllcyBhZGRzIHFlbXUtaW1nIG1lYXN1cmUgc3VwcG9ydCB0byB0aGUgImx1
a3MiIGJsb2NrIGRyaXZlci4gIFdlCmp1c3QgbmVlZCB0byB0YWtlIGludG8gYWNjb3VudCB0aGUg
TFVLUyBoZWFkZXIgd2hlbiBzaXppbmcgdGhlIGltYWdlLgoKU3RlZmFuIEhham5vY3ppICg0KToK
ICBsdWtzOiBleHRyYWN0IHFjcnlwdG9fYmxvY2tfY2FsY3VsYXRlX3BheWxvYWRfb2Zmc2V0KCkK
ICBsdWtzOiBpbXBsZW1lbnQgLmJkcnZfbWVhc3VyZSgpCiAgcWVtdS1pbWc6IGFsbG93IHFlbXUt
aW1nIG1lYXN1cmUgLS1vYmplY3Qgd2l0aG91dCBhIGZpbGVuYW1lCiAgaW90ZXN0czogYWRkIDI4
MiBsdWtzIHFlbXUtaW1nIG1lYXN1cmUgdGVzdAoKIGJsb2NrL2NyeXB0by5jICAgICAgICAgICAg
ICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKysrCiBibG9jay9xY293Mi5jICAgICAgICAg
ICAgICAgICAgICB8IDc0ICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIGNyeXB0by9ibG9jay5j
ICAgICAgICAgICAgICAgICAgIHwgMzYgKysrKysrKysrKysrKwogaW5jbHVkZS9jcnlwdG8vYmxv
Y2suaCAgICAgICAgICAgfCAyMiArKysrKysrKwogcWVtdS1pbWcuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgNiArLS0KIHRlc3RzL3FlbXUtaW90ZXN0cy8xNzggICAgICAgICAgIHwgIDIgKy0K
IHRlc3RzL3FlbXUtaW90ZXN0cy8xNzgub3V0LnFjb3cyIHwgIDggKy0tCiB0ZXN0cy9xZW11LWlv
dGVzdHMvMTc4Lm91dC5yYXcgICB8ICA4ICstLQogdGVzdHMvcWVtdS1pb3Rlc3RzLzI4MiAgICAg
ICAgICAgfCA5MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvcWVtdS1p
b3Rlc3RzLzI4Mi5vdXQgICAgICAgfCAzMCArKysrKysrKysrKwogdGVzdHMvcWVtdS1pb3Rlc3Rz
L2dyb3VwICAgICAgICAgfCAgMSArCiAxMSBmaWxlcyBjaGFuZ2VkLCAyNzQgaW5zZXJ0aW9ucygr
KSwgNjggZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI4MgogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yODIub3V0CgotLSAK
Mi4yNC4xCgo=


