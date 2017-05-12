Received: from eggs.gnu.org ([2001:4830:134:3::10]:48881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1d94Uy-0000Qm-CO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1d94Ut-0000U5-GK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:56:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1d94Ut-0000Sw-6a
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:56:19 -0400
Date: Fri, 12 May 2017 02:56:14 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <459420445.7146183.1494572174539.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170511181703.GC8701@stefanha-x1.localdomain>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
	<20170511181703.GC8701@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM "fake DAX" device flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kwolf@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, Dan Williams <dan.j.williams@intel.com>


>=20
> On Wed, May 10, 2017 at 09:26:00PM +0530, Pankaj Gupta wrote:
> > We are sharing initial project proposal for
> > 'KVM "fake DAX" device flushing' project for feedback.
> > Got the idea during discussion with 'Rik van Riel'.
>=20
> CCing NVDIMM folks.
>=20
> >=20
> > Also, request answers to 'Questions' section.
> >=20
> > Abstract :
> > ----------
> > Project idea is to use fake persistent memory with direct
> > access(DAX) in virtual machines. Overall goal of project
> > is to increase the number of virtual machines that can be
> > run on a physical machine, in order to increase the density
> > of customer virtual machines.
> >=20
> > The idea is to avoid the guest page cache, and minimize the
> > memory footprint of virtual machines. By presenting a disk
> > image as a nvdimm direct access (DAX) memory region in a
> > virtual machine, the guest OS can avoid using page cache
> > memory for most file accesses.
> >=20
> > Problem Statement :
> > ------------------
> > * Guest uses page cache in memory to process fast requests
> >   for disk read/write. This results in big memory footprint
> >   of guests without host knowing much details of the guest
> >   memory.
> >=20
> > * If guests use direct access(DAX) with fake persistent
> >   storage, the host manages the page cache for guests,
> >   allowing the host to easily reclaim/evict less frequently
> >   used page cache pages without requiring guest cooperation,
> >   like ballooning would.
> >=20
> > * Host manages guest cache as =E2=80=98mmaped=E2=80=99 disk image area =
in
> >   qemu address space. This region is passed to guest as fake
> >   persistent memory range. We need a new flushing interface
> >   to flush this cache to secondary storage to persist guest
> >   writes.
> >=20
> > * New asynchronous flushing interface will allow guests to
> >   cause the host flush the dirty data to backup storage file.
> >   Systems with pmem storage make use of CLFLUSH instruction
> >   to flush single cache line to persistent storage and it
> >   takes care of flushing. With fake persistent storage in
> >   guest we cannot depend on CLFLUSH instruction to flush entire
> >   dirty cache to backing storage. Even If we trap and emulate
> >   CLFLUSH instruction guest vCPU has to wait till we flush all
> >   the dirty memory. Instead of this we need to implement a new
> >   asynchronous guest flushing interface, which allows the guest
> >   to specify a larger range to be flushed at once, and allows
> >   the vCPU to run something else while the data is being synced
> >   to disk.
> >=20
> > * New flushing interface will consists of a para virt driver to
> >   new fake nvdimm like device which will process guest flushing
> >   requests like fsync/msync etc instead of pmem library calls
> >   like clflush. The corresponding device at host side will be
> >   responsible for flushing requests for guest dirty pages.
> >   Guest can put current task in sleep and vCPU can run any other
> >   task while host side flushing of guests pages is in progress.
> >=20
> > Host controlled fake nvdimm DAX to avoid guest page cache :
> > -------------------------------------------------------------
> > * Bypass guest page cache by using a fake persistent storage
> >   like nvdimm & DAX. Guest Read/Write is directly done on
> >   fake persistent storage without involving guest kernel for
> >   caching data.
> >=20
> > * Fake nvdimm device passed to guest is backed by a regular
> >   file in host stored in secondary storage.
> >=20
> > * Qemu has implementation of fake NVDIMM/DAX device. Use this
> >   capability of passing regular host file(disk) as nvdimm device
> >   to guest.
> >=20
> > * Nvdimm with DAX works for ext4/xfs filesystem. Supported
> >   filesystem should be DAX compatible.
> >=20
> > * As we are using guest disk as fake DAX/NVDIMM device, we
> >   need a mechanism for persistence of data backed on regular
> >   host storage file.
> >=20
> > * For live migration use case, if host side backing file is
> >   shared storage, we need to flush the page cache for the disk
> >   image at the destination (new fadvise interface, FADV_INVALIDATE_CACH=
E?)
> >   before starting execution of the guest on the destination host.
>=20
> Good point.  QEMU currently only supports live migration with O_DIRECT.
> I think the problem was that userspace cannot guarantee consistency in
> the general case.  If you find a solution to this problem for fake
> NVDIMM then maybe the QEMU block layer can also begin supporting live
> migration with buffered I/O.
>=20
> >=20
> > Design :
> > ---------
> > * In order to not have page cache inside the guest, qemu would:
> >=20
> >  1) mmap the guest's disk image and present that disk image to
> >     the guest as a persistent memory range.
> >=20
> >  2) Present information to the guest telling it that the persistent
> >     memory range is not physical persistent memory.
>=20
> Steps 1 & 2 are already supported by QEMU NVDIMM emulation today.

Yes. I have also tested guest 'fake DAX' device using QEMU NVDIMM emulation=
.
>=20
> >  3) Present an additional paravirt device alongside the persistent
> >     memory range, that can be used to sync (ranges of) data to disk.
> >=20
> > * Guest would use the disk image mostly like a persistent memory
> >   device, with two exceptions:
> >=20
> >   1) It would not tell userspace that the files on that device are
> >      persistent memory. This is  done so userspace knows to call
> >      fsync/msync, instead of the pmem clflush library call.
>=20
> Not sure I agree with hiding the nvdimm nature of the device.  Instead I
> think you need to build this capability into the Linux nvdimm code.
> libpmem will detect these types of devices and issue fsync/msync when
> the application wants to flush.
>=20
> >   2) When userspace calls fsync/msync on files on the fake persistent
> >      memory device, issue a request through the paravirt device that
> >      causes the host to flush the device back end.
> >=20
> > * Guest uses fake persistent storage data updates can be still in
> >   qemu memory. We need a way to flush cached data in host to backed
>=20
> s/qemu memory/host memory/
>=20
> I guess you mean that host userspace needs a way to reliably flush an
> address range to the underlying storage.

right.
>=20
> >   secondary storage.
> >=20
> > * Once the guest receives a completion event from the host, it will
> >   allow userspace programs that were waiting on the fsync/msync to
> >   continue running.
> >=20
> > * Host is responsible for paging in pages in host backing area for
> >   guest persistent memory as they are accessed by the guest, and
> >   for evicting pages as host memory fills up.
> >=20
> > Questions :
> > -----------
> > * What should the flushing interface between guest and host look
> >   like?
>=20
> A simple hack for prototyping is to instantiate an virtio-blk-pci for
> the mmapped host file.  The guest can send flush commands on the
> virtio-blk-pci device but will otherwise use the mapped memory directly.

okay. I will check this.
>=20
> > * Any suggestions to hook the IO caching code with KVM/Qemu or
> >   thoughts on how we should do it?
> >=20
> > * Thinking of implementing a guest para virt driver which will send
> >   guest requests to Qemu to flush data to disk. Not sure at this
> >   point how to tell userspace to work on this device as any regular
> >   device without considering it as persistent device. Any suggestions
> >   on this?
> >=20
> > * Not thought yet about ballooning impact. But feel this solution
> >   could be better than ballooning in long term? As we will be
> >   managing all guests cache from host side.
> >=20
> > * Not sure this solution works for ARM and other architectures and
> >   Windows?
>=20
