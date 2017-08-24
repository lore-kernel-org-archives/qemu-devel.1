Received: from eggs.gnu.org ([2001:4830:134:3::10]:49661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkmV0-0005iS-Ky
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkmUz-0006VM-Or
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:24:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-32-git-send-email-armbru@redhat.com>
	<w51wp5uh03w.fsf@maestria.local.igalia.com>
Date: Thu, 24 Aug 2017 09:24:03 +0200
In-Reply-To: <w51wp5uh03w.fsf@maestria.local.igalia.com> (Alberto Garcia's
	message of "Wed, 23 Aug 2017 15:42:11 +0200")
Message-ID: <87mv6pqvho.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 31/56] block: Make
 throttle byte rates and sizes unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

Alberto Garcia <berto@igalia.com> writes:

> On Mon 07 Aug 2017 04:45:35 PM CEST, Markus Armbruster wrote:
>> Sizes and byte rates should use QAPI type 'size' (uint64_t).
>> BlockIOThrottle and BlockDeviceInfo members @bps, @bps_rd, @bps_wr,
>> @bps_max, @bps_rd_max, @bps_wr_max, @iops_size are 'int' (int64_t).
>> qmp_block_set_io_throttle() and bdrv_block_device_info() copy @bps,
>> @bps_rd, @bps_wr to / from LeakyBucket member @avg (implicit
>> conversion to / from double), @bps_max, @bps_rd_max, @bps_wr_max to /
>> from LeakyBucket member @max (implicit conversion to / from double),
>> and @iops_size to / from ThrottleConfig member op_size (implicit
>> conversion to / from uint64_t).
>>
>> Change these BlockIOThrottle and BlockDeviceInfo members to 'size'.
>>
>> block_set_io_throttle now accepts sizes and rates between 2^63 and
>> 2^64-1.  It accepts negative values as before, because that's how the
>> QObject input visitor works for backward compatibility.
>>
>> Doing the same for HMP's block_set_io_throttle deserves its own commit
>> (the next one).
>>
>> query-block and query-named-block-nodes now report sizes and rates
>> above 2^63-1 correctly instead of their (negative) two's complement.
>>
>> So does HMP's "info block".
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> This is fine because all those parameters are limited to [0, 10^15], so
> changing int64_t -> uint64_t is not a problem.
>
> I have already sent a patch that changes the fields in the data
> structure in throttle.h from double to uint64_t

I expect v2 to be based on your patch.  Might simplify the commit
message.

> Reviewed-by: Alberto Garcia <berto@igalia.com>

Thanks!
