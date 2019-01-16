Received: from eggs.gnu.org ([209.51.188.92]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjogS-0006dE-HW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjogR-0004uu-OW
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:08:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjogR-0004tU-9Y
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:08:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id g67so2796759wmd.2
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:08:54 -0800 (PST)
References: <30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
	<e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
	<a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
	<87y37monyr.fsf@linaro.org>
	<CAFEAcA8u4AdhW-MF6uMP7=B4iYVO9ZEQCtcQKpN6KWALwAfLnw@mail.gmail.com>
	<87won6nfl1.fsf@linaro.org>
	<6cb80b50-0352-430e-0c46-85ed69f95c88@redhat.com>
	<87va2poqoz.fsf@linaro.org> <20190115200527.GB7844@flamenco>
	<479044cb-345a-0faa-795a-f67da0077198@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <479044cb-345a-0faa-795a-f67da0077198@redhat.com>
Date: Wed, 16 Jan 2019 17:08:51 +0000
Message-ID: <87a7k0zg0s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>


Thomas Huth <thuth@redhat.com> writes:

> On 2019-01-15 21:05, Emilio G. Cota wrote:
>> On Tue, Jan 15, 2019 at 16:01:32 +0000, Alex Benn=C3=A9e wrote:
>>> Ahh I should have mentioned we already have the technology for this ;-)
>>>
>>> If you build the fpu/next tree on a s390x you can then run:
>>>
>>>   ./tests/fp/fp-bench f64_div
>>>
>>> with and without the CONFIG_128 path. To get an idea of the real world
>>> impact you can compile a foreign binary and run it on a s390x system
>>> with:
>>>
>>>   $QEMU ./tests/fp/fp-bench f64_div -t host
>>>
>>> And that will give you the peak performance assuming your program is
>>> doing nothing but f64_div operations. If the two QEMU's are basically in
>>> the same ballpark then it doesn't make enough difference. That said:
>>
>> I think you mean here `tests/fp/fp-bench -o div -p double', otherwise
>> you'll get the default op (-o add).
>
> I tried that now, too, and -o div -p double does not really seem to
> exercise this function at all.

How do you mean? It should do because by default it should be calling
the softfloat implementations.

> Here are my results (disclaimer: that system is likely not really usable
> for benchmarks since it's CPUs are shared with other LPARs, but I ran
> all the tests at least twice and got similar results):
>
>
> With the DGLR inline assembly:
>
<snip>
>  time ./fp-bench -o div -p double
>  204.98 MFlops
<snip>
> With the "#else" default 64-bit code:
>
<snip>
>  time ./fp-bench -o div -p double
>  205.41 MFlops
<snip>
> With the new CONFIG_INT128 code:
>
<snip>
>  time ./fp-bench -o div -p double
>  205.17 MFlops
<snip>
>
>
> =3D=3D> The new CONFIG_INT128 code is really worse than the 64-bit code, =
so
> I don't think we should include this yet (unless we know a system where
> the compiler can create optimized assembly code without libgcc here).

I mean to me that looks like it is easily in the noise range and that
the dglr instruction didn't actually beat the unrolled 64 bit code -
which is just weird.

--
Alex Benn=C3=A9e
