Received: from eggs.gnu.org ([2001:4830:134:3::10]:37947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0VWI-0000Sn-AU
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0VWG-0008Nb-9k
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:58:22 -0400
From: Max Reitz <mreitz@redhat.com>
Message-Id: <20170401155751.14322-4-mreitz@redhat.com>
In-Reply-To: <20170401155751.14322-1-mreitz@redhat.com>
References: <20170401155751.14322-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC for-3.0 3/4] block/qcow2-rust: Add partial write
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Tue, 18 Apr 2017 15:58:24 -0000
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Some people may want to lead you to believe write support may destroy
your data. These entirely BASELESS and FALSE accusations are COMPLETE
and UTTER LIES because you actually cannot use this driver yet at all,
as it does not register itself as a qemu block driver.

This is a very modest approach, in contrast to some other LEGACY drivers
that do just assume they are worthy of this honor (which of course is
utterly wrong, they are INSECURE and NOT SUITED FOR THE JOB) and just
want to bury the gem the QEMU project is under a pile of not-greatness.
VERY SAD!

Also, we do not allocate any new clusters because we do not TAKE from
HONEST HARD-WORKING other programs that may want to use disk space, but
we just make do with what we have and that is enough!

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/rust/src/qcow2/allocation.rs | 162 +++++++++++++++++++++++++++++++++++++
 block/rust/src/qcow2/io.rs         | 117 +++++++++++++++++++++++++++
 block/rust/src/qcow2/mod.rs        |  17 +++-
 block/rust/src/qcow2/refcount.rs   |  96 ++++++++++++++++++++++
 4 files changed, 390 insertions(+), 2 deletions(-)
 create mode 100644 block/rust/src/qcow2/allocation.rs
 create mode 100644 block/rust/src/qcow2/refcount.rs

diff --git a/block/rust/src/qcow2/allocation.rs b/block/rust/src/qcow2/allocation.rs
new file mode 100644
index 0000000000..9ed975d853
--- /dev/null
+++ b/block/rust/src/qcow2/allocation.rs
@@ -0,0 +1,162 @@
+use interface::*;
+use qcow2::*;
+use qcow2::io::*;
+
+
+impl QCow2BDS {
+    fn allocate_cluster(cbds: &mut CBDS) -> Result<u64, IOError>
+    {
+        let (mut offset, cluster_size) = {
+            let_bds!(this, cbds);
+            (this.first_free_cluster_offset, this.cluster_size)
+        };
+
+        /* TODO: Optimize by scanning whole refblocks */
+        while try!(Self::get_refcount(cbds, offset)) > 0 {
+            offset += cluster_size as u64;
+        }
+
+        try!(Self::change_refcount(cbds, offset, 1));
+
+        {
+            let_mut_bds!(this, cbds);
+            this.first_free_cluster_offset = offset + (cluster_size as u64);
+        }
+
+        Ok(offset)
+    }
+
+
+    pub fn allocate_l2(cbds: &mut CBDS, mut hoi: HostOffsetInfo)
+        -> Result<HostOffsetInfo, IOError>
+    {
+        let offset = try!(Self::allocate_cluster(cbds));
+
+        /* Zero the new table */
+        {
+            let zero_data = qemu_blockalign(cbds, hoi.cluster_size as usize);
+            zero_byte_slice(zero_data);
+
+            let res = hoi.file.bdrv_pwrite(offset, zero_data);
+            qemu_vfree(zero_data);
+
+            if let Err(_) = res {
+                return Err(IOError::GenericError);
+            }
+        }
+
+        hoi.l1_entry = L1Entry::Allocated(offset, true);
+        try!(Self::update_l1_entry(cbds, &hoi));
+
+        hoi.l2_entry = Some(L2Entry::Unallocated);
+
+        Ok(hoi)
+    }
+
+
+    pub fn allocate_data_cluster(cbds: &mut CBDS, mut hoi: HostOffsetInfo)
+        -> Result<HostOffsetInfo, IOError>
+    {
+        let offset = try!(Self::allocate_cluster(cbds));
+
+        hoi.l2_entry = Some(L2Entry::Normal(offset, true));
+        hoi = try!(Self::update_l2_entry(cbds, hoi));
+
+        Ok(hoi)
+    }
+
+
+    pub fn free_cluster(cbds: &mut CBDS, l2e: L2Entry) -> Result<(), IOError>
+    {
+        match l2e {
+            L2Entry::Unallocated    => Ok(()),
+            L2Entry::Zero(None, _)  => Ok(()),
+
+            L2Entry::Normal(offset, _)
+            | L2Entry::Zero(Some(offset), _)
+            | L2Entry::Compressed(offset, _) => {
+                {
+                    let_mut_bds!(this, cbds);
+                    if offset < this.first_free_cluster_offset {
+                        this.first_free_cluster_offset = offset;
+                    }
+                }
+
+                Self::change_refcount(cbds, offset, -1)
+            },
+        }
+    }
+
+
+    pub fn update_l1_entry(cbds: &mut CBDS, hoi: &HostOffsetInfo)
+        -> Result<(), IOError>
+    {
+        let (l1_offset, l1_size) = {
+            let_bds!(this, cbds);
+            (this.l1_offset, this.l1_table.len())
+        };
+
+        assert!((hoi.l1_index as usize) < l1_size);
+        let entry_offset = l1_offset + (hoi.l1_index * 8) as u64;
+        let l1_entry_cpu = hoi.l1_entry.to_bits();
+        let l1_entry = u64::to_be(l1_entry_cpu);
+
+        if let Err(_) = hoi.file.bdrv_pwrite(entry_offset,
+                                             object_as_byte_slice(&l1_entry))
+        {
+            return Err(IOError::GenericError);
+        }
+
+        let_mut_bds!(this, cbds);
+        this.l1_table[hoi.l1_index as usize] = l1_entry_cpu;
+
+        Ok(())
+    }
+
+
+    /* hoi.l2_entry must be Some(_) */
+    pub fn update_l2_entry(cbds: &mut CBDS, mut hoi: HostOffsetInfo)
+        -> Result<HostOffsetInfo, IOError>
+    {
+        let (l2_offset, copied) = match hoi.l1_entry {
+            L1Entry::Unallocated => panic!("L2 table must be allocated"),
+            L1Entry::Allocated(o, c) => (o, c),
+        };
+
+        let l2_entry = u64::to_be(hoi.l2_entry.as_ref().unwrap()
+                                              .to_bits(hoi.compressed_shift));
+
+        if copied {
+            let entry_offset = l2_offset + (hoi.l2_index * 8) as u64;
+            if let Err(_) = hoi.file.bdrv_pwrite(entry_offset,
+                                                 object_as_byte_slice(&l2_entry))
+            {
+                return Err(IOError::GenericError);
+            }
+        } else {
+            let table_data = qemu_blockalign(cbds, hoi.cluster_size as usize);
+
+            if let Err(_) = hoi.file.bdrv_pread(l2_offset, table_data) {
+                qemu_vfree(table_data);
+                return Err(IOError::GenericError);
+            }
+
+            copy_into_byte_slice(table_data, (hoi.l2_index * 8) as usize,
+                                 object_as_byte_slice(&l2_entry));
+
+            let new_offset = try_vfree!(Self::allocate_cluster(cbds),
+                                        table_data);
+            let res = hoi.file.bdrv_pwrite(new_offset, table_data);
+            qemu_vfree(table_data);
+
+            if let Err(_) = res {
+                return Err(IOError::GenericError);
+            }
+
+            hoi.l1_entry = L1Entry::Allocated(new_offset, true);
+            try!(Self::update_l1_entry(cbds, &hoi));
+        }
+
+        Ok(hoi)
+    }
+}
diff --git a/block/rust/src/qcow2/io.rs b/block/rust/src/qcow2/io.rs
index 069cc78303..36556282de 100644
--- a/block/rust/src/qcow2/io.rs
+++ b/block/rust/src/qcow2/io.rs
@@ -319,4 +319,121 @@ impl QCow2BDS {
         let hoi = try!(Self::find_host_offset(cbds, offset));
         Self::do_read_cluster(cbds, &hoi, dest, flags)
     }
+
+
+    /* If necessary. copies a cluster somewhere else (freeing the original
+     * allocation), overlaying the data with the given slice (if given). */
+    fn copy_and_overlay_cluster(cbds: &mut CBDS, mut hoi: HostOffsetInfo,
+                                overlay_opt: Option<&[u8]>, flags: u32)
+        -> Result<(), IOError>
+    {
+        let free_original: L2Entry;
+
+        let mut cluster_data = qemu_blockalign(cbds, hoi.cluster_size as usize);
+        try_vfree!(Self::do_read_cluster(cbds, &hoi, cluster_data, 0),
+                   cluster_data);
+
+        match hoi.l2_entry {
+            None => panic!("L2 entry expected"),
+
+            Some(L2Entry::Zero(Some(offset), true)) => {
+                /* We are going to use this cluster, so do not free it */
+                free_original = L2Entry::Unallocated;
+                hoi.l2_entry = Some(L2Entry::Normal(offset, true));
+                hoi = try_vfree!(Self::update_l2_entry(cbds, hoi),
+                                 cluster_data);
+            },
+
+            Some(unwrapped_entry) => {
+                free_original = unwrapped_entry;
+                hoi.l2_entry = Some(L2Entry::Unallocated);
+
+                hoi = try_vfree!(Self::allocate_data_cluster(cbds, hoi),
+                                 cluster_data);
+            }
+        }
+
+        try_vfree!(Self::free_cluster(cbds, free_original),
+                   cluster_data);
+
+        if let Some(overlay) = overlay_opt {
+            copy_into_byte_slice(cluster_data, hoi.offset_in_cluster as usize,
+                                 overlay);
+        }
+
+        /* TODO: Maybe on failure we should try pointing back to the original
+         *       cluster? */
+        hoi.offset_in_cluster = 0;
+        try_vfree!(Self::do_write_cluster(cbds, hoi, cluster_data, flags),
+                   cluster_data);
+
+        qemu_vfree(cluster_data);
+
+        Ok(())
+    }
+
+
+    fn do_write_cluster(cbds: &mut CBDS, mut hoi: HostOffsetInfo, src: &[u8],
+                        flags: u32)
+        -> Result<(), IOError>
+    {
+        /* Try to set COPIED flag */
+        match hoi.l2_entry {
+            Some(L2Entry::Normal(offset, false)) => {
+                if try!(Self::get_refcount(cbds, offset)) == 1 {
+                    hoi.l2_entry = Some(L2Entry::Normal(offset, true));
+                    /* We are going to write directly into this cluster without
+                     * updating the L2 table, so do it now */
+                    hoi = try!(Self::update_l2_entry(cbds, hoi));
+                }
+            },
+
+            Some(L2Entry::Zero(Some(offset), false)) => {
+                if try!(Self::get_refcount(cbds, offset)) == 1 {
+                    hoi.l2_entry = Some(L2Entry::Zero(Some(offset), true));
+                    /* No need to update the L2 table entry now: We will call
+                     * copy_and_overlay_cluster() and that will do the update */
+                }
+            },
+
+            _ => (),
+        }
+
+        match hoi.l2_entry {
+            None => {
+                hoi = try!(Self::allocate_l2(cbds, hoi));
+                Self::do_write_cluster(cbds, hoi, src, flags)
+            },
+
+            Some(L2Entry::Normal(offset, true)) => {
+                let full_offset = offset + (hoi.offset_in_cluster as u64);
+                if let Err(_) = hoi.file.bdrv_pwrite(full_offset, src) {
+                    Err(IOError::GenericError)
+                } else {
+                    Ok(())
+                }
+            },
+
+            _ => {
+                Self::copy_and_overlay_cluster(cbds, hoi, Some(src), flags)
+            },
+        }
+    }
+
+
+    pub fn write_cluster(cbds: &mut CBDS, offset: u64, bytes: u32,
+                         full_src_mnm: &mut MNMIOVSlice, flags: u32)
+        -> Result<(), IOError>
+    {
+        let src = match *full_src_mnm {
+            MNMIOVSlice::Mut(ref mut full_src) =>
+                full_src.split_at(bytes as usize).0,
+
+            MNMIOVSlice::Const(ref mut full_src) =>
+                full_src.split_at(bytes as usize).0,
+        };
+
+        let hoi = try!(Self::find_host_offset(cbds, offset));
+        Self::do_write_cluster(cbds, hoi, src, flags)
+    }
 }
diff --git a/block/rust/src/qcow2/mod.rs b/block/rust/src/qcow2/mod.rs
index 5fb523c93b..6cd413c5cb 100644
--- a/block/rust/src/qcow2/mod.rs
+++ b/block/rust/src/qcow2/mod.rs
@@ -1,4 +1,6 @@
+mod allocation;
 mod io;
+mod refcount;
 mod on_disk_structures;
 
 
@@ -264,8 +266,6 @@ impl BlockDriverOpen for QCow2BDS {
             this.common.set_file(Some(file));
         }
 
-        cbds.read_only = true;
-
         QCow2BDS::do_open(cbds, options, flags)
     }
 }
@@ -290,6 +290,18 @@ impl BlockDriverRead for QCow2BDS {
 }
 
 
+impl BlockDriverWrite for QCow2BDS {
+    fn bdrv_co_pwritev(cbds: &mut CBDS, offset: u64, bytes: u64,
+                       iov: Vec<&[u8]>, flags: u32)
+        -> Result<(), IOError>
+    {
+        /* TODO: Do not split */
+        Self::split_io_to_clusters(cbds, offset, bytes, io::MNMIOV::Const(iov),
+                                   flags, &Self::write_cluster)
+    }
+}
+
+
 impl BlockDriverChildPerm for QCow2BDS {
     fn bdrv_child_perm(cbds: &mut CBDS, c: Option<&mut BdrvChild>,
                        role: &c_structs::BdrvChildRole, perm: u64, shared: u64)
@@ -325,6 +337,7 @@ pub extern fn bdrv_qcow2_rust_init()
     bdrv.provides_open();
     bdrv.provides_close();
     bdrv.provides_read();
+    bdrv.provides_write();
     bdrv.provides_child_perm();
     bdrv.provides_info();
 
diff --git a/block/rust/src/qcow2/refcount.rs b/block/rust/src/qcow2/refcount.rs
new file mode 100644
index 0000000000..4f5e14a9f8
--- /dev/null
+++ b/block/rust/src/qcow2/refcount.rs
@@ -0,0 +1,96 @@
+use interface::*;
+use qcow2::*;
+
+
+impl QCow2BDS {
+    pub fn get_refcount(cbds: &mut CBDS, offset: u64) -> Result<u64, IOError>
+    {
+        let refblock_index;
+        let refcount_order;
+        let cluster_size;
+        let file;
+
+        let reftable_entry = {
+            let_bds!(this, cbds);
+
+            refcount_order = this.refcount_order;
+            cluster_size = this.cluster_size;
+            file = this.common.file();
+
+            let cluster_index = offset >> this.cluster_bits;
+            let reftable_index = offset >> this.reftable_bits;
+
+            refblock_index = (cluster_index as u32) & (this.refblock_size - 1);
+
+            if reftable_index >= (this.reftable_size as u64) {
+                0
+            } else {
+                this.reftable[reftable_index as usize]
+            }
+        };
+
+        let refblock_offset = reftable_entry & REFT_OFFSET_MASK;
+
+        if refblock_offset == 0 {
+            return Ok(0);
+        }
+
+        if (refblock_offset & ((cluster_size - 1) as u64)) != 0 {
+            return Err(IOError::InvalidMetadata);
+        }
+
+        assert!(refcount_order <= 6);
+        if refcount_order == 6 {
+            let mut refcount: u64 = 0;
+            let byte_offset = (refblock_index * 8) as u64;
+            if let Err(_) =
+                file.bdrv_pread(refblock_offset + byte_offset,
+                                object_as_mut_byte_slice(&mut refcount))
+            {
+                return Err(IOError::GenericError);
+            }
+            Ok(u64::from_be(refcount))
+        } else if refcount_order == 5 {
+            let mut refcount: u32 = 0;
+            let byte_offset = (refblock_index * 4) as u64;
+            if let Err(_) =
+                file.bdrv_pread(refblock_offset + byte_offset,
+                                object_as_mut_byte_slice(&mut refcount))
+            {
+                return Err(IOError::GenericError);
+            }
+            Ok(u32::from_be(refcount) as u64)
+        } else if refcount_order == 4 {
+            let mut refcount: u16 = 0;
+            let byte_offset = (refblock_index * 2) as u64;
+            if let Err(_) =
+                file.bdrv_pread(refblock_offset + byte_offset,
+                                object_as_mut_byte_slice(&mut refcount))
+            {
+                return Err(IOError::GenericError);
+            }
+            Ok(u16::from_be(refcount) as u64)
+        } else {
+            let mut refcount_byte: u8 = 0;
+            let byte_offset = (refblock_index >> (3 - refcount_order)) as u64;
+            if let Err(_) =
+                file.bdrv_pread(refblock_offset + byte_offset,
+                                object_as_mut_byte_slice(&mut refcount_byte))
+            {
+                return Err(IOError::GenericError);
+            }
+
+            let mask = ((1u16 << (1u8 << refcount_order)) - 1) as u8;
+            let shift = (refblock_index << refcount_order) & 0x7;
+
+            Ok(((refcount_byte >> shift) & mask) as u64)
+        }
+    }
+
+
+    pub fn change_refcount(_: &mut CBDS, _: u64, _: i8)
+        -> Result<(), IOError>
+    {
+        Err(IOError::UnsupportedImageFeature)
+    }
+}
-- 
2.12.2
