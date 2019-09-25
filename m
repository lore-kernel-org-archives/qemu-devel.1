Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317AC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35AC2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qv8uaaQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35AC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5Ak-0001bJ-Gy
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44769)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3R0qLXQYKCvoucogkfiqqing.eqosgow-fgxgnpqpipw.qti@flex--sameid.bounces.google.com>)
 id 1iD58F-0007kI-SS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3R0qLXQYKCvoucogkfiqqing.eqosgow-fgxgnpqpipw.qti@flex--sameid.bounces.google.com>)
 id 1iD58E-0004Kh-OT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:51 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a]:36272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3R0qLXQYKCvoucogkfiqqing.eqosgow-fgxgnpqpipw.qti@flex--sameid.bounces.google.com>)
 id 1iD58E-0004Ic-IF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:50 -0400
Received: by mail-wm1-x34a.google.com with SMTP id k184so1941700wmk.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=GKWNqiYwVrsn0putnRnrghN5ULrhO4lIMes6GImbrWQ=;
 b=qv8uaaQ2HAdNlrWSNmuGHrSyNvLRnBKqOU4VlQDxSQtILzBVYxEA+HVjLYXhGLWLQF
 DzblVQXyj1jsEa5mj+ZSU4HWVyqZNtBuSq1tZrRTf2tkMuXDxQpBkA6jUMefOF1h6Ptq
 JWzQ3qk/C3U0iSqtB/i9n1fpcbbaA9j9hoo1ARnRud2SdW7KJr6o89F0FmCaI+r7MeP4
 UXtqx/hOcvdJdJhLOcAEP8Ge0kWdYVR22G2bew3kuFOfT4wcl+YoUw1SsaBvxPzKCw2J
 xILthFEQJMDqwVfeHAxLz447h2z9KHprcOpgvr4koqGljor19ptyC/8owthY08JUTI9r
 aKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GKWNqiYwVrsn0putnRnrghN5ULrhO4lIMes6GImbrWQ=;
 b=WQ3l2vYtO9HfK0uA4eO4eEnJs/KuAwo1Aak88Ew3OQ7qQExkkNz8/ddawIhiHcY5Ls
 s4C7N0f1iy597LnfSEKAJkbiiVwwugr3Ve4IkU3t0np4KxUYIJw6IidurK5PW8b0qb1d
 cvp9yf2awynWh2/mTSFVUX5ATgjVUfgnlE1OVMZDJBWSp2SP/sHHqWkGgpZrPxlQrV1/
 Bbg02VT+Cb32oONvDK5OdaY8P2MdCWJabiX0s0Q2KnAHV8vaY845IMyebCaXrIaeV1qH
 ajfheU6EW7mTX29B2GO3zxqfCjEjmc0uZq2vc+a4Y5GFNNeipwyotJ1w8hMF6GGGk3pL
 NgKQ==
X-Gm-Message-State: APjAAAW4IpB6F35xQE5X2BaOiUU39vm58grkAYb6eGobWtm2QO2kQg6G
 fX0pQ7zH5TOSnMw18tFx2NWWP7LVNas5jBXtd/4ewzEUrjWYxhlMBiftbX56SAkOyXqvH7HsmBr
 sh3MFiwJjWSbL3mNYyM8a40UCWcBRUKiZhm6SVJviuOURpQLXO+qAh3cj2EqY
X-Google-Smtp-Source: APXvYqzFtaLuUeiiTrWsNy1fSb8dotL3CjrEb7LFgBfYrQaoJuzmCVsDNs+5hXOSvYxm8rBzntACvWaqrgE=
X-Received: by 2002:adf:eb42:: with SMTP id u2mr8730661wrn.307.1569409607592; 
 Wed, 25 Sep 2019 04:06:47 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:32 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-2-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 1/8] block: Refactor macros - fix tabbing
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::34a
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kevin@koconnor.net, liran.alon@oracle.com,
 kraxel@redhat.com, Sam Eiderman <shmuel.eiderman@oracle.com>,
 sameid@google.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Sam Eiderman <sameid@google.com>
From: Sam Eiderman via <qemu-devel@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Fixing tabbing in block related macros.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 hw/ide/qdev.c            |  2 +-
 include/hw/block/block.h | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..6dd219944f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -290,7 +290,7 @@ static void ide_drive_realize(IDEDevice *dev, Error **errp)
     DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
     DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
     DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),    \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
     DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
     DEFINE_PROP_STRING("model", IDEDrive, dev.model)
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..fd55a30bca 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -50,21 +50,21 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                           _conf.logical_block_size),                    \
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
                           _conf.physical_block_size),                   \
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  \
+    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
-    DEFINE_PROP_UINT32("discard_granularity", _state, \
-                       _conf.discard_granularity, -1), \
-    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, \
-                            ON_OFF_AUTO_AUTO), \
+    DEFINE_PROP_UINT32("discard_granularity", _state,                   \
+                       _conf.discard_granularity, -1),                  \
+    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,           \
+                            ON_OFF_AUTO_AUTO),                          \
     DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
     DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
 
-#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
-    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
-    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
+#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
+    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
+    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
     DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
 
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
-- 
2.23.0.351.gc4317032e6-goog


