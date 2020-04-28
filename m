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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA7C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BB6206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5NuyA6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BB6206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTL0C-0006MV-Kl
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTJpI-00006Y-DR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <gorbak25@gmail.com>) id 1jTJkr-00083H-LH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:34:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gorbak25@gmail.com>)
 id 1jTJkr-00082u-7M
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:30:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id j1so23218826wrt.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 23:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yaK0Tjz4Mh+yIXINkTHSBD8ilpF6Ag6GsRW6Q4ivbTA=;
 b=R5NuyA6+wVEyDRerxt4JF4uR7UXbtDIJQluhU5qdZRUx9wPQijBaoWHuKExJN5wcHQ
 dVVb7NvWWvf+1x2czH+0zGPevI1byLqnHr0MPTULlbp1TmfLkOR7zhSX12CHtxPziZqE
 gIYYkCH2yH67+b14kvapCJJAkntr5shxNmrmXBWoPuyBdwMyFzJ3yTMESUZS+Y0tVk4w
 DTWuCjUR+LEPcrjoz1zyxDLbyWhlSB376x47pXgSXHBY/FF+FiAJhzVWWhXvFZ2IEc+f
 tHNOsxrLpYTCg1pxz6A04Dsg5icQdRwAAw0m5HdjYoYhhxeOJb88DkJS8DbXJXz+Th1F
 xAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yaK0Tjz4Mh+yIXINkTHSBD8ilpF6Ag6GsRW6Q4ivbTA=;
 b=PZE5sWksbPqiwpYcM3kS0Y7h8B8xcwBGHu6s9PhvueeK3Vcbid56AErTuMCC3VrxQg
 eijPZZ4w+fSpSdGzVRVcIDFSaNMMImL9pvMke5x1OE+Hq11y0BNO5TBI4UMQrADDOWUN
 zMxTdJPgWyGMHcksH1tNiNJaUxQXw1MPsCvZHN+mNnymNcZUgP+9kG73UA7d44f6Rbj9
 8VzofM9Tv9ChWxp3/ysnXbKPy+bOn9RKpu0ASWWX4STYcLi/YnBZ24X3b6ZfQ/wAeH/S
 obudP44cteV5YzVx4gmvIq1Bhc0TArrMB4+9spQflnxELjTWa6b6O65knFnZ+zeoRb5W
 he4g==
X-Gm-Message-State: AGi0PubAGcxFPzpwhZHu95mNAmVTlvrvSeIe118ECUgi2daDcwglQnaG
 O/I8Eu6t9iLNLqYCp9/tpY58FPfbLOZN4A==
X-Google-Smtp-Source: APiQypJu6V8g7t351GQHZKstcuogANA7URIwmgoWma5c7hYJSKzrp8DyniKXjLah1RJeLvvREzjpfw==
X-Received: by 2002:adf:f8c6:: with SMTP id f6mr34233073wrq.276.1588055403438; 
 Mon, 27 Apr 2020 23:30:03 -0700 (PDT)
Received: from localhost.localdomain (public-gprs351065.centertel.pl.
 [37.47.2.154])
 by smtp.gmail.com with ESMTPSA id a205sm2030564wmh.29.2020.04.27.23.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 23:30:02 -0700 (PDT)
From: Grzegorz Uriasz <gorbak25@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] Improve legacy vbios handling
Date: Tue, 28 Apr 2020 06:28:47 +0000
Message-Id: <20200428062847.7764-3-gorbak25@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200428062847.7764-1-gorbak25@gmail.com>
References: <20200428062847.7764-1-gorbak25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=gorbak25@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
X-Mailman-Approved-At: Tue, 28 Apr 2020 03:48:49 -0400
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
 hw/xen/xen_pt.c          |  8 +++++--
 hw/xen/xen_pt_graphics.c | 48 +++++++++++++++++++++++++++++++++++++---
 hw/xen/xen_pt_load_rom.c |  2 +-
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index b91082cb8b..ffc3559dd4 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -483,8 +483,12 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
                    i, r->size, r->base_addr, type);
     }
 
-    /* Register expansion ROM address */
-    if (d->rom.base_addr && d->rom.size) {
+    /*
+     * Register expansion ROM address. If we are dealing with a ROM
+     * shadow copy for legacy vga devices then don't bother to map it
+     * as previous code creates a proper shadow copy
+     */
+    if (d->rom.base_addr && d->rom.size && !(is_igd_vga_passthrough(d))) {
         uint32_t bar_data = 0;
 
         /* Re-set BAR reported by OS, otherwise ROM can't be read. */
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index a3bc7e3921..fe0ef2685c 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -129,7 +129,7 @@ int xen_pt_unregister_vga_regions(XenHostPCIDevice *dev)
     return 0;
 }
 
-static void *get_vgabios(XenPCIPassthroughState *s, int *size,
+static void *get_sysfs_vgabios(XenPCIPassthroughState *s, int *size,
                        XenHostPCIDevice *dev)
 {
     return pci_assign_dev_load_option_rom(&s->dev, size,
@@ -137,6 +137,45 @@ static void *get_vgabios(XenPCIPassthroughState *s, int *size,
                                           dev->dev, dev->func);
 }
 
+static void xen_pt_direct_vbios_copy(XenPCIPassthroughState *s, Error **errp)
+{
+    int fd = -1;
+    void *guest_bios = NULL;
+    void *host_vbios = NULL;
+    /* This is always 32 pages in the real mode reserved region */
+    int bios_size = 32 << XC_PAGE_SHIFT;
+    int vbios_addr = 0xc0000;
+
+    fd = open("/dev/mem", O_RDONLY);
+    if (fd == -1) {
+        error_setg(errp, "Can't open /dev/mem: %s", strerror(errno));
+        return;
+    }
+    host_vbios = mmap(NULL, bios_size,
+            PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, fd, vbios_addr);
+    close(fd);
+
+    if (host_vbios == MAP_FAILED) {
+        error_setg(errp, "Failed to mmap host vbios: %s", strerror(errno));
+        return;
+    }
+
+    memory_region_init_ram(&s->dev.rom, OBJECT(&s->dev),
+            "legacy_vbios.rom", bios_size, &error_abort);
+    guest_bios = memory_region_get_ram_ptr(&s->dev.rom);
+    memcpy(guest_bios, host_vbios, bios_size);
+
+    if (munmap(host_vbios, bios_size) == -1) {
+        XEN_PT_LOG(&s->dev, "Failed to unmap host vbios: %s\n", strerror(errno));
+    }
+
+    cpu_physical_memory_write(vbios_addr, guest_bios, bios_size);
+    memory_region_set_address(&s->dev.rom, vbios_addr);
+    pci_register_bar(&s->dev, PCI_ROM_SLOT, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->dev.rom);
+    s->dev.has_rom = true;
+    XEN_PT_LOG(&s->dev, "Legacy VBIOS registered\n");
+}
+
 /* Refer to Seabios. */
 struct rom_header {
     uint16_t signature;
@@ -179,9 +218,11 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         return;
     }
 
-    bios = get_vgabios(s, &bios_size, dev);
+    bios = get_sysfs_vgabios(s, &bios_size, dev);
     if (!bios) {
-        error_setg(errp, "VGA: Can't get VBIOS");
+        XEN_PT_LOG(&s->dev, "Unable to get host VBIOS from sysfs - "
+                            "falling back to a direct copy of memory ranges\n");
+        xen_pt_direct_vbios_copy(s, errp);
         return;
     }
 
@@ -223,6 +264,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
 
     /* Currently we fixed this address as a primary for legacy BIOS. */
     cpu_physical_memory_write(0xc0000, bios, bios_size);
+    XEN_PT_LOG(&s->dev, "Legacy VBIOS registered\n");
 }
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 9f100dc159..8cd9aa84dc 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -65,7 +65,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
         goto close_rom;
     }
 
-    pci_register_bar(dev, PCI_ROM_SLOT, 0, &dev->rom);
+    pci_register_bar(dev, PCI_ROM_SLOT, PCI_BASE_ADDRESS_SPACE_MEMORY, &dev->rom);
     dev->has_rom = true;
     *size = st.st_size;
 close_rom:
-- 
2.26.1


