Received: from eggs.gnu.org ([2001:4830:134:3::10]:51764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTMP3-0004PT-Vb
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTMP0-0000Cl-Pl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:10:41 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-6-david@redhat.com>
	<20180613130113.64852912@redhat.com>
	<1bb1ffd0-2d96-09bb-09aa-348016e452c1@redhat.com>
	<20180613155759.4e78aec0@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b8fd860d-b489-d808-e243-0802598b39fe@redhat.com>
Date: Thu, 14 Jun 2018 09:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180613155759.4e78aec0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/11] spapr: move memory hotplug size
 check into plug code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Haozhong Zhang <haozhong.zhang@intel.com>, Junyan He <junyan.he@intel.com>

On 13.06.2018 15:57, Igor Mammedov wrote:
> On Wed, 13 Jun 2018 13:05:53 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 13.06.2018 13:01, Igor Mammedov wrote:
>>> On Mon, 11 Jun 2018 14:16:49 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> This might look like a step backwards, but it is not. get_memory_reg=
ion()
>>>> should not be called on uninititalized devices. In general, only
>>>> properties should be access, but no "derived" satte like the memory
>>>> region.
>>>>
>>>> 1. We need duplicate error checks if memdev is actually already set.
>>>>    realize() performs these checks, no need to duplicate. =20
>>> it's not duplicate, if a machine doesn't access to memory region
>>> in preplug time (hence doesn't check), then device itself would check=
 it,
>>> check won't be missed by accident.
>>> (yep it's more code but more robust at the same time, so I'd leave it=
 as is) =20
>>
>> Checking at two places for the same thing =3D=3D duplicate checks
> device models and there users are separate entities hence I consider
> checks are separate. If user code can be written without adding extra c=
hecks
> it's fine. But if device model doesn't have its own checks when and is
> used in by new user code without checks also, it's going to break.
>=20
> So it would be hard to convince me that consolidating error handling
> between in-depended layers is a good idea in general and particularly
> in this case.
>=20
> I'd just drop this error cleanups altogether so that they won't get
> in the way of actual changes you are aiming for (unless you have to do =
it).
>=20
>>>> 2. This is bad practise as one can see when looking at the NVDIMM
>>>>    implemetation. The call does not return sane data before the devi=
ce
>>>>    is realized. Although spapr does not use NVDIMM, conceptually it =
is
>>>>    wrong.
>>>>
>>>> So let's just move this call to the right place. We can then cleanup
>>>> get_memory_region(). =20
>>> So I have to say no to this particular patch.
>>> It is indeed a step backwards and it looks like workaround for broken=
 nvdimm impl.
>>>
>>> Firstly, memdev property must be set for dimm device and
>>> a user accessing memory region first must check for error.
>>> More details below.
>>>  =20
>>
>> You assume that any class function can be called at any time. And I
>> don't think this is the way to go.
> Not any time, in the case of get_memory_region() it should work at
> pre_plug() time as all the pieces for it are already there.
> So we should make it work correctly for NVDIMM instead of=20
> succumbing to it and running wild.
> we should stick to canonical sequence
>   object_new -> set props -> realize
> I don't see any reason to violate it in this case other than laziness.
>=20

See my replay to patch nr. 7.

In contrast to what you suggest, I propose converting all nvdimm
properties to static properties (because that's what they actually are).
The validation/initialization of them should happen at a central place,
not at various places (realize(), property setters, or even
get_memory_region()) what you suggest.

I propose a separate function for this (prepare() on DeviceClass), where
we can split of the applicable parts of realize() that just perform
property checks + basic initialization (e.g. of derived properties like
the memory region in case of NVDIMM).

--=20

Thanks,

David / dhildenb
