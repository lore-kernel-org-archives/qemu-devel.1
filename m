Received: from eggs.gnu.org ([2001:4830:134:3::10]:35147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8xsY-0001dU-LN
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8xsV-0008MA-H4
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:29:06 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8xsV-0008LB-Bd
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 21:29:03 -0400
Date: Sat, 6 Oct 2018 21:29:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181007012900.GB23787@flamenco>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-15-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005154910.3099-15-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH 14/21] trace: add support for plugin
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Oct 05, 2018 at 16:49:03 +0100, Alex Bennée wrote:
(snip)
> +static int bind_to_tracepoints(GModule *g_module, GPtrArray *events)
> +{
> +    int count = 0;
> +    TraceEventIter iter;
> +    TraceEvent *ev;
> +
> +    trace_event_iter_init(&iter, "*");
> +    while ((ev = trace_event_iter_next(&iter)) != NULL) {
> +        const char *name = trace_event_get_name(ev);
> +        gpointer fn;
> +
> +        if (g_module_symbol(g_module, name, &fn)) {
> +            ev->plugin = (uintptr_t) fn;
> +            trace_event_set_state_dynamic(ev, true);
> +            count++;
> +        }
> +    }

I'd rather have subscription functions exposed to the
plugins via an API, so that
- Plugins can turn on and off subscriptions to callbacks
  as they see fit, instead of "being called from
  the very beginning, and then disable forever"
- We can have compile-time failures when doing something
  wrong with callback names :-)

Thanks,

		E.
