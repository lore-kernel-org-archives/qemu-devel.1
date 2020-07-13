Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,WEIRD_QUOTING autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48062C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E9A206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H68kDhJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E9A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2lO-0006h0-8d
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2iC-0002DD-7G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:57:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv2iA-00085U-6y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:57:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id f2so17494324wrp.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8Ll1qrclIjkyFqPyTPWaB9zfmblOTcQIEKljCnPs7a4=;
 b=H68kDhJ78PHBSj2plV/IjHgXqd8gvZxfn4pnVW0sz9b07gOL3eqIlDwabqosAGq/WU
 QiUPz6nZqo2ZGPKGzTm44b8dB9JI2HRm8jp3U0RMZ0GZCenRhkoZbLMeH5JGj/fAT40b
 rb7afALgD9eWgpU8Kyv781ER7nVv6luEwM9v5iTi2hTQrIFD2T3tIQxFRh2YShen59lC
 QMpBZeQmkuEL8MYtuwF5RDKX0h4IvewAviJow1shcVpTn2mEDcj1nqOf75cGO/3IFbph
 a1gTjhfwe1In1DyB4t1ldARdxCzyGtubT6ojx7AkfJVq0+oBY5G4rE0i5UjvfwHTSq/g
 5Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Ll1qrclIjkyFqPyTPWaB9zfmblOTcQIEKljCnPs7a4=;
 b=sYvHZXYt2ukbEK910TJVueNTKypTpNel/pSwIrjsFK8x38ZtTvlrjkkwKRDS7b3kFH
 UvrJDUqtFVeaY54DXiz8qujGXq/ccgvnsgpiIPa9UfyQNthPdN1Engss0g/16Ty8BHoH
 ktuwTnuofDhgDFTG94qkd3Co8w56HxWAUyPGhtnTj2PXUOxtEA1LYva9Xhn5cD5nx+rX
 N1sywUb0Pb0SjuKZq4o8G29jCHFC7I7LNpAzQ63rMV+teOlDFSqnrgYwkHBUTGHc0vvo
 O6MjjA1wOwozWC31nBAtwXQzHuxE49PoVGb1iIrClEc6518jQNKLfhtkPL0tF4X7eLnc
 nd1A==
X-Gm-Message-State: AOAM532s48c3fzBKQusOVxcCXh1RSBoHFyhMu6ObUEhMOzfg/5hvQdTC
 hr81nceyHhdQXYRBq0InWVWfhQ==
X-Google-Smtp-Source: ABdhPJxNGC4hhjgIFd98GqhhDgraU2S8YBNHdywsOeSxUL8s9lXLCVFNY+Vlw9tinUOHG6hRjXpqGQ==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr615769wro.126.1594663072735; 
 Mon, 13 Jul 2020 10:57:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j4sm25723721wrp.51.2020.07.13.10.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 10:57:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1 4/4] docs/system: Document the arm virt board
Date: Mon, 13 Jul 2020 18:57:46 +0100
Message-Id: <20200713175746.5936-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713175746.5936-1-peter.maydell@linaro.org>
References: <20200713175746.5936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the arm 'virt' board, which has been undocumented
for far too long given that it is the main recommended board
type for arm guests.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst   | 157 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |   1 +
 MAINTAINERS                |   1 +
 3 files changed, 159 insertions(+)
 create mode 100644 docs/system/arm/virt.rst

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
new file mode 100644
index 00000000000..6a7823d8bca
--- /dev/null
+++ b/docs/system/arm/virt.rst
@@ -0,0 +1,157 @@
+'virt' generic virtual platform (``virt``)
+==========================================
+
+The `virt` board is a platform which does not correspond to any
+real hardware; it is designed for use in virtual machines.
+It is the recommended board type if you simply want to run
+a guest such as Linux and do not care about reproducing the
+idiosyncrasies and limitations of a particular bit of real-world
+hardware.
+
+This is a "versioned" board model, so as well as the ``virt`` machine
+type itself (which may have improvements, bugfixes and other minor
+changes between QEMU versions) a version is provided that guarantees
+to have the same behaviour as that of previous QEMU releases, so
+that VM migration will work between QEMU versions. For instance the
+``virt-5.0`` machine type will behave like the ``virt`` machine from
+the QEMU 5.0 release, and migration should work between ``virt-5.0``
+of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
+is not guaranteed to work between different QEMU releases for
+the non-versioned ``virt`` machine type.
+
+Supported devices
+"""""""""""""""""
+
+The virt board supports:
+
+- Flash memory
+- One PL011 UART
+- An RTC
+- The fw_cfg device that allows a guest to obtain data from QEMU
+- A PL061 GPIO controller
+- An optional SMMUv3 IOMMU
+- hotpluggable DIMMs
+- hotpluggable NVDIMs
+- 32 virtio-mmio transport devices
+- running guests using the KVM accelerator on aarch64 hardware
+- large amounts of RAM (at least 255GB, and more if using highmem)
+- many CPUs (up to 512 if using a GICv3 and highmem)
+- Secure-World-only devices if the CPU has TrustZone:
+
+  - A second PL011 UART
+  - A secure flash memory
+  - 16MB of secure RAM
+
+Supported guest CPU types:
+
+- ``cortex-a7`` (32-bit)
+- ``cortex-a15`` (32-bit; the default)
+- ``cortex-a53`` (64-bit)
+- ``cortex-a57`` (64-bit)
+- ``cortex-a72`` (64-bit)
+- ``host`` (with KVM only)
+- ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
+
+Note that the default is ``cortex-a15``, so for an AArch64 guest you must
+specify a CPU type.
+
+Graphics output is available, but unlike the x86 PC machine types
+there is no default display device enabled: you should select one from
+the Display devices section of "-device help". The recommended option
+is ``virtio-gpu-pci``; this is the only one which will work correctly
+with KVM. You may also need to ensure your guest kernel is configured
+with support for this; see below.
+
+Machine-specific options
+""""""""""""""""""""""""
+
+The following machine-specific options are supported:
+
+secure
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Security Extensions (TrustZone). The default is ``off``.
+
+virtualization
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Virtualization Extensions. The default is ``off``.
+
+highmem
+  Set ``on``/``off`` to enable/disable placing devices and RAM in physical
+  address space above 32 bits. The default is ``on`` for machine types
+  later than ``virt-2.12``.
+
+gic-version
+  Specify the version of the Generic Interrupt Controller (GIC) to provide.
+  Valid values are:
+
+  ``2``
+    GICv2
+  ``3``
+    GICv3
+  ``host``
+    Use the same GIC version the host provides, when using KVM
+  ``max``
+    Use the best GIC version possible (same as host when using KVM;
+    currently same as ``3``` for TCG, but this may change in future)
+
+its
+  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
+  for machine types later than ``virt-2.7``.
+
+iommu
+  Set the IOMMU type to create for the guest. Valid values are:
+
+  ``none``
+    Don't create an IOMMU (the default)
+  ``smmuv3``
+    Create an SMMUv3
+
+ras
+  Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
+  using ACPI and guest external abort exceptions. The default is off.
+
+Linux guest kernel configuration
+""""""""""""""""""""""""""""""""
+
+The 'defconfig' for Linux arm and arm64 kernels should include the
+right device drivers for virtio and the PCI controller; however some older
+kernel versions, especially for 32-bit Arm, did not have everything
+enabled by default. If you're not seeing PCI devices that you expect,
+then check that your guest config has::
+
+  CONFIG_PCI=y
+  CONFIG_VIRTIO_PCI=y
+  CONFIG_PCI_HOST_GENERIC=y
+
+If you want to use the ``virtio-gpu-pci`` graphics device you will also
+need::
+
+  CONFIG_DRM=y
+  CONFIG_DRM_VIRTIO_GPU=y
+
+Hardware configuration information for bare-metal programming
+"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+
+The ``virt`` board automatically generates a device tree blob ("dtb")
+which it passes to the guest. This provides information about the
+addresses, interrupt lines and other configuration of the various devices
+in the system. Guest code can rely on and hard-code the following
+addresses:
+
+- Flash memory starts at address 0x0000_0000
+
+- RAM starts at 0x4000_0000
+
+All other information about device locations may change between
+QEMU versions, so guest code must look in the DTB.
+
+QEMU supports two types of guest image boot for ``virt``, and
+the way for the guest code to locate the dtb binary differs:
+
+- For guests using the Linux kernel boot protocol (this means any
+  non-ELF file passed to the QEMU ``-kernel`` option) the address
+  of the DTB is passed in a register (``r2`` for 32-bit guests,
+  or ``x0`` for 64-bit guests)
+
+- For guests booting as "bare-metal" (any other kind of boot),
+  the DTB is at the start of RAM (0x4000_0000)
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 163ab915592..4c5b0e4aab8 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -92,6 +92,7 @@ undocumented; you can get a complete list by running
    arm/collie
    arm/sx1
    arm/stellaris
+   arm/virt
 
 Arm CPU features
 ================
diff --git a/MAINTAINERS b/MAINTAINERS
index 286b076da89..553760e5442 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -878,6 +878,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
+F: docs/system/arm/virt.rst
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-- 
2.20.1


