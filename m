Received: from eggs.gnu.org ([2001:4830:134:3::10]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0QAX-0004Z1-Sq
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0QAS-0004pF-U1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:15:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0QAS-0004oq-Ki
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:15:28 -0400
Received: by mail-wr0-x242.google.com with SMTP id l44so24002808wrc.2
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 03:15:28 -0700 (PDT)
Date: Tue, 18 Apr 2017 11:15:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418101524.GG21261@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170406094359.GB21261@stefanha-x1.localdomain>
	<20170411063426.5fmxyuglhqk7qo3k@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <20170411063426.5fmxyuglhqk7qo3k@hz-desktop>
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
To: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 02:34:26PM +0800, Haozhong Zhang wrote:
> On 04/06/17 10:43 +0100, Stefan Hajnoczi wrote:
> > On Fri, Mar 31, 2017 at 04:41:43PM +0800, Haozhong Zhang wrote:
> > > This patch series constructs the flush hint address structures for
> > > nvdimm devices in QEMU.
> > >=20
> > > It's of course not for 2.9. I send it out early in order to get
> > > comments on one point I'm uncertain (see the detailed explanation
> > > below). Thanks for any comments in advance!
> > > Background
> > > ---------------
> >=20
> > Extra background:
> >=20
> > Flush Hint Addresses are necessary because:
> >=20
> > 1. Some hardware configurations may require them.  In other words, a
> >    cache flush instruction is not enough to persist data.
> >=20
> > 2. The host file system may need fsync(2) calls (e.g. to persist
> >    metadata changes).
> >=20
> > Without Flush Hint Addresses only some NVDIMM configurations actually
> > guarantee data persistence.
> >=20
> > > Flush hint address structure is a substructure of NFIT and specifies
> > > one or more addresses, namely Flush Hint Addresses. Software can write
> > > to any one of these flush hint addresses to cause any preceding writes
> > > to the NVDIMM region to be flushed out of the intervening platform
> > > buffers to the targeted NVDIMM. More details can be found in ACPI Spec
> > > 6.1, Section 5.2.25.8 "Flush Hint Address Structure".
> >=20
> > Do you have performance data?  I'm concerned that Flush Hint Address
> > hardware interface is not virtualization-friendly.
>=20
> Some performance data below.
>=20
> Host HW config:
>   CPU: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz x 2 sockets w/ HT enabled
>   MEM: 64 GB
>=20
>   As I don't have NVDIMM hardware, so I use files in ext4 fs on a
>   normal SATA SSD as the back storage of vNVDIMM.
>=20
>=20
> Host SW config:
>   Kernel: 4.10.1
>   QEMU: commit ea2afcf with this patch series applied.
>=20
>=20
> Guest config:
>   For flush hint enabled case, the following QEMU options are used
>     -enable-kvm -smp 4 -cpu host -machine pc,nvdimm \
>     -m 4G,slots=3D4,maxmem=3D128G \
>     -object memory-backend-file,id=3Dmem1,share,mem-path=3Dnvm-img,size=
=3D8G \
>     -device nvdimm,id=3Dnv1,memdev=3Dmem1,reserved-size=3D4K,flush-hint \
>     -hda GUEST_DISK_IMG -serial pty
>=20
>   For flush hint disabled case, the following QEMU options are used
>     -enable-kvm -smp 4 -cpu host -machine pc,nvdimm \
>     -m 4G,slots=3D4,maxmem=3D128G \
>     -object memory-backend-file,id=3Dmem1,share,mem-path=3Dnvm-img,size=
=3D8G \
>     -device nvdimm,id=3Dnv1,memdev=3Dmem1 \
>     -hda GUEST_DISK_IMG -serial pty
>=20
>   nvm-img used above is created in ext4 fs on the host SSD by
>     dd if=3D/dev/zero of=3Dnvm-img bs=3D1G count=3D8
>=20
>   Guest kernel: 4.11.0-rc4
>=20
>=20
> Benchmark in guest:
>   mkfs.ext4 /dev/pmem0
>   mount -o dax /dev/pmem0 /mnt
>   dd if=3D/dev/zero of=3D/mnt/data bs=3D1G count=3D7 # warm up EPT mapping
>   rm /mnt/data                               #
>   dd if=3D/dev/zero of=3D/mnt/data bs=3D1G count=3D7
>=20
>   and record the write speed reported by the last 'dd' command.
>=20
>=20
> Result:
>   - Flush hint disabled
>     Vary from 161 MB/s to 708 MB/s, depending on how many fs/device
>     flush operations are performed on the host side during the guest
>     'dd'.
>=20
>   - Flush hint enabled
>  =20
>     Vary from 164 MB/s to 546 MB/s, depending on how long fsync() in
>     QEMU takes. Usually, there is at least one fsync() during one 'dd'
>     command that takes several seconds (the worst one takes 39 s).
>=20
>     To be worse, during those long host-side fsync() operations, guest
>     kernel complained stalls.

I'm surprised that maximum throughput was 708 MB/s.  The guest is
DAX-aware and the write(2) syscall is a memcpy.  I expected higher
numbers without flush hints.

Also strange that throughput varied so greatly.  A benchmark that varies
4x is not useful since it's hard to tell if anything <4x indicates a
significant performance difference.  In other words, the noise is huge!

What results do you get on the host?

Dan: Any comments on this benchmark and is there a recommended way to
benchmark NVDIMM?

> Some thoughts:
>=20
> - If the non-NVDIMM hardware is used as the back store of vNVDIMM,
>   QEMU may perform the host-side flush operations asynchronously with
>   VM, which will not block VM too long but sacrifice the durability
>   guarantee.
>=20
> - If physical NVDIMM is used as the back store and ADR is supported on
>   the host, QEMU can rely on ADR to guarantee the data durability and
>   will not need to emulate flush hint for guest.
>=20
> - If physical NVDIMM is used as the back store and ADR is not
>   supported on the host, QEMU will still need to emulate flush hint
>   for guest and need to use a fast approach other than fsync() to
>   trigger writes to host flush hint.
>=20
>   Could kernel expose an interface to allow the userland (i.e. QEMU in
>   this case) to directly write to the flush hint of a NVDIMM region?
>=20
>=20
> Haozhong
>=20
> >=20
> > In Linux drivers/nvdimm/region_devs.c:nvdimm_flush() does:
> >=20
> >   wmb();
> >   for (i =3D 0; i < nd_region->ndr_mappings; i++)
> >       if (ndrd_get_flush_wpq(ndrd, i, 0))
> >           writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
> >   wmb();
> >=20
> > That looks pretty lightweight - it's an MMIO write between write
> > barriers.
> >=20
> > This patch implements the MMIO write like this:
> >=20
> >   void nvdimm_flush(NVDIMMDevice *nvdimm)
> >   {
> >       if (nvdimm->backend_fd !=3D -1) {
> >           /*
> >            * If the backend store is a physical NVDIMM device, fsync()
> >            * will trigger the flush via the flush hint on the host devi=
ce.
> >            */
> >           fsync(nvdimm->backend_fd);
> >       }
> >   }
> >=20
> > The MMIO store instruction turned into a synchronous fsync(2) system
> > call plus vmexit/vmenter and QEMU userspace context switch:
> >=20
> > 1. The vcpu blocks during the fsync(2) system call.  The MMIO write
> >    instruction has an unexpected and huge latency.
> >=20
> > 2. The vcpu thread holds the QEMU global mutex so all other threads
> >    (including the monitor) are blocked during fsync(2).  Other vcpu
> >    threads may block if they vmexit.
> >=20
> > It is hard to implement this efficiently in QEMU.  This is why I said
> > the hardware interface is not virtualization-friendly.  It's cheap on
> > real hardware but expensive under virtualization.
> >=20
> > We should think about the optimal way of implementing Flush Hint
> > Addresses in QEMU.  But if there is no reasonable way to implement them
> > then I think it's better *not* to implement them, just like the Block
> > Window feature which is also not virtualization-friendly.  Users who
> > want a block device can use virtio-blk.  I don't think NVDIMM Block
> > Window can achieve better performance than virtio-blk under
> > virtualization (although I'm happy to be proven wrong).
> >=20
> > Some ideas for a faster implementation:
> >=20
> > 1. Use memory_region_clear_global_locking() to avoid taking the QEMU
> >    global mutex.  Little synchronization is necessary as long as the
> >    NVDIMM device isn't hot unplugged (not yet supported anyway).
> >=20
> > 2. Can the host kernel provide a way to mmap Address Flush Hints from
> >    the physical NVDIMM in cases where the configuration does not require
> >    host kernel interception?  That way QEMU can map the physical
> >    NVDIMM's Address Flush Hints directly into the guest.  The hypervisor
> >    is bypassed and performance would be good.
> >=20
> > I'm not sure there is anything we can do to make the case where the host
> > kernel wants an fsync(2) fast :(.
> >=20
> > Benchmark results would be important for deciding how big the problem
> > is.
>=20
>=20

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9ec8AAoJEJykq7OBq3PInMUIAIwk6v61xKT72vPDQlipbrNG
WfPCObHBugvhwpfikXnINcVcDLJLyYAhhEt+37vPadqdF2SS7FElA44hB1nD4m7e
DJNFDnftQRJLlYLh+ldRkgmbqqVpaMEuv5R70Lk5BCwAAcuqCRuQ6MyBmr8TEm/6
7rL49EjCiK0qPH3yAPpm6iS6osZ8HmZyzli8jRr9GrrdqBoksu/Tw4sJFotJG8pi
IBY0Xl1n/Ktsb6cyDeIAXb8tGGA6M67k3TP6HOkoh5Y3yGB/AHwH+S/ms94NHRah
dqU442zIK3tZ/qXhqpX/kHN8+IenaeWEwjJapEq7Cnm/PTMg210gEGYAnEnBbx8=
=q9op
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
