Received: from eggs.gnu.org ([2001:4830:134:3::10]:57865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebq0H-0001na-1T
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebq0G-0007vz-2k
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:51:53 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
Date: Wed, 17 Jan 2018 18:51:38 +0300
MIME-Version: 1.0
In-Reply-To: <1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

17.01.2018 18:23, Eric Blake wrote:
> On 01/17/2018 07:36 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>>> looks interesting. what about the following naming?
>>>>>
>>>>> @mode: possible values:
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 hide - just hide server from new clients, maintain
>>>>> existing connections,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 remove after all clients disconnected
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 soft - like hide, but answer with ESHUTDOWN for all
>>>>> further requests from
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =
=C2=A0 existing connections
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 hard - hard disconnect all clients and remove server
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (default: soft)
>>>> Or even a fourth mode that causes an immediate error return without
>>>> state change if there are any connected clients, but otherwise removes
>>>> the server.
>>>>
>>>>> new corresponding states of nbd export:
>>>>> hidden, shutting_down
>>>>>
>>>>> and we allow transitions:
>>>>>
>>>>> normal_execution -> hidden
>>>>> normal_execution -> shutting_down
>>>>> normal_execution -> exit
>>>>> hidden -> shutting_down
>>>>> hidden -> exit
>>>>> shutting_down -> exit
>>>> Seems reasonable.=C2=A0 Are you planning on tackling a respin of this =
series
>>>> incorporating that idea?
>>>>
>>> yes, will do.
>>>
>>>
>> Discussed with Nikolay.
>> For now we actually need only one mode: hard.
>> In near future we _may be_ will need your proposed fourth mode (what
>> about "safe" name for it ?)
> 'safe' sounds reasonable.
>
> Of course, if we only have two modes at front ('safe' which returns an
> error if a client is connected, and 'hard' which disconnects all clients
> immediately; leaving 'hide' and 'soft' for the future), then we don't
> have to worry about a state transition or any hidden exports.
>
> A QAPI enum with only two values now is at least extensible in the
> future if someone has a need for another mode, and introspectible to
> learn which modes are currently supported.
>
>> I was going to implement all 4 modes, but now I doubt, isn't it too
>> hastily, to introduce 3 new modes to the
>> interface, which we (personally) do not need. May be it is better to
>> start from one or two modes.
> Starting with just two modes is fine as well.
>
>> Finally what do you think, Eric? Which modes do you need?
> 'hide' may be interesting for the purpose of connecting a single client,
> then hiding the export so no other clients can connect, while waiting
> for the first client to take its time.  But right now, I don't have
> actual use cases in mind so much as making sure we aren't limiting
> ourself from future expansion as needs are identified, so a conservative
> choice of just 'safe' and 'hard' for now is reasonable.

ok, I agree. 'safe' looks like better option for default behavior. So=20
I'll post these two options in v3.

>
>> ps: I've created hmp version for 2/6, it will be in v2.
>>  =C2=A0also, I'm going to add query-nbd-server, which should list all ex=
ports
> Sounds good.
>
>> also, about HMP: If I understand correctly, people use it because
>> writing qmp command by hand is not very comfortable.
>> I have a script (for managing libvirt guest, but it can be adopted for
>> qemu or even used for qemu monitor), which allows
>> me run qmp commands on vms as easy as:
>>
>> |qmp VMNAME query-block-jobs or qmp VMNAME nbd-server-remove name exp1
>> mode hard or even |
>>
>> |qmp VMNAME blockdev-add id disk driver qcow2 cache {writeback true
>> direct true} aio native discard unmap file {driver file filename
>> /tmp/somedisk} |||
> Yeah, there are various scripting solutions around QMP that can make it
> easier; but HMP is often still an easy front-line interface for experimen=
ts.
>

isn't it because these solutions are not available directly in monitor,=20
when HMP is?
may be, we need third type of monitor HQMP which is QMP with simplified=20
syntax? Or
allow qmp commands in simplified syntax directly in HMP?

--=20
Best regards,
Vladimir
