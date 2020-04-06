Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B766C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07ED206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1HmjqTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07ED206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVtL-0004gl-Ty
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqj-0001Sr-2q
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqg-0001Og-0x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqf-0001Iz-Pp; Mon, 06 Apr 2020 13:47:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id g3so528283wrx.2;
 Mon, 06 Apr 2020 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2rmRZ8EJBuNRGYmD7sOjQOcGn9wy27OJ72EAKJJ6t9Q=;
 b=a1HmjqTXwLEeQNBl+IjNTUAIoDur89BD8uzU7eqvS3PP6M1VlcsnV6GeRYQyaNNMnA
 h9U7ZGx0k8gOFtJXewZ64r19yXKMXRACLuOeQjQxO1RYW1QVC+SZPyv6J88aDTEtJccg
 JbriKJIUplt+/a8GqtpghvFk9A3qYeFDJbx6nz/EszmdH7/tUIAapdvx4/CPfogJ8uOW
 MIlstw/BLWe3+iazq2svu+ye+wLvJ6rqO3fVsgITZrAheZLyewvM+UDZlrBIFh/YnHKz
 ikaKOJ9JRXGj1Gg+ZpZlg7Wafdfux2IBBbX1EPZ0wqfP74YhQPY18Is4+SvwyBAeDFBW
 0Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2rmRZ8EJBuNRGYmD7sOjQOcGn9wy27OJ72EAKJJ6t9Q=;
 b=Z0wtJqRUuXbYfTL6NpufGiHjAF0klI0Fdm8QoIxADNb0Z6DT59aStQXDJ965DnOvvy
 6pb11qEd+KAgftKsKMrrLjifOzQ4i+g4FFQUVfUsVH844ZUoF47Am3XDu7fE3MqjWM58
 YgrI7KUdvtxFCpikd6Gv5Dv7zbge8Fc22Z2MQErInoSqu/jNTTo/KkPRCWGKB589I6th
 CvqDApWN2/6PwMT68jhYD5i3VAuFZ/Dete07sVLQkWen7V7js6EpSQmtyBKbn92BfxVC
 oB0+A+5GeGkFsKD8LZtgmKXIXRJK95d/FMS+gSa3Fsadw/mYXhwPiUXOYhRKZXOtH9Hg
 S9ng==
X-Gm-Message-State: AGi0Pua7ugTGnMS+moBfOAmO9Bd2m1bxdLOfUufQWjiTol7g8MZj8xij
 TpI6bAYVdTfsM6ilUipDn/d6G7l2JAI=
X-Google-Smtp-Source: APiQypJMS9g2sBloVFBfjNbgKNfiMBE2qlrq/9dgafK3kRU3B6Y/KGhGTngEk1PNxdZCNXoJw7aLbw==
X-Received: by 2002:adf:e744:: with SMTP id c4mr327360wrn.133.1586195267687;
 Mon, 06 Apr 2020 10:47:47 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 01/54] various: Remove suspicious '\' character
 outside of #define in C code
Date: Mon,  6 Apr 2020 19:46:50 +0200
Message-Id: <20200406174743.16956-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the following coccinelle warnings:

  $ spatch --sp-file --verbose-parsing  ... \
      scripts/coccinelle/remove_local_err.cocci
  ...
  SUSPICIOUS: a \ character appears outside of a #define at ./target/ppc/translate_init.inc.c:5213
  SUSPICIOUS: a \ character appears outside of a #define at ./target/ppc/translate_init.inc.c:5261
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:166
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:167
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:169
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:170
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:171
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:172
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microblaze/cpu.c:173
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5787
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5789
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5800
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5801
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5802
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5804
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5805
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:5806
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/cpu.c:6329
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/sd/sdhci.c:1133
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/scsi/scsi-disk.c:3081
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/net/virtio-net.c:1529
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/riscv/sifive_u.c:468
  SUSPICIOUS: a \ character appears outside of a #define at ./dump/dump.c:1895
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:2209
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:2215
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:2221
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:2222
  SUSPICIOUS: a \ character appears outside of a #define at ./block/replication.c:172
  SUSPICIOUS: a \ character appears outside of a #define at ./block/replication.c:173

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/replication.c             |  4 ++--
 block/vhdx.c                    |  8 ++++----
 dump/dump.c                     |  2 +-
 hw/net/virtio-net.c             |  2 +-
 hw/riscv/sifive_u.c             |  2 +-
 hw/scsi/scsi-disk.c             |  2 +-
 hw/sd/sdhci.c                   |  2 +-
 target/i386/cpu.c               | 18 +++++++++---------
 target/microblaze/cpu.c         | 14 +++++++-------
 target/ppc/translate_init.inc.c |  4 ++--
 10 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 413d95407d..5e09951c6b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -169,8 +169,8 @@ static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
     if ((bs->open_flags & (BDRV_O_INACTIVE | BDRV_O_RDWR)) == BDRV_O_RDWR) {
         *nperm |= BLK_PERM_WRITE;
     }
-    *nshared = BLK_PERM_CONSISTENT_READ \
-               | BLK_PERM_WRITE \
+    *nshared = BLK_PERM_CONSISTENT_READ
+               | BLK_PERM_WRITE
                | BLK_PERM_WRITE_UNCHANGED;
     return;
 }
diff --git a/block/vhdx.c b/block/vhdx.c
index 33e57cd656..e16fdc2f2d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2206,20 +2206,20 @@ static QemuOptsList vhdx_create_opts = {
            .name = VHDX_BLOCK_OPT_BLOCK_SIZE,
            .type = QEMU_OPT_SIZE,
            .def_value_str = stringify(0),
-           .help = "Block Size; min 1MB, max 256MB. " \
+           .help = "Block Size; min 1MB, max 256MB. "
                    "0 means auto-calculate based on image size."
        },
        {
            .name = BLOCK_OPT_SUBFMT,
            .type = QEMU_OPT_STRING,
-           .help = "VHDX format type, can be either 'dynamic' or 'fixed'. "\
+           .help = "VHDX format type, can be either 'dynamic' or 'fixed'. "
                    "Default is 'dynamic'."
        },
        {
            .name = VHDX_BLOCK_OPT_ZERO,
            .type = QEMU_OPT_BOOL,
-           .help = "Force use of payload blocks of type 'ZERO'. "\
-                   "Non-standard, but default.  Do not set to 'off' when "\
+           .help = "Force use of payload blocks of type 'ZERO'. "
+                   "Non-standard, but default.  Do not set to 'off' when "
                    "using 'qemu-img convert' with subformat=dynamic."
        },
        { NULL }
diff --git a/dump/dump.c b/dump/dump.c
index 22ed1d3b0d..248ea06370 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1892,7 +1892,7 @@ static void dump_process(DumpState *s, Error **errp)
     result = qmp_query_dump(NULL);
     /* should never fail */
     assert(result);
-    qapi_event_send_dump_completed(result, !!local_err, (local_err ? \
+    qapi_event_send_dump_completed(result, !!local_err, (local_err ?
                                    error_get_pretty(local_err) : NULL));
     qapi_free_DumpQueryResult(result);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a46e3b37a7..eddfa7f923 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1526,7 +1526,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRscChain *chain,
                                  + sizeof(struct eth_header));
     unit->ip = ip6;
     unit->ip_plen = &(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
-    unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip)\
+    unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip)
                                         + sizeof(struct ip6_header));
     unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 56351c4faa..998666c91f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -465,7 +465,7 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
     object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
                              sifive_u_set_start_in_flash, NULL);
     object_property_set_description(obj, "start-in-flash",
-                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "Set on to tell QEMU's ROM to jump to "
                                     "flash. Otherwise QEMU will jump to DRAM",
                                     NULL);
 }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1c0cb63a6f..e5bcd0baf8 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3078,7 +3078,7 @@ static const TypeInfo scsi_cd_info = {
 
 #ifdef __linux__
 static Property scsi_block_properties[] = {
-    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
+    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index de63ffb037..70531ad360 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1130,7 +1130,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
         /* Limit block size to the maximum buffer size */
         if (extract32(s->blksize, 0, 12) > s->buf_maxsz) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than " \
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than "
                           "the maximum buffer 0x%x", __func__, s->blksize,
                           s->buf_maxsz);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f3b1..9c256ab159 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5784,9 +5784,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             host_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) | \
+        *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
-        *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
+        *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
         *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
         *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
@@ -5797,13 +5797,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             host_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) | \
-               (L2_DTLB_2M_ENTRIES << 16) | \
-               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) | \
+        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+               (L2_DTLB_2M_ENTRIES << 16) |
+               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
-        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) | \
-               (L2_DTLB_4K_ENTRIES << 16) | \
-               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
+        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+               (L2_DTLB_4K_ENTRIES << 16) |
+               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
@@ -6326,7 +6326,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
              */
             env->features[w] |=
                 x86_cpu_get_supported_feature_word(w, cpu->migratable) &
-                ~env->user_features[w] & \
+                ~env->user_features[w] &
                 ~feature_word_info[w].no_autoenable_flags;
         }
     }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a2c2f271df..c9cf2364ca 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -163,14 +163,14 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
 
-    env->pvr.regs[0] = PVR0_USE_EXC_MASK \
-                       | PVR0_USE_ICACHE_MASK \
+    env->pvr.regs[0] = PVR0_USE_EXC_MASK
+                       | PVR0_USE_ICACHE_MASK
                        | PVR0_USE_DCACHE_MASK;
-    env->pvr.regs[2] = PVR2_D_OPB_MASK \
-                        | PVR2_D_LMB_MASK \
-                        | PVR2_I_OPB_MASK \
-                        | PVR2_I_LMB_MASK \
-                        | PVR2_FPU_EXC_MASK \
+    env->pvr.regs[2] = PVR2_D_OPB_MASK
+                        | PVR2_D_LMB_MASK
+                        | PVR2_I_OPB_MASK
+                        | PVR2_I_LMB_MASK
+                        | PVR2_FPU_EXC_MASK
                         | 0;
 
     version = cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSION;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index e853164a86..fd763e588e 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -5210,7 +5210,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
                        PPC_FLOAT_STFIWX | PPC_WAIT |
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD;
-    pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 | \
+    pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
                         PPC2_FP_CVT_S64;
     pcc->msr_mask = (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
@@ -5258,7 +5258,7 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, void *data)
                        PPC_FLOAT_STFIWX | PPC_WAIT |
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVEC;
-    pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 | \
+    pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
                         PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
     pcc->msr_mask = (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
-- 
2.21.1


