Received: from eggs.gnu.org ([2001:4830:134:3::10]:40880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1caoax-0003Uc-7F
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1caoau-0001xd-3Z
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1caoat-0001xN-RV
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:04:56 -0500
References: <20170204100317.32425-1-rjones@redhat.com>
	<20170204100317.32425-2-rjones@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21e1f16f-59f3-479c-a8f7-42cf5ada40b4@redhat.com>
Date: Mon, 6 Feb 2017 13:04:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170204100317.32425-2-rjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BOoInfLEFqEOAwwwIEaSPai5EtkeQQdPA"
Subject: Re: [Qemu-devel] [PATCH v5] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, pbonzini@redhat.com
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com, dplotnikov@virtuozzo.com, rkagan@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BOoInfLEFqEOAwwwIEaSPai5EtkeQQdPA
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>, pbonzini@redhat.com
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 dplotnikov@virtuozzo.com, rkagan@virtuozzo.com, den@openvz.org
Message-ID: <21e1f16f-59f3-479c-a8f7-42cf5ada40b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] qemu-nbd: Implement socket activation.
References: <20170204100317.32425-1-rjones@redhat.com>
 <20170204100317.32425-2-rjones@redhat.com>
In-Reply-To: <20170204100317.32425-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/04/2017 04:03 AM, Richard W.M. Jones wrote:
> Socket activation (sometimes known as systemd socket activation)
> allows an Internet superserver to pass a pre-opened listening socket
> to the process, instead of having qemu-nbd open a socket itself.  This
> is done via the LISTEN_FDS and LISTEN_PID environment variables, and a
> standard file descriptor range.
>=20
> This change partially implements socket activation for qemu-nbd.  If
> the environment variables are set correctly, then socket activation
> will happen automatically, otherwise everything works as before.  The
> limitation is that LISTEN_FDS must be 1.
>=20
> Signed-off-by: Richard W.M. Jones.
> ---

> +
> +    /* So the file descriptors don't leak into child processes. */
> +    for (i =3D 0; i < nr_fds; ++i) {
> +        fd =3D FIRST_SOCKET_ACTIVATION_FD + i;
> +        if (fcntl(fd, F_SETFD, FD_CLOEXEC) =3D=3D -1) {

This is not the right way to do things (it risks clearing any other FD_
flags currently set on the fd, even though there aren't any such FD_
flags in common use).  You HAVE to do F_GETFD before F_SETFD
(read-modify-write) for correct usage - and the best way to do that is
to use qemu_set_cloexec() from util/oslib-posix.c.

Except that qemu_set_cloexec() doesn't pay attention to errors...

> +            /* If we cannot set FD_CLOEXEC then it probably means the =
file
> +             * descriptor is invalid, so socket activation has gone wr=
ong
> +             * and we should exit.
> +             */
> +            error_report("Socket activation failed: "
> +                         "invalid file descriptor fd =3D %d: %m",
> +                         fd);

=2E..while you use it for argument validation.  Hmm.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BOoInfLEFqEOAwwwIEaSPai5EtkeQQdPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmMjUAAoJEKeha0olJ0NqJUEH/1ymJOkvewFjBvgd7ydnsy0R
bfOab4LEo7SkbEu3hGaBh3oMWMDdqL3rESphm33AcKc16dqfNfV9Q/brRDUWSbVd
AjoqTCQ1wzsaQ9algVootDwHgfadMSKQEe8ejkEoQORuLJ6ECrO/8hbD58gX+dJg
dwQQQCFfEZj4D3kBdJ4rW7sPP1o9/Ln6T/NdfzF1q71Ci4Wj1EBrgbvVW5cPl7GW
nw3bNd0FTHKV7GZKhumCSyOW3eaP7y6PjmclMPdyq0qgcs6cVtfLPIpzzGDV6zBj
sB7J7zvNUh1xdJ15esCYNhjpOC89dAI7mqj5q7xrh6c19+4zitnVnlI62xzckeI=
=xvba
-----END PGP SIGNATURE-----

--BOoInfLEFqEOAwwwIEaSPai5EtkeQQdPA--
