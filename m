Received: from eggs.gnu.org ([2001:4830:134:3::10]:34835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOxP-0000cg-1e
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOxJ-0003gS-Ul
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:16:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOxJ-0003fb-PT
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:16:29 -0400
References: <1525854998-14243-1-git-send-email-jingqi.liu@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7279dfe4-ca56-dbc7-c26f-ca566267a937@redhat.com>
Date: Wed, 9 May 2018 08:16:28 -0500
MIME-Version: 1.0
In-Reply-To: <1525854998-14243-1-git-send-email-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/7] numa: Extend the command-line to
 provide memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 05/09/2018 03:36 AM, Liu Jingqi wrote:
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> ---

> +++ b/qapi/misc.json
> @@ -2705,7 +2705,7 @@
>   # Since: 2.1
>   ##
>   { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }

Missing documentation for the new addition, particularly that it is 
'(since 2.13)'.


>   ##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information between Initiator and Target proximity Domains.

Long line here and elsewhere. Please keep this file wrapped below 80 
columns.

> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance of memory or side cache.
> +#
> +# @level: indicates the level of side cache, if it's the performance of side cache.
> +#
> +# @data-type: presents the type of data, access/read/write latency or hit latency.
> +#
> +# @base-lat: the base unit for latency in nanosecondsbytes.

Is that supposed to be nanoseconds/bytes?

> +#
> +# @base-bw: the base unit for bandwidth in megabytes per second(MB/s).
> +#
> +# @latency: the value of latency based on Base Unit from @initiator to @target proximity domain.
> +#
> +# @bandwidth: the value of bandwidth based on Base Unit between @initiator to @target proximity domain.
> +#
> +# Since: 2.10

Not even close.  The soonest this could make it in is 2.13.

> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +  'data': {
> +   'initiator': 'uint16',
> +   'target': 'uint16',
> +   'hierarchy': 'str',

Is this really a free-form string, or is it better as an enum type?

> +   '*level': 'uint8',
> +   'data-type': 'str',

Ditto.

> +   '*base-lat': 'uint64',
> +   '*base-bw': 'uint64',
> +   '*latency': 'uint16',
> +   '*bandwidth': 'uint16' }}
> +


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
