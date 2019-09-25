Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83BC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4835621D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n0g6EcEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4835621D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5EB-0005r9-VO
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44941)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3YEqLXQYKChUDv7z3y19916z.x97Bz7F-yzGz689818F.9C1@flex--sameid.bounces.google.com>)
 id 1iD58m-0000CQ-4x
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3YEqLXQYKChUDv7z3y19916z.x97Bz7F-yzGz689818F.9C1@flex--sameid.bounces.google.com>)
 id 1iD58i-0004j3-1a
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:22 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:35830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3YEqLXQYKChUDv7z3y19916z.x97Bz7F-yzGz689818F.9C1@flex--sameid.bounces.google.com>)
 id 1iD58e-0004fD-GZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:07:17 -0400
Received: by mail-qt1-x84a.google.com with SMTP id x25so5496628qtq.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jijw4mo3osb8pd1tKVqFKzKBvaD7tj7dTNiSSh+oews=;
 b=n0g6EcEhgtLT0NCcAphJmVIq2NP0HJepeKySY5GYfD6hoXKpSIZGzxBUv9bUCAbwB7
 PzDQwJgk89Qo2mQC2cgnXps0zF9dySYAXXwq5+8tNUpkYuXRQlNio2NI1UkZzUEcLzJ4
 x1Y+8xoOvEdRUi3LJ6EPuo7xAxG5PUjGUua7qqLDq0WZFcobwmgfMu/fdarDPKkEO785
 kqJ4XlwPLVQfgX+ScTT+doh1IgMPr6Bmx3e6g1z3pyEoYxUX4g8+qmUcbN2PEXubdwov
 Sr5hJ9EA4PWrd4wNLnhTA5y57CoqMjwHEwV4K7oN5POnTg8KSEuXyxVeKxkUTiKqStOM
 Kk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jijw4mo3osb8pd1tKVqFKzKBvaD7tj7dTNiSSh+oews=;
 b=gXeHN43HHRj6hftmdlOQCLJkMwj5avMkoUHkPX4GZu75yV+SXgm2NjZXE4gYhGJ0qk
 7mGnMS4G37m10rSZ1d/fgznsmBuNTqq0csA0UZG82NRDD+197BUszGvfo5K3GmwhdiDY
 /FKPyt2hUxPimAZS3BiAKnYNqEPGFQv0MN9x3BJo7fTkA+M0yIKhLY4qgJbWw4IJ20Pm
 JdAoT9boi0K8Sa79LBWGhRx3O9WcivSFSj4J7l9M89EMUgYcqZRby9kF+PHf7gNi0Uxa
 ARsARadKyhGMjAGd/LIoOm53NxiVdmBo2NxlG3atwVHvyXtnw04RJIdU1xNoZF22Uu28
 vZfw==
X-Gm-Message-State: APjAAAVj1JdVWlBpWcxnOzd5yPJgsxs0cnmMP3ezVbGCSeI8jCBjs004
 Mgu8oqPUZQcxWcO07ppvSAlx0V15Ng/sgoC1tnLMhWqwmjNtNK3DIUFtI3whHwdteXWK6zznTl1
 XxWYuk9igrBhD9iG7Z3zXb6WyhiIoIIMgDBazYa84Yy+cdTMlkzZ0etABvfhQ
X-Google-Smtp-Source: APXvYqw/4BvKzKbIF6sw8qGThdte8SI17nKVQUTMJ49lIMpcHBYNXkbbtZEFy+wcB0/aFY6//UfIkjhUCS0=
X-Received: by 2002:a0c:8749:: with SMTP id 9mr6928386qvi.174.1569409632799;
 Wed, 25 Sep 2019 04:07:12 -0700 (PDT)
Date: Wed, 25 Sep 2019 14:06:38 +0300
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-Id: <20190925110639.100699-8-sameid@google.com>
Mime-Version: 1.0
References: <20190925110639.100699-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS values
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::84a
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
index 5bc5c79cbc..80c57fdc4e 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, Error **errp);
 void add_boot_device_lchs(DeviceState *dev, const char *suffix,
                           uint32_t lcyls, uint32_t lheads, uint32_t lsecs);
 void del_boot_device_lchs(DeviceState *dev, const char *suffix);
+char *get_boot_devices_lchs_list(size_t *size);
 
 /* handler to set the boot_device order for a specific type of MachineClass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
-- 
2.23.0.351.gc4317032e6-goog


