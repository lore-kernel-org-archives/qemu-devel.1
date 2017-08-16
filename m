Received: from eggs.gnu.org ([2001:4830:134:3::10]:41314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dhp2t-0005UO-SC
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 23:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dhp2q-0006kU-Ns
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 23:31:03 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dhp2q-0006iI-BV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 23:31:00 -0400
Received: by mail-pf0-x244.google.com with SMTP id c65so195476pfl.0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 20:30:58 -0700 (PDT)
References: <20170720072231.35054-1-aik@ozlabs.ru>
	<20170720072231.35054-2-aik@ozlabs.ru>
	<20170724055316.GJ17228@umbus.fritz.box>
	<81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
	<20170809073346.GR13670@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f93ac9b-a559-6a6d-3665-e1f4496b12ff@ozlabs.ru>
Date: Wed, 16 Aug 2017 13:30:51 +1000
MIME-Version: 1.0
In-Reply-To: <20170809073346.GR13670@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nKVEJkrfdimC9qocxufQTx8PopBQwOrdk"
Subject: Re: [Qemu-devel] [PATCH qemu v4 1/3] spapr_iommu: Realloc guest
 visible TCE table when hot(un)plugging vfio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nKVEJkrfdimC9qocxufQTx8PopBQwOrdk
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Message-ID: <2f93ac9b-a559-6a6d-3665-e1f4496b12ff@ozlabs.ru>
Subject: Re: [PATCH qemu v4 1/3] spapr_iommu: Realloc guest visible TCE table
 when hot(un)plugging vfio-pci
References: <20170720072231.35054-1-aik@ozlabs.ru>
 <20170720072231.35054-2-aik@ozlabs.ru>
 <20170724055316.GJ17228@umbus.fritz.box>
 <81254aff-3d78-556e-71df-5ea71bf960d9@ozlabs.ru>
 <20170809073346.GR13670@umbus.fritz.box>
In-Reply-To: <20170809073346.GR13670@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/17 17:33, David Gibson wrote:
> On Mon, Jul 24, 2017 at 08:48:45PM +1000, Alexey Kardashevskiy wrote:
>> On 24/07/17 15:53, David Gibson wrote:
>>> On Thu, Jul 20, 2017 at 05:22:29PM +1000, Alexey Kardashevskiy wrote:=

>>>> This replaces g_malloc() with spapr_tce_alloc_table() as this is
>>>> the standard way of allocating tables and this allows moving the tab=
le
>>>> back to KVM when unplugging a VFIO PCI device and VFIO TCE accelerat=
ion
>>>> support is not present in the KVM.
>>>
>>> So, I like the idea here, and I think it will work for now, but one
>>> thing concerns me.
>>>
>>> AIUI, your future plans include allowing in-kernel accelerated TCE
>>> tables even with VFIO devices.  When that happens, we might have an
>>> in-kernel table both before and after a change in the "need_vfio"
>>> state.
>>
>> The in-kernel table just stays there, mappings will be replayed but in=
 the
>> end of the replay only the hardware table will change.
>>
>>>
>>> But you won't be able to have two in-kernel tables allocated at once,=

>>> whereas this code relies on having both the old and new tables at onc=
e
>>> so it can copy the contents over.
>>>
>>> How do you intend to handle that?
>>
>> I intend to make this function no-op when cap_spapr_vfio is present.
>>
>>
>>>
>>>> Although spapr_tce_alloc_table() is expected to fail with EBUSY
>>>> if called when previous fd is not closed yet, in practice we will no=
t
>>>> see it because cap_spapr_vfio is false at the moment.
>>>
>>> I don't follow this.  How would cap_spapr_vfio be changing at any
>>> point?
>>
>> It depends on the version of the host kernel.
>=20
> Ok.  I'm still a bit dubious about the line of reasoning here, but the
> patch is correct for now, so we just have to make sure subsequent
> changes work with it.
>=20
> Applied to ppc-for-2.11.

Thanks, what about the other two (2/3, 3/3)?



--=20
Alexey


--nKVEJkrfdimC9qocxufQTx8PopBQwOrdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZk7xrDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5xgAP/j95
gR05ozAE/TyqWEsxsSgypuL63paCJ3BLzd1aZkn5Xvd4jjikrCBVl9kIu7jFyy7c
nY2nU5Z5j7gp6vQK6R0qVYWNcKAwpEVANclNkBDPlE8WlZvaLa+yCJo5sRD4GVE3
Ij9GCoa3WWxG23Jxc9Wj+xsiVwm/VYZDNDCD4bGqbOfo8ZcakZsULiq7Ao0JKSVp
cDdywQDwsvi0dOX20f32AZ6KLmrCAC5KAgHSmcVEHyFDjR5h/OuTfE36IMFWRbu6
nf49vleSsdz8Zb4Ez+9hby5IZTMKmrE+q8JF51dT+B0GkkNaCh+EaGWcRrW/XN6R
2uhRh3Q+ScbiHMKnxpH91EQCoeGrPLGXpiSg+lT2gQaD+o63AeV7syKtRx8i7byM
BBGgOpmSuO5+6Xep/kC8sPmuxAmEsVCwPFdwNAMEpFidHkb22WFfjHTLQrRwW1ah
7y59KxHwi5yw2ODUak1N69Xs/p7EeP7nWy8c4kF8tNGlZz2AbPF+/aIO5w2SjVOE
oR71tMn044+dkiVrNK9ptZ5DLPelZ04BIQeHTeMQ20kL6kmXr/sEvuRDF5iK75P+
57lcLsqFAUW6CXV5Xd2FXi1m0ujXCY0Zx65o9l927vMk7kEiYu3tAMa/qMbq/ejV
0w8o2hjVRhrvlhkhyrbLbkCrIg22mgSoe06GzSNy
=9zdx
-----END PGP SIGNATURE-----

--nKVEJkrfdimC9qocxufQTx8PopBQwOrdk--
