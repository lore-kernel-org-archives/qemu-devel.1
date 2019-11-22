Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC36EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A452068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dereferenced-org.20150623.gappssmtp.com header.i=@dereferenced-org.20150623.gappssmtp.com header.b="ymG08q2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A452068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dereferenced.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDaX-0008It-FV
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ariadne@dereferenced.org>) id 1iYCvP-0003Nz-99
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ariadne@dereferenced.org>) id 1iYCvN-00068C-Q1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:40:55 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ariadne@dereferenced.org>)
 id 1iYCvN-000688-5D
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:40:53 -0500
Received: by mail-yw1-xc44.google.com with SMTP id 4so2275847ywx.4
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 09:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i4GRKRFk7JjeMiYHWnt/tzXmlrhglXvP499/mIPKDO8=;
 b=ymG08q2s92GJQpxntqH3pO7Ymcr0ORwTdL2LmGumjHhXLA/UtGItlz/oH5KXTtyjck
 dXGm7e1PCiiX8j9Wx98xA3MzOtcjYuy4wV6BKtwAnVQ2i2TdAY81pwEGToX+uCJjcBJD
 0cOVukhPS8auTdQa0mYXj0SLNflRzFMirNEypkXm9qWtSqWBAviI8qXdZGr3hkGRD8wU
 0Fbkpbj+QbkF0OqRfS3J/6xWhaa/mfrnG6Hq9OZQsJ9Pw8pb0SVJtQ1mF8GTQBEWDtG5
 qa216iTQb7nw0XXH7fJMd9+hD/HEls8ffJO+2KGyJL17Gs23Q3utEhinDX29tt7x5jx/
 57SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i4GRKRFk7JjeMiYHWnt/tzXmlrhglXvP499/mIPKDO8=;
 b=L0n/ZliYbMK3vwxEaJu+7ynYf5YtEuY1y2h13YkjtITKwvlrzK7ZvF2JwCf1JpkETi
 TVPH1CU+8DUPAEYsYAi/FqRaEDNZuI/HZJHgukHHCGq1LbiJDn0irkFiR/xbuNzh6n3d
 PNGiycXDkpPK+beeO13f30zWI17eP3Yk8G4u7zwa7K53nRHS6CzrpZINvyUlc3BXvKNP
 Xffr2LFTdiCQfgPvYtJGlxvvCD6WtJMgFzdnrjy/ufGy0u0xGR2II3UQDsNxrn1lYL7h
 m96SO+XZrrC3q54fcggaBKtmJddXm/oi+aGr0qFSTbQ9qKk1bcfXQlmJW6xV1rLwHZtj
 M9vA==
X-Gm-Message-State: APjAAAVAedFEnRYZlDbq5Xq6kdcGYTKrYXoooxTIBB1HSb8yhXUcJ5HS
 f2pLb1Caacswxg5YQ2a7iXuKnA==
X-Google-Smtp-Source: APXvYqxfcuPKDSFR2TwJq5I6BK56EkbKHqshzNEJyBOSIwLlExXF3PUyXD7uj3w/tS2e+rtg+/F5Ww==
X-Received: by 2002:a81:38c4:: with SMTP id f187mr2424431ywa.479.1574444452277; 
 Fri, 22 Nov 2019 09:40:52 -0800 (PST)
Received: from localhost.localdomain ([2600:1:918b:c6b0:e264:9cd8:2711:d89f])
 by smtp.gmail.com with ESMTPSA id
 q131sm1783118ywh.22.2019.11.22.09.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 09:40:51 -0800 (PST)
From: Ariadne Conill <ariadne@dereferenced.org>
To: riku.voipio@iki.fi,
	laurent@vivier.eu
Subject: [PATCH] linux-user: fix translation of statx structures
Date: Fri, 22 Nov 2019 11:40:40 -0600
Message-Id: <20191122174040.569252-1-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
X-Mailman-Approved-At: Fri, 22 Nov 2019 13:19:31 -0500
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
Cc: qemu-devel@nongnu.org, Ariadne Conill <ariadne@dereferenced.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All timestamps were copied to atime instead of to their respective
fields.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 linux-user/syscall.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ce399a55f0..171c0caef3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6743,12 +6743,12 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
     __put_user(host_stx->stx_attributes_mask, &target_stx->stx_attributes_mask);
     __put_user(host_stx->stx_atime.tv_sec, &target_stx->stx_atime.tv_sec);
     __put_user(host_stx->stx_atime.tv_nsec, &target_stx->stx_atime.tv_nsec);
-    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_atime.tv_sec);
-    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_atime.tv_nsec);
-    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_atime.tv_sec);
-    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_atime.tv_nsec);
-    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_atime.tv_sec);
-    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_atime.tv_nsec);
+    __put_user(host_stx->stx_btime.tv_sec, &target_stx->stx_btime.tv_sec);
+    __put_user(host_stx->stx_btime.tv_nsec, &target_stx->stx_btime.tv_nsec);
+    __put_user(host_stx->stx_ctime.tv_sec, &target_stx->stx_ctime.tv_sec);
+    __put_user(host_stx->stx_ctime.tv_nsec, &target_stx->stx_ctime.tv_nsec);
+    __put_user(host_stx->stx_mtime.tv_sec, &target_stx->stx_mtime.tv_sec);
+    __put_user(host_stx->stx_mtime.tv_nsec, &target_stx->stx_mtime.tv_nsec);
     __put_user(host_stx->stx_rdev_major, &target_stx->stx_rdev_major);
     __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
     __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
-- 
2.24.0


