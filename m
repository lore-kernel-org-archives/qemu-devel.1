Received: from eggs.gnu.org ([2001:4830:134:3::10]:39747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csV1f-00073q-3H
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csV1b-0007zl-4K
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1csV1a-0007zA-RL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:49:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0B9A41A2B
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:49:33 +0000 (UTC)
Date: Mon, 27 Mar 2017 14:49:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170327134929.GA2757@work-vm>
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

And queued.

Dave
> ---
>  hmp-commands.hx |  32 ++++++++++++++++++
>  monitor.c       | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
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
> index be282ec..216a97a 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1421,6 +1421,107 @@ static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
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
> +    uintptr_t addr = (uintptr_t) ptr;
> +    uintptr_t pagesize = getpagesize();
> +    off_t offset = addr / pagesize * sizeof(pinfo);
> +    int fd;
> +
> +    fd = open("/proc/self/pagemap", O_RDONLY);
> +    if (fd == -1) {
> +        error_setg_errno(errp, errno, "Cannot open /proc/self/pagemap");
> +        return -1;
> +    }
> +
> +    /* Force copy-on-write if necessary.  */
> +    atomic_add((uint8_t *)ptr, 0);
> +
> +    if (pread(fd, &pinfo, sizeof(pinfo), offset) != sizeof(pinfo)) {
> +        error_setg_errno(errp, errno, "Cannot read pagemap");
> +        goto out;
> +    }
> +    if ((pinfo & (1ull << 63)) == 0) {
> +        error_setg(errp, "Page not present");
> +        goto out;
> +    }
> +    ret = ((pinfo & 0x007fffffffffffffull) * pagesize) | (addr & (pagesize - 1));
> +
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
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
