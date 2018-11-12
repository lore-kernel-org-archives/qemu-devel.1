Received: from eggs.gnu.org ([2001:4830:134:3::10]:46383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMF3d-0002dD-5Z
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMF3H-0004XI-60
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:27:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMF3G-0004TB-F9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:27:02 -0500
References: <A02D6AA901860840B46E751C5E9E38B42AFDB150@DGGEML532-MBX.china.huawei.com>
	<A02D6AA901860840B46E751C5E9E38B43CC96A3B@DGGEML532-MBX.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6c3c3a4-e82a-ce67-da68-c8d03a77a289@redhat.com>
Date: Mon, 12 Nov 2018 10:26:51 -0600
MIME-Version: 1.0
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B43CC96A3B@DGGEML532-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-9p: qmp interface to set/query
 io throttle for fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

On 11/11/18 7:12 PM, xiezhide wrote:
> This patch provide qmp interface to set/query io throttle for fsdev devices.

This patch is titled 1/2, but not threaded to a 0/2 or 2/2 patch. 
Remember that proper threading aids reviewers.

> 
> This patch include following work:
> 1. port Pradeep Jagadeesh's patches, details please review
>   http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00173.html
> 2. fix two issue:
> (1). qmp set io throttle code dump when qemu start CLI not include io throttle params
> (2). issue Berto comment at: http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03150.html
> 3. resolve back-compat issue Eric comment at: http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03149.html
> 
> Signed-off-by: x00390961 <xiezhide@huawei.com<mailto:xiezhide@huawei.com>>
> ---
> Makefile                                             |  20 +++-
> Makefile.objs                                    |   8 ++
> block/throttle.c                                |   6 +-

Indentation is really weird here. Are you using 'git send-email' 
directly, or did you do some copy-and-paste that corrupted whitespace?

> util/throttle.c                                      | 224 ++++++++++++++++++++++++++--------------
> 22 files changed, 640 insertions(+), 354 deletions(-)
> create mode 100644 qapi/fsdev.json
> create mode 100644 qapi/tlimits.json

That's a rather big patch to review - you're refactoring existing code 
AND adding new code in the same patch. Can you break it into smaller 
pieces, to aid reviewers?

> +++ b/Makefile
> @@ -94,6 +94,7 @@ GENERATED_FILES += qapi/qapi-types-block-core.h qapi/qapi-types-block-core.c
> GENERATED_FILES += qapi/qapi-types-block.h qapi/qapi-types-block.c
> GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
> GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
> +GENERATED_FILES += qapi/qapi-types-tlimits.h qapi/qapi-types-tlimits.c

Corrupt patch - where's the leading blank on unchanged context lines?


> +++ b/qapi/block-core.json
> @@ -8,6 +8,7 @@
> { 'include': 'crypto.json' }
> { 'include': 'job.json' }
> { 'include': 'sockets.json' }
> +{ 'include': 'tlimits.json' }
> 
>   ##
> # @SnapshotInfo:
> @@ -2150,130 +2151,13 @@
> #
> # @id: The name or QOM path of the guest device (since: 2.8)
> #

> -# @iops_size: an I/O size in bytes (Since 1.7)
> -#
> # @group: throttle group name (Since 2.4)
> #
> # Since: 1.1
> ##
> { 'struct': 'BlockIOThrottle',
> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
> -            '*bps_max': 'int', '*bps_rd_max': 'int',
> -            '*bps_wr_max': 'int', '*iops_max': 'int',
> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> -            '*iops_size': 'int', '*group': 'str' } }
> -
> -##
> -# @ThrottleLimits:

> -#
> -# Since: 2.11
> -##
> -{ 'struct': 'ThrottleLimits',
> -  'data': { '*iops-total' : 'int', '*iops-total-max' : 'int',
> -            '*iops-total-max-length' : 'int', '*iops-read' : 'int',
> -            '*iops-read-max' : 'int', '*iops-read-max-length' : 'int',
> -            '*iops-write' : 'int', '*iops-write-max' : 'int',
> -            '*iops-write-max-length' : 'int', '*bps-total' : 'int',
> -            '*bps-total-max' : 'int', '*bps-total-max-length' : 'int',
> -            '*bps-read' : 'int', '*bps-read-max' : 'int',
> -            '*bps-read-max-length' : 'int', '*bps-write' : 'int',
> -            '*bps-write-max' : 'int', '*bps-write-max-length' : 'int',
> -            '*iops-size' : 'int' } }
> +  'base': 'ThrottleLimits',
> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }

Okay, so it looks like you are moving throttle limits to a new file?

> 
>   ##
> # @block-stream:
> diff --git a/qapi/fsdev.json b/qapi/fsdev.json
> new file mode 100644
> index 0000000..2df8ec1
> --- /dev/null
> +++ b/qapi/fsdev.json
> @@ -0,0 +1,96 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == QAPI fsdev definitions
> +##
> +
> +{ 'include': 'tlimits.json' }
> +
> +##
> +# @FsdevIOThrottle:
> +#
> +# A set of parameters describing fsdev throttling.
> +#
> +# @id: device id
> +#
> +# Since: 2.11

Is 2.11 the correct release? Perhaps so, if this struct is being reused 
by existing code, and you just refactored to move it to a new file.


> +##
> +{ 'struct': 'FsdevIOThrottle',
> +  'base': 'ThrottleLimits',
> +  'data': { '*id': 'str' } }
> +
> +##
> +# @fsdev-set-io-throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# I/O limits can be enabled by setting throttle value to non-zero number.
> +#
> +# I/O limits can be disabled by setting all throttle values to 0.
> +#
> +# Returns: Nothing on success
> +#          If @device is not a valid fsdev device, GenericError
> +#
> +# Since: 2.11

However, isn't this a new command?  If that's the case, you definitely 
don't want 2.11 here; you've missed 3.1, and the next release will be 
4.0 (although there are still threads mentioning 3.2).

> +++ b/qapi/tlimits.json
> @@ -0,0 +1,89 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == Throttle limits (VM unrelated)

What does 'VM unrelated' mean?

> +##
> +
> +##
> +# @ThrottleLimits:
> +#
> +# Limit parameters for throttling.
> +# Since some limit combinations are illegal, limits should always be set in one
> +# transaction. All fields are optional. When setting limits, if a field is
> +# missing the current value is not changed.
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
> +# Since: 2.11
> +#
> +##
> +{ 'struct': 'ThrottleLimits',
> +  'data': { '*bps': 'int', '*bps_rd': 'int',
> +            '*bps_wr': 'int', '*iops': 'int', '*iops_rd': 'int', '*iops_wr': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
> +            '*iops_size': 'int' } }
> diff --git a/qmp.c b/qmp.c
> index e7c0a2f..18b1f0f 100644
> --- a/qmp.c


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
