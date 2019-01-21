Received: from eggs.gnu.org ([209.51.188.92]:33928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1glUb6-0004gx-Lw
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 03:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1glUS7-0002sh-TQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:57:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:21203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1glUS7-0002rj-LK
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:57:03 -0500
Date: Mon, 21 Jan 2019 15:57:18 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20190121075717.GA24848@tiger-server>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<be0aba0f61ea5c583ea696db4cc621d3886893de.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116103615-mutt-send-email-mst@kernel.org>
	<20190121061143.GB21562@tiger-server>
	<790023026.65652877.1548055299697.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <790023026.65652877.1548055299697.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V9 6/6] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, stefanha@redhat.com, pbonzini@redhat.com, yu c zhang <yu.c.zhang@linux.intel.com>, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>

On 2019-01-21 at 02:21:39 -0500, Pankaj Gupta wrote:
> 
> > > > ---
> > > >  docs/nvdimm.txt | 21 ++++++++++++++++++++-
> > > >  qemu-options.hx |  4 ++++
> > > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > > > index 5f158a6..565ba73 100644
> > > > --- a/docs/nvdimm.txt
> > > > +++ b/docs/nvdimm.txt
> > > > @@ -142,11 +142,30 @@ backend of vNVDIMM:
> > > >  Guest Data Persistence
> > > >  ----------------------
> > > >  
> > > > +vNVDIMM is designed and implemented to guarantee the guest data
> > > > +persistence on the backends even on the host crash and power
> > > 
> > > in case of a host crash or a power failure
> > > 
> > > (be consistent)
> > > 
> > > > +failures. However, there are still some requirements and limitations
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
> > > > +systems, QEMU can mmap(2) the backend with MAP_SYNC, which can ensure
> > > 
> > > which ensures
> > > 
> > > > +filesystem metadata consistent
> > > 
> > > consistency
> > > 
> > > > even after a system crash or power
> > > 
> > > a power
> > > 
> > > > +failure. Besides the host kernel support, enabling MAP_SYNC in QEMU
> > > > +also requires:
> > > > +
> > > > + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> > > > +   xfs file system mounted with '-o dax',
> > > > +
> > > > + - 'share' option of memory-backend-file is 'on'.
> > > 
> > > why does share need to be on?
> > According to mmap(2) man page,
> > MAP_SYNC is available only with the MAP_SHARED_VALIDATE map‐ping type.
> > I will add this to documentation, Thanks.
> 
> MAP_SHARE_VALIDATE should be used to validate MAP_SYNC with MAP_SHARED.
> 
> #define MAP_SHARED_VALIDATE 0x03
> 
> In contrast, MAP_SHARED is:
> #define MAP_SHARED      0x01            /* Share changes */
> 
> I think we should use MAP_SHARED_VALIDATE with MAP_SYNC here?
> 
> Thanks,
> Pankaj
Yes, Pankaj, Thanks point that out, I will add the MAP_SHARED_VALIDATE.
> 
> > > 
> > > > +
> > > > + - 'pmem' option of memory-backend-file is 'on'
> > > > +
> > > >  When using other types of backends, it's suggested to set 'unarmed'
> > > >  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> > > >  guest NVDIMM region mapping structure.  This unarmed flag indicates
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index 08f8516..545cb8a 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Intel
> > > > NVDIMM).
> > > >  If @option{pmem} is set to 'on', QEMU will take necessary operations to
> > > >  guarantee the persistence of its own writes to @option{mem-path}
> > > >  (e.g. in vNVDIMM label emulation and live migration).
> > > > +Also, we will map the backend-file with MAP_SYNC flag, which can ensure
> > > > +the file metadata is in sync to @option{mem-path} even on the host crash
> > > > +and power failures. MAP_SYNC requires supports from both the host kernel
> > > 
> > > requires support
> > > 
> > > > +(since Linux kernel 4.15) and @option{mem-path} (only files supporting
> > > > DAX).
> > > >  
> > > >  @item -object
> > > >  memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
> > > >  
> > > > --
> > > > 2.7.4
> > 
