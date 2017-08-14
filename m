Received: from eggs.gnu.org ([2001:4830:134:3::10]:46578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGJK-0004be-QE
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhGJG-0003Ss-KF
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhGJG-0003Q9-4U
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:25:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-4-vadim.galitsyn@profitbricks.com>
Date: Mon, 14 Aug 2017 16:25:31 +0200
In-Reply-To: <20170728121044.15488-4-vadim.galitsyn@profitbricks.com> (Vadim
	Galitsyn's message of "Fri, 28 Jul 2017 14:10:44 +0200")
Message-ID: <87tw1ateec.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/3] hmp: introduce 'info
 memory-size-summary' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:

> This command is an equivalent of QMP command query-memory-size-summary.
> It provides the following memory information in bytes:
>
>   * base-memory - size of "base" memory specified with command line option -m.
>
>   * hotunpluggable-memory - amount of memory that was hot-plugged.
>     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>     value is reported.
>
> Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
> Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hmp-commands-info.hx     | 16 ++++++++++++++++
>  hmp.c                    | 16 ++++++++++++++++
>  hmp.h                    |  1 +
>  hw/mem/pc-dimm.c         |  2 +-
>  include/hw/mem/pc-dimm.h |  2 +-
>  qmp.c                    |  3 ++-
>  stubs/qmp_pc_dimm.c      |  2 +-
>  7 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index d9df238a5f..c5a62699ed 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -849,6 +849,22 @@ ETEXI
>          .cmd = hmp_info_vm_generation_id,
>      },
>  
> +STEXI
> +@item info memory-size-summary
> +@findex memory-size-summary
> +Display the amount of initially allocated and hot-plugged (if
> +enabled) memory in bytes.
> +ETEXI
> +
> +    {
> +        .name       = "memory-size-summary",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the amount of initially allocated and "
> +                      "hot-plugged (if enabled) memory in bytes.",
> +        .cmd        = hmp_info_memory_size_summary,
> +    },
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.c b/hmp.c
> index fd80dce758..0c14ecc454 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2868,3 +2868,19 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>      qapi_free_GuidInfo(info);
>  }
> +
> +void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
> +{
> +    MemoryInfo *info = qmp_query_memory_size_summary(&error_abort);
> +    if (info) {
> +        monitor_printf(mon, "base memory: %" PRIu64 "\n",
> +                       info->base_memory);
> +
> +        if (info->has_hotunpluggable_memory) {
> +            monitor_printf(mon, "hotunpluggable memory: %" PRIu64 "\n",
> +                           info->hotunpluggable_memory);
> +        }
> +
> +        qapi_free_MemoryInfo(info);
> +    }
> +}
> diff --git a/hmp.h b/hmp.h
> index 1ff455295e..3605003e4c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -145,5 +145,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
>  void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> +void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 1df8b7ee57..f00c61bb82 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -159,7 +159,7 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
>      return cap.size;
>  }
>  
> -uint64_t get_existing_hotpluggable_memory_size(void)
> +uint64_t get_existing_hotunpluggable_memory_size(void)
>  {
>      return pc_existing_dimms_capacity(&error_abort);
>  }
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 52c6b5e641..7dd8c3b7c1 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -95,7 +95,7 @@ int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
>  
>  int qmp_pc_dimm_device_list(Object *obj, void *opaque);
>  uint64_t pc_existing_dimms_capacity(Error **errp);
> -uint64_t get_existing_hotpluggable_memory_size(void);
> +uint64_t get_existing_hotunpluggable_memory_size(void);

Introduced in PATCH 2, renamed in PATCH 3.  Try again :)

>  void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>                           MemoryRegion *mr, uint64_t align, Error **errp);
>  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
> diff --git a/qmp.c b/qmp.c
> index 682d950440..18a7594b54 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -716,7 +716,8 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
>  
>      mem_info->base_memory = ram_size;
>  
> -    mem_info->hotunpluggable_memory = get_existing_hotpluggable_memory_size();
> +    mem_info->hotunpluggable_memory =
> +        get_existing_hotunpluggable_memory_size();
>      mem_info->has_hotunpluggable_memory =
>          (mem_info->hotunpluggable_memory != (uint64_t)-1);
>  
> diff --git a/stubs/qmp_pc_dimm.c b/stubs/qmp_pc_dimm.c
> index 1d1e008b58..eba97dbbbb 100644
> --- a/stubs/qmp_pc_dimm.c
> +++ b/stubs/qmp_pc_dimm.c
> @@ -7,7 +7,7 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque)
>     return 0;
>  }
>  
> -uint64_t get_existing_hotpluggable_memory_size(void)
> +uint64_t get_existing_hotunpluggable_memory_size(void)
>  {
>      return (uint64_t)-1;
>  }
