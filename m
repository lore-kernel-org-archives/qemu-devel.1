Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D67FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D520207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNBJUPod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D520207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmST-0000Xo-EV
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35972)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3VUinXQYKCnYmUgYcXaiiafY.WigkYgo-XYpYfhihaho.ila@flex--sameid.bounces.google.com>)
 id 1iKmN5-0003xf-Qq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3VUinXQYKCnYmUgYcXaiiafY.WigkYgo-XYpYfhihaho.ila@flex--sameid.bounces.google.com>)
 id 1iKmN4-00064y-OV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:41:59 -0400
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749]:39272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3VUinXQYKCnYmUgYcXaiiafY.WigkYgo-XYpYfhihaho.ila@flex--sameid.bounces.google.com>)
 id 1iKmN4-00064m-Jp
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:41:58 -0400
Received: by mail-qk1-x749.google.com with SMTP id s3so24307864qkd.6
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=tUHo9dKXhyv0Ca4PFpuClHGZsVjvVcITsBogQiKTl7s=;
 b=kNBJUPodP1ll0Cd/UCphX2etrl1SP/5V6r5bAQSM2+1v2kJnSqu8f+qx8xKv6NgYYn
 u4cV8AobEIK1Sl/6i4jPmd+zfWUwNgjygvl3PoxxE/n4355ShxaaimVSE53yhKHUGUAe
 aRIYfYBwEuUvfkq00Z780jRQ3hKQhL3rrAlg2pM+7fPCdU8gNYmz+qLl94DsdyFx7Ytg
 12C743Laps1WJs+QMy3d19PbZJzpqnJfCLuUnFg17AMizBV8Kh9lKCgyUQr2ZPw1DYfq
 rkiQQTGMGcMh/afZM6/8OR912ThVfVjywFQ6qvEHTuR2Nnng7v10jT3JWReqZ1sNVf1z
 cvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=tUHo9dKXhyv0Ca4PFpuClHGZsVjvVcITsBogQiKTl7s=;
 b=O3DkoPmMzPrvwbW979up3Ln4OPIyd92A9GWDlBmwkUXC7T5pR3s1Fjikzt/FQ9yE61
 7vOTeztJNSJFsEDFQShbrqye+zkEZmN+gwhS0d0c1pCbbBGon4J08djq14n1cr3b3Ezm
 Bc1Vc8hdrSLPfCt0l1ZWZQOHg6WTPWbbnkwJMYVpD73a5hLjzI+h0cNQHmWRQxp7E7uD
 U5YfTzTcHUzmi+0HRk9PCWLL5lJB1gZUzVgJsTcYdS/tdR2orhzY+Gy000uW/G81KqQc
 yxPq7x34GrIYPMwRJBKAOZx2+x/3cJ6fJYYjSdbCMrkVXawk1pVpVeU7WVrX62Wna04P
 w1kA==
X-Gm-Message-State: APjAAAXSQqJ6aaE7yLVQHlrtTGk67qhtwUCWswacuCf6NBIkWGyZwyOg
 RKmTlF0eD2M81YmPWQwnGl7L2kz+itoPw76xzXJKBgMJ2iavqMdT3s3Csw3yPjog88CWsgsRKkT
 SiNu8AX8By048j3cGRFTINpC79utZOnruo3WJmTgBqwNE1JYES8TZtNmSVyKW
X-Google-Smtp-Source: APXvYqyksGp04TrBS5lTnT45E90skoPTjfr50ZI/PWPT6OSBog2AJR1+uoxuyR2fkqMDK0tQG7xj4lCQqX8=
X-Received: by 2002:a05:620a:342:: with SMTP id
 t2mr41444675qkm.251.1571244117573; 
 Wed, 16 Oct 2019 09:41:57 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:37 +0300
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Message-Id: <20191016164145.115898-2-sameid@google.com>
Mime-Version: 1.0
References: <20191016164145.115898-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 1/8] block: Refactor macros - fix tabbing
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com, 
 Sam Eiderman <shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::749
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Fixing tabbing in block related macros.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
---
 hw/ide/qdev.c            |  2 +-
 include/hw/block/block.h | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 6fba6b62b8..6dd219944f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -290,7 +290,7 @@ static void ide_drive_realize(IDEDevice *dev, Error **e=
rrp)
     DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
     DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
     DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
-    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),    \
+    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
     DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
     DEFINE_PROP_STRING("model", IDEDrive, dev.model)
=20
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 607539057a..fd55a30bca 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -50,21 +50,21 @@ static inline unsigned int get_physical_block_exp(Block=
Conf *conf)
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
=20
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
     DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
=20
-#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
-    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
-    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
+#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
+    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
+    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
     DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
=20
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
--=20
2.23.0.700.g56cf767bdb-goog


