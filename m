Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB93AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F5720684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INafv6E3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F5720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzcm-000207-Rk
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iZzZ1-0006ko-4I
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iZzYz-0001kj-7z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iZzYy-0001kH-GW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574869747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F+sRT08xI0DgTWOHKpVZIo4KNrtxWrizu/wCM33a8W4=;
 b=INafv6E3chutwO5D2JQiZ8nKqHjd/4vwfw6UMO4s6wXadxq4NagaIPSxp+x0t2ingfGdVw
 M0yTyDZAK4xHbqE4kdp9wsXkKylsoGHim88ZoI3065Oob9SPIRH6yEy29wOv+T9W2yZNfF
 l5CfSdGztviQy452Uc9GxpmBMOCX1N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Qkj3jAXvNPauElYJ5phUwQ-1; Wed, 27 Nov 2019 10:49:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4A8112CAC08;
 Wed, 27 Nov 2019 15:49:03 +0000 (UTC)
Received: from thuth.com (ovpn-117-186.ams2.redhat.com [10.36.117.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8F9B1001DE1;
 Wed, 27 Nov 2019 15:48:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH] travis.yml: Run tcg tests with tci
Date: Wed, 27 Nov 2019 16:48:57 +0100
Message-Id: <20191127154857.3590-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Qkj3jAXvNPauElYJ5phUwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far we only have compile coverage for tci. But since commit
2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
for INDEX_op_ld16u_i64") has been included, we can also run the
x86 TCG tests with tci, so let's enable them in Travis now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c09b6a0014..b0b634d484 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -218,7 +218,7 @@ matrix:
     # We manually include builds which we disable "make check" for
     - env:
         - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
-        - TEST_CMD=3D""
+        - TEST_CMD=3D"make run-tcg-tests-x86_64-softmmu V=3D1"
=20
=20
     # We don't need to exercise every backend with every front-end
--=20
2.18.1


