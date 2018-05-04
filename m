Received: from eggs.gnu.org ([2001:4830:134:3::10]:45212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEX2u-0002zi-4Y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEX2q-0001Qc-G1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:30:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fEX2q-0001QA-9v
	for qemu-devel@nongnu.org; Fri, 04 May 2018 05:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E11F242EF0E5
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 09:30:27 +0000 (UTC)
References: <20180420123456.22196-1-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<908f1079-385f-24d3-99ad-152ecd6b01d2@redhat.com>
	<20180424153154.05e79de7@redhat.com>
	<1046685642.22350584.1524635112123.JavaMail.zimbra@redhat.com>
	<20180425152356.46ee7e04@redhat.com>
	<709141862.22620677.1524664609218.JavaMail.zimbra@redhat.com>
	<20180425172639.3e4d8ca1@redhat.com>
	<212695685.22833607.1524728271984.JavaMail.zimbra@redhat.com>
	<20180504111323.7cb4c7c8@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0c67b8f1-163f-1f69-d2e0-cb50133af7d3@redhat.com>
Date: Fri, 4 May 2018 11:30:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180504111323.7cb4c7c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] virtio-pmem: should we make it
 migratable???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 04.05.2018 11:13, Igor Mammedov wrote:
> On Thu, 26 Apr 2018 03:37:51 -0400 (EDT)
> Pankaj Gupta <pagupta@redhat.com> wrote:
>=20
> trimming CC list to keep people that might be interested in the topic
> and renaming thread to reflect it.
>=20
>>>>>>>>>> +
>>>>>>>>>> +    memory_region_add_subregion(&hpms->mr, addr - hpms->base,
>>>>>>>>>> mr); =20
>>>>>>>>> missing vmstate registration? =20
>>>>>>>>
>>>>>>>> Missed this one: To be called by the caller. Important because e=
.g.
>>>>>>>> for
>>>>>>>> virtio-pmem we don't want this (I assume :) ). =20
>>>>>>> if pmem isn't on shared storage, then We'd probably want to migra=
te
>>>>>>> it as well, otherwise target would experience data loss.
>>>>>>> Anyways, I'd just reat it as normal RAM in migration case =20
>>>>>>
>>>>>> Main difference between RAM and pmem it acts like combination of R=
AM
>>>>>> and
>>>>>> disk.
>>>>>> Saying this, in normal use-case size would be 100 GB's - few TB's
>>>>>> range.
>>>>>> I am not sure we really want to migrate it for non-shared storage
>>>>>> use-case. =20
>>>>> with non shared storage you'd have to migrate it target host but
>>>>> with shared storage it might be possible to flush it and use direct=
ly
>>>>> from target host. That probably won't work right out of box and wou=
ld
>>>>> need some sort of synchronization between src/dst hosts. =20
>>>>
>>>> Shared storage should work out of the box.
>>>> Only thing is data in destination
>>>> host will be cache cold and existing pages in cache should be invali=
dated
>>>> first.
>>>> But if we migrate entire fake DAX RAMstate it will populate destinat=
ion
>>>> host page
>>>> cache including pages while were idle in source host. This would
>>>> unnecessarily
>>>> create entropy in destination host.
>>>>
>>>> To me this feature don't make much sense. Problem which we are solvi=
ng is:
>>>> Efficiently use guest RAM. =20
>>> What would live migration handover flow look like in case of
>>> guest constantly dirting memory provided by virtio-pmem and
>>> and sometimes issuing async flush req along with it? =20
>>
>> Dirty entire pmem (disk) at once not a usual scenario. Some part of di=
sk/pmem
>> would get dirty and we need to handle that. I just want to say moving =
entire
>> pmem (disk) is not efficient solution because we are using this soluti=
on to
>> manage guest memory efficiently. Otherwise it will be like any block d=
evice copy
>> with non-shared storage.  =20
> not sure if we can use block layer analogy here.
>=20
>>>>> The same applies to nv/pc-dimm as well, as backend file easily coul=
d be
>>>>> on pmem storage as well. =20
>>>>
>>>> Are you saying backing file is in actual actual nvdimm hardware? we =
don't
>>>> need
>>>> emulation at all. =20
>>> depends on if file is on DAX filesystem, but your argument about
>>> migrating huge 100Gb- TB's range applies in this case as well.
>>>  =20
>>>>  =20
>>>>>
>>>>> Maybe for now we should migrate everything so it would work in case=
 of
>>>>> non shared NVDIMM on host. And then later add migration-less capabi=
lity
>>>>> to all of them. =20
>>>>
>>>> not sure I agree. =20
>>> So would you inhibit migration in case of non shared backend storage,
>>> to avoid loosing data since they aren't migrated? =20
>>
>> I am just thinking what features we want to support with pmem. And liv=
e migration
>> with shared storage is the one which comes to my mind.
>>
>> If live migration with non-shared storage is what we want to support (=
I don't know
>> yet) we can add this? Even with shared storage it would copy entire pm=
em state?
> Perhaps we should register vmstate like for normal ram and use somethin=
g similar to
>   http://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html th=
is
> to skip shared memory on migration.
> In this case we could use this for pc-dimms as well.
>=20
> David,
>  what's your take on it?

(I assume you were talking to David Gilbert, but still my take on it :))

"shared RAM" use in that context is rather "shared between processes",
no? What would be the benefit of enabling migration for a ramblock but
then again blocking it off?

Anyhow, I think this detail discussion is way to early right now. Pankaj
has some other problems to solve before moving on to migration (yes,
migration is important to keep in mind but not the top priority right
now). And I would consider migration in this context as the next step
once we have the basics sorted out (flushing, threads ...)

>=20
>> Thanks,
>> Pankaj
>> =20


--=20

Thanks,

David / dhildenb
