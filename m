Received: from eggs.gnu.org ([2001:4830:134:3::10]:44891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOogg-0002el-9H
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOogd-0001zQ-7E
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:45:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cOogc-0001yW-Ur
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 11:45:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C1FE21730
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 16:45:14 +0000 (UTC)
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-2-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <318eee50-fc8b-281d-6b98-50aa6dfa5259@redhat.com>
Date: Wed, 4 Jan 2017 10:45:11 -0600
MIME-Version: 1.0
In-Reply-To: <20161223182641.2718-2-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wxKonLASG1KP9apvktMLCxA8waHjcKIN3"
Subject: Re: [Qemu-devel] [PATCH 1/3] io: add methods to set I/O handlers on
 AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wxKonLASG1KP9apvktMLCxA8waHjcKIN3
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <318eee50-fc8b-281d-6b98-50aa6dfa5259@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] io: add methods to set I/O handlers on
 AioContext
References: <20161223182641.2718-1-pbonzini@redhat.com>
 <20161223182641.2718-2-pbonzini@redhat.com>
In-Reply-To: <20161223182641.2718-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/23/2016 12:26 PM, Paolo Bonzini wrote:
> This is in preparation for making qio_channel_yield work on
> AioContexts other than the main one.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/io/channel.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  io/channel-socket.c  | 16 +++++++++++-----
>  io/channel-tls.c     | 12 ++++++++++++
>  io/channel-watch.c   |  6 ++++++
>  io/channel.c         | 25 +++++++++++++++++++++++++
>  5 files changed, 96 insertions(+), 5 deletions(-)
>=20

> +++ b/io/channel-socket.c
> @@ -661,11 +661,6 @@ qio_channel_socket_set_blocking(QIOChannel *ioc,
>          qemu_set_block(sioc->fd);
>      } else {
>          qemu_set_nonblock(sioc->fd);
> -#ifdef WIN32
> -        WSAEventSelect(sioc->fd, ioc->event,
> -                       FD_READ | FD_ACCEPT | FD_CLOSE |
> -                       FD_CONNECT | FD_WRITE | FD_OOB);
> -#endif
>      }
>      return 0;

How does this hunk fit in?

> +++ b/io/channel-watch.c
> @@ -285,6 +285,12 @@ GSource *qio_channel_create_socket_watch(QIOChanne=
l *ioc,
>      GSource *source;
>      QIOChannelSocketSource *ssource;
> =20
> +#ifdef WIN32
> +    WSAEventSelect(socket, ioc->event,
> +                   FD_READ | FD_ACCEPT | FD_CLOSE |
> +                   FD_CONNECT | FD_WRITE | FD_OOB);
> +#endif
> +

Is it that you're moving it, now that the ability to associate handlers
lets you have more fine-grained control on when to adjust the properties?=


Otherwise the patch makes sense to me.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wxKonLASG1KP9apvktMLCxA8waHjcKIN3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbSaXAAoJEKeha0olJ0NqvQMIAJILCW7NurDEoxAZCF1QW9Qa
isp545UVQGIA+p9+BcZ3iyxqGZUvg9me6AE+T1Qnqi2f2fyh1y3+lkGWOBz4Q5/N
fqZrUGd1rehwpDwLMIZJ7ulAkK+XJrKp7z2Us+z4VOdnkD2iaQuepVmtTDuGz/EW
zPNhi5IN/PQE0ntNLvQxGCUhlGCZVz+FXbSvaqVZKbSfKhOdmJYc0y7sd3juwzaN
WWemWBff1HnJE1o7peZeppLVhPROnpRO3Cu+So3VwVx6hO/9bCb7UBY09vo8h6aL
VK+kEpqjAyr5gMRPAIxuBXcJEbcMNDKEZgwZhrDBnQ9eAPXud8O1CZL05ge775U=
=Mz5D
-----END PGP SIGNATURE-----

--wxKonLASG1KP9apvktMLCxA8waHjcKIN3--
