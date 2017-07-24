Received: from eggs.gnu.org ([2001:4830:134:3::10]:42290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZg9h-0007zn-9S
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZg9c-0008M0-9x
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:24:25 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZg9c-0008LF-4w
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 12:24:20 -0400
Received: by mail-qk0-x241.google.com with SMTP id t2so10366862qkc.5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 09:24:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<20170724113422.GC2784@stefanha-x1.localdomain>
	<2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7b81efbc-f0ef-3637-1043-9bec4b4266b1@amsat.org>
Date: Mon, 24 Jul 2017 13:24:07 -0300
MIME-Version: 1.0
In-Reply-To: <2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On 07/24/2017 09:17 AM, Denis V. Lunev wrote:
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
>>>    trace: do not calculate arguments for disabled trace-points
>>>    monitor: improve tracing in handle_qmp_command
>> Please use the TRACE_FOO_ENABLED macro instead of putting computation
>> inside the trace event arguments.  This makes the code cleaner and
>> easier to read.
> At our opinion this ENABLED is compile time check while the option
> could be tuned in runtime. Thus normally it would normally be
> enabled while the trace is silent.
> 
> So, under load, we will have extra allocation, copying the command buffer,
> freeing memory without actual trace. In order to fix that we should
> do something like
> 
> if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
>     req_json = qobject_to_json(req);
>     trace_handle_qmp_command(mon, req_json);
>     QDECREF(req_json);
> }
> 
> which is possible, but at our (me + Vova) opinion is ugly.

It seems to me much cleaner/easier to read than your patch, I really 
prefer this way. It is so nice/useful that it deserves to be starred as 
an example in docs/devel/tracing.txt :)

> That is why we are proposing to switch to macro, which
> will not require such tweaking.
> 
> Arguments will be only evaluated when necessary and we
> will not have side-effects if the tracepoint is compile time
> enabled and run-time disabled.
> 
> Though if the code above is acceptable, we can send the
> patch with it. No problem.
> 
> Den
