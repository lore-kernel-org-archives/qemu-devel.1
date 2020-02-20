Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3DBC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF66F20722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMZraOGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF66F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lhN-00086s-4I
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXi-0006Ac-0A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXf-0005if-L7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:07:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55294
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXe-0005hQ-99
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582204017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PwVfta2T/yY9fXrs1bpbk8EWKAqkE2atADSJKtO6lc=;
 b=aMZraOGsZO86CJJlCmjIJyrRCBZ/McJ97zH0wV4UgJAJelsNoACqYcBQFog+Wa1eES2XT6
 licHRAi2PbZ3Rj8bBdPOt9yChrTMgBL8LEgJluT2Lq73GI++BtWebwYag51+GP3h2rnluE
 d6x5URZex6J0ek8gAnjSbWq8XAh2veU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-yAsfuQdhPVygUAk_kTOW1w-1; Thu, 20 Feb 2020 08:06:56 -0500
Received: by mail-wm1-f69.google.com with SMTP id b205so807281wmh.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mOFaN72GDMCW5HO6VjgTUS8UF4EBg1PhikK6Z5qXel0=;
 b=Zenc46viiCPJGBIz7GlTC4P3dOiztrXx0XxJQHbrjENBOa1MC3sie/+0Tj92Xx1wVL
 uuVJMcE3uCaXLK45CcgHerFdCd+fkxPXQLGONlEssI5HNvcV75IRaZ2W6w8FVBtOBZtx
 gfsBbsSygeVWG98F+xG2UoD1Gt4Nd1KNppLkm9K9S2LI2xWIvqmqNVJvgAkhzQpkHF9p
 8oyJYj0BTCH4vizRqeByBskBwMZytpaknmM/3o+ph+loe8Az4T6BkMHnFWKsPD6kYiuJ
 kp7aVfptpOTmnPCPX1R4UHmoQQ3jUE96toy2XxqKz/KBlgOXgi557/+oWl3v0HrCbK4+
 JhTA==
X-Gm-Message-State: APjAAAVZLs+Ny6C7WYsp+hiVLEEzIhFKDHFB0KVN0KK9g4cx6S3yUFCh
 orDhOY0WBOtWU7O7lZgx3Kkr3syCtCp5INGgbcRjdF7XH+xv7jHovbj22yTXj77idjwWccNqjn3
 dzW0oc0H3B8zQZPo=
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr4525013wmf.124.1582204014475; 
 Thu, 20 Feb 2020 05:06:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVjczz55ql1rEb/MuCKbM4mbnGg2+QP76S0K4doZSf4ATrQ7PaxLlWrdmPAnroUu1OpiGw2w==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr4524974wmf.124.1582204014007; 
 Thu, 20 Feb 2020 05:06:54 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 16/20] Let address_space_rw() calls pass a boolean
 'is_write' argument
Date: Thu, 20 Feb 2020 14:05:44 +0100
Message-Id: <20200220130548.29974-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: yAsfuQdhPVygUAk_kTOW1w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Since its introduction in commit ac1970fbe8, address_space_rw()
takes a boolean 'is_write' argument. Fix the codebase by using
an explicit boolean type.

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/exec_rw_const.cocci | 12 ++++++++++++
 target/i386/hvf/vmx.h                  |  2 +-
 exec.c                                 |  4 ++--
 hw/net/dp8393x.c                       | 27 +++++++++++++-------------
 hw/net/i82596.c                        | 11 ++++++-----
 hw/net/lasi_i82596.c                   |  4 ++--
 target/i386/hvf/x86_mmu.c              |  8 ++++----
 7 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/ex=
ec_rw_const.cocci
index 70cf52d58e..98cb06f09f 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -1,6 +1,18 @@
 // Usage:
 //  spatch --sp-file scripts/coccinelle/exec_rw_const.cocci --dir . --in-p=
lace
=20
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
index a115ca1782..19af029133 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -128,7 +128,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint=
64_t cr0)
         address_space_rw(&address_space_memory,
                          rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
                          MEMTXATTRS_UNSPECIFIED,
-                         pdpte, 32, 0);
+                         pdpte, 32, false);
         /* Only set PDPTE when appropriate. */
         for (i =3D 0; i < 4; i++) {
             wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
diff --git a/exec.c b/exec.c
index 16974d4f4b..73c3bcfa40 100644
--- a/exec.c
+++ b/exec.c
@@ -3815,8 +3815,8 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong a=
ddr,
             address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
                                     attrs, buf, l);
         } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
-                             attrs, buf, l, 0);
+            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, bu=
f,
+                             l, false);
         }
         len -=3D l;
         buf +=3D l;
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b461101ceb..b4363e3186 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -276,7 +276,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
         s->cam[index][0] =3D dp8393x_get(s, width, 1) & 0xff;
         s->cam[index][1] =3D dp8393x_get(s, width, 1) >> 8;
         s->cam[index][2] =3D dp8393x_get(s, width, 2) & 0xff;
@@ -294,7 +294,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
=20
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
     s->regs[SONIC_CE] =3D dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
=20
@@ -312,7 +312,7 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size =3D sizeof(uint16_t) * 4 * width;
     address_space_rw(&s->as, dp8393x_rrp(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
=20
     /* Update SONIC registers */
     s->regs[SONIC_CRBA0] =3D dp8393x_get(s, width, 0);
@@ -427,7 +427,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
         s->regs[SONIC_TTDA] =3D s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
         address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * widt=
h,
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, false);
         tx_len =3D 0;
=20
         /* Update registers */
@@ -452,7 +452,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
                 len =3D sizeof(s->tx_buffer) - tx_len;
             }
             address_space_rw(&s->as, dp8393x_tsa(s),
-                MEMTXATTRS_UNSPECIFIED, &s->tx_buffer[tx_len], len, 0);
+                             MEMTXATTRS_UNSPECIFIED,
+                             &s->tx_buffer[tx_len], len, false);
             tx_len +=3D len;
=20
             i++;
@@ -461,7 +462,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
                 size =3D sizeof(uint16_t) * 3 * width;
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * wid=
th,
-                                 MEMTXATTRS_UNSPECIFIED, s->data, size, 0)=
;
+                                 MEMTXATTRS_UNSPECIFIED, s->data, size, fa=
lse);
                 s->regs[SONIC_TSA0] =3D dp8393x_get(s, width, 0);
                 s->regs[SONIC_TSA1] =3D dp8393x_get(s, width, 1);
                 s->regs[SONIC_TFS] =3D dp8393x_get(s, width, 2);
@@ -496,7 +497,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
         size =3D sizeof(uint16_t) * width;
         address_space_rw(&s->as,
                          dp8393x_ttda(s),
-                         MEMTXATTRS_UNSPECIFIED, s->data, size, 1);
+                         MEMTXATTRS_UNSPECIFIED, s->data, size, true);
=20
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
@@ -505,7 +506,7 @@ static void dp8393x_do_transmit_packets(dp8393xState *s=
)
                              dp8393x_ttda(s) +
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
-                             MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->data, size, false)=
;
             s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
             if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
@@ -768,7 +769,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
         size =3D sizeof(uint16_t) * 1 * width;
         address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         s->data, size, 0);
+                         s->data, size, false);
         if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
@@ -790,7 +791,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
     address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED, buf, rx_l=
en);
     address +=3D rx_len;
     address_space_rw(&s->as, address,
-                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, 1);
+                     MEMTXATTRS_UNSPECIFIED, &checksum, 4, true);
     rx_len +=3D 4;
     s->regs[SONIC_CRBA1] =3D address >> 16;
     s->regs[SONIC_CRBA0] =3D address & 0xffff;
@@ -819,12 +820,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size =3D sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 1);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, true);
=20
     /* Move to next descriptor */
     size =3D sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * widt=
h,
-                     MEMTXATTRS_UNSPECIFIED, s->data, size, 0);
+                     MEMTXATTRS_UNSPECIFIED, s->data, size, false);
     s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
@@ -838,7 +839,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
         }
         s->data[0] =3D 0;
         address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         s->data, sizeof(uint16_t), 1);
+                         s->data, sizeof(uint16_t), true);
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[=
SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a292984e06..11537f72d1 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -149,7 +149,7 @@ static void i82596_transmit(I82596State *s, uint32_t ad=
dr)
         if (s->nic && len) {
             assert(len <=3D sizeof(s->tx_buffer));
             address_space_rw(&address_space_memory, tba,
-                MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, fa=
lse);
             DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
             DBG(printf("Sending %d bytes\n", len));
             qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
@@ -173,7 +173,7 @@ static void set_individual_address(I82596State *s, uint=
32_t addr)
     nc =3D qemu_get_queue(s->nic);
     m =3D s->conf.macaddr.a;
     address_space_rw(&address_space_memory, addr + 8,
-        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, 0);
+                     MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, false);
     qemu_format_nic_info_str(nc, m);
     trace_i82596_new_mac(nc->info_str);
 }
@@ -192,7 +192,7 @@ static void set_multicast_list(I82596State *s, uint32_t=
 addr)
         uint8_t multicast_addr[ETH_ALEN];
         address_space_rw(&address_space_memory,
             addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
-            multicast_addr, ETH_ALEN, 0);
+                         multicast_addr, ETH_ALEN, false);
         DBG(printf("Add multicast entry " MAC_FMT "\n",
                     MAC_ARG(multicast_addr)));
         unsigned mcast_idx =3D (net_crc32(multicast_addr, ETH_ALEN) &
@@ -261,7 +261,8 @@ static void command_loop(I82596State *s)
             byte_cnt =3D MIN(byte_cnt, sizeof(s->config));
             /* copy byte_cnt max. */
             address_space_rw(&address_space_memory, s->cmd_p + 8,
-                MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt, 0);
+                             MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt,
+                             false);
             /* config byte according to page 35ff */
             s->config[2] &=3D 0x82; /* mask valid bits */
             s->config[2] |=3D 0x40;
@@ -647,7 +648,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint8_=
t *buf, size_t sz)
             len -=3D num;
             if (len =3D=3D 0) { /* copy crc */
                 address_space_rw(&address_space_memory, rba - 4,
-                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, 1);
+                                 MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, true)=
;
             }
=20
             num |=3D 0x4000; /* set F BIT */
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 427b3fbf70..8bff419378 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -55,8 +55,8 @@ static void lasi_82596_mem_write(void *opaque, hwaddr add=
r,
          * Provided for SeaBIOS only. Write MAC of Network card to addr @v=
al.
          * Needed for the PDC_LAN_STATION_ID_READ PDC call.
          */
-        address_space_rw(&address_space_memory, val,
-            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a, ETH_ALEN, 1);
+        address_space_rw(&address_space_memory, val, MEMTXATTRS_UNSPECIFIE=
D,
+                         d->state.conf.macaddr.a, ETH_ALEN, true);
         break;
     }
 }
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 6a620643c1..451dcc983a 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -89,7 +89,7 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt=
_translation *pt,
=20
     index =3D gpt_entry(pt->gva, level, pae);
     address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
-                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), 0);
+                     MEMTXATTRS_UNSPECIFIED, &pte, pte_size(pae), false);
=20
     pt->pte[level - 1] =3D pte;
=20
@@ -238,8 +238,8 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong g=
va, void *data, int bytes
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva)=
;
         } else {
-            address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPEC=
IFIED,
-                             data, copy, 1);
+            address_space_rw(&address_space_memory, gpa,
+                             MEMTXATTRS_UNSPECIFIED, data, copy, true);
         }
=20
         bytes -=3D copy;
@@ -260,7 +260,7 @@ void vmx_read_mem(struct CPUState *cpu, void *data, tar=
get_ulong gva, int bytes)
             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva)=
;
         }
         address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIE=
D,
-                         data, copy, 0);
+                         data, copy, false);
=20
         bytes -=3D copy;
         gva +=3D copy;
--=20
2.21.1


