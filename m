Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1EAC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619BA205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619BA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQPH-0001uT-M2
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfQGa-000323-81
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfQGN-0006QW-SO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfQGG-00064B-Cr; Mon, 24 Jun 2019 10:48:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 944BF301EA93;
 Mon, 24 Jun 2019 14:47:58 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99BBF600D1;
 Mon, 24 Jun 2019 14:47:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 16:47:38 +0200
Message-Id: <20190624144740.5338-7-mreitz@redhat.com>
In-Reply-To: <20190624144740.5338-1-mreitz@redhat.com>
References: <20190624144740.5338-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 24 Jun 2019 14:47:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 6/8] vmdk: Add read-only support for seSparse
 snapshots
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Until ESXi 6.5 VMware used the vmfsSparse format for snapshots (VMDK3 in
QEMU).

This format was lacking in the following:

    * Grain directory (L1) and grain table (L2) entries were 32-bit,
      allowing access to only 2TB (slightly less) of data.
    * The grain size (default) was 512 bytes - leading to data
      fragmentation and many grain tables.
    * For space reclamation purposes, it was necessary to find all the
      grains which are not pointed to by any grain table - so a reverse
      mapping of "offset of grain in vmdk" to "grain table" must be
      constructed - which takes large amounts of CPU/RAM.

The format specification can be found in VMware's documentation:
https://www.vmware.com/support/developer/vddk/vmdk_50_technote.pdf

In ESXi 6.5, to support snapshot files larger than 2TB, a new format was
introduced: SESparse (Space Efficient).

This format fixes the above issues:

    * All entries are now 64-bit.
    * The grain size (default) is 4KB.
    * Grain directory and grain tables are now located at the beginning
      of the file.
      + seSparse format reserves space for all grain tables.
      + Grain tables can be addressed using an index.
      + Grains are located in the end of the file and can also be
        addressed with an index.
      - seSparse vmdks of large disks (64TB) have huge preallocated
        headers - mainly due to L2 tables, even for empty snapshots.
    * The header contains a reverse mapping ("backmap") of "offset of
      grain in vmdk" to "grain table" and a bitmap ("free bitmap") which
      specifies for each grain - whether it is allocated or not.
      Using these data structures we can implement space reclamation
      efficiently.
    * Due to the fact that the header now maintains two mappings:
        * The regular one (grain directory & grain tables)
        * A reverse one (backmap and free bitmap)
      These data structures can lose consistency upon crash and result
      in a corrupted VMDK.
      Therefore, a journal is also added to the VMDK and is replayed
      when the VMware reopens the file after a crash.

Since ESXi 6.7 - SESparse is the only snapshot format available.

Unfortunately, VMware does not provide documentation regarding the new
seSparse format.

This commit is based on black-box research of the seSparse format.
Various in-guest block operations and their effect on the snapshot file
were tested.

The only VMware provided source of information (regarding the underlying
implementation) was a log file on the ESXi:

    /var/log/hostd.log

Whenever an seSparse snapshot is created - the log is being populated
with seSparse records.

Relevant log records are of the form:

[...] Const Header:
[...]  constMagic     =3D 0xcafebabe
[...]  version        =3D 2.1
[...]  capacity       =3D 204800
[...]  grainSize      =3D 8
[...]  grainTableSize =3D 64
[...]  flags          =3D 0
[...] Extents:
[...]  Header         : <1 : 1>
[...]  JournalHdr     : <2 : 2>
[...]  Journal        : <2048 : 2048>
[...]  GrainDirectory : <4096 : 2048>
[...]  GrainTables    : <6144 : 2048>
[...]  FreeBitmap     : <8192 : 2048>
[...]  BackMap        : <10240 : 2048>
[...]  Grain          : <12288 : 204800>
[...] Volatile Header:
[...] volatileMagic     =3D 0xcafecafe
[...] FreeGTNumber      =3D 0
[...] nextTxnSeqNumber  =3D 0
[...] replayJournal     =3D 0

The sizes that are seen in the log file are in sectors.
Extents are of the following format: <offset : size>

This commit is a strict implementation which enforces:
    * magics
    * version number 2.1
    * grain size of 8 sectors  (4KB)
    * grain table size of 64 sectors
    * zero flags
    * extent locations

Additionally, this commit proivdes only a subset of the functionality
offered by seSparse's format:
    * Read-only
    * No journal replay
    * No space reclamation
    * No unmap support

Hence, journal header, journal, free bitmap and backmap extents are
unused, only the "classic" (L1 -> L2 -> data) grain access is
implemented.

However there are several differences in the grain access itself.
Grain directory (L1):
    * Grain directory entries are indexes (not offsets) to grain
      tables.
    * Valid grain directory entries have their highest nibble set to
      0x1.
    * Since grain tables are always located in the beginning of the
      file - the index can fit into 32 bits - so we can use its low
      part if it's valid.
Grain table (L2):
    * Grain table entries are indexes (not offsets) to grains.
    * If the highest nibble of the entry is:
        0x0:
            The grain in not allocated.
            The rest of the bytes are 0.
        0x1:
            The grain is unmapped - guest sees a zero grain.
            The rest of the bits point to the previously mapped grain,
            see 0x3 case.
        0x2:
            The grain is zero.
        0x3:
            The grain is allocated - to get the index calculate:
            ((entry & 0x0fff000000000000) >> 48) |
            ((entry & 0x0000ffffffffffff) << 12)
    * The difference between 0x1 and 0x2 is that 0x1 is an unallocated
      grain which results from the guest using sg_unmap to unmap the
      grain - but the grain itself still exists in the grain extent - a
      space reclamation procedure should delete it.
      Unmapping a zero grain has no effect (0x2 will not change to 0x1)
      but unmapping an unallocated grain will (0x0 to 0x1) - naturally.

In order to implement seSparse some fields had to be changed to support
both 32-bit and 64-bit entry sizes.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190620091057.47441-4-shmuel.eiderman@oracle.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 358 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 342 insertions(+), 16 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 931eb2759c..bd36ece125 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -91,6 +91,44 @@ typedef struct {
     uint16_t compressAlgorithm;
 } QEMU_PACKED VMDK4Header;
=20
+typedef struct VMDKSESparseConstHeader {
+    uint64_t magic;
+    uint64_t version;
+    uint64_t capacity;
+    uint64_t grain_size;
+    uint64_t grain_table_size;
+    uint64_t flags;
+    uint64_t reserved1;
+    uint64_t reserved2;
+    uint64_t reserved3;
+    uint64_t reserved4;
+    uint64_t volatile_header_offset;
+    uint64_t volatile_header_size;
+    uint64_t journal_header_offset;
+    uint64_t journal_header_size;
+    uint64_t journal_offset;
+    uint64_t journal_size;
+    uint64_t grain_dir_offset;
+    uint64_t grain_dir_size;
+    uint64_t grain_tables_offset;
+    uint64_t grain_tables_size;
+    uint64_t free_bitmap_offset;
+    uint64_t free_bitmap_size;
+    uint64_t backmap_offset;
+    uint64_t backmap_size;
+    uint64_t grains_offset;
+    uint64_t grains_size;
+    uint8_t pad[304];
+} QEMU_PACKED VMDKSESparseConstHeader;
+
+typedef struct VMDKSESparseVolatileHeader {
+    uint64_t magic;
+    uint64_t free_gt_number;
+    uint64_t next_txn_seq_number;
+    uint64_t replay_journal;
+    uint8_t pad[480];
+} QEMU_PACKED VMDKSESparseVolatileHeader;
+
 #define L2_CACHE_SIZE 16
=20
 typedef struct VmdkExtent {
@@ -99,19 +137,23 @@ typedef struct VmdkExtent {
     bool compressed;
     bool has_marker;
     bool has_zero_grain;
+    bool sesparse;
+    uint64_t sesparse_l2_tables_offset;
+    uint64_t sesparse_clusters_offset;
+    int32_t entry_size;
     int version;
     int64_t sectors;
     int64_t end_sector;
     int64_t flat_start_offset;
     int64_t l1_table_offset;
     int64_t l1_backup_table_offset;
-    uint32_t *l1_table;
+    void *l1_table;
     uint32_t *l1_backup_table;
     unsigned int l1_size;
     uint32_t l1_entry_sectors;
=20
     unsigned int l2_size;
-    uint32_t *l2_cache;
+    void *l2_cache;
     uint32_t l2_cache_offsets[L2_CACHE_SIZE];
     uint32_t l2_cache_counts[L2_CACHE_SIZE];
=20
@@ -435,6 +477,11 @@ static int vmdk_add_extent(BlockDriverState *bs,
          *            minimal L2 table size: 512 entries
          *            8 TB is still more than the maximal value supporte=
d for
          *            VMDK3 & VMDK4 which is 2TB.
+         *     64TB - for "ESXi seSparse Extent"
+         *            minimal cluster size: 512B (default is 4KB)
+         *            L2 table size: 4096 entries (const).
+         *            64TB is more than the maximal value supported for
+         *            seSparse VMDKs (which is slightly less than 64TB)
          */
         error_setg(errp, "L1 size too big");
         return -EFBIG;
@@ -460,6 +507,7 @@ static int vmdk_add_extent(BlockDriverState *bs,
     extent->l2_size =3D l2_size;
     extent->cluster_sectors =3D flat ? sectors : cluster_sectors;
     extent->next_cluster_sector =3D ROUND_UP(nb_sectors, cluster_sectors=
);
+    extent->entry_size =3D sizeof(uint32_t);
=20
     if (s->num_extents > 1) {
         extent->end_sector =3D (*(extent - 1)).end_sector + extent->sect=
ors;
@@ -481,7 +529,7 @@ static int vmdk_init_tables(BlockDriverState *bs, Vmd=
kExtent *extent,
     int i;
=20
     /* read the L1 table */
-    l1_size =3D extent->l1_size * sizeof(uint32_t);
+    l1_size =3D extent->l1_size * extent->entry_size;
     extent->l1_table =3D g_try_malloc(l1_size);
     if (l1_size && extent->l1_table =3D=3D NULL) {
         return -ENOMEM;
@@ -499,10 +547,16 @@ static int vmdk_init_tables(BlockDriverState *bs, V=
mdkExtent *extent,
         goto fail_l1;
     }
     for (i =3D 0; i < extent->l1_size; i++) {
-        le32_to_cpus(&extent->l1_table[i]);
+        if (extent->entry_size =3D=3D sizeof(uint64_t)) {
+            le64_to_cpus((uint64_t *)extent->l1_table + i);
+        } else {
+            assert(extent->entry_size =3D=3D sizeof(uint32_t));
+            le32_to_cpus((uint32_t *)extent->l1_table + i);
+        }
     }
=20
     if (extent->l1_backup_table_offset) {
+        assert(!extent->sesparse);
         extent->l1_backup_table =3D g_try_malloc(l1_size);
         if (l1_size && extent->l1_backup_table =3D=3D NULL) {
             ret =3D -ENOMEM;
@@ -525,7 +579,7 @@ static int vmdk_init_tables(BlockDriverState *bs, Vmd=
kExtent *extent,
     }
=20
     extent->l2_cache =3D
-        g_new(uint32_t, extent->l2_size * L2_CACHE_SIZE);
+        g_malloc(extent->entry_size * extent->l2_size * L2_CACHE_SIZE);
     return 0;
  fail_l1b:
     g_free(extent->l1_backup_table);
@@ -571,6 +625,205 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *=
bs,
     return ret;
 }
=20
+#define SESPARSE_CONST_HEADER_MAGIC UINT64_C(0x00000000cafebabe)
+#define SESPARSE_VOLATILE_HEADER_MAGIC UINT64_C(0x00000000cafecafe)
+
+/* Strict checks - format not officially documented */
+static int check_se_sparse_const_header(VMDKSESparseConstHeader *header,
+                                        Error **errp)
+{
+    header->magic =3D le64_to_cpu(header->magic);
+    header->version =3D le64_to_cpu(header->version);
+    header->grain_size =3D le64_to_cpu(header->grain_size);
+    header->grain_table_size =3D le64_to_cpu(header->grain_table_size);
+    header->flags =3D le64_to_cpu(header->flags);
+    header->reserved1 =3D le64_to_cpu(header->reserved1);
+    header->reserved2 =3D le64_to_cpu(header->reserved2);
+    header->reserved3 =3D le64_to_cpu(header->reserved3);
+    header->reserved4 =3D le64_to_cpu(header->reserved4);
+
+    header->volatile_header_offset =3D
+        le64_to_cpu(header->volatile_header_offset);
+    header->volatile_header_size =3D le64_to_cpu(header->volatile_header=
_size);
+
+    header->journal_header_offset =3D le64_to_cpu(header->journal_header=
_offset);
+    header->journal_header_size =3D le64_to_cpu(header->journal_header_s=
ize);
+
+    header->journal_offset =3D le64_to_cpu(header->journal_offset);
+    header->journal_size =3D le64_to_cpu(header->journal_size);
+
+    header->grain_dir_offset =3D le64_to_cpu(header->grain_dir_offset);
+    header->grain_dir_size =3D le64_to_cpu(header->grain_dir_size);
+
+    header->grain_tables_offset =3D le64_to_cpu(header->grain_tables_off=
set);
+    header->grain_tables_size =3D le64_to_cpu(header->grain_tables_size)=
;
+
+    header->free_bitmap_offset =3D le64_to_cpu(header->free_bitmap_offse=
t);
+    header->free_bitmap_size =3D le64_to_cpu(header->free_bitmap_size);
+
+    header->backmap_offset =3D le64_to_cpu(header->backmap_offset);
+    header->backmap_size =3D le64_to_cpu(header->backmap_size);
+
+    header->grains_offset =3D le64_to_cpu(header->grains_offset);
+    header->grains_size =3D le64_to_cpu(header->grains_size);
+
+    if (header->magic !=3D SESPARSE_CONST_HEADER_MAGIC) {
+        error_setg(errp, "Bad const header magic: 0x%016" PRIx64,
+                   header->magic);
+        return -EINVAL;
+    }
+
+    if (header->version !=3D 0x0000000200000001) {
+        error_setg(errp, "Unsupported version: 0x%016" PRIx64,
+                   header->version);
+        return -ENOTSUP;
+    }
+
+    if (header->grain_size !=3D 8) {
+        error_setg(errp, "Unsupported grain size: %" PRIu64,
+                   header->grain_size);
+        return -ENOTSUP;
+    }
+
+    if (header->grain_table_size !=3D 64) {
+        error_setg(errp, "Unsupported grain table size: %" PRIu64,
+                   header->grain_table_size);
+        return -ENOTSUP;
+    }
+
+    if (header->flags !=3D 0) {
+        error_setg(errp, "Unsupported flags: 0x%016" PRIx64,
+                   header->flags);
+        return -ENOTSUP;
+    }
+
+    if (header->reserved1 !=3D 0 || header->reserved2 !=3D 0 ||
+        header->reserved3 !=3D 0 || header->reserved4 !=3D 0) {
+        error_setg(errp, "Unsupported reserved bits:"
+                   " 0x%016" PRIx64 " 0x%016" PRIx64
+                   " 0x%016" PRIx64 " 0x%016" PRIx64,
+                   header->reserved1, header->reserved2,
+                   header->reserved3, header->reserved4);
+        return -ENOTSUP;
+    }
+
+    /* check that padding is 0 */
+    if (!buffer_is_zero(header->pad, sizeof(header->pad))) {
+        error_setg(errp, "Unsupported non-zero const header padding");
+        return -ENOTSUP;
+    }
+
+    return 0;
+}
+
+static int check_se_sparse_volatile_header(VMDKSESparseVolatileHeader *h=
eader,
+                                           Error **errp)
+{
+    header->magic =3D le64_to_cpu(header->magic);
+    header->free_gt_number =3D le64_to_cpu(header->free_gt_number);
+    header->next_txn_seq_number =3D le64_to_cpu(header->next_txn_seq_num=
ber);
+    header->replay_journal =3D le64_to_cpu(header->replay_journal);
+
+    if (header->magic !=3D SESPARSE_VOLATILE_HEADER_MAGIC) {
+        error_setg(errp, "Bad volatile header magic: 0x%016" PRIx64,
+                   header->magic);
+        return -EINVAL;
+    }
+
+    if (header->replay_journal) {
+        error_setg(errp, "Image is dirty, Replaying journal not supporte=
d");
+        return -ENOTSUP;
+    }
+
+    /* check that padding is 0 */
+    if (!buffer_is_zero(header->pad, sizeof(header->pad))) {
+        error_setg(errp, "Unsupported non-zero volatile header padding")=
;
+        return -ENOTSUP;
+    }
+
+    return 0;
+}
+
+static int vmdk_open_se_sparse(BlockDriverState *bs,
+                               BdrvChild *file,
+                               int flags, Error **errp)
+{
+    int ret;
+    VMDKSESparseConstHeader const_header;
+    VMDKSESparseVolatileHeader volatile_header;
+    VmdkExtent *extent;
+
+    ret =3D bdrv_apply_auto_read_only(bs,
+            "No write support for seSparse images available", errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    assert(sizeof(const_header) =3D=3D SECTOR_SIZE);
+
+    ret =3D bdrv_pread(file, 0, &const_header, sizeof(const_header));
+    if (ret < 0) {
+        bdrv_refresh_filename(file->bs);
+        error_setg_errno(errp, -ret,
+                         "Could not read const header from file '%s'",
+                         file->bs->filename);
+        return ret;
+    }
+
+    /* check const header */
+    ret =3D check_se_sparse_const_header(&const_header, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    assert(sizeof(volatile_header) =3D=3D SECTOR_SIZE);
+
+    ret =3D bdrv_pread(file,
+                     const_header.volatile_header_offset * SECTOR_SIZE,
+                     &volatile_header, sizeof(volatile_header));
+    if (ret < 0) {
+        bdrv_refresh_filename(file->bs);
+        error_setg_errno(errp, -ret,
+                         "Could not read volatile header from file '%s'"=
,
+                         file->bs->filename);
+        return ret;
+    }
+
+    /* check volatile header */
+    ret =3D check_se_sparse_volatile_header(&volatile_header, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D vmdk_add_extent(bs, file, false,
+                          const_header.capacity,
+                          const_header.grain_dir_offset * SECTOR_SIZE,
+                          0,
+                          const_header.grain_dir_size *
+                          SECTOR_SIZE / sizeof(uint64_t),
+                          const_header.grain_table_size *
+                          SECTOR_SIZE / sizeof(uint64_t),
+                          const_header.grain_size,
+                          &extent,
+                          errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    extent->sesparse =3D true;
+    extent->sesparse_l2_tables_offset =3D const_header.grain_tables_offs=
et;
+    extent->sesparse_clusters_offset =3D const_header.grains_offset;
+    extent->entry_size =3D sizeof(uint64_t);
+
+    ret =3D vmdk_init_tables(bs, extent, errp);
+    if (ret) {
+        /* free extent allocated by vmdk_add_extent */
+        vmdk_free_last_extent(bs);
+    }
+
+    return ret;
+}
+
 static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *bu=
f,
                                QDict *options, Error **errp);
=20
@@ -848,6 +1101,7 @@ static int vmdk_parse_extents(const char *desc, Bloc=
kDriverState *bs,
          * RW [size in sectors] SPARSE "file-name.vmdk"
          * RW [size in sectors] VMFS "file-name.vmdk"
          * RW [size in sectors] VMFSSPARSE "file-name.vmdk"
+         * RW [size in sectors] SESPARSE "file-name.vmdk"
          */
         flat_offset =3D -1;
         matches =3D sscanf(p, "%10s %" SCNd64 " %10s \"%511[^\n\r\"]\" %=
" SCNd64,
@@ -870,7 +1124,8 @@ static int vmdk_parse_extents(const char *desc, Bloc=
kDriverState *bs,
=20
         if (sectors <=3D 0 ||
             (strcmp(type, "FLAT") && strcmp(type, "SPARSE") &&
-             strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE")) ||
+             strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE") &&
+             strcmp(type, "SESPARSE")) ||
             (strcmp(access, "RW"))) {
             continue;
         }
@@ -923,6 +1178,13 @@ static int vmdk_parse_extents(const char *desc, Blo=
ckDriverState *bs,
                 return ret;
             }
             extent =3D &s->extents[s->num_extents - 1];
+        } else if (!strcmp(type, "SESPARSE")) {
+            ret =3D vmdk_open_se_sparse(bs, extent_file, bs->open_flags,=
 errp);
+            if (ret) {
+                bdrv_unref_child(bs, extent_file);
+                return ret;
+            }
+            extent =3D &s->extents[s->num_extents - 1];
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
             bdrv_unref_child(bs, extent_file);
@@ -957,6 +1219,7 @@ static int vmdk_open_desc_file(BlockDriverState *bs,=
 int flags, char *buf,
     if (strcmp(ct, "monolithicFlat") &&
         strcmp(ct, "vmfs") &&
         strcmp(ct, "vmfsSparse") &&
+        strcmp(ct, "seSparse") &&
         strcmp(ct, "twoGbMaxExtentSparse") &&
         strcmp(ct, "twoGbMaxExtentFlat")) {
         error_setg(errp, "Unsupported image type '%s'", ct);
@@ -1207,10 +1470,12 @@ static int get_cluster_offset(BlockDriverState *b=
s,
 {
     unsigned int l1_index, l2_offset, l2_index;
     int min_index, i, j;
-    uint32_t min_count, *l2_table;
+    uint32_t min_count;
+    void *l2_table;
     bool zeroed =3D false;
     int64_t ret;
     int64_t cluster_sector;
+    unsigned int l2_size_bytes =3D extent->l2_size * extent->entry_size;
=20
     if (m_data) {
         m_data->valid =3D 0;
@@ -1225,7 +1490,36 @@ static int get_cluster_offset(BlockDriverState *bs=
,
     if (l1_index >=3D extent->l1_size) {
         return VMDK_ERROR;
     }
-    l2_offset =3D extent->l1_table[l1_index];
+    if (extent->sesparse) {
+        uint64_t l2_offset_u64;
+
+        assert(extent->entry_size =3D=3D sizeof(uint64_t));
+
+        l2_offset_u64 =3D ((uint64_t *)extent->l1_table)[l1_index];
+        if (l2_offset_u64 =3D=3D 0) {
+            l2_offset =3D 0;
+        } else if ((l2_offset_u64 & 0xffffffff00000000) !=3D 0x100000000=
0000000) {
+            /*
+             * Top most nibble is 0x1 if grain table is allocated.
+             * strict check - top most 4 bytes must be 0x10000000 since =
max
+             * supported size is 64TB for disk - so no more than 64TB / =
16MB
+             * grain directories which is smaller than uint32,
+             * where 16MB is the only supported default grain table cove=
rage.
+             */
+            return VMDK_ERROR;
+        } else {
+            l2_offset_u64 =3D l2_offset_u64 & 0x00000000ffffffff;
+            l2_offset_u64 =3D extent->sesparse_l2_tables_offset +
+                l2_offset_u64 * l2_size_bytes / SECTOR_SIZE;
+            if (l2_offset_u64 > 0x00000000ffffffff) {
+                return VMDK_ERROR;
+            }
+            l2_offset =3D (unsigned int)(l2_offset_u64);
+        }
+    } else {
+        assert(extent->entry_size =3D=3D sizeof(uint32_t));
+        l2_offset =3D ((uint32_t *)extent->l1_table)[l1_index];
+    }
     if (!l2_offset) {
         return VMDK_UNALLOC;
     }
@@ -1237,7 +1531,7 @@ static int get_cluster_offset(BlockDriverState *bs,
                     extent->l2_cache_counts[j] >>=3D 1;
                 }
             }
-            l2_table =3D extent->l2_cache + (i * extent->l2_size);
+            l2_table =3D (char *)extent->l2_cache + (i * l2_size_bytes);
             goto found;
         }
     }
@@ -1250,13 +1544,13 @@ static int get_cluster_offset(BlockDriverState *b=
s,
             min_index =3D i;
         }
     }
-    l2_table =3D extent->l2_cache + (min_index * extent->l2_size);
+    l2_table =3D (char *)extent->l2_cache + (min_index * l2_size_bytes);
     BLKDBG_EVENT(extent->file, BLKDBG_L2_LOAD);
     if (bdrv_pread(extent->file,
                 (int64_t)l2_offset * 512,
                 l2_table,
-                extent->l2_size * sizeof(uint32_t)
-            ) !=3D extent->l2_size * sizeof(uint32_t)) {
+                l2_size_bytes
+            ) !=3D l2_size_bytes) {
         return VMDK_ERROR;
     }
=20
@@ -1264,16 +1558,45 @@ static int get_cluster_offset(BlockDriverState *b=
s,
     extent->l2_cache_counts[min_index] =3D 1;
  found:
     l2_index =3D ((offset >> 9) / extent->cluster_sectors) % extent->l2_=
size;
-    cluster_sector =3D le32_to_cpu(l2_table[l2_index]);
=20
-    if (extent->has_zero_grain && cluster_sector =3D=3D VMDK_GTE_ZEROED)=
 {
-        zeroed =3D true;
+    if (extent->sesparse) {
+        cluster_sector =3D le64_to_cpu(((uint64_t *)l2_table)[l2_index])=
;
+        switch (cluster_sector & 0xf000000000000000) {
+        case 0x0000000000000000:
+            /* unallocated grain */
+            if (cluster_sector !=3D 0) {
+                return VMDK_ERROR;
+            }
+            break;
+        case 0x1000000000000000:
+            /* scsi-unmapped grain - fallthrough */
+        case 0x2000000000000000:
+            /* zero grain */
+            zeroed =3D true;
+            break;
+        case 0x3000000000000000:
+            /* allocated grain */
+            cluster_sector =3D (((cluster_sector & 0x0fff000000000000) >=
> 48) |
+                              ((cluster_sector & 0x0000ffffffffffff) << =
12));
+            cluster_sector =3D extent->sesparse_clusters_offset +
+                cluster_sector * extent->cluster_sectors;
+            break;
+        default:
+            return VMDK_ERROR;
+        }
+    } else {
+        cluster_sector =3D le32_to_cpu(((uint32_t *)l2_table)[l2_index])=
;
+
+        if (extent->has_zero_grain && cluster_sector =3D=3D VMDK_GTE_ZER=
OED) {
+            zeroed =3D true;
+        }
     }
=20
     if (!cluster_sector || zeroed) {
         if (!allocate) {
             return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
         }
+        assert(!extent->sesparse);
=20
         if (extent->next_cluster_sector >=3D VMDK_EXTENT_MAX_SECTORS) {
             return VMDK_ERROR;
@@ -1297,7 +1620,7 @@ static int get_cluster_offset(BlockDriverState *bs,
             m_data->l1_index =3D l1_index;
             m_data->l2_index =3D l2_index;
             m_data->l2_offset =3D l2_offset;
-            m_data->l2_cache_entry =3D &l2_table[l2_index];
+            m_data->l2_cache_entry =3D ((uint32_t *)l2_table) + l2_index=
;
         }
     }
     *cluster_offset =3D cluster_sector << BDRV_SECTOR_BITS;
@@ -1623,6 +1946,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint6=
4_t offset,
         if (!extent) {
             return -EIO;
         }
+        if (extent->sesparse) {
+            return -ENOTSUP;
+        }
         offset_in_cluster =3D vmdk_find_offset_in_cluster(extent, offset=
);
         n_bytes =3D MIN(bytes, extent->cluster_sectors * BDRV_SECTOR_SIZ=
E
                              - offset_in_cluster);
--=20
2.21.0


