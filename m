Received: from eggs.gnu.org ([2001:4830:134:3::10]:39819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebqOO-00084a-HW
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebqOL-0004OD-AV
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:16:48 -0500
References: <20180117141849.65757-1-borntraeger@de.ibm.com>
	<20180117141849.65757-3-borntraeger@de.ibm.com>
	<20180117153727.2552d1a2.cohuck@redhat.com>
	<94c656aa-4c1d-5297-8e3a-2816c3628290@redhat.com>
	<34233d9f-2a81-3e81-8ea1-c8f11ccb29bc@de.ibm.com>
	<66733c96-819a-c1ef-fada-42057324d224@redhat.com>
	<616ff4d0-f8e0-b8f3-e631-f469b82a1735@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c3e2cd72-1df6-0769-6b07-174b3c3536ce@redhat.com>
Date: Wed, 17 Jan 2018 17:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <616ff4d0-f8e0-b8f3-e631-f469b82a1735@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/kvm: Handle bpb feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 17.01.2018 17:07, Halil Pasic wrote:
>=20
>=20
> On 01/17/2018 04:10 PM, David Hildenbrand wrote:
>>>> As soon as we enable bits for CPU models, we guarantee that migratio=
n
>>>> works. While introducing this change we already had one example wher=
e
>>>> this was not the case. Not good. (and remember having another such
>>>> exception)
>>> The point is migration continues to work. In fact I had a different v=
ersion
>>> of this patch set that did it the other way around. Keep 82 a transpa=
rent
>>> and add a new cpu misc facility that takes care of the migration stat=
e.
>>>> It is easier to patch a feature in than silently enabling *anything*
>>>> somebody thinks is transparent (but its not). Especially not for the
>>>> host model. The expanded host model is migration safe.
>>> I really do not care about -cpu host (host-passthrough) for migration=
 safety,=20
>>> because its not. And as you said: host-model (expanded) will work.
>>>
>> It will if the world would be perfect.
>>
>> expand "-cpu host" -> -cpu z14-base,stfle_82=3Don
>>
>> stfle_82 would now not be properly migrated. Yes, it might work someho=
w
>> right now. But it is not clean.
>>
>=20

Please don't only focus on this case. I had different reasons why this
is a bad idea (especially IBC and feature names). And this is still my
position.

> Based on the code (did not test) I would expect to see this in the
> scenario I think you are talking about David:
>=20
> 0. Libvirt uses cpu mode host (not host-passtrough).
> 1. Source: -"cpu host" expands to "-cpu z14-base,stfle_82=3Don" as you =
said
> the whole environment (host cpu, kvm, qemu) is supporting 82 inclusive =
migration
> 2. Target: libvirt requires "-cpu z14-base,stfle_82=3Don" when trying t=
o migrate
> 2.1. If the target environment as a whole does not fully support 82 the=
 model
> checking refuses the migration. It does not matter if the reason is QEM=
U missing
> patch #2 or lack of HW support or whatever.

Let's assume stfle_999, because this is obviously not a problem for 82.

If source and target blindly forward a feature they think is migration
safe, but is not (again, I am being conservative here as I was given a
counter example in the very same patch set), migration does not fail but
the guest might see a difference, because some state is not properly
migrated.

>=20
> Assumed my reasoning above is correct, I really don't get what is not c=
lean.
> Except 'blindly' trusting the hardware that it works as advertised (and
> fixing the mess only if it turns out that there is a mess).
>=20
> On a meta level I think I understand your concerns David to some extent=
.
> But for my taste here you are too concerned about the user shooting her=
self
> into the foot (because equipment malfunction or user error).

Using the host model in QEMU shoots you in the foot. And it shouldn't.
Better safe than sorry.

>=20
> Let me also note, that while we might very well end up propagating bugs
> to the user, we also give the user the means to mitigate these (e.g.
> by turning the buggy features explicitly off like -cpu host,stfle_82=3D=
off).

Shoot first and then ask questions? :D

I don't see any valid reason for this risk. Forwarding "transparent"
features from KVM to QEMU - perfect idea. Forwarding "transparent"
features from QEMU to the guest - not a good idea.

New HW -> new features -> new QEMU CPU model.

Patching in CPU features is really "out of order" ( ;) )

>=20
> Regards,
> Halil
>=20


--=20

Thanks,

David / dhildenb
