Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841A8C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410ED206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQPrT58I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410ED206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThB0-00077C-Cg
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh22-0007u4-PT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003yY-Pm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1h-0003uj-J3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/q+oXi50GMupSm+7rXcjLmCi9r2gW1+YWdw23q5lev8=;
 b=JQPrT58I8/n8dWvUAYlUxTcGEsOzgX/q3YTCO18uEy5SdzlKx9LaJJLR5uIUCl++SjQrIL
 Gzu0Bp8fabBaMcw/IVhoLJBYYVfnUvsXNiwqQlclDaV1CIVUFWA7EQZUOnwMWFWKxAUdnD
 V3jA7vq87eJEGaQ+4YLIf82nPu3etqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-iGq9NqIBOYK9QgIkksfa-w-1; Wed, 29 Apr 2020 03:20:54 -0400
X-MC-Unique: iGq9NqIBOYK9QgIkksfa-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BFAE8014D9;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B7A260BF4;
 Wed, 29 Apr 2020 07:20:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C33DA11358BD; Wed, 29 Apr 2020 09:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] various: Remove suspicious '\' character outside of
 #define in C code
Date: Wed, 29 Apr 2020 09:20:17 +0200
Message-Id: <20200429072048.29963-2-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Fixes the following coccinelle warnings:

  $ spatch --sp-file --verbose-parsing  ... \
      scripts/coccinelle/remove_local_err.cocci
  ...
  SUSPICIOUS: a \ character appears outside of a #define at ./target/ppc/tr=
anslate_init.inc.c:5213
  SUSPICIOUS: a \ character appears outside of a #define at ./target/ppc/tr=
anslate_init.inc.c:5261
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:166
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:167
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:169
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:170
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:171
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:172
  SUSPICIOUS: a \ character appears outside of a #define at ./target/microb=
laze/cpu.c:173
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5787
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5789
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5800
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5801
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5802
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5804
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5805
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:5806
  SUSPICIOUS: a \ character appears outside of a #define at ./target/i386/c=
pu.c:6329
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/sd/sdhci.c=
:1133
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/scsi/scsi-=
disk.c:3081
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/net/virtio=
-net.c:1529
  SUSPICIOUS: a \ character appears outside of a #define at ./hw/riscv/sifi=
ve_u.c:468
  SUSPICIOUS: a \ character appears outside of a #define at ./dump/dump.c:1=
895
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:=
2209
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:=
2215
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:=
2221
  SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.c:=
2222
  SUSPICIOUS: a \ character appears outside of a #define at ./block/replica=
tion.c:172
  SUSPICIOUS: a \ character appears outside of a #define at ./block/replica=
tion.c:173

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200412223619.11284-2-f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
index da013c2041..971f0fe266 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -172,8 +172,8 @@ static void replication_child_perm(BlockDriverState *bs=
, BdrvChild *c,
     if ((bs->open_flags & (BDRV_O_INACTIVE | BDRV_O_RDWR)) =3D=3D BDRV_O_R=
DWR) {
         *nperm |=3D BLK_PERM_WRITE;
     }
-    *nshared =3D BLK_PERM_CONSISTENT_READ \
-               | BLK_PERM_WRITE \
+    *nshared =3D BLK_PERM_CONSISTENT_READ
+               | BLK_PERM_WRITE
                | BLK_PERM_WRITE_UNCHANGED;
     return;
 }
diff --git a/block/vhdx.c b/block/vhdx.c
index 33e57cd656..e16fdc2f2d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2206,20 +2206,20 @@ static QemuOptsList vhdx_create_opts =3D {
            .name =3D VHDX_BLOCK_OPT_BLOCK_SIZE,
            .type =3D QEMU_OPT_SIZE,
            .def_value_str =3D stringify(0),
-           .help =3D "Block Size; min 1MB, max 256MB. " \
+           .help =3D "Block Size; min 1MB, max 256MB. "
                    "0 means auto-calculate based on image size."
        },
        {
            .name =3D BLOCK_OPT_SUBFMT,
            .type =3D QEMU_OPT_STRING,
-           .help =3D "VHDX format type, can be either 'dynamic' or 'fixed'=
. "\
+           .help =3D "VHDX format type, can be either 'dynamic' or 'fixed'=
. "
                    "Default is 'dynamic'."
        },
        {
            .name =3D VHDX_BLOCK_OPT_ZERO,
            .type =3D QEMU_OPT_BOOL,
-           .help =3D "Force use of payload blocks of type 'ZERO'. "\
-                   "Non-standard, but default.  Do not set to 'off' when "=
\
+           .help =3D "Force use of payload blocks of type 'ZERO'. "
+                   "Non-standard, but default.  Do not set to 'off' when "
                    "using 'qemu-img convert' with subformat=3Ddynamic."
        },
        { NULL }
diff --git a/dump/dump.c b/dump/dump.c
index 22ed1d3b0d..248ea06370 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1892,7 +1892,7 @@ static void dump_process(DumpState *s, Error **errp)
     result =3D qmp_query_dump(NULL);
     /* should never fail */
     assert(result);
-    qapi_event_send_dump_completed(result, !!local_err, (local_err ? \
+    qapi_event_send_dump_completed(result, !!local_err, (local_err ?
                                    error_get_pretty(local_err) : NULL));
     qapi_free_DumpQueryResult(result);
=20
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a46e3b37a7..eddfa7f923 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1526,7 +1526,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetRsc=
Chain *chain,
                                  + sizeof(struct eth_header));
     unit->ip =3D ip6;
     unit->ip_plen =3D &(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
-    unit->tcp =3D (struct tcp_header *)(((uint8_t *)unit->ip)\
+    unit->tcp =3D (struct tcp_header *)(((uint8_t *)unit->ip)
                                         + sizeof(struct ip6_header));
     unit->tcp_hdrlen =3D (htons(unit->tcp->th_offset_flags) & 0xF000) >> 1=
0;
=20
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 56351c4faa..998666c91f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -465,7 +465,7 @@ static void riscv_sifive_u_machine_instance_init(Object=
 *obj)
     object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_=
flash,
                              sifive_u_set_start_in_flash, NULL);
     object_property_set_description(obj, "start-in-flash",
-                                    "Set on to tell QEMU's ROM to jump to =
" \
+                                    "Set on to tell QEMU's ROM to jump to =
"
                                     "flash. Otherwise QEMU will jump to DR=
AM",
                                     NULL);
 }
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1c0cb63a6f..e5bcd0baf8 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3078,7 +3078,7 @@ static const TypeInfo scsi_cd_info =3D {
=20
 #ifdef __linux__
 static Property scsi_block_properties[] =3D {
-    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
+    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false)=
,
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index de63ffb037..70531ad360 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1130,7 +1130,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val=
, unsigned size)
=20
         /* Limit block size to the maximum buffer size */
         if (extract32(s->blksize, 0, 12) > s->buf_maxsz) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than "=
 \
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than "
                           "the maximum buffer 0x%x", __func__, s->blksize,
                           s->buf_maxsz);
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f3b1..9c256ab159 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5784,9 +5784,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
             host_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax =3D (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) | \
+        *eax =3D (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
-        *ebx =3D (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
+        *ebx =3D (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
         *ecx =3D encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache)=
;
         *edx =3D encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache)=
;
@@ -5797,13 +5797,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
             host_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax =3D (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) | \
-               (L2_DTLB_2M_ENTRIES << 16) | \
-               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) | \
+        *eax =3D (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+               (L2_DTLB_2M_ENTRIES << 16) |
+               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
-        *ebx =3D (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) | \
-               (L2_DTLB_4K_ENTRIES << 16) | \
-               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
+        *ebx =3D (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+               (L2_DTLB_4K_ENTRIES << 16) |
+               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
@@ -6326,7 +6326,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Erro=
r **errp)
              */
             env->features[w] |=3D
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
@@ -163,14 +163,14 @@ static void mb_cpu_realizefn(DeviceState *dev, Error =
**errp)
=20
     qemu_init_vcpu(cs);
=20
-    env->pvr.regs[0] =3D PVR0_USE_EXC_MASK \
-                       | PVR0_USE_ICACHE_MASK \
+    env->pvr.regs[0] =3D PVR0_USE_EXC_MASK
+                       | PVR0_USE_ICACHE_MASK
                        | PVR0_USE_DCACHE_MASK;
-    env->pvr.regs[2] =3D PVR2_D_OPB_MASK \
-                        | PVR2_D_LMB_MASK \
-                        | PVR2_I_OPB_MASK \
-                        | PVR2_I_LMB_MASK \
-                        | PVR2_FPU_EXC_MASK \
+    env->pvr.regs[2] =3D PVR2_D_OPB_MASK
+                        | PVR2_D_LMB_MASK
+                        | PVR2_I_OPB_MASK
+                        | PVR2_I_LMB_MASK
+                        | PVR2_FPU_EXC_MASK
                         | 0;
=20
     version =3D cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSION;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.in=
c.c
index e853164a86..fd763e588e 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -5210,7 +5210,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
                        PPC_FLOAT_STFIWX | PPC_WAIT |
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD;
-    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |=
 \
+    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
                         PPC2_FP_CVT_S64;
     pcc->msr_mask =3D (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
@@ -5258,7 +5258,7 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, void *data)
                        PPC_FLOAT_STFIWX | PPC_WAIT |
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVEC;
-    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |=
 \
+    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
                         PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
     pcc->msr_mask =3D (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
--=20
2.21.1


