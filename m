Received: from eggs.gnu.org ([2001:4830:134:3::10]:59135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTNix-0003pV-9y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTNis-00011d-T4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:30:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTNis-000110-Ha
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:30:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170630133139.7907-1-vadim.galitsyn@profitbricks.com>
	<20170630133139.7907-2-vadim.galitsyn@profitbricks.com>
Date: Fri, 07 Jul 2017 09:30:38 +0200
In-Reply-To: <20170630133139.7907-2-vadim.galitsyn@profitbricks.com> (Vadim
	Galitsyn's message of "Fri, 30 Jun 2017 15:31:39 +0200")
Message-ID: <87lgo0900x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] hmp,
 qmp: introduce memory-size-summary commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Mohammed Gamal <mohammed.gamal@profitbricks.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

Sorry for the late review, got a bit overwhelmed...

Vadim Galitsyn <vadim.galitsyn@profitbricks.com> writes:

> Commands above provide the following memory information in bytes:
>
>   * base-memory - amount of unremovable memory specified
>     with '-m' option at the start of the QEMU process.
>
>   * hotpluggable-memory - amount of memory that was hot-plugged.
>     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>     value is reported.
>
>   * balloon-actual-memory - size of the memory that remains
>     available to the guest after ballooning, as reported by the
>     guest. If the guest has not reported its memory, this value
>     equals to @base-memory + @hot-plug-memory. If ballooning
>     is not enabled, no value is reported.
>
> NOTE:
>
>     Parameter @balloon-actual-memory reports the same as
>     "info balloon" command when ballooning is enabled. The idea
>     to have it in scope of this command(s) comes from
>     https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.

Should we deprecate qmp-query-balloon?  Hmm, see qmp.c below.

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
>
> v4:
>  * Commands "info memory" and "query-memory" were renamed
>    to "info memory-size-summary" and "query-memory-size-summary"
>    correspondingly.
>  * Descriptions for both commands as well as MemoryInfo structure
>    fields were updated/renamed according to
>    http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05972.html.
>  * In MemoryInfo structure following fields are now optional:
>    hotpluggable-memory and balloon-actual-memory.
>  * Field "hotpluggable-memory" now not displayed in HMP if target
>    has no CONFIG_MEM_HOTPLUG enabled.
>  * Field "balloon-actual-memory" now not displayed in HMP if
>    ballooning not enabled.
>  * qapi_free_MemoryInfo() used in order to free corresponding memory
>    instead of g_free().
>  * #ifdef CONFIG_MEM_HOTPLUG was removed and replaced with stubs/ approach.
>    get_exiting_hotpluggable_memory_size() function was introduced in
>    hw/mem/pc-dimm.c (available for all targets which have CONFIG_MEM_HOTPLUG
>    enabled). For other targets, there is a stub in stubs/qmp_pc_dimm.c.
>    In addition, stubs/qmp_pc_dimm_device_list.c was renamed to
>    stubs/qmp_pc_dimm.c in order to reflect actual source file content.
>  * Commit message was updated in order to reflect what was changed.
>
> v3:
>  * Use PRIu64 instead of 'lu' when printing results via HMP.
>  * Report zero hot-plugged memory instead of reporting error
>    when target architecture has no CONFIG_MEM_HOTPLUG enabled.
>
> v2:
>  * Fixed build for targets which do not have CONFIG_MEM_HOTPLUG
>    enabled.
>
>  hmp-commands-info.hx                               | 17 ++++++++++++
>  hmp.c                                              | 23 ++++++++++++++++
>  hmp.h                                              |  1 +
>  hw/mem/pc-dimm.c                                   |  6 +++++
>  include/hw/mem/pc-dimm.h                           |  1 +
>  qapi-schema.json                                   | 28 +++++++++++++++++++
>  qmp.c                                              | 31 ++++++++++++++++++++++
>  stubs/Makefile.objs                                |  2 +-
>  stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 ++++
>  9 files changed, 113 insertions(+), 1 deletion(-)
>  rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (60%)

No test coverage?

I prefer to add pairs of QMP / HMP commands in separate patches, QMP
first, for easier review.  This patch seems small enough to tolerate
adding them in a single patch.  But do consider splitting if you have to
respin.

> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ba98e581ab..a535960157 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -829,6 +829,23 @@ ETEXI
>          .cmd = hmp_info_vm_generation_id,
>      },
>  
> +STEXI
> +@item info memory-size-summary
> +@findex memory-size-summary
> +Display the amount of initially allocated, hot-plugged (if enabled)
> +and ballooned (if enabled) memory in bytes.
> +ETEXI
> +
> +    {
> +        .name       = "memory-size-summary",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the amount of initially allocated, "
> +                      "hot-plugged (if enabled) and ballooned (if enabled) "
> +                      "memory in bytes.",
> +        .cmd        = hmp_info_memory_size_summary,
> +    },
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.c b/hmp.c
> index dee40284c1..15f632481c 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2828,3 +2828,26 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>      qapi_free_GuidInfo(info);
>  }
> +
> +void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    MemoryInfo *info = qmp_query_memory_size_summary(&err);
> +    if (info) {
> +        monitor_printf(mon, "base-memory: %" PRIu64 "\n",
> +                       info->base_memory);
> +
> +        if (info->has_hotpluggable_memory) {
> +            monitor_printf(mon, "hotpluggable-memory: %" PRIu64 "\n",
> +                           info->hotpluggable_memory);
> +        }
> +
> +        if (info->has_balloon_actual_memory) {
> +            monitor_printf(mon, "balloon-actual-memory: %" PRIu64 "\n",
> +                           info->balloon_actual_memory);
> +        }

Why-do-you-separate-words-by-dashes?  Separating them by spaces has been
the custom since about the tenth century :)

According to your cover letter, "balloon actual memory" is the "size of
the memory that remains available to the guest after ballooning".
That's not obvious.  It could just as well be the size of the balloon.
Can we find a more self-explanatory wording that's still short enough?

> +
> +        qapi_free_MemoryInfo(info);
> +    }
> +    hmp_handle_error(mon, &err);
> +}
> diff --git a/hmp.h b/hmp.h
> index 214b2617e7..8c5398ea7a 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -144,5 +144,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
>  void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> +void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index b72258e28f..ea81b1384a 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -159,6 +159,12 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
>      return cap.size;
>  }
>  
> +bool get_exiting_hotpluggable_memory_size(uint64_t *mem_size, Error **errp)

Why is my hot-pluggable memory exiting, and where's it going?  Or do you
mean "exciting"?  Or "existing", perhaps?

> +{
> +    *mem_size = pc_existing_dimms_capacity(errp);
> +    return true;
> +}

What if pc_existing_dimms_capacity() fails?  Shouldn't you return false
then?

Hmm, get_exiting_hotpluggable_memory_size()'s only caller passes
&error_abort, which means you think it can't fail.  Drop the errp
parameter and pass &error_abort here then.

I find "on success store through parameter and return true, on failure
return false" awkward.  I'd return the size on success and (uint64_t)-1
on failure.  Matter of taste.

> +
>  int qmp_pc_dimm_device_list(Object *obj, void *opaque)
>  {
>      MemoryDeviceInfoList ***prev = opaque;
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 1e483f2670..738343df32 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -95,6 +95,7 @@ int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
>  
>  int qmp_pc_dimm_device_list(Object *obj, void *opaque);
>  uint64_t pc_existing_dimms_capacity(Error **errp);
> +bool get_exiting_hotpluggable_memory_size(uint64_t *mem_size, Error **errp);
>  void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>                           MemoryRegion *mr, uint64_t align, Error **errp);
>  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 37c4b95aad..683da8a711 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4327,6 +4327,34 @@
>    'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
>              '*unavailable-features': [ 'str' ], 'typename': 'str' } }
>  
> +##
> +# @MemoryInfo:
> +#
> +# Actual memory information in bytes.
> +#
> +# @base-memory: size of unremovable memory which is specified
> +#               with '-m size' CLI option.

The relative clause suggests that there may be other unremovable memory,
but base-memory reflects only the unremovable memory specified with -m.
Suggest something like

     @base-memory: size of "base" memory specified with command line
                   option -m

> +#
> +# @hotpluggable-memory: size of hot-plugged memory.

I suspect this is actually the size of memory that can be hot-unplugged.
If true, let's say so:

   # @hotpluggable-memory: size memory that can be hot-unplugged

> +#
> +# @balloon-actual-memory: amount of guest memory available after ballooning.
> +#
> +# Since: 2.10.0
> +##
> +{ 'struct': 'MemoryInfo',
> +  'data'  : { 'base-memory': 'int', '*hotpluggable-memory': 'int',
> +              '*balloon-actual-memory': 'int' } }

I think these should all be 'size'.

We suck at using 'size' correctly.  For instance, @BalloonInfo also uses
'int' instead of 'size'.  Looks fixable to me.

Apropos BalloonInfo: you effectively inline it here.  What if we ever
add something to BalloonInfo?  Wouldn't 'balloon': 'BalloonInfo' be
cleaner?

See also my comment after next.

> +
> +##
> +# @query-memory-size-summary:
> +#
> +# Return the amount of initially allocated, hot-plugged (if enabled)
> +# and ballooned (if enabled) memory in bytes.
> +#
> +# Since: 2.10.0
> +##
> +{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
> +
>  ##
>  # @query-cpu-definitions:
>  #
> diff --git a/qmp.c b/qmp.c
> index 7ee9bcfdcf..a863726ad6 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -712,3 +712,34 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
>  
>      return head;
>  }
> +
> +MemoryInfo *qmp_query_memory_size_summary(Error **errp)
> +{
> +    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
> +    BalloonInfo *balloon_info;
> +    uint64_t hotpluggable_memory = 0;
> +    Error *local_err = NULL;
> +
> +    mem_info->base_memory = ram_size;
> +
> +    mem_info->has_hotpluggable_memory =
> +        get_exiting_hotpluggable_memory_size(&hotpluggable_memory,
> +                                             &error_abort);
> +    if (mem_info->has_hotpluggable_memory) {
> +        mem_info->hotpluggable_memory = hotpluggable_memory;
> +    }

Why the @hotpluggable_memory middleman?  Why not

       mem_info->has_hotpluggable_memory =
           get_exiting_hotpluggable_memory_size(&mem_info->hotpluggable_memory,
                                                &error_abort);

> +
> +    /* In case if it is not possible to get balloon info, just ignore it. */
> +    balloon_info = qmp_query_balloon(&local_err);
> +    if (local_err) {
> +        mem_info->has_balloon_actual_memory = false;
> +        error_free(local_err);

Since we throw away the error, query-memory-size-summary is *not* a
replacement for query-balloon.

query-memory-size-summary combines three queries:

(1) base-memory (query can't fail)

(2) hotpluggable-memory (query must not fail, i.e. &error_abort)

(3) balloon-actual-memory (query can fail, and we throw away the error
    then)

Including (3) adds a failure mode.  The fact that we sweep the failure
under the rug doesn't change that.

Why is this a good idea?

> +    } else {
> +        mem_info->has_balloon_actual_memory = true;
> +        mem_info->balloon_actual_memory = balloon_info->actual;
> +    }
> +
> +    qapi_free_BalloonInfo(balloon_info);
> +
> +    return mem_info;
> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index f5b47bfd74..f7cab5b11c 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -32,7 +32,7 @@ stub-obj-y += uuid.o
>  stub-obj-y += vm-stop.o
>  stub-obj-y += vmstate.o
>  stub-obj-$(CONFIG_WIN32) += fd-register.o
> -stub-obj-y += qmp_pc_dimm_device_list.o
> +stub-obj-y += qmp_pc_dimm.o
>  stub-obj-y += target-monitor-defs.o
>  stub-obj-y += target-get-monitor-def.o
>  stub-obj-y += pc_madt_cpu_entry.o
> diff --git a/stubs/qmp_pc_dimm_device_list.c b/stubs/qmp_pc_dimm.c
> similarity index 60%
> rename from stubs/qmp_pc_dimm_device_list.c
> rename to stubs/qmp_pc_dimm.c
> index def211564d..f50029326e 100644
> --- a/stubs/qmp_pc_dimm_device_list.c
> +++ b/stubs/qmp_pc_dimm.c
> @@ -6,3 +6,8 @@ int qmp_pc_dimm_device_list(Object *obj, void *opaque)
>  {
>     return 0;
>  }
> +
> +bool get_exiting_hotpluggable_memory_size(uint64_t *mem_size, Error **errp)
> +{
> +    return false;
> +}
