Received: from eggs.gnu.org ([2001:4830:134:3::10]:42509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNFC-00064i-4X
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqNF5-0002C1-Vz
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqNF5-0002BN-NG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:06:43 -0400
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
	<87h92xk5p7.fsf@dusky.pond.sub.org>
	<7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
	<1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
	<CAJ+F1CKMUGA26PhTchxL3GNBJr11JMdS-eujvhF3gSyLULjbXg@mail.gmail.com>
	<878tnyk223.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2b4d4d4-f141-f70a-ef62-233e1ddb740b@redhat.com>
Date: Tue, 21 Mar 2017 12:06:33 -0500
MIME-Version: 1.0
In-Reply-To: <878tnyk223.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aOwVfh9AgBilOaVxMaJvgpN78xcvgNVN1"
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aOwVfh9AgBilOaVxMaJvgpN78xcvgNVN1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, anderson@redhat.com,
 pbonzini@redhat.com, lersek@redhat.com
Message-ID: <a2b4d4d4-f141-f70a-ef62-233e1ddb740b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
 <20170311132256.22951-5-marcandre.lureau@redhat.com>
 <84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
 <87h92xk5p7.fsf@dusky.pond.sub.org>
 <7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
 <1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
 <CAJ+F1CKMUGA26PhTchxL3GNBJr11JMdS-eujvhF3gSyLULjbXg@mail.gmail.com>
 <878tnyk223.fsf@dusky.pond.sub.org>
In-Reply-To: <878tnyk223.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 11:49 AM, Markus Armbruster wrote:

>=20
> QMP clients that work around the "large positive integers are rejected"=

> bugs by sending large negative ones instead may well exist.  Fixing the=

> interface would break them.  Depressing.  Eric, could you have a peek a=
t
> libvirt?

Yes, libvirt is such a client already.  From
util/virjson.c:virJSONValueObjectAddVArgs():


 * Adds the key-value pairs supplied as variable argument list to @obj.
 *
 * Keys look like   s:name  the first letter is a type code:
=2E..
 * U: unsigned long integer value (see below for quirks)
 * P: unsigned long integer value, omitted if zero
=2E..
        case 'P':
        case 'U': {
            /* qemu silently truncates numbers larger than LLONG_MAX,
             * so passing the full range of unsigned 64 bit integers
             * is not safe here.  Pass them as signed 64 bit integers
             * instead.
             */
            long long val =3D va_arg(args, long long);

            if (!val && type =3D=3D 'P')
                continue;

            rc =3D virJSONValueObjectAppendNumberLong(obj, key, val);
        }   break;

So if we "fix" QMP to reject negative values in place of large unsigned
values, we'll need to also fix libvirt to have a way to introspect the
difference and cope accordingly.  (I'm thinking that we'll have to keep
the negative parsing indefinitely, and can merely improve the parser to
also parse large positive - but that we can still reject values <
INT64_MIN that would have a weird wraparound).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aOwVfh9AgBilOaVxMaJvgpN78xcvgNVN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0V2ZAAoJEKeha0olJ0NqRDgH/0bLQWzvGP/GpSb9ndKwzf47
Rt+f7UZdJthN+kzdN1seTXa70UeJxHzdZqs2FQYIBVc2fLq8ALUPCkVhAmQtJh9z
uBKFvXLqJtpa5StmChTcVDSTnYAnl+LOhJIjVA7dVxZTL6mJKe7uUnNVG30/MclX
ILyG2bcipwbs13Zm6onGMIOekBW4K9Yx21ihyAo4Mq9TO0p6HIuT+NojT9Hdbe3q
1iADSu1o0ix9u+uEUg29cCjtfi5Krs+M4bVgjswZ540ZxfG3/h4ZJbJ3hd3WeHcy
EVlsypmsfsaP337lkrgw1Ac6lWgbcaaIUCOyzY0pG2G0GM+NUEQq38icT2Bo7S0=
=wN9i
-----END PGP SIGNATURE-----

--aOwVfh9AgBilOaVxMaJvgpN78xcvgNVN1--
