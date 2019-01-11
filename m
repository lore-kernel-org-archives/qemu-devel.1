Received: from eggs.gnu.org ([209.51.188.92]:49160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghzUN-00089G-Na
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghzUM-0003JY-Mg
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:16:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghzUM-0003JF-ER
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:16:54 -0500
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
	<8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
	<CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
Date: Fri, 11 Jan 2019 17:16:40 +0100
MIME-Version: 1.0
In-Reply-To: <CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Moroz <mmoroz@google.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

On 11/01/19 16:41, Max Moroz wrote:
>=20
>=20
> On Fri, Jan 11, 2019 at 7:34 AM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>     On 11/01/19 16:04, Max Moroz wrote:
>     > We usually have a single fuzzing process, it starts with a fuzzin=
g
>     > engine's main function and is calling=C2=A0LLVMFuzzerTestOneInput=
 with
>     > various inputs and keep mutating them based on the coverage feedb=
ack.
>     > Running a second process which you don't care too much about migh=
t be
>     > fine, but the fuzzing process should be "replacing" or should I s=
ay
>     > "imitating" the process whose coverage you're interested in.
>=20
>     What do you mean by replacing or imitating?
>=20
> To give you an example, when we fuzz ffmpeg, we do not run ffmpeg's mai=
n
> function. We write=C2=A0LLVMFuzzerTestOneInput that would do the necess=
ary
> initialization, reset the state, etc, and then would pass (data, size)
> provided by a fuzzing engine to the API(s) we're trying to fuzz. So, in
> your case, there should not be a regular QEMU process, and instead the
> fuzz target (i.e. LLVMFuzzerTestOneInput) should be doing certain
> initialization (which is usually done by the QEMU process) and then cal=
l
> the API you want to fuzz.

The main issue is that we are not really testing an API and QEMU has a
lot of global state.  Of course there are C functions to do the
elementary I/O operations, but there are two problems.  The first and
smaller is that one input would correspond to a sequence of invocations
of the functions, not just one function invocation; the larger, is that
the knowledge of the guest (memory map, placement of devices, etc.) is
not easy to consume from within QEMU.  We do have a library that
includes that knowledge, and it would be easy to use it from a mutator
or input postprocessor, but I'm afraid that it would be very very
intrusive to embed that library into QEMU, replacing all of main() etc.

The simplest way would be to test the input by fork()-ing QEMU, followed
by waitpid() in the parent and invoking the original main() in the
child.  But that wouldn't buy much and would probably even be slower
than an efficient deferred fork server.

Paolo

> =C2=A0
>=20
>=20
>     Avoiding fork would probably be hard.=C2=A0 I'm mostly afraid that =
some state
>     guest state is not resetted properly across runs, and this would re=
sult
>     in non-reproducible crashes.
>=20
>     It seems to me that the task can be approached with AFL and a test =
case
>     postprocessor to generate the qtest input; however, my knowledge of
>     libFuzzer is very very limited.
>=20
>     Paolo
>=20
