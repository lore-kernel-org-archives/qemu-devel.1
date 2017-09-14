Received: from eggs.gnu.org ([2001:4830:134:3::10]:58943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsQx8-0004OO-FM
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsQwy-0004qN-GT
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsQwy-0004pd-0c
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:00:48 -0400
Date: Thu, 14 Sep 2017 12:00:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170914120039.5100b63d@nial.brq.redhat.com>
In-Reply-To: <20170829153022.27004-4-vadim.galitsyn@profitbricks.com>
References: <20170829153022.27004-1-vadim.galitsyn@profitbricks.com>
	<20170829153022.27004-4-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 3/3] hmp: introduce 'info
 memory_size_summary' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

On Tue, 29 Aug 2017 17:30:22 +0200
Vadim Galitsyn <vadim.galitsyn@profitbricks.com> wrote:

> Add 'info memory_size_summary' command which is a sibling
> of QMP command query-memory-size-summary. It provides the
> following memory information in bytes:
> 
>   * base-memory - size of "base" memory specified with command line option -m.
> 
>   * plugged-memory - amount of memory that was hot-plugged.
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
>  hmp.h                |  1 +
>  hmp.c                | 18 ++++++++++++++++++
>  hmp-commands-info.hx | 16 ++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
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
> diff --git a/hmp.c b/hmp.c
> index fd80dce758..b718dab4df 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2868,3 +2868,21 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>      qapi_free_GuidInfo(info);
>  }
> +
> +void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    MemoryInfo *info = qmp_query_memory_size_summary(&err);
> +    if (info) {
> +        monitor_printf(mon, "base memory: %" PRIu64 "\n",
> +                       info->base_memory);
> +
> +        if (info->has_plugged_memory) {
> +            monitor_printf(mon, "plugged memory: %" PRIu64 "\n",
> +                           info->plugged_memory);
> +        }
> +
> +        qapi_free_MemoryInfo(info);
> +    }
> +    hmp_handle_error(mon, &err);
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index d9df238a5f..04c9db81f6 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -849,6 +849,22 @@ ETEXI
>          .cmd = hmp_info_vm_generation_id,
>      },
>  
> +STEXI
> +@item info memory_size_summary
> +@findex memory_size_summary
> +Display the amount of initially allocated and hot-plugged (if
s/hot-plugged/present hotpluggable/

> +enabled) memory in bytes.
> +ETEXI
> +
> +    {
> +        .name       = "memory_size_summary",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the amount of initially allocated and "
> +                      "hot-plugged (if enabled) memory in bytes.",
ditto

> +        .cmd        = hmp_info_memory_size_summary,
> +    },
> +
>  STEXI
>  @end table
>  ETEXI
