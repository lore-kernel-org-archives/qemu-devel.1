Received: from eggs.gnu.org ([2001:4830:134:3::10]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7tz-0002Gd-CT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7tu-0001ga-F8
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co7tu-0001gI-6K
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:19:34 -0400
References: <20170315081641.20588-1-pbonzini@redhat.com>
	<7d1e7414-1194-2d81-1058-62b6313b625e@redhat.com>
	<CAFEAcA8GCnA8ri1KEiCjmcjxPUTQtih9u0DT10NLjtZ9=Zx_vA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <171bdcbd-25d4-9659-2ef1-ece063bf4945@redhat.com>
Date: Wed, 15 Mar 2017 07:19:31 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8GCnA8ri1KEiCjmcjxPUTQtih9u0DT10NLjtZ9=Zx_vA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9CJ92Ifd0d8hMb8Gif5cFml88vb9fur19"
Subject: Re: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9CJ92Ifd0d8hMb8Gif5cFml88vb9fur19
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <171bdcbd-25d4-9659-2ef1-ece063bf4945@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] coverity-model: model
 address_space_read/write
References: <20170315081641.20588-1-pbonzini@redhat.com>
 <7d1e7414-1194-2d81-1058-62b6313b625e@redhat.com>
 <CAFEAcA8GCnA8ri1KEiCjmcjxPUTQtih9u0DT10NLjtZ9=Zx_vA@mail.gmail.com>
In-Reply-To: <CAFEAcA8GCnA8ri1KEiCjmcjxPUTQtih9u0DT10NLjtZ9=Zx_vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 06:58 AM, Peter Maydell wrote:
> On 15 March 2017 at 11:55, Eric Blake <eblake@redhat.com> wrote:
>> On 03/15/2017 03:16 AM, Paolo Bonzini wrote:
>>> -MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAtt=
rs attrs,
>>> -                             uint8_t *buf, int len, bool is_write)
>>> +MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>>> +                               MemTxAttrs attrs,
>>> +                               uint8_t *buf, int len)
>>>  {
>>>      MemTxResult result;
>>> -
>>>      // TODO: investigate impact of treating reads as producing
>>>      // tainted data, with __coverity_tainted_data_argument__(buf).
>>> -    if (is_write) __bufread(buf, len); else __bufwrite(buf, len);
>>
>> Old code did __bufread for reads,
>=20
> Eh? for a read is_write is false, and we use the else clause,
> which is __bufwrite...

Maybe I shouldn't send emails when I've just woken up? It threw me that
we have a function named 'read' relying on coverity's 'write' - but
you're correct that it has always been that way, and thinking about it
more, what is really happening is:

our function named 'read' is emulating getting data from hardware (the
'read' portion) and copying it into the buffer (the 'write' portion);
the Coverity model needs to know about the effects to the buffer, but
could care less about the hardware emulation side.

Okay, you've straightened me out, so I can give:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9CJ92Ifd0d8hMb8Gif5cFml88vb9fur19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyTFTAAoJEKeha0olJ0Nqt7QH/iFhI1r83UrrlD9YqPm5yqGK
e1eG/ZugVIAHWka8nDfwG/NTVsT3VrtKM8gGsEdbo/nyZImIJqQrVW9we5+fr/AZ
WRmZLtGZoPm5/LYRT6MQUXCQhDKQrgxiKfta8djhlDqIeuPbQL3ljxT9ivMl498Z
uye//S32YP4dhvr101+0bqjnYQ9Jooqvr1TipPqBiJHLOi9NX6oQKVETE77xj9HB
GCCjg7JFYgO5qBIGwc2E2Q5DaOZg5eajHDgbgDHJ61HVkJoRopNFjusPaFqYpP7c
N4vefRGu9E/u8+4GBrYjIq6nQ49pbtIhxcQY8frZnEK3tf0h2reJx0ynroiTkiM=
=boo/
-----END PGP SIGNATURE-----

--9CJ92Ifd0d8hMb8Gif5cFml88vb9fur19--
