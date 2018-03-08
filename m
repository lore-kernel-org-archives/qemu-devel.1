Received: from eggs.gnu.org ([2001:4830:134:3::10]:54774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etzFu-00066b-K6
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etzFr-0007sP-EG
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:23:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1etzFr-0007s9-9E
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:22:59 -0500
References: <20180308023337.21062-1-haozhong.zhang@intel.com>
	<20180308023337.21062-3-haozhong.zhang@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42a520ee-9715-3a88-21bc-2b0b11f5d6f3@redhat.com>
Date: Thu, 8 Mar 2018 11:22:47 -0600
MIME-Version: 1.0
In-Reply-To: <20180308023337.21062-3-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qmp: distinguish PC-DIMM and NVDIMM
 in MemoryDeviceInfoList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Markus Armbruster <armbru@redhat.com>, dgilbert@redhat.com

On 03/07/2018 08:33 PM, Haozhong Zhang wrote:
> It may need to treat PC-DIMM and NVDIMM differently, e.g., when
> deciding the necessity of non-volatile flag bit in SRAT memory
> affinity structures.
> 
> NVDIMMDeviceInfo, which inherits from PCDIMMDeviceInfo, is added to
> union type MemoryDeviceInfo to record information of NVDIMM devices.
> The NVDIMM-specific data is currently left empty and will be filled
> when necessary in the future.
> 
> It also fixes "info memory-devices"/query-memory-devices which
> currently show nvdimm devices as dimm devices since
> object_dynamic_cast(obj, TYPE_PC_DIMM) happily cast nvdimm to
> TYPE_PC_DIMM which it's been inherited from.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---

> +++ b/qapi/misc.json
> @@ -2830,6 +2830,18 @@
>             }
>   }
>   
> +##
> +# @NVDIMMDeviceInfo:
> +#
> +# NVDIMMDevice state information
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'NVDIMMDeviceInfo',
> +  'base': 'PCDIMMDeviceInfo',
> +  'data': {}
> +}
> +

As long as you don't have any data members to add, you could omit this 
type...

>   ##
>   # @MemoryDeviceInfo:
>   #
> @@ -2837,7 +2849,11 @@
>   #
>   # Since: 2.1
>   ##
> -{ 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
> +{ 'union': 'MemoryDeviceInfo',
> +  'data': { 'dimm': 'PCDIMMDeviceInfo',
> +            'nvdimm': 'NVDIMMDeviceInfo'
> +          }

and just write this as

  'data': { 'dimm': 'PCDIMMDeviceInfo',
            'nvdimm': 'PCDIMMDeviceInfo' }

If, down the road, you want to add data members to one but not both of 
the branches, we can add a new (sub-)type at that time, and it won't 
break backwards compatibility.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
