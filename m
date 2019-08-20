Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D6C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EB8214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EB8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyGC-0005c3-Pe
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7z-00053t-CI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy7x-0002oF-8p
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy7v-0002lD-9L
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A6DC1027015
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:00:17 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5682A18122;
 Tue, 20 Aug 2019 07:00:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:24 +0200
Message-Id: <1566284395-30287-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 20 Aug 2019 07:00:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/36] hw/i386/pc: Map into memory the initrd
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
Cc: Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

In order to reduce the memory footprint we map into memory
the initrd using g_mapped_file_new() instead of reading it.
In this way we can share the initrd pages between multiple
instances of QEMU.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190724143105.307042-4-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 17 +++++++++++++----
 include/hw/i386/pc.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437..96f6b89 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1241,17 +1241,21 @@ static void load_linux(PCMachineState *pcms,
 
             /* load initrd */
             if (initrd_filename) {
+                GMappedFile *mapped_file;
                 gsize initrd_size;
                 gchar *initrd_data;
                 GError *gerr = NULL;
 
-                if (!g_file_get_contents(initrd_filename, &initrd_data,
-                            &initrd_size, &gerr)) {
+                mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
+                if (!mapped_file) {
                     fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                             initrd_filename, gerr->message);
                     exit(1);
                 }
+                pcms->initrd_mapped_file = mapped_file;
 
+                initrd_data = g_mapped_file_get_contents(mapped_file);
+                initrd_size = g_mapped_file_get_length(mapped_file);
                 initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
                 if (initrd_size >= initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot support."
@@ -1378,6 +1382,7 @@ static void load_linux(PCMachineState *pcms,
 
     /* load initrd */
     if (initrd_filename) {
+        GMappedFile *mapped_file;
         gsize initrd_size;
         gchar *initrd_data;
         GError *gerr = NULL;
@@ -1387,12 +1392,16 @@ static void load_linux(PCMachineState *pcms,
             exit(1);
         }
 
-        if (!g_file_get_contents(initrd_filename, &initrd_data,
-                                 &initrd_size, &gerr)) {
+        mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
+        if (!mapped_file) {
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                     initrd_filename, gerr->message);
             exit(1);
         }
+        pcms->initrd_mapped_file = mapped_file;
+
+        initrd_data = g_mapped_file_get_contents(mapped_file);
+        initrd_size = g_mapped_file_get_length(mapped_file);
         if (initrd_size >= initrd_max) {
             fprintf(stderr, "qemu: initrd is too large, cannot support."
                     "(max: %"PRIu32", need %"PRId64")\n",
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 859b64c..44edc69 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -42,6 +42,7 @@ struct PCMachineState {
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
     PFlashCFI01 *flash[2];
+    GMappedFile *initrd_mapped_file;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
-- 
1.8.3.1



