Received: from eggs.gnu.org ([2001:4830:134:3::10]:40276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fNIf8-0001ll-Hm
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fNIf7-0008CD-T0
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:58:14 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAFEAcA9ose2=2t+ehCt5yPqoBDhm6NRG9AicsO9X-PD8KxObGA@mail.gmail.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
	<20180515154033.19899-21-kwolf@redhat.com>
	<CAFEAcA-FhMC0LqkYcRh3fV864wNSAJnHbT3657Y55MN9=RO72Q@mail.gmail.com>
	<20180528083855.GB4580@localhost.localdomain>
	<w51vab8qhqu.fsf@maestria.local.igalia.com>
	<CAFEAcA9ose2=2t+ehCt5yPqoBDhm6NRG9AicsO9X-PD8KxObGA@mail.gmail.com>
Date: Mon, 28 May 2018 15:58:03 +0200
Message-ID: <w51sh6brifo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 20/37] qcow2: Give the refcount cache the
 minimum possible size by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon 28 May 2018 03:49:07 PM CEST, Peter Maydell wrote:
> On 28 May 2018 at 09:58, Alberto Garcia <berto@igalia.com> wrote:
>> On Mon 28 May 2018 10:38:55 AM CEST, Kevin Wolf wrote:
>>>> > +        if (!refcount_cache_size_set) {
>>>> > +            *refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>>>>
>>>> ...but in the else clause down here, we don't have the cast, and
>>>> Coverity complains that we evaluate a 32-bit result and then put it
>>>> in a 64-bit variable. Should this have the (uint64_t) cast as well ?
>>
>> I suppose that's not because we put a 32-bit result in a 64-bit
>> variable, but because it could theoretically overflow (if
>> s->cluster_size > INT32_MAX / 4).
>
> Well, coverity warns because it's one of those things that could be
> correct code, or could be the author tripping over one of C's
> less-than-obvious traps. 32x32->32 multiplies are just as susceptible
> to overflow, but the heuristic Coverity uses is "calculated a 32-bit
> multiply result and put it in a 64-bit variable", on the assumption
> that the type of the destination implies that whatever you're
> calculating could well be that big, and "truncate the result of my
> multiply even though it would fit in the destination" is a bit
> unexpected. Coverity's wrong quite a bit on this one, naturally, but
> it's usually easier to shut it up on the wrong guesses for the benefit
> of the times when it turns out to be right.

Yes, it's a fair warning. I'll send a patch.

Berto
