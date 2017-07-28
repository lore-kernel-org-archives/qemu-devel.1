Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db84D-0007kz-DU
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db849-00064L-DV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db849-0005xj-4S
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:24:41 -0400
Date: Fri, 28 Jul 2017 17:24:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728162420.GT31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728092053.10122-1-stefanha@redhat.com>
	<20170728092053.10122-3-stefanha@redhat.com>
	<20170728110544.GL31495@redhat.com>
	<20170728155649.GA15534@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728155649.GA15534@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] trace: check backend dstate in
 trace_event_get_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>

On Fri, Jul 28, 2017 at 04:56:49PM +0100, Stefan Hajnoczi wrote:
> On Fri, Jul 28, 2017 at 12:05:44PM +0100, Daniel P. Berrange wrote:
> > On Fri, Jul 28, 2017 at 10:20:53AM +0100, Stefan Hajnoczi wrote:
> > > Code that checks dstate is unaware of SystemTap and LTTng UST dstate, so
> > > the following trace event will not fire when solely enabled by SystemTap
> > > or LTTng UST:
> > > 
> > >   if (trace_event_get_state(TRACE_MY_EVENT)) {
> > >       str = g_strdup_printf("Expensive string to generate ...",
> > >                             ...);
> > >       trace_my_event(str);
> > >       g_free(str);
> > >   }
> > > 
> > > Most users of trace_event_get_state() want to know both QEMU and backend
> > > dstate for the event.  Update the macro to include backend dstate.
> > > 
> > > Introduce trace_event_get_state_qemu() for those callers who really only
> > > want QEMU dstate.  This includes the trace backends (like 'log') which
> > > should only trigger when event are enabled via QEMU.
> > 
> > I'm not convinced this is quite right as is.
> > 
> > The QEMU state for an event is set via cli flags to -trace and that
> > is intended for use with with things like simpletrace or log which
> > have no other way to filter which events are turned on at runtime.
> > For these calling trace_event_get_state_dynamic_by_id() is right.
> > 
> > For DTrace / LTT-NG, and event is active if the kernel has turned
> > on the dynamic probe location.  Any command line args like -trace
> > should not influence this at all, so we should *not* involve QEMU
> > state at all - only the backend state. So for these we should only
> > be calling the backend specific test and ignoring
> > trace_event_get_state_dynamic_by_id() entirely. Your patch though
> > makes it consider both.
> 
> I think you're referring to this:
> 
>   #define trace_event_get_state(id)                       \
>       ((id ##_ENABLED) && (trace_event_get_state_dynamic_by_id(id) || \
>                            id ##_BACKEND_DSTATE()))
> 
> We could change it to:
> 
>   #define trace_event_get_state(id)                       \
>       ((id ##_ENABLED) && id ##_BACKEND_DSTATE())
> 
> and modify the log, syslog, ftrace, etc backends to emit
> trace_event_get_state_dynamic_by_id(id) as their backend dstate.

Yeah that's exactly what I imagined.

> 
> However, in the multi-backend case with ./configure
> --enable-trace-backends=log,syslog this expands to:
> 
>   ((id ##_ENABLED) && (trace_event_get_state_dynamic_by_id(id) || \
>                        trace_event_get_state_dynamic_by_id(id) || \
> 		       false))
> 
> I couldn't bring myself to have multiple calls to
> trace_event_get_state_dynamic_by_id() :).

I don't think that's worth worrying about.

trace_event_get_state_dynamic_by_id() is optimized to a simple inline
condition check. IOW, if you have 3 backends enable concurrently which
each use trace_event_get_state_dynamic_by_id(), this is no worse than
if you have 3 other backends enabled concurrently that each perform
some backend specific check.

Since trace_event_get_state_dynamic_by_id() is inline check, the
compiler might even optimize away the redundant check of the same
variable, or the processor might have optimized it too.

Enabling many backends at once is not particularly common anyway,
but in the absolute worst case, you could make tracetool intelligent
enough to notice the duplicate calls to trace_event_get_state_dynamic_by_id
and merge them into one in the generated code.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
