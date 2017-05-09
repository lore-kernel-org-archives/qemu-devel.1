Received: from eggs.gnu.org ([2001:4830:134:3::10]:57387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d83Ec-000756-Jv
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d83EY-0006OT-Io
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d83EY-0006NC-9k
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:23:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F3704E02E
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:23:13 +0000 (UTC)
Date: Tue, 9 May 2017 19:23:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170509112306.GL2820@pxdev.xzpeter.org>
References: <1494223204-16388-1-git-send-email-peterx@redhat.com>
	<1494223204-16388-3-git-send-email-peterx@redhat.com>
	<20170508192132.GN2120@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170508192132.GN2120@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] ramblock: add new hmp command "info
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

On Mon, May 08, 2017 at 08:21:33PM +0100, Dr. David Alan Gilbert wrote:
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
> >  exec.c                 | 20 ++++++++++++++++++++
> >  hmp-commands-info.hx   | 14 ++++++++++++++
> >  hmp.c                  |  6 ++++++
> >  hmp.h                  |  1 +
> >  include/exec/ramlist.h |  1 +
> >  include/qemu-common.h  |  1 +
> >  util/cutils.c          | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 89 insertions(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index 50519ae..5e50bdf 100644
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
> > @@ -1333,6 +1335,24 @@ void qemu_mutex_unlock_ramlist(void)
> >      qemu_mutex_unlock(&ram_list.mutex);
> >  }
> >  
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
> > +    rcu_read_unlock();
> > +}
> > +
> >  #ifdef __linux__
> >  /*
> >   * FIXME TOCTTOU: this iterates over memory backends' mem-path, which
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index a53f105..ae16901 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -788,6 +788,20 @@ Display the latest dump status.
> >  ETEXI
> >  
> >      {
> > +        .name       = "ramblock",
> > +        .args_type  = "",
> > +        .params     = "",
> > +        .help       = "Display system ramblock information",
> > +        .cmd        = hmp_info_ramblock,
> > +    },
> > +
> > +STEXI
> > +@item info ramblock
> > +@findex ramblock
> > +Dump all the ramblocks of the system.
> > +ETEXI
> > +
> > +    {
> >          .name       = "hotpluggable-cpus",
> >          .args_type  = "",
> >          .params     = "",
> > diff --git a/hmp.c b/hmp.c
> > index ab407d6..8369388 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -37,6 +37,7 @@
> >  #include "qemu-io.h"
> >  #include "qemu/cutils.h"
> >  #include "qemu/error-report.h"
> > +#include "exec/ramlist.h"
> >  #include "hw/intc/intc.h"
> >  
> >  #ifdef CONFIG_SPICE
> > @@ -2563,6 +2564,11 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict)
> >      qapi_free_DumpQueryResult(result);
> >  }
> >  
> > +void hmp_info_ramblock(Monitor *mon, const QDict *qdict)
> > +{
> > +    ram_block_dump(mon);
> > +}
> > +
> >  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
> >  {
> >      Error *err = NULL;
> > diff --git a/hmp.h b/hmp.h
> > index 799fd37..7353b67 100644
> > --- a/hmp.h
> > +++ b/hmp.h
> > @@ -136,6 +136,7 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
> >  void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
> >  void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
> >  void hmp_info_dump(Monitor *mon, const QDict *qdict);
> > +void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
> >  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
> >  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> >  
> > diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> > index f1c6b45..2e2ac6c 100644
> > --- a/include/exec/ramlist.h
> > +++ b/include/exec/ramlist.h
> > @@ -73,5 +73,6 @@ void ram_block_notifier_remove(RAMBlockNotifier *n);
> >  void ram_block_notify_add(void *host, size_t size);
> >  void ram_block_notify_remove(void *host, size_t size);
> >  
> > +void ram_block_dump(Monitor *mon);
> >  
> >  #endif /* RAMLIST_H */
> > diff --git a/include/qemu-common.h b/include/qemu-common.h
> > index d218821..62aef10 100644
> > --- a/include/qemu-common.h
> > +++ b/include/qemu-common.h
> > @@ -146,6 +146,7 @@ int parse_debug_env(const char *name, int max, int initial);
> >  
> >  const char *qemu_ether_ntoa(const MACAddr *mac);
> >  void page_size_init(void);
> > +const char *page_size_to_str(size_t psize);
> >  
> >  /* returns non-zero if dump is in progress, otherwise zero is
> >   * returned. */
> > diff --git a/util/cutils.c b/util/cutils.c
> > index 50ad179..b0fe88a 100644
> > --- a/util/cutils.c
> > +++ b/util/cutils.c
> > @@ -619,3 +619,49 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
> >  
> >      return ret;
> >  }
> > +
> > +const char *page_size_to_str(size_t psize)
> > +{
> > +    switch (psize) {
> > +    case 0x1000:
> > +        return "4K";
> > +    case 0x2000:
> > +        return "8K";
> > +    case 0x4000:
> > +        return "16K";
> > +    case 0x8000:
> > +        return "32K";
> > +    case 0x10000:
> > +        return "64K";
> > +    case 0x20000:
> > +        return "128K";
> > +    case 0x40000:
> > +        return "256K";
> > +    case 0x80000:
> > +        return "512K";
> > +    case 0x100000:
> > +        return "1M";
> > +    case 0x200000:
> > +        return "2M";
> > +    case 0x400000:
> > +        return "4M";
> > +    case 0x800000:
> > +        return "8M";
> > +    case 0x1000000:
> > +        return "16M";
> > +    case 0x2000000:
> > +        return "32M";
> > +    case 0x4000000:
> > +        return "64M";
> > +    case 0x8000000:
> > +        return "128M";
> > +    case 0x10000000:
> > +        return "256M";
> > +    case 0x20000000:
> > +        return "512M";
> > +    case 0x40000000:
> > +        return "1G";
> > +    default:
> > +        return "N/A";
> > +    }
> > +}
> 
> Again, I'm happy - but this function still bothers me; I wonder
> what we can do.  My main worry is it's the same as cvtstr and
> print_type_size - but it's actually not, because they do odd
> things printing it as %.3f.  Is print_type_str in MB or MiB
> (I cna't tell it's got both 1000 and 1024 in - odd)
> 
> Can't we just write a general routine using ctz rather
> than the big switch - then anyone can use it with a power of 2.

Finally I stole frexp() in print_type_size() (as you mentioned) to
provide a general routine for this convertion. I didn't generalize
print_type_size() though since that's using iB unit (while that does
not suite for page sizes). I'll post v5 later to see whether we'll
like it. Thanks,

-- 
Peter Xu
