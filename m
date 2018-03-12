Received: from eggs.gnu.org ([2001:4830:134:3::10]:39584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evIff-0001Cc-QS
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evIfe-0002zd-Ia
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 04:19:03 -0400
References: <20180309165212.97144-1-vsementsov@virtuozzo.com>
	<20180309165212.97144-3-vsementsov@virtuozzo.com>
	<29747b20-9a56-dcef-a058-e12264ecdda3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c1f6b47e-2029-1021-8d2b-e871a5b9660c@virtuozzo.com>
Date: Mon, 12 Mar 2018 11:18:46 +0300
MIME-Version: 1.0
In-Reply-To: <29747b20-9a56-dcef-a058-e12264ecdda3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qapi: add block latency histogram
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

11.03.2018 06:20, Eric Blake wrote:
> On 03/09/2018 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Set (and clear) histogram through new command
>> block-latency-histogram-set and show new statistics in
>> query-blockstats results.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block-core.json | 111=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>> =C2=A0 block/qapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 41 +++++++++++++++++++
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 43 ++++++++++++++++++++
>> =C2=A0 3 files changed, 194 insertions(+), 1 deletion(-)
>>
>
>> +# @boundaries: list of interval boundary values in nanoseconds, all=20
>> greater
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 than zero and in ascending order.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 For example, the list [10, 50, 100] produces the=20
>> following
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 histogram intervals: [0, 10), [10, 50), [50, 100),=20
>> [100, +inf).
>
> 10 vs. 50 nanoseconds is a bit unrealistic; the example makes sense=20
> but you may want to scale the boundaries into values that are more=20
> likely to make sense during use.=C2=A0 Can be a followup.

I've just taken Paolo's suggestion), not realistic, but do not occupy so=20
much space as mine. Be free to adjust it if you want

>
>> +#
>> +# @bins: list of io request counts corresponding to histogram=20
>> intervals.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len(@bins) =3D len(@boundar=
ies) + 1
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For the example above, @bin=
s may be something like [3, 1,=20
>> 5, 2],
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and corresponding histogram=
 looks like:
>> +#
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5|=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4|=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3| *=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2| *=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 *
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1| *=C2=A0=C2=A0=C2=A0 *=C2=
=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 *
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------------
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 10=C2=A0=C2=A0 50=C2=A0=C2=A0 100
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'XBlockLatencyHistogramInfo',
>
> Struct names have no impact to introspection; I see no reason to use a=20
> leading X here.
>
>> +=C2=A0 'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
>> +
>> +##
>> +# @x-block-latency-histogram-set:
>
> I guess you've decided that this should be experimental in 2.12? If=20
> you want to change the name and promote it to a released interface,=20
> you don't have much time left.

Yes. This is not random feature, it's required by our customers. And I=20
understood (after I remake it to support different bins for different io=20
types) that we are on the early stage of doing it, so it would be good=20
to have it in 2.12 with x-.

>
>
>> +#
>> +# @boundaries-read: list of interval boundary values for read latency
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 histogram. If specified, old read l=
atency=20
>> histogram is
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 removed, and empty one created with=
 interavals
>
> s/interavals/intervals/
>
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corresponding to @boundaries-read. =
The parameter=20
>> has higher
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priority then @boundaries.
>> +#
>> +# @boundaries-write: list of interaval boundary values for write=20
>> latency
>
> and again
>
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 histogram.
>> +#
>> +# @boundaries-flush: list of interaval boundary values for flush=20
>> latency
>
> copy-paste strikes again :)
>
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 histogram.
>> +#
>> +# Returns: error if device is not found or @boundaries* arrays are=20
>> invalid.
>
> s/@boundaries*/any boundary arrays/
>
>> +#
>> +# Since: 2.12
>> +#
>> +# Example: set new histograms for all io types with intervals
>> +# [0, 10), [10, 50), [50, 100), [100, +inf):
>
> Again, are these reasonable numbers in nanoseconds?=C2=A0 And spelling ou=
t=20
> the time unit in the example documentation may be helpful.
>
>> @@ -730,6 +830,12 @@
>> =C2=A0 # @timed_stats: Statistics specific to the set of previously defi=
ned
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 intervals of time (Since 2.5)
>> =C2=A0 #
>> +# @x_rd_latency_histogram: @BlockLatencyHistogramInfo. (Since 2.12)
>
> Here, the naming makes sense (the _ is consistent with this being an=20
> older interface and already using it elsewhere, and the leading x=20
> matches with your command being marked experimental).
>
>> +++ b/blockdev.c
>> @@ -4180,6 +4180,49 @@ void qmp_x_blockdev_set_iothread(const char=20
>> *node_name, StrOrNull *iothread,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aio_context_release(old_context);
>> =C2=A0 }
>> =C2=A0 +void qmp_x_block_latency_histogram_set(
>> +=C2=A0=C2=A0=C2=A0 const char *device,
> I'll fix up the trivial typos, but you may want a followup patch.

Thank you!

>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>


--=20
Best regards,
Vladimir
