Received: from eggs.gnu.org ([2001:4830:134:3::10]:50705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dh81C-0007kj-0e
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 01:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dh817-0007OH-30
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 01:34:26 -0400
References: <1502527090-11473-1-git-send-email-thuth@redhat.com>
	<20170812121651.497c6e39@bahia.lan>
	<20170814032456.GA3452@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53b4a8b5-dd86-4afd-d3c6-a0304fa4dc70@redhat.com>
Date: Mon, 14 Aug 2017 07:34:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170814032456.GA3452@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="og73qpjImPMl9Bc57i5bG5e8X5N5GBEge"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr_cpu_core: Add a
 proper check for spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--og73qpjImPMl9Bc57i5bG5e8X5N5GBEge
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.08.2017 05:24, David Gibson wrote:
> On Sat, Aug 12, 2017 at 12:16:51PM +0200, Greg Kurz wrote:
>> On Sat, 12 Aug 2017 10:38:10 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> QEMU currently crashes when the user tries to add a spapr-cpu-core
>>> on a non-pseries machine:
>>>
>>> $ qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg \
>>>                     -device POWER5+_v2.1-spapr-cpu-core
>>> hw/ppc/spapr_cpu_core.c:178:spapr_cpu_core_realize_child:
>>> Object 0x55cee1f55160 is not an instance of type spapr-machine
>>> Aborted (core dumped)
>>>
>>> So let's add a proper check for the correct machine time with
>>> a more friendly error message here.
>>>
>>> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/ppc/spapr_cpu_core.c   | 9 ++++++++-
>>>  scripts/device-crash-test | 1 +
>>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>>> index ea278ce..0f3d653 100644
>>> --- a/hw/ppc/spapr_cpu_core.c
>>> +++ b/hw/ppc/spapr_cpu_core.c
>>> @@ -175,11 +175,18 @@ static void spapr_cpu_core_unrealizefn(DeviceSt=
ate *dev, Error **errp)
>>>  static void spapr_cpu_core_realize_child(Object *child, Error **errp=
)
>>>  {
>>>      Error *local_err =3D NULL;
>>> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>>> +    sPAPRMachineState *spapr;
>>>      CPUState *cs =3D CPU(child);
>>>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>>>      Object *obj;
>>> =20
>>> +    spapr =3D (sPAPRMachineState *)object_dynamic_cast(qdev_get_mach=
ine(),
>>> +                                                     TYPE_SPAPR_MACH=
INE);
>>> +    if (!spapr) {
>>> +        error_setg(errp, "spapr-cpu-core needs a pseries machine");
>>> +        return;
>>> +    }
>>> +
>>
>> This is the realize function for individual threads. Maybe this sanity=
 check
>> should be performed earlier at the core level in spapr_cpu_core_realiz=
e() ?
>=20
> Ah, yes, that would be a better way of doing it.
>=20
> I'm also not clear if you're proposing this for 2.10 or 2.11.

I was not sure, either ;-) Anyway, it's not a bug that blocks normal
usage of QEMU, and apparently there's a better but more extensive way to
fix this, so let's postpone this to 2.11.

 Thomas


--og73qpjImPMl9Bc57i5bG5e8X5N5GBEge
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZkTZVAAoJEC7Z13T+cC21+zAQAICS4bUFO7HbfhEavhshnoPn
YPsMjwuE9HWOthAH4J5je3WWd2C39jxro65nP0ssLi29b0TZfYvHKk0uTZnuW+Iz
rb5EqdE7ma68oOWd5giIpKrK7Izk65xcAAO2ldYifHoWpkS8QYATXfvA/XhB/tkP
CqO1hmYb39BgUOVaQSvPGHHH93O96i6T9UZddpkLeh/f4wxvnSqhrcojQoiTUHsx
zqludiQX/J7S0eRqC93l5QbRG9gTds8qoASciU1pKR4O8i85El+fnLHY+8vywKUf
4zbDHalto36p7MMaZYTBBwV2aCZEKgVW8duHqrdBAyPYrPCnIvm62Up6QiC4rRXZ
FlKCysDiEXRceHtmHyuG3O+eFN+AZUoSuA4YvJynYBGjM9OvkMbmWAL6e+TZV67j
r5hMU8L46Rr9Trbi9H98OXCY25rLEsKVbMEvnYqXi264OnPzxUP6/zBRnfKjqAFQ
iUZFLivk282lgG/rsbU9dJrn2kLmRC2zGv/7iWf8ICzrCgxUf5xdgT2ofVEs0h0A
BDg7F20lIBcEKfn701GngvRxTgeyRhq5NyXGGAYTab4hEMuIXQMd4HmOYckdkri7
EUSjzlKDOHfaBhuqEnZNXYOX3yvqR/iabjo75XrtqIk8JJHpDRjcIJVG7urRbXgF
CoGDnyGWltQiXus5Far+
=WpIF
-----END PGP SIGNATURE-----

--og73qpjImPMl9Bc57i5bG5e8X5N5GBEge--
