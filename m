Received: from eggs.gnu.org ([2001:4830:134:3::10]:50049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcvRN-0004xt-Fj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcvRG-0000F2-On
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:20:05 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:37765 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dcvRG-0000E2-8s
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:19:58 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
	<CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
	<20170802110400.GI5531@stefanha-x1.localdomain>
	<CAFEAcA82EBmOF3k=fXN4tAAL2=J6s8avUoQGXKrBwchh1rmMCQ@mail.gmail.com>
	<20170802144943.GF10101@stefanha-x1.localdomain>
Date: Wed, 02 Aug 2017 18:19:29 +0300
In-Reply-To: <20170802144943.GF10101@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 2 Aug 2017 15:49:43 +0100")
Message-ID: <87lgn2q9oe.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Alessandro Di Federico <ale+qemu@clearmind.me>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>

Stefan Hajnoczi writes:

> On Wed, Aug 02, 2017 at 12:10:14PM +0100, Peter Maydell wrote:
>> On 2 August 2017 at 12:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> > On Tue, Aug 01, 2017 at 02:54:29PM +0100, Peter Maydell wrote:
>> >> and I don't need the TCG engine to be a library to do that...
>> >
>> > You do need TCG APIs if you want TCG-level instrumentation, tuning
>> > options, callbacks, etc.
>> 
>> I need an API; that doesn't necessarily look like the kind
>> of API you want to be able to embed the TCG engine into
>> other things, I think.
>> 
>> >> I agree that we want to provide something that is at least
>> >> closer to a stable API than "just expose trace events",
>> >> though.
>> >
>> > libqemu has at least three parts:
>> >
>> > 1. VM API (i.e. qemu_init(argc, argv), qemu_run(), qemu_vcpu_get_reg32())
>> > 2. TCG engine
>> > 3. Device models
>> >
>> > Like I said in my email, start with what matters for the instrumentation
>> > use case (VM API at a minimum to control guest execution).  Other people
>> > can flesh out the other parts later, as needed.
>> >
>> > Other attempts to provide a stable API will be essentially the same
>> > thing as libqemu.
>> 
>> I don't think this is the case -- you could have a stable
>> instrumentation API without it looking anything like
>> libqemu. In particular I don't think you need to have
>> something that sits at the top level and says 'run'.
>> 
>> In particular I think that pulling TCG out of QEMU
>> is an enormous and painful undertaking that you just
>> don't need to do at all to allow this kind of
>> instrumentation API.

> Please post an example of the API you'd like.

In my opinion, the instrumentation support in this series provides an API that
works in the opposite way you're suggesting (let's ignore the fact that it's
built on tracing events).

When QEMU loads an instrumentation library (which can happen at any time), some
initialization function is called on the library so that it can establish what
events to instrument. This also has the advantage that a user can hook into a
running QEMU instance at any time to perform some instrumentation.

I think this is the bare minimum necessary to make it work, and has the upside
of being completely orthogonal to the libqemu approach. We could reuse most of
the stable instrumentation API there too, except for the instrumentation code
initialization.

That being said, the libqemu approach *might* make it a bit easier to provide an
API for things such as "run for this many instructions and return control to
instrumentor", but I don't think that's mandatory for a first prototype (and can
definitely be implemented using both approaches).

Cheers,
  Lluis
