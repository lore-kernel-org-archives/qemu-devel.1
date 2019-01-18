Received: from eggs.gnu.org ([209.51.188.92]:47482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gkP2T-0005vP-5S
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gkP2S-0002KN-7p
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:58:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gkP2R-0002D9-UW
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 02:58:04 -0500
From: Bandan Das <bsd@redhat.com>
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
	<8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
	<CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
	<0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
	<20190114092459.GA7038@stefanha-x1.localdomain>
Date: Fri, 18 Jan 2019 02:51:23 -0500
In-Reply-To: <20190114092459.GA7038@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 14 Jan 2019 09:24:59 +0000")
Message-ID: <jpgh8e6o138.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrey Konovalov <andreyknvl@google.com>, qemu-devel <qemu-devel@nongnu.org>, Kostya Serebryany <kcc@google.com>, Jonathan Metzman <metzman@google.com>, Max Moroz <mmoroz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Nitesh Narayan Lal <nitesh@redhat.com>

[Ccing Nitesh]
Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, Jan 11, 2019 at 05:16:40PM +0100, Paolo Bonzini wrote:
>> On 11/01/19 16:41, Max Moroz wrote:
>> > On Fri, Jan 11, 2019 at 7:34 AM Paolo Bonzini <pbonzini@redhat.com
>> > <mailto:pbonzini@redhat.com>> wrote:
>> >=20
>> >     On 11/01/19 16:04, Max Moroz wrote:
>> >     > We usually have a single fuzzing process, it starts with a fuzzi=
ng
>> >     > engine's main function and is calling=C2=A0LLVMFuzzerTestOneInpu=
t with
>> >     > various inputs and keep mutating them based on the coverage feed=
back.
>> >     > Running a second process which you don't care too much about mig=
ht be
>> >     > fine, but the fuzzing process should be "replacing" or should I =
say
>> >     > "imitating" the process whose coverage you're interested in.
>> >=20
>> >     What do you mean by replacing or imitating?
>> >=20
>> > To give you an example, when we fuzz ffmpeg, we do not run ffmpeg's ma=
in
>> > function. We write=C2=A0LLVMFuzzerTestOneInput that would do the neces=
sary
>> > initialization, reset the state, etc, and then would pass (data, size)
>> > provided by a fuzzing engine to the API(s) we're trying to fuzz. So, in
>> > your case, there should not be a regular QEMU process, and instead the
>> > fuzz target (i.e. LLVMFuzzerTestOneInput) should be doing certain
>> > initialization (which is usually done by the QEMU process) and then ca=
ll
>> > the API you want to fuzz.
>>=20
>> The main issue is that we are not really testing an API and QEMU has a
>> lot of global state.
>
> With regards to the GSoC/Outreachy project, I think the mentors (me?)
> need to figure this out beforehand by experimentation.  The QEMU folks
> don't know the details of oss-fuzz and vice versa.  But with a weekend
> or two's worth of playing around we could figure out a reasonable way of
> integrating qtest/oss-fuzz.
>

If you recall, Nitesh and myself did experiment with the plumbing although
our entry point in qtest for calling the fuzzing function was simpler. Figu=
ring out
the right entry point with a subset of absolutely necessary initialization
is what's next.

Bandan

> Then the intern has a clear direction to follow this summer and won't be
> demotivated by failed attempts at working with two codebases they are
> unfamiliar with :).
>
> Stefan
