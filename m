Received: from eggs.gnu.org ([2001:4830:134:3::10]:41210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFHKm-0008Ts-1G
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFHKh-00058k-Aw
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:19:15 -0500
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-3-david@gibson.dropbear.id.au>
	<e8178564-d4a6-17a8-895d-a88147560cc0@redhat.com>
	<20161209090917.GA23035@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aecc4f5b-1265-13f0-2368-9ea7daad474c@redhat.com>
Date: Fri, 9 Dec 2016 10:18:59 +0100
MIME-Version: 1.0
In-Reply-To: <20161209090917.GA23035@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ClCP3tBF3ktLvQ4MeTtHBthtADtqKAJBj"
Subject: Re: [Qemu-devel] [for-2.9 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ClCP3tBF3ktLvQ4MeTtHBthtADtqKAJBj
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, agraf@suse.de,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 lvivier@redhat.com
Message-ID: <aecc4f5b-1265-13f0-2368-9ea7daad474c@redhat.com>
Subject: Re: [for-2.9 2/5] pseries: Stubs for HPT resizing
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
 <20161209022314.14399-3-david@gibson.dropbear.id.au>
 <e8178564-d4a6-17a8-895d-a88147560cc0@redhat.com>
 <20161209090917.GA23035@umbus.fritz.box>
In-Reply-To: <20161209090917.GA23035@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.12.2016 10:09, David Gibson wrote:
> On Fri, Dec 09, 2016 at 09:18:51AM +0100, Thomas Huth wrote:
>> On 09.12.2016 03:23, David Gibson wrote:
>>> This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
>>> H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
>>> extension to allow run time resizing of a guest's hash page table.  I=
t
>>> also adds a new machine property for controlling whether this new
>>> facility is available, and logic to check that against availability
>>> with KVM (only supported with KVM PR for now).
>>>
>>> Finally, it adds a new string to the hypertas property in the device
>>> tree, advertising to the guest the availability of the HPT resizing
>>> hypercalls.  This is a tentative suggested value, and would need to b=
e
>>> standardized by PAPR before being merged.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  hw/ppc/spapr.c         | 66 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  hw/ppc/spapr_hcall.c   | 36 +++++++++++++++++++++++++++
>>>  hw/ppc/trace-events    |  2 ++
>>>  include/hw/ppc/spapr.h | 11 +++++++++
>>>  target-ppc/kvm.c       | 26 ++++++++++++++++++++
>>>  target-ppc/kvm_ppc.h   |  5 ++++
>>>  6 files changed, 146 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 0f25e83..ecb0822 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -760,6 +760,11 @@ static void spapr_dt_rtas(sPAPRMachineState *spa=
pr, void *fdt)
>>>      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
>>>          add_str(hypertas, "hcall-multi-tce");
>>>      }
>>> +
>>> +    if (spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) {
>>> +        add_str(hypertas, "hcall-hpt-resize");
>>> +    }
>>> +
>>>      _FDT(fdt_setprop(fdt, rtas, "ibm,hypertas-functions",
>>>                       hypertas->str, hypertas->len));
>>>      g_string_free(hypertas, TRUE);
>>> @@ -1839,11 +1844,31 @@ static void ppc_spapr_init(MachineState *mach=
ine)
>>>      long load_limit, fw_size;
>>>      char *filename;
>>>      int smt =3D kvmppc_smt_threads();
>>> +    Error *resize_hpt_err =3D NULL;
>>> =20
>>>      msi_nonbroken =3D true;
>>> =20
>>>      QLIST_INIT(&spapr->phbs);
>>> =20
>>> +    /* Check HPT resizing availability */
>>> +    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
>>> +    if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
>>> +        if (resize_hpt_err) {
>>> +            spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
>>> +            error_free(resize_hpt_err);
>>> +            resize_hpt_err =3D NULL;
>>> +        } else {
>>> +            spapr->resize_hpt =3D smc->resize_hpt_default;
>>> +        }
>>> +    }
>>> +
>>> +    assert(spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DEFAULT);
>>> +
>>> +    if ((spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) && resize=
_hpt_err) {
>>> +        error_report_err(resize_hpt_err);
>>> +        exit(1);
>>> +    }
>>
>> The logic here is IMHO a little bit hard to understand. Why do you nee=
d
>> the SPAPR_RESIZE_HPT_DEFAULT state here at all? Wouldn't it be
>> sufficient to start with SPAPR_RESIZE_HPT_DISABLED by default and to
>> only enable it when the extension is available?
>=20
> Because if the user explicitly sets something, we should never
> override itin the logic here.  In order to determine whether the user
> has set something explicitly, we need another value that means "not
> set explicitly".

Hmm, ok, I think I slowly get it. Another question: Does this also take
care of the handling if the user migrates from a machine that supports
HPT resizing to a machine that does not support this feature?

 Thomas



--ClCP3tBF3ktLvQ4MeTtHBthtADtqKAJBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSncIAAoJEC7Z13T+cC21xUcP/jN9xvC+MOArr8+6GNAeqgs2
E4GZK7ud5B6s1wkxiGqv53SgYgzCgwSh4JRHVX6YV02Vio/UZS6ezOl6HhwgZVnq
JQ5I3soAicP3rxD5kT2w+xlT2Z/jy3Mhby3UmCaFWeT1nsus8BXjZ4xVsTo2Fydz
j02OD246C8wWpi+l5gdOq+ul4QatKXBlCBHvejQfFyap4IrwNUWtjcGsyf1FUQND
Eue/OX/6OsxHEIEli9XE54iVrt74tXvzKMEh9Pkxj01r4xic8/lhAyk0qSNpa3Ca
xNXnfr6IQ2WLGnBXddHS066xvzJ7u9EuJid0x3J6OJF3wUQppH7kpX5EB7gDvpb9
IFbsM56s1UXNc0J5VeJKE3BqUQFwcrTiSNmh+3XM7DebZEMCK6rw/wspiVecgvEq
3Hc47znswPwrDunbC1BANXmzRplMvHHErPcUWQlLPjO2RmZO0mb/zFQdA4fQE3jw
8fTtAtLOilMNcRsevscKJa78tiR+zVLS0pGtDAIm+VxaCxh9U5jCyNgqc7vxH9fB
aQC1qY/n7xgeezlO1G66mG9svPtb2xmz1EoyoIs4R22gIAkCQwCnEexpkSx+2MJa
7upktHSZGcjY4uuRFxsw0bM2r3s2XRvv0JsKdMTIOX7K948/y7LiuXtTsOX7iEpP
Hlc0r7nG06vHP978aBB7
=i2tI
-----END PGP SIGNATURE-----

--ClCP3tBF3ktLvQ4MeTtHBthtADtqKAJBj--
