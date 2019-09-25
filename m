Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CDDC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E21221D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YFyIaGWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E21221D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5FU-00074N-67
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44795)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3S0qLXQYKCv4ygskojmuumrk.iuswks0-jk1krtutmt0.uxm@flex--sameid.bounces.google.com>)
 id 1iD58I-0007ou-5H
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3S0qLXQYKCv4ygskojmuumrk.iuswks0-jk1krtutmt0.uxm@flex--sameid.bounces.google.com>)
 id 1iD58H-0004NG-5l
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:54 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449]:34750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3S0qLXQYKCv4ygskojmuumrk.iuswks0-jk1krtutmt0.uxm@flex--sameid.bounces.google.com>)
 id 1iD58H-0004Ma-0d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:06:53 -0400
Received: by mail-wr1-x449.google.com with SMTP id j2so2187942wre.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wQfLQEhmK8gGTLXrGitPL7fj5j2zg1DshrzOt/Wj1N8=;
 b=YFyIaGWXPT8GzhIgXk+7H8kjpGkg6WzlWq0c6P359HSXyTuZbcRYM2QRT79snxqqST
 BIhwrE+QoZR6xpFcc19J9ry2QrIqmBGq/8X/G2fR2KGsUSJY6Ezh+41fLm0N2P4870lr
 65UqFC0cZ70dvEGlg2CfQJDzxsng/NweY4hAkkJJXkb2SZbQJQbSdfOFvfsu07jvb8G1
 KWbPmbN25Uzh5bl0TPZ5fcmXprMU6eIZpn/dOJH59J0zDbcqytE+dY3TOTC3Mda7+ife
 jxWWkREdYctczyl4GtvlvmagCqhP5TlnewB1JPY5cdLmF9qk1dKD0dVbf16jt4dQOtAp
 ZayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wQfLQEhmK8gGTLXrGitPL7fj5j2zg1DshrzOt/Wj1N8=;
 b=c9akByEI6nVE2XlMhwBYMX972HtY3wuVQnRS6V1XoEgzIzxyMrA3SM924o47Vs2SYF
 TDzmxk6KfrLsdWHQ12FvJbINUCH70ZgqigodQNk1rt8+/iPV7AmLNZZnLMmB3qMX2JAL
 EFgY9/YabGuyMx6rY9Na/u27z5sreitBRnNNtwhPjYx424iNhMXDKfBxNrxDePLvnU4d
 RSzzg4PeRvx4p6rYzxUhcreG6jYsEtdmb4+jqXuc3DtZUvQLivIpLaLyA5mPQM5zYebE
 zJe/KKQVo24oNIwI0nZU2LpEGJGI6t7GXQSuXo26MvRzPNNUz1A1ndJ/vLgLQJqla0Rl
 0RyA==
X-Gm-Message-State: APjAAAXX1HATLDka/4U0Uq/iMpnHx6x/1kK54q1maIHfxpKX1Z/9r3p9
 vqIjhUdO9+3v6e1mk7iK1svLjeg7mIBpEc1vcoqT7kR9hsGogIzdM+l5bKTZBGaZ1aqzPcWiaHF
 hzMSTzpEQnc570M4jkIqWgbVumD6rwV6p2JGGdzjMAbU5h5Iiimv3tuWf+Dpa
X-Google-Smtp-Source: APXvYqwbiy5AcLGpgpOvEX+dSWV45Mq2I7MVpTEbdcZtR6LvUmPTYcrxWYConl0V1VXmAAR5EJ1SPBuLODU=
X-Received: by 2002:a5d:4742:: with SMTP id o2mr8365092wrs.253.1569409611655; 
 Wed, 25 Sep 2019 04:06:51 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:33 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-3-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 2/8] block: Support providing LCHS from user
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::449
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

Add logical geometry variables to BlockConf.

A user can now supply "lcyls", "lheads" & "lsecs" for any HD device
that supports CHS ("cyls", "heads", "secs").

These devices include:
    * ide-hd
    * scsi-hd
    * virtio-blk-pci

In future commits we will use the provided LCHS and pass it to the BIOS
through fw_cfg to be supplied using INT13 routines.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 include/hw/block/block.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index fd55a30bca..d7246f3862 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -26,6 +26,7 @@ typedef struct BlockConf {
     uint32_t discard_granularity;
     /* geometry, not all devices use this */
     uint32_t cyls, heads, secs;
+    uint32_t lcyls, lheads, lsecs;
     OnOffAuto wce;
     bool share_rw;
     BlockdevOnError rerror;
@@ -65,7 +66,10 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
     DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
     DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
-    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
+    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0),                  \
+    DEFINE_PROP_UINT32("lcyls", _state, _conf.lcyls, 0),                \
+    DEFINE_PROP_UINT32("lheads", _state, _conf.lheads, 0),              \
+    DEFINE_PROP_UINT32("lsecs", _state, _conf.lsecs, 0)
 
 #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                    \
     DEFINE_PROP_BLOCKDEV_ON_ERROR("rerror", _state, _conf.rerror,       \
-- 
2.23.0.351.gc4317032e6-goog


