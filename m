Received: from eggs.gnu.org ([209.51.188.92]:58592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gofx6-0001pF-9N
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gofx5-0007dC-09
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:50:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:44694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gofx4-0007Xf-HG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:50:10 -0500
Date: Wed, 30 Jan 2019 19:20:45 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20190130112045.GC53874@tiger-server>
References: <cover.1548771590.git.yi.z.zhang@linux.intel.com>
	<4f91d5a46fc26d5672c91d80b78e986d4267c612.1548771590.git.yi.z.zhang@linux.intel.com>
	<20190129085131-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129085131-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v11 3/3] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On 2019-01-29 at 09:09:54 -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 29, 2019 at 10:49:18PM +0800, Zhang, Yi wrote:
> > From: Zhang Yi <yi.z.zhang@linux.intel.com>
> > 
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > ---
> >  docs/nvdimm.txt | 29 ++++++++++++++++++++++++++++-
> >  qemu-options.hx |  4 ++++
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > index 5f158a6..9da96aa 100644
> > --- a/docs/nvdimm.txt
> > +++ b/docs/nvdimm.txt
> > @@ -142,11 +142,38 @@ backend of vNVDIMM:
> >  Guest Data Persistence
> >  ----------------------
> >  
> > +vNVDIMM is designed and implemented to guarantee the guest data
> > +persistence on the backends in case of host crash or a power failures.
> > +However, there are still some requirements and limitations
> > +as explained below.
> > +
> 
> I'd just drop the above paragraph.
> 
> >  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > -currently the only one that can guarantee the guest write persistence
> > +if MAP_SYNC is not supported by the host kernel and the backends,
> > +the only backend that can guarantee the guest write persistence
> >  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> >  which all guest access do not involve any host-side kernel cache.
> >  
> > +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> > +systems, QEMU can mmap(2) the dax backend files with MAP_SYNC, which
> > +ensures filesystem metadata consistency in case of a host crash or a power
> > +failure. Enabling MAP_SYNC in QEMU requires below conditions
> > +
> > + - 'pmem' option of memory-backend-file is 'on':
> > +   The backend is a file supporting DAX, e.g., a file on an ext4 or
> > +   xfs file system mounted with '-o dax'. if your pmem=on ,but the backend is
> > +   not a file supporting DAX, mapping with this flag results in an EOPNOTSUPP
> > +   warning. then MAP_SYNC will be ignored
> > +
> > + - 'share' option of memory-backend-file is 'on':
> > +   MAP_SYNC flag available only with the MAP_SHARED_VALIDATE mapping type.
> > +
> > + - 'MAP_SYNC' is supported on linux kernel.(default opened since Linux 4.15)
> > +
> > +Otherwise, We will ignore the MAP_SYNC flag.
> > +
> > +For more details, please reference mmap(2) man page:
> > +http://man7.org/linux/man-pages/man2/mmap.2.html.
> > +
> 
> 
> OK above is too low level so it doesn't really help anyone. Instead
> it describes code internals and will quickly get out of sync
> (pun intended). Let's look at the manpage:
> 
> 	Shared file mappings with this flag provide the guarantee that
>               while some memory is writably mapped in the address space of
>               the process, it will be visible in the same file at the same
>               offset even after the system crashes or is rebooted.  In con‐
>               junction with the use of appropriate CPU instructions, this
>               provides users of such mappings with a more efficient way of
>               making data modifications persistent.
> 
> OK this is more readable. We already have:
> 
> 	Though QEMU supports multiple types of vNVDIMM backends on Linux,
> 	the only backend that can guarantee the guest write persistence
> 	is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> 	which all guest access do not involve any host-side kernel cache.
> 
> Let's add:
> 
> When using a file supporting DAX (direct mapping of persistent memory)
> as a backend, write persistence is guaranteed if the host kernel
> has support for the MAP_SYNC flag in the mmap system call
> (available since Linux 4.15 and on certain distro kernels)
> and additionally both 'pmem' and 'share' flags are set to 'on'
> on the backend.
> 
> If these conditions are not satisfied i.e. if either 'pmem' or 'share'
> are not set, if the backend file does not support DAX
> or if MAP_SYNC is not supported by the host kernel, write
> persistence is not guaranteed after a system crash.
> For compatibility reasons, these conditions are silently ignored if not
> satisfied. Currently, no way is provided to test for them.
Much better than me, thank you very much, Michael. I will add that.
> 
> 
> >  When using other types of backends, it's suggested to set 'unarmed'
> >  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> >  guest NVDIMM region mapping structure.  This unarmed flag indicates
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 08f8516..0cd41f4 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
> >  If @option{pmem} is set to 'on', QEMU will take necessary operations to
> >  guarantee the persistence of its own writes to @option{mem-path}
> >  (e.g. in vNVDIMM label emulation and live migration).
> > +Also, we will map the backend-file with MAP_SYNC flag, which can ensure
> > +the file metadata is in sync to @option{mem-path} in case of host crash
> > +or a power failure. MAP_SYNC requires support from both the host kernel
> > +(since Linux kernel 4.15) and @option{mem-path} (only files supporting DAX).
> >  
> >  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
> >  
> > -- 
> > 2.7.4
