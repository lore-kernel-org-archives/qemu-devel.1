Received: from eggs.gnu.org ([2001:4830:134:3::10]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dagGC-0006gi-N7
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dagG8-0005Dg-JW
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dagG8-0005DQ-Ad
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:43:12 -0400
Date: Thu, 27 Jul 2017 11:43:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727104302.GI2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Jul 26, 2017 at 12:49:00PM +0100, Peter Maydell wrote:
> On 26 July 2017 at 12:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Tue, Jul 25, 2017 at 02:30:06PM +0100, Peter Maydell wrote:
> >> Is your proposal that my-instrumentation.c gets compiled into
> >> QEMU at this point? That doesn't seem like a great idea to
> >> me, because it means you can only use this tracing if you
> >> build QEMU yourself, and distros won't enable it and so
> >> lots of our users won't have convenient access to it.
> >> I'd much rather see a cleanly designed plugin interface
> >> (which we should be able to implement in a manner that doesn't
> >> let the plugin monkey patch arbitrary parts of QEMU beyond
> >> what can already be achieved via LD_PRELOAD).
> >
> > Trace events are not a stable public API.  They change between releases
> > and need to be interpreted together with the QEMU source code.
> >
> > It doesn't make sense to be doing instrumentation inside the QEMU
> > process but not want to compile QEMU.
> >
> > What is the use case?
> 
> I want the continuous stream of people who come along
> and want to do interesting things (or even just straightforward
> things like "show me all the memory accesses") with tracing
> their guest binary to be able to do so without having to
> rebuild QEMU. We don't require people to rebuild QEMU
> themselves to attach gdb to it, and tracing of guest
> behaviour is a similar "I just want to introspect what
> my guest is doing" use case.
> 
> I think this is distinct from use of the trace API
> for qemu-internal events as used in a lot of the C
> code.
> 
> Some simple use cases:
>  * a plugin which prints out instruction execution traces
> by hooking into "insn executed" and printing something
> helpful (you can extend this into producing traces
> in whatever standard format some other program wants
> to inhale, but at a minimum it would be something we
> could point people at that makes more sense than our
> current "only print insns at translate time" debug);
> it's also easy to add bells and whistles for "start
> tracing at time T" and so on
>  * a plugin that make cachegrind-style guesses about
> cache usage by tracking memory accesses and simulating
> cache effects
>  * a plugin that prints all the system calls the
> guest makes (by hooking into "insn executed" and
> printing info when the insn is an SVC)
>  * trivial statistics like "count executed instructions
> and branches taken"

Maybe I'm missing something, but aren't all these things
already possible via either the statically defined tracepoints
QEMU exposes, or by placing dynamic tracepoints on arbitrary
code locations using dtrace/systemtap/lttng-ust. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
