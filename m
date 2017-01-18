Received: from eggs.gnu.org ([2001:4830:134:3::10]:48488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTm2F-0005en-4Z
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTm2B-00023c-Vg
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTm2B-00023J-Mj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:55:59 -0500
Date: Wed, 18 Jan 2017 09:55:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118095556.1ff151cb@nial.brq.redhat.com>
In-Reply-To: <625a11ec95fc51d4aae4811a06eab586454e1135.1484594095.git.ben@skyportsystems.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
	<625a11ec95fc51d4aae4811a06eab586454e1135.1484594095.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] qmp/hmp: add set-vm-generation-id
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org

On Mon, 16 Jan 2017 11:20:57 -0800
ben@skyportsystems.com wrote:

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
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
when you are reposting someone else written patch,
you are supposed to keep SoB lines patch has had and just add
your own SoB after original SoB lines.

If you made non trivial change to the patch then ask
original author(s) if they wish to keep their SoB
before posting modified patch.
(Usually I do it offline).

> ---
>  hmp-commands.hx  | 13 +++++++++++++
>  hmp.c            | 12 ++++++++++++
>  hmp.h            |  1 +
>  qapi-schema.json | 12 ++++++++++++
>  stubs/vmgenid.c  |  6 ++++++
>  5 files changed, 44 insertions(+)
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
> index 9ec27ae..a54a312 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2579,3 +2579,15 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
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
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 2348391..c5ebea4 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4796,3 +4796,15 @@
>  # Since 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +##
> +# @set-vm-generation-id
> +#
> +# Set Virtual Machine Generation ID
> +#
> +# @changed: Is the Virtual Machine Generation ID a new value?
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
> +}
