Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7di-0000et-Ef
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7dc-0002Og-EB
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:06:42 -0500
References: <20180206140722.10110-1-vsementsov@virtuozzo.com>
	<20180206140722.10110-3-vsementsov@virtuozzo.com>
	<c501a095-43e6-95f3-b7bb-96ab80f99689@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cf41e939-1670-89a5-ab2b-0f182a7555fa@virtuozzo.com>
Date: Tue, 6 Feb 2018 21:06:15 +0300
MIME-Version: 1.0
In-Reply-To: <c501a095-43e6-95f3-b7bb-96ab80f99689@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: add block latency histogram
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

06.02.2018 18:50, Eric Blake wrote:
> On 02/06/2018 08:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Set (and clear) histogram through new command
>> block-latency-histogram-set and show new statistics in
>> query-blockstats results.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block-core.json | 62=20
>> +++++++++++++++++++++++++++++++++++++++++++++++++++-
>> =C2=A0 block/qapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31=
 ++++++++++++++++++++++++++
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 15 +++++++++++++
>> =C2=A0 3 files changed, 107 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 8225308904..4706a934d9 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -451,6 +451,63 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'status': 'DirtyBitmapStatus'} }
>> =C2=A0 =C2=A0 ##
>> +# @BlockLatencyHistogramInfo:
>> +#
>> +# Block latency histogram.
>> +#
>> +# @latency: list of latency points in microseconds. Equals to=20
>> @latency parameter
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of last c=
alled block-latency-histogram-set.
>
> Second sentence might read better as:
>
> Matches the @latency parameter from the last call to=20
> block-latency-histogram-set for the given device.
>
>> +#
>> +# @read: list of read-request counts corresponding to latency region.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len(@read) =3D len(@latency=
) + 1
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @read[0] corresponds to lat=
ency region [0, @latency[0])
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for 0 < i < len(@latency): =
@read[i] corresponds to latency=20
>> region
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [@l=
atency[i-1], @latency[i])
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @read.last_element correspo=
nds to latency region
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [@l=
atency.last_element, +inf)
>> +#
>> +# @write: list of write-request counts (see @read semantics)
>> +#
>> +# @flush: list of flush-request counts (see @read semantics)
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'BlockLatencyHistogramInfo',
>> +=C2=A0 'data': {'latency': ['uint64'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'read': ['=
uint64'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'write': [=
'uint64'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'flush': [=
'uint64'] } }
>
> Okay, I can see how this interface works.
>
>> +
>> +##
>> +# @block-latency-histogram-set:
>> +#
>> +# Add latency histogram to block device. If latency histogram alredy=20
>> exists for
>
> s/latency/a latency/ (twice)
> s/alredy/already/
>
>> +# the device it will be removed and a new one created. Latency=20
>> histogram may be
>
> s/Latency/The latency/
>
>> +# quered through query-blockstats.
>
> s/quered/queried/
>
>> +#
>> +# @device: device name to set latency histogram for.
>> +#
>> +# @latency: list of latency points in microseconds. The sequcence=20
>> must be
>
> s/sequcence/sequence/
>
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ascending=
, elements must be greater than zero. Histogram=20
>> latency
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regions w=
ould be
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0, @late=
ncy[0]), ..., [@latency[i], @latency[i+1]), ...,
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [@latency=
.last_element, +inf)
>> +#
>> +# Returns: error if device is not found.
>> +#
>> +# Since: 2.12
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "block-latency-histogram-set",
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "arguments": { "device": "drive0",
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "latency": [500000, 100=
0000, 2000000] } }
>> +# <- { "return": {} }
>> +##
>> +{ 'command': 'block-latency-histogram-set',
>> +=C2=A0 'data': {'device': 'str', 'latency': ['uint64'] } }
>
> The commit message mentioned that you can set and clear histogram=20
> tracking; how does this interface let you clear things?=C2=A0 By passing =
a=20
> 0-length latency array?=C2=A0 If you violate the constraint (pass=20
> non-ascending points, for example), does the previous latency map get=20
> wiped out or is it still preserved unchanged?

On error nothing is changed.

By "clear" I mean zeroing statistics, not removing the whole histogram.=20
And to zero statistics you can call set with the same latency array.
There is no way to remove histogram at all.. We can add=20
block-latency-histogram-unset later if needed.

>
>> +
>> +##
>> =C2=A0 # @BlockInfo:
>> =C2=A0 #
>> =C2=A0 # Block device information.=C2=A0 This structure describes a virt=
ual=20
>> device and
>> @@ -730,6 +787,8 @@
>> =C2=A0 # @timed_stats: Statistics specific to the set of previously defi=
ned
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 intervals of time (Since 2.5)
>> =C2=A0 #
>> +# @latency-histogram: @BlockLatencyHistogramInfo. (Since 2.12)
>
> I'd mention that this only appears if block-latency-histogram-set has=20
> been called.

yes

>
>> +#
>> =C2=A0 # Since: 0.14.0
>> =C2=A0 ##
>> =C2=A0 { 'struct': 'BlockDeviceStats',
>> @@ -742,7 +801,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'failed_flush_operations': 'int',=20
>> 'invalid_rd_operations': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'invalid_wr_operations': 'int',=20
>> 'invalid_flush_operations': 'int',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'account_invalid': 'bool', 'account_failed': 'bool',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'timed_sta=
ts': ['BlockDeviceTimedStats'] } }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'timed_sta=
ts': ['BlockDeviceTimedStats'],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*latency-=
histogram': 'BlockLatencyHistogramInfo' } }
>
>


--=20
Best regards,
Vladimir
