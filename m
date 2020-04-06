Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BFEC2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3725920672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0+b6GJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3725920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWMc-0007Tg-Co
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrz-0003St-KD
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrx-0003jG-HA
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrx-0003ii-An
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:49:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id z7so304666wmk.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwVCTYhCp0Lrwvq8mABkyy5/qGJ2ZQsdDyKSYnT4qAQ=;
 b=P0+b6GJUrhml3X08b7IHqkkkQymB8AsFLyMRvO+Ipn0uQRERYwnMY0jgg35cukUcsI
 BAzV39yP4B3enwd4qzbV2AWnfFO+CxQY6io3aGRePjYuJ7oMERRli0+k4ltXANE3pnq+
 JHtpEaiGpTU+gdRrwgaNYDjzDrBhl/O4v4IPA0ikolEjXY4msQhpTx1JHP/EY8w5saeY
 3hQnQtxC31ggtCTsFrEUIFH1CEelfOipSvte1gmfuk0M7uYCNSaxzltiXu42Kv1gVtdW
 9aBmapAZx+36+z5dd67/r/idvNPBjVDljIFWugEfe+KGOABy8vEYzIlBH8aBq5BbTOkP
 Dd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vwVCTYhCp0Lrwvq8mABkyy5/qGJ2ZQsdDyKSYnT4qAQ=;
 b=DG/z8G2dNA0bTB5YcA5WOuONZA45vW5zLLuPEws0XfN13tXEabZ037itHP2Vhs6Kf6
 sRNvSV0565EDdLjoFSeyCvt5c7qpfFSlTMSDmJLqVhoZH7M7TiSoWU8SsQWUA/1yXf8Y
 E/l1PiO00O3ugKFMVjYhkhwdOWvdZ5gLVUGcvYCYLRgzy21W/2IzXA+zo0mFJZs4oly1
 n9SFODlqiUo28/QrUjllwPOjWyNi/BgO7pZOeURV6eDeW6uZIPdAsTRJLnHwd0SRVSzq
 PLWnsdeCvfhSsfX9Icecry9cZgVsJRcC9V+QAsVLlEaFWPu8ZpLC9VG4li9LRLjD0Bof
 Q2nQ==
X-Gm-Message-State: AGi0PuY8k58bKvjoOf+zCTYUxwpy1vsbl3Hq7XHARk9xlVkjDNd7Lji/
 xqj3d4ezzF4+YMqumO9nMRlPRihQlno=
X-Google-Smtp-Source: APiQypJYek6J7czWvZUyHrzNZa7iT1ppEsgcNErH12iavhUpIjSoNuLsIgkwczi4Ax5DTvS+zBsaLg==
X-Received: by 2002:a1c:9ad7:: with SMTP id c206mr198761wme.48.1586195348157; 
 Mon, 06 Apr 2020 10:49:08 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:49:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 54/54] qga/commands-win32: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:43 +0200
Message-Id: <20200406174743.16956-55-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir .
  HANDLING: ./qga/commands-win32.c
  [[manual check required: error_propagate() might be missing in acquire_privilege() ./qga/commands-win32.c:1344:4]]
  [[manual check required: error_propagate() might be missing in acquire_privilege() ./qga/commands-win32.c:1360:4]]
  [[manual check required: error_propagate() might be missing in check_suspend_mode() ./qga/commands-win32.c:1343:4]]
  [[manual check required: error_propagate() might be missing in check_suspend_mode() ./qga/commands-win32.c:1359:4]]

Add the missing error_propagate() after review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qga/commands-win32.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index b49920e201..8b66098056 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1341,13 +1341,18 @@ void qmp_guest_suspend_disk(Error **errp)
 
     *mode = GUEST_SUSPEND_MODE_DISK;
     check_suspend_mode(*mode, &local_err);
+    if (local_err) {
+        goto out;
+    }
     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
+    if (local_err) {
+        goto out;
+    }
     execute_async(do_suspend, mode, &local_err);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(mode);
-    }
+out:
+    error_propagate(errp, local_err);
+    g_free(mode);
 }
 
 void qmp_guest_suspend_ram(Error **errp)
@@ -1357,13 +1362,18 @@ void qmp_guest_suspend_ram(Error **errp)
 
     *mode = GUEST_SUSPEND_MODE_RAM;
     check_suspend_mode(*mode, &local_err);
+    if (local_err) {
+        goto out;
+    }
     acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
+    if (local_err) {
+        goto out;
+    }
     execute_async(do_suspend, mode, &local_err);
 
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(mode);
-    }
+out:
+    error_propagate(errp, local_err);
+    g_free(mode);
 }
 
 void qmp_guest_suspend_hybrid(Error **errp)
-- 
2.21.1


