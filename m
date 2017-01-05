Received: from eggs.gnu.org ([2001:4830:134:3::10]:57866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPG4X-0005qA-2M
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPG4S-0008B7-5x
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:59:45 -0500
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
	<8cb9e1d4-3dca-8a32-9f0d-2173bea52771@redhat.com>
	<20170105214552.GA15064@pacoca>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2b8f962-3a62-8577-c02a-1a2f7b7c080c@redhat.com>
Date: Thu, 5 Jan 2017 15:59:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170105214552.GA15064@pacoca>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B4XxGkitTFmRVXA154fKnukieo5EXS1Rj"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 1/6] target-ppc: Implement
 unsigned quadword left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4XxGkitTFmRVXA154fKnukieo5EXS1Rj
From: Eric Blake <eblake@redhat.com>
To: joserz@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org,
 bharata@linux.vnet.ibm.com
Message-ID: <e2b8f962-3a62-8577-c02a-1a2f7b7c080c@redhat.com>
Subject: Re: [Qemu-ppc] [Qemu-devel] [PATCH v4 1/6] target-ppc: Implement
 unsigned quadword left/right shift and unit tests
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
 <1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
 <8cb9e1d4-3dca-8a32-9f0d-2173bea52771@redhat.com>
 <20170105214552.GA15064@pacoca>
In-Reply-To: <20170105214552.GA15064@pacoca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 03:45 PM, joserz@linux.vnet.ibm.com wrote:

>>
>>> +    { 0, 0, 0ULL, 0, 200, false },
>>
>> If you are going to support shifts larger than 127, your testsuite
>> should include a shift of a non-zero number.  Also, if you are going t=
o
>> implicitly truncate the shift value into range, then accepting a signe=
d
>> shift might be nicer (as there are cases where it is easier to code a
>> shift by -1 than it is a shift by 127).
>=20
> Correct me if I'm wrong: Actually the caller can use the function like:=

>=20
> urshift(low, high, (uint32_t)-1);
>=20
> And I'll get "shift =3D=3D UINT_MAX", which truncates to 127 after "&=3D=
 127".
> I don't need to use a signed integer necessarily, right?

It's not necessary to make the number signed, and in fact, thanks to C
implicit promotion rules and qemu's guarantee that we only compile on
hardware with twos-complement signed numbers, urshift(low, high, -1)
works the same whether the shift parameter is typed as signed or
unsigned (without needing an explicit cast).

It's just that making it signed instead of unsigned makes it slightly
easier to read code by interpreting shifting by -1 as "shift all but the
last bit out" (shifting by -2 is "shift all but the last two bits out",
etc.), where there is no ambiguity what was meant on shift values down
to -127.  In contrast, shifting by UINT_MAX is ambiguous to read without
further consulting the documentation (is it "shift modulo bit width" or
"shift to infinity so that I'm left with 0"?).  Or put another way,
making the shift amount signed makes it OBVIOUS that you are implicitly
masking the shift amount to the maximum width shift (making it perhaps a
bit easier to see that shifting by 128 is a no-op, rather than a synonym
for making the result 0), while leaving the shift amount unsigned almost
argues that you want to assert that the shift amount is in range.


>>> +{
>>> +    shift &=3D 127;
>>
>> This says you allow any shift value (whether negative or beyond 127);
>> either the testsuite must cover this, or you should tighten the contra=
ct
>> and assert that the callers pass a value in range.
>=20
> I prefer to let this function flexible and let the caller decides
> whether to assert it or not before calling these functions. But I'm
> totally open to assert it if you prefer.
>=20
> I'm writing the testcase to cover it.

At any rate, I'm fine with your decision to state that it is up to the
caller to range-check if truncation was not intended, and that the
worker function implicitly truncates rather than noisily asserting a
range - as long as the v5 patch also includes the documentation and
testsuite coverage of this behavior.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--B4XxGkitTFmRVXA154fKnukieo5EXS1Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbsHIAAoJEKeha0olJ0NqZ5cH/ja0mF4RWypZXtjyjJNAYpxj
ErWbeJvcBeGgtJOZCcU5Xnedc15CqMsAMlNAKajZ1mIhV6znqhAo9bFw/mMF+bNA
7cfhf+wLemy18sUi7NI4fum1E9S+4oJVkjkeEoEMJuHLhaIv0iWl6OyzgLhO2KV1
3K6Bmp5eEguvpArrMArxhixBxiQO/fBHlYagzf85Pgqa+5DMwsNKqBOUUO8Nwj0S
enT9LY2VDCX4YdF0wlSb84M360ofSlfeNwzMpU+LUX1iaRCgsv9Op9FkqTC44WCZ
xDSZX3sVlZHDJjJBt5C6aWYY92/aw8PemDMuL8kFinZS8CWAU+33DYDmcd9LMi4=
=Q1aL
-----END PGP SIGNATURE-----

--B4XxGkitTFmRVXA154fKnukieo5EXS1Rj--
