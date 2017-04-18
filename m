Received: from eggs.gnu.org ([2001:4830:134:3::10]:37898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0VWF-0000Pu-2c
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0VWC-0008ML-LW
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:58:19 -0400
From: Max Reitz <mreitz@redhat.com>
Message-Id: <20170401155751.14322-3-mreitz@redhat.com>
In-Reply-To: <20170401155751.14322-1-mreitz@redhat.com>
References: <20170401155751.14322-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC for-3.0 2/4] block/qcow2-rust: Add qcow2-rust
 block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Tue, 18 Apr 2017 15:58:21 -0000
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Currently, this MUCH MORE SECURE block driver than the LEGACY C qcow2
driver (SAD!) only has read support. But this makes it actually much
less likely to destroy your data, so this is a GOOD thing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/rust/src/lib.rs                      |   3 +
 block/rust/src/qcow2/io.rs                 | 322 +++++++++++++++++++++++++++
 block/rust/src/qcow2/mod.rs                | 334 +++++++++++++++++++++++++++++
 block/rust/src/qcow2/on_disk_structures.rs |  59 +++++
 4 files changed, 718 insertions(+)
 create mode 100644 block/rust/src/qcow2/io.rs
 create mode 100644 block/rust/src/qcow2/mod.rs
 create mode 100644 block/rust/src/qcow2/on_disk_structures.rs

diff --git a/block/rust/src/lib.rs b/block/rust/src/lib.rs
index 2aa2f365ba..9892a22b84 100644
--- a/block/rust/src/lib.rs
+++ b/block/rust/src/lib.rs
@@ -7,3 +7,6 @@ extern crate libc;
 
 #[macro_use]
 mod interface;
+
+mod qcow2;
+pub use qcow2::*; /* Export symbols */
diff --git a/block/rust/src/qcow2/io.rs b/block/rust/src/qcow2/io.rs
new file mode 100644
index 0000000000..069cc78303
--- /dev/null
+++ b/block/rust/src/qcow2/io.rs
@@ -0,0 +1,322 @@
+use interface::*;
+use qcow2::*;
+
+
+pub enum MNMIOV<'a> {
+    Mut(Vec<&'a mut [u8]>),
+    Const(Vec<&'a [u8]>),
+}
+
+pub enum MNMIOVSlice<'a> {
+    Mut(&'a mut [u8]),
+    Const(&'a [u8]),
+}
+
+
+pub struct HostOffsetInfo {
+    pub guest_offset: u64,
+
+    pub cluster_size: u32,
+    pub compressed_shift: u8,
+
+    pub file: BdrvChild,
+
+    pub l1_index: u32,
+    pub l2_index: u32,
+    pub offset_in_cluster: u32,
+
+    pub l1_entry: L1Entry,
+    pub l2_entry: Option<L2Entry>,
+}
+
+pub enum L1Entry {
+    Unallocated,
+
+    /* L2 offset, COPIED */
+    Allocated(u64, bool),
+}
+
+pub enum L2Entry {
+    Unallocated,
+
+    /* Offset, COPIED */
+    Normal(u64, bool),
+
+    /* Offset (if allocated), COPIED */
+    Zero(Option<u64>, bool),
+
+    /* Offset, compressed length */
+    Compressed(u64, usize),
+}
+
+impl L1Entry {
+    pub fn from_bits(l1_entry: u64, cluster_size: u32) -> Result<L1Entry, IOError>
+    {
+        let l2_offset = l1_entry & L1E_OFFSET_MASK;
+
+        if l2_offset == 0 {
+            Ok(L1Entry::Unallocated)
+        } else if (l2_offset & ((cluster_size - 1) as u64)) != 0 {
+            Err(IOError::InvalidMetadata)
+        } else {
+            Ok(L1Entry::Allocated(l2_offset, (l1_entry & OFLAG_COPIED) != 0))
+        }
+    }
+
+
+    pub fn to_bits(&self) -> u64
+    {
+        match *self {
+            L1Entry::Unallocated                => 0u64,
+            L1Entry::Allocated(offset, false)   => offset,
+            L1Entry::Allocated(offset, true)    => offset | OFLAG_COPIED,
+        }
+    }
+}
+
+impl L2Entry {
+    pub fn from_bits(l2_entry: u64, cluster_size: u32, compressed_shift: u8)
+        -> Result<L2Entry, IOError>
+    {
+        if (l2_entry & OFLAG_COMPRESSED) != 0 {
+            let offset = l2_entry & ((1u64 << compressed_shift) - 1);
+            let sectors = (l2_entry & L2E_COMPRESSED_MASK) >> compressed_shift;
+            let length = sectors * BDRV_SECTOR_SIZE;
+
+            Ok(L2Entry::Compressed(offset, length as usize))
+        } else {
+            let offset = l2_entry & L2E_OFFSET_MASK;
+            let copied = (l2_entry & OFLAG_COPIED) != 0;
+
+            if (offset & ((cluster_size - 1) as u64)) != 0 {
+                Err(IOError::InvalidMetadata)
+            } else {
+                if (l2_entry & OFLAG_ZERO) != 0 {
+                    if offset == 0 {
+                        Ok(L2Entry::Zero(None, false))
+                    } else {
+                        Ok(L2Entry::Zero(Some(offset), copied))
+                    }
+                } else {
+                    if offset == 0 {
+                        Ok(L2Entry::Unallocated)
+                    } else {
+                        Ok(L2Entry::Normal(offset, copied))
+                    }
+                }
+            }
+        }
+    }
+
+
+    pub fn to_bits(&self, compressed_shift: u8) -> u64
+    {
+        match *self {
+            L2Entry::Unallocated                => 0u64,
+            L2Entry::Normal(offset, false)      => offset,
+            L2Entry::Normal(offset, true)       => offset | OFLAG_COPIED,
+            L2Entry::Zero(None, _)              => OFLAG_ZERO,
+            L2Entry::Zero(Some(offset), false)  => offset | OFLAG_ZERO,
+            L2Entry::Zero(Some(offset), true)   => offset
+                                                   | OFLAG_COPIED | OFLAG_ZERO,
+
+            L2Entry::Compressed(offset, length) => {
+                let secs = ((length as u64) + BDRV_SECTOR_SIZE - 1)
+                               / BDRV_SECTOR_SIZE;
+
+                assert!((offset & !((1u64 << compressed_shift) - 1)) == 0);
+                assert!((secs << compressed_shift) >> compressed_shift == secs);
+
+                offset | (secs << compressed_shift) | OFLAG_COMPRESSED
+            }
+        }
+    }
+}
+
+
+impl QCow2BDS {
+    pub fn split_io_to_clusters(cbds: &mut CBDS, mut offset: u64, bytes: u64,
+                                mut iov_mnm: MNMIOV, flags: u32,
+                                func: &Fn(&mut CBDS, u64, u32, &mut MNMIOVSlice,
+                                          u32)
+                                     -> Result<(), IOError>)
+        -> Result<(), IOError>
+    {
+        let cluster_size = {
+            let_bds!(this, cbds);
+            this.cluster_size
+        };
+
+        let mut current_slice_outer: Option<MNMIOVSlice> = None;
+
+        let end_offset = offset + bytes;
+        while offset < end_offset {
+            /* Using a single current_slice variable does not work, and my
+             * knowledge of Rust does not suffice to explain why. */
+            current_slice_outer = {
+                let mut current_slice_opt = current_slice_outer;
+
+                let mut cs_len;
+
+                while (cs_len = match current_slice_opt {
+                        None                                => 0,
+                        Some(MNMIOVSlice::Mut(ref slice))   => slice.len(),
+                        Some(MNMIOVSlice::Const(ref slice)) => slice.len(),
+                    }, cs_len) == ((), 0)
+                {
+                    current_slice_opt = match iov_mnm {
+                        MNMIOV::Mut(ref mut iov) =>
+                            Some(MNMIOVSlice::Mut(iov.pop().unwrap())),
+
+                        MNMIOV::Const(ref mut iov) =>
+                            Some(MNMIOVSlice::Const(iov.pop().unwrap())),
+                    }
+                }
+
+                let mut current_slice = current_slice_opt.unwrap();
+
+                let mut this_bytes: u32 = cluster_size;
+                if cs_len < (this_bytes as usize) {
+                    this_bytes = cs_len as u32;
+                }
+                if end_offset - offset < (this_bytes as u64) {
+                    this_bytes = (end_offset - offset) as u32;
+                }
+
+                try!(func(cbds, offset, this_bytes, &mut current_slice, flags));
+
+                offset += this_bytes as u64;
+
+                Some(match current_slice {
+                    MNMIOVSlice::Mut(iov) =>
+                        MNMIOVSlice::Mut(iov.split_at_mut(this_bytes as usize).1),
+
+                    MNMIOVSlice::Const(iov) =>
+                        MNMIOVSlice::Const(iov.split_at(this_bytes as usize).1),
+                })
+            };
+        }
+
+        Ok(())
+    }
+
+
+    fn do_backing_read(cbds: &mut CBDS, offset: u64, dest: &mut [u8])
+        -> Result<(), IOError>
+    {
+        let backing = {
+            let_mut_bds!(this, cbds);
+
+            if !this.common.has_backing() {
+                zero_byte_slice(dest);
+                return Ok(());
+            }
+
+            this.common.backing()
+        };
+
+        match backing.bdrv_pread(offset, dest) {
+            Ok(_) => Ok(()),
+            Err(_) => Err(IOError::GenericError),
+        }
+    }
+
+
+    fn find_host_offset(cbds: &mut CBDS, offset: u64)
+        -> Result<HostOffsetInfo, IOError>
+    {
+        let mut res = {
+            let_mut_bds!(this, cbds);
+
+            let cluster_offset_mask = (this.cluster_size - 1) as u64;
+            let l2_mask = (this.l2_size - 1) as u32;
+
+            let l1_index = (offset >> this.l1_bits) as usize;
+
+            HostOffsetInfo {
+                guest_offset: offset,
+
+                cluster_size: this.cluster_size,
+                compressed_shift: 63 - (this.cluster_bits - 8),
+
+                file: this.common.file(),
+
+                l1_index: l1_index as u32,
+                l2_index: ((offset >> this.cluster_bits) as u32) & l2_mask,
+                offset_in_cluster: (offset & cluster_offset_mask) as u32,
+
+                l1_entry: try!(L1Entry::from_bits(this.l1_table[l1_index],
+                                                  this.cluster_size)),
+                l2_entry: None,
+            }
+        };
+
+        let mut l2_entry_offset;
+
+        match res.l1_entry {
+            L1Entry::Unallocated    => return Ok(res),
+            L1Entry::Allocated(l2_offset, _) => l2_entry_offset = l2_offset,
+        }
+
+        l2_entry_offset += (res.l2_index as u64) * 8;
+
+        let mut l2_entry = 0u64;
+        if let Err(_) =
+            res.file.bdrv_pread(l2_entry_offset,
+                                object_as_mut_byte_slice(&mut l2_entry))
+        {
+            return Err(IOError::GenericError);
+        }
+
+        let l2_entry = try!(L2Entry::from_bits(u64::from_be(l2_entry),
+                                               res.cluster_size,
+                                               res.compressed_shift));
+        res.l2_entry = Some(l2_entry);
+        return Ok(res);
+    }
+
+
+    fn do_read_cluster(cbds: &mut CBDS, hoi: &HostOffsetInfo, dest: &mut [u8],
+                       _: u32)
+        -> Result<(), IOError>
+    {
+        match hoi.l2_entry {
+            None | Some(L2Entry::Unallocated) =>
+                Self::do_backing_read(cbds, hoi.guest_offset, dest),
+
+            Some(L2Entry::Zero(_, _)) => {
+                zero_byte_slice(dest);
+                Ok(())
+            },
+
+            Some(L2Entry::Compressed(_, _)) =>
+                Err(IOError::UnsupportedImageFeature),
+
+            Some(L2Entry::Normal(offset, _)) => {
+                let full_offset = offset + (hoi.offset_in_cluster as u64);
+                if let Err(_) = hoi.file.bdrv_pread(full_offset, dest) {
+                    Err(IOError::GenericError)
+                } else {
+                    Ok(())
+                }
+            }
+        }
+    }
+
+
+    pub fn read_cluster(cbds: &mut CBDS, offset: u64, bytes: u32,
+                        full_dest_mnm: &mut MNMIOVSlice, flags: u32)
+        -> Result<(), IOError>
+    {
+        let mut dest = match *full_dest_mnm {
+            MNMIOVSlice::Mut(ref mut full_dest) =>
+                full_dest.split_at_mut(bytes as usize).0,
+
+            MNMIOVSlice::Const(_) =>
+                panic!("read_cluster() requires a mutable I/O vector"),
+        };
+
+        let hoi = try!(Self::find_host_offset(cbds, offset));
+        Self::do_read_cluster(cbds, &hoi, dest, flags)
+    }
+}
diff --git a/block/rust/src/qcow2/mod.rs b/block/rust/src/qcow2/mod.rs
new file mode 100644
index 0000000000..5fb523c93b
--- /dev/null
+++ b/block/rust/src/qcow2/mod.rs
@@ -0,0 +1,334 @@
+mod io;
+mod on_disk_structures;
+
+
+use interface::*;
+use self::on_disk_structures::*;
+
+
+const MIN_CLUSTER_BITS: u32 =  9;
+const MAX_CLUSTER_BITS: u32 = 21;
+const MAX_L1_SIZE       : u32 = 0x02000000u32;
+const MAX_REFTABLE_SIZE : u32 = 0x00800000u32;
+const L1E_OFFSET_MASK       : u64 = 0x00fffffffffffe00u64;
+const L2E_OFFSET_MASK       : u64 = 0x00fffffffffffe00u64;
+const L2E_COMPRESSED_MASK   : u64 = 0x3fffffffffffffffu64;
+const REFT_OFFSET_MASK      : u64 = 0xfffffffffffffe00u64;
+
+const OFLAG_COPIED      : u64 = 1u64 << 63;
+const OFLAG_COMPRESSED  : u64 = 1u64 << 62;
+const OFLAG_ZERO        : u64 = 1u64 <<  0;
+
+
+pub struct QCow2BDS {
+    common: BDSCommon<QCow2BDS>,
+
+    qcow_version: u8,
+
+    cluster_bits: u8,
+    cluster_size: u32,
+    cluster_sectors: u32,
+
+    l1_bits: u8,
+    l1_size: u32,
+    l2_bits: u8,
+    l2_size: u32,
+
+    l1_offset: u64,
+    l1_table: Vec<u64>,
+
+    refcount_order: u8,
+    reftable_bits: u8,
+    refblock_size: u32,
+
+    reftable_offset: u64,
+    reftable_size: u32,
+    reftable: Vec<u64>,
+
+    first_free_cluster_offset: u64,
+}
+
+
+impl QCow2BDS {
+    fn do_open(cbds: &mut CBDS, _: QDict, _: u32)
+        -> Result<(), String>
+    {
+        let file = {
+            let_mut_bds!(this, cbds);
+            this.common.file()
+        };
+
+        let mut header = QCow2Header::default();
+        try_prepend!(file.bdrv_pread(0, object_as_mut_byte_slice(&mut header)),
+                     "Could not read qcow2 header");
+
+        header.from_be();
+
+        let reftable_size;
+
+        {
+            let_mut_bds!(this, cbds);
+
+            if header.magic != 0x514649fb {
+                return Err(String::from("Image is not in qcow2 format"));
+            }
+            if header.version < 2 || header.version > 3 {
+                return Err(format!("Unsupported qcow2 version {}",
+                                   header.version));
+            }
+
+            this.qcow_version = header.version as u8;
+
+            if header.cluster_bits < MIN_CLUSTER_BITS ||
+                header.cluster_bits > MAX_CLUSTER_BITS
+            {
+                return Err(format!("Unsupported cluster size: 2^{}",
+                                   header.cluster_bits));
+            }
+
+            this.cluster_bits = header.cluster_bits as u8;
+            this.cluster_size = 1u32 << this.cluster_bits;
+            this.cluster_sectors = this.cluster_size >> BDRV_SECTOR_SHIFT;
+
+            if this.qcow_version > 2 {
+                if header.header_length < 104 {
+                    return Err(String::from("qcow2 header too short"));
+                }
+                if header.header_length > this.cluster_size {
+                    return Err(String::from("qcow2 header exceeds cluster \
+                                             size"));
+                }
+            }
+
+            if header.backing_file_offset > (this.cluster_size as u64) {
+                return Err(String::from("Invalid backing file offset"));
+            }
+
+            if this.qcow_version > 2 {
+                if header.incompatible_features != 0 {
+                    return Err(format!("Unsupported incompatible features: \
+                                        {:x}", header.incompatible_features));
+                }
+
+                if header.refcount_order > 6 {
+                    return Err(String::from("Refcount width may not exceed 64 \
+                                             bits"));
+                }
+                this.refcount_order = header.refcount_order as u8;
+            }
+
+            /* No need to do anything about snapshots, compression, encryption,
+             * or other funky extensions: We do not support them */
+
+            if header.crypt_method != 0 {
+                return Err(format!("Unsupported encryption method: {}",
+                                   header.crypt_method));
+            }
+
+            if header.backing_file_size > 1023 ||
+                (header.backing_file_size as u64) >
+                    (this.cluster_size as u64) - header.backing_file_offset
+            {
+                return Err(String::from("Backing file name too long"));
+            }
+
+
+            this.l2_bits = this.cluster_bits - 3 /* ld(sizeof(u64)) */;
+            this.l2_size = 1u32 << this.l2_bits;
+
+            cbds.total_sectors = (header.size / BDRV_SECTOR_SIZE) as i64;
+
+            this.l1_offset = header.l1_table_offset;
+            this.l1_bits = this.cluster_bits + this.l2_bits;
+
+            if header.l1_size > MAX_L1_SIZE / 8 {
+                return Err(String::from("Active L1 table too large"));
+            }
+
+            let min_l1_size = (header.size + (1u64 << this.l1_bits) - 1) >>
+                                  this.l1_bits;
+            if (header.l1_size as u64) < min_l1_size || header.l1_size == 0 {
+                return Err(String::from("Active L1 table too small"));
+            }
+
+            this.l1_size = header.l1_size;
+
+            this.reftable_offset = header.refcount_table_offset;
+
+            reftable_size = (header.refcount_table_clusters as u64) <<
+                                (this.cluster_bits - 3);
+            if reftable_size > (MAX_REFTABLE_SIZE as u64) {
+                return Err(String::from("Refcount table too large"));
+            }
+
+            this.reftable_size = reftable_size as u32;
+
+            let refblock_bits = this.cluster_bits + this.refcount_order - 3;
+            this.reftable_bits = this.cluster_bits + refblock_bits;
+            this.refblock_size = 1u32 << refblock_bits;
+        }
+
+        /* Read L1 table */
+        let mut l1_table = Vec::<u64>::new();
+        l1_table.resize(header.l1_size as usize, 0);
+
+        try_prepend!(file.bdrv_pread(header.l1_table_offset,
+                                     vec_as_mut_byte_slice(&mut l1_table)),
+                     "Could not read L1 table");
+
+        for i in 0..header.l1_size {
+            l1_table[i as usize] = u64::from_be(l1_table[i as usize]);
+        }
+
+        /* Read reftable */
+        let mut reftable = Vec::<u64>::new();
+        reftable.resize(reftable_size as usize, 0);
+
+        try_prepend!(file.bdrv_pread(header.refcount_table_offset,
+                                     vec_as_mut_byte_slice(&mut reftable)),
+                     "Could not read refcount table");
+
+        for i in 0..reftable_size {
+            reftable[i as usize] = u64::from_be(reftable[i as usize]);
+        }
+
+        /* Read backing file name */
+        try_prepend!(
+            file.bdrv_pread(header.backing_file_offset,
+                            slice_as_mut_byte_slice(&mut cbds.backing_file)),
+            "Could not read backing file name");
+        cbds.backing_file[header.backing_file_size as usize] = 0;
+
+        {
+            let_mut_bds!(this, cbds);
+            this.l1_table = l1_table;
+            this.reftable = reftable;
+        }
+
+        Ok(())
+    }
+}
+
+
+impl BlockDriverState for QCow2BDS {
+    fn new() -> Self
+    {
+        QCow2BDS {
+            common: BDSCommon::<Self>::new(),
+
+            qcow_version: 0,
+
+            cluster_bits: 0,
+            cluster_size: 0,
+            cluster_sectors: 0,
+
+            l1_bits: 0,
+            l1_size: 0,
+            l2_bits: 0,
+            l2_size: 0,
+
+            l1_offset: 0,
+            l1_table: Vec::new(),
+
+            refcount_order: 0,
+            reftable_bits: 0,
+            refblock_size: 0,
+
+            reftable_offset: 0,
+            reftable_size: 0,
+            reftable: Vec::new(),
+
+            first_free_cluster_offset: 0,
+        }
+    }
+
+    /* Required for the generic BlockDriverState implementation */
+    fn common(&mut self) -> &mut BDSCommon<Self>
+    {
+        &mut self.common
+    }
+}
+
+
+impl BlockDriverOpen for QCow2BDS {
+    fn bdrv_open(cbds: &mut CBDS, options: QDict, flags: u32)
+        -> Result<(), String>
+    {
+        let role = bdrv_get_standard_child_role(StandardChildRole::File);
+        let file = try!(bdrv_open_child(None, Some(options),
+                                        String::from("file"), cbds, role,
+                                        false));
+
+        {
+            let_mut_bds!(this, cbds);
+            this.common.set_file(Some(file));
+        }
+
+        cbds.read_only = true;
+
+        QCow2BDS::do_open(cbds, options, flags)
+    }
+}
+
+
+impl BlockDriverClose for QCow2BDS {
+    fn bdrv_close(_: &mut CBDS)
+    {
+    }
+}
+
+
+impl BlockDriverRead for QCow2BDS {
+    fn bdrv_co_preadv(cbds: &mut CBDS, offset: u64, bytes: u64,
+                      iov: Vec<&mut [u8]>, flags: u32)
+        -> Result<(), IOError>
+    {
+        /* TODO: Do not split */
+        Self::split_io_to_clusters(cbds, offset, bytes, io::MNMIOV::Mut(iov),
+                                   flags, &Self::read_cluster)
+    }
+}
+
+
+impl BlockDriverChildPerm for QCow2BDS {
+    fn bdrv_child_perm(cbds: &mut CBDS, c: Option<&mut BdrvChild>,
+                       role: &c_structs::BdrvChildRole, perm: u64, shared: u64)
+        -> (u64, u64)
+    {
+        bdrv_format_default_perms(c, role, perm, shared,
+                                  bdrv_is_read_only(cbds))
+    }
+}
+
+
+impl BlockDriverInfo for QCow2BDS {
+    fn bdrv_get_info(cbds: &mut CBDS, bdi: &mut c_structs::BlockDriverInfo)
+        -> Result<(), String>
+    {
+        let_bds!(this, cbds);
+
+        bdi.unallocated_blocks_are_zero = true;
+        bdi.can_write_zeroes_with_unmap = false; /* no discard support */
+        bdi.cluster_size = this.cluster_size as i32;
+        /* no VM state support */
+
+        Ok(())
+    }
+}
+
+
+#[no_mangle]
+pub extern fn bdrv_qcow2_rust_init()
+{
+    let mut bdrv = BlockDriver::<QCow2BDS>::new(String::from("qcow2-rust"));
+
+    bdrv.provides_open();
+    bdrv.provides_close();
+    bdrv.provides_read();
+    bdrv.provides_child_perm();
+    bdrv.provides_info();
+
+    bdrv.supports_backing();
+
+    bdrv_register(bdrv);
+}
diff --git a/block/rust/src/qcow2/on_disk_structures.rs b/block/rust/src/qcow2/on_disk_structures.rs
new file mode 100644
index 0000000000..bdc8be7418
--- /dev/null
+++ b/block/rust/src/qcow2/on_disk_structures.rs
@@ -0,0 +1,59 @@
+/* TODO: Write a derive(Endianness) macro */
+
+#[repr(C, packed)]
+#[derive(Default)]
+pub struct QCow2Header {
+    pub magic: u32,
+    pub version: u32,
+    pub backing_file_offset: u64,
+    pub backing_file_size: u32,
+    pub cluster_bits: u32,
+    pub size: u64,
+    pub crypt_method: u32,
+    pub l1_size: u32,
+    pub l1_table_offset: u64,
+    pub refcount_table_offset: u64,
+    pub refcount_table_clusters: u32,
+    pub nb_snapshots: u32,
+    pub snapshots_offset: u64,
+
+    pub incompatible_features: u64,
+    pub compatible_features: u64,
+    pub autoclear_features: u64,
+
+    pub refcount_order: u32,
+    pub header_length: u32,
+}
+
+
+impl QCow2Header {
+    pub fn from_be(&mut self)
+    {
+        self.magic                  = u32::from_be(self.magic);
+        self.version                = u32::from_be(self.version);
+
+        self.backing_file_offset    = u64::from_be(self.backing_file_offset);
+        self.backing_file_size      = u32::from_be(self.backing_file_size);
+
+        self.cluster_bits           = u32::from_be(self.cluster_bits);
+        self.size                   = u64::from_be(self.size);
+        self.crypt_method           = u32::from_be(self.crypt_method);
+
+        self.l1_size                = u32::from_be(self.l1_size);
+        self.l1_table_offset        = u64::from_be(self.l1_table_offset);
+
+        self.refcount_table_offset  = u64::from_be(self.refcount_table_offset);
+        self.refcount_table_clusters
+            = u32::from_be(self.refcount_table_clusters);
+
+        self.nb_snapshots           = u32::from_be(self.nb_snapshots);
+        self.snapshots_offset       = u64::from_be(self.snapshots_offset);
+
+        self.incompatible_features  = u64::from_be(self.incompatible_features);
+        self.compatible_features    = u64::from_be(self.compatible_features);
+        self.autoclear_features     = u64::from_be(self.autoclear_features);
+
+        self.refcount_order         = u32::from_be(self.refcount_order);
+        self.header_length          = u32::from_be(self.header_length);
+    }
+}
-- 
2.12.2
