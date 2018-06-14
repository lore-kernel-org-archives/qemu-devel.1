Received: from eggs.gnu.org ([2001:4830:134:3::10]:44486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTTub-0001N1-5t
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTTuX-0006Q8-9l
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:11:45 -0400
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-8-david@redhat.com>
	<20180613150320.3d6d11ca@redhat.com>
	<430ef63d-0e9b-5925-5d5a-b6804ec7d988@redhat.com>
	<045b1a53-fdf2-36db-2898-cfee0849232a@redhat.com>
	<20180614170051.62104d16@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3ba714d3-2031-5ddd-d21a-afdaee97f685@redhat.com>
Date: Thu, 14 Jun 2018 17:11:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180614170051.62104d16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 14.06.2018 17:00, Igor Mammedov wrote:
> On Wed, 13 Jun 2018 16:50:54 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 13.06.2018 16:07, David Hildenbrand wrote:
>>> On 13.06.2018 15:03, Igor Mammedov wrote: =20
>>>> On Mon, 11 Jun 2018 14:16:51 +0200
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>> =20
>>>>> We already verify when realizing that the memdev property has been
>>>>> set. We have no more accesses to get_memory_region() before the dev=
ice
>>>>> is realized. =20
>>>> this stems from assumption that get_memory_region shouldn't be calle=
d
>>>> before devices realize is executed, which I don't agree to begin wit=
h.
>>>>
>>>> However wrt error handling, we should probably leave device internal=
 error
>>>> up to devices and make check for error only in pre_plug handler
>>>> (since pre_plug was successful, the rest machine helpers would have
>>>> access to the same region until device is removed.
>>>> =20
>>>
>>> Something like a generic Device "validate()"/"pre_realize()" function=
,
>>> that can be called before realize() and validates all properties
>>> (+initializes derived properties) would be something I could agree to=
.
>>>
>>> Then we could drop all error handling from access functions (as they
>>> have been validated early during pre_plug())
>>>
>>> Moving all checks out of realize into pre_plug() looks ugly, because =
we
>>> have implementation details split across c-files.
>>>  =20
>>
>> I am thinking about something like this
>>
>> From ee8da4f5774ff5fa190466674e36ee99020033c4 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Wed, 13 Jun 2018 16:41:12 +0200
>> Subject: [PATCH RFC] device: add "prepare()" function
>>
>> The realize() function usually does several things. It validates
>> properties, inititalizes state based on properties and performs
>> e.g. registrations in the system that require "unrealize()" to be call=
ed
>> when removing the device.
>>
>> In a pre_plug hotplug handler, we usually want to access certain
>> properties or derived properties, e.g. to perform advanced checks
>> (for resource asignment). Now we have the problem, that realize() was
>> not called yet once we reach pre_plug(). So we theoretically have to
>> duplicate checks and add error paths for cases that can
>> theoretically never happen.
> I care less about duplicate checks in completely different parts of cod=
e,
> and I'd even insist on device:realize checks being self contained and n=
ot
> rely on any other external checks performed by users of device. And vic=
e
> verse layer that uses device should do it's own checks when necessary
> and not rely on device's verification. That way loosely coupled code
> wouldn't fall apart whenever we drop or change checks in one of the par=
ts.
>=20
> The only case where I'd make concession is minimizing error handling
> on hot path for performance reasons and this is not the case here.
>=20
>> Let's add the "prepare()" callback, which can be used to validate
>> properties and inititalize some state based on these. It will be calle=
d
>> once all static properties have been inititalized, but before the
>> pre_plug hotplug handler is activated. The pre_plug handler can than
>> rely on the fact that basic checks already were performed.
>=20
> pre_plug isn't part of device, it's a separate part that might vary
> depending on machine and which might modify device properties along
> the way and then exaggerating we would need 'prepare2()' and after
> that 'pre_plug2()' and ...

That's how two parties (device vs hotplug handler) work together to get
results done ... Just like inititalize() -> realized() vs. pre_plug ->
plug(). There has to be some hand shaking.

>=20
> Hence I dislike idea of adding more callbacks. I'd rather have a proper=
ty
> setter do the job of initializing state of device when necessary instea=
d
> of adding more callbacks. Which is in nvdimm case a bit more code compa=
red
> to doing it in realize() but should be possible to implement.

Although I strongly disagree (especially about the fact of calling class
functions *anytime* after a device has been created but not initialized)
I will implement it like that for now (otherwise I won't be making any
progress here but instead be creating more and more problems to solve).


nvdimm will only have static properties. When realizing or when calling
get_memory_region(), properties will be checked and the nvdimm_mr
inititalized, if not already done.

--=20

Thanks,

David / dhildenb
