Received: from eggs.gnu.org ([2001:4830:134:3::10]:38586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9TWL-00030F-SZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g9TQs-000471-8T
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:10:41 -0400
References: <1538647621-9376-1-git-send-email-thuth@redhat.com>
	<20181005042527.GN7004@umbus.fritz.box>
	<1322d08f-9612-99d6-7ace-7b470beafa9a@redhat.com>
	<20181008005703.GQ7004@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2bbbb695-b8a6-e7a4-72cf-2268f7f6c173@redhat.com>
Date: Mon, 8 Oct 2018 13:10:26 +0200
MIME-Version: 1.0
In-Reply-To: <20181008005703.GQ7004@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="MOU48CjcQYdQQ3dJ1sgsZs5iJWYxJHcOw"
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MOU48CjcQYdQQ3dJ1sgsZs5iJWYxJHcOw
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <2bbbb695-b8a6-e7a4-72cf-2268f7f6c173@redhat.com>
Subject: Re: [PATCH] hw/ppc/spapr_rng: Introduce CONFIG_SPAPR_RNG switch for
 spapr_rng.c
References: <1538647621-9376-1-git-send-email-thuth@redhat.com>
 <20181005042527.GN7004@umbus.fritz.box>
 <1322d08f-9612-99d6-7ace-7b470beafa9a@redhat.com>
 <20181008005703.GQ7004@umbus.fritz.box>
In-Reply-To: <20181008005703.GQ7004@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-10-08 02:57, David Gibson wrote:
> On Fri, Oct 05, 2018 at 08:12:12AM +0200, Thomas Huth wrote:
>> On 2018-10-05 06:25, David Gibson wrote:
>>> On Thu, Oct 04, 2018 at 12:07:01PM +0200, Thomas Huth wrote:
>>>> The spapr-rng device is suboptimal when compared to virtio-rng, so
>>>> users might want to disable it in their builds. Thus let's introduce=

>>>> a proper CONFIG switch to allow us to compile QEMU without this devi=
ce.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Uh, sure, I guess so.
>>
>> Yes, we definitely want this for the QEMU in RHEL :-)
>>
>>>> diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
>>>> index d2acd61..dec8434 100644
>>>> --- a/hw/ppc/spapr_rng.c
>>>> +++ b/hw/ppc/spapr_rng.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include "sysemu/rng.h"
>>>>  #include "hw/ppc/spapr.h"
>>>>  #include "kvm_ppc.h"
>>>> +#include "spapr_rng.h"
>>>> =20
>>>>  #define SPAPR_RNG(obj) \
>>>>      OBJECT_CHECK(sPAPRRngState, (obj), TYPE_SPAPR_RNG)
>>>> @@ -132,29 +133,6 @@ static void spapr_rng_realize(DeviceState *dev,=
 Error **errp)
>>>>      }
>>>>  }
>>>> =20
>>>> -int spapr_rng_populate_dt(void *fdt)
>>>> -{
>>>> -    int node;
>>>> -    int ret;
>>>> -
>>>> -    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");=

>>>> -    if (node <=3D 0) {
>>>> -        return -1;
>>>> -    }
>>>> -    ret =3D fdt_setprop_string(fdt, node, "device_type",
>>>> -                             "ibm,platform-facilities");
>>>> -    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
>>>> -    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
>>>> -
>>>> -    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
>>>> -    if (node <=3D 0) {
>>>> -        return -1;
>>>> -    }
>>>> -    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,rando=
m");
>>>> -
>>>> -    return ret ? -1 : 0;
>>>> -}
>>>> -
>>>
>>> Moving this to an inline doesn't seem right to me though - it's a mor=
e
>>> complex function that we usually want in a .h inline, and I don't
>>> really see a good reason for it to be there (rather than an #ifdeffed=

>>> stub).
>>
>> An #ifdef is not possible here - the CONFIG switches for the targets a=
re
>> *not* turned into pre-processor macros, only the CONFIG switches for t=
he
>> host settings.
>=20
> Ah, right.
>=20
>> So putting this function as static inline into a separate
>> header seems to be the best option to me right now. Alternatively, I
>> could also put it directly into spapr.c directly, but that file is
>> already very big... well, I don't mind, let me know what you prefer.
>=20
> I'd prefer spapr.c to the inline.
>=20
> But.. couldn't you put a stub version in stubs?  That would make a
> weak symbol that would be overridden when SPAPR_RNG is compiled in.

We could ... but stubs should IMHO only be used if there is no other
good solution. In this case, it's perfectly fine if we just move the
spapr_rng_populate_dt() function to another location. So I'll have a try
with spapr.c instead.

 Thomas


--MOU48CjcQYdQQ3dJ1sgsZs5iJWYxJHcOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbuzsqAAoJEC7Z13T+cC21aIAQALAzCGmkADOMMi+Cl+DmiZdA
PhlzMil1vCAUScw5z3NXqDUHTRJygaPpF2923xzSb//1F9ndwkivt0t1fE1i4JQC
/mGrfxVFWGGmbtbC2oOBZfHJrmpKWUQvjk1epG0BO+4QPNooSCD0jupUEVEQs/bK
CZ4SEv2YwPHSoYuxPGduyOc2k7HFVAJzb+gnwq11PghBJgda/vB8OjNO/r3ytlVG
Dgb0MR8VDwP209s1QsjOaRYdE76KjQErqu4iuJ1JofpaluZcrx+WstgKkCpcoaDp
HNz/8jxuxhgW66c5jsUACDdVb7ABbjGyimKpcBRJqEi2OEySVexz1cdgvT62Rg6Q
So7iPgoPOMoWPBeU08qnh0EMmqk3+WXQFsZbVdaEWGFTHZW5fmGMPRigg7lz1BT4
089cKjfEEP0TAhsYRMhkc/AnrO2EV2e0vOsP05wBCUylnsIfg4joXnXOZWXnkiey
4a2trrah3keCkFH1oQLHtYZZBbYPJhmjPEEd+Ygr+zixxFai+uL+8h4BeC+jSzKB
z6fJ1lEp8JlIF/qSIS83KcuboTtrk5G0JvXalC5h9iXRjK5kBivs6zA4pF3Rac//
cXS71Pa1OfRj488XZGbyi0E69PT5wrLDPJesJmyxXrp/7UATtJxJe+W4qJajFme3
3GL3EQvjwViXyYuKCEFh
=nB6M
-----END PGP SIGNATURE-----

--MOU48CjcQYdQQ3dJ1sgsZs5iJWYxJHcOw--
