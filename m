Received: from eggs.gnu.org ([2001:4830:134:3::10]:36112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNIWt-0007Zw-FV
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNIWf-000151-8F
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:49:43 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNIWe-000133-HV
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:49:28 -0400
Received: by mail-oi0-x22b.google.com with SMTP id l1-v6so10402070oii.1
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 06:49:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <w51vab8qhqu.fsf@maestria.local.igalia.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
	<20180515154033.19899-21-kwolf@redhat.com>
	<CAFEAcA-FhMC0LqkYcRh3fV864wNSAJnHbT3657Y55MN9=RO72Q@mail.gmail.com>
	<20180528083855.GB4580@localhost.localdomain>
	<w51vab8qhqu.fsf@maestria.local.igalia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 May 2018 14:49:07 +0100
Message-ID: <CAFEAcA9ose2=2t+ehCt5yPqoBDhm6NRG9AicsO9X-PD8KxObGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 May 2018 at 09:58, Alberto Garcia <berto@igalia.com> wrote:
> On Mon 28 May 2018 10:38:55 AM CEST, Kevin Wolf wrote:
>>> > +        if (!refcount_cache_size_set) {
>>> > +            *refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>>>
>>> ...but in the else clause down here, we don't have the cast, and
>>> Coverity complains that we evaluate a 32-bit result and then put it
>>> in a 64-bit variable. Should this have the (uint64_t) cast as well ?
>
> I suppose that's not because we put a 32-bit result in a 64-bit
> variable, but because it could theoretically overflow (if
> s->cluster_size > INT32_MAX / 4).

Well, coverity warns because it's one of those things that
could be correct code, or could be the author tripping over
one of C's less-than-obvious traps. 32x32->32 multiplies are
just as susceptible to overflow, but the heuristic Coverity
uses is "calculated a 32-bit multiply result and put it in
a 64-bit variable", on the assumption that the type of the
destination implies that whatever you're calculating could
well be that big, and "truncate the result of my multiply
even though it would fit in the destination" is a bit
unexpected. Coverity's wrong quite a bit on this one, naturally,
but it's usually easier to shut it up on the wrong guesses
for the benefit of the times when it turns out to be right.

thanks
-- PMM
