Received: from eggs.gnu.org ([2001:4830:134:3::10]:53596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fNDzf-00035s-8L
	for qemu-devel@nongnu.org; Mon, 28 May 2018 04:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fNDzZ-0006at-Pr
	for qemu-devel@nongnu.org; Mon, 28 May 2018 04:59:07 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180528083855.GB4580@localhost.localdomain>
References: <20180515154033.19899-1-kwolf@redhat.com>
	<20180515154033.19899-21-kwolf@redhat.com>
	<CAFEAcA-FhMC0LqkYcRh3fV864wNSAJnHbT3657Y55MN9=RO72Q@mail.gmail.com>
	<20180528083855.GB4580@localhost.localdomain>
Date: Mon, 28 May 2018 10:58:17 +0200
Message-ID: <w51vab8qhqu.fsf@maestria.local.igalia.com>
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
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon 28 May 2018 10:38:55 AM CEST, Kevin Wolf wrote:
>> > +        if (!refcount_cache_size_set) {
>> > +            *refcount_cache_size = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>> 
>> ...but in the else clause down here, we don't have the cast, and
>> Coverity complains that we evaluate a 32-bit result and then put it
>> in a 64-bit variable. Should this have the (uint64_t) cast as well ?

I suppose that's not because we put a 32-bit result in a 64-bit
variable, but because it could theoretically overflow (if
s->cluster_size > INT32_MAX / 4).

> It's a false positive, MIN_REFCOUNT_CACHE_SIZE is 4 and
> s->cluster_size is at most 2 MB, so this will never overflow.
>
> I guess we can change the code anyway to silence it?

Same opinion here, no problem with adding a cast to silence the warning.

Berto
