Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPy0u-000222-T6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPy0r-0002GH-QU
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:31:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fPy0r-0002G5-Kz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:31:41 -0400
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-6-xiaoguangrong@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09358622-9975-3aa3-6201-cdbe77b021dc@redhat.com>
Date: Mon, 4 Jun 2018 17:31:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180604095520.8563-6-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

On 06/04/2018 04:55 AM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Then the uses can adjust the parameters based on this info
> 
> Currently, it includes:
> pages: amount of pages compressed and transferred to the target VM
> busy: amount of count that no free thread to compress data
> busy-rate: rate of thread busy
> reduced-size: amount of bytes reduced by compression
> compression-rate: rate of compressed size
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---

> +++ b/qapi/migration.json
> @@ -72,6 +72,26 @@
>              'cache-miss': 'int', 'cache-miss-rate': 'number',
>              'overflow': 'int' } }
>   
> +##
> +# @CompressionStats:
> +#
> +# Detailed compression migration statistics

Sounds better as s/compression migration/migration compression/

> +#
> +# @pages: amount of pages compressed and transferred to the target VM
> +#
> +# @busy: amount of count that no free thread to compress data

Not sure what was meant, maybe:

@busy: count of times that no free thread was available to compress data

> +#
> +# @busy-rate: rate of thread busy

In what unit? pages per second?

> +#
> +# @reduced-size: amount of bytes reduced by compression
> +#
> +# @compression-rate: rate of compressed size

In what unit?

> +#
> +##

Missing a 'Since: 3.0' tag

> +{ 'struct': 'CompressionStats',
> +  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
> +	   'reduced-size': 'int', 'compression-rate': 'number' } }
> +
>   ##
>   # @MigrationStatus:
>   #
> @@ -169,6 +189,8 @@
>   #           only present when the postcopy-blocktime migration capability
>   #           is enabled. (Since 2.13)

Pre-existing - we need to fix this 2.13 to be 3.0 (if it isn't already 
fixed)

>   #
> +# @compression: compression migration statistics, only returned if compression
> +#           feature is on and status is 'active' or 'completed' (Since 2.14)

There will not be a 2.14 (for that matter, not even a 2.13).  The next 
release is 3.0.

>   #
>   # Since: 0.14.0
>   ##
> @@ -183,7 +205,8 @@
>              '*cpu-throttle-percentage': 'int',
>              '*error-desc': 'str',
>              '*postcopy-blocktime' : 'uint32',
> -           '*postcopy-vcpu-blocktime': ['uint32']} }
> +           '*postcopy-vcpu-blocktime': ['uint32'],
> +           '*compression': 'CompressionStats'} }
>   
>   ##
>   # @query-migrate:
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
