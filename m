Received: from eggs.gnu.org ([2001:4830:134:3::10]:51356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw3xY-00060f-Dj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw3xW-000894-Ct
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:44:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw3xW-00088n-2w
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:44:06 -0400
Received: by mail-wr0-x244.google.com with SMTP id t20so9688425wra.2
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 02:44:05 -0700 (PDT)
Date: Thu, 6 Apr 2017 10:43:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406094359.GB21261@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20170331084147.32716-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] nvdimm: enable flush hint address
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
> This patch series constructs the flush hint address structures for
> nvdimm devices in QEMU.
>=20
> It's of course not for 2.9. I send it out early in order to get
> comments on one point I'm uncertain (see the detailed explanation
> below). Thanks for any comments in advance!
> Background
> ---------------

Extra background:

Flush Hint Addresses are necessary because:

1. Some hardware configurations may require them.  In other words, a
   cache flush instruction is not enough to persist data.

2. The host file system may need fsync(2) calls (e.g. to persist
   metadata changes).

Without Flush Hint Addresses only some NVDIMM configurations actually
guarantee data persistence.

> Flush hint address structure is a substructure of NFIT and specifies
> one or more addresses, namely Flush Hint Addresses. Software can write
> to any one of these flush hint addresses to cause any preceding writes
> to the NVDIMM region to be flushed out of the intervening platform
> buffers to the targeted NVDIMM. More details can be found in ACPI Spec
> 6.1, Section 5.2.25.8 "Flush Hint Address Structure".

Do you have performance data?  I'm concerned that Flush Hint Address
hardware interface is not virtualization-friendly.

In Linux drivers/nvdimm/region_devs.c:nvdimm_flush() does:

  wmb();
  for (i =3D 0; i < nd_region->ndr_mappings; i++)
      if (ndrd_get_flush_wpq(ndrd, i, 0))
          writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
  wmb();

That looks pretty lightweight - it's an MMIO write between write
barriers.

This patch implements the MMIO write like this:

  void nvdimm_flush(NVDIMMDevice *nvdimm)
  {
      if (nvdimm->backend_fd !=3D -1) {
          /*
           * If the backend store is a physical NVDIMM device, fsync()
           * will trigger the flush via the flush hint on the host device.
           */
          fsync(nvdimm->backend_fd);
      }
  }

The MMIO store instruction turned into a synchronous fsync(2) system
call plus vmexit/vmenter and QEMU userspace context switch:

1. The vcpu blocks during the fsync(2) system call.  The MMIO write
   instruction has an unexpected and huge latency.

2. The vcpu thread holds the QEMU global mutex so all other threads
   (including the monitor) are blocked during fsync(2).  Other vcpu
   threads may block if they vmexit.

It is hard to implement this efficiently in QEMU.  This is why I said
the hardware interface is not virtualization-friendly.  It's cheap on
real hardware but expensive under virtualization.

We should think about the optimal way of implementing Flush Hint
Addresses in QEMU.  But if there is no reasonable way to implement them
then I think it's better *not* to implement them, just like the Block
Window feature which is also not virtualization-friendly.  Users who
want a block device can use virtio-blk.  I don't think NVDIMM Block
Window can achieve better performance than virtio-blk under
virtualization (although I'm happy to be proven wrong).

Some ideas for a faster implementation:

1. Use memory_region_clear_global_locking() to avoid taking the QEMU
   global mutex.  Little synchronization is necessary as long as the
   NVDIMM device isn't hot unplugged (not yet supported anyway).

2. Can the host kernel provide a way to mmap Address Flush Hints from
   the physical NVDIMM in cases where the configuration does not require
   host kernel interception?  That way QEMU can map the physical
   NVDIMM's Address Flush Hints directly into the guest.  The hypervisor
   is bypassed and performance would be good.

I'm not sure there is anything we can do to make the case where the host
kernel wants an fsync(2) fast :(.

Benchmark results would be important for deciding how big the problem
is.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5g3fAAoJEJykq7OBq3PIOu8H/ihMPMr6npoTFk4xDBjFsNqr
6izxemNmiNWMkeN6vHNjOL4DbAfOYXFd9FsLRaSa1f7jCzxuoARo/IB5EW6Yq522
Rw7wHkVwTI51C6dlWa+p6V4xIspQpW0TPa3zrl7Ua751vinmhHMJqBogdus4EmNe
u7G3096TCFDGlIb3vhc7+ZNqUgP+fZNNeF8beM3jigDYsIP2FJ+A5XKJMgRnQjIZ
7kfbIHPv2xK6om0ShXHLR/2H5GXClEvGnhqi2KubnoGZXEeSOREPXKRDCJauoIFj
cs1qlR4Ii56Ph6MGEVG39KfdxdWra19FGh8C10kCJFNTxIEux/efUoK6kB/xT14=
=7sdk
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
