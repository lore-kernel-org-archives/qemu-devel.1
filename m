Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D20C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A852078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6OSlufe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A852078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9sy-00072e-Ip
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9rQ-0003dh-NY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:50:04 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:33454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9rO-0003is-QR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:50:04 -0400
Received: by mail-pg1-x52c.google.com with SMTP id o13so2478185pgf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hAIHaNoFAufwAGE6KbRmUZ0ExbibwWjhonjd/BMqxdQ=;
 b=H6OSlufeVe70sUyXpUiMZIh+/E9q3jJGFxgmBsSFtgWd/z9QNkwjELY8U6DjAqEUoz
 NrSCrB+dqnZVvnyR/OTJe4BnnxYPPSqfOsu+DMrk26O3vLAD4w3Xxk3zariVBEZrkMwO
 UHpnVqTEjunnYwdAdcbVArmW7NIMEPIG3eY2SPAS5aTbzBp3B549yK6TojvS0dn8jEpj
 tWXnrttZZgmWaMljl8qK7m6VRIMzxuiJg48AumIMwxzPQdMN0LKufhj6BHGfu+xuC9ba
 bMc09ZqcmxfNmv3fW1qTrFppdvsnE3mUZ5kkw4MYRvA4k8uK+gdyOxK6kDbhGN3e38av
 BXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hAIHaNoFAufwAGE6KbRmUZ0ExbibwWjhonjd/BMqxdQ=;
 b=hQE/hqTjoOoVWQMz/AbuyROizeSt2uWroe1NyHUoTnwbrg3vZMZ/mygZu3zzKQ1Bwc
 U4K9lEtCuAMwqmc94rt1kjOMvLEPZJ8xtc4veFTKLv34dB5f08mvW2WkwpQNaAF1AcL4
 2S25ZGtCJtop08wpgXhIAIQQvSQxkbmLPoEEF7+lj8VYkwxbd391DbWcY1xYpmZJpVEY
 Ohtrtn+pQYuC5jleK+3TIsYxHIrUI8+hKsgIRQkbtD53jfBkHHcHH20BPsDJ+Bz+VvY6
 dV2mNvPikSkZLRzUL35EZIuxCvsk21H1HXZXzaJiH4dyHmJlEOa5OgDdoSsanFCyoIm3
 zwtQ==
X-Gm-Message-State: AOAM530FppUAl7zWE4KwRV9+rh321VLXDyCI8RfuvKBG+GgP+jhVBFH6
 p9yQ8bhq7AOTst9P/qNDXHUpZHaRK8u9CrfNL3Q=
X-Google-Smtp-Source: ABdhPJztqGONx5q3IWhvve9gq6nFnqL/m+pwhe9FZcGDz9YhMBw5T55zSdREXE71U722+RnDijo/Cg==
X-Received: by 2002:aa7:854f:: with SMTP id y15mr14843926pfn.298.1598503800706; 
 Wed, 26 Aug 2020 21:50:00 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 n26sm902296pff.30.2020.08.26.21.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 21:49:59 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] meson: Convert undefsym.sh to undefsym.py
Date: Thu, 27 Aug 2020 12:49:17 +0800
Message-Id: <20200827044917.1356-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827044917.1356-1-luoyonggang@gmail.com>
References: <20200827044917.1356-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

undefsym.sh are not msys2 compatible, convert it to python script

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build         |  2 +-
 scripts/undefsym.py | 57 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/undefsym.sh | 20 ----------------
 3 files changed, 58 insertions(+), 21 deletions(-)
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh

diff --git a/meson.build b/meson.build
index 1644bbd83c..d6e3bcea7e 100644
--- a/meson.build
+++ b/meson.build
@@ -845,7 +845,7 @@ foreach d, list : modules
 endforeach
 
 nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.sh')
+undefsym = find_program('scripts/undefsym.py')
 block_syms = custom_target('block.syms', output: 'block.syms',
                              input: [libqemuutil, block_mods],
                              capture: true,
diff --git a/scripts/undefsym.py b/scripts/undefsym.py
new file mode 100644
index 0000000000..c690f88c7a
--- /dev/null
+++ b/scripts/undefsym.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+# Before a shared module's DSO is produced, a static library is built for it
+# and passed to this script.  The script generates -Wl,-u options to force
+# the inclusion of symbol from libqemuutil.a if the shared modules need them,
+# This is necessary because the modules may use functions not needed by the
+# executable itself, which would cause the function to not be linked in.
+# Then the DSO loading would fail because of the missing symbol.
+
+
+"""
+Compare the static library with the shared module for compute the symbol duplication
+"""
+
+import sys
+import subprocess
+
+def filter_lines_set(stdout, is_static = True):
+    linesSet = set()
+    for line in stdout.splitlines():
+        tokens = line.split(b' ')
+        if len(tokens) >= 1:
+            if len(tokens) > 1:
+                if is_static and tokens[1] == b'U':
+                    continue
+                if not is_static and tokens[1] != b'U':
+                    continue
+            new_line = b'-Wl,-u,' + tokens[0]
+            if not new_line in linesSet:
+                linesSet.add(new_line)
+    return linesSet
+
+def main(args):
+    if len(args) <= 3:
+        sys.exit(0)
+
+    nm = args[1]
+    staticlib = args[2]
+    pc = subprocess.run([nm, "-P", "-g", staticlib], stdout=subprocess.PIPE)
+    if pc.returncode != 0:
+        sys.exit(-1)
+    lines_set_left = filter_lines_set(pc.stdout)
+
+    shared_modules = args[3:]
+    pc = subprocess.run([nm, "-P", "-g"] + shared_modules, stdout=subprocess.PIPE)
+    if pc.returncode != 0:
+        sys.exit(-1)
+    lines_set_right = filter_lines_set(pc.stdout, False)
+    lines = []
+    for line in sorted(list(lines_set_right)):
+        if line in lines_set_left:
+            lines.append(line)
+    sys.stdout.write(b'\n'.join(lines).decode())
+
+if __name__ == "__main__":
+    main(sys.argv)
diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
deleted file mode 100755
index b9ec332e95..0000000000
--- a/scripts/undefsym.sh
+++ /dev/null
@@ -1,20 +0,0 @@
-#! /usr/bin/env bash
-
-# Before a shared module's DSO is produced, a static library is built for it
-# and passed to this script.  The script generates -Wl,-u options to force
-# the inclusion of symbol from libqemuutil.a if the shared modules need them,
-# This is necessary because the modules may use functions not needed by the
-# executable itself, which would cause the function to not be linked in.
-# Then the DSO loading would fail because of the missing symbol.
-
-if test $# -le 2; then
-  exit 0
-fi
-
-NM=$1
-staticlib=$2
-shift 2
-# Find symbols defined in static libraries and undefined in shared modules
-comm -12 \
-  <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
-  <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)
-- 
2.27.0.windows.1


