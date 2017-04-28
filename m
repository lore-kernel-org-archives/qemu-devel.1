Received: from eggs.gnu.org ([2001:4830:134:3::10]:44041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d435T-0006le-RU
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d435Q-0008FK-N2
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:25:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d435Q-0008EY-DT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:25:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F6587F4A7
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:25:15 +0000 (UTC)
Date: Fri, 28 Apr 2017 18:21:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170428102130.GD22801@pxdev.xzpeter.org>
References: <1493287126-19072-1-git-send-email-peterx@redhat.com>
	<1493287126-19072-3-git-send-email-peterx@redhat.com>
	<20170427112313.GD2082@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427112313.GD2082@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ramblock: add new hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Apr 27, 2017 at 12:23:14PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > To dump information about ramblocks. It looks like:
> > 
> > (qemu) info ramblock
> >               Block Name    PSize              Offset               Used              Total
> >             /objects/mem       2M  0x0000000000000000 0x0000000080000000 0x0000000080000000
> >                 vga.vram       4K  0x0000000080060000 0x0000000001000000 0x0000000001000000
> >     /rom@etc/acpi/tables       4K  0x00000000810b0000 0x0000000000020000 0x0000000000200000
> >                  pc.bios       4K  0x0000000080000000 0x0000000000040000 0x0000000000040000
> >   0000:00:03.0/e1000.rom       4K  0x0000000081070000 0x0000000000040000 0x0000000000040000
> >                   pc.rom       4K  0x0000000080040000 0x0000000000020000 0x0000000000020000
> >     0000:00:02.0/vga.rom       4K  0x0000000081060000 0x0000000000010000 0x0000000000010000
> >    /rom@etc/table-loader       4K  0x00000000812b0000 0x0000000000001000 0x0000000000001000
> >       /rom@etc/acpi/rsdp       4K  0x00000000812b1000 0x0000000000001000 0x0000000000001000
> > 
> > Ramblock is something hidden internally in QEMU implementation, and this
> > command should only be used by mostly QEMU developers on RAM stuff. It
> > is not a command suitable for QMP interface. So only HMP interface is
> > provided for it.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  exec.c                 | 36 ++++++++++++++++++++++++++++++++++++
> >  hmp-commands-info.hx   | 14 ++++++++++++++
> >  hmp.c                  |  6 ++++++
> >  hmp.h                  |  1 +
> >  include/exec/ramlist.h |  1 +
> >  5 files changed, 58 insertions(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index 50519ae..9b9d16e 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -71,6 +71,8 @@
> >  #include "qemu/mmap-alloc.h"
> >  #endif
> >  
> > +#include "monitor/monitor.h"
> > +
> >  //#define DEBUG_SUBPAGE
> >  
> >  #if !defined(CONFIG_USER_ONLY)
> > @@ -1333,6 +1335,40 @@ void qemu_mutex_unlock_ramlist(void)
> >      qemu_mutex_unlock(&ram_list.mutex);
> >  }
> >  
> > +static const char *page_size_to_str(size_t psize)
> > +{
> > +    switch (psize) {
> > +    case 0x1000:
> > +        return "4K";
> > +    case 0x10000:
> > +        return "64K";
> > +    case 0x200000:
> > +        return "2M";
> > +    case 0x40000000:
> > +        return "1G";
> 
> That's not very portable; other platforms have other sizes, for example
> I think ARM has 16kB as one option, and I'm pretty sure the huge-pages
> on Power are a different size.
> Hmm, we already have
>                      qemu-io-cmds.c:cvtstr and
>        qapi/string-output-visitor.c:print_type_size
> 
> to print sizes nicely; it's a pity we can't use them somehow rather
> than having a 3rd similar function.

Indeed. But it's not easy to directly leverage them. Another thing is
that even with these two existing ones, I would still prefer one
function tailored for translating page sizes, since page sizes are
after all static and imho a hash is nice and fast in that case (just
like what the switch does above).

Regarding to the compatibility issue - I considered that, so I had a
"default" below. Since this command is at least currently only for
debugging, if anyone sees "N/A" in the page size field, he/she would
know something wrong, and possibly he/she can add the missed page size
then (if he/she really think this command useful :-).

How about I move this function into util/cutils.c? Would that be a
solution for current series? Also, I can add translations for
4K,8K,16K,... until 1G, if you prefer. That won't be too hard.

> 
> > +    default:
> > +        return "N/A";
> > +    }
> > +}
> > +
> > +void ram_block_dump(Monitor *mon)
> > +{
> > +    RAMBlock *block;
> > +
> > +    rcu_read_lock();
> > +    monitor_printf(mon, "%24s %8s  %18s %18s %18s\n",
> > +                   "Block Name", "PSize", "Offset", "Used", "Total");
> > +    RAMBLOCK_FOREACH(block) {
> > +        monitor_printf(mon, "%24s %8s  0x%016" PRIx64 " 0x%016" PRIx64
> > +                       " 0x%016" PRIx64 "\n", block->idstr,
> > +                       page_size_to_str(block->page_size),
> > +                       (uint64_t)block->offset,
> > +                       (uint64_t)block->used_length,
> > +                       (uint64_t)block->max_length);
> > +    }
> 
> Yes that should work, I remember there's a RAM_ADDR_FMT macro that's
> supposed to be usable for ram_addr_t, but that's fine.

That looks better. Will switch to that. Thanks!

-- 
Peter Xu
