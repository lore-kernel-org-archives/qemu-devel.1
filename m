Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F48C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6A9218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsWLm5/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6A9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZoA-0000kk-28
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlT-0002Ja-SN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlR-00027G-Og
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlR-00023w-FN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id a9so2849947wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BEXM9DCtSB4wQYHKGFoho3KdlDT+RNE40DwDXtR7FIc=;
 b=bsWLm5/MSuNTcdFhZoTvVzLXgxZVPOcWT2GgN0OOVxdDouPVKlbxx6zbzwMiMr9ZJa
 5vND4b4lv0xd3ByqTu8adH+kwBIzSe7LnG15ujqYDDPFOxA7dUyd/gJgEK4hiWu/HgoB
 Z7oUZ6+4vE4tNtIoXgCPuBdMaGLQy4ueFHDD5F8+lIPLCXxYarhzWHfiIHi5qLrBpl/k
 O3uNhIsN3iki1NzKvsmTBKvXCN/oJFyNI6tjqvVeokh9TAg89LO04paaLAaz8+UplcUt
 jryHO2CpdsxkziM1WYe23Qpq1ZIRziZPdFn/ah4r2XNr75awHsUPMteOWwDuoeeALMcZ
 G5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BEXM9DCtSB4wQYHKGFoho3KdlDT+RNE40DwDXtR7FIc=;
 b=V9NB2uYDn+aix+hms1MxAY1Lo6+9XgvzebhplcYhDCgK3/U9nP1EnvT9e8NnZjePRq
 1Cgo9CQLo5IVXfl8n5bK+FpjPn3FEA0Hrdwo0SqD7SxbalNyNEWtldVzKjIr34bVFPRI
 ugKV6kBYAA4/PKIXQZXTO9snf7T3QuKyJ67UicBowMje7UbPg8rJW/kCw+mw4k9l2U/e
 fKz/ytJ9UDeHz2Jxht+L76QUwL35YCCs0b6k8l1gChsqCeFCRP5dqR5Ej/QZfe3kUjkl
 pDZc83XZpGysZ626TTnQ2imOrDVRajG2Yt5pQQJTPCPU94RJ84lVOmOTmGawhI+nbX5j
 Rybg==
X-Gm-Message-State: APjAAAWGq+jtUiPocEu9Hx1ahZJ41B/AyMdBhvjSlXX4bMqwz/4apdG0
 BOSbPMKtrIdac8KTqZV6VAF9RhGn
X-Google-Smtp-Source: APXvYqyN2rQ+K7NOflZhWCA84oeHtBUPbIb/HRp+llPEDoRbTIVkvqyyHMSp7nFY7Mt9JDq7nAdrRw==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4894428wmh.35.1582631556001; 
 Tue, 25 Feb 2020 03:52:36 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 097/136] Let cpu_[physical]_memory() calls pass a boolean
 'is_write' argument
Date: Tue, 25 Feb 2020 12:50:27 +0100
Message-Id: <1582631466-13880-97-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use an explicit boolean type.

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/exynos4210_fimd.c           |  3 ++-
 hw/display/milkymist-tmu2.c            |  8 ++++----
 hw/display/omap_dss.c                  |  2 +-
 hw/display/ramfb.c                     |  2 +-
 hw/misc/pc-testdev.c                   |  2 +-
 hw/nvram/spapr_nvram.c                 |  4 ++--
 hw/ppc/ppc440_uc.c                     |  6 ++++--
 hw/ppc/spapr_hcall.c                   |  4 ++--
 hw/s390x/ipl.c                         |  2 +-
 hw/s390x/s390-pci-bus.c                |  2 +-
 hw/s390x/virtio-ccw.c                  |  2 +-
 hw/xen/xen_pt_graphics.c               |  2 +-
 include/exec/cpu-common.h              |  4 ++--
 scripts/coccinelle/exec_rw_const.cocci | 14 ++++++++++++++
 target/i386/hax-all.c                  |  4 ++--
 target/s390x/excp_helper.c             |  2 +-
 target/s390x/helper.c                  |  6 +++---
 17 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c1071ec..ec67766 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1164,7 +1164,8 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
         goto error_return;
     }
 
-    w->host_fb_addr = cpu_physical_memory_map(fb_start_addr, &fb_mapped_len, 0);
+    w->host_fb_addr = cpu_physical_memory_map(fb_start_addr, &fb_mapped_len,
+                                              false);
     if (!w->host_fb_addr) {
         DPRINT_ERROR("Failed to map window %u framebuffer\n", win);
         goto error_return;
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 199f122..513c0d5 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -218,7 +218,7 @@ static void tmu2_start(MilkymistTMU2State *s)
     glGenTextures(1, &texture);
     glBindTexture(GL_TEXTURE_2D, texture);
     fb_len = 2ULL * s->regs[R_TEXHRES] * s->regs[R_TEXVRES];
-    fb = cpu_physical_memory_map(s->regs[R_TEXFBUF], &fb_len, 0);
+    fb = cpu_physical_memory_map(s->regs[R_TEXFBUF], &fb_len, false);
     if (fb == NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
@@ -262,7 +262,7 @@ static void tmu2_start(MilkymistTMU2State *s)
 
     /* Read the QEMU dest. framebuffer into the OpenGL framebuffer */
     fb_len = 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
-    fb = cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 0);
+    fb = cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, false);
     if (fb == NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
@@ -281,7 +281,7 @@ static void tmu2_start(MilkymistTMU2State *s)
 
     /* Map the texture */
     mesh_len = MESH_MAXSIZE*MESH_MAXSIZE*sizeof(struct vertex);
-    mesh = cpu_physical_memory_map(s->regs[R_VERTICESADDR], &mesh_len, 0);
+    mesh = cpu_physical_memory_map(s->regs[R_VERTICESADDR], &mesh_len, false);
     if (mesh == NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
@@ -298,7 +298,7 @@ static void tmu2_start(MilkymistTMU2State *s)
 
     /* Write back the OpenGL framebuffer to the QEMU framebuffer */
     fb_len = 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
-    fb = cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 1);
+    fb = cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, true);
     if (fb == NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 637aae8..32dc0d6 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -632,7 +632,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s *s)
     len = s->rfbi.pixels * 2;
 
     data_addr = s->dispc.l[0].addr[0];
-    data = cpu_physical_memory_map(data_addr, &len, 0);
+    data = cpu_physical_memory_map(data_addr, &len, false);
     if (data && len != s->rfbi.pixels * 2) {
         cpu_physical_memory_unmap(data, len, 0, 0);
         data = NULL;
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index cd94940..7ba07c8 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -57,7 +57,7 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
     }
 
     size = (hwaddr)linesize * height;
-    data = cpu_physical_memory_map(addr, &size, 0);
+    data = cpu_physical_memory_map(addr, &size, false);
     if (size != (hwaddr)linesize * height) {
         cpu_physical_memory_unmap(data, size, 0, 0);
         return NULL;
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 0fb84dd..8aa8e65 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -125,7 +125,7 @@ static void test_flush_page_write(void *opaque, hwaddr addr, uint64_t data,
                             unsigned len)
 {
     hwaddr page = 4096;
-    void *a = cpu_physical_memory_map(data & ~0xffful, &page, 0);
+    void *a = cpu_physical_memory_map(data & ~0xffful, &page, false);
 
     /* We might not be able to get the full page, only mprotect what we actually
        have mapped */
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 877ddef..15d0828 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -89,7 +89,7 @@ static void rtas_nvram_fetch(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     assert(nvram->buf);
 
-    membuf = cpu_physical_memory_map(buffer, &len, 1);
+    membuf = cpu_physical_memory_map(buffer, &len, true);
     memcpy(membuf, nvram->buf + offset, len);
     cpu_physical_memory_unmap(membuf, len, 1, len);
 
@@ -127,7 +127,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return;
     }
 
-    membuf = cpu_physical_memory_map(buffer, &len, 0);
+    membuf = cpu_physical_memory_map(buffer, &len, false);
 
     alen = len;
     if (nvram->blk) {
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 1a6a8fa..d5ea962 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -909,8 +909,10 @@ static void dcr_write_dma(void *opaque, int dcrn, uint32_t val)
 
                     sidx = didx = 0;
                     width = 1 << ((val & DMA0_CR_PW) >> 25);
-                    rptr = cpu_physical_memory_map(dma->ch[chnl].sa, &rlen, 0);
-                    wptr = cpu_physical_memory_map(dma->ch[chnl].da, &wlen, 1);
+                    rptr = cpu_physical_memory_map(dma->ch[chnl].sa, &rlen,
+                                                   false);
+                    wptr = cpu_physical_memory_map(dma->ch[chnl].da, &wlen,
+                                                   true);
                     if (rptr && wptr) {
                         if (!(val & DMA0_CR_DEC) &&
                             val & DMA0_CR_SAI && val & DMA0_CR_DAI) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b8bb66b..caf55ab 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -832,7 +832,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (!is_ram_address(spapr, dst) || (dst & ~TARGET_PAGE_MASK) != 0) {
         return H_PARAMETER;
     }
-    pdst = cpu_physical_memory_map(dst, &len, 1);
+    pdst = cpu_physical_memory_map(dst, &len, true);
     if (!pdst || len != TARGET_PAGE_SIZE) {
         return H_PARAMETER;
     }
@@ -843,7 +843,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
             ret = H_PARAMETER;
             goto unmap_out;
         }
-        psrc = cpu_physical_memory_map(src, &len, 0);
+        psrc = cpu_physical_memory_map(src, &len, false);
         if (!psrc || len != TARGET_PAGE_SIZE) {
             ret = H_PARAMETER;
             goto unmap_out;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7773499..0817874 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -626,7 +626,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     uint8_t *addr;
     uint64_t len = 4096;
 
-    addr = cpu_physical_memory_map(cpu->env.psa, &len, 1);
+    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
     if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
         error_report("Cannot set QEMU IPL parameters");
         return;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 7c6a2b3..ed8be12 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -641,7 +641,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
     hwaddr len = 1;
     uint8_t *ind_addr;
 
-    ind_addr = cpu_physical_memory_map(ind_loc, &len, 1);
+    ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
         return -1;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 13f57e7..50cf95b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -790,7 +790,7 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
     hwaddr len = 1;
     uint8_t *ind_addr;
 
-    ind_addr = cpu_physical_memory_map(ind_loc, &len, 1);
+    ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         error_report("%s(%x.%x.%04x): unable to access indicator",
                      __func__, sch->cssid, sch->ssid, sch->schid);
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index b697327..b11e4e0 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -222,7 +222,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
     }
 
     /* Currently we fixed this address as a primary for legacy BIOS. */
-    cpu_physical_memory_rw(0xc0000, bios, bios_size, 1);
+    cpu_physical_memory_rw(0xc0000, bios, bios_size, true);
 }
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index d127d84..b47e563 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -74,12 +74,12 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
 static inline void cpu_physical_memory_read(hwaddr addr,
                                             void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, buf, len, 0);
+    cpu_physical_memory_rw(addr, buf, len, false);
 }
 static inline void cpu_physical_memory_write(hwaddr addr,
                                              const void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, (void *)buf, len, 1);
+    cpu_physical_memory_rw(addr, (void *)buf, len, true);
 }
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 4f0e634..35ab79e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -19,6 +19,20 @@ expression E1, E2, E3, E4, E5;
 |
 - address_space_rw(E1, E2, E3, E4, E5, 1)
 + address_space_rw(E1, E2, E3, E4, E5, true)
+|
+
+- cpu_physical_memory_rw(E1, E2, E3, 0)
++ cpu_physical_memory_rw(E1, E2, E3, false)
+|
+- cpu_physical_memory_rw(E1, E2, E3, 1)
++ cpu_physical_memory_rw(E1, E2, E3, true)
+|
+
+- cpu_physical_memory_map(E1, E2, 0)
++ cpu_physical_memory_map(E1, E2, false)
+|
+- cpu_physical_memory_map(E1, E2, 1)
++ cpu_physical_memory_map(E1, E2, true)
 )
 
 // Use address_space_write instead of casting to non-const
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a9cc51e..38936d7 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, struct hax_fastmmio *hft)
          *  hft->direction == 2: gpa ==> gpa2
          */
         uint64_t value;
-        cpu_physical_memory_rw(hft->gpa, &value, hft->size, 0);
-        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, 1);
+        cpu_physical_memory_rw(hft->gpa, &value, hft->size, false);
+        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, true);
     }
 
     return 0;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 1e9d6f2..3b58d10 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -393,7 +393,7 @@ static int mchk_store_vregs(CPUS390XState *env, uint64_t mcesao)
     MchkExtSaveArea *sa;
     int i;
 
-    sa = cpu_physical_memory_map(mcesao, &len, 1);
+    sa = cpu_physical_memory_map(mcesao, &len, true);
     if (!sa) {
         return -EFAULT;
     }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a3a4916..b810ad4 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -151,7 +151,7 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
     LowCore *lowcore;
     hwaddr len = sizeof(LowCore);
 
-    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore = cpu_physical_memory_map(env->psa, &len, true);
 
     if (len < sizeof(LowCore)) {
         cpu_abort(env_cpu(env), "Could not map lowcore\n");
@@ -246,7 +246,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
     hwaddr len = sizeof(*sa);
     int i;
 
-    sa = cpu_physical_memory_map(addr, &len, 1);
+    sa = cpu_physical_memory_map(addr, &len, true);
     if (!sa) {
         return -EFAULT;
     }
@@ -298,7 +298,7 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
     hwaddr save = len;
     int i;
 
-    sa = cpu_physical_memory_map(addr, &save, 1);
+    sa = cpu_physical_memory_map(addr, &save, true);
     if (!sa) {
         return -EFAULT;
     }
-- 
1.8.3.1



