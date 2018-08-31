Received: from eggs.gnu.org ([208.118.235.92]:37245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvhVl-0004PW-4l
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvhRT-0005Qt-5C
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:18:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fvhRQ-0005QM-I3
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:18:17 -0400
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-15-david@redhat.com>
	<20180831103855.GC2376@work-vm>
	<6aabaa18-33f1-dea3-0824-74f78fcb2d0c@redhat.com>
	<20180831104302.GD2376@work-vm>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8d71de77-9fa8-4100-41be-8e1d689ba98b@redhat.com>
Date: Fri, 31 Aug 2018 13:18:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180831104302.GD2376@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio
 based devices are special
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

On 31.08.2018 12:43, Dr. David Alan Gilbert wrote:
> * David Hildenbrand (david@redhat.com) wrote:
>>
>>>>  static gint memory_device_addr_sort(gconstpointer a, gconstpointer =
b)
>>>>  {
>>>>      const MemoryDeviceState *md_a =3D MEMORY_DEVICE(a);
>>>> @@ -168,6 +184,7 @@ static uint64_t memory_device_get_free_addr(Mach=
ineState *ms,
>>>>      for (item =3D list; item; item =3D g_slist_next(item)) {
>>>>          MemoryDeviceState *md =3D item->data;
>>>>          const MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(OB=
JECT(md));
>>>> +        const char *id =3D memory_device_id(md);
>>>>          uint64_t md_size, md_addr;
>>>> =20
>>>>          md_addr =3D mdc->get_addr(md);
>>>> @@ -178,8 +195,8 @@ static uint64_t memory_device_get_free_addr(Mach=
ineState *ms,
>>>> =20
>>>>          if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>>>>              if (hint) {
>>>> -                const DeviceState *d =3D DEVICE(md);
>>>> -                error_setg(errp, "address range conflicts with '%s'=
", d->id);
>>>> +                error_setg(errp, "address range conflicts with '%s'=
",
>>>> +                           id ? id : 0);
>>>
>>> What's that 'id ? id : 0' trick for?
>>
>> 0 -> "", then it actually makes sense :)
>>
>> I'll fix this up, thanks!
>=20
> Except that:
>=20
>    address range conflicts with ''
> isn't very helpful.
> Why would you get a NULL id ?

This is easy: don't specify an id for a memory device:

Unfortunately, if the user does not give ids to devices, there is no way
of telling him what we are talking about.

qemu-system-x86_64 -machine pc -m 4G,maxmem=3D20G,slots=3D4 \
	-object memory-backend-ram,id=3Dmem0,size=3D4G \
	-object memory-backend-ram,id=3Dmem1,size=3D4G \
	-device pc-dimm,memdev=3Dmem0,addr=3D0x140000000 \
	-device pc-dimm,memdev=3Dmem1,addr=3D0x140000000

qemu-system-x86_64: -device pc-dimm,memdev=3Dmem1,addr=3D0x140000000:
address range conflicts with '(null)'

(I thought providing NULL would lead to a crash, but it is actually
handled properly)

So while not being able to indicate an id is not nice, I can simply
forward the id directly here.

Thanks!

>=20
> Dave
>=20
>>
>> --=20
>>
>> Thanks,
>>
>> David / dhildenb
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--=20

Thanks,

David / dhildenb
