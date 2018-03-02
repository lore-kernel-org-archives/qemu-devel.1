Received: from eggs.gnu.org ([2001:4830:134:3::10]:53881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erksi-00086o-AQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erksf-0004Wj-40
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:37:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erkse-0004WT-Tf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:37:49 -0500
References: <20180301130939.15875-1-aik@ozlabs.ru>
	<20180301130939.15875-2-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3986fcf2-844d-bc49-d297-960f788c3941@redhat.com>
Date: Fri, 2 Mar 2018 07:37:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180301130939.15875-2-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 1/2] qmp: Merge ObjectPropertyInfo
 and DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

On 03/01/2018 07:09 AM, Alexey Kardashevskiy wrote:
> ObjectPropertyInfo is more generic and only missing @description.
> This adds a description to ObjectPropertyInfo and removes
> DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
> elsewhere.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   qapi-schema.json | 23 +++++------------------
>   qdev-monitor.c   |  6 +++---
>   qmp.c            | 20 ++++++++++----------
>   3 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 0262b9f..87327e5 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1266,10 +1266,12 @@
>   #        3) A link type in the form 'link<subtype>' where subtype is a qdev
>   #           device type name.  Link properties form the device model graph.
>   #
> +# @description: if specified, the description of the property.

Missing a '(since 2.12)' tag.

> +#
>   # Since: 1.2
>   ##
>   { 'struct': 'ObjectPropertyInfo',
> -  'data': { 'name': 'str', 'type': 'str' } }
> +  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
>   
> +++ b/qmp.c
> @@ -463,12 +463,12 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
>    *
>    * The caller must free the return value.
>    */
> -static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
> -                                                     const char *name,
> -                                                     const char *default_type,
> -                                                     const char *description)
> +static ObjectPropertyInfo *make_device_property_info(ObjectClass *klass,
> +                                                  const char *name,
> +                                                  const char *default_type,
> +                                                  const char *description)

Why the indentation change?

> @@ -508,14 +508,14 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
>       return info;
>   }
>   
> -DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
> -                                                   Error **errp)
> +ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> +                                                Error **errp)

and again

Otherwise looks okay

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
