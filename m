Received: from eggs.gnu.org ([2001:4830:134:3::10]:42160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eHZEv-0000Pz-0O
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eHZEr-0007jr-P4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 12:55:13 -0500
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-2-mdavidsaver@gmail.com>
	<20171122032852.GG2380@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <791a1520-6f3b-f380-3029-a89cdd0fbff6@gmail.com>
Date: Wed, 22 Nov 2017 11:55:04 -0600
MIME-Version: 1.0
In-Reply-To: <20171122032852.GG2380@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rb53w6tNWrEuoQJEMdltsafNXg7TGiUHj"
Subject: Re: [Qemu-devel] [PATCH 01/12] e500: add board config options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rb53w6tNWrEuoQJEMdltsafNXg7TGiUHj
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <791a1520-6f3b-f380-3029-a89cdd0fbff6@gmail.com>
Subject: Re: [PATCH 01/12] e500: add board config options
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
 <20171120032420.9134-2-mdavidsaver@gmail.com>
 <20171122032852.GG2380@umbus.fritz.box>
In-Reply-To: <20171122032852.GG2380@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 09:28 PM, David Gibson wrote:
> On Sun, Nov 19, 2017 at 09:24:09PM -0600, Michael Davidsaver wrote:
>> allow board code to skip common NIC and guest image setup
>> and configure decrementor frequency.
>> Existing boards unchanged.
>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>=20
> So, it's spelled "decrementer".
>=20
> Other than that, the patch looks correct.  However having a big common
> function for overall init with a pile of ad-hoc configuration
> parameters is usually not a great way to go.  I think what we want
> instead is to eliminate ppce500_init(), instead doing the setup logic
> separately in each of the e500 machines.   The large common slabs of
> code can be helpers in e500.c, but the overall logic - including most
> of the things controlled by the current params - would be under the
> individual machine's control.

I agree that ppce500_init() is unwieldy, and am willing to spend some
time on cleanup.  I'm just not sure what to do.

I can see moving initialization of at least the serial, i2c, gpio, and
possibly MPIC and PCI host bridge into the e500-ccsr class.

I'm not sure what to do with all the device tree construction code in
e500.c, which has a bunch of hard coded register offsets.  A comment
here summarizes the problem nicely.

> /* TODO: parameterize */
> #define MPC8544_CCSRBAR_SIZE       0x00100000ULL
> #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL

It seems desirable to avoid having these offsets appear in two different
files, which could allow them to get out of sync.

I had the idea of using an Interface to split up device tree
construction, and was encouraged to find PnvXScomInterfaceClass which
seems be a way of combining device tree construction in a device class.
Is this the way to go?

Some guidance would be appreciated.

Michael


>> ---
>>  hw/ppc/e500.c      | 8 ++++++--
>>  hw/ppc/e500.h      | 3 +++
>>  hw/ppc/e500plat.c  | 1 +
>>  hw/ppc/mpc8544ds.c | 1 +
>>  4 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index 5cf0dabef3..9e7e1b29c4 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -826,7 +826,7 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>>          env->mpic_iack =3D params->ccsrbar_base +
>>                           MPC8544_MPIC_REGS_OFFSET + 0xa0;
>> =20
>> -        ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
>> +        ppc_booke_timers_init(cpu, params->decrementor_freq, PPC_TIME=
R_E500);
>> =20
>>          /* Register reset handler */
>>          if (!i) {
>> @@ -899,7 +899,7 @@ void ppce500_init(MachineState *machine, PPCE500Pa=
rams *params)
>>      if (!pci_bus)
>>          printf("couldn't create PCI controller!\n");
>> =20
>> -    if (pci_bus) {
>> +    if (pci_bus && !params->tsec_nic) {
>>          /* Register network interfaces. */
>>          for (i =3D 0; i < nb_nics; i++) {
>>              pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio", NULL=
);
>> @@ -948,6 +948,10 @@ void ppce500_init(MachineState *machine, PPCE500P=
arams *params)
>>                                      sysbus_mmio_get_region(s, 0));
>>      }
>> =20
>> +    if (params->skip_load) {
>> +        return;
>> +    }
>> +
>>      /* Load kernel. */
>>      if (machine->kernel_filename) {
>>          kernel_base =3D cur_base;
>> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
>> index 70ba1d8f4f..40f72f2de2 100644
>> --- a/hw/ppc/e500.h
>> +++ b/hw/ppc/e500.h
>> @@ -22,6 +22,9 @@ typedef struct PPCE500Params {
>>      hwaddr pci_mmio_base;
>>      hwaddr pci_mmio_bus_base;
>>      hwaddr spin_base;
>> +    uint32_t decrementor_freq; /* in Hz */
>> +    bool skip_load;
>> +    bool tsec_nic;
>>  } PPCE500Params;
>> =20
>>  void ppce500_init(MachineState *machine, PPCE500Params *params);
>> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
>> index e59e80fb9e..3d07987bd1 100644
>> --- a/hw/ppc/e500plat.c
>> +++ b/hw/ppc/e500plat.c
>> @@ -47,6 +47,7 @@ static void e500plat_init(MachineState *machine)
>>          .pci_mmio_base =3D 0xC00000000ULL,
>>          .pci_mmio_bus_base =3D 0xE0000000ULL,
>>          .spin_base =3D 0xFEF000000ULL,
>> +        .decrementor_freq =3D 400000000,
>>      };
>> =20
>>      /* Older KVM versions don't support EPR which breaks guests when =
we announce
>> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
>> index 1717953ec7..6d9931c475 100644
>> --- a/hw/ppc/mpc8544ds.c
>> +++ b/hw/ppc/mpc8544ds.c
>> @@ -40,6 +40,7 @@ static void mpc8544ds_init(MachineState *machine)
>>          .pci_mmio_bus_base =3D 0xC0000000ULL,
>>          .pci_pio_base =3D 0xE1000000ULL,
>>          .spin_base =3D 0xEF000000ULL,
>> +        .decrementor_freq =3D 400000000,
>>      };
>> =20
>>      if (machine->ram_size > 0xc0000000) {
>=20



--Rb53w6tNWrEuoQJEMdltsafNXg7TGiUHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAloVufkACgkQlAHmyz1/
GOr4ghAAgRlDMnUhRUn53KzmmsZ7SXOHOUpL2yFvrDp5NYwYKQRrSwXbAOorsP7N
SuPN/dDpZw40uEksRlv5sJ1QjP9Lc/3SRpI/9Xu0hLkJMfPOlpaMgXH3ZpzA6KrB
vTgOFzkhKIhO7P62KGigaMCpV95DnWsZMCDH3dBwPbR5m3KVkwg2D4KdVO9WF8qp
fP95bFuWk6Owr+EUcJaN/FCprw1zBTsZ5JwZWUupdrHbO3Gx9oEUZ8vq9SaxklVW
zjCQvmym4N1b9B7fN5cdjre7bUTZ2u2hxvqORT0WAMQy+abd/PC4REhkRnIjFpj5
K6dNaYtLV7pEVuyaqMPSLdjtfMabkIjpuw+CGsjk+N321ze/lsW/uZuDULyV6pQh
N+KmX7rW9lumqK/eZhvZ5bQVstEdoKO7TMD/ydS8psY+bLpS/G+IRZcx49D8rR24
AQ6UkRMYdYrTAVaIf47ZSa0MTM3L+KQRnXMy70a+DOa95yrfoIeowwlF8kT2x8IC
gc9hX3VqjJcRbLdLZBCh8rU/62+mOb7mXssQ1m9SBQMImIteinksApT913cwLj0w
Wmfbib7IGmmlb3WpbDZXt2MSkbrjX/J5ubw5J29JQUJZnB+I39NeiU8L2dhYqzbK
QObOzeO3ijX8bpxszxtoWsTIpfgJjTpZDQU495Tyly1AuzuT0A8=
=gRvR
-----END PGP SIGNATURE-----

--Rb53w6tNWrEuoQJEMdltsafNXg7TGiUHj--
