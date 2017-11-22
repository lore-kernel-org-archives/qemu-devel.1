Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eHN64-0001y4-DV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eHN5z-0006M3-Il
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:57:16 -0500
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-4-mdavidsaver@gmail.com>
	<20171122034637.GI2380@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <f6cdbf61-d595-7710-3c33-d2cf908c93c3@gmail.com>
Date: Tue, 21 Nov 2017 22:57:03 -0600
MIME-Version: 1.0
In-Reply-To: <20171122034637.GI2380@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KKtfmTMm3m3IG0K7uTbFb56OW2FvXcxUl"
Subject: Re: [Qemu-devel] [PATCH 03/12] e500: note possible bug with host
 bridge
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
--KKtfmTMm3m3IG0K7uTbFb56OW2FvXcxUl
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <f6cdbf61-d595-7710-3c33-d2cf908c93c3@gmail.com>
Subject: Re: [PATCH 03/12] e500: note possible bug with host bridge
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
 <20171120032420.9134-4-mdavidsaver@gmail.com>
 <20171122034637.GI2380@umbus.fritz.box>
In-Reply-To: <20171122034637.GI2380@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 09:46 PM, David Gibson wrote:
> On Sun, Nov 19, 2017 at 09:24:11PM -0600, Michael Davidsaver wrote:
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>=20
> I'm not sure if you're saying you think there is a hardware bug which
> we're faithfully emulating, or a software bug.

I mean that the emulation is incorrect in that it just sets
config[PCI_HEADER_TYPE]=3D=3DPCI_HEADER_TYPE_BRIDGE but does none of the
other initialization of the base-pci-bridge class.

I specifically observed Linux being confused by the fact that the
primary, secondary, and subordinate bus registers don't work right
because they're actually the BAR2 address register.

Further, it seems odd that a host bridge would identify itself as a
pci-to-pci bridge.  The mpc8540 doesn't.  The mpc8544 docs aren't clear,
and I don't have a real one to test.  My inclination is to remove the
line changing PCI_HEADER_TYPE, but I'm hesitant about breaking things.
Especially since this doesn't trigger mis-behavior in Linux or RTEMS.

>> ---
>>  hw/pci-host/ppce500.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
>> index f2d108bc8a..0e2833bd98 100644
>> --- a/hw/pci-host/ppce500.c
>> +++ b/hw/pci-host/ppce500.c
>> @@ -424,6 +424,9 @@ static void e500_pcihost_bridge_realize(PCIDevice =
*d, Error **errp)
>>      MemoryRegion *ccsr_mr =3D sysbus_mmio_get_region(ccsr, 0);
>> =20
>>      pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
>> +    /* BUG? identifies as PCI_HEADER_TYPE_BRIDGE but uses
>> +     * standard device config read/write
>> +     */
>>      d->config[PCI_HEADER_TYPE] =3D
>>          (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION)=
 |
>>          PCI_HEADER_TYPE_BRIDGE;
>=20



--KKtfmTMm3m3IG0K7uTbFb56OW2FvXcxUl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAloVA6MACgkQlAHmyz1/
GOqVYQ/8DrU9CQ9dLXMyAfTNv06u3IEZLBwwFfLNTwE0S86Lf1q/rP6Q9+nIq9rP
jHxEJ+6SVmB5f5jSnXNLDwSNQBfIHom94uaH9GzN3Yy9QMyG5ePj8Jyctac46b0m
Cq5lyBf4CQc/GvpD0u1N/Qv+H1R4IXk/Tvz9VQpsXfQeaY1p4GjEuk3hm0Y+UFdJ
bFZXS8i/FBXg1GaLDJRejoI2CvL0CtBMfh7NudZT6PfcJwXqHu+XVnnMSbz41rrU
X17L1zZG6NkOVYQOhy0FKP4k4czG38JDGaGw0tju/RZEQuAVsn0wBqoP3T33CI+O
mFaEvqK5MJl2qPFAA5GZm7qFDQW3KX5RiL8PSOTcG6bN/ddc6gVSZ3pwNPab1NeN
ezc4oLd1bQzPvE8wzUEwpOkVZblx2QisqaKrE6sqMnvHfzU8KTtucBWAsxpyNXoO
lgxJ4YxAUY8OQf1O8d2s1MGz6wO6ct325Kibi7KY6J3o5lLutEFUy/7aXRt9Cahd
QC7bLs9L9V/qYFQU4YeSAjc61Leouh0o6RG4WDAFdfgcnk406TJMllrvEPyCgqGK
60Z77gaIKSbL54G/HC1hGcOCcD8f9Yknro/mynPrn96lBmnv/Hx6l6YK/keof9u/
WgcgHvFzIwduOYk30s7DcQQ+YQhpicQJ/yDU8+XNV0LitRJEDaM=
=jmkY
-----END PGP SIGNATURE-----

--KKtfmTMm3m3IG0K7uTbFb56OW2FvXcxUl--
