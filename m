Received: from eggs.gnu.org ([2001:4830:134:3::10]:45301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ciWDU-0004mu-IZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ciWDR-0004lX-CO
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:04:36 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ciWDR-0004lP-4S
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:04:33 -0500
Received: by mail-pf0-x244.google.com with SMTP id p185so1452904pfb.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 17:04:32 -0800 (PST)
References: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170228004101.GG17615@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <00c78b02-a323-d394-5179-932860193006@ozlabs.ru>
Date: Tue, 28 Feb 2017 12:04:26 +1100
MIME-Version: 1.0
In-Reply-To: <20170228004101.GG17615@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5K0UlEttDi6xQDLKk1GvH8PNlBpoQnp6k"
Subject: Re: [Qemu-devel] [PATCH v2] memory: Introduce DEVICE_HOST_ENDIAN
 for ram device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, qemu-devel@nongnu.org, alex.williamson@redhat.com, peter.maydell@linaro.org, paulus@samba.org, mdroth@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5K0UlEttDi6xQDLKk1GvH8PNlBpoQnp6k
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, peter.maydell@linaro.org,
 paulus@samba.org, mdroth@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com
Message-ID: <00c78b02-a323-d394-5179-932860193006@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v2] memory: Introduce DEVICE_HOST_ENDIAN for
 ram device
References: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20170228004101.GG17615@umbus.fritz.box>
In-Reply-To: <20170228004101.GG17615@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 28/02/17 11:41, David Gibson wrote:
> On Mon, Feb 27, 2017 at 12:52:44PM +0800, Yongji Xie wrote:
>> At the moment ram device's memory regions are DEVICE_NATIVE_ENDIAN. It=
's
>> incorrect. This memory region is backed by a MMIO area in host, so the=

>> uint64_t data that MemoryRegionOps read from/write to this area should=
 be
>> host-endian rather than target-endian. Hence, current code does not wo=
rk
>> when target and host endianness are different which is the most common=
 case
>> on PPC64. To fix it, this introduces DEVICE_HOST_ENDIAN for the ram de=
vice.
>>
>> This has been tested on PPC64 BE/LE host/guest in all possible combina=
tions
>> including TCG.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> The effect of the patch is certainly correct.  I remain a little
> concerned that the name "host endian" might cause more confusion than
> it resolves, but a better term isn't immediately obvious to me.


In order to match memory_region_wrong_endianness(), it could be
DEVICE_CORRECT_ENDIAN :)

Just joking :)


>=20
>> ---
>>  include/exec/cpu-common.h |    6 ++++++
>>  memory.c                  |    2 +-
>>  2 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index bd15853..eef74df 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -36,6 +36,12 @@ enum device_endian {
>>      DEVICE_LITTLE_ENDIAN,
>>  };
>> =20
>> +#if defined(HOST_WORDS_BIGENDIAN)
>> +#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
>> +#else
>> +#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
>> +#endif
>> +
>>  /* address in the RAM (different from a physical address) */
>>  #if defined(CONFIG_XEN_BACKEND)
>>  typedef uint64_t ram_addr_t;
>> diff --git a/memory.c b/memory.c
>> index ed8b5aa..17cfada 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void =
*opaque, hwaddr addr,
>>  static const MemoryRegionOps ram_device_mem_ops =3D {
>>      .read =3D memory_region_ram_device_read,
>>      .write =3D memory_region_ram_device_write,
>> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .endianness =3D DEVICE_HOST_ENDIAN,
>>      .valid =3D {
>>          .min_access_size =3D 1,
>>          .max_access_size =3D 8,
>=20


--=20
Alexey


--5K0UlEttDi6xQDLKk1GvH8PNlBpoQnp6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYtMyaDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5Ji8P/1sX
tWRNlF9du9ZTsQI/O9EDpK2J5ZARiQ394XjB5ptnbWDGsZij01ohofxjP2QF0hOi
JDSDrD3yyl8MWl+keKcSmipVg0Kv82ikb5NDsWGk4HG2XzCU7VVLGaGhw7md+Ema
yRPzQjUYsvmhb5E7pMU2e3sFToOKSAMaO8Hz87m63HsQYjeYbXpiu7DT45m+L/v1
UklWdmFNiEbyhG/BhHH0ItgI2gKfj6f7sz9ySJ3JHbFLiptABTc0zXrnlnQPkvkH
teTI2aUp+e0Ff1wwTPVntTJXOxdl8LlvaeNPf3Wb8VomjSKFnab9K2I+OALV8xib
QqsaPEeyg4sDWKwLyKTNoJRBGhM5tA8PDumfl3POdDyJ5nzp0QNTfd9hjNPlO83L
hWZf4Lwo/yZOAlWUbYsc1UJDIrWJUPgTmBKIrohYzi4Iph5/yOYmbVTwmzOkhdD4
EtsG8Ubl/+LVY6SnDN1fqYp5kPZdJDcDGwFl0djG+WERmZQ7WH/3mWp/3E6wYx1b
r6YOclZ7BvR5gx0+ykHVhjrnQqw3iSXKbqAwTrU1eMx34b6Miwyto42RlsYLJmHL
vjG7l5/DCxZvgg5LsstEy0M034DAzHYThjnQwon145OZD8vZYDO3Ura1ckG/jtUa
sucETQ0mEA0sHPoffOcRlkZsgvGp3vQSgrDaSKT1
=ncD9
-----END PGP SIGNATURE-----

--5K0UlEttDi6xQDLKk1GvH8PNlBpoQnp6k--
