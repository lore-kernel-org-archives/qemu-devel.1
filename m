Received: from eggs.gnu.org ([2001:4830:134:3::10]:34138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7n60-0003E3-W8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7n5x-0006Nh-0g
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:09:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7n5w-0006M9-Kr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:09:16 -0400
References: <1493966082-9352-1-git-send-email-armbru@redhat.com>
	<20170508164230.GD22428@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
Date: Mon, 8 May 2017 13:09:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170508164230.GD22428@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PNejAL5Gn0BgX28A1WBSEmJ0qxV1xQTPu"
Subject: Re: [Qemu-devel] [PULL v2 00/28] QAPI patches for 2017-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNejAL5Gn0BgX28A1WBSEmJ0qxV1xQTPu
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Message-ID: <79237b29-3f53-64c7-413a-4451562292ff@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 00/28] QAPI patches for 2017-05-04
References: <1493966082-9352-1-git-send-email-armbru@redhat.com>
 <20170508164230.GD22428@stefanha-x1.localdomain>
In-Reply-To: <20170508164230.GD22428@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 11:42 AM, Stefan Hajnoczi wrote:
> On Fri, May 05, 2017 at 08:34:42AM +0200, Markus Armbruster wrote:
>> [v2]: Fix trailing space, note tweaks to PATCH 12 properly in the
>>
>> commit message=20
>> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01f=
d4d60:
>>
>>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into s=
taging (2017-05-02 15:16:29 +0100)
>>
>> are available in the git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-04-v2
>=20
> make check fails when I apply this series:
>=20
>   GTESTER tests/test-char
>   GTester: last random seed: R02S47a681e3e741223084711f7aacacb19a
>   GTester: last random seed: R02S739de30ffeb0f93caedc22b2863f60a7

I tried bisecting, and I hit compilation failures during:

    sockets: Rename SocketAddress to SocketAddressLegacy

chardev/char-socket.c: In function =E2=80=98qmp_chardev_open_socket=E2=80=
=99:
chardev/char-socket.c:948:13: error: implicit declaration of function
=E2=80=98qapi_free_SocketAddress=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
             qapi_free_SocketAddress(s->addr);
             ^~~~~~~~~~~~~~~~~~~~~~~


and
    sockets: Rename SocketAddressFlat to SocketAddress

chardev/char-socket.c: In function =E2=80=98qmp_chardev_open_socket=E2=80=
=99:
chardev/char-socket.c:948:37: error: passing argument 1 of
=E2=80=98qapi_free_SocketAddress=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
             qapi_free_SocketAddress(s->addr);
                                     ^

which places the failure(s) anywhere in this range:

pick 70ae657 qapi: New QAPI_CLONE_MEMBERS()
pick f031ce2 sockets: Rename SocketAddress to SocketAddressLegacy
pick b1eb5e0 sockets: Rename SocketAddressFlat to SocketAddress
pick a842861 sockets: Limit SocketAddressLegacy to external interfaces

I don't see the failures when testing armbru/qapi-next in isolation.

Probably just means you have to rebase your series on top of
Marc-Andr=C3=A9's series which got merged first, although such a rebase i=
s
not necessarily trivial :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PNejAL5Gn0BgX28A1WBSEmJ0qxV1xQTPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZELRHAAoJEKeha0olJ0NqRWIH/0xLmTjiO7S4whkMUcysXDDI
cNcTDbuXmDvuJjI4+VQoCU+m414jh6ErVF2AtHhTQeojmMkm/dQ6ju3HtmIVA/9z
TZut1R1acZNfBpV/QPGjIJHIP9QKAZOKqhYpLraC9FEPJWniyDV0QCqq0ZJKDbAr
GXoAkO/HK2OEShD/QBeSpQC6D+KJ4SQkl4QNWHPBl4aRL51cYpANiw2ZNQZjyE+U
rALeUWqqqtiyZF+3thgVXLy4jluJ6nrLypo9ERVNv8kw7Y2Ap/I+rWdM4QoE9mmI
Fh74EjBlLSiucyWpOx2Br5zLicsQl6ND2IIWg2OAFJX3V1/RsLMZdFM2fwIpmFM=
=NHXY
-----END PGP SIGNATURE-----

--PNejAL5Gn0BgX28A1WBSEmJ0qxV1xQTPu--
