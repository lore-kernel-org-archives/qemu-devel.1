Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD8CC3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E093206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFtgXRaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E093206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ec8-0002b6-9y
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2eax-0000rr-MT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2eav-0007Ob-HG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2eav-0007O9-Dl
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581700656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TE3YZlGhEob/gLlLYAmhUGskynNyvdDHL/TV6S3PPic=;
 b=GFtgXRaWCFuKPn8CYz91JjgP8U+cXS48AsaHV0p7JYbUla0aUS5ezhwL71FpbbmT8Q+ol7
 9Y7DFZuFTgmo1xw9NZRRvmdriDGOWNVOxjWmoOu7B2Sa/XaW1AKZ5PPMg25RuAbcdZ5VOo
 b98pkALm9JhZrVPNIInZM+W40ZW7xD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-orqvC7QpOZ2PA2kZeH3HVw-1; Fri, 14 Feb 2020 12:17:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83772DBA6;
 Fri, 14 Feb 2020 17:17:33 +0000 (UTC)
Received: from localhost (ovpn-116-135.ams2.redhat.com [10.36.116.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F049B5C126;
 Fri, 14 Feb 2020 17:17:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] aio-posix: don't pass ns timeout to epoll_wait()
Date: Fri, 14 Feb 2020 17:17:09 +0000
Message-Id: <20200214171712.541358-3-stefanha@redhat.com>
In-Reply-To: <20200214171712.541358-1-stefanha@redhat.com>
References: <20200214171712.541358-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: orqvC7QpOZ2PA2kZeH3HVw-1
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG9uJ3QgcGFzcyB0aGUgbmFub3NlY29uZCB0aW1lb3V0IGludG8gZXBvbGxfd2FpdCgpLCB3aGlj
aCBleHBlY3RzCm1pbGxpc2Vjb25kcy4KClRoZSBlcG9sbF93YWl0KCkgdGltZW91dCB2YWx1ZSBk
b2VzIG5vdCBtYXR0ZXIgaWYgcWVtdV9wb2xsX25zKCkKZGV0ZXJtaW5lZCB0aGF0IHRoZSBwb2xs
IGZkIGlzIHJlYWR5LCBidXQgcGFzc2luZyBhIHZhbHVlIGluIHRoZSB3cm9uZwp1bml0cyBpcyBz
dGlsbCB1Z2x5LiAgUGFzcyBhIDAgdGltZW91dCB0byBlcG9sbF93YWl0KCkgaW5zdGVhZC4KClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1
dGlsL2Fpby1wb3NpeC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS91dGlsL2Fpby1wb3NpeC5jIGIvdXRpbC9haW8tcG9zaXguYwppbmRleCAz
MWE4ZTAzY2E3Li5iMjFiY2Q4ZTk3IDEwMDY0NAotLS0gYS91dGlsL2Fpby1wb3NpeC5jCisrKyBi
L3V0aWwvYWlvLXBvc2l4LmMKQEAgLTExNiw2ICsxMTYsOSBAQCBzdGF0aWMgaW50IGFpb19lcG9s
bChBaW9Db250ZXh0ICpjdHgsIGludDY0X3QgdGltZW91dCkKIAogICAgIGlmICh0aW1lb3V0ID4g
MCkgewogICAgICAgICByZXQgPSBxZW11X3BvbGxfbnMoJnBmZCwgMSwgdGltZW91dCk7CisgICAg
ICAgIGlmIChyZXQgPiAwKSB7CisgICAgICAgICAgICB0aW1lb3V0ID0gMDsKKyAgICAgICAgfQog
ICAgIH0KICAgICBpZiAodGltZW91dCA8PSAwIHx8IHJldCA+IDApIHsKICAgICAgICAgcmV0ID0g
ZXBvbGxfd2FpdChjdHgtPmVwb2xsZmQsIGV2ZW50cywKLS0gCjIuMjQuMQoK


