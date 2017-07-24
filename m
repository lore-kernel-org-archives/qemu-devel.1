Received: from eggs.gnu.org ([2001:4830:134:3::10]:41741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dZcIi-0006oh-Ee
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dZcIf-00088c-AC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:17:28 -0400
Received: from mail-he1eur01on070d.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::70d]:49226
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dZcIe-00087V-DI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:17:25 -0400
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<20170724113422.GC2784@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org>
Date: Mon, 24 Jul 2017 15:17:16 +0300
MIME-Version: 1.0
In-Reply-To: <20170724113422.GC2784@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com

On 07/24/2017 02:34 PM, Stefan Hajnoczi wrote:
> On Fri, Jul 21, 2017 at 05:31:47PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>> Current trace system have a drawback: parameters of trace functions
>> are calculated even if corresponding tracepoint is disabled. Also, it
>> looks like trace function are not actually inlined by compiler (at
>> least for me).
>>
>> Here is a fix proposal: move from function call to macros. Patch 02
>> is an example, of how to reduce extra calculations with help of
>> patch 01.
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>   trace: do not calculate arguments for disabled trace-points
>>   monitor: improve tracing in handle_qmp_command
> Please use the TRACE_FOO_ENABLED macro instead of putting computation
> inside the trace event arguments.  This makes the code cleaner and
> easier to read.
At our opinion this ENABLED is compile time check while the option
could be tuned in runtime. Thus normally it would normally be
enabled while the trace is silent.

So, under load, we will have extra allocation, copying the command buffer=
,
freeing memory without actual trace. In order to fix that we should
do something like

if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
   req_json =3D qobject_to_json(req);
   trace_handle_qmp_command(mon, req_json);
   QDECREF(req_json);
}

which is possible, but at our (me + Vova) opinion is ugly.
That is why we are proposing to switch to macro, which
will not require such tweaking.

Arguments will be only evaluated when necessary and we
will not have side-effects if the tracepoint is compile time
enabled and run-time disabled.

Though if the code above is acceptable, we can send the
patch with it. No problem.

Den
