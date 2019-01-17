Received: from eggs.gnu.org ([209.51.188.92]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk2K2-0001qY-SU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk2K1-0001Cr-UP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:42:42 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk2K1-00010Z-Ot
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 02:42:41 -0500
Received: by mail-wm1-x341.google.com with SMTP id t200so4661985wmt.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 23:42:25 -0800 (PST)
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
	<87a7k0zg0s.fsf@linaro.org>
	<26dad243-d1cf-6705-c8eb-ff329590d272@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <26dad243-d1cf-6705-c8eb-ff329590d272@redhat.com>
Date: Thu, 17 Jan 2019 07:42:22 +0000
Message-ID: <877ef3zq5d.fsf@linaro.org>
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

> On 2019-01-16 18:08, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 2019-01-15 21:05, Emilio G. Cota wrote:
>>>> On Tue, Jan 15, 2019 at 16:01:32 +0000, Alex Benn=C3=A9e wrote:
>>>>> Ahh I should have mentioned we already have the technology for this ;=
-)
>>>>>
>>>>> If you build the fpu/next tree on a s390x you can then run:
>>>>>
>>>>>   ./tests/fp/fp-bench f64_div
>>>>>
>>>>> with and without the CONFIG_128 path. To get an idea of the real world
>>>>> impact you can compile a foreign binary and run it on a s390x system
>>>>> with:
>>>>>
>>>>>   $QEMU ./tests/fp/fp-bench f64_div -t host
>>>>>
>>>>> And that will give you the peak performance assuming your program is
>>>>> doing nothing but f64_div operations. If the two QEMU's are basically=
 in
>>>>> the same ballpark then it doesn't make enough difference. That said:
>>>>
>>>> I think you mean here `tests/fp/fp-bench -o div -p double', otherwise
>>>> you'll get the default op (-o add).
>>>
>>> I tried that now, too, and -o div -p double does not really seem to
>>> exercise this function at all.
>>
>> How do you mean? It should do because by default it should be calling
>> the softfloat implementations.
>
> I've added a puts("hello") into the udiv_qrnd() function. When I then
> run "fp-bench -o div -p double", it only prints out "hello" a single
> time, so the function is only called once during the whole test.

That's very odd. With the following on my aarch64 box:

modified   include/fpu/softfloat-macros.h
@@ -637,6 +637,8 @@ static inline uint64_t estimateDiv128To64(uint64_t a0, =
uint64_t a1, uint64_t b)
 static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
                                   uint64_t n0, uint64_t d)
 {
+    static int iter =3D 0;
+    fprintf(stderr, "%s: %d\n", __func__, iter++);
 #if defined(__x86_64__)
     uint64_t q;
     asm("divq %4" : "=3Da"(q), "=3Dd"(*r) : "0"(n0), "1"(n1), "rm"(d));

I get:

udiv_qrnnd: 0
udiv_qrnnd: 1
..
..<all the way to>
udiv_qrnnd: 99998
udiv_qrnnd: 99999

So I'm not sure what is different on s390

--
Alex Benn=C3=A9e
