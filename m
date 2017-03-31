Received: from eggs.gnu.org ([2001:4830:134:3::10]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctvA9-0002dZ-0F
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ctvA5-0007jg-VQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:56:17 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ctvA5-0007iY-Ji
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:56:13 -0400
Received: by mail-pg0-x242.google.com with SMTP id g2so16745824pge.2
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 04:56:12 -0700 (PDT)
References: <20170331044711.21749-1-aik@ozlabs.ru>
	<c436e7e1-83be-e30f-5ce9-aa3b993d6be2@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a35e25d9-83d9-9728-d39b-3de0d2ad27bc@ozlabs.ru>
Date: Fri, 31 Mar 2017 22:56:03 +1100
MIME-Version: 1.0
In-Reply-To: <c436e7e1-83be-e30f-5ce9-aa3b993d6be2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9mx0F3Rax8RRFiERdqNt0p9SawaWbR6Vj"
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Only unmap
 bus_master_enabled_region if was added previously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9mx0F3Rax8RRFiERdqNt0p9SawaWbR6Vj
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a35e25d9-83d9-9728-d39b-3de0d2ad27bc@ozlabs.ru>
Subject: Re: [PATCH qemu] pci: Only unmap bus_master_enabled_region if was
 added previously
References: <20170331044711.21749-1-aik@ozlabs.ru>
 <c436e7e1-83be-e30f-5ce9-aa3b993d6be2@redhat.com>
In-Reply-To: <c436e7e1-83be-e30f-5ce9-aa3b993d6be2@redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 31/03/17 21:33, Max Reitz wrote:
> On 31.03.2017 06:47, Alexey Kardashevskiy wrote:
>> Normally pci_init_bus_master() would be called either via
>> bus->machine_done.notify or directly from do_pci_register_device().
>>
>> However if a device's realize() failed, pci_init_bus_master() is not
>> called, and do_pci_unregister_device() fails on
>> memory_region_del_subregion() as it was not mapped.
>>
>> This adds a check that subregion was mapped before unmapping it.
>>
>> Fixes: c53598ed18e4 ("pci: Add missing drop of bus master AS reference=
")
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> This is to pass iotest 051 which does run QEMU like this:
>>
>> ppc64-softmmu/qemu-system-ppc64 -nodefaults -machine accel=3Dqtest -no=
graphic -monitor stdio -serial none -drive if=3Dvirtio
>>
>> which normally fails with:
>>
>> qemu-system-ppc64: -drive if=3Dvirtio: Device needs media, but drive i=
s empty
>>
>> or asserts (without this patch):
>>
>> qemu-system-ppc64: /home/aik/p/qemu-kvm/memory.c:2118: memory_region_d=
el_subregion: Assertion `subregion->container =3D=3D mr' failed.
>> ---
>>  hw/pci/pci.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index bd8043c460..259483b1c0 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -869,8 +869,10 @@ static void do_pci_unregister_device(PCIDevice *p=
ci_dev)
>>      pci_dev->bus->devices[pci_dev->devfn] =3D NULL;
>>      pci_config_free(pci_dev);
>> =20
>> -    memory_region_del_subregion(&pci_dev->bus_master_container_region=
,
>> -                                &pci_dev->bus_master_enable_region);
>> +    if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) =
{
>> +        memory_region_del_subregion(&pci_dev->bus_master_container_re=
gion,
>> +                                    &pci_dev->bus_master_enable_regio=
n);
>> +    }
>>      address_space_destroy(&pci_dev->bus_master_as);
>>  }
>=20
> I'm not sure whether it's generally assumed to be safe to call
> memory_region_is_mapped() on "uninitialized" memory regions
> (bus_master_enable_region is just completely zeroed out before
> pci_init_bus_master(), as far as I can see and guess), but it certainly=

> works in practice, so:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>


PCI device is also initialized via object_initialize() which does memset(=
0)
so I assume it is quite safe.


--=20
Alexey


--9mx0F3Rax8RRFiERdqNt0p9SawaWbR6Vj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJY3kPUDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5W1kP/0Z7
P21frTTk56k+tSjvNpWrd+HuJygalOIC2lemqMWmUy5DEYRaIKntrz5fiML/TgbN
ZqCNp5gvyIvylukWq0kbY8RmxRGNR+vRI4/3Yfm8h0jgliHuJt10pFpQ6ZNsohI4
CwG6k3c3B0VYNQ+khpp4BERWAHub0MYU3Ij6xsQybIwuws+3i1jnlxn//MH8n3ea
QYIgJGOPaniHTRIoi91UM5dw0ntxWhGoguiSMwPWVytAbJcwM+0/TUc1nnaYj1Cp
iguQnR1RGCx1rW3QP92n31qC8wmU2pokxZVzRpGKpGb+3zlmXJohkmXaIKazFqMU
dECnHVYQF6JGICJ3b2hc7A7dOOy6yqfhbzlUiywoISz+49Mghmz+fVUlbe57cx7U
aEPudOx2ATPYnAv79jJNtimzYWskzakJ1GVaBrZwJeZW+dR5U45BKOvS9bVgaAwD
U5WeYHEN32UqS8paTljQaNIaDa4s+q5dDWgmG/8h/oZFXX943uZatH9eovDbQnK9
2mJGfUfRDZBzNIonmUN/1lXlYAZqusRqeo7UFvcLxDLItpshkRCSnAoCAiDXa3VW
Z/Eob1K0c+78oqplpxkPoK4tKDGlHshk3K+cyxMGobpc38HuVQKbuYYLCYj3/3g0
A+pEEWcI9QkCxoFyNrmrOtJem3MIzn9rP80+ZQzI
=9Ycs
-----END PGP SIGNATURE-----

--9mx0F3Rax8RRFiERdqNt0p9SawaWbR6Vj--
