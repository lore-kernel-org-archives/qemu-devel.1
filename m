Received: from eggs.gnu.org ([2001:4830:134:3::10]:38948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db35f-0007kw-MA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db35c-0005tr-7R
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db35b-0005tG-UO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:05:52 -0400
Date: Fri, 28 Jul 2017 12:05:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728110544.GL31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728092053.10122-1-stefanha@redhat.com>
	<20170728092053.10122-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728092053.10122-3-stefanha@redhat.com>
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

On Fri, Jul 28, 2017 at 10:20:53AM +0100, Stefan Hajnoczi wrote:
> Code that checks dstate is unaware of SystemTap and LTTng UST dstate, so
> the following trace event will not fire when solely enabled by SystemTap
> or LTTng UST:
> 
>   if (trace_event_get_state(TRACE_MY_EVENT)) {
>       str = g_strdup_printf("Expensive string to generate ...",
>                             ...);
>       trace_my_event(str);
>       g_free(str);
>   }
> 
> Most users of trace_event_get_state() want to know both QEMU and backend
> dstate for the event.  Update the macro to include backend dstate.
> 
> Introduce trace_event_get_state_qemu() for those callers who really only
> want QEMU dstate.  This includes the trace backends (like 'log') which
> should only trigger when event are enabled via QEMU.

I'm not convinced this is quite right as is.

The QEMU state for an event is set via cli flags to -trace and that
is intended for use with with things like simpletrace or log which
have no other way to filter which events are turned on at runtime.
For these calling trace_event_get_state_dynamic_by_id() is right.

For DTrace / LTT-NG, and event is active if the kernel has turned
on the dynamic probe location.  Any command line args like -trace
should not influence this at all, so we should *not* involve QEMU
state at all - only the backend state. So for these we should only
be calling the backend specific test and ignoring
trace_event_get_state_dynamic_by_id() entirely. Your patch though
makes it consider both.



> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  trace/control.h                     | 20 ++++++++++++++++++--
>  scripts/tracetool/backend/ftrace.py |  2 +-
>  scripts/tracetool/backend/log.py    |  3 ++-
>  scripts/tracetool/backend/simple.py |  2 +-
>  scripts/tracetool/backend/syslog.py |  3 ++-
>  5 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/trace/control.h b/trace/control.h
> index b931824d60..b996c34c08 100644
> --- a/trace/control.h
> +++ b/trace/control.h
> @@ -93,16 +93,32 @@ static bool trace_event_is_vcpu(TraceEvent *ev);
>  static const char * trace_event_get_name(TraceEvent *ev);
>  
>  /**
> + * trace_event_get_state_qemu:
> + * @id: Event identifier name.
> + *
> + * Get the tracing state of an event, both static and the QEMU dynamic state.
> + * Note that some backends maintain their own dynamic state, use
> + * trace_event_get_state() instead if you wish to include it.
> + *
> + * If the event has the disabled property, the check will have no performance
> + * impact.
> + */
> +#define trace_event_get_state_qemu(id)                       \
> +    ((id ##_ENABLED) && trace_event_get_state_dynamic_by_id(id))
> +
> +/**
>   * trace_event_get_state:
>   * @id: Event identifier name.
>   *
> - * Get the tracing state of an event (both static and dynamic).
> + * Get the tracing state of an event (both static and dynamic).  Both QEMU and
> + * backend-specific dynamic state are included.
>   *
>   * If the event has the disabled property, the check will have no performance
>   * impact.
>   */
>  #define trace_event_get_state(id)                       \
> -    ((id ##_ENABLED) && trace_event_get_state_dynamic_by_id(id))
> +    ((id ##_ENABLED) && (trace_event_get_state_dynamic_by_id(id) || \
> +                         id ##_BACKEND_DSTATE()))
>  
>  /**
>   * trace_event_get_vcpu_state:
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index dd0eda4441..fba637b376 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -33,7 +33,7 @@ def generate_h(event, group):
>          '        char ftrace_buf[MAX_TRACE_STRLEN];',
>          '        int unused __attribute__ ((unused));',
>          '        int trlen;',
> -        '        if (trace_event_get_state(%(event_id)s)) {',
> +        '        if (trace_event_get_state_qemu(%(event_id)s)) {',
>          '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
>          '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
>          '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
> diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
> index 54f0a69886..4562b9d12d 100644
> --- a/scripts/tracetool/backend/log.py
> +++ b/scripts/tracetool/backend/log.py
> @@ -33,7 +33,8 @@ def generate_h(event, group):
>          # already checked on the generic format code
>          cond = "true"
>      else:
> -        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
> +        cond = "trace_event_get_state_qemu(%s)" % \
> +               ("TRACE_" + event.name.upper())
>  
>      out('    if (%(cond)s) {',
>          '        struct timeval _now;',
> diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
> index f983670ee1..a39bbdc5c6 100644
> --- a/scripts/tracetool/backend/simple.py
> +++ b/scripts/tracetool/backend/simple.py
> @@ -73,7 +73,7 @@ def generate_c(event, group):
>          # already checked on the generic format code
>          cond = "true"
>      else:
> -        cond = "trace_event_get_state(%s)" % event_id
> +        cond = "trace_event_get_state_qemu(%s)" % event_id
>  
>      out('',
>          '    if (!%(cond)s) {',
> diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
> index 1ce627f0fc..3ee07bf7fd 100644
> --- a/scripts/tracetool/backend/syslog.py
> +++ b/scripts/tracetool/backend/syslog.py
> @@ -33,7 +33,8 @@ def generate_h(event, group):
>          # already checked on the generic format code
>          cond = "true"
>      else:
> -        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
> +        cond = "trace_event_get_state_qemu(%s)" % \
> +               ("TRACE_" + event.name.upper())
>  
>      out('    if (%(cond)s) {',
>          '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
> -- 
> 2.13.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
