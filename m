Received: from eggs.gnu.org ([2001:4830:134:3::10]:41997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnqh9-0004rp-54
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cnqh4-0007Ln-8c
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cnqh3-0007LM-VZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:57:10 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C984FC04BD21
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 17:57:09 +0000 (UTC)
Date: Tue, 14 Mar 2017 17:57:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170314175704.GQ2445@work-vm>
References: <1489512045-49206-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489512045-49206-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9?] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> These commands are useful when testing machine-check passthrough.
> gpa2hva is useful to inject a MADV_HWPOISON madvise from gdb, while
> gpa2hpa is useful to inject an error with the mce-inject kernel
> module.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Technically a feature, but on the other hand it is pretty
> 	much impossible to test without it, and the people testing
> 	the feature are using it as an out-of-tree patch.  Opinions?

I've no real objection except for the freeze; they're reasonable
debug commands.

>  hmp-commands.hx |  32 ++++++++++++++++++
>  monitor.c       | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 8819281..0aca984 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -526,6 +526,38 @@ Dump 80 16 bit values at the start of the video memory.
>  ETEXI
>  
>      {
> +        .name       = "gpa2hva",
> +        .args_type  = "addr:l",
> +        .params     = "addr",
> +        .help       = "print the host virtual address corresponding to a guest physical address",
> +        .cmd        = hmp_gpa2hva,
> +    },
> +
> +STEXI
> +@item gpa2hva @var{addr}
> +@findex gpa2hva
> +Print the host virtual address at which the guest's physical address @var{addr}
> +is mapped.
> +ETEXI
> +
> +#ifdef CONFIG_LINUX
> +    {
> +        .name       = "gpa2hpa",
> +        .args_type  = "addr:l",
> +        .params     = "addr",
> +        .help       = "print the host physical address corresponding to a guest physical address",
> +        .cmd        = hmp_gpa2hpa,
> +    },
> +#endif
> +
> +STEXI
> +@item gpa2hpa @var{addr}
> +@findex gpa2hpa
> +Print the host physical address at which the guest's physical address @var{addr}
> +is mapped.
> +ETEXI
> +
> +    {
>          .name       = "p|print",
>          .args_type  = "fmt:/,val:l",
>          .params     = "/fmt expr",
> diff --git a/monitor.c b/monitor.c
> index be282ec..1ac8c5f 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1421,6 +1421,109 @@ static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>      memory_dump(mon, count, format, size, addr, 1);
>  }
>  
> +static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> +{
> +    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> +                                                 addr, 1);
> +
> +    if (!mrs.mr) {
> +        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
> +        return NULL;
> +    }
> +
> +    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
> +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
> +        memory_region_unref(mrs.mr);
> +        return NULL;
> +    }
> +
> +    *p_mr = mrs.mr;
> +    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
> +}
> +
> +static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
> +{
> +    hwaddr addr = qdict_get_int(qdict, "addr");
> +    Error *local_err = NULL;
> +    MemoryRegion *mr;
> +    void *ptr;
> +
> +    ptr = gpa2hva(&mr, addr, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +
> +    monitor_printf(mon, "Host virtual address for 0x%" HWADDR_PRIx
> +                   " (%s) is %p\n",
> +                   addr, mr->name, ptr);
> +
> +    memory_region_unref(mr);
> +}
> +
> +#ifdef CONFIG_LINUX
> +static uint64_t vtop(void *ptr, Error **errp)
> +{
> +    uint64_t pinfo;
> +    uint64_t ret = -1;

An odd value for a uint.

> +    uintptr_t addr = (uintptr_t) ptr;
> +    uintptr_t pagesize = getpagesize();
> +    off_t offset = addr / pagesize * sizeof (pinfo);
> +    char pagemapname[64];
> +    int fd;
> +
> +    sprintf(pagemapname, "/proc/%d/pagemap", getpid());
> +    fd = open(pagemapname, O_RDONLY);

/proc/self/pagemap would seem easier.

> +    if (fd == -1) {
> +        error_setg_errno(errp, errno, "Cannot open %s", pagemapname);
> +        return -1;
> +    }
> +
> +    /* Force copy-on-write if necessary.  */
> +    atomic_add((uint8_t *)ptr, 0);
> +
> +    if (pread(fd, &pinfo, sizeof(pinfo), offset) != sizeof(pinfo)) {
> +        error_setg_errno(errp, errno, "Cannot read from %s", pagemapname);
> +        goto out;
> +    }
> +    if ((pinfo & (1ull << 63)) == 0) {
> +        error_setg(errp, "Page not present");
> +        goto out;
> +    }
> +    ret = ((pinfo & 0x007fffffffffffffull) << 12) | (addr & (pagesize - 1));

Is that an x86 magic 12 ?
(life would seem to get messy if pagesize != 1<<12 for that line)

> +out:
> +    close(fd);
> +    return ret;
> +}
> +
> +static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
> +{
> +    hwaddr addr = qdict_get_int(qdict, "addr");
> +    Error *local_err = NULL;
> +    MemoryRegion *mr;
> +    void *ptr;
> +    uint64_t physaddr;
> +
> +    ptr = gpa2hva(&mr, addr, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +
> +    physaddr = vtop(ptr, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    } else {
> +        monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
> +                       " (%s) is 0x%" PRIx64 "\n",
> +                       addr, mr->name, (uint64_t) physaddr);

> +    }
> +
> +    memory_region_unref(mr);
> +}
> +#endif
> +
>  static void do_print(Monitor *mon, const QDict *qdict)
>  {
>      int format = qdict_get_int(qdict, "format");

Dave

> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
