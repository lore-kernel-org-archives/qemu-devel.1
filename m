Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA009C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F1824673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqmlFwdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F1824673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52043 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWf1-0007Wd-Cn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWd8-0005du-6O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWd5-0007k2-8Z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37086
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWd5-0007jc-41
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kg8dkgToII+17yCLdud4DGcpR3GxCmqyAmpoGaHxRIE=;
 b=EqmlFwdr6DDwz6H7PI6OOgX7KHz9iOKVc0Sv1i+3jv+y5fIqSk6jnujksMncGzPU2x7qkU
 /lRGbPwvicUqw6yybpgK6yPVrOXtETtUmBTGXxkmUpMvUcVyO9ub2yhL/CqIqpOAYRQOy2
 2TQjxmlwYg9G/5DuzUrvUyjhpekkVCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-KQ1I_UFFNJCrDg5odpw-bQ-1; Thu, 23 Jan 2020 02:10:13 -0500
Received: by mail-wm1-f71.google.com with SMTP id s25so246341wmj.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SZlgsbuRexepbyzGOJZSIRK1RX+EEBHf43p6wbErIqU=;
 b=npMedmvdcjwPeKsnqoziAp3wDGt+PijaYvrPOGjvlJo6i72J4ijpzfU3ntlDVp+wy3
 otqhQZG/EcbZe1hdKKbmEXFbE46vMPL9Mex0P+iyMsl12C92Y5zRkUoX6NNmObKSKX/7
 iBzbYVlXz4t+3RP/MBNYsgpRKMxGD0JeRIUy/QY5Iv+cKIQpIAxI3nvSoUQBJGJPWAIB
 3bVmBLUSWprqQqrARJKtPGfiJa64ZhYgyI7wj/NCxdz6/+GQJJpen/OfLA3XUNG9zmac
 GmA1vVAUr1QXfrsCICgVieWV9lQWxiPtVCNJDAmuAZnljbYSBpCropsEbSqGXOI4tovR
 yKdA==
X-Gm-Message-State: APjAAAXYTJuPnORbgJI2socn7VzkTmYGd24dQfWnr4t+zxGfJhY486P+
 qJJE7EXgCW0vXgbIt/KmXXIj1x7XpTqtqPtVTq95ObJb7CF+9MtYG+NiQJa/49rvb8kGXvE8Au/
 nOOEqtgNM6tverd0=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr15326423wrw.93.1579763411470; 
 Wed, 22 Jan 2020 23:10:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxy8rMxhUh4AJ7Qgy4YRfRynLNh5q3YUb5SsoSZS/n978QVvswMjMFdzO+BHqI3gvDtpp5/iQ==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr15326386wrw.93.1579763411118; 
 Wed, 22 Jan 2020 23:10:11 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 l3sm1838822wrt.29.2020.01.22.23.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:10 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 01/18] q35: implement 128K SMRAM at default SMBASE address
Message-ID: <20200123070913.626488-2-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: KQ1I_UFFNJCrDg5odpw-bQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

It's not what real HW does, implementing which would be overkill [**]
and would require complex cross stack changes (QEMU+firmware) to make
it work.
So considering that SMRAM is owned by MCH, for simplicity (ab)use
reserved Q35 register, which allows QEMU and firmware easily init
and make RAM at SMBASE available only from SMM context.

Patch uses commit (2f295167e0 q35/mch: implement extended TSEG sizes)
for inspiration and uses reserved register in config space at 0x9c
offset [*] to extend q35 pci-host with ability to use 128K at
0x30000 as SMRAM and hide it (like TSEG) from non-SMM context.

Usage:
  1: write 0xff in the register
  2: if the feature is supported, follow up read from the register
     should return 0x01. At this point RAM at 0x30000 is still
     available for SMI handler configuration from non-SMM context
  3: writing 0x02 in the register, locks SMBASE area, making its contents
     available only from SMM context. In non-SMM context, reads return
     0xff and writes are ignored. Further writes into the register are
     ignored until the system reset.

*) https://www.mail-archive.com/qemu-devel@nongnu.org/msg455991.html
**) https://www.mail-archive.com/qemu-devel@nongnu.org/msg646965.html

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1575896942-331151-3-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/pci-host/q35.h | 10 +++++
 hw/i386/pc.c              |  4 +-
 hw/pci-host/q35.c         | 84 +++++++++++++++++++++++++++++++++++----
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index b3bcf2e632..976fbae599 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -32,6 +32,7 @@
 #include "hw/acpi/ich9.h"
 #include "hw/pci-host/pam.h"
 #include "hw/i386/intel_iommu.h"
+#include "qemu/units.h"
=20
 #define TYPE_Q35_HOST_DEVICE "q35-pcihost"
 #define Q35_HOST_DEVICE(obj) \
@@ -54,6 +55,8 @@ typedef struct MCHPCIState {
     MemoryRegion smram_region, open_high_smram;
     MemoryRegion smram, low_smram, high_smram;
     MemoryRegion tseg_blackhole, tseg_window;
+    MemoryRegion smbase_blackhole, smbase_window;
+    bool has_smram_at_smbase;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
@@ -97,6 +100,13 @@ typedef struct Q35PCIHost {
 #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY  0xffff
 #define MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX    0xfff
=20
+#define MCH_HOST_BRIDGE_SMBASE_SIZE            (128 * KiB)
+#define MCH_HOST_BRIDGE_SMBASE_ADDR            0x30000
+#define MCH_HOST_BRIDGE_F_SMBASE               0x9c
+#define MCH_HOST_BRIDGE_F_SMBASE_QUERY         0xff
+#define MCH_HOST_BRIDGE_F_SMBASE_IN_RAM        0x01
+#define MCH_HOST_BRIDGE_F_SMBASE_LCK           0x02
+
 #define MCH_HOST_BRIDGE_PCIEXBAR               0x60    /* 64bit register *=
/
 #define MCH_HOST_BRIDGE_PCIEXBAR_SIZE          8       /* 64bit register *=
/
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8054bc4147..a6302a772d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -93,7 +93,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
=20
-GlobalProperty pc_compat_4_2[] =3D {};
+GlobalProperty pc_compat_4_2[] =3D {
+    { "mch", "smbase-smram", "off" },
+};
 const size_t pc_compat_4_2_len =3D G_N_ELEMENTS(pc_compat_4_2);
=20
 GlobalProperty pc_compat_4_1[] =3D {};
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 158d270b9f..6342f73b9f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -275,20 +275,20 @@ static const TypeInfo q35_host_info =3D {
  * MCH D0:F0
  */
=20
-static uint64_t tseg_blackhole_read(void *ptr, hwaddr reg, unsigned size)
+static uint64_t blackhole_read(void *ptr, hwaddr reg, unsigned size)
 {
     return 0xffffffff;
 }
=20
-static void tseg_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
-                                 unsigned width)
+static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
+                            unsigned width)
 {
     /* nothing */
 }
=20
-static const MemoryRegionOps tseg_blackhole_ops =3D {
-    .read =3D tseg_blackhole_read,
-    .write =3D tseg_blackhole_write,
+static const MemoryRegionOps blackhole_ops =3D {
+    .read =3D blackhole_read,
+    .write =3D blackhole_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size =3D 1,
     .valid.max_access_size =3D 4,
@@ -430,6 +430,46 @@ static void mch_update_ext_tseg_mbytes(MCHPCIState *mc=
h)
     }
 }
=20
+static void mch_update_smbase_smram(MCHPCIState *mch)
+{
+    PCIDevice *pd =3D PCI_DEVICE(mch);
+    uint8_t *reg =3D pd->config + MCH_HOST_BRIDGE_F_SMBASE;
+    bool lck;
+
+    if (!mch->has_smram_at_smbase) {
+        return;
+    }
+
+    if (*reg =3D=3D MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D
+            MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
+        return;
+    }
+
+    /*
+     * default/reset state, discard written value
+     * which will disable SMRAM balackhole at SMBASE
+     */
+    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D=3D 0xff) {
+        *reg =3D 0x00;
+    }
+
+    memory_region_transaction_begin();
+    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
+        /* disable all writes */
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=3D
+            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        *reg =3D MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        lck =3D true;
+    } else {
+        lck =3D false;
+    }
+    memory_region_set_enabled(&mch->smbase_blackhole, lck);
+    memory_region_set_enabled(&mch->smbase_window, lck);
+    memory_region_transaction_commit();
+}
+
 static void mch_write_config(PCIDevice *d,
                               uint32_t address, uint32_t val, int len)
 {
@@ -456,6 +496,10 @@ static void mch_write_config(PCIDevice *d,
                        MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
         mch_update_ext_tseg_mbytes(mch);
     }
+
+    if (ranges_overlap(address, len, MCH_HOST_BRIDGE_F_SMBASE, 1)) {
+        mch_update_smbase_smram(mch);
+    }
 }
=20
 static void mch_update(MCHPCIState *mch)
@@ -464,6 +508,7 @@ static void mch_update(MCHPCIState *mch)
     mch_update_pam(mch);
     mch_update_smram(mch);
     mch_update_ext_tseg_mbytes(mch);
+    mch_update_smbase_smram(mch);
=20
     /*
      * pci hole goes from end-of-low-ram to io-apic.
@@ -514,6 +559,9 @@ static void mch_reset(DeviceState *qdev)
                      MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
     }
=20
+    d->config[MCH_HOST_BRIDGE_F_SMBASE] =3D 0;
+    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] =3D 0xff;
+
     mch_update(mch);
 }
=20
@@ -563,7 +611,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram)=
;
=20
     memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
-                          &tseg_blackhole_ops, NULL,
+                          &blackhole_ops, NULL,
                           "tseg-blackhole", 0);
     memory_region_set_enabled(&mch->tseg_blackhole, false);
     memory_region_add_subregion_overlap(mch->system_memory,
@@ -575,6 +623,27 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->tseg_window, false);
     memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
                                 &mch->tseg_window);
+
+    /*
+     * This is not what hardware does, so it's QEMU specific hack.
+     * See commit message for details.
+     */
+    memory_region_init_io(&mch->smbase_blackhole, OBJECT(mch), &blackhole_=
ops,
+                          NULL, "smbase-blackhole",
+                          MCH_HOST_BRIDGE_SMBASE_SIZE);
+    memory_region_set_enabled(&mch->smbase_blackhole, false);
+    memory_region_add_subregion_overlap(mch->system_memory,
+                                        MCH_HOST_BRIDGE_SMBASE_ADDR,
+                                        &mch->smbase_blackhole, 1);
+
+    memory_region_init_alias(&mch->smbase_window, OBJECT(mch),
+                             "smbase-window", mch->ram_memory,
+                             MCH_HOST_BRIDGE_SMBASE_ADDR,
+                             MCH_HOST_BRIDGE_SMBASE_SIZE);
+    memory_region_set_enabled(&mch->smbase_window, false);
+    memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
+                                &mch->smbase_window);
+
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram), &error_abort);
=20
@@ -601,6 +670,7 @@ uint64_t mch_mcfg_base(void)
 static Property mch_props[] =3D {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbyte=
s,
                        16),
+    DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, tru=
e),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
MST


