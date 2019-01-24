Received: from eggs.gnu.org ([209.51.188.92]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmj4n-0008N2-Rx
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmj4m-0001Iq-3r
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gmj4l-0001I1-Qw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:46:04 -0500
Date: Thu, 24 Jan 2019 12:45:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190124123824-mutt-send-email-mst@kernel.org>
References: <cover.1548136274.git.yi.z.zhang@linux.intel.com>
	<78014185dc40dea43750eaa50ae093806e3dab66.1548136274.git.yi.z.zhang@linux.intel.com>
	<20190123145050.GU4136@habkost.net>
	<20190124112102.GA9821@tiger-server>
	<20190124165926.GY4136@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124165926.GY4136@habkost.net>
Subject: Re: [Qemu-devel] [PATCH V10 4/4] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Thu, Jan 24, 2019 at 02:59:26PM -0200, Eduardo Habkost wrote:
> On Thu, Jan 24, 2019 at 07:21:03PM +0800, Yi Zhang wrote:
> > On 2019-01-23 at 12:50:50 -0200, Eduardo Habkost wrote:
> > > On Wed, Jan 23, 2019 at 11:00:02AM +0800, Zhang, Yi wrote:
> > > > From: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > > 
> > > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > > ---
> > > >  docs/nvdimm.txt | 29 ++++++++++++++++++++++++++++-
> > > >  qemu-options.hx |  4 ++++
> > > >  2 files changed, 32 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > > > index 5f158a6..166c395 100644
> > > > --- a/docs/nvdimm.txt
> > > > +++ b/docs/nvdimm.txt
> > > > @@ -142,11 +142,38 @@ backend of vNVDIMM:
> > > >  Guest Data Persistence
> > > >  ----------------------
> > > >  
> > > > +vNVDIMM is designed and implemented to guarantee the guest data
> > > > +persistence on the backends in case of host crash or a power failures.
> > > > +However, there are still some requirements and limitations
> > > > +as explained below.
> > > > +
> > > >  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > > > -currently the only one that can guarantee the guest write persistence
> > > > +if MAP_SYNC is not supported by the host kernel and the backends,
> > > > +the only backend that can guarantee the guest write persistence
> > > >  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> > > >  which all guest access do not involve any host-side kernel cache.
> > > >  
> > > > +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> > > > +systems, QEMU can mmap(2) the dax backend files with MAP_SYNC, which
> > > > +ensures filesystem metadata consistency in case of a host crash or a power
> > > > +failure. Enabling MAP_SYNC in QEMU requires below conditions
> > > > +
> > > > + - 'pmem' option of memory-backend-file is 'on':
> > > > +   The backend is a file supporting DAX, e.g., a file on an ext4 or
> > > > +   xfs file system mounted with '-o dax'. if your pmem=on ,but the backend is
> > > > +   not a file supporting DAX, mapping with this flag results in an EOPNOTSUPP
> > > > +   error.
> > > 
> > > Won't this break existing configurations that work today on QEMU
> > > 3.1.0?  Why exactly it is OK to break compatibility here?
> > won't, pmem option default is off, if people who start VM don't know what
> > backend file is, it is suggested and *default to set pmem=off,
> > if people well know the backend file have dax capbility. it is suggest
> > to set pmem=on. 
> > 
> > For a special case that we use /dev/dax as backend, we already have a
> > patch to add MAP_SYNC falg mapiing from device dax mode.
> > see https://lkml.org/lkml/2018/4/22/524 
> > 
> > So, if people force set pmem=on, mapping a regular file, it will results
> > in an EOPNOTSUPP error. 
> 
> This is where compatibility is being broken, isn't it?  People
> currently using pmem=on on a regular file will start getting
> errors after a QEMU upgrade.  Existing VMs with pmem=on may stop
> booting.  Maybe this is OK, but we need to be able to explain why
> it is OK.

I think it's OK since pmem explicitly means "persistent":

The @option{pmem} option specifies whether the backing file specified
by @option{mem-path} is in host persistent memory that can be accessed
using the SNIA NVM programming model (e.g. Intel NVDIMM).
If @option{pmem} is set to 'on', QEMU will take necessary operations to
guarantee the persistence of its own writes to @option{mem-path}
(e.g. in vNVDIMM label emulation and live migration).




> > 
> > see http://man7.org/linux/man-pages/man2/mmap.2.html 
> > > 
> > > > +
> > > > + - 'share' option of memory-backend-file is 'on':
> > > > +   MAP_SYNC flag available only with the MAP_SHARED_VALIDATE mapping type.
> > > 
> > > I don't understand what this paragraph means.
> > see http://man7.org/linux/man-pages/man2/mmap.2.html 
> > > 
> > > > +
> > > > + - 'MAP_SYNC' is supported on linux kernel.(default opened since Linux 4.15)
> > > > +
> > > 
> > > I don't understand why you are making the semantics of
> > > command-line options change depending on the host kernel.
> > the option pmem=on do not dependent the host kernel. MAP_SYNC will be ignore
> > if the kernel don't support. the "pmem=on" have another meaning
> > see https://patchwork.kernel.org/patch/10459407/
> > > 
> > > > +Otherwise, We will ignore the MAP_SYNC flag.
> > > > +
> > > 
> > > See the questions I sent about supported use cases at
> > > <https://www.mail-archive.com/qemu-devel@nongnu.org/msg588822.html>.
> > > I still don't see those questions answered:
> > > 
> > > ] We have at least 3 different possible use cases we might need to
> > > ] support:
> > > ] 
> > > ] 1) pmem=on, MAP_SYNC not desired
> > > ] 2) pmem=on, MAP_SYNC desired but optional
> > > ] 3) pmem=on, MAP_SYNC required, not optional
> > > ] 
> > 
> > Sorry for my poor understanding, I don't know what these mean? 
> > pmem=on will force flag the MAP_SYNC while it capable on current kernel.
> > As we talk with Micheal if we set pmem=on , MAP_SYNC is always desired.
> > 
> > Means, if pmem=on, there is no option to close MAP_SYNC seprately.
> 
> I'm trying to find out what you need the code to do, and the 3
> items above are possible use cases that we might need to support.
> I'm not claiming we need to support all of them, but I would like
> to understand which ones you need to support.
> 
> Once we answer that, we can choose what's the command-line
> required for each case.  Right now this is not clear.

I think generally MAP_SYNC is required.
But for compatibility reasons we might need to support
!MAP_SYNC on old kernels even though it's risky.

> > 
> > 
> > > ] Which cases from the list above we need to support?
> > > ] 
> > > ] From the cases above, what's the expected semantics of "pmem=on"
> > > ] with no extra options?
> > > 
> > > It's not clear to me yet if you want to support use cases (1) and (2).
> > > 
> > > Also, you seem to be choosing between use case (1) or (3) depending on
> > > the build environment instead of command-line options.  The
> > > meaning of command-line options must be predictable and
> > > unambiguous, and not depend on build time variables.
> > so you are asking?
> > 1) pmem=on, MAP_SYNC not supported kernel
> > - MAP_SYNC will be defined 0 and will be ignored in this case. see 2/4.
> > 2) pmem=on, MAP_SYNC is supported but have a option to pass to mmap2()
> > - v7 send-out for a option sync to open/close MAP_SYNC seprately.
> > After talking with Micheal, we give up on a bit of flexibility, and
> > just say pmem=on forces MAP_SYNC. on a MAP_SYNC capable configrations(kernel+
> > backend dax)
> 
> I don't get this: you seem to be saying your series implement
> (2), but above you say that users will get an error if using
> pmem=on on a filesystem not supporting DAX, which means MAP_SYNC
> is required but not optional (3).
> 
> In either case, the choice between (1), (2) or (3) must depend
> only on command-line options, not on the QEMU build environment.
> "pmem=on" must always mean the same thing.
> 
> If pmem=on is documented as making MAP_SYNC required (not
> optional), it should make MAP_SYNC required every time.
> 
> If pmem=on is documented as making MAP_SYNC desired but optional,
> it should make MAP_SYNC optional every time.
> 
> If you want pmem=on to mean something else not listed above, it
> may be also OK, as long as the meaning of pmem=on doesn't depend
> on the build time environment.
> 
> With the current version of the series, the user can't be sure if
> pmem=on will enable MAP_SYNC or not, because its meaning depends
> on the version of the headers when QEMU was compiled.
> 


Yes I am confused too.

> > 3) pmem=on, ?
> > > 
> > > 
> > > > +For more details, please reference mmap(2) man page:
> > > > +http://man7.org/linux/man-pages/man2/mmap.2.html.
> > > > +
> > > >  When using other types of backends, it's suggested to set 'unarmed'
> > > >  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> > > >  guest NVDIMM region mapping structure.  This unarmed flag indicates
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index 08f8516..0cd41f4 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
> > > >  If @option{pmem} is set to 'on', QEMU will take necessary operations to
> > > >  guarantee the persistence of its own writes to @option{mem-path}
> > > >  (e.g. in vNVDIMM label emulation and live migration).
> > > > +Also, we will map the backend-file with MAP_SYNC flag, which can ensure
> > > > +the file metadata is in sync to @option{mem-path} in case of host crash
> > > > +or a power failure. MAP_SYNC requires support from both the host kernel
> > > > +(since Linux kernel 4.15) and @option{mem-path} (only files supporting DAX).
> > > >  
> > > >  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
> > > >  
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > -- 
> > > Eduardo
> 
> -- 
> Eduardo
