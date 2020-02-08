Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB3C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AEA21741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkZQuUGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AEA21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TVs-0007GE-7V
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ7-0006Mi-IO
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ6-0001t5-KM
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:27 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ6-0001sg-Du; Sat, 08 Feb 2020 11:57:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so2489181wrh.5;
 Sat, 08 Feb 2020 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3rBdGV77acnZuRXknbrZFUu5k1x9HktZihwAmZUV2Pk=;
 b=QkZQuUGJDmzyGNiVBJsQGmUxc2Tnfwxw9/o3qpL3v+pg2iMhJcYKvR6V7Eyntl80hA
 PfwqlJqFk8o1dhoXOpb3K1Hwxux8sJQjTCniu7vr6gGRzeXJ0ft3ZJuycnGihT0isfjU
 v1AvhQCRcihtDAl8lCWPMTq+4CpUiQcAYgV++ev6X7cBysKB/rC4leGtsO0jpqEWYTNm
 bVFBQxSGzLGERpQikgWJkRYdrMNOfSaaJuf+TYN5B3hJlCt/9hd5y4e0VUht6b5HGwNQ
 ofdpnyswmNRlHHh0tGakWjvxeeQo+2OuYjo+rLiVsWmlff5r90MdatBQHfNiyJJl3mR+
 /O2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3rBdGV77acnZuRXknbrZFUu5k1x9HktZihwAmZUV2Pk=;
 b=p8SRTS5/nJyF9KRUS0dOZKDIP/MQL2+yChqsgIFANJ+KN4HFtpklGmSErX9Zmt9foR
 XqGwsew6DEHwQ2J6VvHQOUZIc8up8uFMZNnzDNmkoEUrHOm0/fNmuv/6ULQSQZ3TJBsW
 WoPyU6uDYqOHUdRNWeHv4kwbWbIrrRT488CZPxkUvHZtnLf/BScNOfDZ6j5eIFMuftHh
 tsWSlA+pVaWlxoFEHtCvF1QG0wl+FMANp5xgpFi36SGuWIE0+X3zZ8xDkj/c3W8QnxpR
 fK3BVHQaV9/PRYFGTKiwvbJ1s86JnsXQ5HBoXIB9RaplYfhloaYidkLvcP6rILVROwt3
 HwUw==
X-Gm-Message-State: APjAAAUuh2ssTzJvIWNWXKAgcmewNfjD1d7sDb0/O8zhzR3RrHSpndCB
 x4UJwX/8Thk106WFT4By1spL7Rwb
X-Google-Smtp-Source: APXvYqzPJ9gFBySJMdPaTLZmTNa6+vIJDT1kRKb3tcosfDMXynjOkj3xQA+at1MpnOuLK2kw9vf2Gg==
X-Received: by 2002:adf:db48:: with SMTP id f8mr5819460wrj.146.1581181045353; 
 Sat, 08 Feb 2020 08:57:25 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/13] hw/arm/raspi: Extract the cores count from the board
 revision
Date: Sat,  8 Feb 2020 17:56:45 +0100
Message-Id: <20200208165645.15657-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The board revision encode the count of ARM cores. Add a helper
to extract the number of cores, and use it. This will be helpful
when we add the Raspi0/1 that have a single core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index bee6ca0a08..90ad9b8115 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -101,6 +101,21 @@ static const char *board_soc_type(uint32_t board_rev)
     return soc_types[proc_id];
 }
 
+static int cores_count(uint32_t board_rev)
+{
+    static const int soc_cores_count[] = {
+        0, BCM283X_NCPUS, BCM283X_NCPUS,
+    };
+    int proc_id = board_processor_id(board_rev);
+
+    if (proc_id >= ARRAY_SIZE(soc_cores_count) || !soc_cores_count[proc_id]) {
+        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
+                     proc_id, board_rev);
+        exit(1);
+    }
+    return soc_cores_count[proc_id];
+}
+
 static const char *board_type(uint32_t board_rev)
 {
     static const char *types[] = {
@@ -307,9 +322,7 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->max_cpus = BCM283X_NCPUS;
-    mc->min_cpus = BCM283X_NCPUS;
-    mc->default_cpus = BCM283X_NCPUS;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     if (board_version(board_rev) == 2) {
         mc->ignore_memory_transaction_failures = true;
-- 
2.21.1


