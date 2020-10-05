Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9EAC4727E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650BE20795
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMLXNoJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650BE20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLtK-00074F-9a
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmr-00084n-AM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPLmo-0007Js-Oe
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:24:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id t17so7812728wmi.4
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d/6w7cwNeEMUJTL0K6G7lo4Y3Xqu1aQim4LACNPfDLU=;
 b=nMLXNoJ2iA8T4Zzzs+hlLES2bV6BdwJedTrpZ9jc8YF0ngSgnxqZ6ZQB1h5z8qp7w5
 Y2YRQUeyrRV69IkeBmvCHasjKcy2LHtsv3b72gVaW/5+g+SwEtAKh6Adb/0QwCY67ReP
 NH5lWH5c2+Nh45ccW4ab/o1R5ppISM4Lbkge6NKk+ztQmDg5115VLqnlgklUM5zb4YY1
 jaKvtrY+ogx2g3d3adqEiSYhPNFFZuqJ0DmVAiJpt4KGylMj8gJtH4U2fW37kTHZyBaS
 5iPLr1Qmt6DEaXevJVDbbGtqZqKZt4FzsbRGr3naCT4AV4qvFrJVFI8OtDrkPY6mDaWp
 I7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=d/6w7cwNeEMUJTL0K6G7lo4Y3Xqu1aQim4LACNPfDLU=;
 b=YZJhUqsOmhoftv5jydAN6SAsRENCMRn2mJ+4qObjbNCyrGmg2E1sRupZ46kYeYELv1
 h7HO34k2LBT3myv7oU+5HFx4vAfBFg+2tpiiiSq3AaRsLbZOhMXjxxxAS8SXvyc0UE+x
 eJG8jTOqmh6VOL/jyM4Mhusqr5qk1DG/eINnFKVwQ0gQV/2yBfenqOBHxdHvynzIdUK1
 blvZSG+SC0p9tENE6WaviDAqN4vy4i83rbrDN5GQXMcWBQzy+0/NmzJooio14ubRNsPn
 7UOW7ETkz31w2XT4hwO9upAkshqX4Rf59fSSmeGzs1haLL0PcSnlkdzqL4K6B9MPRXsD
 aI/w==
X-Gm-Message-State: AOAM5317OXn0g5Y/LNyv1pqFmHz/VZZ5NWDpYj5DtBjUxkZIRLhHy5V3
 Uqj4W+PBieoYjwYapasHLnU332QCgoI=
X-Google-Smtp-Source: ABdhPJxGwWO1kPiPLRbsu5gZway8Vbk4H91EUdFbNmWZ5dHazsept8FYSCftw4GIc8KTJKQ7hH7g5g==
X-Received: by 2002:a1c:3283:: with SMTP id y125mr802048wmy.61.1601886236802; 
 Mon, 05 Oct 2020 01:23:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id z15sm11931434wrv.94.2020.10.05.01.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:23:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] default-configs: remove default-configs/devices for
 user-mode targets
Date: Mon,  5 Oct 2020 10:23:40 +0200
Message-Id: <20201005082349.354095-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005082349.354095-1-pbonzini@redhat.com>
References: <20201005082349.354095-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer need dummy files to detect targets, since
default-configs/targets/ exists.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                           | 6 +++---
 default-configs/devices/aarch64-linux-user.mak      | 1 -
 default-configs/devices/aarch64_be-linux-user.mak   | 1 -
 default-configs/devices/alpha-linux-user.mak        | 1 -
 default-configs/devices/arm-linux-user.mak          | 1 -
 default-configs/devices/armeb-linux-user.mak        | 1 -
 default-configs/devices/cris-linux-user.mak         | 1 -
 default-configs/devices/hppa-linux-user.mak         | 1 -
 default-configs/devices/i386-bsd-user.mak           | 1 -
 default-configs/devices/i386-linux-user.mak         | 1 -
 default-configs/devices/m68k-linux-user.mak         | 1 -
 default-configs/devices/microblaze-linux-user.mak   | 1 -
 default-configs/devices/microblazeel-linux-user.mak | 1 -
 default-configs/devices/mips-linux-user.mak         | 1 -
 default-configs/devices/mips64-linux-user.mak       | 1 -
 default-configs/devices/mips64el-linux-user.mak     | 1 -
 default-configs/devices/mipsel-linux-user.mak       | 1 -
 default-configs/devices/mipsn32-linux-user.mak      | 1 -
 default-configs/devices/mipsn32el-linux-user.mak    | 1 -
 default-configs/devices/nios2-linux-user.mak        | 1 -
 default-configs/devices/or1k-linux-user.mak         | 1 -
 default-configs/devices/ppc-linux-user.mak          | 1 -
 default-configs/devices/ppc64-linux-user.mak        | 1 -
 default-configs/devices/ppc64abi32-linux-user.mak   | 1 -
 default-configs/devices/ppc64le-linux-user.mak      | 1 -
 default-configs/devices/riscv32-linux-user.mak      | 1 -
 default-configs/devices/riscv64-linux-user.mak      | 1 -
 default-configs/devices/s390x-linux-user.mak        | 1 -
 default-configs/devices/sh4-linux-user.mak          | 1 -
 default-configs/devices/sh4eb-linux-user.mak        | 1 -
 default-configs/devices/sparc-bsd-user.mak          | 1 -
 default-configs/devices/sparc-linux-user.mak        | 1 -
 default-configs/devices/sparc32plus-linux-user.mak  | 1 -
 default-configs/devices/sparc64-bsd-user.mak        | 1 -
 default-configs/devices/sparc64-linux-user.mak      | 1 -
 default-configs/devices/tilegx-linux-user.mak       | 1 -
 default-configs/devices/x86_64-bsd-user.mak         | 1 -
 default-configs/devices/x86_64-linux-user.mak       | 1 -
 default-configs/devices/xtensa-linux-user.mak       | 1 -
 default-configs/devices/xtensaeb-linux-user.mak     | 1 -
 40 files changed, 3 insertions(+), 42 deletions(-)
 delete mode 100644 default-configs/devices/aarch64-linux-user.mak
 delete mode 100644 default-configs/devices/aarch64_be-linux-user.mak
 delete mode 100644 default-configs/devices/alpha-linux-user.mak
 delete mode 100644 default-configs/devices/arm-linux-user.mak
 delete mode 100644 default-configs/devices/armeb-linux-user.mak
 delete mode 100644 default-configs/devices/cris-linux-user.mak
 delete mode 100644 default-configs/devices/hppa-linux-user.mak
 delete mode 100644 default-configs/devices/i386-bsd-user.mak
 delete mode 100644 default-configs/devices/i386-linux-user.mak
 delete mode 100644 default-configs/devices/m68k-linux-user.mak
 delete mode 100644 default-configs/devices/microblaze-linux-user.mak
 delete mode 100644 default-configs/devices/microblazeel-linux-user.mak
 delete mode 100644 default-configs/devices/mips-linux-user.mak
 delete mode 100644 default-configs/devices/mips64-linux-user.mak
 delete mode 100644 default-configs/devices/mips64el-linux-user.mak
 delete mode 100644 default-configs/devices/mipsel-linux-user.mak
 delete mode 100644 default-configs/devices/mipsn32-linux-user.mak
 delete mode 100644 default-configs/devices/mipsn32el-linux-user.mak
 delete mode 100644 default-configs/devices/nios2-linux-user.mak
 delete mode 100644 default-configs/devices/or1k-linux-user.mak
 delete mode 100644 default-configs/devices/ppc-linux-user.mak
 delete mode 100644 default-configs/devices/ppc64-linux-user.mak
 delete mode 100644 default-configs/devices/ppc64abi32-linux-user.mak
 delete mode 100644 default-configs/devices/ppc64le-linux-user.mak
 delete mode 100644 default-configs/devices/riscv32-linux-user.mak
 delete mode 100644 default-configs/devices/riscv64-linux-user.mak
 delete mode 100644 default-configs/devices/s390x-linux-user.mak
 delete mode 100644 default-configs/devices/sh4-linux-user.mak
 delete mode 100644 default-configs/devices/sh4eb-linux-user.mak
 delete mode 100644 default-configs/devices/sparc-bsd-user.mak
 delete mode 100644 default-configs/devices/sparc-linux-user.mak
 delete mode 100644 default-configs/devices/sparc32plus-linux-user.mak
 delete mode 100644 default-configs/devices/sparc64-bsd-user.mak
 delete mode 100644 default-configs/devices/sparc64-linux-user.mak
 delete mode 100644 default-configs/devices/tilegx-linux-user.mak
 delete mode 100644 default-configs/devices/x86_64-bsd-user.mak
 delete mode 100644 default-configs/devices/x86_64-linux-user.mak
 delete mode 100644 default-configs/devices/xtensa-linux-user.mak
 delete mode 100644 default-configs/devices/xtensaeb-linux-user.mak

diff --git a/configure b/configure
index a0701570d0..a32c43a905 100755
--- a/configure
+++ b/configure
@@ -1604,13 +1604,13 @@ deprecated_features=""
 mak_wilds=""
 
 if [ "$softmmu" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-softmmu.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/targets/*-softmmu.mak"
 fi
 if [ "$linux_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-linux-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/targets/*-linux-user.mak"
 fi
 if [ "$bsd_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/default-configs/devices/*-bsd-user.mak"
+    mak_wilds="${mak_wilds} $source_path/default-configs/targets/*-bsd-user.mak"
 fi
 
 # If the user doesn't explicitly specify a deprecated target we will
diff --git a/default-configs/devices/aarch64-linux-user.mak b/default-configs/devices/aarch64-linux-user.mak
deleted file mode 100644
index 0a5b08a007..0000000000
--- a/default-configs/devices/aarch64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for aarch64-linux-user
diff --git a/default-configs/devices/aarch64_be-linux-user.mak b/default-configs/devices/aarch64_be-linux-user.mak
deleted file mode 100644
index a69d9d2e41..0000000000
--- a/default-configs/devices/aarch64_be-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for aarch64_be-linux-user
diff --git a/default-configs/devices/alpha-linux-user.mak b/default-configs/devices/alpha-linux-user.mak
deleted file mode 100644
index 7956e29898..0000000000
--- a/default-configs/devices/alpha-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for alpha-linux-user
diff --git a/default-configs/devices/arm-linux-user.mak b/default-configs/devices/arm-linux-user.mak
deleted file mode 100644
index 413361a022..0000000000
--- a/default-configs/devices/arm-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for arm-linux-user
diff --git a/default-configs/devices/armeb-linux-user.mak b/default-configs/devices/armeb-linux-user.mak
deleted file mode 100644
index bf2ffe7038..0000000000
--- a/default-configs/devices/armeb-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for armeb-linux-user
diff --git a/default-configs/devices/cris-linux-user.mak b/default-configs/devices/cris-linux-user.mak
deleted file mode 100644
index e3aec7b864..0000000000
--- a/default-configs/devices/cris-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for cris-linux-user
diff --git a/default-configs/devices/hppa-linux-user.mak b/default-configs/devices/hppa-linux-user.mak
deleted file mode 100644
index 796393940b..0000000000
--- a/default-configs/devices/hppa-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for hppa-linux-user
diff --git a/default-configs/devices/i386-bsd-user.mak b/default-configs/devices/i386-bsd-user.mak
deleted file mode 100644
index af1b31a59a..0000000000
--- a/default-configs/devices/i386-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for i386-bsd-user
diff --git a/default-configs/devices/i386-linux-user.mak b/default-configs/devices/i386-linux-user.mak
deleted file mode 100644
index 8657e68627..0000000000
--- a/default-configs/devices/i386-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for i386-linux-user
diff --git a/default-configs/devices/m68k-linux-user.mak b/default-configs/devices/m68k-linux-user.mak
deleted file mode 100644
index 06cd5ed7ed..0000000000
--- a/default-configs/devices/m68k-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for m68k-linux-user
diff --git a/default-configs/devices/microblaze-linux-user.mak b/default-configs/devices/microblaze-linux-user.mak
deleted file mode 100644
index 566fdc01c4..0000000000
--- a/default-configs/devices/microblaze-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for microblaze-linux-user
diff --git a/default-configs/devices/microblazeel-linux-user.mak b/default-configs/devices/microblazeel-linux-user.mak
deleted file mode 100644
index 378c6ddcb0..0000000000
--- a/default-configs/devices/microblazeel-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for microblazeel-linux-user
diff --git a/default-configs/devices/mips-linux-user.mak b/default-configs/devices/mips-linux-user.mak
deleted file mode 100644
index 31df57021e..0000000000
--- a/default-configs/devices/mips-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mips-linux-user
diff --git a/default-configs/devices/mips64-linux-user.mak b/default-configs/devices/mips64-linux-user.mak
deleted file mode 100644
index 1598bfcf7d..0000000000
--- a/default-configs/devices/mips64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mips64-linux-user
diff --git a/default-configs/devices/mips64el-linux-user.mak b/default-configs/devices/mips64el-linux-user.mak
deleted file mode 100644
index 629f084086..0000000000
--- a/default-configs/devices/mips64el-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mips64el-linux-user
diff --git a/default-configs/devices/mipsel-linux-user.mak b/default-configs/devices/mipsel-linux-user.mak
deleted file mode 100644
index 4d0e4afb69..0000000000
--- a/default-configs/devices/mipsel-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mipsel-linux-user
diff --git a/default-configs/devices/mipsn32-linux-user.mak b/default-configs/devices/mipsn32-linux-user.mak
deleted file mode 100644
index 5b97919794..0000000000
--- a/default-configs/devices/mipsn32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mipsn32-linux-user
diff --git a/default-configs/devices/mipsn32el-linux-user.mak b/default-configs/devices/mipsn32el-linux-user.mak
deleted file mode 100644
index d6367ff987..0000000000
--- a/default-configs/devices/mipsn32el-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for mipsn32el-linux-user
diff --git a/default-configs/devices/nios2-linux-user.mak b/default-configs/devices/nios2-linux-user.mak
deleted file mode 100644
index 5be3eb795d..0000000000
--- a/default-configs/devices/nios2-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for nios2-linux-user
diff --git a/default-configs/devices/or1k-linux-user.mak b/default-configs/devices/or1k-linux-user.mak
deleted file mode 100644
index 20e03c1317..0000000000
--- a/default-configs/devices/or1k-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for or1k-linux-user
diff --git a/default-configs/devices/ppc-linux-user.mak b/default-configs/devices/ppc-linux-user.mak
deleted file mode 100644
index 6273df2930..0000000000
--- a/default-configs/devices/ppc-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc-linux-user
diff --git a/default-configs/devices/ppc64-linux-user.mak b/default-configs/devices/ppc64-linux-user.mak
deleted file mode 100644
index 422d3fbaeb..0000000000
--- a/default-configs/devices/ppc64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc64-linux-user
diff --git a/default-configs/devices/ppc64abi32-linux-user.mak b/default-configs/devices/ppc64abi32-linux-user.mak
deleted file mode 100644
index 1c657ec9bb..0000000000
--- a/default-configs/devices/ppc64abi32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc64abi32-linux-user
diff --git a/default-configs/devices/ppc64le-linux-user.mak b/default-configs/devices/ppc64le-linux-user.mak
deleted file mode 100644
index 63f4269023..0000000000
--- a/default-configs/devices/ppc64le-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for ppc64le-linux-user
diff --git a/default-configs/devices/riscv32-linux-user.mak b/default-configs/devices/riscv32-linux-user.mak
deleted file mode 100644
index 865b362f5a..0000000000
--- a/default-configs/devices/riscv32-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for riscv-linux-user
diff --git a/default-configs/devices/riscv64-linux-user.mak b/default-configs/devices/riscv64-linux-user.mak
deleted file mode 100644
index 865b362f5a..0000000000
--- a/default-configs/devices/riscv64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for riscv-linux-user
diff --git a/default-configs/devices/s390x-linux-user.mak b/default-configs/devices/s390x-linux-user.mak
deleted file mode 100644
index a243c99874..0000000000
--- a/default-configs/devices/s390x-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for s390x-linux-user
diff --git a/default-configs/devices/sh4-linux-user.mak b/default-configs/devices/sh4-linux-user.mak
deleted file mode 100644
index a469e19ac6..0000000000
--- a/default-configs/devices/sh4-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sh4-linux-user
diff --git a/default-configs/devices/sh4eb-linux-user.mak b/default-configs/devices/sh4eb-linux-user.mak
deleted file mode 100644
index be08ca1002..0000000000
--- a/default-configs/devices/sh4eb-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sh4eb-linux-user
diff --git a/default-configs/devices/sparc-bsd-user.mak b/default-configs/devices/sparc-bsd-user.mak
deleted file mode 100644
index 21e09508d8..0000000000
--- a/default-configs/devices/sparc-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc-bsd-user
diff --git a/default-configs/devices/sparc-linux-user.mak b/default-configs/devices/sparc-linux-user.mak
deleted file mode 100644
index 9c716d1f92..0000000000
--- a/default-configs/devices/sparc-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc-linux-user
diff --git a/default-configs/devices/sparc32plus-linux-user.mak b/default-configs/devices/sparc32plus-linux-user.mak
deleted file mode 100644
index 432e88011e..0000000000
--- a/default-configs/devices/sparc32plus-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc32plus-linux-user
diff --git a/default-configs/devices/sparc64-bsd-user.mak b/default-configs/devices/sparc64-bsd-user.mak
deleted file mode 100644
index b8b9eea7f6..0000000000
--- a/default-configs/devices/sparc64-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc64-bsd-user
diff --git a/default-configs/devices/sparc64-linux-user.mak b/default-configs/devices/sparc64-linux-user.mak
deleted file mode 100644
index bf1bdd6aa4..0000000000
--- a/default-configs/devices/sparc64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for sparc64-linux-user
diff --git a/default-configs/devices/tilegx-linux-user.mak b/default-configs/devices/tilegx-linux-user.mak
deleted file mode 100644
index 3e47493af0..0000000000
--- a/default-configs/devices/tilegx-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for tilegx-linux-user
diff --git a/default-configs/devices/x86_64-bsd-user.mak b/default-configs/devices/x86_64-bsd-user.mak
deleted file mode 100644
index 73e5d34ec5..0000000000
--- a/default-configs/devices/x86_64-bsd-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for x86_64-bsd-user
diff --git a/default-configs/devices/x86_64-linux-user.mak b/default-configs/devices/x86_64-linux-user.mak
deleted file mode 100644
index bec1d9e7c6..0000000000
--- a/default-configs/devices/x86_64-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for x86_64-linux-user
diff --git a/default-configs/devices/xtensa-linux-user.mak b/default-configs/devices/xtensa-linux-user.mak
deleted file mode 100644
index fd1d350ee9..0000000000
--- a/default-configs/devices/xtensa-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for xtensa-linux-user
diff --git a/default-configs/devices/xtensaeb-linux-user.mak b/default-configs/devices/xtensaeb-linux-user.mak
deleted file mode 100644
index fd1d350ee9..0000000000
--- a/default-configs/devices/xtensaeb-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-# Default configuration for xtensa-linux-user
-- 
2.26.2



