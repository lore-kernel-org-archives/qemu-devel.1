Received: from eggs.gnu.org ([2001:4830:134:3::10]:51268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djlRx-0003qf-Rt
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1djlRs-00035k-4M
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:04:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170818151621.o367sr74hi3e2kpm@postretch>
References: <20170818031019.3723-1-el13635@mail.ntua.gr>
	<20170818031019.3723-5-el13635@mail.ntua.gr>
	<w51r2w958mc.fsf@maestria.local.igalia.com>
	<20170818151621.o367sr74hi3e2kpm@postretch>
Date: Mon, 21 Aug 2017 14:04:10 +0200
Message-ID: <w51h8x1nn45.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 4/6] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 19 Aug 2017 09:08:59 AM CEST, Manos Pitsidianakis wrote:
>>> +    if (tg->name) {
>>> +        /* error if name is duplicate */
>>> +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
>>> +            if (!g_strcmp0(tg->name, iter->name) && tg != iter) {
>>
>>I'm just nitpicking here :) but if you change this and put 'tg !=
>>iter' first you'll save one unnecessary string comparison.
>
> Only in the case where tg == iter, otherwise you have one unnecessary
> pointer comparison for every other group.

Right, although calling g_strcmp0() may be more expensive than doing all
the pointer comparisons? Anyway it probably doesn't matter much in the
end.

>>Out of the blue I can think of the following alternative:
>>
>>   - There's 6 different buckets (we have BucketType listing them)
>>
>>   - There's 3 values we can set in each bucket (max, avg,
>>     burst_length). For those we can have an internal enumeration
>>     (probably with one additional value for iops-size).
>>
>>   - In the 'properties' array, for each property we know its category
>>     (and I mean: avg, max, burst-lenght, iops-size) and the bucket
>>     where they belong.
>>
>>   - In throttle_group_set() the switch could be something like this:
>>
>>     switch (info->category) {
>>        case THROTTLE_VALUE_AVG:
>>           cfg->buckets[info->bkt_type].avg = value;
>>           break;
>>        case THROTTLE_VALUE_MAX:
>>           cfg->buckets[info->bkt_type].max = value;
>>           break;
>>        case THROTTLE_VALUE_BURST_LENGTH:
>>           /* Code here to check that value <= UINT_MAX */
>>           cfg->buckets[info->bkt_type].iops_length = value;
>>           break;
>>        case THROTTLE_VALUE_IOPS_SIZE:
>>           cfg->op_size = value;
>>     }
>
> I don't think that solves the type problem, since C uses coercion.  For 
> example if hypothetically a double changes to uint in the future, 
> `value` will not be checked for overflow and the compiler would just 
> convert it to uint implicitly.  An academic solution would be to use a 
> strongly typed language!
>>

Indeed, but I'd rather have this:

   unsigned int avg;
   double value = 2.5;
   avg = value;

than this:

   unsigned int avg;
   double value = 2.5;
   *((double *)&avg) = value;

>>> +static void throttle_group_set_limits(Object *obj, Visitor *v,
>>> +                                      const char *name, void *opaque,
>>> +                                      Error **errp)
>>> +
>>> +{
>>> +    ThrottleGroup *tg = THROTTLE_GROUP(obj);
>>> +    ThrottleConfig cfg;
>>> +    ThrottleLimits *arg = NULL;
>>> +    Error *local_err = NULL;
>>> +
>>> +    arg = g_new0(ThrottleLimits, 1);
>>
>>Do you need to allocate ThrottleLimits in the heap?
>
> I thought you actually do because visit_type_ThrottleLimits() frees arg 
> on error:
>  
>     if (err && visit_is_input(v)) {
>         qapi_free_ThrottleLimits(*obj);
>         *obj = NULL;
>     }
>
> but I see now it doesn't actually call g_free and only sets the pointer 
> to NULL.  Is that supposed to prevent use of a stack pointer in the 
> caller after error? I am a bit confused as to why. (This is the 
> generated qapi-visit.c code but similar to other visitor functions)

I'm not sure why it does that.

Berto
