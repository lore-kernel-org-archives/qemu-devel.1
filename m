Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48115C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F81206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 21:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry/sQtQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F81206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO6nn-0000UY-0M
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 17:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6n1-0008Ub-H5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6mx-0002fG-7t
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:38:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO6mw-0002f5-PB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 17:38:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id g12so3795278wmh.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGAga8BYVHJSNF2JXAFuIVgkfvIclW5q+uLZoijoRJw=;
 b=ry/sQtQ8VFvKhi8w6mQl8+hrfHAYj71oZPq+VoWr8zoWwv/ZzqaMY9XoIXU+Zg/vxx
 S7NUICggtPK6MfkmaKDxCMzWxK7NGahD/RSxMl/5wZysNZWH/6/sfDnLsPVXO05eIWbm
 +wH9XDpZ4deDesXTCR3jkWyMfEcp/iz2Stx9tq6+8mDP56747D93Ugj69zngofZ98hQS
 QKvS/wABfbOP1Ne4FxavhvYn6T7U4TA43LOCy/5DRcCPlMGhrImZpw2cyotBZOcEvs53
 hqw8DzyI3zO8MMaVle5w2MyD1CBNRplgMRrvbRGPbS4Chi46fln/oJyLS7gxE46tLlSl
 IbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sGAga8BYVHJSNF2JXAFuIVgkfvIclW5q+uLZoijoRJw=;
 b=jglgvi2iRE30LzDpShjTAQeNs+Y95X0i6d57iQdpd14fdH8H76+N1Ozu3/yuOrk+kv
 +OkjM4QIISSo9+RngohhBnpw3wBmwaNE826uYUYn56ef1+6i9YwibEgV132HTzfEqJRO
 pdhwzCAAc1qXyfOHHcFXQkBti1n3oqVclpfedVkKPyNQ7Fcu+VyRosAgQQFsOqIxGQwE
 BxFGQPsoFiGTffqUtg1Xd8CprZM0yllPBKLvTVnJnrnHeZ/fGtPbMmox8YBZkLjKFEqY
 OqtvwBO/bGpf1gN30uUreAKYCYQX6uQAvcnmagHZJXdW3OZaVCz3k/UtE6UiefUsrdOv
 bquA==
X-Gm-Message-State: AGi0PuaDzSQxOJFz8Rd1+prKmdqNjTMgnBbEmJ7e8PIoiP86guJ33uHL
 QpoKx+8SP9aLHSKA7AYHPxNMiS4YIZsHeA==
X-Google-Smtp-Source: APiQypKG01VASxTx3QqAQ4pKFc7S5YMKKhBm9AQcHg++oIyumOLLzwH9ISd+qsFDw5VVldNU7oZuHQ==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr19433076wmn.81.1586813919823; 
 Mon, 13 Apr 2020 14:38:39 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k184sm16825270wma.13.2020.04.13.14.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 14:38:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 2/7] various: Use &error_abort in instance_init()
Date: Mon, 13 Apr 2020 23:38:25 +0200
Message-Id: <20200413213825.15584-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h \
    --include-headers --keep-comments --in-place \
    --sp-file \
      scripts/coccinelle/use-error_abort-in-instance_init.cocci

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Include "qapi/error.h" in spapr_llan.c and test-qdev-global-props.c
---
 backends/cryptodev-vhost-user.c |  2 +-
 backends/rng-egd.c              |  2 +-
 backends/rng-random.c           |  2 +-
 backends/vhost-user.c           |  3 ++-
 hw/arm/bcm2835_peripherals.c    |  6 ++++--
 hw/arm/vexpress.c               |  8 ++++----
 hw/arm/xlnx-zcu102.c            |  8 ++++----
 hw/block/fdc.c                  |  4 ++--
 hw/block/vhost-user-blk.c       |  2 +-
 hw/block/virtio-blk.c           |  2 +-
 hw/core/machine.c               |  6 +++---
 hw/cpu/core.c                   |  4 ++--
 hw/display/vga-pci.c            |  7 +++++--
 hw/display/xlnx_dp.c            |  4 ++--
 hw/dma/sparc32_dma.c            |  2 +-
 hw/gpio/aspeed_gpio.c           |  2 +-
 hw/ide/macio.c                  |  4 +++-
 hw/ide/qdev.c                   |  4 ++--
 hw/intc/apic_common.c           |  2 +-
 hw/mem/nvdimm.c                 |  4 ++--
 hw/misc/aspeed_sdmc.c           |  2 +-
 hw/misc/edu.c                   |  3 ++-
 hw/misc/macio/macio.c           |  4 ++--
 hw/misc/macio/pmu.c             |  3 ++-
 hw/misc/pca9552.c               |  2 +-
 hw/misc/tmp105.c                |  2 +-
 hw/misc/tmp421.c                |  8 ++++----
 hw/net/e1000.c                  |  3 ++-
 hw/net/lance.c                  |  3 ++-
 hw/net/lasi_i82596.c            |  3 ++-
 hw/net/ne2000-isa.c             |  4 ++--
 hw/net/spapr_llan.c             |  3 ++-
 hw/net/virtio-net.c             |  2 +-
 hw/pci-host/grackle.c           |  2 +-
 hw/pci-host/i440fx.c            |  8 ++++----
 hw/pci-host/prep.c              |  2 +-
 hw/pci-host/q35.c               | 23 ++++++++++++++---------
 hw/pci-host/sabre.c             |  3 ++-
 hw/pci-host/uninorth.c          |  9 +++++----
 hw/pcmcia/pxa2xx.c              |  3 ++-
 hw/ppc/spapr_drc.c              |  6 +++---
 hw/ppc/spapr_rng.c              |  2 +-
 hw/riscv/sifive_u.c             |  4 ++--
 hw/s390x/event-facility.c       |  6 +++---
 hw/s390x/s390-ccw.c             |  2 +-
 hw/s390x/s390-skeys.c           |  4 ++--
 hw/s390x/s390-stattrib.c        |  4 ++--
 hw/s390x/sclp.c                 |  2 +-
 hw/scsi/scsi-bus.c              |  2 +-
 hw/ssi/xilinx_spips.c           |  2 +-
 hw/usb/bus.c                    |  4 ++--
 hw/usb/dev-network.c            |  2 +-
 hw/usb/dev-storage.c            |  4 ++--
 hw/usb/host-libusb.c            |  2 +-
 hw/usb/redirect.c               |  2 +-
 hw/virtio/virtio-balloon.c      |  4 ++--
 net/dump.c                      |  4 ++--
 net/filter-buffer.c             |  2 +-
 net/filter-mirror.c             | 10 +++++-----
 net/filter-rewriter.c           |  3 ++-
 target/arm/cpu64.c              |  4 ++--
 target/i386/cpu.c               | 23 ++++++++++++++---------
 target/s390x/cpu.c              |  3 ++-
 tests/check-qom-proplist.c      |  7 ++++---
 tests/test-qdev-global-props.c  |  5 +++--
 65 files changed, 157 insertions(+), 126 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 6edada8e9e..2fb28c13ac 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -341,7 +341,7 @@ static void cryptodev_vhost_user_instance_int(Object *obj)
     object_property_add_str(obj, "chardev",
                             cryptodev_vhost_user_get_chardev,
                             cryptodev_vhost_user_set_chardev,
-                            NULL);
+                            &error_abort);
 }
 
 static void cryptodev_vhost_user_finalize(Object *obj)
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index e380519408..58fb73f03a 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -139,7 +139,7 @@ static void rng_egd_init(Object *obj)
 {
     object_property_add_str(obj, "chardev",
                             rng_egd_get_chardev, rng_egd_set_chardev,
-                            NULL);
+                            &error_abort);
 }
 
 static void rng_egd_finalize(Object *obj)
diff --git a/backends/rng-random.c b/backends/rng-random.c
index a810581393..6429276a95 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -111,7 +111,7 @@ static void rng_random_init(Object *obj)
     object_property_add_str(obj, "filename",
                             rng_random_get_filename,
                             rng_random_set_filename,
-                            NULL);
+                            &error_abort);
 
     s->filename = g_strdup("/dev/urandom");
     s->fd = -1;
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 2bf3406525..491da81653 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -177,7 +177,8 @@ static char *get_chardev(Object *obj, Error **errp)
 
 static void vhost_user_backend_init(Object *obj)
 {
-    object_property_add_str(obj, "chardev", get_chardev, set_chardev, NULL);
+    object_property_add_str(obj, "chardev", get_chardev, set_chardev,
+                            &error_abort);
 }
 
 static void vhost_user_backend_finalize(Object *obj)
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index a111e91069..201123dd05 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -43,12 +43,14 @@ static void bcm2835_peripherals_init(Object *obj)
 
     /* Memory region for peripheral devices, which we export to our parent */
     memory_region_init(&s->peri_mr, obj,"bcm2835-peripherals", 0x1000000);
-    object_property_add_child(obj, "peripheral-io", OBJECT(&s->peri_mr), NULL);
+    object_property_add_child(obj, "peripheral-io", OBJECT(&s->peri_mr),
+                              &error_abort);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_mr);
 
     /* Internal memory region for peripheral bus addresses (not exported) */
     memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << 32);
-    object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL);
+    object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr),
+                              &error_abort);
 
     /* Internal memory region for request/response communication with
      * mailbox-addressable peripherals (not exported)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index ed683eeea5..7f79c4eb13 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -749,11 +749,11 @@ static void vexpress_instance_init(Object *obj)
     /* EL3 is enabled by default on vexpress */
     vms->secure = true;
     object_property_add_bool(obj, "secure", vexpress_get_secure,
-                             vexpress_set_secure, NULL);
+                             vexpress_set_secure, &error_abort);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM "
                                     "Security Extensions (TrustZone)",
-                                    NULL);
+                                    &error_abort);
 }
 
 static void vexpress_a15_instance_init(Object *obj)
@@ -766,12 +766,12 @@ static void vexpress_a15_instance_init(Object *obj)
      */
     vms->virt = true;
     object_property_add_bool(obj, "virtualization", vexpress_get_virt,
-                             vexpress_set_virt, NULL);
+                             vexpress_set_virt, &error_abort);
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable the ARM "
                                     "Virtualization Extensions "
                                     "(defaults to same as 'secure')",
-                                    NULL);
+                                    &error_abort);
 }
 
 static void vexpress_a9_instance_init(Object *obj)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bd645ad818..e4d233ec58 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -178,21 +178,21 @@ static void xlnx_zcu102_machine_instance_init(Object *obj)
     /* Default to secure mode being disabled */
     s->secure = false;
     object_property_add_bool(obj, "secure", zcu102_get_secure,
-                             zcu102_set_secure, NULL);
+                             zcu102_set_secure, &error_abort);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM "
                                     "Security Extensions (TrustZone)",
-                                    NULL);
+                                    &error_abort);
 
     /* Default to virt (EL2) being disabled */
     s->virt = false;
     object_property_add_bool(obj, "virtualization", zcu102_get_virt,
-                             zcu102_set_virt, NULL);
+                             zcu102_set_virt, &error_abort);
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable emulating a "
                                     "guest CPU which implements the ARM "
                                     "Virtualization Extensions",
-                                    NULL);
+                                    &error_abort);
 }
 
 static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 33bc9e2f92..29b499260d 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2812,10 +2812,10 @@ static void isabus_fdc_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &isa->bootindexA,
                                   "bootindexA", "/floppy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj), &error_abort);
     device_add_bootindex_property(obj, &isa->bootindexB,
                                   "bootindexB", "/floppy@1",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj), &error_abort);
 }
 
 static const TypeInfo isa_fdc_info = {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 17df5338e7..22ddccefce 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -477,7 +477,7 @@ static void vhost_user_blk_instance_init(Object *obj)
     VHostUserBlk *s = VHOST_USER_BLK(obj);
 
     device_add_bootindex_property(obj, &s->bootindex, "bootindex",
-                                  "/disk@0,0", DEVICE(obj), NULL);
+                                  "/disk@0,0", DEVICE(obj), &error_abort);
 }
 
 static const VMStateDescription vmstate_vhost_user_blk = {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 97ba8a2187..5af420fd15 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1248,7 +1248,7 @@ static void virtio_blk_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.conf.bootindex,
                                   "bootindex", "/disk@0,0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj), &error_abort);
 }
 
 static const VMStateDescription vmstate_virtio_blk = {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index de0c425605..6c114cdd6b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -894,7 +894,7 @@ static void machine_initfn(Object *obj)
                                  &error_abort);
         object_property_set_description(obj, "nvdimm",
                                         "Set on/off to enable/disable "
-                                        "NVDIMM instantiation", NULL);
+                                        "NVDIMM instantiation", &error_abort);
 
         object_property_add_str(obj, "nvdimm-persistence",
                                 machine_get_nvdimm_persistence,
@@ -903,7 +903,7 @@ static void machine_initfn(Object *obj)
         object_property_set_description(obj, "nvdimm-persistence",
                                         "Set NVDIMM persistence"
                                         "Valid values are cpu, mem-ctrl",
-                                        NULL);
+                                        &error_abort);
     }
 
     if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
@@ -914,7 +914,7 @@ static void machine_initfn(Object *obj)
         object_property_set_description(obj, "hmat",
                                         "Set on/off to enable/disable "
                                         "ACPI Heterogeneous Memory Attribute "
-                                        "Table (HMAT)", NULL);
+                                        "Table (HMAT)", &error_abort);
     }
 
     object_property_add_str(obj, "memory-backend",
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 9874c5c870..aa0040f8e6 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -76,9 +76,9 @@ static void cpu_core_instance_init(Object *obj)
     CPUCore *core = CPU_CORE(obj);
 
     object_property_add(obj, "core-id", "int", core_prop_get_core_id,
-                        core_prop_set_core_id, NULL, NULL, NULL);
+                        core_prop_set_core_id, NULL, NULL, &error_abort);
     object_property_add(obj, "nr-threads", "int", core_prop_get_nr_threads,
-                        core_prop_set_nr_threads, NULL, NULL, NULL);
+                        core_prop_set_nr_threads, NULL, NULL, &error_abort);
     core->nr_threads = ms->smp.threads;
 }
 
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 6b9db86e36..423943bd35 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
@@ -270,7 +271,8 @@ static void pci_std_vga_init(Object *obj)
 {
     /* Expose framebuffer byteorder via QOM */
     object_property_add_bool(obj, "big-endian-framebuffer",
-                             vga_get_big_endian_fb, vga_set_big_endian_fb, NULL);
+                             vga_get_big_endian_fb, vga_set_big_endian_fb,
+                             &error_abort);
 }
 
 static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
@@ -321,7 +323,8 @@ static void pci_secondary_vga_init(Object *obj)
 {
     /* Expose framebuffer byteorder via QOM */
     object_property_add_bool(obj, "big-endian-framebuffer",
-                             vga_get_big_endian_fb, vga_set_big_endian_fb, NULL);
+                             vga_get_big_endian_fb, vga_set_big_endian_fb,
+                             &error_abort);
 }
 
 static void pci_secondary_vga_reset(DeviceState *dev)
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 7058443797..af5958d256 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1249,11 +1249,11 @@ static void xlnx_dp_init(Object *obj)
      * Initialize DPCD and EDID..
      */
     s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd"));
-    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd), NULL);
+    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd), &error_abort);
 
     s->edid = I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2c-ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
-    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid), NULL);
+    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid), &error_abort);
 
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 3e4da0c47f..cd751b6d63 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -264,7 +264,7 @@ static void sparc32_dma_device_init(Object *obj)
     object_property_add_link(OBJECT(dev), "iommu", TYPE_SUN4M_IOMMU,
                              (Object **) &s->iommu,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     qdev_init_gpio_in(dev, dma_set_irq, 1);
     qdev_init_gpio_out(dev, s->gpio, 2);
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index e52fcfd9a0..8aed5c4583 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -873,7 +873,7 @@ static void aspeed_gpio_init(Object *obj)
         name = g_strdup_printf("gpio%s%d", props->group_label[group_idx],
                                pin_idx % GPIOS_PER_GROUP);
         object_property_add(obj, name, "bool", aspeed_gpio_get_pin,
-                            aspeed_gpio_set_pin, NULL, NULL, NULL);
+                            aspeed_gpio_set_pin, NULL, NULL, &error_abort);
         g_free(name);
     }
 }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index a9f25e5d02..c4e20a246f 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/qdev-properties.h"
@@ -459,7 +460,8 @@ static void macio_ide_initfn(Object *obj)
 
     object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
                              (Object **) &s->dbdma,
-                             qdev_prop_allow_set_link_before_realize, 0, NULL);
+                             qdev_prop_allow_set_link_before_realize, 0,
+                             &error_abort);
 }
 
 static Property macio_ide_properties[] = {
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index c22afdb8ee..a25c424bdf 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -266,8 +266,8 @@ static void ide_dev_instance_init(Object *obj)
 {
     object_property_add(obj, "bootindex", "int32",
                         ide_dev_get_bootindex,
-                        ide_dev_set_bootindex, NULL, NULL, NULL);
-    object_property_set_int(obj, -1, "bootindex", NULL);
+                        ide_dev_set_bootindex, NULL, NULL, &error_abort);
+    object_property_set_int(obj, -1, "bootindex", &error_abort);
 }
 
 static void ide_hd_realize(IDEDevice *dev, Error **errp)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 9ec0f2deb2..710deed276 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -445,7 +445,7 @@ static void apic_common_initfn(Object *obj)
     s->id = s->initial_apic_id = -1;
     object_property_add(obj, "id", "uint32",
                         apic_common_get_id,
-                        apic_common_set_id, NULL, NULL, NULL);
+                        apic_common_set_id, NULL, NULL, &error_abort);
 }
 
 static void apic_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 8e426d24bb..be9f145dfd 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -110,10 +110,10 @@ static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
-                        NULL, NULL);
+                        NULL, &error_abort);
 
     object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
-                        nvdimm_set_uuid, NULL, NULL, NULL);
+                        nvdimm_set_uuid, NULL, NULL, &error_abort);
 }
 
 static void nvdimm_finalize(Object *obj)
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 7b466bf19a..6154cd23d8 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -255,7 +255,7 @@ static void aspeed_sdmc_initfn(Object *obj)
 {
     object_property_add(obj, "ram-size", "int",
                         aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size,
-                        NULL, NULL, NULL);
+                        NULL, NULL, &error_abort);
 }
 
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index ff10f5b794..9ecbfc767b 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
 #include "hw/hw.h"
@@ -403,7 +404,7 @@ static void edu_instance_init(Object *obj)
     edu->dma_mask = (1UL << 28) - 1;
     object_property_add_uint64_ptr(obj, "dma_mask",
                                    &edu->dma_mask, OBJ_PROP_FLAG_READWRITE,
-                                   NULL);
+                                   &error_abort);
 }
 
 static void edu_class_init(ObjectClass *class, void *data)
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index fffb64a7d5..3c40256ae5 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -241,7 +241,7 @@ static void macio_oldworld_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_HEATHROW,
                              (Object **) &os->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
 
@@ -401,7 +401,7 @@ static void macio_newworld_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &ns->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     macio_init_child_obj(s, "gpio", &ns->gpio, sizeof(ns->gpio),
                          TYPE_MACIO_GPIO);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index b8466a4a3f..22b380e2fd 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "hw/ppc/mac.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
@@ -773,7 +774,7 @@ static void pmu_init(Object *obj)
     object_property_add_link(obj, "gpio", TYPE_MACIO_GPIO,
                              (Object **) &s->gpio,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     sysbus_init_child_obj(obj, "mos6522-pmu", &s->mos6522_pmu,
                           sizeof(s->mos6522_pmu), TYPE_MOS6522_PMU);
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index efd961e041..9abb84cb24 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -298,7 +298,7 @@ static void pca9552_initfn(Object *obj)
 
         name = g_strdup_printf("led%d", led);
         object_property_add(obj, name, "bool", pca9552_get_led, pca9552_set_led,
-                            NULL, NULL, NULL);
+                            NULL, NULL, &error_abort);
         g_free(name);
     }
 }
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 75ddad3a12..e3e1f03e51 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -245,7 +245,7 @@ static void tmp105_initfn(Object *obj)
 {
     object_property_add(obj, "temperature", "int",
                         tmp105_get_temperature,
-                        tmp105_set_temperature, NULL, NULL, NULL);
+                        tmp105_set_temperature, NULL, NULL, &error_abort);
 }
 
 static void tmp105_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index c0bc150bca..a49835f6b6 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -347,16 +347,16 @@ static void tmp421_initfn(Object *obj)
 {
     object_property_add(obj, "temperature0", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL, &error_abort);
     object_property_add(obj, "temperature1", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL, &error_abort);
     object_property_add(obj, "temperature2", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL, &error_abort);
     object_property_add(obj, "temperature3", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL, &error_abort);
 }
 
 static void tmp421_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 2a69eee63f..6b76e71e4c 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -26,6 +26,7 @@
 
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
@@ -1774,7 +1775,7 @@ static void e1000_instance_init(Object *obj)
     E1000State *n = E1000(obj);
     device_add_bootindex_property(obj, &n->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(n), NULL);
+                                  DEVICE(n), &error_abort);
 }
 
 static const TypeInfo e1000_base_info = {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 688724db0b..436a40225b 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -38,6 +38,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
+#include "qapi/error.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "migration/vmstate.h"
 #include "hw/net/lance.h"
@@ -134,7 +135,7 @@ static void lance_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj), &error_abort);
 }
 
 static Property lance_properties[] = {
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 52637a562d..7c7e9f3366 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "net/eth.h"
@@ -152,7 +153,7 @@ static void lasi_82596_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(obj), NULL);
+                                  DEVICE(obj), &error_abort);
 }
 
 static Property lasi_82596_properties[] = {
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index e744eff153..fece06c59f 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -133,8 +133,8 @@ static void isa_ne2000_instance_init(Object *obj)
 {
     object_property_add(obj, "bootindex", "int32",
                         isa_ne2000_get_bootindex,
-                        isa_ne2000_set_bootindex, NULL, NULL, NULL);
-    object_property_set_int(obj, -1, "bootindex", NULL);
+                        isa_ne2000_set_bootindex, NULL, NULL, &error_abort);
+    object_property_set_int(obj, -1, "bootindex", &error_abort);
 }
 static const TypeInfo ne2000_isa_info = {
     .name          = TYPE_ISA_NE2000,
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index a2377025a7..f81b39c812 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "net/net.h"
 #include "migration/vmstate.h"
 #include "hw/ppc/spapr.h"
@@ -340,7 +341,7 @@ static void spapr_vlan_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &dev->nicconf.bootindex,
                                   "bootindex", "",
-                                  DEVICE(dev), NULL);
+                                  DEVICE(dev), &error_abort);
 
     if (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) {
         for (i = 0; i < RX_MAX_POOLS; i++) {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eddfa7f923..ba93984c6d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3122,7 +3122,7 @@ static void virtio_net_instance_init(Object *obj)
     n->config_size = sizeof(struct virtio_net_config);
     device_add_bootindex_property(obj, &n->nic_conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  DEVICE(n), NULL);
+                                  DEVICE(n), &error_abort);
 }
 
 static int virtio_net_pre_save(void *opaque)
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 24ccdf6ceb..89e37c4bf8 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -109,7 +109,7 @@ static void grackle_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_HEATHROW,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     sysbus_init_mmio(sbd, &phb->conf_mem);
     sysbus_init_mmio(sbd, &phb->data_mem);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index d980c97049..512ff600a6 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -212,19 +212,19 @@ static void i440fx_pcihost_initfn(Object *obj)
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         i440fx_pcihost_get_pci_hole_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
                         i440fx_pcihost_get_pci_hole_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
                         i440fx_pcihost_get_pci_hole64_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
                         i440fx_pcihost_get_pci_hole64_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 }
 
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 1a02e9a670..22dc3bd033 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -311,7 +311,7 @@ static void raven_pcihost_initfn(Object *obj)
     pci_dev = DEVICE(&s->pci_dev);
     qdev_set_parent_bus(pci_dev, BUS(&s->pci_bus));
     object_property_set_int(OBJECT(&s->pci_dev), PCI_DEVFN(0, 0), "addr",
-                            NULL);
+                            &error_abort);
     qdev_prop_set_bit(pci_dev, "multifunction", false);
 }
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 2bbc90b28f..f05fbae3c9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -222,38 +222,43 @@ static void q35_host_initfn(Object *obj)
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
                         q35_host_get_pci_hole_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
                         q35_host_get_pci_hole64_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
                         q35_host_get_pci_hole64_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
-                                   &pehb->size, OBJ_PROP_FLAG_READ, NULL);
+                                   &pehb->size, OBJ_PROP_FLAG_READ,
+                                   &error_abort);
 
     object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.ram_memory,
-                             qdev_prop_allow_set_link_before_realize, 0, NULL);
+                             qdev_prop_allow_set_link_before_realize, 0,
+                             &error_abort);
 
     object_property_add_link(obj, MCH_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.pci_address_space,
-                             qdev_prop_allow_set_link_before_realize, 0, NULL);
+                             qdev_prop_allow_set_link_before_realize, 0,
+                             &error_abort);
 
     object_property_add_link(obj, MCH_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.system_memory,
-                             qdev_prop_allow_set_link_before_realize, 0, NULL);
+                             qdev_prop_allow_set_link_before_realize, 0,
+                             &error_abort);
 
     object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
                              (Object **) &s->mch.address_space_io,
-                             qdev_prop_allow_set_link_before_realize, 0, NULL);
+                             qdev_prop_allow_set_link_before_realize, 0,
+                             &error_abort);
 }
 
 static const TypeInfo q35_host_info = {
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 2b8503b709..b02c56def5 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
@@ -442,7 +443,7 @@ static void sabre_init(Object *obj)
     object_property_add_link(obj, "iommu", TYPE_SUN4U_IOMMU,
                              (Object **) &s->iommu,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     /* sabre_config */
     memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, s,
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index cf70b76fe2..14e619d1d3 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/ppc/mac.h"
 #include "hw/qdev-properties.h"
@@ -175,7 +176,7 @@ static void pci_unin_main_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
@@ -223,7 +224,7 @@ static void pci_u3_agp_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
@@ -262,7 +263,7 @@ static void pci_unin_agp_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
@@ -299,7 +300,7 @@ static void pci_unin_internal_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0, &error_abort);
 
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 14e4dfe8b1..c0d2bf4c9a 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
@@ -189,7 +190,7 @@ static void pxa2xx_pcmcia_initfn(Object *obj)
     object_property_add_link(obj, "card", TYPE_PCMCIA_CARD,
                              (Object **)&s->card,
                              NULL, /* read-only property */
-                             0, NULL);
+                             0, &error_abort);
 }
 
 /* Insert a new card into a slot */
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 47e6bb12f9..5537468e20 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -584,11 +584,11 @@ static void spapr_dr_connector_instance_init(Object *obj)
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ,
-                                   NULL);
+                                   &error_abort);
     object_property_add(obj, "index", "uint32", prop_get_index,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL, &error_abort);
     drc->state = drck->empty_state;
 }
 
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index e8e8d65ec0..e82b0db598 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -104,7 +104,7 @@ static void spapr_rng_instance_init(Object *obj)
 
     object_property_set_description(obj, "rng",
                                     "ID of the random number generator backend",
-                                    NULL);
+                                    &error_abort);
 }
 
 static void spapr_rng_realize(DeviceState *dev, Error **errp)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b6c27bc970..6fda0db71e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -487,11 +487,11 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
 
     s->start_in_flash = false;
     object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
-                             sifive_u_set_start_in_flash, NULL);
+                             sifive_u_set_start_in_flash, &error_abort);
     object_property_set_description(obj, "start-in-flash",
                                     "Set on to tell QEMU's ROM to jump to "
                                     "flash. Otherwise QEMU will jump to DRAM",
-                                    NULL);
+                                    &error_abort);
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 9d6972afa8..a1c555fb84 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -449,18 +449,18 @@ static void init_event_facility(Object *obj)
     event_facility->allow_all_mask_sizes = true;
     object_property_add_bool(obj, "allow_all_mask_sizes",
                              sclp_event_get_allow_all_mask_sizes,
-                             sclp_event_set_allow_all_mask_sizes, NULL);
+                             sclp_event_set_allow_all_mask_sizes, &error_abort);
     /* Spawn a new bus for SCLP events */
     qbus_create_inplace(&event_facility->sbus, sizeof(event_facility->sbus),
                         TYPE_SCLP_EVENTS_BUS, sdev, NULL);
 
     new = object_new(TYPE_SCLP_QUIESCE);
-    object_property_add_child(obj, TYPE_SCLP_QUIESCE, new, NULL);
+    object_property_add_child(obj, TYPE_SCLP_QUIESCE, new, &error_abort);
     object_unref(new);
     qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
 
     new = object_new(TYPE_SCLP_CPU_HOTPLUG);
-    object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new, NULL);
+    object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new, &error_abort);
     object_unref(new);
     qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
     /* the facility will automatically realize the devices via the bus */
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 0c5a5b60bd..f67306de13 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -151,7 +151,7 @@ static void s390_ccw_instance_init(Object *obj)
     S390CCWDevice *dev = S390_CCW_DEVICE(obj);
 
     device_add_bootindex_property(obj, &dev->bootindex, "bootindex",
-                                  "/disk@0,0", DEVICE(obj), NULL);
+                                  "/disk@0,0", DEVICE(obj), &error_abort);
 }
 
 static void s390_ccw_class_init(ObjectClass *klass, void *data)
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index a9a4ae7b39..8dbb0eb48a 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -400,8 +400,8 @@ static void s390_skeys_instance_init(Object *obj)
 {
     object_property_add_bool(obj, "migration-enabled",
                              s390_skeys_get_migration_enabled,
-                             s390_skeys_set_migration_enabled, NULL);
-    object_property_set_bool(obj, true, "migration-enabled", NULL);
+                             s390_skeys_set_migration_enabled, &error_abort);
+    object_property_set_bool(obj, true, "migration-enabled", &error_abort);
 }
 
 static void s390_skeys_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 58121b9f68..f73139c939 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -387,8 +387,8 @@ static void s390_stattrib_instance_init(Object *obj)
 
     object_property_add_bool(obj, "migration-enabled",
                              s390_stattrib_get_migration_enabled,
-                             s390_stattrib_set_migration_enabled, NULL);
-    object_property_set_bool(obj, true, "migration-enabled", NULL);
+                             s390_stattrib_set_migration_enabled, &error_abort);
+    object_property_set_bool(obj, true, "migration-enabled", &error_abort);
     sas->migration_cur_gfn = 0;
 }
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f0c35aa57a..dbfa4c8514 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -349,7 +349,7 @@ static void sclp_init(Object *obj)
     Object *new;
 
     new = object_new(TYPE_SCLP_EVENT_FACILITY);
-    object_property_add_child(obj, TYPE_SCLP_EVENT_FACILITY, new, NULL);
+    object_property_add_child(obj, TYPE_SCLP_EVENT_FACILITY, new, &error_abort);
     object_unref(new);
     sclp->event_facility = EVENT_FACILITY(new);
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1c980cab38..339635d99e 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1738,7 +1738,7 @@ static void scsi_dev_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", NULL,
-                                  &s->qdev, NULL);
+                                  &s->qdev, &error_abort);
 }
 
 static const TypeInfo scsi_device_type_info = {
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index c57850a505..15f9c0c188 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1361,7 +1361,7 @@ static void xlnx_zynqmp_qspips_init(Object *obj)
                              (Object **)&rq->dma,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG,
-                             NULL);
+                             &error_abort);
 }
 
 static int xilinx_spips_post_load(void *opaque, int version_id)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index c9a390063f..c076d2d436 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -754,11 +754,11 @@ static void usb_device_instance_init(Object *obj)
     if (klass->attached_settable) {
         object_property_add_bool(obj, "attached",
                                  usb_get_attached, usb_set_attached,
-                                 NULL);
+                                 &error_abort);
     } else {
         object_property_add_bool(obj, "attached",
                                  usb_get_attached, NULL,
-                                 NULL);
+                                 &error_abort);
     }
 }
 
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 6210427544..d56b9c4ad0 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1381,7 +1381,7 @@ static void usb_net_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
-                                  &dev->qdev, NULL);
+                                  &dev->qdev, &error_abort);
 }
 
 static const VMStateDescription vmstate_usb_net = {
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 5c4b57b06b..6e8d1fbd60 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -753,8 +753,8 @@ static void usb_msd_instance_init(Object *obj)
 {
     object_property_add(obj, "bootindex", "int32",
                         usb_msd_get_bootindex,
-                        usb_msd_set_bootindex, NULL, NULL, NULL);
-    object_property_set_int(obj, -1, "bootindex", NULL);
+                        usb_msd_set_bootindex, NULL, NULL, &error_abort);
+    object_property_set_int(obj, -1, "bootindex", &error_abort);
 }
 
 static void usb_msd_class_bot_initfn(ObjectClass *klass, void *data)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 2ac7a936fb..a25b590dde 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1101,7 +1101,7 @@ static void usb_host_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &s->bootindex,
                                   "bootindex", NULL,
-                                  &udev->qdev, NULL);
+                                  &udev->qdev, &error_abort);
 }
 
 static void usb_host_unrealize(USBDevice *udev, Error **errp)
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 45d8b76218..f1fe21e1a4 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2595,7 +2595,7 @@ static void usbredir_instance_init(Object *obj)
 
     device_add_bootindex_property(obj, &dev->bootindex,
                                   "bootindex", NULL,
-                                  &udev->qdev, NULL);
+                                  &udev->qdev, &error_abort);
 }
 
 static const TypeInfo usbredir_dev_info = {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..d528cf5de7 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -893,12 +893,12 @@ static void virtio_balloon_instance_init(Object *obj)
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
 
     object_property_add(obj, "guest-stats", "guest statistics",
-                        balloon_stats_get_all, NULL, NULL, s, NULL);
+                        balloon_stats_get_all, NULL, NULL, s, &error_abort);
 
     object_property_add(obj, "guest-stats-polling-interval", "int",
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
-                        NULL, s, NULL);
+                        NULL, s, &error_abort);
 }
 
 static const VMStateDescription vmstate_virtio_balloon = {
diff --git a/net/dump.c b/net/dump.c
index 23b3628dde..ea738ff7c3 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -232,9 +232,9 @@ static void filter_dump_instance_init(Object *obj)
     nfds->maxlen = 65536;
 
     object_property_add(obj, "maxlen", "uint32", filter_dump_get_maxlen,
-                        filter_dump_set_maxlen, NULL, NULL, NULL);
+                        filter_dump_set_maxlen, NULL, NULL, &error_abort);
     object_property_add_str(obj, "file", file_dump_get_filename,
-                            file_dump_set_filename, NULL);
+                            file_dump_set_filename, &error_abort);
 }
 
 static void filter_dump_instance_finalize(Object *obj)
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 12e0254287..b9fa2d5c57 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -192,7 +192,7 @@ static void filter_buffer_init(Object *obj)
 {
     object_property_add(obj, "interval", "uint32",
                         filter_buffer_get_interval,
-                        filter_buffer_set_interval, NULL, NULL, NULL);
+                        filter_buffer_set_interval, NULL, NULL, &error_abort);
 }
 
 static const TypeInfo filter_buffer_info = {
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index d83e815545..3893dd299c 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -392,12 +392,12 @@ static void filter_mirror_init(Object *obj)
     MirrorState *s = FILTER_MIRROR(obj);
 
     object_property_add_str(obj, "outdev", filter_mirror_get_outdev,
-                            filter_mirror_set_outdev, NULL);
+                            filter_mirror_set_outdev, &error_abort);
 
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_mirror_get_vnet_hdr,
-                             filter_mirror_set_vnet_hdr, NULL);
+                             filter_mirror_set_vnet_hdr, &error_abort);
 }
 
 static void filter_redirector_init(Object *obj)
@@ -405,14 +405,14 @@ static void filter_redirector_init(Object *obj)
     MirrorState *s = FILTER_REDIRECTOR(obj);
 
     object_property_add_str(obj, "indev", filter_redirector_get_indev,
-                            filter_redirector_set_indev, NULL);
+                            filter_redirector_set_indev, &error_abort);
     object_property_add_str(obj, "outdev", filter_redirector_get_outdev,
-                            filter_redirector_set_outdev, NULL);
+                            filter_redirector_set_outdev, &error_abort);
 
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_redirector_get_vnet_hdr,
-                             filter_redirector_set_vnet_hdr, NULL);
+                             filter_redirector_set_vnet_hdr, &error_abort);
 }
 
 static void filter_mirror_fini(Object *obj)
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 31da08a2f4..7d713c7193 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "trace.h"
 #include "colo.h"
 #include "net/filter.h"
@@ -413,7 +414,7 @@ static void filter_rewriter_init(Object *obj)
     s->failover_mode = FAILOVER_MODE_OFF;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_rewriter_get_vnet_hdr,
-                             filter_rewriter_set_vnet_hdr, NULL);
+                             filter_rewriter_set_vnet_hdr, &error_abort);
 }
 
 static void colo_rewriter_class_init(ObjectClass *oc, void *data)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 62d36f9e8d..6a0a668e17 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -782,11 +782,11 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
 static void aarch64_cpu_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
-                             aarch64_cpu_set_aarch64, NULL);
+                             aarch64_cpu_set_aarch64, &error_abort);
     object_property_set_description(obj, "aarch64",
                                     "Set on/off to enable/disable aarch64 "
                                     "execution state ",
-                                    NULL);
+                                    &error_abort);
 }
 
 static void aarch64_cpu_finalizefn(Object *obj)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c256ab159..f5795788bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6905,28 +6905,32 @@ static void x86_cpu_initfn(Object *obj)
 
     object_property_add(obj, "family", "int",
                         x86_cpuid_version_get_family,
-                        x86_cpuid_version_set_family, NULL, NULL, NULL);
+                        x86_cpuid_version_set_family, NULL, NULL,
+                        &error_abort);
     object_property_add(obj, "model", "int",
                         x86_cpuid_version_get_model,
-                        x86_cpuid_version_set_model, NULL, NULL, NULL);
+                        x86_cpuid_version_set_model, NULL, NULL,
+                        &error_abort);
     object_property_add(obj, "stepping", "int",
                         x86_cpuid_version_get_stepping,
-                        x86_cpuid_version_set_stepping, NULL, NULL, NULL);
+                        x86_cpuid_version_set_stepping, NULL, NULL,
+                        &error_abort);
     object_property_add_str(obj, "vendor",
                             x86_cpuid_get_vendor,
-                            x86_cpuid_set_vendor, NULL);
+                            x86_cpuid_set_vendor, &error_abort);
     object_property_add_str(obj, "model-id",
                             x86_cpuid_get_model_id,
-                            x86_cpuid_set_model_id, NULL);
+                            x86_cpuid_set_model_id, &error_abort);
     object_property_add(obj, "tsc-frequency", "int",
                         x86_cpuid_get_tsc_freq,
-                        x86_cpuid_set_tsc_freq, NULL, NULL, NULL);
+                        x86_cpuid_set_tsc_freq, NULL, NULL, &error_abort);
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
-                        NULL, NULL, (void *)env->features, NULL);
+                        NULL, NULL, (void *)env->features, &error_abort);
     object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
-                        NULL, NULL, (void *)cpu->filtered_features, NULL);
+                        NULL, NULL, (void *)cpu->filtered_features,
+                        &error_abort);
     /*
      * The "unavailable-features" property has the same semantics as
      * CpuDefinitionInfo.unavailable-features on the "query-cpu-definitions"
@@ -6938,7 +6942,8 @@ static void x86_cpu_initfn(Object *obj)
                         NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, "crash-information", "GuestPanicInformation",
-                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
+                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL,
+                        &error_abort);
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 427a46e3e1..1ae550867e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -287,7 +287,8 @@ static void s390_cpu_initfn(Object *obj)
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
-                        s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
+                        s390_cpu_get_crash_info_qom, NULL, NULL, NULL,
+                        &error_abort);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
     cpu->env.tod_timer =
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index a8b2958e6e..999eb1ce40 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -255,13 +255,14 @@ static void dummy_dev_init(Object *obj)
     DummyBus *bus = DUMMY_BUS(object_new(TYPE_DUMMY_BUS));
     DummyBackend *backend = DUMMY_BACKEND(object_new(TYPE_DUMMY_BACKEND));
 
-    object_property_add_child(obj, "bus", OBJECT(bus), NULL);
+    object_property_add_child(obj, "bus", OBJECT(bus), &error_abort);
     dev->bus = bus;
-    object_property_add_child(OBJECT(bus), "backend", OBJECT(backend), NULL);
+    object_property_add_child(OBJECT(bus), "backend", OBJECT(backend),
+                              &error_abort);
     bus->backend = backend;
 
     object_property_add_link(obj, "backend", TYPE_DUMMY_BACKEND,
-                             (Object **)&bus->backend, NULL, 0, NULL);
+                             (Object **)&bus->backend, NULL, 0, &error_abort);
 }
 
 static void dummy_dev_unparent(Object *obj)
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 270c690479..5186c3cb36 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
 #include "qapi/visitor.h"
+#include "qapi/error.h"
 
 
 #define TYPE_STATIC_PROPS "static_prop_type"
@@ -151,9 +152,9 @@ static void prop2_accessor(Object *obj, Visitor *v, const char *name,
 static void dynamic_instance_init(Object *obj)
 {
     object_property_add(obj, "prop1", "uint32", prop1_accessor, prop1_accessor,
-                        NULL, NULL, NULL);
+                        NULL, NULL, &error_abort);
     object_property_add(obj, "prop2", "uint32", prop2_accessor, prop2_accessor,
-                        NULL, NULL, NULL);
+                        NULL, NULL, &error_abort);
 }
 
 static void dynamic_class_init(ObjectClass *oc, void *data)
-- 
2.21.1


