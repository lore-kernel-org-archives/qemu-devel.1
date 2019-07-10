Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B59DC74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF56208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MhZZknJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF56208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJFI-0002f4-4c
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7N-0001a3-T3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7L-0002PY-Od
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:09 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7L-0002MZ-C3
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZPFbQ5tk01R05nbv01ZCuCdEDptHDOEFGh8dh0fsjc=;
 b=MhZZknJQU+WD7sCGFMxWpnMPzCNfybv36UO0ljFj0fXUHYg2PBbGlsd+99ThH5Kz8Ht8qrv2h0yaYkz//+IAzCl0uHCJhNqZfIKopAd6pxW9fr28YC4jp21jwrrvx1dlOC0SYtxtlSXluzmmuPMbYubnX6wVYxA27i0qN65Lkjw=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:05 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:05 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 04/13] kvm: add support to sync the page encryption
 state bitmap
Thread-Index: AQHVN11F+Po2QzUWe02pucGkrz+7bA==
Date: Wed, 10 Jul 2019 20:23:01 +0000
Message-ID: <20190710202219.25939-5-brijesh.singh@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:0:54::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af942760-5217-48e9-ad6c-08d7057467b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB382085C3B3A8C29D62446FC7E5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(43544003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(14444005)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(6666004)(4326008)(66476007)(66946007)(30864003)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uTdOn14jHseACF1pEwWxE4Bx3zVIQRxz73uU/7RD+pBGeZou9zpLzVIt3L/HIHQ5bY8eu1xE4EehRCCoM1vHxscEIqbxU02Ree5mAB08bM9iz9oiVPW20ZfW40QmhQ9eKUsUOMSCqR2ZW0IkEN1Ir3pfySmXeB5zxCoiQDfo6I0rWV7h8zm4Vg9EQKcaws6Xe9hGt6RmrycU4bmTDwVoqp71oKtRAmOUKf6iQIMIRhamoqJcEObN5GKSK3zzVquj3z3cX2iNrifICOIVZig/D2oQhYEbgSCwYEiqHOFswleQELCCBUZzLLiSB5R9l693cb+pnfhhPVNjJNbF2iANqWyVA39gMy0twOQ8/8xd43BuJCw2b5bkkCoYqsUj+bw8Hm2otMLLhYr1jnBqw2rdpG9rz6UvtIa8OLqSOTg01bY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af942760-5217-48e9-ad6c-08d7057467b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:01.3164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 04/13] kvm: add support to sync the page
 encryption state bitmap
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SEV VMs have concept of private and shared memory. The private memory
is encrypted with guest-specific key, while shared memory may be encrypted
with hyperivosr key. The KVM_GET_PAGE_ENC_BITMAP can be used to get a
bitmap indicating whether the guest page is private or shared. A private
page must be transmitted using the SEV migration commands.

Add a cpu_physical_memory_sync_encrypted_bitmap() which can be used to sync
the page encryption bitmap for a given memory region.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c     |  38 ++++++++++
 include/exec/ram_addr.h | 161 ++++++++++++++++++++++++++++++++++++++--
 include/exec/ramlist.h  |   3 +-
 migration/ram.c         |  28 ++++++-
 4 files changed, 222 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 162a2d5085..c935e9366c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -504,6 +504,37 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionS=
ection *section,
=20
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
=20
+/* sync page_enc bitmap */
+static int kvm_sync_page_enc_bitmap(KVMMemoryListener *kml,
+                                    MemoryRegionSection *section,
+                                    KVMSlot *mem)
+{
+    unsigned long size;
+    KVMState *s =3D kvm_state;
+    struct kvm_page_enc_bitmap e =3D {};
+    ram_addr_t pages =3D int128_get64(section->size) / getpagesize();
+    ram_addr_t start =3D section->offset_within_region +
+                       memory_region_get_ram_addr(section->mr);
+
+    size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
+                 /*HOST_LONG_BITS*/ 64) / 8;
+    e.enc_bitmap =3D g_malloc0(size);
+    e.start_gfn =3D mem->start_addr >> TARGET_PAGE_BITS;
+    e.num_pages =3D pages;
+    if (kvm_vm_ioctl(s, KVM_GET_PAGE_ENC_BITMAP, &e) =3D=3D -1) {
+        DPRINTF("KVM_GET_PAGE_ENC_BITMAP ioctl failed %d\n", errno);
+        g_free(e.enc_bitmap);
+        return 1;
+    }
+
+    cpu_physical_memory_set_encrypted_lebitmap(e.enc_bitmap,
+                                               start, pages);
+
+    g_free(e.enc_bitmap);
+
+    return 0;
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Grab dirty bitmap from kernel space
  * This function updates qemu's dirty bitmap using
@@ -553,6 +584,13 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLis=
tener *kml,
         }
=20
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
+
+        if (kvm_memcrypt_enabled() &&
+            kvm_sync_page_enc_bitmap(kml, section, mem)) {
+            g_free(d.dirty_bitmap);
+            return -1;
+        }
+
         g_free(d.dirty_bitmap);
     }
=20
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f96777bb99..6fc6864194 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -51,6 +51,8 @@ struct RAMBlock {
     unsigned long *unsentmap;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
+    /* bitmap of page encryption state for an encrypted guest */
+    unsigned long *encbmap;
 };
=20
 static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
@@ -314,9 +316,41 @@ static inline void cpu_physical_memory_set_dirty_range=
(ram_addr_t start,
 }
=20
 #if !defined(_WIN32)
-static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *b=
itmap,
+
+static inline void cpu_physical_memory_set_encrypted_range(ram_addr_t star=
t,
+                                                           ram_addr_t leng=
th,
+                                                           unsigned long v=
al)
+{
+    unsigned long end, page;
+    unsigned long * const *src;
+
+    if (length =3D=3D 0) {
+        return;
+    }
+
+    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page =3D start >> TARGET_PAGE_BITS;
+
+    rcu_read_lock();
+
+    src =3D atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED]=
)->blocks;
+
+    while (page < end) {
+        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long num =3D MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - of=
fset);
+
+        atomic_xchg(&src[idx][BIT_WORD(offset)], val);
+        page +=3D num;
+    }
+
+    rcu_read_unlock();
+}
+
+static inline void cpu_physical_memory_set_dirty_enc_lebitmap(unsigned lon=
g *bitmap,
                                                           ram_addr_t start=
,
-                                                          ram_addr_t pages=
)
+                                                          ram_addr_t pages=
,
+                                                          bool enc_map)
 {
     unsigned long i, j;
     unsigned long page_number, c;
@@ -349,10 +383,14 @@ static inline void cpu_physical_memory_set_dirty_lebi=
tmap(unsigned long *bitmap,
             if (bitmap[k]) {
                 unsigned long temp =3D leul_to_cpu(bitmap[k]);
=20
-                atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset], te=
mp);
-                atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
-                if (tcg_enabled()) {
-                    atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset], tem=
p);
+                if (enc_map) {
+                    atomic_xchg(&blocks[DIRTY_MEMORY_ENCRYPTED][idx][offse=
t], temp);
+                } else {
+                    atomic_or(&blocks[DIRTY_MEMORY_MIGRATION][idx][offset]=
, temp);
+                    atomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp=
);
+                    if (tcg_enabled()) {
+                        atomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],=
 temp);
+                    }
                 }
             }
=20
@@ -372,6 +410,17 @@ static inline void cpu_physical_memory_set_dirty_lebit=
map(unsigned long *bitmap,
          * especially when most of the memory is not dirty.
          */
         for (i =3D 0; i < len; i++) {
+
+            /* If its encrypted bitmap update, then we need to copy the bi=
tmap
+             * value as-is to the destination.
+             */
+            if (enc_map) {
+                cpu_physical_memory_set_encrypted_range(start + i * TARGET=
_PAGE_SIZE,
+                                                        TARGET_PAGE_SIZE *=
 hpratio,
+                                                        leul_to_cpu(bitmap=
[i]));
+                continue;
+            }
+
             if (bitmap[i] !=3D 0) {
                 c =3D leul_to_cpu(bitmap[i]);
                 do {
@@ -387,6 +436,21 @@ static inline void cpu_physical_memory_set_dirty_lebit=
map(unsigned long *bitmap,
         }
     }
 }
+
+static inline void cpu_physical_memory_set_encrypted_lebitmap(unsigned lon=
g *bitmap,
+                                                              ram_addr_t s=
tart,
+                                                              ram_addr_t p=
ages)
+{
+    return cpu_physical_memory_set_dirty_enc_lebitmap(bitmap, start, pages=
, true);
+}
+
+static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *b=
itmap,
+                                                          ram_addr_t start=
,
+                                                          ram_addr_t pages=
)
+{
+    return cpu_physical_memory_set_dirty_enc_lebitmap(bitmap, start, pages=
, false);
+}
+
 #endif /* not _WIN32 */
=20
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
@@ -406,6 +470,7 @@ static inline void cpu_physical_memory_clear_dirty_rang=
e(ram_addr_t start,
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_M=
IGRATION);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_V=
GA);
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_C=
ODE);
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_E=
NCRYPTED);
 }
=20
=20
@@ -474,5 +539,89 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBloc=
k *rb,
=20
     return num_dirty;
 }
+
+static inline bool cpu_physical_memory_test_encrypted(ram_addr_t start,
+                                                      ram_addr_t length)
+{
+    unsigned long end, page;
+    bool enc =3D false;
+    unsigned long * const *src;
+
+    if (length =3D=3D 0) {
+        return enc;
+    }
+
+    end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page =3D start >> TARGET_PAGE_BITS;
+
+    rcu_read_lock();
+
+    src =3D atomic_rcu_read(&ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED]=
)->blocks;
+
+    while (page < end) {
+        unsigned long idx =3D page / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset =3D page % DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long num =3D MIN(end - page, DIRTY_MEMORY_BLOCK_SIZE - of=
fset);
+
+        enc |=3D atomic_read(&src[idx][BIT_WORD(offset)]);
+        page +=3D num;
+    }
+
+    rcu_read_unlock();
+
+    return enc;
+}
+
+static inline
+void cpu_physical_memory_sync_encrypted_bitmap(RAMBlock *rb,
+                                               ram_addr_t start,
+                                               ram_addr_t length)
+{
+    ram_addr_t addr;
+    unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_PAGE_BI=
TS);
+    unsigned long *dest =3D rb->encbmap;
+
+    /* start address and length is aligned at the start of a word? */
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
+         (start + rb->offset) &&
+        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
+        int k;
+        int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
+        unsigned long * const *src;
+        unsigned long idx =3D (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_=
SIZE;
+        unsigned long offset =3D BIT_WORD((word * BITS_PER_LONG) %
+                                        DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
+
+        rcu_read_lock();
+
+        src =3D atomic_rcu_read(
+                &ram_list.dirty_memory[DIRTY_MEMORY_ENCRYPTED])->blocks;
+
+        for (k =3D page; k < page + nr; k++) {
+            unsigned long bits =3D atomic_read(&src[idx][offset]);
+            dest[k] =3D bits;
+
+            if (++offset >=3D BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                offset =3D 0;
+                idx++;
+            }
+        }
+
+        rcu_read_unlock();
+    } else {
+        ram_addr_t offset =3D rb->offset;
+
+        for (addr =3D 0; addr < length; addr +=3D TARGET_PAGE_SIZE) {
+            long k =3D (start + addr) >> TARGET_PAGE_BITS;
+            if (cpu_physical_memory_test_encrypted(start + addr + offset,
+                                                   TARGET_PAGE_SIZE)) {
+                set_bit(k, dest);
+            } else {
+                clear_bit(k, dest);
+            }
+        }
+    }
+}
 #endif
 #endif
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index bc4faa1b00..2a5eab8b11 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -11,7 +11,8 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
 #define DIRTY_MEMORY_VGA       0
 #define DIRTY_MEMORY_CODE      1
 #define DIRTY_MEMORY_MIGRATION 2
-#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
+#define DIRTY_MEMORY_ENCRYPTED 3
+#define DIRTY_MEMORY_NUM       4        /* num of dirty bits */
=20
 /* The dirty memory bitmap is split into fixed-size blocks to allow growth
  * under RCU.  The bitmap for a block can be accessed as follows:
diff --git a/migration/ram.c b/migration/ram.c
index 3c8977d508..d179867e1b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1680,6 +1680,9 @@ static void migration_bitmap_sync_range(RAMState *rs,=
 RAMBlock *rb,
     rs->migration_dirty_pages +=3D
         cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
                                               &rs->num_dirty_pages_period)=
;
+    if (kvm_memcrypt_enabled()) {
+        cpu_physical_memory_sync_encrypted_bitmap(rb, 0, length);
+    }
 }
=20
 /**
@@ -2465,6 +2468,22 @@ static bool save_compress_page(RAMState *rs, RAMBloc=
k *block, ram_addr_t offset)
     return false;
 }
=20
+/**
+ * encrypted_test_bitmap: check if the page is encrypted
+ *
+ * Returns a bool indicating whether the page is encrypted.
+ */
+static bool encrypted_test_bitmap(RAMState *rs, RAMBlock *block,
+                                  unsigned long page)
+{
+    /* ROM devices contains the unencrypted data */
+    if (memory_region_is_rom(block->mr)) {
+        return false;
+    }
+
+    return test_bit(page, block->encbmap);
+}
+
 /**
  * ram_save_target_page: save one target page
  *
@@ -2491,7 +2510,8 @@ static int ram_save_target_page(RAMState *rs, PageSea=
rchStatus *pss,
      * will take care of accessing the guest memory and re-encrypt it
      * for the transport purposes.
      */
-     if (kvm_memcrypt_enabled()) {
+     if (kvm_memcrypt_enabled() &&
+         encrypted_test_bitmap(rs, pss->block, pss->page)) {
         return ram_save_encrypted_page(rs, pss, last_stage);
      }
=20
@@ -2724,6 +2744,8 @@ static void ram_save_cleanup(void *opaque)
         block->bmap =3D NULL;
         g_free(block->unsentmap);
         block->unsentmap =3D NULL;
+        g_free(block->encbmap);
+        block->encbmap =3D NULL;
     }
=20
     xbzrle_cleanup();
@@ -3251,6 +3273,10 @@ static void ram_list_init_bitmaps(void)
                 block->unsentmap =3D bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
             }
+            if (kvm_memcrypt_enabled()) {
+                block->encbmap =3D bitmap_new(pages);
+                bitmap_set(block->encbmap, 0, pages);
+            }
         }
     }
 }
--=20
2.17.1


