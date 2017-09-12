Received: from eggs.gnu.org ([2001:4830:134:3::10]:57081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drmcI-0005G3-Aa
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drmcH-0008Dm-CO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drmcH-0008C0-3m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:56:45 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<cff16e31-4be0-9665-62d7-88a12b6d0b56@weilnetz.de>
	<15608989-cb43-a522-9a7d-b57b3a393155@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <abc99a4a-1386-2757-e605-f10d0afe6b3e@redhat.com>
Date: Tue, 12 Sep 2017 16:56:39 +0200
MIME-Version: 1.0
In-Reply-To: <15608989-cb43-a522-9a7d-b57b3a393155@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12.09.2017 11:20, Stefan Weil wrote:
> Am 12.09.2017 um 10:52 schrieb Stefan Weil:
>> Am 11.09.2017 um 20:24 schrieb Peter Maydell:
>>> I've also turned on a tci compile check on my pre-merge tests.
>>> (It doesn't pass "make check" for me, though...) thanks -- PMM
>>
>> "make check-qtest-ppc64" fails for me, too.
>>
>> Thomas, this seems to be again the well known timing problem
>> in tests/prom-env-test.c. The time for the test had been
>> changedfrom 30 s to 10 s to 120 s in the past.
>=20
> ... changed from 10 s to 30 s to 120 s ...
>=20
>> For TCI, even that latest value is not sufficient when
>> testing with pseries. Of course that also depends on other
>> parameters (speed of test machine, compiler flags).
>>
>> In my test pseries took nearly 5 minutes, so the test passes
>> when the loop upper limit is increased to 30000.
>=20
> Timing data for prom-env-test with TCI on another test machine:
>=20
> mac99:   78 s
> g3beige: 74 s
> pseries: 477 s

How fast is your host machine? For me the whole prom-env-test finishes
within 52 seconds (my host machine has 3.2 GHz) in TCI mode, and there
are no errors reported during "make check-qtest-ppc64".

Did you compile your QEMU with --enable-debug by accident? I think that
could explain the bad performance here - TCI with --enable-debug is not
just slow, but rather unusable slow already...

>> Is there a better way to handle this test? Why does pseries
>> still need much more time than the other machines
>> (not only with TCI)?

The problem is that the SLOF firmware just performs very badly with TCG
(it's fine on real hardware). It executes a lot of Forth code, and the
Forth interpreter uses things like computed gotos or other tricks that
basically prevent proper JIT operation here. I've done quite a bit of
optimizations in SLOF in the past already, but I've got hardly any ideas
left how to fix that further.

So I hope the problem is just the "--enable-debug" here and we could run
the test with TCI in normal builds? I'm also fine if we increase the
timeout to 5 minutes instead - it should not affect the normal users
(i.e. those who don't use TCI) and ease this situation with TCI a little
bit.

 Thomas
