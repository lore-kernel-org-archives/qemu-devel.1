Received: from eggs.gnu.org ([2001:4830:134:3::10]:36915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2sJ-0006Jy-MA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er2sI-0006cg-QE
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:38:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1er2sI-0006cR-Kh
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:38:30 -0500
References: <20180228133912.21496-1-idgar@virtualoco.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59f157f9-b20e-3d68-7fa6-e97210b92c6e@redhat.com>
Date: Wed, 28 Feb 2018 08:38:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180228133912.21496-1-idgar@virtualoco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vmgenid: allow VM Generation ID
 modification via QMP/HMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Or Idgar <idgar@virtualoco.com>, ben@skyportsystems.com, dgilbert@redhat.com, mst@redhat.com, imammedo@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Cc: oidgar@redhat.com, ghammer@redhat.com

On 02/28/2018 07:39 AM, Or Idgar wrote:
> From: Or Idgar <oidgar@redhat.com>
> 
> This patch allow changing the Virtual Machine Generation

s/allow/allows/

> ID through QMP/HMP while the vm guest is running.

That's the description of "what" the patch is doing, but not the "why" - 
you want to give some justification why this is useful.  Especially since...

> As the definition block of VMGENID in ACPI includes the
> "Notify" method, we can use it to notify the guest about
> ID changes.
> 
> QMP command example:
>      { "execute": "set-vm-generation-id",
>            "arguments": {
>                "guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>            }
>      }
> 
> HMP command example:
>      set-vm-generation-id 324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
> 
> This patch is based off an earlier version by
> Igor Mammedov (imammedo@redhat.com)
> 
> Signed-off-by: Or Idgar <oidgar@redhat.com>
> Reviewed-by: Gal Hammer <ghammer@redhat.com>
> ---

> +++ b/docs/specs/vmgenid.txt
> @@ -240,6 +240,7 @@ The property may be queried via QMP/HMP:
>     (QEMU) query-vm-generation-id
>     {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>   
> -Setting of this parameter is intentionally left out from the QMP/HMP
> -interfaces.  There are no known use cases for changing the GUID once QEMU is
> -running, and adding this capability would greatly increase the complexity.

...the old docs said no known use exists.  Obviously, you wouldn't be 
adding this unless you had a use case, so please describe that use case 
as the "why".

> +Also, the property may be set via QMP/HMP:
> +
> +  (QEMU) set-vm-generation-id guid=ee6726ce-73b4-4a8b-863c-708f26515847
> +  {"return": {}}
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 4afd57c..4524669 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1871,5 +1871,18 @@ ETEXI
>       },
>   
>   STEXI
> +@item set-vm-generation-id @var{uuid}

HMP commands are generally named with _ rather than -; and are geared 
for easy human consumption (abbreviation is permitted), so I might have 
named the HMP version set_vm_genid.

> +++ b/qapi-schema.json
> @@ -3193,6 +3193,17 @@
>   { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>   
>   ##
> +# @set-vm-generation-id:
> +#
> +# Set Virtual Machine Generation ID
> +#
> +# @guid: new GUID to set as Virtual Machine Generation ID
> +#
> +# Since 2.12
> +##
> +{ 'command': 'set-vm-generation-id', 'data': { 'guid': 'str' } }
> +

The QMP portion looks reasonable.  However, without a why, I'm reluctant 
to give R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
