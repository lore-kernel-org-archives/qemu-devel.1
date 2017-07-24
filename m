Received: from eggs.gnu.org ([2001:4830:134:3::10]:50286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dZelW-0007N1-VM
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dZelS-00075H-QG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:55:23 -0400
Received: from mail-eopbgr50128.outbound.protection.outlook.com
	([40.107.5.128]:45078
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dZelR-00074l-Ty
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:55:18 -0400
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<20170724113422.GC2784@stefanha-x1.localdomain>
	<2c20cdf2-9e70-89ef-f323-d7ef77f70b29@openvz.org>
	<87y3rdopza.fsf@frigg.lan>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <d5c6df93-1610-cf55-71b9-940da91a355e@openvz.org>
Date: Mon, 24 Jul 2017 17:55:11 +0300
MIME-Version: 1.0
In-Reply-To: <87y3rdopza.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On 07/24/2017 05:43 PM, Llu=C3=ADs Vilanova wrote:
> Denis V Lunev writes:
>
>> On 07/24/2017 02:34 PM, Stefan Hajnoczi wrote:
>>> On Fri, Jul 21, 2017 at 05:31:47PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
>>>> Current trace system have a drawback: parameters of trace functions
>>>> are calculated even if corresponding tracepoint is disabled. Also, i=
t
>>>> looks like trace function are not actually inlined by compiler (at
>>>> least for me).
>>>>
>>>> Here is a fix proposal: move from function call to macros. Patch 02
>>>> is an example, of how to reduce extra calculations with help of
>>>> patch 01.
>>>>
>>>> Vladimir Sementsov-Ogievskiy (2):
>>>> trace: do not calculate arguments for disabled trace-points
>>>> monitor: improve tracing in handle_qmp_command
>>> Please use the TRACE_FOO_ENABLED macro instead of putting computation=

>>> inside the trace event arguments.  This makes the code cleaner and
>>> easier to read.
>> At our opinion this ENABLED is compile time check while the option
>> could be tuned in runtime. Thus normally it would normally be
>> enabled while the trace is silent.
>> So, under load, we will have extra allocation, copying the command buf=
fer,
>> freeing memory without actual trace. In order to fix that we should
>> do something like
>> if (trace_event_get_state(TRACE_HANDLE_QMP_COMMAND)) {
>>    req_json =3D qobject_to_json(req);
>>    trace_handle_qmp_command(mon, req_json);
>>    QDECREF(req_json);
>> }
>> which is possible, but at our (me + Vova) opinion is ugly.
>> That is why we are proposing to switch to macro, which
>> will not require such tweaking.
>> Arguments will be only evaluated when necessary and we
>> will not have side-effects if the tracepoint is compile time
>> enabled and run-time disabled.
>> Though if the code above is acceptable, we can send the
>> patch with it. No problem.
> I completely get your point, but:
>
> * I'm not sure it will have much of a performance impact.
> * It is not obvious what's going to happen just by looking at the code =
of the
>   calling site.
>
> I prefer to minimize the use of macros, even if that makes a few trace =
event
> calls to be a bit more verbose, as in your example above. Also, I quite=
 dislike
> the new style you propose:
>
>   trace_handle_qmp_command(mon,
>                            qstring_get_str(req_json =3D qobject_to_json=
(req)));
>   QDECREF(req_json);
>
>
> Cheers,
>   Lluis
This is a matter of overall performance. For example I can have 500 VMs.
In order to manage them, f.e. tweak balloon I have to collect statistics.=

This happens 1 time/10 sec/VM. Libvirt issues the following

494665@1486641285.213042:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name "=
query-balloon"
494665@1486641285.214181:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name "=
qom-get"
494665@1486641285.214792:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name "=
query-hotpluggable-cpus"
494665@1486641285.215283:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name "=
query-cpus"
494665@1486641285.216153:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name "=
query-blockstats"
494665@1486641285.216827:handle_qmp_command mon 0x7f7fbce6bea0 cmd_name "=
query-block"

We will have 300 commands in a second in all VMs. This is not that small
load. OK. I do think that I'll lost 2-3-5 percents of one host CPU due
to this allocation/free/copy. There are no measurements unfortunately.
At my opinion this matters.

Den
