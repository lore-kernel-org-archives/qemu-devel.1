Received: from eggs.gnu.org ([209.51.188.92]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1grkhk-00009u-Qj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1grkhh-0006Pr-0C
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:31:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1grkhf-00069Z-5M
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:31:00 -0500
Date: Thu, 7 Feb 2019 09:30:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190207092914-mutt-send-email-mst@kernel.org>
References: <cover.1549473586.git.yi.z.zhang@linux.intel.com>
	<3497114cb20658d8b40837675dcac9c78c04a345.1549473586.git.yi.z.zhang@linux.intel.com>
	<20190206132538-mutt-send-email-mst@kernel.org>
	<20190207151604.GA56533@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207151604.GA56533@tiger-server>
Subject: Re: [Qemu-devel] [PATCH V12 5/5] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Thu, Feb 07, 2019 at 11:16:05PM +0800, Yi Zhang wrote:
> On 2019-02-06 at 13:29:37 -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 07, 2019 at 01:27:29AM +0800, Zhang, Yi wrote:
> > > From: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > 
> > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > ---
> > >  docs/nvdimm.txt | 25 ++++++++++++++++++++++---
> > >  qemu-options.hx |  4 ++++
> > >  2 files changed, 26 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > > index 5f158a6..e2bf89f 100644
> > > --- a/docs/nvdimm.txt
> > > +++ b/docs/nvdimm.txt
> > > @@ -143,9 +143,28 @@ Guest Data Persistence
> > >  ----------------------
> > >  
> > >  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > > -currently the only one that can guarantee the guest write persistence
> > > -is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> > > -which all guest access do not involve any host-side kernel cache.
> > > +the only backend that can guarantee the guest write persistence is:
> > > +
> > > +A. DAX device (e.g., /dev/dax0.0, ) or
> > > +B. DAX file(mounted with dax option)
> > > +
> > > +both are from the real NVDIMM device, all guest access do not
> > > +involve any host-side kernel cache.
> > 
> > I'm not sure - what do above 2 lines mean?
> > That cache must not be used if persistence is desired?
> same meaning of direct mapping of pmem, 
> Ah, Maybe better to change to:
> "both are backend from the real NVDIMM device, which supportting direct
> mapping of persistent memory." ?

Yes but typos aside it is still unclear - what is this? An extra
condition when persistence is guaranteed?


> > 
> > > +
> > > +When using B (A file supporting direct mapping of persistent memory)
> > > +as a backend, write persistence is guaranteed if the host kernel has
> > > +support for the MAP_SYNC flag in the mmap system call (available
> > > +since Linux 4.15 and on certain distro kernels) and additionally
> > > +both 'pmem' and 'share' flags are set to 'on' on the backend.
> > > +
> > > +If these conditions are not satisfied i.e. if either 'pmem' or 'share'
> > > +are not set, if the backend file does not support DAX or if MAP_SYNC
> > > +is not supported by the host kernel, write persistence is not
> > > +guaranteed after a system crash. For compatibility reasons, these
> > > +conditions are silently ignored if not satisfied. Currently, no way
> > > +is provided to test for them.
> > > +For more details, please reference mmap(2) man page:
> > > +http://man7.org/linux/man-pages/man2/mmap.2.html.
> > >  
> > >  When using other types of backends, it's suggested to set 'unarmed'
> > >  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 08f8516..0cd41f4 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
> > >  If @option{pmem} is set to 'on', QEMU will take necessary operations to
> > >  guarantee the persistence of its own writes to @option{mem-path}
> > >  (e.g. in vNVDIMM label emulation and live migration).
> > > +Also, we will map the backend-file with MAP_SYNC flag, which can ensure
> > 
> > should be
> > 	which ensures
> > 
> > > +the file metadata is in sync to @option{mem-path}
> > 
> > 
> > should be
> > 	for @option{mem-path}
> > 
> > > in case of host crash
> > > +or a power failure. MAP_SYNC requires support from both the host kernel
> > > +(since Linux kernel 4.15) and @option{mem-path}
> > 
> > 
> > should be
> > 	and the filesystem of @option{mem-path}
> Thanks, will update it.
> > 
> > > (only files supporting DAX).
> > >  
> > >  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
> > >  
> > > -- 
> > > 2.7.4
