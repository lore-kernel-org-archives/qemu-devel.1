Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8JLp-0007Nu-M1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 02:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8JLk-0000ek-N1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 02:12:37 -0400
References: <1538647621-9376-1-git-send-email-thuth@redhat.com>
	<20181005042527.GN7004@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1322d08f-9612-99d6-7ace-7b470beafa9a@redhat.com>
Date: Fri, 5 Oct 2018 08:12:12 +0200
MIME-Version: 1.0
In-Reply-To: <20181005042527.GN7004@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="YAZuzcFIpaZNQfYojoch52DtlJmvG1Ha9"
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
--YAZuzcFIpaZNQfYojoch52DtlJmvG1Ha9
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <1322d08f-9612-99d6-7ace-7b470beafa9a@redhat.com>
Subject: Re: [PATCH] hw/ppc/spapr_rng: Introduce CONFIG_SPAPR_RNG switch for
 spapr_rng.c
References: <1538647621-9376-1-git-send-email-thuth@redhat.com>
 <20181005042527.GN7004@umbus.fritz.box>
In-Reply-To: <20181005042527.GN7004@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-10-05 06:25, David Gibson wrote:
> On Thu, Oct 04, 2018 at 12:07:01PM +0200, Thomas Huth wrote:
>> The spapr-rng device is suboptimal when compared to virtio-rng, so
>> users might want to disable it in their builds. Thus let's introduce
>> a proper CONFIG switch to allow us to compile QEMU without this device=
=2E
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Uh, sure, I guess so.

Yes, we definitely want this for the QEMU in RHEL :-)

>> diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
>> index d2acd61..dec8434 100644
>> --- a/hw/ppc/spapr_rng.c
>> +++ b/hw/ppc/spapr_rng.c
>> @@ -27,6 +27,7 @@
>>  #include "sysemu/rng.h"
>>  #include "hw/ppc/spapr.h"
>>  #include "kvm_ppc.h"
>> +#include "spapr_rng.h"
>> =20
>>  #define SPAPR_RNG(obj) \
>>      OBJECT_CHECK(sPAPRRngState, (obj), TYPE_SPAPR_RNG)
>> @@ -132,29 +133,6 @@ static void spapr_rng_realize(DeviceState *dev, E=
rror **errp)
>>      }
>>  }
>> =20
>> -int spapr_rng_populate_dt(void *fdt)
>> -{
>> -    int node;
>> -    int ret;
>> -
>> -    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
>> -    if (node <=3D 0) {
>> -        return -1;
>> -    }
>> -    ret =3D fdt_setprop_string(fdt, node, "device_type",
>> -                             "ibm,platform-facilities");
>> -    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
>> -    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
>> -
>> -    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
>> -    if (node <=3D 0) {
>> -        return -1;
>> -    }
>> -    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random"=
);
>> -
>> -    return ret ? -1 : 0;
>> -}
>> -
>=20
> Moving this to an inline doesn't seem right to me though - it's a more
> complex function that we usually want in a .h inline, and I don't
> really see a good reason for it to be there (rather than an #ifdeffed
> stub).

An #ifdef is not possible here - the CONFIG switches for the targets are
*not* turned into pre-processor macros, only the CONFIG switches for the
host settings. So putting this function as static inline into a separate
header seems to be the best option to me right now. Alternatively, I
could also put it directly into spapr.c directly, but that file is
already very big... well, I don't mind, let me know what you prefer.

 Thomas


--YAZuzcFIpaZNQfYojoch52DtlJmvG1Ha9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbtwDMAAoJEC7Z13T+cC21lDUP/2YSBpFAk72SCzAU3UKKfCpG
sCUUtj6vL0eLdnWbaLy9ginok5iYpIZHiYlu5P/0iP9XZ7YBJBWXygp+1Q53+VjZ
2gZ6rC6r2W+N6ldmIR4KL6c3jk79I3MmU8FKXHbBpUPXUMdFOaIEjUzDw5mPAkvT
2wtveKtTzepuC4ALNfEfSxk5td8n7WVmJ+xdUit1gGPeBL1b/hFIV8LEznsyMt5x
DvxIZZUFFlV4HOqLcxpC7gDdyFHFbCIQNtNqZpo9B9bYWgACxCc6UzyXIuOoBnIH
WSTMgqcCfTP/3NylW6jtgIayP9auMGJvgfyG8zQBc4JaaHbs2lrkyVOl2RxNXsX1
C6J6N156MADbfaywRQFPDKEbeXxA0apz9h8n1aT+G/BlAmMZ+m86E15CzIG/1D5e
NEnTMIqkBOErL48Ad+gCUicHbWgd7/SU8QXhN2hoTNB4wkme9S7J1XWa7CNbAgOh
uPcuFHjSnlZLwHIX8Pvtv3PJZ1W9xA9Uqnda4+DNQ9NNDOLj/KU38Cpt8BxLP1Jy
PsfEH26v3866M8VIgko8Rp2mkL7+84re6hM8G2hk70GImGkjfQRulfeEf7rFSBYo
biFIQoo4vgmrnU4Ko4Lra9B2XV5M7Sw9z5d3MLDJLSsAU+6lifaD+9MYPZoZ5fb3
W9i9g1TiHnNp+kH5mD4/
=mv30
-----END PGP SIGNATURE-----

--YAZuzcFIpaZNQfYojoch52DtlJmvG1Ha9--
