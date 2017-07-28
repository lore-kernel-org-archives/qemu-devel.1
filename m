Received: from eggs.gnu.org ([2001:4830:134:3::10]:41035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db80x-0005j9-Q4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db80s-0007UT-Ek
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:21:22 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:47358)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db80s-0007SG-1I
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:21:18 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<87o9s88sb4.fsf@frigg.lan>
	<20170726112210.GD18489@stefanha-x1.localdomain>
	<871sp34bbc.fsf@frigg.lan>
	<20170727103253.GE10129@stefanha-x1.localdomain>
	<CAFEAcA-Da7ZV7SL41TShqiy=icgo_nJXJxBqRr=RO+M23JsrGg@mail.gmail.com>
	<20170728134218.GT12364@stefanha-x1.localdomain>
Date: Fri, 28 Jul 2017 19:21:04 +0300
In-Reply-To: <20170728134218.GT12364@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Fri, 28 Jul 2017 14:42:18 +0100")
Message-ID: <877eyslehb.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

Stefan Hajnoczi writes:

> On Thu, Jul 27, 2017 at 11:40:17AM +0100, Peter Maydell wrote:
>> On 27 July 2017 at 11:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > On Wed, Jul 26, 2017 at 03:44:39PM +0300, Llu=C3=ADs Vilanova wrote:
>> >> And why exactly is this a threat? Because it can be used to "extend" =
QEMU
>> >> without touching its sources? Is this a realistic threat? (it's a rat=
her brittle
>> >> way to do it, so I'm not sure it's practical)
>> >
>> > Unfortunately it is a problem.  I recently came across a product that
>> > was using LD_PRELOAD=3D to "integrate" with QEMU.  People really abuse
>> > these interfaces instead of integrating their features cleanly into
>> > QEMU.
>>=20
>> ...if people who want to do this kind of thing already can and
>> do use LD_PRELOAD for it, I don't think we should worry too much
>> about trying to make the instrumentation plugin API bulletproof
>> against similar abuse.
>>=20
>> > I see the use cases that Peter has been describing and am sure we can
>> > come up with good solutions.  What I care about is that it doesn't all=
ow
>> > loading a .so that connects to arbitrary trace events.
>>=20
>> That said, I agree that we don't really need an arbitrary-trace-event
>> setup here, and we should probably design our API so that it isn't
>> handing the trace plugin hooks pointers into QEMU's internals.
>> We want an API that makes it easy for people to do things based on
>> changes of the guest binary's state (registers, insns, etc etc)
>> and which makes it hard for them to accidentally trip themselves up
>> (eg by prodding around in QEMU internal data structures).
>> This will have the secondary benefit that it's unlikely that future
>> changes to QEMU will break plugin code.
>>=20
>> >> As a side note, I find instrumentation to be most useful for guest co=
de events,
>> >> which mostly contain non-pointer values (except for the CPUState*).
>>=20
>> For instance we definitely should not be passing a CPUState* to
>> any plugin function.

> The gdbstub protocol has relevant features for accessing guest memory,
> registers, etc.  Perhaps a set of QEMU-specific events can be added
> (e.g. tb generated) so it's possible to instrument and control the
> guest from an instrumentation program (written in any language).

> Perhaps there is a fundamental reason why this isn't possible due to the
> protocol design, because using gdbstub halts all vcpus, etc.  I don't
> know.

> Do you think this is an interesting direction?  It definitely seems like
> a powerful approach though performance would be less than running native
> code inside the QEMU process.

That's the same approach someone else dubbed as using a fifo with "synchron=
ous"
events, right? I have some measurements on this using a pipe, and overheads=
 are
1000x to 2300x for each communication event (compared to a function call, a=
nd
depending on whether each process/thread is pinned to the same or different
CPU).


Cheers,
  Lluis
