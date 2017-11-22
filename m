Received: from eggs.gnu.org ([2001:4830:134:3::10]:33153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHTvw-0003Ry-Kw
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHTvq-0004o5-Mb
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:15:16 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHTvq-0004mq-HA
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:15:10 -0500
Received: by mail-ot0-x242.google.com with SMTP id j29so13371222oth.13
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 04:15:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e384f727-0cdd-9fcd-a50f-a9f89ae2272a@linaro.org>
References: <20171122084157.11480-1-quintela@redhat.com>
	<4e926520-1b21-5aad-6a5c-3a8d11a8ea80@linaro.org>
	<CAFEAcA_i2rumOMHVa7t4nQhHoM6zWgD1mPC5QbcqGermiO3eeQ@mail.gmail.com>
	<e384f727-0cdd-9fcd-a50f-a9f89ae2272a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Nov 2017 12:14:49 +0000
Message-ID: <CAFEAcA9zwnY5+=Em2gta7HVoKGv2EBS3UVH+zbwCzOCovyUVdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 22 November 2017 at 12:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/22/2017 01:03 PM, Peter Maydell wrote:
>> Wow, I totally do not expect "assert(tcg_enabled())" to mean
>> "we rely on the compiler to be able to determine that this
>> code is dead" (and in general I'm not a fan of the compilation
>> relying on the compiler determining that code is dead).
>
> We do this all of the time for more regular tests that are obviously
> compile-time.  I am a really big fan of this, because it makes sure that the
> (usually 32-bit) else branch continues to compile.

I'm happy with code that is "we assume the compiler is going to
be sensible here so we don't have to use #ifdefs in the name
of performance". I just don't think we should write code that
can't compile at all if the compiler happens to not identify
the codepath as dead. There's no guarantee by the compiler
that it's going to do that.

Also, if we do have some need to do this, assert() is the
wrong way to do it -- the program should behave (and build)
identically if you strip all the assert()s out of it.
We should have some construct that makes the intent clear.

thanks
-- PMM
