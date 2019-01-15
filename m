Received: from eggs.gnu.org ([209.51.188.92]:36328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjRA1-0000S8-Ux
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjR9p-0000nE-DI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:01:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjR9p-0000l9-2d
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:01:41 -0500
Received: by mail-wr1-x431.google.com with SMTP id r10so3535277wrs.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 08:01:34 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
	<e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
	<a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
	<87y37monyr.fsf@linaro.org>
	<CAFEAcA8u4AdhW-MF6uMP7=B4iYVO9ZEQCtcQKpN6KWALwAfLnw@mail.gmail.com>
	<87won6nfl1.fsf@linaro.org>
	<6cb80b50-0352-430e-0c46-85ed69f95c88@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6cb80b50-0352-430e-0c46-85ed69f95c88@redhat.com>
Date: Tue, 15 Jan 2019 16:01:32 +0000
Message-ID: <87va2poqoz.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 2019-01-15 15:46, Alex Benn=C3=A9e wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Mon, 14 Jan 2019 at 22:48, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>>>
>>>>
>>>> Richard Henderson <rth@twiddle.net> writes:
>>>>> But perhaps
>>>>>
>>>>>     unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>>>>>     *r =3D n % d;
>>>>>     return n / d;
>>>>>
>>>>> will allow the compiler to do what the assembly does for some 64-bit
>>>>> hosts.
>>>>
>>>> I wonder how much cost is incurred by the jumping to the (libgcc?) div
>>>> helper? Anyone got an s390x about so we can benchmark the two
>>>> approaches?
>>>
>>> The project has an s390x system available; however it's usually
>>> running merge build tests so not so useful for benchmarking.
>>> (I can set up accounts on it but that requires me to faff about
>>> figuring out how to create new accounts :-))
>>
>> I'm happy to leave this up to those who care about s390x host
>> performance (Thomas, Cornelia?). I'm just keen to avoid the divide
>> helper getting too #ifdefy.
>
> Ok, I just did a quick'n'dirty "benchmark" on the s390x that I've got
> available:

Ahh I should have mentioned we already have the technology for this ;-)

If you build the fpu/next tree on a s390x you can then run:

  ./tests/fp/fp-bench f64_div

with and without the CONFIG_128 path. To get an idea of the real world
impact you can compile a foreign binary and run it on a s390x system
with:

  $QEMU ./tests/fp/fp-bench f64_div -t host

And that will give you the peak performance assuming your program is
doing nothing but f64_div operations. If the two QEMU's are basically in
the same ballpark then it doesn't make enough difference. That said:

> #include <stdio.h>
> #include <time.h>
> #include <stdint.h>
>
> uint64_t udiv_qrnnd1(uint64_t *r, uint64_t n1, uint64_t n0, uint64_t d)
> {
>     unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>     *r =3D n >> 64;
>     return n;
> }
>
> uint64_t udiv_qrnnd2(uint64_t *r, uint64_t n1, uint64_t n0, uint64_t d)
> {
>     unsigned __int128 n =3D (unsigned __int128)n1 << 64 | n0;
>     *r =3D n % d;
>     return n / d;
> }
>
<snip>
>
> int main()
> {
> 	uint64_t r =3D 0, n1 =3D 0, n0 =3D 0, d =3D 0;
> 	uint64_t rs =3D 0, rn =3D 0;
> 	clock_t start, end;
> 	long i;
>
> 	start =3D clock();
> 	for (i=3D0; i<200000000L; i++) {
> 		n1 +=3D 3;
> 		n0 +=3D 987654321;
> 		d +=3D 0x123456789;
> 		rs +=3D udiv_qrnnd1(&r, n1, n0, d);
> 		rn +=3D r;
> 	}
> 	end =3D clock();
> 	printf("test 1: time=3D%li\t, rs=3D%li , rn =3D %li\n", (end-start)/1000=
, rs, rn);
>
> 	r =3D n1 =3D n0 =3D d =3D rs =3D rn =3D 0;
>
> 	start =3D clock();
> 	for (i=3D0; i<200000000L; i++) {
> 		n1 +=3D 3;
> 		n0 +=3D 987654321;
> 		d +=3D 0x123456789;
> 		rs +=3D udiv_qrnnd2(&r, n1, n0, d);
> 		rn +=3D r;
> 	}
> 	end =3D clock();
> 	printf("test 2: time=3D%li\t, rs=3D%li , rn =3D %li\n", (end-start)/1000=
, rs, rn);
>
> 	r =3D n1 =3D n0 =3D d =3D rs =3D rn =3D 0;
>
> 	start =3D clock();
> 	for (i=3D0; i<200000000L; i++) {
> 		n1 +=3D 3;
> 		n0 +=3D 987654321;
> 		d +=3D 0x123456789;
> 		rs +=3D udiv_qrnnd3(&r, n1, n0, d);
> 		rn +=3D r;
> 	}
> 	end =3D clock();
> 	printf("test 3: time=3D%li\t, rs=3D%li , rn =3D %li\n", (end-start)/1000=
, rs, rn);
>
> 	return 0;
> }
>
> ... and results with GCC v8.2.1 are (using -O2):
>
> test 1: time=3D609	, rs=3D2264924160200000000 , rn =3D 6136218997527160832
> test 2: time=3D10127	, rs=3D2264924160200000000 , rn =3D 6136218997527160=
832
> test 3: time=3D2350	, rs=3D2264924183048928865 , rn =3D 48428220481623110=
89
>
> Thus the int128 version is the slowest!

I'd expect a little slow down due to the indirection into libgcc.. but
that seems pretty high.

>
> ... but at least it gives the same results as the DLGR instruction. The 6=
4-bit
> version gives different results - do we have a bug here?
>
> Results with Clang v7.0.1 (using -O2, too) are these:
>
> test 2: time=3D5035	, rs=3D2264924160200000000 , rn =3D 61362189975271608=
32
> test 3: time=3D1970	, rs=3D2264924183048928865 , rn =3D
> 4842822048162311089

You can run:

  ./tests/fp/fp-test f64_div -l 2 -r all

For a proper comprehensive test.

--
Alex Benn=C3=A9e
