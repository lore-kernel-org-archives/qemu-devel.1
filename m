Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eeVLe-0003zf-Aq
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eeVLa-0006V0-7x
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:24:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:53105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eeVLZ-0006UO-U8
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 19:24:54 -0500
Date: Thu, 25 Jan 2018 08:24:35 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180125002435.r3gjfo765obx3bv2@hz-desktop>
References: <20180117081325.11924-1-haozhong.zhang@intel.com>
	<20180117081325.11924-4-haozhong.zhang@intel.com>
	<20180124222235-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180124222235-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 01/24/18 22:23 +0200, Michael S. Tsirkin wrote:
> On Wed, Jan 17, 2018 at 04:13:25PM +0800, Haozhong Zhang wrote:
> > This option controls whether QEMU mmap(2) the memory backend file with
> > MAP_SYNC flag, which can fully guarantee the guest write persistence
> > to the backend, if MAP_SYNC flag is supported by the host kernel
> > (Linux kernel 4.15 and later) and the backend is a file supporting
> > DAX (e.g., file on ext4/xfs file system mounted with '-o dax').
> > 
> > It can take one of following values:
> >  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> >         'share=off', QEMU will abort
> >  - off: never pass MAP_SYNC to mmap(2)
> >  - auto (default): if MAP_SYNC is supported and 'share=on', work as if
> >         'sync=on'; otherwise, work as if 'sync=off'
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>

[..]
> >  
> >  @table @option
> >  
> > -@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align}
> > +@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align},sync=@var{on|off|auto}
> >  
> >  Creates a memory file backend object, which can be used to back
> >  the guest RAM with huge pages.
> > @@ -4034,6 +4034,25 @@ requires an alignment different than the default one used by QEMU, eg
> >  the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
> >  such cases, users can specify the required alignment via this option.
> >  
> > +The @option{sync} option specifies whether QEMU mmap(2) @option{mem-path}
> > +with MAP_SYNC flag, which can fully guarantee the guest write
> > +persistence to @option{mem-path}.
> 
> I would add ... even in case of a host power loss.
> Here and wherever you say "fully".

Without MAP_SYNC, QEMU can only guarantee the guest data is written to
the host NVDIMM after, for example, guest clwb+sfence. However, if
some host file system meta data of the mapped file have not been
written back to the host NVDIMM when a host power failure happens, the
mapped file may be broken though all its data may be still there.

Anyway, I'll remove the confusing word "fully" and add your suggestion.

Thanks,
Haozhong

> 
> > MAP_SYNC requires supports from both
> > +the host kernel (since Linux kernel 4.15) and @option{mem-path} (only
> > +files supporting DAX). It can take one of following values:
> > +
> > +@table @option
> > +@item @var{on}
> > +try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> > +@option{share}=@var{off}, QEMU will abort
> > +
> > +@item @var{off}
> > +never pass MAP_SYNC to mmap(2)
> > +
> > +@item @var{auto} (default)
> > +if MAP_SYNC is supported and @option{share}=@var{on}, work as if
> > +@option{sync}=@var{on}; otherwise, work as if @option{sync}=@var{off}
> > +@end table
> > +
> >  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
> >  
> >  Creates a memory backend object, which can be used to back the guest RAM.
> > -- 
> > 2.14.1
