Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96617C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 01:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E49206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 01:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="nyVhqIT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E49206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mforney.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXE5J-0000av-ST
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 21:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mforney@mforney.org>)
 id 1kXD1a-0007dF-Rf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 20:39:44 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mforney@mforney.org>)
 id 1kXD1W-0008EG-HM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 20:39:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id f38so7040533pgm.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mforney-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4YLNaLLNgtQnOYBKMl4SRnafFnXBnDW9fs6MMtIQGek=;
 b=nyVhqIT5PqyFDa9p1uWfyQZohFgTKIdGWc7f6g88XNInACqrXWLt+Zz/SfOVSClcUU
 HyBirlVSKvAhyxkVw7qF0q46sjO4GJsCErvt3i9JOpAPZJMHie6p5InBhiAxznu7WWQl
 aFwgCPObMXSikZ4HegSVAhZe80qJnMkkAAy78gduUXRoA4mVlEjlH6e4Di/VePxUqAkt
 GjWV0mh8u+e+DSonVDyne6MNhhAaaCZ4r2RmKc9I8qUn+EexlJzjaLNZ3ZkW/tYMbNOL
 MpVn1gfEN7gQ/Z2G7T9IuymilMj0HGTOB8hbXYIIBK4uSAoJQ8aQUp/iST849jO9SZhM
 zgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4YLNaLLNgtQnOYBKMl4SRnafFnXBnDW9fs6MMtIQGek=;
 b=n3u8hYjl6k3FEHhv+p8A1TF8dr60bPr3BVhuX33LBqMlwKIly8mxj28HDSPjOVK/C1
 5YPRPoZqTgcJVV0C90QsUzw+4vcF/Y/W/Yx/0s4ls/X3dkum86NGyWFHtzeS7hcvemXI
 TKAq3IrWWWnOS0MgN7wI7SIBj6ni3ar8nXToNj4atwikjKUQVRLUfq62weFOhm9VxrBS
 E36ervJ0HTxuIjKtdD78wrng24c60MP4bYGaOwlR+CED3KTGybkJD8+epSnZZsrrZ+JH
 P5EhQhXHYo8oLPj/ZSOH/8Q4p9K3DZ3tBRhBq4urNpBUbFnKE19000qyUPhO2Vsu6PdG
 eg/g==
X-Gm-Message-State: AOAM530BNe2OHnuNOuqqFXWiOwW9af9x+Ol5HGSNn39npjKCa46kZXo1
 BEdeoikLgcpMaanLflFTbzpylZ8Yc3hTy4Sac/E=
X-Google-Smtp-Source: ABdhPJxv3xORedXY1rKJOkEglq+w2ATAGjv4pr3Iyjia/ojf94gYModuopqA/Uj9Hx5ncgW6oFgMIw==
X-Received: by 2002:a62:ab0e:0:b029:164:1790:a11b with SMTP id
 p14-20020a62ab0e0000b02901641790a11bmr275164pff.73.1603759174453; 
 Mon, 26 Oct 2020 17:39:34 -0700 (PDT)
Received: from localhost ([2601:647:5180:4570:16dd:a9ff:fee7:6b79])
 by smtp.gmail.com with ESMTPSA id o22sm7810495pgb.83.2020.10.26.17.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2020 17:39:33 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] osdep.h: Remove <sys/signal.h> include
Date: Mon, 26 Oct 2020 17:38:48 -0700
Message-Id: <20201027003848.10920-1-mforney@mforney.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=mforney@mforney.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2020 21:45:19 -0400
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

Prior to 2a4b472c3c, sys/signal.h was only included on OpenBSD
(apart from two .c files). The POSIX standard location for this
header is just <signal.h> and in fact, OpenBSD's signal.h includes
sys/signal.h itself.

Unconditionally including <sys/signal.h> on musl causes warnings
for just about every source file:

  /usr/include/sys/signal.h:1:2: warning: #warning redirecting incorrect #include <sys/signal.h> to <signal.h> [-Wcpp]
      1 | #warning redirecting incorrect #include <sys/signal.h> to <signal.h>
        |  ^~~~~~~

Since there don't seem to be any platforms which require including
<sys/signal.h> in addition to <signal.h>, and some platforms like
Haiku lack it completely, just remove it.

Tested building on OpenBSD after removing this include.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 configure            | 10 ----------
 include/qemu/osdep.h |  4 ----
 2 files changed, 14 deletions(-)

diff --git a/configure b/configure
index 55e07c82dd..7b57456052 100755
--- a/configure
+++ b/configure
@@ -3095,13 +3095,6 @@ if check_include "libdrm/drm.h" ; then
     have_drm_h=yes
 fi
 
-#########################################
-# sys/signal.h check
-have_sys_signal_h=no
-if check_include "sys/signal.h" ; then
-  have_sys_signal_h=yes
-fi
-
 ##########################################
 # VTE probe
 
@@ -6182,9 +6175,6 @@ fi
 if test "$have_openpty" = "yes" ; then
     echo "HAVE_OPENPTY=y" >> $config_host_mak
 fi
-if test "$have_sys_signal_h" = "yes" ; then
-    echo "HAVE_SYS_SIGNAL_H=y" >> $config_host_mak
-fi
 
 # Work around a system header bug with some kernel/XFS header
 # versions where they both try to define 'struct fsxattr':
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f9ec8c84e9..a434382c58 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -104,10 +104,6 @@ extern int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
-#ifdef HAVE_SYS_SIGNAL_H
-#include <sys/signal.h>
-#endif
-
 #ifndef _WIN32
 #include <sys/wait.h>
 #else
-- 
2.29.0


