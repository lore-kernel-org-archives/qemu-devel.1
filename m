Received: from eggs.gnu.org ([2001:4830:134:3::10]:48502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcCRB-00012p-Et
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcCR7-0003eI-I1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcCR7-0003dS-8R
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:16:49 -0400
Date: Mon, 31 Jul 2017 16:16:39 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170731151639.GE21310@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170731140718.22010-1-stefanha@redhat.com>
	<20170731140718.22010-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731140718.22010-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] trace: add
 TRACE_<event>_BACKEND_DSTATE()
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

On Mon, Jul 31, 2017 at 03:07:17PM +0100, Stefan Hajnoczi wrote:
> QEMU keeps track of trace event enabled/disabled state and provides
> monitor commands to inspect and modify the "dstate".  SystemTap and
> LTTng UST maintain independent enabled/disabled states for each trace
> event, the other backends rely on QEMU dstate.
> 
> Introduce a new per-event macro that combines backend-specific dstate
> like this:
> 
>   #define TRACE_MY_EVENT_BACKEND_DSTATE() ( \
>       QEMU_MY_EVENT_ENABLED() || /* SystemTap */ \
>       tracepoint_enabled(qemu, my_event) /* LTTng UST */ || \
>       false)
> 
> This will be used to extend trace_event_get_state() in the next patch.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


> diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
> index c6812b70a2..17f902cc62 100644
> --- a/scripts/tracetool/backend/dtrace.py
> +++ b/scripts/tracetool/backend/dtrace.py
> @@ -44,8 +44,20 @@ def generate_h_begin(events, group):
>      out('#include "%s"' % header,
>          '')
>  
> +    # SystemTap defines <provider>_<name>_ENABLED() but other DTrace
> +    # implementations might not.
> +    for e in events:
> +        out('#ifndef QEMU_%(uppername)s_ENABLED',
> +            '#define QEMU_%(uppername)s_ENABLED() false',
> +            '#endif',
> +            uppername=e.name.upper())


IIUC, this means that on other DTrace impls, any trace points guarded by
QEMU_*_ENABLED() will never run, even if DTrace probes are set. Having
some trace points silently never run makes it pretty useless IMHO.

IOW, you need the opposite, #define it to true. The probe will still
only be executed if DTrace has enabled it, but you'll have to take the
hit of evaluating the probe arguments regardless. Not as optimized
performance-wise, but functionally correct at least.

>  
>  def generate_h(event, group):
>      out('    QEMU_%(uppername)s(%(argnames)s);',
>          uppername=event.name.upper(),
>          argnames=", ".join(event.args.names()))
> +
> +
> +def generate_h_backend_dstate(event, group):
> +    out('    QEMU_%(uppername)s_ENABLED() || \\',
> +        uppername=event.name.upper())

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
