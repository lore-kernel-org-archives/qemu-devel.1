Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C317C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA08206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaEuYIz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA08206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lmM-0007GJ-0E
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXo-0006Pf-PU
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXk-0005qk-He
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXk-0005p2-8M
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GO1E6oO0Gq5uJhHshZ+fhmzu63XBDTLn+7+XeANLTdA=;
 b=iaEuYIz4K9oq+9PS96ks/ORRq6LuA/6dq3CCwMZ5S1zEqoFAmSrmtGaqjAuqYs89GhcEy0
 ez7VNpFChgYh6/zHkczVV6gXZsKydfTRFf5iZlQp3zHOGeJn95756ZkRzzfRkba5knliTg
 NZhREGVvjmitqCLHQSQVXNd7M3nLNlM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-qFsvyIPdMZm3XOAhHtTpvw-1; Thu, 20 Feb 2020 08:07:00 -0500
Received: by mail-wr1-f71.google.com with SMTP id p8so1714364wrw.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kw0XUCUaDNbVcDxMhM9BERQo40GlLRJY6LdRY3T5Lms=;
 b=dgsLSkdOW95PqBdhX7Sgf7Bd8qBMGcjfKTox2NPYeQ8d7lEb6wrJ+QylJjdyzn0PuV
 Va6or86L2MPKuW/2JWuP/eWmfm8d0+g2/3St93y2Mm6bHSuyxM8H8g9rOJ68hYQeTQM1
 QydWYGkvHMUxSyB1YK16hwY4EPJRk9muvXElscqF4P+O5vNeH1QKf6OGY3onPIbxqVWD
 Kx4hYw1dkVVpIV7EhmZfPvwbvyvMmMQtMwAi91/+N50Z6lrjrr2sI1wgTWYsx4E6UuAv
 nweVN0WmoJr0085dhs/3fFzE3ax7A84ByKWIaCJ4zb8kwDcxP02BslVxJcXnQkQy3DTC
 +qiA==
X-Gm-Message-State: APjAAAWV2p8idtRG1EQFwrXHO+Ls8zlVme1wjnzl4UgkZOGogygd4yYp
 GkhSnxwH2PJ2NthYdb0XXRKKWoBD0DbF5gWey2DmCt2lg/N1ayvSi0rLbJe/ES1K27j7P1Se1Hc
 7qq9ILA4yqAh/3PI=
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4444372wma.24.1582204018546; 
 Thu, 20 Feb 2020 05:06:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfY34Ge3A5OmYaegi2SKsDA4DO74+UedMLsATm1YBGQ+eulvbZaY+6nTExEQIMcugpq5jYpw==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr4444308wma.24.1582204018007; 
 Thu, 20 Feb 2020 05:06:58 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 17/20] Avoid address_space_rw() with a constant is_write
 argument
Date: Thu, 20 Feb 2020 14:05:45 +0100
Message-Id: <20200220130548.29974-18-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: qFsvyIPdMZm3XOAhHtTpvw-1
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
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
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

From: Peter Maydell <peter.maydell@linaro.org>

The address_space_rw() function allows either reads or writes
depending on the is_write argument passed to it; this is useful
when the direction of the access is determined programmatically
(as for instance when handling the KVM_EXIT_MMIO exit reason).
Under the hood it just calls either address_space_write() or
address_space_read_full().

We also use it a lot with a constant is_write argument, though,
which has two issues:
 * when reading "address_space_rw(..., 1)" this is less
   immediately clear to the reader as being a write than
   "address_space_write(...)"
 * calling address_space_rw() bypasses the optimization
   in address_space_read() that fast-paths reads of a
   fixed length

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.cocci.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200218112457.22712-1-peter.maydell@linaro.org>
[PMD: Update macvm_set_cr0() reported by Laurent Vivier]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/exec_rw_const.cocci | 13 +++++
 target/i386/hvf/vmx.h                  |  7 ++-
 accel/kvm/kvm-all.c                    |  6 +--
 dma-helpers.c                          |  4 +-
 exec.c                                 |  4 +-
 hw/dma/xlnx-zdma.c                     | 11 ++--
 hw/net/dp8393x.c                       | 70 ++++++++++++++------------
 hw/net/i82596.c                        | 22 ++++----
 hw/net/lasi_i82596.c                   |  5 +-
 hw/ppc/pnv_lpc.c                       |  8 +--
 hw/s390x/css.c                         | 12 ++---
 qtest.c                                | 52 +++++++++----------
 target/i386/hvf/x86_mmu.c              | 12 ++---
 13 files changed, 119 insertions(+), 107 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/ex=
ec_rw_const.cocci
index 98cb06f09f..ee98ce988e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -27,6 +27,19 @@ expression E1, E2, E3, E4;
 + address_space_write(E1, E2, E3, V, E4)
 )
=20
+// Avoid uses of address_space_rw() with a constant is_write argument.
+@@
+expression E1, E2, E3, E4, E5;
+symbol true, false;
+@@
+(
+- address_space_rw(E1, E2, E3, E4, E5, false)
++ address_space_read(E1, E2, E3, E4, E5)
+|
+- address_space_rw(E1, E2, E3, E4, E5, true)
++ address_space_write(E1, E2, E3, E4, E5)
+)
+
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 19af029133..03d2c79b9c 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -125,10 +125,9 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uin=
t64_t cr0)
=20
     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
         !(efer & MSR_EFER_LME)) {
-        address_space_rw(&address_space_memory,
-                         rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
-                         MEMTXATTRS_UNSPECIFIED,
-                         pdpte, 32, false);
+        address_space_read(&address_space_memory,
+                           rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
+                           MEMTXATTRS_UNSPECIFIED, pdpte, 32);
         /* Only set PDPTE when appropriate. */
         for (i =3D 0; i < 4; i++) {
             wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312dfd..0cfe6fd8de 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2178,9 +2178,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
             ent =3D &ring->coalesced_mmio[ring->first];
=20
             if (ent->pio =3D=3D 1) {
-                address_space_rw(&address_space_io, ent->phys_addr,
-                                 MEMTXATTRS_UNSPECIFIED, ent->data,
-                                 ent->len, true);
+                address_space_write(&address_space_io, ent->phys_addr,
+                                    MEMTXATTRS_UNSPECIFIED, ent->data,
+                                    ent->len);
             } else {
                 cpu_physical_memory_write(ent->phys_addr, ent->data, ent->=
len);
             }
diff --git a/dma-helpers.c b/dma-helpers.c
index d3871dc61e..e8a26e81e1 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -28,8 +28,8 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, uin=
t8_t c, dma_addr_t len)
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
         l =3D len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
-        error |=3D address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                  fillbuf, l, true);
+        error |=3D address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
+                                     fillbuf, l);
         len -=3D l;
         addr +=3D l;
     }
diff --git a/exec.c b/exec.c
index 73c3bcfa40..b79919a4f7 100644
--- a/exec.c
+++ b/exec.c
@@ -3815,8 +3815,8 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong a=
ddr,
             address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
                                     attrs, buf, l);
         } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, bu=
f,
-                             l, false);
+            address_space_read(cpu->cpu_ases[asidx].as, phys_addr, attrs, =
buf,
+                               l);
         }
         len -=3D l;
         buf +=3D l;
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 683abbe53f..1c1b142293 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -311,8 +311,7 @@ static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t =
addr, void *buf)
         return false;
     }
=20
-    address_space_rw(s->dma_as, addr, s->attr,
-                     buf, sizeof(XlnxZDMADescr), false);
+    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr=
));
     return true;
 }
=20
@@ -364,7 +363,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, boo=
l type,
     } else {
         addr =3D zdma_get_regaddr64(s, basereg);
         addr +=3D sizeof(s->dsc_dst);
-        address_space_rw(s->dma_as, addr, s->attr, &next, 8, false);
+        address_space_read(s->dma_as, addr, s->attr, &next, 8);
         zdma_put_regaddr64(s, basereg, next);
     }
     return next;
@@ -416,8 +415,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, u=
int32_t len)
             }
         }
=20
-        address_space_rw(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen,
-                         true);
+        address_space_write(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen=
);
         if (burst_type =3D=3D AXI_BURST_INCR) {
             s->dsc_dst.addr +=3D dlen;
         }
@@ -493,8 +491,7 @@ static void zdma_process_descr(XlnxZDMA *s)
                 len =3D s->cfg.bus_width / 8;
             }
         } else {
-            address_space_rw(s->dma_as, src_addr, s->attr, s->buf, len,
-                             false);
+            address_space_read(s->dma_as, src_addr, s->attr, s->buf, len);
             if (burst_type =3D=3D AXI_BURST_INCR) {
                 src_addr +=3D len;
             }
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b4363e3186..70451934ae 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -275,8 +275,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
=20
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
-        address_space_rw(&s->as, dp8393x_cdp(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+        address_space_read(&s->as, dp8393x_cdp(s),
+                           MEMTXATTRS_UNSPECIFIED, s->data, size);
         s->cam[index][0] =3D dp8393x_get(s, width, 1) & 0xff;
         s->cam[index][1] =3D dp8393x_get(s, width, 1) >> 8;
         s->cam[index][2] =3D dp8393x_get(s, width, 2) & 0xff;
@@ -293,8 +293,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     }
=20
     /* Read CAM enable */
-    address_space_rw(&s->as, dp8393x_cdp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+    address_space_read(&s->as, dp8393x_cdp(s),
+                       MEMTXATTRS_UNSPECIFIED, s->data, size);
     s->regs[SONIC_CE] =3D dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
=20
@@ -311,8 +311,8 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     /* Read memory */
     width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size =3D sizeof(uint16_t) * 4 * width;
-    address_space_rw(&s->as, dp8393x_rrp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+    address_space_read(&s->as, dp8393x_rrp(s),
+                       MEMTXATTRS_UNSPECIFIED, s->data, size);
=20
     /* Update SONIC registers */
     s->regs[SONIC_CRBA0] =3D dp8393x_get(s, width, 0);
@@ -426,8 +426,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
         size =3D sizeof(uint16_t) * 6 * width;
         s->regs[SONIC_TTDA] =3D s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
-        address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * widt=
h,
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+        address_space_read(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * wi=
dth,
+                           MEMTXATTRS_UNSPECIFIED, s->data, size);
         tx_len =3D 0;
=20
         /* Update registers */
@@ -451,18 +451,19 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
             if (tx_len + len > sizeof(s->tx_buffer)) {
                 len =3D sizeof(s->tx_buffer) - tx_len;
             }
-            address_space_rw(&s->as, dp8393x_tsa(s),
-                             MEMTXATTRS_UNSPECIFIED,
-                             &s->tx_buffer[tx_len], len, false);
+            address_space_read(&s->as, dp8393x_tsa(s), MEMTXATTRS_UNSPECIF=
IED,
+                               &s->tx_buffer[tx_len], len);
             tx_len +=3D len;
=20
             i++;
             if (i !=3D s->regs[SONIC_TFC]) {
                 /* Read next fragment details */
                 size =3D sizeof(uint16_t) * 3 * width;
-                address_space_rw(&s->as,
-                    dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * wid=
th,
-                                 MEMTXATTRS_UNSPECIFIED, s->data, size, fa=
lse);
+                address_space_read(&s->as,
+                                   dp8393x_ttda(s)
+                                   + sizeof(uint16_t) * width * (4 + 3 * i=
),
+                                   MEMTXATTRS_UNSPECIFIED, s->data,
+                                   size);
                 s->regs[SONIC_TSA0] =3D dp8393x_get(s, width, 0);
                 s->regs[SONIC_TSA1] =3D dp8393x_get(s, width, 1);
                 s->regs[SONIC_TFS] =3D dp8393x_get(s, width, 2);
@@ -495,18 +496,18 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
         dp8393x_put(s, width, 0,
                     s->regs[SONIC_TCR] & 0x0fff); /* status */
         size =3D sizeof(uint16_t) * width;
-        address_space_rw(&s->as,
-                         dp8393x_ttda(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, true);
+        address_space_write(&s->as, dp8393x_ttda(s),
+                            MEMTXATTRS_UNSPECIFIED, s->data, size);
=20
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
             size =3D sizeof(uint16_t) * width;
-            address_space_rw(&s->as,
-                             dp8393x_ttda(s) +
-                             sizeof(uint16_t) *
-                             (4 + 3 * s->regs[SONIC_TFC]) * width,
-                             MEMTXATTRS_UNSPECIFIED, s->data, size, false)=
;
+            address_space_read(&s->as,
+                               dp8393x_ttda(s)
+                               + sizeof(uint16_t) * width
+                                 * (4 + 3 * s->regs[SONIC_TFC]),
+                               MEMTXATTRS_UNSPECIFIED, s->data,
+                               size);
             s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
             if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
@@ -768,8 +769,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
         /* Are we still in resource exhaustion? */
         size =3D sizeof(uint16_t) * 1 * width;
         address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
-        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         s->data, size, false);
+        address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                           s->data, size);
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
@@ -788,10 +789,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address =3D dp8393x_crba(s);
-    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_l=
en);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                        buf, rx_len);
     address +=3D rx_len;
-    address_space_rw(&s->as, address,
-                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, true);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                        &checksum, 4);
     rx_len +=3D 4;
     s->regs[SONIC_CRBA1] =3D address >> 16;
     s->regs[SONIC_CRBA0] =3D address & 0xffff;
@@ -819,13 +821,15 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     dp8393x_put(s, width, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
     dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size =3D sizeof(uint16_t) * 5 * width;
-    address_space_rw(&s->as, dp8393x_crda(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, true);
+    address_space_write(&s->as, dp8393x_crda(s),
+                        MEMTXATTRS_UNSPECIFIED,
+                        s->data, size);
=20
     /* Move to next descriptor */
     size =3D sizeof(uint16_t) * width;
-    address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * widt=
h,
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
+    address_space_read(&s->as,
+                       dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
+                       MEMTXATTRS_UNSPECIFIED, s->data, size);
     s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
@@ -838,8 +842,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
             offset +=3D sizeof(uint16_t);
         }
         s->data[0] =3D 0;
-        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         s->data, sizeof(uint16_t), true);
+        address_space_write(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
+                            s->data, sizeof(uint16_t));
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[=
SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 11537f72d1..fe9f2390a9 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -148,8 +148,8 @@ static void i82596_transmit(I82596State *s, uint32_t ad=
dr)
=20
         if (s->nic && len) {
             assert(len <=3D sizeof(s->tx_buffer));
-            address_space_rw(&address_space_memory, tba,
-                             MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, fa=
lse);
+            address_space_read(&address_space_memory, tba,
+                               MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len);
             DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
             DBG(printf("Sending %d bytes\n", len));
             qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
@@ -172,8 +172,8 @@ static void set_individual_address(I82596State *s, uint=
32_t addr)
=20
     nc =3D qemu_get_queue(s->nic);
     m =3D s->conf.macaddr.a;
-    address_space_rw(&address_space_memory, addr + 8,
-                     MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, false);
+    address_space_read(&address_space_memory, addr + 8,
+                       MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN);
     qemu_format_nic_info_str(nc, m);
     trace_i82596_new_mac(nc->info_str);
 }
@@ -190,9 +190,8 @@ static void set_multicast_list(I82596State *s, uint32_t=
 addr)
     }
     for (i =3D 0; i < mc_count; i++) {
         uint8_t multicast_addr[ETH_ALEN];
-        address_space_rw(&address_space_memory,
-            addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
-                         multicast_addr, ETH_ALEN, false);
+        address_space_read(&address_space_memory, addr + i * ETH_ALEN,
+                           MEMTXATTRS_UNSPECIFIED, multicast_addr, ETH_ALE=
N);
         DBG(printf("Add multicast entry " MAC_FMT "\n",
                     MAC_ARG(multicast_addr)));
         unsigned mcast_idx =3D (net_crc32(multicast_addr, ETH_ALEN) &
@@ -260,9 +259,8 @@ static void command_loop(I82596State *s)
             byte_cnt =3D MAX(byte_cnt, 4);
             byte_cnt =3D MIN(byte_cnt, sizeof(s->config));
             /* copy byte_cnt max. */
-            address_space_rw(&address_space_memory, s->cmd_p + 8,
-                             MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt,
-                             false);
+            address_space_read(&address_space_memory, s->cmd_p + 8,
+                               MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt=
);
             /* config byte according to page 35ff */
             s->config[2] &=3D 0x82; /* mask valid bits */
             s->config[2] |=3D 0x40;
@@ -647,8 +645,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_=
t *buf, size_t sz)
             buf +=3D num;
             len -=3D num;
             if (len =3D=3D 0) { /* copy crc */
-                address_space_rw(&address_space_memory, rba - 4,
-                                 MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, true)=
;
+                address_space_write(&address_space_memory, rba - 4,
+                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
             }
=20
             num |=3D 0x4000; /* set F BIT */
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 8bff419378..52637a562d 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -55,8 +55,9 @@ static void lasi_82596_mem_write(void *opaque, hwaddr add=
r,
          * Provided for SeaBIOS only. Write MAC of Network card to addr @v=
al.
          * Needed for the PDC_LAN_STATION_ID_READ PDC call.
          */
-        address_space_rw(&address_space_memory, val, MEMTXATTRS_UNSPECIFIE=
D,
-                         d->state.conf.macaddr.a, ETH_ALEN, true);
+        address_space_write(&address_space_memory, val,
+                            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.=
a,
+                            ETH_ALEN);
         break;
     }
 }
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 5989d723c5..f150deca34 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -238,16 +238,16 @@ static bool opb_read(PnvLpcController *lpc, uint32_t =
addr, uint8_t *data,
                      int sz)
 {
     /* XXX Handle access size limits and FW read caching here */
-    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, sz, false);
+    return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
+                               data, sz);
 }
=20
 static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
                       int sz)
 {
     /* XXX Handle access size limits here */
-    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, sz, true);
+    return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED=
,
+                                data, sz);
 }
=20
 #define ECCB_CTL_READ           PPC_BIT(15)
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f27f8c45a5..5d8e08667e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -874,18 +874,18 @@ static inline int ida_read_next_idaw(CcwDataStream *c=
ds)
         if (idaw_addr & 0x07 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1))=
 {
             return -EINVAL; /* channel program check */
         }
-        ret =3D address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt2,
-                               sizeof(idaw.fmt2), false);
+        ret =3D address_space_read(&address_space_memory, idaw_addr,
+                                 MEMTXATTRS_UNSPECIFIED, &idaw.fmt2,
+                                 sizeof(idaw.fmt2));
         cds->cda =3D be64_to_cpu(idaw.fmt2);
     } else {
         idaw_addr =3D cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
         if (idaw_addr & 0x03 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1))=
 {
             return -EINVAL; /* channel program check */
         }
-        ret =3D address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, &idaw.fmt1,
-                               sizeof(idaw.fmt1), false);
+        ret =3D address_space_read(&address_space_memory, idaw_addr,
+                                 MEMTXATTRS_UNSPECIFIED, &idaw.fmt1,
+                                 sizeof(idaw.fmt1));
         cds->cda =3D be64_to_cpu(idaw.fmt1);
         if (cds->cda & 0x80000000) {
             return -EINVAL; /* channel program check */
diff --git a/qtest.c b/qtest.c
index 65e33b80e3..dcb57498ad 100644
--- a/qtest.c
+++ b/qtest.c
@@ -429,23 +429,23 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
=20
         if (words[0][5] =3D=3D 'b') {
             uint8_t data =3D value;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 1, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIE=
D,
+                                &data, 1);
         } else if (words[0][5] =3D=3D 'w') {
             uint16_t data =3D value;
             tswap16s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 2, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIE=
D,
+                                &data, 2);
         } else if (words[0][5] =3D=3D 'l') {
             uint32_t data =3D value;
             tswap32s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 4, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIE=
D,
+                                &data, 4);
         } else if (words[0][5] =3D=3D 'q') {
             uint64_t data =3D value;
             tswap64s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 8, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIE=
D,
+                                &data, 8);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -463,22 +463,22 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
=20
         if (words[0][4] =3D=3D 'b') {
             uint8_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 1, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
+                               &data, 1);
             value =3D data;
         } else if (words[0][4] =3D=3D 'w') {
             uint16_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 2, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
+                               &data, 2);
             value =3D tswap16(data);
         } else if (words[0][4] =3D=3D 'l') {
             uint32_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 4, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
+                               &data, 4);
             value =3D tswap32(data);
         } else if (words[0][4] =3D=3D 'q') {
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &value, 8, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
+                               &value, 8);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
@@ -498,8 +498,8 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
         g_assert(len);
=20
         data =3D g_malloc(len);
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, false);
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, da=
ta,
+                           len);
=20
         enc =3D g_malloc(2 * len + 1);
         for (i =3D 0; i < len; i++) {
@@ -524,8 +524,8 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
         g_assert(ret =3D=3D 0);
=20
         data =3D g_malloc(len);
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, false);
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, da=
ta,
+                           len);
         b64_data =3D g_base64_encode(data, len);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -559,8 +559,8 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
                 data[i] =3D 0;
             }
         }
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, true);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, d=
ata,
+                            len);
         g_free(data);
=20
         qtest_send_prefix(chr);
@@ -582,8 +582,8 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
         if (len) {
             data =3D g_malloc(len);
             memset(data, pattern, len);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, len, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIE=
D,
+                                data, len);
             g_free(data);
         }
=20
@@ -616,8 +616,8 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
             out_len =3D MIN(out_len, len);
         }
=20
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, true);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, d=
ata,
+                            len);
=20
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 451dcc983a..65d4603dbf 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -88,8 +88,8 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt=
_translation *pt,
     }
=20
     index =3D gpt_entry(pt->gva, level, pae);
-    address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
-                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), false);
+    address_space_read(&address_space_memory, gpa + index * pte_size(pae),
+                       MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae));
=20
     pt->pte[level - 1] =3D pte;
=20
@@ -238,8 +238,8 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong g=
va, void *data, int bytes
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva)=
;
         } else {
-            address_space_rw(&address_space_memory, gpa,
-                             MEMTXATTRS_UNSPECIFIED, data, copy, true);
+            address_space_write(&address_space_memory, gpa,
+                                MEMTXATTRS_UNSPECIFIED, data, copy);
         }
=20
         bytes -=3D copy;
@@ -259,8 +259,8 @@ void vmx_read_mem(struct CPUState *cpu, void *data, tar=
get_ulong gva, int bytes)
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva)=
;
         }
-        address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIE=
D,
-                         data, copy, false);
+        address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIF=
IED,
+                           data, copy);
=20
         bytes -=3D copy;
         gva +=3D copy;
--=20
2.21.1


