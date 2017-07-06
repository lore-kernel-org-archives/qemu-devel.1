Received: from eggs.gnu.org ([2001:4830:134:3::10]:40582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTB0X-0003mn-K6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTB0T-0004mx-Is
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTB0T-0004lZ-9Y
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:56:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Thu, 06 Jul 2017 19:55:56 +0200
In-Reply-To: <1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	(Pradeep Jagadeesh's message of "Tue, 4 Jul 2017 11:30:59 -0400")
Message-ID: <87bmoxcuvn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:

> This patch enables qmp interfaces for the fsdev
> devices. This provides two interfaces one 
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  qapi/block-core.json | 76 ++-------------------------------------------
>  qapi/iothrottle.json | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 73 deletions(-)
>  create mode 100644 qapi/iothrottle.json
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f85c223..9320974 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -6,6 +6,7 @@
>  
>  # QAPI common definitions
>  { 'include': 'common.json' }
> +{ 'include': 'iothrottle.json' }
>  
>  ##
>  # @SnapshotInfo:
> @@ -1761,84 +1762,13 @@
>  #
>  # @device: Block device name (deprecated, use @id instead)
>  #
> -# @id: The name or QOM path of the guest device (since: 2.8)
> -#
> -# @bps: total throughput limit in bytes per second
> -#
> -# @bps_rd: read throughput limit in bytes per second
> -#
> -# @bps_wr: write throughput limit in bytes per second
> -#
> -# @iops: total I/O operations per second
> -#
> -# @iops_rd: read I/O operations per second
> -#
> -# @iops_wr: write I/O operations per second
> -#
> -# @bps_max: total throughput limit during bursts,
> -#                     in bytes (Since 1.7)
> -#
> -# @bps_rd_max: read throughput limit during bursts,
> -#                        in bytes (Since 1.7)
> -#
> -# @bps_wr_max: write throughput limit during bursts,
> -#                        in bytes (Since 1.7)
> -#
> -# @iops_max: total I/O operations per second during bursts,
> -#                      in bytes (Since 1.7)
> -#
> -# @iops_rd_max: read I/O operations per second during bursts,
> -#                         in bytes (Since 1.7)
> -#
> -# @iops_wr_max: write I/O operations per second during bursts,
> -#                         in bytes (Since 1.7)
> -#
> -# @bps_max_length: maximum length of the @bps_max burst
> -#                            period, in seconds. It must only
> -#                            be set if @bps_max is set as well.
> -#                            Defaults to 1. (Since 2.6)
> -#
> -# @bps_rd_max_length: maximum length of the @bps_rd_max
> -#                               burst period, in seconds. It must only
> -#                               be set if @bps_rd_max is set as well.
> -#                               Defaults to 1. (Since 2.6)
> -#
> -# @bps_wr_max_length: maximum length of the @bps_wr_max
> -#                               burst period, in seconds. It must only
> -#                               be set if @bps_wr_max is set as well.
> -#                               Defaults to 1. (Since 2.6)
> -#
> -# @iops_max_length: maximum length of the @iops burst
> -#                             period, in seconds. It must only
> -#                             be set if @iops_max is set as well.
> -#                             Defaults to 1. (Since 2.6)
> -#
> -# @iops_rd_max_length: maximum length of the @iops_rd_max
> -#                                burst period, in seconds. It must only
> -#                                be set if @iops_rd_max is set as well.
> -#                                Defaults to 1. (Since 2.6)
> -#
> -# @iops_wr_max_length: maximum length of the @iops_wr_max
> -#                                burst period, in seconds. It must only
> -#                                be set if @iops_wr_max is set as well.
> -#                                Defaults to 1. (Since 2.6)
> -#
> -# @iops_size: an I/O size in bytes (Since 1.7)
> -#
>  # @group: throttle group name (Since 2.4)
>  #
>  # Since: 1.1
>  ##
>  { 'struct': 'BlockIOThrottle',
> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
> -            '*bps_max': 'int', '*bps_rd_max': 'int',
> -            '*bps_wr_max': 'int', '*iops_max': 'int',
> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> -            '*iops_size': 'int', '*group': 'str' } }
> +  'base': 'IOThrottle',
> +  'data': { '*device': 'str', '*group': 'str' } }
>  
>  ##
>  # @block-stream:
> diff --git a/qapi/iothrottle.json b/qapi/iothrottle.json
> new file mode 100644
> index 0000000..0f067c3
> --- /dev/null
> +++ b/qapi/iothrottle.json
> @@ -0,0 +1,88 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == QAPI IOThrottle definitions
> +##
> +
> +##
> +# @IOThrottle:
> +#
> +# A set of parameters describing IO throttling
> +#
> +# @id: The name or QOM path of the guest device (since: 2.8)
> +#
> +# @bps: total throughput limit in bytes per second
> +#
> +# @bps_rd: read throughput limit in bytes per second
> +#
> +# @bps_wr: write throughput limit in bytes per second
> +#
> +# @iops: total I/O operations per second
> +#
> +# @iops_rd: read I/O operations per second
> +#
> +# @iops_wr: write I/O operations per second
> +#
> +# @bps_max: total throughput limit during bursts,
> +#                     in bytes (Since 1.7)
> +#
> +# @bps_rd_max: read throughput limit during bursts,
> +#                        in bytes (Since 1.7)
> +#
> +# @bps_wr_max: write throughput limit during bursts,
> +#                        in bytes (Since 1.7)
> +#
> +# @iops_max: total I/O operations per second during bursts,
> +#                      in bytes (Since 1.7)
> +#
> +# @iops_rd_max: read I/O operations per second during bursts,
> +#                         in bytes (Since 1.7)
> +#
> +# @iops_wr_max: write I/O operations per second during bursts,
> +#                         in bytes (Since 1.7)
> +#
> +# @bps_max_length: maximum length of the @bps_max burst
> +#                            period, in seconds. It must only
> +#                            be set if @bps_max is set as well.
> +#                            Defaults to 1. (Since 2.6)
> +#
> +# @bps_rd_max_length: maximum length of the @bps_rd_max
> +#                               burst period, in seconds. It must only
> +#                               be set if @bps_rd_max is set as well.
> +#                               Defaults to 1. (Since 2.6)
> +#
> +# @bps_wr_max_length: maximum length of the @bps_wr_max
> +#                               burst period, in seconds. It must only
> +#                               be set if @bps_wr_max is set as well.
> +#                               Defaults to 1. (Since 2.6)
> +#
> +# @iops_max_length: maximum length of the @iops burst
> +#                             period, in seconds. It must only
> +#                             be set if @iops_max is set as well.
> +#                             Defaults to 1. (Since 2.6)
> +#
> +# @iops_rd_max_length: maximum length of the @iops_rd_max
> +#                                burst period, in seconds. It must only
> +#                                be set if @iops_rd_max is set as well.
> +#                                Defaults to 1. (Since 2.6)
> +#
> +# @iops_wr_max_length: maximum length of the @iops_wr_max
> +#                                burst period, in seconds. It must only
> +#                                be set if @iops_wr_max is set as well.
> +#                                Defaults to 1. (Since 2.6)
> +#
> +# @iops_size: an I/O size in bytes (Since 1.7)
> +#
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'IOThrottle',
> +  'data': { '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> +            '*iops_size': 'int' } }

Awkward question for a v7, but here goes anyway: why is IOThrottle worth
its very own .json file?

Diff can't show the differences (if any), because you factor IOThrottle
out of BlockIOThrottle and move it in a single patch.  I had to extract
and diff by hand.
