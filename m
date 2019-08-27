Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB0C3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25962173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LZkvzC86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25962173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Wol-0007BL-NE
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36841)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <36-hkXQYKCkIweqimhksskpi.gsquiqy-hiziprsrkry.svk@flex--sameid.bounces.google.com>)
 id 1i2Wn1-0005Ho-2r
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <36-hkXQYKCkIweqimhksskpi.gsquiqy-hiziprsrkry.svk@flex--sameid.bounces.google.com>)
 id 1i2Wmz-00084s-9R
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:18 -0400
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a]:46052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <36-hkXQYKCkIweqimhksskpi.gsquiqy-hiziprsrkry.svk@flex--sameid.bounces.google.com>)
 id 1i2Wmy-00082i-Qo
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:17 -0400
Received: by mail-qk1-x74a.google.com with SMTP id a197so18126387qkg.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ReH46jE36OS5IMjEYP1C82QUib+jR1ntBNxmII/Xf2w=;
 b=LZkvzC86q7/0iRXlVUgcymRXHzd2tOI9NXY8eLpmMqGkjwV40MBfvYce3w9xKFTalw
 u+kCuEwQBfk8n4ECRTfuOIer8rXMT/VGkWuigLfGcBLoSNzP/xJ1uBlNyXRh6hDDM90B
 J7eU2J/pPDC3EUJNo0M/MJZ2ECXtgkmx54eFwU1pf5O9UdJIOakFIDbvqF4J7ahUDlBr
 0DPklg0zcNHEsem1rWrB35y7kHPmdXMMLUgpDgG1QmjSzHatHoRpJiC8wx+8nvAWe8Vg
 QQO+9W8OUCKpwoJ8eDoOcR+l5Ds2LWiEdm5G/4S+cEJkt6xL2m8ME2obidLJrdjTJch8
 rO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ReH46jE36OS5IMjEYP1C82QUib+jR1ntBNxmII/Xf2w=;
 b=Zj7wHNpnmxKFBv51DWmvKgzg9ornkz+HC5v6gTSf+HETVokZ729eZV/vL7OXS6j7xh
 atmOsNAS1kfOeliMYHfJEIi6RjutG4sqyoJ2dc+zZdfVbYF4weyk+kfwopuGqzLKKwsH
 ZYpj02Ay4yyTqN9Zm9PdGc286zzbQPEK2vc4Np82HbxCBylUoYuDUq8RihdlZ8Z3Enwx
 l7Mou+sVmuzc4mptmr+oNwcE1HHRKRu1Vs0n9k/HerjrNAeP7qmklfQn1jDWCptct0HJ
 dga7+P+pirKPQOtnrL8uQaII2Y8KZF56OPGwIEib4ACLfEB++zXFySWLsTeRwbKdmDyV
 f+PQ==
X-Gm-Message-State: APjAAAV4vi5Ow6Bo9yCG3K9iVp9z/+vIuruq/11RiNIaEn+CVUFigFzC
 6AmU9FMsfaR3UR+skG8JKFa++3VaQRqDMbtEmofnVqSwQJNeaCLpTu0bwp9ExcgVh9hlY275q4H
 UpFNxPJrwZrw8ndCR9vU9cwVGaLK3nCWTiVs/cOu1OLZf/DDd64shBAIm3Q9C
X-Google-Smtp-Source: APXvYqw2OeJvI73jn7V11ymInMcuJ1pjmcIFkJGE6ZDYgI5L1tzUJT5UvYgcKOSFFGHCHBCttsFwGqPuyeg=
X-Received: by 2002:aed:3785:: with SMTP id j5mr21088892qtb.87.1566894315484; 
 Tue, 27 Aug 2019 01:25:15 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:26 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-8-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::74a
Subject: [Qemu-devel] [PATCH v6 7/8] bootdevice: FW_CFG interface for LCHS
 values
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, sameid@google.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS.

Non-standard logical geometries break under QEMU.

A virtual disk which contains an operating system which depends on
logical geometries (consistent values being reported from BIOS INT13
AH=08) will most likely break under QEMU/SeaBIOS if it has non-standard
logical geometries - for example 56 SPT (sectors per track).
No matter what QEMU will report - SeaBIOS, for large enough disks - will
use LBA translation, which will report 63 SPT instead.

In addition we cannot force SeaBIOS to rely on physical geometries at
all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
report more than 16 physical heads when moved to an IDE controller,
since the ATA spec allows a maximum of 16 heads - this is an artifact of
virtualization.

By supplying the logical geometries directly we are able to support such
"exotic" disks.

We serialize this information in a similar way to the "bootorder"
interface.
The new fw_cfg entry is "bios-geometry".

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c       | 14 +++++++++++---
 include/sysemu/sysemu.h |  1 +
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index 2b12fb85a4..b034ad7bdc 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, const char *suffix)
         }
     }
 }
+
+/* Serialized as: (device name\0 + lchs struct) x devices */
+char *get_boot_devices_lchs_list(size_t *size)
+{
+    FWLCHSEntry *i;
+    size_t total = 0;
+    char *list = NULL;
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        char *bootpath;
+        char *chs_string;
+        size_t len;
+
+        bootpath = get_boot_device_path(i->dev, false, i->suffix);
+        chs_string = g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %" PRIu32,
+                                     bootpath, i->lcyls, i->lheads, i->lsecs);
+
+        if (total) {
+            list[total - 1] = '\n';
+        }
+        len = strlen(chs_string) + 1;
+        list = g_realloc(list, total + len);
+        memcpy(&list[total], chs_string, len);
+        total += len;
+        g_free(chs_string);
+        g_free(bootpath);
+    }
+
+    *size = total;
+
+    return list;
+}
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac378e..18aff658c0 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
 
 static void fw_cfg_machine_reset(void *opaque)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    FWCfgState *s = opaque;
     void *ptr;
     size_t len;
-    FWCfgState *s = opaque;
-    char *bootindex = get_boot_devices_list(&len);
+    char *buf;
 
-    ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
+    buf = get_boot_devices_list(&len);
+    ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
     g_free(ptr);
+
+    if (!mc->legacy_fw_cfg_order) {
+        buf = get_boot_devices_lchs_list(&len);
+        ptr = fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len);
+        g_free(ptr);
+    }
 }
 
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 1a33f25a5a..150fe8c0e2 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -108,6 +108,7 @@ void validate_bootdevices(const char *devices, Error **errp);
 void add_boot_device_lchs(DeviceState *dev, const char *suffix,
                           uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
 void del_boot_device_lchs(DeviceState *dev, const char *suffix);
+char *get_boot_devices_lchs_list(size_t *size);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.23.0.187.g17f5b7556c-goog


