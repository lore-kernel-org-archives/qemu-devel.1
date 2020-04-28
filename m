Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91842C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E885206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFE04p88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E885206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTL0E-0006Qj-DH
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTJpH-000068-MH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTJkm-00080U-RR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:34:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jTJkm-00080L-Cd
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:30:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id x25so1379256wmc.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 23:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/xdW9TlF14cno7Dox1YULYIivWRvz4pvd3kbVi7j+L4=;
 b=LFE04p88MpHoPldLuBL/ef/Ua1bNp9e+y/AioN8MiM9U5SHhMHb2oaOuIHdrgUrfvp
 OwWz5i3q1Tu4LjPp1sZH+uewJSXti8ttRSe8d4o4Yu9774I62ekPt4PWwGGhSWeKwURe
 Ujhqmqn4J7uo8NwSOeHNm7zB07nEI89ZLHKzkvQ6aAibNYyiRGvStPM8fWwvmlIgeLf0
 kL5lPAGouNRIDqC54gdYhcUeIT8+TvQlmoaylTU7gdf5GOflOAULoHvyg0STXeW1JqD2
 b3Wb8+3KZ0w1uJGCNf8Yoy4RhiJJW0ZhIBUJTUGabjsPKXlvUQHvXTzw9rBHXagIZJky
 8iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/xdW9TlF14cno7Dox1YULYIivWRvz4pvd3kbVi7j+L4=;
 b=T0NIEnU58BPuCNyTwlByHJz0mKHNIGghHtrkcLt9KwA0dkQQ2XPX1cxqR8PQYl+rkp
 8F6FH06TDqauLZwMlQoErevsnash0HNfVtQgPyo6gK19uD+BpNqI7Tny2zqs8UaEJtP+
 sJy+3ngu0pJyizWdlUI0zm5UsuASowdnk9QDu03liy+ehfOtqTy7xPpeey7QIM8Ff6Jb
 AElxlWGrmh0LcWQKZsVUjPmxqS0Rb9rKnQmskDh6Ge58Z/iipz2FATAPKL9pRTRaLADr
 arVylC+QPQkDYZCpJBg7qJ/b8/2//6EMRdik8CU1kuio2TrCCV0KKobCQdtwnsR1Q8cB
 ltXA==
X-Gm-Message-State: AGi0PuYu2jTFNzAxEizlTdUI6nL/WrxPKIPfacLlVV7YmQeK2t8N/qoV
 Yx065TfC2+JwjxZfh6mwG8CtQRwdbcJ2PA==
X-Google-Smtp-Source: APiQypJjAWImZKi6yyETe7bMvdVFmRMyX+Q/xhJCHdWzOGMOtz5pIllYGMr6MRFpzeCK7ibGxixnWw==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr2746244wmd.88.1588055398259;
 Mon, 27 Apr 2020 23:29:58 -0700 (PDT)
Received: from localhost.localdomain (public-gprs351065.centertel.pl.
 [37.47.2.154])
 by smtp.gmail.com with ESMTPSA id a205sm2030564wmh.29.2020.04.27.23.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 23:29:57 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] Fix undefined behaviour
Date: Tue, 28 Apr 2020 06:28:46 +0000
Message-Id: <20200428062847.7764-2-gorbak25@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200428062847.7764-1-gorbak25@gmail.com>
References: <20200428062847.7764-1-gorbak25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=gorbak25@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Tue, 28 Apr 2020 03:48:48 -0400
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
Cc: artur@puzio.waw.pl, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Grzegorz Uriasz <gorbak25@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, j.nowak26@student.uw.edu.pl,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
---
 hw/xen/xen_pt_load_rom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index a50a80837e..9f100dc159 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -38,12 +38,12 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     fp = fopen(rom_file, "r+");
     if (fp == NULL) {
         if (errno != ENOENT) {
-            error_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
+            warn_report("pci-assign: Cannot open %s: %s", rom_file, strerror(errno));
         }
         return NULL;
     }
     if (fstat(fileno(fp), &st) == -1) {
-        error_report("pci-assign: Cannot stat %s: %s", rom_file, strerror(errno));
+        warn_report("pci-assign: Cannot stat %s: %s", rom_file, strerror(errno));
         goto close_rom;
     }
 
@@ -59,10 +59,9 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     memset(ptr, 0xff, st.st_size);
 
     if (!fread(ptr, 1, st.st_size, fp)) {
-        error_report("pci-assign: Cannot read from host %s", rom_file);
-        error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
-                     "or load from file with romfile=\n");
+        warn_report("pci-assign: Cannot read from host %s", rom_file);
+        memory_region_unref(&dev->rom);
+        ptr = NULL;
         goto close_rom;
     }
 
-- 
2.26.1


