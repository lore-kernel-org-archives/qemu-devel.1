Received: from eggs.gnu.org ([2001:4830:134:3::10]:48978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJJJ7-0005yA-Tj
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJJJ3-0004Or-CM
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJJJ3-0004Ob-2E
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:46:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F22ADC057FA7
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 12:46:23 +0000 (UTC)
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
	<20170607163635.17635-44-marcandre.lureau@redhat.com>
	<87h8zq1ikt.fsf@dusky.pond.sub.org>
	<156294090.32020319.1497003113601.JavaMail.zimbra@redhat.com>
	<1764775958.32020420.1497003321879.JavaMail.zimbra@redhat.com>
	<87a85hl4fa.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61455d06-0f0b-ddea-551d-f6ae65a27531@redhat.com>
Date: Fri, 9 Jun 2017 07:46:19 -0500
MIME-Version: 1.0
In-Reply-To: <87a85hl4fa.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e44FEjL19tV0pEi3jFocsR4tSCCNo0Wrh"
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e44FEjL19tV0pEi3jFocsR4tSCCNo0Wrh
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <61455d06-0f0b-ddea-551d-f6ae65a27531@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 43/43] qobject: move dump_qobject() from
 block/ to qobject/
References: <20170607163635.17635-1-marcandre.lureau@redhat.com>
 <20170607163635.17635-44-marcandre.lureau@redhat.com>
 <87h8zq1ikt.fsf@dusky.pond.sub.org>
 <156294090.32020319.1497003113601.JavaMail.zimbra@redhat.com>
 <1764775958.32020420.1497003321879.JavaMail.zimbra@redhat.com>
 <87a85hl4fa.fsf@dusky.pond.sub.org>
In-Reply-To: <87a85hl4fa.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 07:40 AM, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> Hi
>>
>> ----- Original Message -----
>>>>
>>>> The title claims "move dump_qobject() from block/ to qobject/", but
>>>> that's not what the patch does.  It *replaces* dump_qobject() by
>>>> qobject_to_string().  The former dumps to a callback, the latter to =
a
>>>> dynamic string buffer.
>>>>
>>>> Providing dump functionality in one way doesn't preclude the other w=
ay:
>>>> given callback, one could define a callback that builds up a string
>>>> buffer, and given buffer, one could (and you actually do) pass the
>>>> buffer to a callback.  That's less efficient, though.
>>>>
>>>> Trading efficiency for ease-of-use should be okay here, but I'm cc'i=
ng
>>>> Max and Kevin to double-check.
>>>
>>> I believe convenience is more important than efficiency here. It's ea=
sy to
>>> call qobject_to_string(foo) from gdb for example, with a callback, it=
's less
>>> easy.
>>>
>>> (fprintf or monitor_fprintf will both build an internal buffer anyway=
,
>>> efficiency is probably similar)
>=20
> monitor_vprintf() formats to a dynamic buffer, which it passes to
> monitor_puts().  monitor_puts() uses a line buffer.
>=20
> fprintf() can be unbuffered, line-buffered, or fully buffered.
>=20
> Converting everything to a string first is different: the string buffer=

> holds *everything* rather than just a line or some fixed size.

My patch series to create a QAPI-to-JSON output visitor, and convert the
existing qobject-to-json conversion to be a thin wrapper over the JSON
visitor, is a natural place to create a visitor constructor that can
take a callback (where the callback either appends to a QString or uses
pwrite() (no need to spend time with the slower printf()) to go straight
to stdout.  I'll have to revive that series on top of your work.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--e44FEjL19tV0pEi3jFocsR4tSCCNo0Wrh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOpibAAoJEKeha0olJ0Nq5GMH/1/H/T8AChiDgee+wJzepaDy
BYYzCI4Qpd6VisrpekCZQX/ejK5UX3zb5RKMqkYte1Omc1pzb7fy4dpmqQSh6b+k
9F1XpNAzqhESBK2H9WZLbFdObIT7PKSOYypxA4/HEL/6dSznrZCip6xWqAi6Ez1G
BrVEIG87paFW/L6H9r6Z3MX6p3hRVQMxW5gbXm+zvaCCej44s9pE4htIxJKue9B+
heU1XzzjghD6SyFut3qBWeMdo5BOA9UQ/jxIWB8tx/I6acUFE57Er54pang6/lw3
JWtrhGlBJSkKS3oqNvqn6aj+YnB8vyk1hN0m2wMhXUQrAvSOBd7WKiDfDq2ffVg=
=sr0L
-----END PGP SIGNATURE-----

--e44FEjL19tV0pEi3jFocsR4tSCCNo0Wrh--
