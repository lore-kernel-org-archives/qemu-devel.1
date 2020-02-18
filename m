Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D00A2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5c4KcJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D00A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4112-00038J-Jj
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j40zz-00027L-Rj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j40zw-000164-6S
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:25:07 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j40zv-00013m-RJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:25:04 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so2452214wme.4
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ocvgGVe4ThF/H/MiItjnPsg1c4TOZf/X4tYab+zLhRQ=;
 b=t5c4KcJq1ZD7sPMSAYWhhN6AjJDq3HeEbdTnyuqY0lNlNrfNgeP+s+nE8ggxuOMUwn
 2S/PLlToi/bCFK4GXQtrKHKnI2sNv3lK1c9HMQ/FitM3vIpqmUpIAcppV60/8Fd50HNd
 9d//7BmYNTX46eULeV2YRpUJ0E6atfeFEchPcTl/bTmLOTNFN1gDfHiNG5vmVS7VTzBK
 XcMkwynrWKRZx5VFdSnzNscbOy4fJEuGCxq+MElDnmATYNRfBIMLcOzowEohwany1mcA
 exqIVhW4TgFLNtioZVaPfuRhUed83ut/5sSpZW242FX0ZVzB8nUk1dG8f1v3121K3XBE
 4GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ocvgGVe4ThF/H/MiItjnPsg1c4TOZf/X4tYab+zLhRQ=;
 b=cvP7ZiF4sSPsZA/aiXEv1UazKbLySjrn39Ewcw8hCug0J+PqlBCcVfwn7Q9rmhKmij
 qVpKmPPm7F/RlpHDUoiJQewX1hGJl4uNKQMn5wW56gzxpUVV4yKlp3bkd4RCy2YoJtuG
 C8ctQh1U6xz7pRuRrGCkbBGxB7hvfCBWhs2u/GTUb2SuHqj5xGrWxkrHYbo3JFAS6n7k
 QA+7ji0LXb3cx8yCs929yjINd95or2YziZofbENFUP3SZm9OPDNQRos3slQ6HC8XIb8U
 biBsVvhb4tykeJBRJ2B8aJDv5Cd9DRmvcF1ViPZwsD0PYuLj3YgnXh0wxAvUaNfossI4
 8itA==
X-Gm-Message-State: APjAAAX8Le4JFnSwCbpjHOqeiBSM2jSIyCWLl8USCnq6boDQAqVN70Rj
 5Y/ablDnAcsboaZEnKaChW5GDmvejUPJMg==
X-Google-Smtp-Source: APXvYqwESrbkLGcEBhsOxmYJg5N6oIDbtIS1MCRqsLvUYx5GBBpqvHMoTA3jLc8ohXxu6kYbYH2Fgg==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr2690437wmc.18.1582025101567; 
 Tue, 18 Feb 2020 03:25:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s65sm3172352wmf.48.2020.02.18.03.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 03:25:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Avoid address_space_rw() with a constant is_write argument
Date: Tue, 18 Feb 2020 11:24:57 +0000
Message-Id: <20200218112457.22712-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
scripts/coccinelle/as-rw-const.patch.

Two lines in hw/net/dp8393x.c that Coccinelle produced that
were over 80 characters were re-wrapped by hand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I could break this down into separate patches by submaintainer,
but the patch is not that large and I would argue that it's
better for the project if we can try to avoid introducing too
much friction into the process of doing 'safe' tree-wide
minor refactorings.

v1->v2: put the coccinelle script in scripts/coccinelle rather
than just in the commit message.
---
 accel/kvm/kvm-all.c                  |  6 +--
 dma-helpers.c                        |  4 +-
 exec.c                               |  4 +-
 hw/dma/xlnx-zdma.c                   | 11 ++---
 hw/net/dp8393x.c                     | 68 ++++++++++++++--------------
 hw/net/i82596.c                      | 25 +++++-----
 hw/net/lasi_i82596.c                 |  5 +-
 hw/ppc/pnv_lpc.c                     |  8 ++--
 hw/s390x/css.c                       | 12 ++---
 qtest.c                              | 52 ++++++++++-----------
 target/i386/hvf/x86_mmu.c            | 12 ++---
 scripts/coccinelle/as_rw_const.cocci | 30 ++++++++++++
 12 files changed, 133 insertions(+), 104 deletions(-)
 create mode 100644 scripts/coccinelle/as_rw_const.cocci

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312dfdd..0cfe6fd8ded 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2178,9 +2178,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
             ent = &ring->coalesced_mmio[ring->first];
 
             if (ent->pio == 1) {
-                address_space_rw(&address_space_io, ent->phys_addr,
-                                 MEMTXATTRS_UNSPECIFIED, ent->data,
-                                 ent->len, true);
+                address_space_write(&address_space_io, ent->phys_addr,
+                                    MEMTXATTRS_UNSPECIFIED, ent->data,
+                                    ent->len);
             } else {
                 cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
             }
diff --git a/dma-helpers.c b/dma-helpers.c
index d3871dc61ea..e8a26e81e16 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -28,8 +28,8 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
         l = len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
-        error |= address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                  fillbuf, l, true);
+        error |= address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
+                                     fillbuf, l);
         len -= l;
         addr += l;
     }
diff --git a/exec.c b/exec.c
index 8e9cc3b47cf..baefe582393 100644
--- a/exec.c
+++ b/exec.c
@@ -3810,8 +3810,8 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
                                     attrs, buf, l);
         } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
-                             attrs, buf, l, 0);
+            address_space_read(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
+                               l);
         }
         len -= l;
         buf += l;
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 8fb83f5b078..31936061e21 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -311,8 +311,7 @@ static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
         return false;
     }
 
-    address_space_rw(s->dma_as, addr, s->attr,
-                     buf, sizeof(XlnxZDMADescr), false);
+    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr));
     return true;
 }
 
@@ -364,7 +363,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, bool type,
     } else {
         addr = zdma_get_regaddr64(s, basereg);
         addr += sizeof(s->dsc_dst);
-        address_space_rw(s->dma_as, addr, s->attr, (void *) &next, 8, false);
+        address_space_read(s->dma_as, addr, s->attr, (void *)&next, 8);
         zdma_put_regaddr64(s, basereg, next);
     }
     return next;
@@ -416,8 +415,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf, uint32_t len)
             }
         }
 
-        address_space_rw(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen,
-                         true);
+        address_space_write(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen);
         if (burst_type == AXI_BURST_INCR) {
             s->dsc_dst.addr += dlen;
         }
@@ -493,8 +491,7 @@ static void zdma_process_descr(XlnxZDMA *s)
                 len = s->cfg.bus_width / 8;
             }
         } else {
-            address_space_rw(s->dma_as, src_addr, s->attr, s->buf, len,
-                             false);
+            address_space_read(s->dma_as, src_addr, s->attr, s->buf, len);
             if (burst_type == AXI_BURST_INCR) {
                 src_addr += len;
             }
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a134d431ae3..f5f1c669e80 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -275,8 +275,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
-        address_space_rw(&s->as, dp8393x_cdp(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+        address_space_read(&s->as, dp8393x_cdp(s), MEMTXATTRS_UNSPECIFIED,
+                           (uint8_t *)s->data, size);
         s->cam[index][0] = dp8393x_get(s, width, 1) & 0xff;
         s->cam[index][1] = dp8393x_get(s, width, 1) >> 8;
         s->cam[index][2] = dp8393x_get(s, width, 2) & 0xff;
@@ -293,8 +293,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     }
 
     /* Read CAM enable */
-    address_space_rw(&s->as, dp8393x_cdp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    address_space_read(&s->as, dp8393x_cdp(s), MEMTXATTRS_UNSPECIFIED,
+                       (uint8_t *)s->data, size);
     s->regs[SONIC_CE] = dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
@@ -311,8 +311,8 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     /* Read memory */
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size = sizeof(uint16_t) * 4 * width;
-    address_space_rw(&s->as, dp8393x_rrp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    address_space_read(&s->as, dp8393x_rrp(s), MEMTXATTRS_UNSPECIFIED,
+                       (uint8_t *)s->data, size);
 
     /* Update SONIC registers */
     s->regs[SONIC_CRBA0] = dp8393x_get(s, width, 0);
@@ -426,8 +426,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         size = sizeof(uint16_t) * 6 * width;
         s->regs[SONIC_TTDA] = s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
-        address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+        address_space_read(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
+                           MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size);
         tx_len = 0;
 
         /* Update registers */
@@ -451,17 +451,19 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
             if (tx_len + len > sizeof(s->tx_buffer)) {
                 len = sizeof(s->tx_buffer) - tx_len;
             }
-            address_space_rw(&s->as, dp8393x_tsa(s),
-                MEMTXATTRS_UNSPECIFIED, &s->tx_buffer[tx_len], len, 0);
+            address_space_read(&s->as, dp8393x_tsa(s), MEMTXATTRS_UNSPECIFIED,
+                               &s->tx_buffer[tx_len], len);
             tx_len += len;
 
             i++;
             if (i != s->regs[SONIC_TFC]) {
                 /* Read next fragment details */
                 size = sizeof(uint16_t) * 3 * width;
-                address_space_rw(&s->as,
-                    dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
-                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                address_space_read(&s->as,
+                                   dp8393x_ttda(s)
+                                   + sizeof(uint16_t) * (4 + 3 * i) * width,
+                                   MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data,
+                                   size);
                 s->regs[SONIC_TSA0] = dp8393x_get(s, width, 0);
                 s->regs[SONIC_TSA1] = dp8393x_get(s, width, 1);
                 s->regs[SONIC_TFS] = dp8393x_get(s, width, 2);
@@ -494,18 +496,18 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         dp8393x_put(s, width, 0,
                     s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
-        address_space_rw(&s->as,
-            dp8393x_ttda(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
+        address_space_write(&s->as, dp8393x_ttda(s), MEMTXATTRS_UNSPECIFIED,
+                            (uint8_t *)s->data, size);
 
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
             size = sizeof(uint16_t) * width;
-            address_space_rw(&s->as,
-                dp8393x_ttda(s) +
-                             sizeof(uint16_t) *
-                             (4 + 3 * s->regs[SONIC_TFC]) * width,
-                MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+            address_space_read(&s->as,
+                               dp8393x_ttda(s)
+                               + sizeof(uint16_t) * (4 + 3 * s->regs[SONIC_TFC])
+                               * width,
+                               MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data,
+                               size);
             s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
             if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
@@ -767,8 +769,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* Are we still in resource exhaustion? */
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
-        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, size, 0);
+        address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                           (uint8_t *)s->data, size);
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
@@ -787,11 +789,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address = dp8393x_crba(s);
-    address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *)buf, rx_len);
     address += rx_len;
-    address_space_rw(&s->as, address,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
+    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *)&checksum, 4);
     rx_len += 4;
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
@@ -819,13 +821,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     dp8393x_put(s, width, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
     dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
-    address_space_rw(&s->as, dp8393x_crda(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
+    address_space_write(&s->as, dp8393x_crda(s), MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *)s->data, size);
 
     /* Move to next descriptor */
     size = sizeof(uint16_t) * width;
-    address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    address_space_read(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
+                       MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size);
     s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
@@ -838,8 +840,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
             offset += sizeof(uint16_t);
         }
         s->data[0] = 0;
-        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, sizeof(uint16_t), 1);
+        address_space_write(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
+                            (uint8_t *)s->data, sizeof(uint16_t));
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 3a0e1ec4c05..6a80c24af23 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -148,8 +148,8 @@ static void i82596_transmit(I82596State *s, uint32_t addr)
 
         if (s->nic && len) {
             assert(len <= sizeof(s->tx_buffer));
-            address_space_rw(&address_space_memory, tba,
-                MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, 0);
+            address_space_read(&address_space_memory, tba,
+                               MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len);
             DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
             DBG(printf("Sending %d bytes\n", len));
             qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
@@ -172,8 +172,8 @@ static void set_individual_address(I82596State *s, uint32_t addr)
 
     nc = qemu_get_queue(s->nic);
     m = s->conf.macaddr.a;
-    address_space_rw(&address_space_memory, addr + 8,
-        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, 0);
+    address_space_read(&address_space_memory, addr + 8,
+                       MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN);
     qemu_format_nic_info_str(nc, m);
     trace_i82596_new_mac(nc->info_str);
 }
@@ -190,9 +190,8 @@ static void set_multicast_list(I82596State *s, uint32_t addr)
     }
     for (i = 0; i < mc_count; i++) {
         uint8_t multicast_addr[ETH_ALEN];
-        address_space_rw(&address_space_memory,
-            addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
-            multicast_addr, ETH_ALEN, 0);
+        address_space_read(&address_space_memory, addr + i * ETH_ALEN,
+                           MEMTXATTRS_UNSPECIFIED, multicast_addr, ETH_ALEN);
         DBG(printf("Add multicast entry " MAC_FMT "\n",
                     MAC_ARG(multicast_addr)));
         unsigned mcast_idx = (net_crc32(multicast_addr, ETH_ALEN) &
@@ -260,8 +259,8 @@ static void command_loop(I82596State *s)
             byte_cnt = MAX(byte_cnt, 4);
             byte_cnt = MIN(byte_cnt, sizeof(s->config));
             /* copy byte_cnt max. */
-            address_space_rw(&address_space_memory, s->cmd_p + 8,
-                MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt, 0);
+            address_space_read(&address_space_memory, s->cmd_p + 8,
+                               MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt);
             /* config byte according to page 35ff */
             s->config[2] &= 0x82; /* mask valid bits */
             s->config[2] |= 0x40;
@@ -640,14 +639,14 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
             }
             rba = get_uint32(rbd + 8);
             /* printf("rba is 0x%x\n", rba); */
-            address_space_rw(&address_space_memory, rba,
-                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);
+            address_space_write(&address_space_memory, rba,
+                                MEMTXATTRS_UNSPECIFIED, (void *)buf, num);
             rba += num;
             buf += num;
             len -= num;
             if (len == 0) { /* copy crc */
-                address_space_rw(&address_space_memory, rba - 4,
-                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, 1);
+                address_space_write(&address_space_memory, rba - 4,
+                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
             }
 
             num |= 0x4000; /* set F BIT */
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 427b3fbf701..52637a562d8 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -55,8 +55,9 @@ static void lasi_82596_mem_write(void *opaque, hwaddr addr,
          * Provided for SeaBIOS only. Write MAC of Network card to addr @val.
          * Needed for the PDC_LAN_STATION_ID_READ PDC call.
          */
-        address_space_rw(&address_space_memory, val,
-            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a, ETH_ALEN, 1);
+        address_space_write(&address_space_memory, val,
+                            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a,
+                            ETH_ALEN);
         break;
     }
 }
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 5989d723c50..f150deca340 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -238,16 +238,16 @@ static bool opb_read(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
                      int sz)
 {
     /* XXX Handle access size limits and FW read caching here */
-    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, sz, false);
+    return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
+                               data, sz);
 }
 
 static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *data,
                       int sz)
 {
     /* XXX Handle access size limits here */
-    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, sz, true);
+    return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
+                                data, sz);
 }
 
 #define ECCB_CTL_READ           PPC_BIT(15)
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 844caab4082..0e0fccd050e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -874,18 +874,18 @@ static inline int ida_read_next_idaw(CcwDataStream *cds)
         if (idaw_addr & 0x07 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
             return -EINVAL; /* channel program check */
         }
-        ret = address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
-                               sizeof(idaw.fmt2), false);
+        ret = address_space_read(&address_space_memory, idaw_addr,
+                                 MEMTXATTRS_UNSPECIFIED, (void *)&idaw.fmt2,
+                                 sizeof(idaw.fmt2));
         cds->cda = be64_to_cpu(idaw.fmt2);
     } else {
         idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
         if (idaw_addr & 0x03 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
             return -EINVAL; /* channel program check */
         }
-        ret = address_space_rw(&address_space_memory, idaw_addr,
-                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
-                               sizeof(idaw.fmt1), false);
+        ret = address_space_read(&address_space_memory, idaw_addr,
+                                 MEMTXATTRS_UNSPECIFIED, (void *)&idaw.fmt1,
+                                 sizeof(idaw.fmt1));
         cds->cda = be64_to_cpu(idaw.fmt1);
         if (cds->cda & 0x80000000) {
             return -EINVAL; /* channel program check */
diff --git a/qtest.c b/qtest.c
index 12432f99cf4..328d674bcc8 100644
--- a/qtest.c
+++ b/qtest.c
@@ -429,23 +429,23 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 1, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 2, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                (uint8_t *)&data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 4, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                (uint8_t *)&data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 8, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                (uint8_t *)&data, 8);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -463,22 +463,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             &data, 1, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 2, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               (uint8_t *)&data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &data, 4, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               (uint8_t *)&data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             (uint8_t *) &value, 8, false);
+            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                               (uint8_t *)&value, 8);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
@@ -498,8 +498,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, false);
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           len);
 
         enc = g_malloc(2 * len + 1);
         for (i = 0; i < len; i++) {
@@ -524,8 +524,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, false);
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           len);
         b64_data = g_base64_encode(data, len);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -559,8 +559,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, true);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                            len);
         g_free(data);
 
         qtest_send_prefix(chr);
@@ -582,8 +582,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                             data, len, true);
+            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                                data, len);
             g_free(data);
         }
 
@@ -616,8 +616,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                         data, len, true);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                            len);
 
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index d5a0efe7188..ff016fc0145 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -88,8 +88,8 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
     }
 
     index = gpt_entry(pt->gva, level, pae);
-    address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
-                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pte, pte_size(pae), 0);
+    address_space_read(&address_space_memory, gpa + index * pte_size(pae),
+                       MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pte, pte_size(pae));
 
     pt->pte[level - 1] = pte;
 
@@ -238,8 +238,8 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         } else {
-            address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-                             data, copy, 1);
+            address_space_write(&address_space_memory, gpa,
+                                MEMTXATTRS_UNSPECIFIED, data, copy);
         }
 
         bytes -= copy;
@@ -259,8 +259,8 @@ void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes)
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         }
-        address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-                         data, copy, 0);
+        address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                           data, copy);
 
         bytes -= copy;
         gva += copy;
diff --git a/scripts/coccinelle/as_rw_const.cocci b/scripts/coccinelle/as_rw_const.cocci
new file mode 100644
index 00000000000..30da707701b
--- /dev/null
+++ b/scripts/coccinelle/as_rw_const.cocci
@@ -0,0 +1,30 @@
+// Avoid uses of address_space_rw() with a constant is_write argument.
+// Usage:
+//  spatch --sp-file as-rw-const.spatch --dir . --in-place
+
+@@
+expression E1, E2, E3, E4, E5;
+symbol false;
+@@
+
+- address_space_rw(E1, E2, E3, E4, E5, false)
++ address_space_read(E1, E2, E3, E4, E5)
+@@
+expression E1, E2, E3, E4, E5;
+@@
+
+- address_space_rw(E1, E2, E3, E4, E5, 0)
++ address_space_read(E1, E2, E3, E4, E5)
+@@
+expression E1, E2, E3, E4, E5;
+symbol true;
+@@
+
+- address_space_rw(E1, E2, E3, E4, E5, true)
++ address_space_write(E1, E2, E3, E4, E5)
+@@
+expression E1, E2, E3, E4, E5;
+@@
+
+- address_space_rw(E1, E2, E3, E4, E5, 1)
++ address_space_write(E1, E2, E3, E4, E5)
-- 
2.20.1


