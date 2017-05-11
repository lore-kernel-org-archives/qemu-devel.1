Received: from eggs.gnu.org ([2001:4830:134:3::10]:50244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d8seE-0008G9-UU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d8se9-0002AK-VK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d8se9-00028o-M3
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:17:05 -0400
Date: Thu, 11 May 2017 14:17:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170511181703.GC8701@stefanha-x1.localdomain>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, riel@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
> We are sharing initial project proposal for=20
> 'KVM "fake DAX" device flushing' project for feedback.=20
> Got the idea during discussion with 'Rik van Riel'.=20

CCing NVDIMM folks.

>=20
> Also, request answers to 'Questions' section.
>=20
> Abstract :=20
> ----------
> Project idea is to use fake persistent memory with direct=20
> access(DAX) in virtual machines. Overall goal of project=20
> is to increase the number of virtual machines that can be=20
> run on a physical machine, in order to increase the density=20
> of customer virtual machines.
>=20
> The idea is to avoid the guest page cache, and minimize the=20
> memory footprint of virtual machines. By presenting a disk=20
> image as a nvdimm direct access (DAX) memory region in a=20
> virtual machine, the guest OS can avoid using page cache=20
> memory for most file accesses.
>=20
> Problem Statement :
> ------------------
> * Guest uses page cache in memory to process fast requests=20
>   for disk read/write. This results in big memory footprint=20
>   of guests without host knowing much details of the guest=20
>   memory.=20
>=20
> * If guests use direct access(DAX) with fake persistent=20
>   storage, the host manages the page cache for guests,=20
>   allowing the host to easily reclaim/evict less frequently=20
>   used page cache pages without requiring guest cooperation,=20
>   like ballooning would.
>=20
> * Host manages guest cache as =E2=80=98mmaped=E2=80=99 disk image area in=
=20
>   qemu address space. This region is passed to guest as fake=20
>   persistent memory range. We need a new flushing interface=20
>   to flush this cache to secondary storage to persist guest=20
>   writes.
>=20
> * New asynchronous flushing interface will allow guests to=20
>   cause the host flush the dirty data to backup storage file.=20
>   Systems with pmem storage make use of CLFLUSH instruction=20
>   to flush single cache line to persistent storage and it=20
>   takes care of flushing. With fake persistent storage in=20
>   guest we cannot depend on CLFLUSH instruction to flush entire=20
>   dirty cache to backing storage. Even If we trap and emulate=20
>   CLFLUSH instruction guest vCPU has to wait till we flush all=20
>   the dirty memory. Instead of this we need to implement a new=20
>   asynchronous guest flushing interface, which allows the guest=20
>   to specify a larger range to be flushed at once, and allows=20
>   the vCPU to run something else while the data is being synced=20
>   to disk.=20
>=20
> * New flushing interface will consists of a para virt driver to=20
>   new fake nvdimm like device which will process guest flushing
>   requests like fsync/msync etc instead of pmem library calls=20
>   like clflush. The corresponding device at host side will be=20
>   responsible for flushing requests for guest dirty pages.=20
>   Guest can put current task in sleep and vCPU can run any other=20
>   task while host side flushing of guests pages is in progress.
>=20
> Host controlled fake nvdimm DAX to avoid guest page cache :
> -------------------------------------------------------------
> * Bypass guest page cache by using a fake persistent storage=20
>   like nvdimm & DAX. Guest Read/Write is directly done on=20
>   fake persistent storage without involving guest kernel for=20
>   caching data.
>=20
> * Fake nvdimm device passed to guest is backed by a regular=20
>   file in host stored in secondary storage.
>=20
> * Qemu has implementation of fake NVDIMM/DAX device. Use this=20
>   capability of passing regular host file(disk) as nvdimm device=20
>   to guest.
>=20
> * Nvdimm with DAX works for ext4/xfs filesystem. Supported=20
>   filesystem should be DAX compatible.=20
>=20
> * As we are using guest disk as fake DAX/NVDIMM device, we=20
>   need a mechanism for persistence of data backed on regular=20
>   host storage file.
>=20
> * For live migration use case, if host side backing file is=20
>   shared storage, we need to flush the page cache for the disk=20
>   image at the destination (new fadvise interface, FADV_INVALIDATE_CACHE?=
)=20
>   before starting execution of the guest on the destination host.

Good point.  QEMU currently only supports live migration with O_DIRECT.
I think the problem was that userspace cannot guarantee consistency in
the general case.  If you find a solution to this problem for fake
NVDIMM then maybe the QEMU block layer can also begin supporting live
migration with buffered I/O.

>=20
> Design :
> ---------
> * In order to not have page cache inside the guest, qemu would:
>=20
>  1) mmap the guest's disk image and present that disk image to=20
>     the guest as a persistent memory range.
>=20
>  2) Present information to the guest telling it that the persistent=20
>     memory range is not physical persistent memory.

Steps 1 & 2 are already supported by QEMU NVDIMM emulation today.

>  3) Present an additional paravirt device alongside the persistent=20
>     memory range, that can be used to sync (ranges of) data to disk.
>=20
> * Guest would use the disk image mostly like a persistent memory=20
>   device, with two exceptions:
>=20
>   1) It would not tell userspace that the files on that device are=20
>      persistent memory. This is  done so userspace knows to call=20
>      fsync/msync, instead of the pmem clflush library call.

Not sure I agree with hiding the nvdimm nature of the device.  Instead I
think you need to build this capability into the Linux nvdimm code.
libpmem will detect these types of devices and issue fsync/msync when
the application wants to flush.

>   2) When userspace calls fsync/msync on files on the fake persistent=20
>      memory device, issue a request through the paravirt device that=20
>      causes the host to flush the device back end.
>=20
> * Guest uses fake persistent storage data updates can be still in=20
>   qemu memory. We need a way to flush cached data in host to backed=20

s/qemu memory/host memory/

I guess you mean that host userspace needs a way to reliably flush an
address range to the underlying storage.

>   secondary storage.
>=20
> * Once the guest receives a completion event from the host, it will=20
>   allow userspace programs that were waiting on the fsync/msync to=20
>   continue running.
>=20
> * Host is responsible for paging in pages in host backing area for=20
>   guest persistent memory as they are accessed by the guest, and=20
>   for evicting pages as host memory fills up.
>=20
> Questions :
> -----------
> * What should the flushing interface between guest and host look=20
>   like?

A simple hack for prototyping is to instantiate an virtio-blk-pci for
the mmapped host file.  The guest can send flush commands on the
virtio-blk-pci device but will otherwise use the mapped memory directly.

> * Any suggestions to hook the IO caching code with KVM/Qemu or=20
>   thoughts on how we should do it?=20
>=20
> * Thinking of implementing a guest para virt driver which will send=20
>   guest requests to Qemu to flush data to disk. Not sure at this=20
>   point how to tell userspace to work on this device as any regular
>   device without considering it as persistent device. Any suggestions
>   on this?
>=20
> * Not thought yet about ballooning impact. But feel this solution=20
>   could be better than ballooning in long term? As we will be=20
>   managing all guests cache from host side.
>=20
> * Not sure this solution works for ARM and other architectures and=20
>   Windows?=20

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFKqfAAoJEJykq7OBq3PI22sH/1c4SnPOfz/6lk/XzWkpBZWz
H6c0ix5OXPRKAfPhhTX6HkSqt7VF8bP90uvu6z5b+cPJFIRCr+NpaiDFBDVXDz0c
9v/nFYMG8l1571W7xnczy+apJjrB60t4bD2FPCRFDiwLvahcWqRsMStkNA3B1TH5
bzJSMtOVl5/lmLiPfU72heB6C7bDsItLksTDk4WO8+toPZ1394gxiAFSzrDOEqPj
muHii3bgiV3C5iCcijYzfrsnBpirUoMdwG5KchN1gAhPpl3V6JX1eKyjaZca+r4v
tc8n6/eFzrejMz2yhsLZ+glH1zsO/ul9yVWdEvfRrggUJWX3PfdJXDZGr+6Wa+E=
=MvN4
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
