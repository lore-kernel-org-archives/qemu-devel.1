Received: from eggs.gnu.org ([2001:4830:134:3::10]:49386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@gmail.com>) id 1d8wDm-0001wf-4T
	for qemu-devel@nongnu.org; Thu, 11 May 2017 18:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@gmail.com>) id 1d8wDk-0002DQ-65
	for qemu-devel@nongnu.org; Thu, 11 May 2017 18:06:06 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@gmail.com>)
	id 1d8wDj-0002D9-Qc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 18:06:04 -0400
Received: by mail-wm0-x234.google.com with SMTP id u65so1988146wmu.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:06:03 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
References: <1494431760-6455-1-git-send-email-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 May 2017 15:06:01 -0700
Message-ID: <CAA9_cmffgsC6cQwQRxHOmK00YEjpx22U6zjLYJUf+fZj6_orLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, qemu-devel@nongnu.org, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>

[ adding nvdimm mailing list ]

On Wed, May 10, 2017 at 8:56 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> We are sharing initial project proposal for
> 'KVM "fake DAX" device flushing' project for feedback.
> Got the idea during discussion with 'Rik van Riel'.
>
> Also, request answers to 'Questions' section.
>
> Abstract :
> ----------
> Project idea is to use fake persistent memory with direct
> access(DAX) in virtual machines. Overall goal of project
> is to increase the number of virtual machines that can be
> run on a physical machine, in order to increase the density
> of customer virtual machines.
>
> The idea is to avoid the guest page cache, and minimize the
> memory footprint of virtual machines. By presenting a disk
> image as a nvdimm direct access (DAX) memory region in a
> virtual machine, the guest OS can avoid using page cache
> memory for most file accesses.
>
> Problem Statement :
> ------------------
> * Guest uses page cache in memory to process fast requests
>   for disk read/write. This results in big memory footprint
>   of guests without host knowing much details of the guest
>   memory.
>
> * If guests use direct access(DAX) with fake persistent
>   storage, the host manages the page cache for guests,
>   allowing the host to easily reclaim/evict less frequently
>   used page cache pages without requiring guest cooperation,
>   like ballooning would.
>
> * Host manages guest cache as =E2=80=98mmaped=E2=80=99 disk image area in
>   qemu address space. This region is passed to guest as fake
>   persistent memory range. We need a new flushing interface
>   to flush this cache to secondary storage to persist guest
>   writes.
>
> * New asynchronous flushing interface will allow guests to
>   cause the host flush the dirty data to backup storage file.
>   Systems with pmem storage make use of CLFLUSH instruction
>   to flush single cache line to persistent storage and it
>   takes care of flushing. With fake persistent storage in
>   guest we cannot depend on CLFLUSH instruction to flush entire
>   dirty cache to backing storage. Even If we trap and emulate
>   CLFLUSH instruction guest vCPU has to wait till we flush all
>   the dirty memory. Instead of this we need to implement a new
>   asynchronous guest flushing interface, which allows the guest
>   to specify a larger range to be flushed at once, and allows
>   the vCPU to run something else while the data is being synced
>   to disk.
>
> * New flushing interface will consists of a para virt driver to
>   new fake nvdimm like device which will process guest flushing
>   requests like fsync/msync etc instead of pmem library calls
>   like clflush. The corresponding device at host side will be
>   responsible for flushing requests for guest dirty pages.
>   Guest can put current task in sleep and vCPU can run any other
>   task while host side flushing of guests pages is in progress.
>
> Host controlled fake nvdimm DAX to avoid guest page cache :
> -------------------------------------------------------------
> * Bypass guest page cache by using a fake persistent storage
>   like nvdimm & DAX. Guest Read/Write is directly done on
>   fake persistent storage without involving guest kernel for
>   caching data.
>
> * Fake nvdimm device passed to guest is backed by a regular
>   file in host stored in secondary storage.
>
> * Qemu has implementation of fake NVDIMM/DAX device. Use this
>   capability of passing regular host file(disk) as nvdimm device
>   to guest.
>
> * Nvdimm with DAX works for ext4/xfs filesystem. Supported
>   filesystem should be DAX compatible.
>
> * As we are using guest disk as fake DAX/NVDIMM device, we
>   need a mechanism for persistence of data backed on regular
>   host storage file.
>
> * For live migration use case, if host side backing file is
>   shared storage, we need to flush the page cache for the disk
>   image at the destination (new fadvise interface, FADV_INVALIDATE_CACHE?=
)
>   before starting execution of the guest on the destination host.
>
> Design :
> ---------
> * In order to not have page cache inside the guest, qemu would:
>
>  1) mmap the guest's disk image and present that disk image to
>     the guest as a persistent memory range.
>
>  2) Present information to the guest telling it that the persistent
>     memory range is not physical persistent memory.
>
>  3) Present an additional paravirt device alongside the persistent
>     memory range, that can be used to sync (ranges of) data to disk.
>
> * Guest would use the disk image mostly like a persistent memory
>   device, with two exceptions:
>
>   1) It would not tell userspace that the files on that device are
>      persistent memory. This is  done so userspace knows to call
>      fsync/msync, instead of the pmem clflush library call.

There are no (safe) pmem applications today that can get by without
calling fsync/msync after an mmap write to a file on ext4 or xfs.
We're trying to fix that, more details below.

>   2) When userspace calls fsync/msync on files on the fake persistent
>      memory device, issue a request through the paravirt device that
>      causes the host to flush the device back end.

We need this in general for the persistent memory use case. There has
been proposals about using the "flush hint" addresses as defined by
ACPI 6, but those are awkward because it's not a queued interface and
they are not defined to be part of the persistence path, so
applications may be written to not trigger a "deep flush". Device-DAX
is an interface that bypasses the flush hint mechanism by default.

>
> * Guest uses fake persistent storage data updates can be still in
>   qemu memory. We need a way to flush cached data in host to backed
>   secondary storage.
>
> * Once the guest receives a completion event from the host, it will
>   allow userspace programs that were waiting on the fsync/msync to
>   continue running.
>
> * Host is responsible for paging in pages in host backing area for
>   guest persistent memory as they are accessed by the guest, and
>   for evicting pages as host memory fills up.
>
> Questions :
> -----------
> * What should the flushing interface between guest and host look
>   like?

I'm very interested in this because we have another need for a new
flushing interface to support passing DAX capable memory ranges
through to the guest in the general case.  Some of the background is
here:

    https://www.mail-archive.com/qemu-devel@nongnu.org/msg444473.html

...but we need an interface to implement lightweight flushing of data
updates to persistence for applications that want to use persist
updates to data structures on a frequent basis, think a persistent
btree. This new flush interface needs a host side implementation, but
also a way for guests to know when a guest-fsync needs to trigger
host-fsync.


>
> * Any suggestions to hook the IO caching code with KVM/Qemu or
>   thoughts on how we should do it?
>
> * Thinking of implementing a guest para virt driver which will send
>   guest requests to Qemu to flush data to disk. Not sure at this
>   point how to tell userspace to work on this device as any regular
>   device without considering it as persistent device. Any suggestions
>   on this?
>
> * Not thought yet about ballooning impact. But feel this solution
>   could be better than ballooning in long term? As we will be
>   managing all guests cache from host side.
>
> * Not sure this solution works for ARM and other architectures and
>   Windows?
>
