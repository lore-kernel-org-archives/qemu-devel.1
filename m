Received: from eggs.gnu.org ([209.51.188.92]:49523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjeub-0004CM-5L
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjelf-00061y-Hb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 01:33:40 -0500
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
From: Thomas Huth <thuth@redhat.com>
Message-ID: <479044cb-345a-0faa-795a-f67da0077198@redhat.com>
Date: Wed, 16 Jan 2019 07:33:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190115200527.GB7844@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 2019-01-15 21:05, Emilio G. Cota wrote:
> On Tue, Jan 15, 2019 at 16:01:32 +0000, Alex Benn=C3=A9e wrote:
>> Ahh I should have mentioned we already have the technology for this ;-=
)
>>
>> If you build the fpu/next tree on a s390x you can then run:
>>
>>   ./tests/fp/fp-bench f64_div
>>
>> with and without the CONFIG_128 path. To get an idea of the real world
>> impact you can compile a foreign binary and run it on a s390x system
>> with:
>>
>>   $QEMU ./tests/fp/fp-bench f64_div -t host
>>
>> And that will give you the peak performance assuming your program is
>> doing nothing but f64_div operations. If the two QEMU's are basically =
in
>> the same ballpark then it doesn't make enough difference. That said:
>=20
> I think you mean here `tests/fp/fp-bench -o div -p double', otherwise
> you'll get the default op (-o add).

I tried that now, too, and -o div -p double does not really seem to
exercise this function at all.

Here are my results (disclaimer: that system is likely not really usable
for benchmarks since it's CPUs are shared with other LPARs, but I ran
all the tests at least twice and got similar results):


With the DGLR inline assembly:

 time ./fp-test f64_div -l 2 -r all
 real	6m43,648s
 user	6m43,362s
 sys	0m0,160s

 time ./fp-bench -o div -p double
 204.98 MFlops
 real	0m1,002s
 user	0m1,001s
 sys	0m0,001s


With the "#else" default 64-bit code:

 time ./fp-test f64_div -l 2 -r all
 real	6m44,910s
 user	6m44,616s
 sys	0m0,165s

 time ./fp-bench -o div -p double
 205.41 MFlops
 real	0m1,002s
 user	0m1,001s
 sys	0m0,001s


With the new CONFIG_INT128 code:

 time ./fp-test f64_div -l 2 -r all
 real	6m58,371s
 user	6m58,078s
 sys	0m0,164s

 time ./fp-bench -o div -p double
 205.17 MFlops
 real	0m1,002s
 user	0m1,000s
 sys	0m0,001s


=3D=3D> The new CONFIG_INT128 code is really worse than the 64-bit code, =
so
I don't think we should include this yet (unless we know a system where
the compiler can create optimized assembly code without libgcc here).

 Thomas
