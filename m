Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E485CC55194
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 22:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7ECF2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 22:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dottedmag.net header.i=@dottedmag.net header.b="PeZEBz7+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkWyZJMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7ECF2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dottedmag.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSpc9-0006sk-Ql
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 18:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dottedmag@dottedmag.net>) id 1jSoZf-0000Bi-QQ
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dottedmag@dottedmag.net>) id 1jSoZf-00061a-4M
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:12:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dottedmag@dottedmag.net>)
 id 1jSoZe-00061P-GD; Sun, 26 Apr 2020 17:12:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id D11FC5C0118;
 Sun, 26 Apr 2020 17:12:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 26 Apr 2020 17:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dottedmag.net;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=zgV7/9k3Hto6rUVeJ6s8ZLt/qf
 Ekaj7t1R0wnIL3X6o=; b=PeZEBz7+eJbhoBUDGw9nt13MTe6nMKvZ2hxgCNRYfL
 Y7is5YTkSymjYSYwWcmiz5s3zeJuFGu3/xccky738FMhjGHD0WjF1M4lhrU1PpDn
 RnuK8sR8USmeLsayBjMpowYavI/NX0vJxOflwwGV2NqgcYLZ7aFpWe6fT9lT5bFl
 gPsN+SZCFJmG0pNFqPHJ0479f20NyE8FWlQGJIo/uNXcGRV9JzSJHgy+Fh4ZWQTF
 F344rF9Em6T6sUbktWra53duMGA9E3/j5sKZa8NVMaxywg0PcpGODKCLE5jCkQ11
 L6iL+ELZ2kgtOF1GEoOHreAzQwbeU6d/IM1GyPtgD4KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zgV7/9k3Hto6rUVeJ
 6s8ZLt/qfEkaj7t1R0wnIL3X6o=; b=mkWyZJMQhA9Xzp9PlXDax5ssqYKu3jkAC
 QNPDoMD7U/qyLLInkOlTWYC5un7hmEF1yJyEz1AfHh/zzszM3esdujoSSBjovXAc
 CrYwmIBAizCYjTEyyE3kyzfNZvorSwbaa/3Ag709aM5vIlnLGSfozSjk2sKagsX0
 z619rrCnU9GXgAFkVZCNnBJeUHec5eIMaaQe/Lco9aAKGoKDK7gGlXx2ZFocfYMA
 g5oDPD+d00o/GUiTeswIUAfEzXZz1IEcMeaAB4Cr1/Rr+wjCiUdfU65Oh56klnYQ
 nzDxP0nG0OIlU5TdplGHz14Qfz+ThrBtZX1Hlz5/yA2WfzDe7BJWw==
X-ME-Sender: <xms:N_mlXsmhcShj0Rv8CKKE8FmBZrdqB-6nA3Rqvtpn5kdo3cljtsKF4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdduheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomhepofhikhhhrghilhcuifhushgrrhhovhcuoeguohhtthgvughmrghg
 seguohhtthgvughmrghgrdhnvghtqeenucfkphepledvrddvhedurdefgedrvddvkeenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguohhtthgv
 ughmrghgseguohhtthgvughmrghgrdhnvght
X-ME-Proxy: <xmx:N_mlXtZ0D4x3Q0oXR_H3sK4N8jwmuoXpNzY8-6m9SIq1OLKJqaY7Kw>
 <xmx:N_mlXg_qoEaUCYaAw23ZDPeEYaHUxcNGMDIZtVrOblxZYoCdoe4YFw>
 <xmx:N_mlXkZbR-CBSG-CM24d51GYXyHEJ9afbhmVxq0ZBQEjGu3AL26Epw>
 <xmx:N_mlXnE5qU_NvmRTytefv_tplM4yLGsUa8Zp-aZV0sM5Du8Tq34LOA>
Received: from newton.malta.dottedmag.net (c34-228.i07-9.onvol.net
 [92.251.34.228])
 by mail.messagingengine.com (Postfix) with ESMTPA id 566AE3280067;
 Sun, 26 Apr 2020 17:12:23 -0400 (EDT)
Received: by newton.malta.dottedmag.net (Postfix, from userid 501)
 id 2654F2CE1CF5; Sun, 26 Apr 2020 23:12:20 +0200 (CEST)
From: Mikhail Gusarov <dottedmag@dottedmag.net>
To: qemu-devel@nongnu.org
Subject: [PATCH] chardev: Add macOS to list of OSes that support -chardev
 serial
Date: Sun, 26 Apr 2020 23:09:58 +0200
Message-Id: <20200426210956.17324-1-dottedmag@dottedmag.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=dottedmag@dottedmag.net;
 helo=out1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 17:12:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 66.111.4.25
X-Mailman-Approved-At: Sun, 26 Apr 2020 18:16:21 -0400
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
Cc: qemu-trivial@nongnu.org, Mikhail Gusarov <dottedmag@dottedmag.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

macOS API for dealing with serial ports/ttys is identical to BSDs.

Signed-off-by: Mikhail Gusarov <dottedmag@dottedmag.net>
---

Note that the same file has a line
> #endif /* linux || sun */
that is severely out of date.

 chardev/char-serial.c | 2 +-
 include/qemu/osdep.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 5b833ea077..7c3d84ae24 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -53,7 +53,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
 
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)      \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
-    || defined(__GLIBC__)
+    || defined(__GLIBC__) || defined(__APPLE__)
 
 static void tty_serial_init(int fd, int speed,
                             int parity, int data_bits, int stop_bits)
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 20f5c5f197..ff7c17b857 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -379,7 +379,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define HAVE_CHARDEV_SERIAL 1
 #elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
-    || defined(__GLIBC__)
+    || defined(__GLIBC__) || defined(__APPLE__)
 #define HAVE_CHARDEV_SERIAL 1
 #endif
 
-- 
2.19.1


