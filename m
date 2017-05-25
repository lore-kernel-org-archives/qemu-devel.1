Received: from eggs.gnu.org ([2001:4830:134:3::10]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDu0v-0006Bk-Ro
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDu0s-0004Vq-On
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDu0s-0004VY-Et
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1013413A68
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 14:45:17 +0000 (UTC)
References: <20170525101900.15950-1-berrange@redhat.com>
	<3d090dbd-eb49-5e4e-6b7e-b52a3fdc1716@redhat.com>
	<20170525144044.GF18049@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <218f633d-6b96-460a-256a-b55db315e07a@redhat.com>
Date: Thu, 25 May 2017 09:45:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170525144044.GF18049@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XfppqGJH8aWNFS8c7lfjTCtWwTm2hSElm"
Subject: Re: [Qemu-devel] [PATCH v3] sockets: improve error reporting if
 UNIX socket path is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XfppqGJH8aWNFS8c7lfjTCtWwTm2hSElm
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <218f633d-6b96-460a-256a-b55db315e07a@redhat.com>
Subject: Re: [PATCH v3] sockets: improve error reporting if UNIX socket path
 is too long
References: <20170525101900.15950-1-berrange@redhat.com>
 <3d090dbd-eb49-5e4e-6b7e-b52a3fdc1716@redhat.com>
 <20170525144044.GF18049@redhat.com>
In-Reply-To: <20170525144044.GF18049@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 09:40 AM, Daniel P. Berrange wrote:
> On Thu, May 25, 2017 at 09:28:31AM -0500, Eric Blake wrote:
>> On 05/25/2017 05:19 AM, Daniel P. Berrange wrote:
>>> The 'struct sockaddr_un' only allows 108 bytes for the socket
>>> path.
>>>
>>> If the user supplies a path, QEMU uses snprintf() to silently
>>> truncate it when too long. This is undesirable because the user
>>> will then be unable to connect to the path they asked for.
>>>
>>> If the user doesn't supply a path, QEMU builds one based on
>>> TMPDIR, but if that leads to an overlong path, it mistakenly
>>> uses error_setg_errno() with a stale errno value, because
>>> snprintf() does not set errno on truncation.
>>>
>>> In solving this the code needed some refactoring to ensure we
>>> don't pass 'un.sun_path' directly to any APIs which expect
>>> NUL-terminated strings, because the path is not required to
>>> be terminated.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

>>> =20
>>> -    if (unlink(un.sun_path) < 0 && errno !=3D ENOENT) {
>>> +    if (strlen(path) > sizeof(un.sun_path)) {
>>> +        error_setg(errp, "UNIX socket path '%s' is too long", path);=

>>> +        error_append_hint(errp, "Path must be less than %zu bytes\n"=
,
>>> +                          sizeof(un.sun_path));
>>
>> The old message mentioned the name that was too long, the new does not=
=2E
>> That's a potential slight loss in error message quality, particularly
>> since you are no longer mentioning a UNIX socket (which may give the
>> user a clue why 108 is special), but I can probably live with it (it's=

>> still pretty obvious from the message that you should investigate what=

>> is too long).
>=20
> I'm not sure why you are saying I don't mention the path or that it
> is a UNIX socket - I do exactly that right there.

Oh shoot, I was misreading things.  I saw two lines of error_*, and must
have thought that the first was the deletion and the second an
insertion. But you're right that they are both insertions, that the
first is an accurate message, and the second is a hint.

Never mind, I'm obviously not fully awake yet today ;)


>>> @@ -932,9 +942,16 @@ static int unix_connect_saddr(UnixSocketAddress =
*saddr,
>>>          qemu_set_nonblock(sock);
>>>      }
>>> =20
>>> +    if (strlen(saddr->path) > sizeof(un.sun_path)) {
>>> +        error_setg(errp, "UNIX socket path '%s' is too long", saddr-=
>path);
>>> +        error_append_hint(errp, "Path must be less than %zu bytes\n"=
,
>>> +                          sizeof(un.sun_path));
>>
>> Again, potential loss in error message quality.
>=20
> I don't think so.

Yep, another instance of me reading the patch wrong.  This part's fine,
after all.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XfppqGJH8aWNFS8c7lfjTCtWwTm2hSElm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJu35AAoJEKeha0olJ0NqFagH/3dxbIoE8EL7+Ir8LZTc/7Zk
uueE3ekIG/zVCgtqAcFZxtU0sD7utTpA92dGbSHVb5723e1PuVNH7Kd5iuml+lG3
ff0pMgEsFiAeRxvJBF+38Xq+DPLy1SEQfLgndQ45I7TNuw0sAHPD7h6vzhU3yVUr
n77jtHkRkuwgq0M6OUuz9nYUdBNI+sMfrqr2Wyi6O6bHV6htwL5EzretcAldzpxf
D5k+Cpzu78JZLUvmRrQvgVzCAHyyjh2GlF6IRPIS2CX02V6Hdaw5dj2CC1+F7Rl0
gb1P11JqE3z7L7nsvZ4rdQiaCr6PZ6GF0zHKN60tG4CCZyYIcUKZLZgl7mGEozQ=
=aNPT
-----END PGP SIGNATURE-----

--XfppqGJH8aWNFS8c7lfjTCtWwTm2hSElm--
