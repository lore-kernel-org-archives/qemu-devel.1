Received: from eggs.gnu.org ([2001:4830:134:3::10]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbaIs-00051H-Pb
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbaIo-0008KS-Kg
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:01:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbaIo-0008Jr-Cx
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 17:01:26 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<755a17f2d8daf7d2a62b23bb8957c114a93ccf12.1486285434.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e00d3f7f-93bf-6db5-72cd-9e4c09b9c2ce@redhat.com>
Date: Wed, 8 Feb 2017 23:01:22 +0100
MIME-Version: 1.0
In-Reply-To: <755a17f2d8daf7d2a62b23bb8957c114a93ccf12.1486285434.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qmp/hmp: add set-vm-generation-id
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 02/05/17 10:12, ben@skyportsystems.com wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> Add set-vm-generation-id command to set Virtual Machine
> Generation ID counter.
> 
> QMP command example:
>     { "execute": "set-vm-generation-id",
>           "arguments": {
>               "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>           }
>     }
> 
> HMP command example:
>     set-vm-generation-id guid=324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hmp-commands.hx   | 13 +++++++++++++
>  hmp.c             | 12 ++++++++++++
>  hmp.h             |  1 +
>  hw/acpi/vmgenid.c | 12 ++++++++++++
>  qapi-schema.json  | 11 +++++++++++
>  stubs/vmgenid.c   |  6 ++++++
>  6 files changed, 55 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 8819281..56744aa 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1775,5 +1775,18 @@ ETEXI
>      },
>  
>  STEXI
> +@item set-vm-generation-id @var{uuid}
> +Set Virtual Machine Generation ID counter to @var{guid}
> +ETEXI
> +
> +    {
> +        .name       = "set-vm-generation-id",
> +        .args_type  = "guid:s",
> +        .params     = "guid",
> +        .help       = "Set Virtual Machine Generation ID counter",
> +        .cmd = hmp_set_vm_generation_id,
> +    },
> +
> +STEXI
>  @end table
>  ETEXI
> diff --git a/hmp.c b/hmp.c
> index 535613d..39c8965 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2574,3 +2574,15 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
>      }
>      qapi_free_GuidInfo(info);
>  }
> +
> +void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict)
> +{
> +    Error *errp = NULL;
> +    const char *guid = qdict_get_str(qdict, "guid");
> +
> +    qmp_set_vm_generation_id(guid, &errp);
> +    if (errp) {
> +        hmp_handle_error(mon, &errp);
> +        return;

This return statement is superfluous.

> +    }
> +}
> diff --git a/hmp.h b/hmp.h
> index 799fd37..e0ac1e8 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -138,5 +138,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
>  void hmp_info_dump(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
> +void hmp_set_vm_generation_id(Monitor *mon, const QDict *qdict);
>  
>  #endif
> diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
> index e148051..af8b35c 100644
> --- a/hw/acpi/vmgenid.c
> +++ b/hw/acpi/vmgenid.c
> @@ -224,3 +224,15 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
>      info->guid = qemu_uuid_unparse_strdup(&guid);
>      return info;
>  }
> +
> +void qmp_set_vm_generation_id(const char *guid, Error **errp)
> +{
> +    Object *obj = find_vmgenid_dev(errp);
> +
> +    if (!obj) {
> +        return;
> +    }
> +
> +    object_property_set_str(obj, guid, VMGENID_GUID, errp);
> +    return;

This too.

> +}
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 384a7f3..ed2657d 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -6051,3 +6051,14 @@
>  # Since 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +##
> +# @set-vm-generation-id:
> +#
> +# Set Virtual Machine Generation ID
> +#
> +# @guid: new GUID to set as Virtual Machine Generation ID
> +#
> +# Since 2.9
> +##
> +{ 'command': 'set-vm-generation-id', 'data': {'guid': 'str'} }
> diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
> index 8c448ac..d25d41b 100644
> --- a/stubs/vmgenid.c
> +++ b/stubs/vmgenid.c
> @@ -6,3 +6,9 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
>      error_setg(errp, "this command is not currently supported");
>      return NULL;
>  }
> +
> +void qmp_set_vm_generation_id(const char *guid, Error **errp)
> +{
> +    error_setg(errp, "this command is not currently supported");
> +    return;

And this.

Thanks,
Laszlo

> +}
> 
