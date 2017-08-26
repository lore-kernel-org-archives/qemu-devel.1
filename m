Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlOjy-0006tr-FA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dlOjv-0006BH-8i
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:14:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57389)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dlOjv-0006B5-3A
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:14:15 -0400
Date: Fri, 25 Aug 2017 20:14:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170826001411.GC29654@flamenco>
References: <CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
	<CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
	<20170802110400.GI5531@stefanha-x1.localdomain>
	<CAFEAcA82EBmOF3k=fXN4tAAL2=J6s8avUoQGXKrBwchh1rmMCQ@mail.gmail.com>
	<20170802144943.GF10101@stefanha-x1.localdomain>
	<87lgn2q9oe.fsf@frigg.lan>
	<20170803115457.GD22685@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170803115457.GD22685@stefanha-x1.localdomain>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Alessandro Di Federico <ale+qemu@clearmind.me>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 03, 2017 at 12:54:57 +0100, Stefan Hajnoczi wrote:
> > > Please post an example of the API you'd like.
> > 
> > In my opinion, the instrumentation support in this series provides an API that
> > works in the opposite way you're suggesting (let's ignore the fact that it's
> > built on tracing events).
> > 
> > When QEMU loads an instrumentation library (which can happen at any time), some
> > initialization function is called on the library so that it can establish what
> > events to instrument. This also has the advantage that a user can hook into a
> > running QEMU instance at any time to perform some instrumentation.
> > 
> > I think this is the bare minimum necessary to make it work, and has the upside
> > of being completely orthogonal to the libqemu approach. We could reuse most of
> > the stable instrumentation API there too, except for the instrumentation code
> > initialization.
> > 
> > That being said, the libqemu approach *might* make it a bit easier to provide an
> > API for things such as "run for this many instructions and return control to
> > instrumentor", but I don't think that's mandatory for a first prototype (and can
> > definitely be implemented using both approaches).
> 
> The main concern I have is that a feature for loading shared libraries
> and hooking QEMU will be abused.  This can be mostly solved by offering
> only a stable API without the ability to hook trace events.  There are
> still ways to abuse this and that's why I prefer the libqemu approach.
> 
> The libqemu approach also avoids the "how do I enable my
> instrumentation?" step for new users because they just need to run their
> program after compiling it.  The workflow is simpler.

Widely used instrumentation tools, such as DynamoRIO and Pin, follow the
same approach Lluis took here, i.e. your plugin is loaded at run-time by the tool.
So from a usability viewpoint I don't think this approach would be controversial.

> As a next step I suggest defining the stable instrumentation API and
> dropping the tracing hooks.  We can still work out whether shared
> library loading or libqemu is okay later but the stable API is most
> important.

I agree with dropping the tracing hooks. However, I wonder whether we'd
want to add another field to struct TranslationBlock to keep track of
the dynamic instrumentation state, or just reuse trace_vcpu_dstate.

I gravitate towards the former approach--would be nice to have the
instrumentation code completely separate from the tracing code, and
hopefully not rely on python nor trace-events files :-)

		Emilio
