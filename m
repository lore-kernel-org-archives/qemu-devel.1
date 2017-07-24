Received: from eggs.gnu.org ([2001:4830:134:3::10]:48018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZeZp-00021O-Qb
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZeZn-0008JT-4N
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:43:17 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:34883)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZeZm-0008IQ-Nf
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:43:15 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<20170724113422.GC2784@stefanha-x1.localdomain>
	<2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org>
Date: Mon, 24 Jul 2017 17:43:05 +0300
In-Reply-To: <2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org> (Denis
	V. Lunev's message of "Mon, 24 Jul 2017 15:17:16 +0300")
Message-ID: <87y3rdopza.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

Denis V Lunev writes:

> On 07/24/2017 02:34 PM, Stefan Hajnoczi wrote:
>> On Fri, Jul 21, 2017 at 05:31:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Current trace system have a drawback: parameters of trace functions
>>> are calculated even if corresponding tracepoint is disabled. Also, it
>>> looks like trace function are not actually inlined by compiler (at
>>> least for me).
>>> 
>>> Here is a fix proposal: move from function call to macros. Patch 02
>>> is an example, of how to reduce extra calculations with help of
>>> patch 01.
>>> 
>>> Vladimir Sementsov-Ogievskiy (2):
>>> trace: do not calculate arguments for disabled trace-points
>>> monitor: improve tracing in handle_qmp_command
>> Please use the TRACE_FOO_ENABLED macro instead of putting computation
>> inside the trace event arguments.  This makes the code cleaner and
>> easier to read.
> At our opinion this ENABLED is compile time check while the option
> could be tuned in runtime. Thus normally it would normally be
> enabled while the trace is silent.

> So, under load, we will have extra allocation, copying the command buffer,
> freeing memory without actual trace. In order to fix that we should
> do something like

> if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
>    req_json = qobject_to_json(req);
>    trace_handle_qmp_command(mon, req_json);
>    QDECREF(req_json);
> }

> which is possible, but at our (me + Vova) opinion is ugly.
> That is why we are proposing to switch to macro, which
> will not require such tweaking.

> Arguments will be only evaluated when necessary and we
> will not have side-effects if the tracepoint is compile time
> enabled and run-time disabled.

> Though if the code above is acceptable, we can send the
> patch with it. No problem.

I completely get your point, but:

* I'm not sure it will have much of a performance impact.
* It is not obvious what's going to happen just by looking at the code of the
  calling site.

I prefer to minimize the use of macros, even if that makes a few trace event
calls to be a bit more verbose, as in your example above. Also, I quite dislike
the new style you propose:

  trace_handle_qmp_command(mon,
                           qstring_get_str(req_json = qobject_to_json(req)));
  QDECREF(req_json);


Cheers,
  Lluis
