Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F83C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED18218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juGnR8O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED18218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zmd-0006QE-7x
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlS-0002DU-Ch
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlQ-00023I-E7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlQ-0001zr-5X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so14386272wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wtR+ce3Urlbs3edVC+Je524/wruoJldpKDJO53XFtbc=;
 b=juGnR8O+kZmMX25KlX69feU+0i0VuBepAxtVr5BzTxRMWY493KBE2mniFyxzmB4eE0
 WCzatwtmp58NqgYuC2GKyze82cL/mPFQbsX7EO9CzwZUWYqOE77vh5TUz5ET0rb6erEW
 tcZliu0s022Ah7Ahfqp5K/8Qf4d2chE5mOA1H4JQ+v7zSlDioAUKCCXJycKnFgiK2Db8
 ERvV6Q8MkSnrZ/t7xCYoYEUdqkjAKVWJNUBn0T5FI/dIdj+hurW/7+Xz7O7WM1hY0Vbw
 TOvD/GP7//NX93w1z9td7jktmHGs0h9R5Mc4B6zPFbUF+3g0+ikW/p636QrBIzSOW8RQ
 VoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wtR+ce3Urlbs3edVC+Je524/wruoJldpKDJO53XFtbc=;
 b=hPJGRhrmI0WuR2g4e3BeDeysGCfnYFjp/gQX0zo7YUFwzB1UaMGGPmPTCYrb57aJFg
 lyf6V8PgZCIwZiacbzmTpShSllyKApKFvp4hV/YctUPUY1UHCTMFDPvwwbUYO/bT2Aa/
 eIXV6ke65Il+/PmlK8DMIVRisLgPvLmGeqpPPEV6+m9ioe4cxpQfWxec78GtATpa7IEc
 CfclNQ98XsIqdfQqeHqmmugKnP+vWMndj2dwSDodgKaJFkbCvKWRf/hBBHnfuVYzapJ2
 e48iFVfqRsr6HwFiP+G3keOYb4cbia/9yaW5qou2gWeKELHp+9RJgyZhLC+1AjsXFaEt
 adnw==
X-Gm-Message-State: APjAAAVyBE2sB/g2+BhKLfiRK17ZSp/zORy/5RNlHJlsRqjS1zGC037J
 TUhvJ/D0/288phVSywlnaCR9N+9W
X-Google-Smtp-Source: APXvYqwhyMOsoY/2Rvz+EpAYP3gwHNLXh4D8yuxFDjbgPZe6camVPRMlBdiqyvPub7e8qJesJ9sxMA==
X-Received: by 2002:adf:f10b:: with SMTP id r11mr73076054wro.307.1582631553464; 
 Tue, 25 Feb 2020 03:52:33 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 094/136] Let address_space_rw() calls pass a boolean 'is_write'
 argument
Date: Tue, 25 Feb 2020 12:50:24 +0100
Message-Id: <1582631466-13880-94-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Since its introduction in commit ac1970fbe8, address_space_rw()
takes a boolean 'is_write' argument. Fix the codebase by using
an explicit boolean type.

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c                                 |  4 ++--
 hw/net/dp8393x.c                       | 27 ++++++++++++++-------------
 hw/net/i82596.c                        | 11 ++++++-----
 hw/net/lasi_i82596.c                   |  4 ++--
 scripts/coccinelle/exec_rw_const.cocci | 12 ++++++++++++
 target/i386/hvf/vmx.h                  |  2 +-
 target/i386/hvf/x86_mmu.c              |  8 ++++----
 7 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/exec.c b/exec.c
index 239239d..90ac015 100644
--- a/exec.c
+++ b/exec.c
@@ -3815,8 +3815,8 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
                                     attrs, buf, l);
         } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
-                             attrs, buf, l, 0);
+            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
+                             l, false);
         }
         len -= l;
         buf += l;
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b461101..b4363e3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -276,7 +276,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
         s->cam[index][0] = dp8393x_get(s, width, 1) & 0xff;
         s->cam[index][1] = dp8393x_get(s, width, 1) >> 8;
         s->cam[index][2] = dp8393x_get(s, width, 2) & 0xff;
@@ -294,7 +294,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
     s->regs[SONIC_CE] = dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
@@ -312,7 +312,7 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size = sizeof(uint16_t) * 4 * width;
     address_space_rw(&s->as, dp8393x_rrp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
 
     /* Update SONIC registers */
     s->regs[SONIC_CRBA0] = dp8393x_get(s, width, 0);
@@ -427,7 +427,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TTDA] = s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
         address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
         tx_len = 0;
 
         /* Update registers */
@@ -452,7 +452,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 len = sizeof(s->tx_buffer) - tx_len;
             }
             address_space_rw(&s->as, dp8393x_tsa(s),
-                MEMTXATTRS_UNSPECIFIED, &s->tx_buffer[tx_len], len, 0);
+                             MEMTXATTRS_UNSPECIFIED,
+                             &s->tx_buffer[tx_len], len, false);
             tx_len += len;
 
             i++;
@@ -461,7 +462,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 size = sizeof(uint16_t) * 3 * width;
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
-                                 MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                                 MEMTXATTRS_UNSPECIFIED, s->data, size, false);
                 s->regs[SONIC_TSA0] = dp8393x_get(s, width, 0);
                 s->regs[SONIC_TSA1] = dp8393x_get(s, width, 1);
                 s->regs[SONIC_TFS] = dp8393x_get(s, width, 2);
@@ -496,7 +497,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
                          dp8393x_ttda(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, 1);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, true);
 
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
@@ -505,7 +506,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                              dp8393x_ttda(s) +
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
-                             MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->data, size, false);
             s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
             if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
@@ -768,7 +769,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         s->data, size, 0);
+                         s->data, size, false);
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
@@ -790,7 +791,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_len);
     address += rx_len;
     address_space_rw(&s->as, address,
-                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, 1);
+                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, true);
     rx_len += 4;
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
@@ -819,12 +820,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 1);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, true);
 
     /* Move to next descriptor */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
     s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
@@ -838,7 +839,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         }
         s->data[0] = 0;
         address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         s->data, sizeof(uint16_t), 1);
+                         s->data, sizeof(uint16_t), true);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a292984..11537f7 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -149,7 +149,7 @@ static void i82596_transmit(I82596State *s, uint32_t addr)
         if (s->nic && len) {
             assert(len <= sizeof(s->tx_buffer));
             address_space_rw(&address_space_memory, tba,
-                MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, false);
             DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
             DBG(printf("Sending %d bytes\n", len));
             qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
@@ -173,7 +173,7 @@ static void set_individual_address(I82596State *s, uint32_t addr)
     nc = qemu_get_queue(s->nic);
     m = s->conf.macaddr.a;
     address_space_rw(&address_space_memory, addr + 8,
-        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, 0);
+                     MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, false);
     qemu_format_nic_info_str(nc, m);
     trace_i82596_new_mac(nc->info_str);
 }
@@ -192,7 +192,7 @@ static void set_multicast_list(I82596State *s, uint32_t addr)
         uint8_t multicast_addr[ETH_ALEN];
         address_space_rw(&address_space_memory,
             addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
-            multicast_addr, ETH_ALEN, 0);
+                         multicast_addr, ETH_ALEN, false);
         DBG(printf("Add multicast entry " MAC_FMT "\n",
                     MAC_ARG(multicast_addr)));
         unsigned mcast_idx = (net_crc32(multicast_addr, ETH_ALEN) &
@@ -261,7 +261,8 @@ static void command_loop(I82596State *s)
             byte_cnt = MIN(byte_cnt, sizeof(s->config));
             /* copy byte_cnt max. */
             address_space_rw(&address_space_memory, s->cmd_p + 8,
-                MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt,
+                             false);
             /* config byte according to page 35ff */
             s->config[2] &= 0x82; /* mask valid bits */
             s->config[2] |= 0x40;
@@ -647,7 +648,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t sz)
             len -= num;
             if (len == 0) { /* copy crc */
                 address_space_rw(&address_space_memory, rba - 4,
-                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, 1);
+                                 MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, true);
             }
 
             num |= 0x4000; /* set F BIT */
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 427b3fb..8bff419 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -55,8 +55,8 @@ static void lasi_82596_mem_write(void *opaque, hwaddr addr,
          * Provided for SeaBIOS only. Write MAC of Network card to addr @val.
          * Needed for the PDC_LAN_STATION_ID_READ PDC call.
          */
-        address_space_rw(&address_space_memory, val,
-            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a, ETH_ALEN, 1);
+        address_space_rw(&address_space_memory, val, MEMTXATTRS_UNSPECIFIED,
+                         d->state.conf.macaddr.a, ETH_ALEN, true);
         break;
     }
 }
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 9c14165..493d79c 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -9,6 +9,18 @@
            --dir .
 */
 
+// Convert to boolean
+@@
+expression E1, E2, E3, E4, E5;
+@@
+(
+- address_space_rw(E1, E2, E3, E4, E5, 0)
++ address_space_rw(E1, E2, E3, E4, E5, false)
+|
+- address_space_rw(E1, E2, E3, E4, E5, 1)
++ address_space_rw(E1, E2, E3, E4, E5, true)
+)
+
 // Use address_space_write instead of casting to non-const
 @@
 type T;
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index a115ca1..19af029 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -128,7 +128,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
         address_space_rw(&address_space_memory,
                          rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
                          MEMTXATTRS_UNSPECIFIED,
-                         pdpte, 32, 0);
+                         pdpte, 32, false);
         /* Only set PDPTE when appropriate. */
         for (i = 0; i < 4; i++) {
             wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 6a62064..451dcc9 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -89,7 +89,7 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
 
     index = gpt_entry(pt->gva, level, pae);
     address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
-                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), 0);
+                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), false);
 
     pt->pte[level - 1] = pte;
 
@@ -238,8 +238,8 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, int bytes
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         } else {
-            address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-                             data, copy, 1);
+            address_space_rw(&address_space_memory, gpa,
+                             MEMTXATTRS_UNSPECIFIED, data, copy, true);
         }
 
         bytes -= copy;
@@ -260,7 +260,7 @@ void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, int bytes)
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
         }
         address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
-                         data, copy, 0);
+                         data, copy, false);
 
         bytes -= copy;
         gva += copy;
-- 
1.8.3.1



