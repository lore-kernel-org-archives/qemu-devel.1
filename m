Received: from eggs.gnu.org ([209.51.188.92]:44708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gkoyv-00067l-TQ
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 06:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gkoyt-00018M-8G
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 06:40:09 -0500
Date: Sat, 19 Jan 2019 11:39:41 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190119113941.GZ27120@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<f10654ba-04d3-3212-94ca-e72c511d51c2@virtuozzo.com>
	<38eca33c-cbea-6948-0e05-86a5e0bbeb00@virtuozzo.com>
	<928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EUYUPHVNfBVWjsvu"
Content-Disposition: inline
In-Reply-To: <928553ea-9694-acc6-1c5f-5a09afc2c64c@redhat.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/21] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>


--EUYUPHVNfBVWjsvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Attached is a NON-working patch to nbdkit-partitioning-plugin which
adds logical partition support.  I don't think I've fully understood
how the EBR fields are supposed to be initialized (or else they don't
work how is described in online documentation).  This actually causes
parted to print an internal error, while fdisk gives a warning and the
size of the logical partition is wrong.

Anyway I've run out of time to work on it this weekend, but I may be
able to have another look next week.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

--EUYUPHVNfBVWjsvu
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-partitioning-Support-MBR-logical-partitions.patch"
Content-Transfer-Encoding: quoted-printable

>From 8d6dd4288064e9b880eccb1a6b1b7a6b03f2ba96 Mon Sep 17 00:00:00 2001
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Sat, 19 Jan 2019 10:30:28 +0000
Subject: [PATCH] partitioning: Support MBR logical partitions.

XXX NEEDS TESTS
---
 .../nbdkit-partitioning-plugin.pod            |  25 +---
 plugins/partitioning/virtual-disk.h           |  15 +-
 plugins/partitioning/partition-gpt.c          |   2 +-
 plugins/partitioning/partition-mbr.c          | 134 +++++++++++++++---
 plugins/partitioning/partitioning.c           |  31 ++--
 plugins/partitioning/virtual-disk.c           |  42 +++++-
 6 files changed, 184 insertions(+), 65 deletions(-)

diff --git a/plugins/partitioning/nbdkit-partitioning-plugin.pod b/plugin=
s/partitioning/nbdkit-partitioning-plugin.pod
index 57a1133..edb0776 100644
--- a/plugins/partitioning/nbdkit-partitioning-plugin.pod
+++ b/plugins/partitioning/nbdkit-partitioning-plugin.pod
@@ -27,23 +27,12 @@ access use the I<-r> flag.
=20
 =3Dhead2 Partition table type
=20
-You can choose either an MBR partition table, which is limited to 4
-partitions, or a GPT partition table.  In theory GPT supports an
-unlimited number of partitions.
-
-The rule for selecting the partition table type is:
+Using the C<partition-type> parameter you can choose either an MBR or
+a GPT partition table.  If this parameter is I<not> present then:
=20
 =3Dover 4
=20
-=3Ditem C<partition-type=3Dmbr> parameter on the command line
-
-=E2=87=92 MBR is selected
-
-=3Ditem C<partition-type=3Dgpt> parameter on the command line
-
-=E2=87=92 GPT is selected
-
-=3Ditem else, number of files E<gt> 4
+=3Ditem number of files E<gt> 4
=20
 =E2=87=92 GPT
=20
@@ -131,7 +120,9 @@ C<./> (absolute paths do not need modification).
 =3Ditem B<partition-type=3Dmbr>
=20
 Add an MBR (DOS-style) partition table.  The MBR format is maximally
-compatible with all clients, but only supports up to 4 partitions.
+compatible with all clients.  If there are E<gt> 4 partitions then an
+extended partition is created
+(L<https://en.wikipedia.org/wiki/Extended_boot_record>).
=20
 =3Ditem B<partition-type=3Dgpt>
=20
@@ -163,10 +154,6 @@ a Linux filesystem.
=20
 =3Dhead1 LIMITS
=20
-This plugin only supports B<primary> MBR partitions, hence the limit
-of 4 partitions with MBR.  This might be increased in future if we
-implement support for logical/extended MBR partitions.
-
 Although this plugin can create GPT partition tables containing more
 than 128 GPT partitions (in fact, unlimited numbers of partitions),
 some clients will not be able to handle this.
diff --git a/plugins/partitioning/virtual-disk.h b/plugins/partitioning/v=
irtual-disk.h
index 3860f46..f59df70 100644
--- a/plugins/partitioning/virtual-disk.h
+++ b/plugins/partitioning/virtual-disk.h
@@ -34,6 +34,7 @@
 #ifndef NBDKIT_VIRTUAL_DISK_H
 #define NBDKIT_VIRTUAL_DISK_H
=20
+#include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
=20
@@ -103,7 +104,7 @@ extern struct file *files;
 extern size_t nr_files;
=20
 extern struct regions regions;
-extern unsigned char *primary, *secondary;
+extern unsigned char *primary, *secondary, **ebr;
=20
 /* Main entry point called after files array has been populated. */
 extern int create_virtual_disk_layout (void);
@@ -114,16 +115,16 @@ extern int create_virtual_disk_layout (void);
 extern int parse_guid (const char *str, char *out)
   __attribute__((__nonnull__ (1, 2)));
=20
-/* Internal functions for creating MBR and GPT layouts.  These are
- * published here because the GPT code calls into the MBR code, but
- * are not meant to be called from the main plugin.
+/* Internal function for creating a single MBR PTE.  The GPT code
+ * calls this for creating the protective MBR.
  */
-extern void create_mbr_partition_table (unsigned char *out)
-  __attribute__((__nonnull__ (1)));
 extern void create_mbr_partition_table_entry (const struct region *,
-                                              int bootable, int partitio=
n_id,
+                                              bool bootable, int partiti=
on_id,
                                               unsigned char *)
   __attribute__((__nonnull__ (1, 4)));
+
+/* Create MBR or GPT layout. */
+extern void create_mbr_layout (void);
 extern void create_gpt_layout (void);
=20
 #endif /* NBDKIT_VIRTUAL_DISK_H */
diff --git a/plugins/partitioning/partition-gpt.c b/plugins/partitioning/=
partition-gpt.c
index 5fb7602..be52e72 100644
--- a/plugins/partitioning/partition-gpt.c
+++ b/plugins/partitioning/partition-gpt.c
@@ -210,7 +210,7 @@ create_gpt_protective_mbr (unsigned char *out)
   region.end =3D end;
   region.len =3D region.end - region.start + 1;
=20
-  create_mbr_partition_table_entry (&region, 0, 0xee, &out[0x1be]);
+  create_mbr_partition_table_entry (&region, false, 0xee, &out[0x1be]);
=20
   /* Boot signature. */
   out[0x1fe] =3D 0x55;
diff --git a/plugins/partitioning/partition-mbr.c b/plugins/partitioning/=
partition-mbr.c
index d3a0d78..6f76432 100644
--- a/plugins/partitioning/partition-mbr.c
+++ b/plugins/partitioning/partition-mbr.c
@@ -49,27 +49,125 @@
 #include "regions.h"
 #include "virtual-disk.h"
=20
-/* Create the partition table. */
+static const struct region *find_file_region (size_t i, size_t *j);
+static const struct region *find_ebr_region (size_t i, size_t *j);
+
+/* Create the MBR and optionally EBRs. */
 void
-create_mbr_partition_table (unsigned char *out)
+create_mbr_layout (void)
 {
-  size_t i, j;
-
-  for (j =3D 0; j < nr_regions (&regions); ++j) {
-    const struct region *region =3D get_region (&regions, j);
-
-    if (region->type =3D=3D region_file) {
-      i =3D region->u.i;
-      assert (i < 4);
-      create_mbr_partition_table_entry (region, i =3D=3D 0,
-                                        files[i].mbr_id,
-                                        &out[0x1be + 16*i]);
-    }
-  }
+  size_t i, j =3D 0;
=20
   /* Boot signature. */
-  out[0x1fe] =3D 0x55;
-  out[0x1ff] =3D 0xaa;
+  primary[0x1fe] =3D 0x55;
+  primary[0x1ff] =3D 0xaa;
+
+  if (nr_files <=3D 4) {
+    /* Basic MBR with no extended partition. */
+    for (i =3D 0; i < nr_files; ++i) {
+      const struct region *region =3D find_file_region (i, &j);
+
+      create_mbr_partition_table_entry (region, i =3D=3D 0, files[i].mbr=
_id,
+                                        &primary[0x1be + 16*i]);
+    }
+  }
+  else {
+    struct region region;
+    const struct region *rptr, *eptr0, *eptr;
+
+    /* The first three primary partitions correspond to the first
+     * three files.
+     */
+    for (i =3D 0; i < 3; ++i) {
+      rptr =3D find_file_region (i, &j);
+      create_mbr_partition_table_entry (rptr, i =3D=3D 0, files[i].mbr_i=
d,
+                                        &primary[0x1be + 16*i]);
+    }
+
+    /* The fourth partition is an extended PTE and does not correspond
+     * to any file.  This partition starts with the first EBR, so find
+     * it.  The partition extends to the end of the disk.
+     */
+    eptr0 =3D find_ebr_region (3, &j);
+    region.start =3D eptr0->start;
+    region.end =3D virtual_size (&regions) - 1; /* to end of disk */
+    region.len =3D region.end - region.start + 1;
+    create_mbr_partition_table_entry (&region, false, 0xf, &primary[0x1e=
e]);
+
+    /* The remaining files are mapped to logical partitions living in
+     * the fourth extended partition.
+     */
+    for (i =3D 3; i < nr_files; ++i) {
+      if (i =3D=3D 3)
+        eptr =3D eptr0;
+      else
+        eptr =3D find_ebr_region (i, &j);
+      rptr =3D find_file_region (i, &j);
+
+      /* Signature. */
+      ebr[i-3][0x1fe] =3D 0x55;
+      ebr[i-3][0x1ff] =3D 0xaa;
+
+      /* First entry in EBR contains:
+       * offset from EBR sector to the first sector of the logical parti=
tion
+       * total count of sectors in the logical partition
+       */
+      region.start =3D rptr->start - eptr->start;
+      region.len =3D rptr->len;
+      create_mbr_partition_table_entry (&region, false, files[i].mbr_id,
+                                        &ebr[i-3][0x1be]);
+
+      if (i < nr_files-1) {
+        size_t j2 =3D j;
+        const struct region *enext =3D find_ebr_region (i+1, &j2);
+        const struct region *rnext =3D find_file_region (i+1, &j2);
+
+        /* Second entry in the EBR contains:
+         * address of next EBR relative to extended partition
+         * total count of sectors in the next logical partition includin=
g
+         * next EBR
+         */
+        region.start =3D enext->start - eptr0->start;
+        region.len =3D rnext->end - enext->start + 1;
+        create_mbr_partition_table_entry (&region, false, files[i+1].mbr=
_id,
+                                          &ebr[i-3][0x1ce]);
+      }
+    }
+  }
+}
+
+/* Find the region corresponding to file[i].
+ * j is a scratch register ensuring we only do a linear scan.
+ */
+static const struct region *
+find_file_region (size_t i, size_t *j)
+{
+  const struct region *region;
+
+  for (; *j < nr_regions (&regions); ++(*j)) {
+    region =3D get_region (&regions, *j);
+    if (region->type =3D=3D region_file && region->u.i =3D=3D i)
+      return region;
+  }
+  abort ();
+}
+
+/* Find the region corresponding to EBR of file[i] (i >=3D 3).
+ * j is a scratch register ensuring we only do a linear scan.
+ */
+static const struct region *
+find_ebr_region (size_t i, size_t *j)
+{
+  const struct region *region;
+
+  assert (i >=3D 3);
+
+  for (; *j < nr_regions (&regions); ++(*j)) {
+    region =3D get_region (&regions, *j);
+    if (region->type =3D=3D region_data && region->u.data =3D=3D ebr[i-3=
])
+      return region;
+  }
+  abort ();
 }
=20
 static void
@@ -84,7 +182,7 @@ chs_too_large (unsigned char *out)
=20
 void
 create_mbr_partition_table_entry (const struct region *region,
-                                  int bootable, int partition_id,
+                                  bool bootable, int partition_id,
                                   unsigned char *out)
 {
   uint64_t start_sector, nr_sectors;
diff --git a/plugins/partitioning/partitioning.c b/plugins/partitioning/p=
artitioning.c
index 205c059..689cb24 100644
--- a/plugins/partitioning/partitioning.c
+++ b/plugins/partitioning/partitioning.c
@@ -35,6 +35,7 @@
=20
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <inttypes.h>
 #include <string.h>
@@ -81,8 +82,11 @@ size_t nr_files =3D 0;
 /* Virtual disk layout. */
 struct regions regions;
=20
-/* Primary and secondary partition tables (secondary is only used for GP=
T). */
-unsigned char *primary =3D NULL, *secondary =3D NULL;
+/* Primary and secondary partition tables and extended boot records.
+ * Secondary PT is only used for GPT.  EBR array of sectors is only
+ * used for MBR with > 4 partitions and has length equal to nr_files-3.
+ */
+unsigned char *primary =3D NULL, *secondary =3D NULL, **ebr =3D NULL;
=20
 /* Used to generate random unique partition GUIDs for GPT. */
 static struct random_state random_state;
@@ -105,12 +109,17 @@ partitioning_unload (void)
   free (files);
=20
   /* We don't need to free regions.regions[].u.data because it points
-   * to either primary or secondary which we free here.
+   * to primary, secondary or ebr which we free here.
    */
   free_regions (&regions);
=20
   free (primary);
   free (secondary);
+  if (ebr) {
+    for (i =3D 0; i < nr_files-3; ++i)
+      free (ebr[i]);
+    free (ebr);
+  }
 }
=20
 static int
@@ -225,7 +234,7 @@ partitioning_config_complete (void)
 {
   size_t i;
   uint64_t total_size;
-  int needs_gpt;
+  bool needs_gpt;
=20
   /* Not enough / too many files? */
   if (nr_files =3D=3D 0) {
@@ -236,17 +245,11 @@ partitioning_config_complete (void)
   total_size =3D 0;
   for (i =3D 0; i < nr_files; ++i)
     total_size +=3D files[i].statbuf.st_size;
-
-  if (nr_files > 4)
-    needs_gpt =3D 1;
-  else if (total_size > MAX_MBR_DISK_SIZE)
-    needs_gpt =3D 1;
-  else
-    needs_gpt =3D 0;
+  needs_gpt =3D total_size > MAX_MBR_DISK_SIZE;
=20
   /* Choose default parttype if not set. */
   if (parttype =3D=3D PARTTYPE_UNSET) {
-    if (needs_gpt) {
+    if (needs_gpt || nr_files > 4) {
       parttype =3D PARTTYPE_GPT;
       nbdkit_debug ("picking partition type GPT");
     }
@@ -256,8 +259,8 @@ partitioning_config_complete (void)
     }
   }
   else if (parttype =3D=3D PARTTYPE_MBR && needs_gpt) {
-    nbdkit_error ("MBR partition table type supports a maximum of 4 part=
itions "
-                  "and a maximum virtual disk size of about 2 TB, "
+    nbdkit_error ("MBR partition table type supports "
+                  "a maximum virtual disk size of about 2 TB, "
                   "but you requested %zu partition(s) "
                   "and a total size of %" PRIu64 " bytes (> %" PRIu64 ")=
.  "
                   "Try using: partition-type=3Dgpt",
diff --git a/plugins/partitioning/virtual-disk.c b/plugins/partitioning/v=
irtual-disk.c
index e2d72bc..4fe186e 100644
--- a/plugins/partitioning/virtual-disk.c
+++ b/plugins/partitioning/virtual-disk.c
@@ -69,6 +69,25 @@ create_virtual_disk_layout (void)
       nbdkit_error ("malloc: %m");
       return -1;
     }
+
+    if (nr_files > 4) {
+      /* The first 3 primary partitions will be real partitions, the
+       * 4th will be an extended partition, and so we need to store
+       * EBRs for nr_files-3 logical partitions.
+       */
+      ebr =3D malloc (sizeof (unsigned char *) * (nr_files-3));
+      if (ebr =3D=3D NULL) {
+        nbdkit_error ("malloc: %m");
+        return -1;
+      }
+      for (i =3D 0; i < nr_files-3; ++i) {
+        ebr[i] =3D calloc (1, SECTOR_SIZE);
+        if (ebr[i] =3D=3D NULL) {
+          nbdkit_error ("malloc: %m");
+          return -1;
+        }
+      }
+    }
   }
   else /* PARTTYPE_GPT */ {
     /* Protective MBR + PT header + PTA =3D 2 + GPT_PTA_LBAs */
@@ -117,6 +136,20 @@ create_virtual_disk_layout (void)
      */
     assert (IS_ALIGNED (offset, SECTOR_SIZE));
=20
+    /* Logical partitions are preceeded by an EBR. */
+    if (parttype =3D=3D PARTTYPE_MBR && nr_files > 4 && i >=3D 3) {
+      region.start =3D offset;
+      region.len =3D SECTOR_SIZE;
+      region.end =3D region.start + region.len - 1;
+      region.type =3D region_data;
+      region.u.data =3D ebr[i-3];
+      region.description =3D "EBR";
+      if (append_region (&regions, region) =3D=3D -1)
+        return -1;
+
+      offset =3D virtual_size (&regions);
+    }
+
     /* Make sure each partition is aligned for best performance. */
     if (!IS_ALIGNED (offset, files[i].alignment)) {
       region.start =3D offset;
@@ -207,13 +240,10 @@ create_partition_table (void)
   if (parttype =3D=3D PARTTYPE_GPT)
     assert (secondary !=3D NULL);
=20
-  if (parttype =3D=3D PARTTYPE_MBR) {
-    assert (nr_files <=3D 4);
-    create_mbr_partition_table (primary);
-  }
-  else /* parttype =3D=3D PARTTYPE_GPT */ {
+  if (parttype =3D=3D PARTTYPE_MBR)
+    create_mbr_layout ();
+  else /* parttype =3D=3D PARTTYPE_GPT */
     create_gpt_layout ();
-  }
=20
   return 0;
 }
--=20
2.20.1


--EUYUPHVNfBVWjsvu--
