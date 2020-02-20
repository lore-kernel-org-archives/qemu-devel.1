Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AEC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2206206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuTgmODB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2206206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4loU-0001ms-PZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXu-0006fb-RA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXs-00060j-0O
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXr-00060D-Qc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8q7l9fCCXUXfbPVdowHNP6yaBAEoO32+ciiHpilnfds=;
 b=iuTgmODB+Kvp5y/VsVoLGFeidkTFIVW+3bgxqGLYugZy0gBU7JWnTIJviYawVJNVfhx/3t
 8RDZjPzpsediV5EBzYisTUa5j45nU7e2+X4eceD84/TMZcPr+fcOPg8O4OMM4ecKC4tUUv
 0mPj2shRDAZ+dLJo83KOrwyE3jV1YnM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-xm3sv3x-NjOz1moN3Wjrkw-1; Thu, 20 Feb 2020 08:07:09 -0500
X-MC-Unique: xm3sv3x-NjOz1moN3Wjrkw-1
Received: by mail-wr1-f72.google.com with SMTP id 90so1712684wrq.6
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Du/Q9cwkYv23U8HuA6dwHrSvlC9gAA5COcpF1xlZ39I=;
 b=Cjgcb7hyFqyGHmKkyxWdG2l1ZUiRaHemPgTDi3pESLcAZRto+9To1CE05nRks8VI+N
 1mcM3Mp85C+RSLAYZEhZ3ydShRUcuvowb/WRVQX6BvPS10VrxkdPt7bqlBMxHcbIJjv2
 bqsqk1rq1FjAx8NubMRxtJr+Jt5ylMKYMycdLOG5YQ2QjdNjqDSKnZR5I3v+w3L/DRXD
 kMNdETW17w4VOKCpezNphsTGvn54spfik+Q+1jI91t4nA33U04FdJTpjlMjs6lgoGMpJ
 jYqXR6X1dF9/ZgIxCFLcrb+0kyVlhXgWORoeqmDr6w8DNa7T5lcbfuaT9w1R8unocd5V
 lo9w==
X-Gm-Message-State: APjAAAXq9N2WWth93sVvsJSJUYgc0F5aTVgQqe2bRh8KSoqOZmgIjDvE
 uU9MxpUjPdh31c96+XgJjbBOnZJPO0pGBwLSFkdECZWxYoUKuBKvWnuxpGQ9LV6cXhlQE/QtsnQ
 htbBpFQIOlbIvsuM=
X-Received: by 2002:a7b:c088:: with SMTP id r8mr4601057wmh.18.1582204025777;
 Thu, 20 Feb 2020 05:07:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTc/nRX5CoIhTiVHPwKrtx6YNl9fhALe1YoNj6XyZHwJDsk5yvnlQRclQhspzivJLvmF3dTQ==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr4601010wmh.18.1582204025361;
 Thu, 20 Feb 2020 05:07:05 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:07:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 19/20] Let cpu_[physical]_memory() calls pass a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:47 +0100
Message-Id: <20200220130548.29974-20-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use an explicit boolean type.

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/exec_rw_const.cocci | 14 ++++++++++++++
 include/exec/cpu-common.h              |  4 ++--
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
 target/i386/hax-all.c                  |  4 ++--
 target/s390x/excp_helper.c             |  2 +-
 target/s390x/helper.c                  |  6 +++---
 17 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/ex=
ec_rw_const.cocci
index ee98ce988e..54b1cab8cd 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -11,6 +11,20 @@ expression E1, E2, E3, E4, E5;
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
=20
 // Use address_space_write instead of casting to non-const
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6bfe201779..e7fd5781ea 100644
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
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c1071ecd46..ec6776680e 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1164,7 +1164,8 @@ static void fimd_update_memory_section(Exynos4210fimd=
State *s, unsigned win)
         goto error_return;
     }
=20
-    w->host_fb_addr =3D cpu_physical_memory_map(fb_start_addr, &fb_mapped_=
len, 0);
+    w->host_fb_addr =3D cpu_physical_memory_map(fb_start_addr, &fb_mapped_=
len,
+                                              false);
     if (!w->host_fb_addr) {
         DPRINT_ERROR("Failed to map window %u framebuffer\n", win);
         goto error_return;
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 199f1227e7..513c0d5bab 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -218,7 +218,7 @@ static void tmu2_start(MilkymistTMU2State *s)
     glGenTextures(1, &texture);
     glBindTexture(GL_TEXTURE_2D, texture);
     fb_len =3D 2ULL * s->regs[R_TEXHRES] * s->regs[R_TEXVRES];
-    fb =3D cpu_physical_memory_map(s->regs[R_TEXFBUF], &fb_len, 0);
+    fb =3D cpu_physical_memory_map(s->regs[R_TEXFBUF], &fb_len, false);
     if (fb =3D=3D NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
@@ -262,7 +262,7 @@ static void tmu2_start(MilkymistTMU2State *s)
=20
     /* Read the QEMU dest. framebuffer into the OpenGL framebuffer */
     fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
-    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 0);
+    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, false);
     if (fb =3D=3D NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
@@ -281,7 +281,7 @@ static void tmu2_start(MilkymistTMU2State *s)
=20
     /* Map the texture */
     mesh_len =3D MESH_MAXSIZE*MESH_MAXSIZE*sizeof(struct vertex);
-    mesh =3D cpu_physical_memory_map(s->regs[R_VERTICESADDR], &mesh_len, 0=
);
+    mesh =3D cpu_physical_memory_map(s->regs[R_VERTICESADDR], &mesh_len, f=
alse);
     if (mesh =3D=3D NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
@@ -298,7 +298,7 @@ static void tmu2_start(MilkymistTMU2State *s)
=20
     /* Write back the OpenGL framebuffer to the QEMU framebuffer */
     fb_len =3D 2ULL * s->regs[R_DSTHRES] * s->regs[R_DSTVRES];
-    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, 1);
+    fb =3D cpu_physical_memory_map(s->regs[R_DSTFBUF], &fb_len, true);
     if (fb =3D=3D NULL) {
         glDeleteTextures(1, &texture);
         glXMakeContextCurrent(s->dpy, None, None, NULL);
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 637aae8d39..32dc0d6aa7 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -632,7 +632,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s =
*s)
     len =3D s->rfbi.pixels * 2;
=20
     data_addr =3D s->dispc.l[0].addr[0];
-    data =3D cpu_physical_memory_map(data_addr, &len, 0);
+    data =3D cpu_physical_memory_map(data_addr, &len, false);
     if (data && len !=3D s->rfbi.pixels * 2) {
         cpu_physical_memory_unmap(data, len, 0, 0);
         data =3D NULL;
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index cd94940223..7ba07c80f6 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -57,7 +57,7 @@ static DisplaySurface *ramfb_create_display_surface(int w=
idth, int height,
     }
=20
     size =3D (hwaddr)linesize * height;
-    data =3D cpu_physical_memory_map(addr, &size, 0);
+    data =3D cpu_physical_memory_map(addr, &size, false);
     if (size !=3D (hwaddr)linesize * height) {
         cpu_physical_memory_unmap(data, size, 0, 0);
         return NULL;
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 0fb84ddc6b..8aa8e6549f 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -125,7 +125,7 @@ static void test_flush_page_write(void *opaque, hwaddr =
addr, uint64_t data,
                             unsigned len)
 {
     hwaddr page =3D 4096;
-    void *a =3D cpu_physical_memory_map(data & ~0xffful, &page, 0);
+    void *a =3D cpu_physical_memory_map(data & ~0xffful, &page, false);
=20
     /* We might not be able to get the full page, only mprotect what we ac=
tually
        have mapped */
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 877ddef7b9..15d08281d4 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -89,7 +89,7 @@ static void rtas_nvram_fetch(PowerPCCPU *cpu, SpaprMachin=
eState *spapr,
=20
     assert(nvram->buf);
=20
-    membuf =3D cpu_physical_memory_map(buffer, &len, 1);
+    membuf =3D cpu_physical_memory_map(buffer, &len, true);
     memcpy(membuf, nvram->buf + offset, len);
     cpu_physical_memory_unmap(membuf, len, 1, len);
=20
@@ -127,7 +127,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
         return;
     }
=20
-    membuf =3D cpu_physical_memory_map(buffer, &len, 0);
+    membuf =3D cpu_physical_memory_map(buffer, &len, false);
=20
     alen =3D len;
     if (nvram->blk) {
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 1a6a8fac22..d5ea962249 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -909,8 +909,10 @@ static void dcr_write_dma(void *opaque, int dcrn, uint=
32_t val)
=20
                     sidx =3D didx =3D 0;
                     width =3D 1 << ((val & DMA0_CR_PW) >> 25);
-                    rptr =3D cpu_physical_memory_map(dma->ch[chnl].sa, &rl=
en, 0);
-                    wptr =3D cpu_physical_memory_map(dma->ch[chnl].da, &wl=
en, 1);
+                    rptr =3D cpu_physical_memory_map(dma->ch[chnl].sa, &rl=
en,
+                                                   false);
+                    wptr =3D cpu_physical_memory_map(dma->ch[chnl].da, &wl=
en,
+                                                   true);
                     if (rptr && wptr) {
                         if (!(val & DMA0_CR_DEC) &&
                             val & DMA0_CR_SAI && val & DMA0_CR_DAI) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b8bb66b5c0..caf55ab044 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -832,7 +832,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
     if (!is_ram_address(spapr, dst) || (dst & ~TARGET_PAGE_MASK) !=3D 0) {
         return H_PARAMETER;
     }
-    pdst =3D cpu_physical_memory_map(dst, &len, 1);
+    pdst =3D cpu_physical_memory_map(dst, &len, true);
     if (!pdst || len !=3D TARGET_PAGE_SIZE) {
         return H_PARAMETER;
     }
@@ -843,7 +843,7 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
             ret =3D H_PARAMETER;
             goto unmap_out;
         }
-        psrc =3D cpu_physical_memory_map(src, &len, 0);
+        psrc =3D cpu_physical_memory_map(src, &len, false);
         if (!psrc || len !=3D TARGET_PAGE_SIZE) {
             ret =3D H_PARAMETER;
             goto unmap_out;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7773499d7f..0817874b48 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -626,7 +626,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     uint8_t *addr;
     uint64_t len =3D 4096;
=20
-    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, 1);
+    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, true);
     if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
         error_report("Cannot set QEMU IPL parameters");
         return;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 7c6a2b3c63..ed8be124da 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -641,7 +641,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t=
 to_be_set)
     hwaddr len =3D 1;
     uint8_t *ind_addr;
=20
-    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, 1);
+    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
         return -1;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 13f57e7b67..50cf95b781 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -790,7 +790,7 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uin=
t64_t ind_loc,
     hwaddr len =3D 1;
     uint8_t *ind_addr;
=20
-    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, 1);
+    ind_addr =3D cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         error_report("%s(%x.%x.%04x): unable to access indicator",
                      __func__, sch->cssid, sch->ssid, sch->schid);
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index b69732729b..b11e4e0546 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -222,7 +222,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHos=
tPCIDevice *dev,
     }
=20
     /* Currently we fixed this address as a primary for legacy BIOS. */
-    cpu_physical_memory_rw(0xc0000, bios, bios_size, 1);
+    cpu_physical_memory_rw(0xc0000, bios, bios_size, true);
 }
=20
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a9cc51e6ce..38936d7af6 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, struc=
t hax_fastmmio *hft)
          *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
          */
         uint64_t value;
-        cpu_physical_memory_rw(hft->gpa, &value, hft->size, 0);
-        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, 1);
+        cpu_physical_memory_rw(hft->gpa, &value, hft->size, false);
+        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, true);
     }
=20
     return 0;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 1e9d6f20c1..3b58d10df3 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -393,7 +393,7 @@ static int mchk_store_vregs(CPUS390XState *env, uint64_=
t mcesao)
     MchkExtSaveArea *sa;
     int i;
=20
-    sa =3D cpu_physical_memory_map(mcesao, &len, 1);
+    sa =3D cpu_physical_memory_map(mcesao, &len, true);
     if (!sa) {
         return -EFAULT;
     }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a3a49164e4..b810ad431e 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -151,7 +151,7 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
     LowCore *lowcore;
     hwaddr len =3D sizeof(LowCore);
=20
-    lowcore =3D cpu_physical_memory_map(env->psa, &len, 1);
+    lowcore =3D cpu_physical_memory_map(env->psa, &len, true);
=20
     if (len < sizeof(LowCore)) {
         cpu_abort(env_cpu(env), "Could not map lowcore\n");
@@ -246,7 +246,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool s=
tore_arch)
     hwaddr len =3D sizeof(*sa);
     int i;
=20
-    sa =3D cpu_physical_memory_map(addr, &len, 1);
+    sa =3D cpu_physical_memory_map(addr, &len, true);
     if (!sa) {
         return -EFAULT;
     }
@@ -298,7 +298,7 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, h=
waddr len)
     hwaddr save =3D len;
     int i;
=20
-    sa =3D cpu_physical_memory_map(addr, &save, 1);
+    sa =3D cpu_physical_memory_map(addr, &save, true);
     if (!sa) {
         return -EFAULT;
     }
--=20
2.21.1


