Received: from eggs.gnu.org ([2001:4830:134:3::10]:51521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7SX-00013t-47
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej7SW-000863-0a
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:55:09 -0500
References: <20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
	<eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
	<1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
	<2e145d8b-855f-9060-1b81-feb515067293@virtuozzo.com>
	<20180126150511.GG2610@work-vm>
	<ac366ae3-d7e0-db65-d5ee-d276a42320da@virtuozzo.com>
	<665b0973-1cf4-8926-1a53-cb392684ba36@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c4310d6f-4fa7-bca3-f30d-6cff51591734@virtuozzo.com>
Date: Tue, 6 Feb 2018 20:54:54 +0300
MIME-Version: 1.0
In-Reply-To: <665b0973-1cf4-8926-1a53-cb392684ba36@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

06.02.2018 19:06, Eric Blake wrote:
> On 02/06/2018 09:29 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> most of commands, ported to hmp are done in same style: they just call
>>>> corresponding qmp command.
>>>> Isn't it better to provide common interface for calling qmp=20
>>>> commands through
>>>> HMP monitor, to never
>>>> create hmp versions of new commands? they will be available=20
>>>> automatically.
>>> It would be nice to do that, but they're not that consistent in how=20
>>> they
>>> convert parameters and options, but I occasionally wonder if we could
>>> automate more of it.
>>
>>
>> What about allowing some new syntax in hmp, directly mapped to qmp?
>>
>> something like
>>
>> =C2=A0>>> blockdev-add id disk driver qcow2 cache {writeback true direct=
=20
>> true} aio native discard unmap file {driver file filename /tmp/somedisk}
>>
>
> Personally, if I'm testing blockdev-add, I'll use QMP directly (or=20
> even scripts/qmp/qmp-shell or virsh qemu-monitor-command), not an HMP=20
> wrapper where I have to learn a new syntax of how to write something=20
> that will convert to QMP.=C2=A0 We already have enough different ways to=
=20
> write things that I don't need to learn yet another syntax wrapper.=C2=A0=
=20
> Or maybe what I'm saying is that instead of inventing a new syntax,=20
> that if you DO add an HMP command that forwards to QMP, please reuse=20
> an existing syntax (whether direct JSON as used by QMP, or the syntax=20
> used by qmp-shell).

I'm afraid, that JSON is too hard to use in human monitor. And this will=20
make the whole feature useless.

>
> If you think writing a new HMP command is worth it, I won't stop you=20
> from writing it.=C2=A0 But at this point, our current approach of writing=
 a=20
> manual wrapper per command as we have interest, rather than a generic=20
> wrap-anything, has worked for the cases that HMP users have cared=20
> about. =C2=A0Remember, QMP is the interface that MUST work, while HMP is=
=20
> only for convenience, and if it is not trivial to make HMP do=20
> everything that QMP can do, it is no real loss.
>

But we create hmp wrappers on demand, and for each case, we actually=20
invent new syntax. I just search for the way to avoid creating new and=20
new hmp wrappers, by introducing new syntax only once.
And, here is almost nothing to learn:

command :=3D command-name parameters
parameters =3D [key value ]...
value =3D simple-value | array | map
map =3D '{' parameters '}'
array =3D '[' [value ]... ']'

another variant is to use yaml - like json, but we do not need put all=20
keys into quotes.

On the other hand, implementing new parser in qemu is not trivial task=20
(hmm, I don't want do it=3D), it should be simpler to create direct JSON=20
wrapper in HMP monitor, and use some python wrapper around the monitor.=20
And this looks useless, as with same result I can use wrapper around QMP=20
monitor. So, may be the most interesting solution would be to make some=20
easy-to-use python-based wrapper, which will give a simple way to use=20
both qmp and hmp commands.. I'll think about it. However it doesn't=20
solve initial problem of creating new and new hmp wrappers by hand.

>> ?
>>
>> Or it may be realized as a separate hmp command "qmp" (looks more=20
>> safe as a first step, however, I think previous variant (direct call)=20
>> is better):
>>
>> =C2=A0>>> qmp blockdev-add id disk driver qcow2 cache {writeback true=20
>> direct true} aio native discard unmap file {driver file filename=20
>> /tmp/somedisk}
>>
>> what do think? This looks simple to implement and should be useful.
>
> Up to you if you want to tackle anything like that, but it would be a=20
> new thread (a generic way to invoke QMP from HMP is independent of=20
> nbd-server-remove).
>


--=20
Best regards,
Vladimir
