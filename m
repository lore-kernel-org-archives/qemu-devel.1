Received: from eggs.gnu.org ([2001:4830:134:3::10]:40726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dPr7O-0006X6-H0
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dPr7I-0002GP-3Y
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dPr7H-0002D7-OK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:05:20 -0400
Date: Tue, 27 Jun 2017 16:05:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170627160512.705f6d8e@nial.brq.redhat.com>
In-Reply-To: <20170614152106.25533-1-vadim.galitsyn@profitbricks.com>
References: <20170614152106.25533-1-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] hmp,
 qmp: introduce "info memory" and "query-memory" commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Mohammed Gamal <mohammed.gamal@profitbricks.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

On Wed, 14 Jun 2017 17:21:06 +0200
Vadim Galitsyn <vadim.galitsyn@profitbricks.com> wrote:

> Commands above provide the following memory information in bytes:
> 
>   * base-memory - amount of static memory specified
>     with '-m' option at the start of the QEMU process.
> 
>   * hot-plug-memory - amount of memory that was hot-plugged.
> 
>   * ballooned-actual-memory - size of the memory that remains
>     available to the guest after ballooning, as reported by the
>     guest. If the guest has not reported its memory, this value
>     equals to @base-memory + @hot-plug-memory. If ballooning
>     is not enabled, zero value is reported.
> 
> NOTE:
> 
>     Parameter @ballooned-actual-memory reports the same as
>     "info balloon" command when ballooning is enabled. The idea
>     to have it in scope of this command(s) comes from
>     https://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01472.html.
> 
> Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
> Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
> 
> v3:
>  * Use PRIu64 instead of 'lu' when printing results via HMP.
>  * Report zero hot-plugged memory instead of reporting error
>    when target architecture has no CONFIG_MEM_HOTPLUG enabled.
> 
> v2:
>  * Fixed build for targets which do not have CONFIG_MEM_HOTPLUG enabled.
> 
>  hmp-commands-info.hx | 15 +++++++++++++++
>  hmp.c                | 16 ++++++++++++++++
>  hmp.h                |  1 +
>  qapi-schema.json     | 27 +++++++++++++++++++++++++++
>  qmp.c                | 36 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 95 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ae169011b1..bc37525550 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -833,6 +833,21 @@ STEXI
>  @end table
>  ETEXI
>  
> +STEXI
> +@item info memory
s/memory/memory-size-summary/
maybe the same for qmp command name

> +@findex memory
> +Display ***

s/***/summary present memory size including hotplugged, ballooned if enabled.
or something like this

> +ETEXI
> +
> +    {
> +        .name       = "memory",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show memory size information in bytes (static, "
> +                      "hotplugged, ballooned)",
> +        .cmd        = hmp_info_memory,
> +    },
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.c b/hmp.c
> index 8c72c58b20..d6ec686376 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2817,3 +2817,19 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>      qapi_free_GuidInfo(info);
>  }
> +
> +void hmp_info_memory(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    MemoryInfo *info = qmp_query_memory(&err);
> +    if (info) {
> +        monitor_printf(mon, "base-memory: %" PRIu64 "\n",
> +                       info->base_memory);
> +        monitor_printf(mon, "hot-plug-memory: %" PRIu64 "\n",
> +                       info->hot_plug_memory);
it shouldn't be printed if hotplug is not enabled

> +        monitor_printf(mon, "ballooned-actual-memory: %" PRIu64 "\n",
> +                       info->ballooned_actual_memory);
> +        g_free(info);

probably there is autogenerated qapi_free_FOO() for MemInfo type
since it's QAPI type, it should be used here instead of g_free() if it exists.

> +    }
> +    hmp_handle_error(mon, &err);
> +}
> diff --git a/hmp.h b/hmp.h
> index d8b94ce9dc..c422aa2fac 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -143,5 +143,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
>  void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> +void hmp_info_memory(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 4b50b652d3..33cd7cb3b8 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4324,6 +4324,33 @@
>    'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
>              '*unavailable-features': [ 'str' ], 'typename': 'str' } }
>  
> +##
> +# @MemoryInfo:
> +#
> +# Memory information in bytes.
s/Memory/Present memory/

> +#
> +# @base-memory: size of static memory which was specified on Qemu start.
s/static/unremovable/
s/was specified on Qemu start/is specified with '-m size' CLI option

> +#
> +# @hot-plug-memory: size of hot-plugged memory.
hotpluggable-memory

> +#
> +# @ballooned-actual-memory: amount of guest memory available after ballooning.
> +#
> +# Since: 2.10.0
> +##
> +{ 'struct': 'MemoryInfo',
> +  'data'  : { 'base-memory': 'int',
> 'hot-plug-memory': 'int',
should be optional and shown only if hotplug is actually enabled

> +              'ballooned-actual-memory': 'int' } }
maybe the same for ballooning

> +
> +##
> +# @query-memory:
> +#
> +# Return memory size information which includes
s//present/

> +# static, hotplugged and ballooned memory.
> +#
> +# Since: 2.10.0
> +##
> +{ 'command': 'query-memory', 'returns': 'MemoryInfo' }
> +
>  ##
>  # @query-cpu-definitions:
>  #
> diff --git a/qmp.c b/qmp.c
> index 7ee9bcfdcf..56b89ffbde 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -712,3 +712,39 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
>  
>      return head;
>  }
> +
> +MemoryInfo *qmp_query_memory(Error **errp)
> +{
> +    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
> +    BalloonInfo *balloon_info;
> +    Error *local_err = NULL;
> +
> +    mem_info->base_memory = ram_size;
> +
> +    /* If current configuration does not have CONFIG_MEM_HOTPLUG
> +     * enabled, report zero hot-plugged memory.
> +     */
> +#ifdef CONFIG_MEM_HOTPLUG
> +    mem_info->hot_plug_memory = pc_existing_dimms_capacity(&local_err);
I'd use &error_abort here as this call should never fail

however it it won't work for spapr target which has CONFIG_MEM_HOTPLUG
and should fail to build due to missing pc_existing_dimms_capacity()
implementation.

I'd suggest to introduce
  get_exiting_hotpluggable_memory_size()
    + stub in stubs/... to avoid ifdefs

and then make separate impl. for pc and spapr targets to make
command work correctly on both targets.

> +    if (local_err) {
> +        error_setg(errp, "could not get hot-plug memory info: %s",
> +                   error_get_pretty(local_err));
> +        g_free(mem_info);
> +        return NULL;
> +    }
> +#else
> +    mem_info->hot_plug_memory = 0;
> +#endif
> +    /* In case if it is not possible to get balloon info, just ignore it. */
> +    balloon_info = qmp_query_balloon(&local_err);
> +    if (local_err) {
> +        mem_info->ballooned_actual_memory = 0;
> +        error_free(local_err);
> +    } else {
> +        mem_info->ballooned_actual_memory = balloon_info->actual;
> +    }
> +
> +    qapi_free_BalloonInfo(balloon_info);
> +
> +    return mem_info;
> +}
