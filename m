Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnTn-0005WE-Eu
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFnTj-0007Sy-9C
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFnTj-0007Sm-0M
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:10:55 -0400
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <874e184b-3727-3bbc-0169-1073db203736@redhat.com>
Date: Tue, 30 May 2017 15:10:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170530143052.165002-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NACfu5TSLSdmkQ1CVDuI0DAl4WSB4sdpd"
Subject: Re: [Qemu-devel] [PATCH 01/19] nbd/server: get rid of
 nbd_negotiate_read and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NACfu5TSLSdmkQ1CVDuI0DAl4WSB4sdpd
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <874e184b-3727-3bbc-0169-1073db203736@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/19] nbd/server: get rid of
 nbd_negotiate_read and friends
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
 <20170530143052.165002-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> Functions nbd_negotiate_{read,write,drop_sync} were introduced in
> 1a6245a5b, when nbd_wr_syncv was working through qemu_co_sendv_recvv,

There is no qemu_co_sendv_recvv. Did you mean qemu_co_recv/qemu_co_send?

> which just yields, without setting any handlers. But now, nbd_wr_syncv
> works through qio_channel_yield() which sets handlers, so watchers
> are redundant in nbd_negotiate_{read,write,drop_sync}, then, let's just=

> use {read,write,drop}_sync functions.

Makes sense to me.  Note that I have a pending patch that was also
related to 1a6245a5, where we introduced an assertion failure (which
later morphed into a segfault) if a client hangs up really early during
negotiation:

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg06240.html

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/nbd/common.c
> @@ -69,6 +69,32 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
>      return done;
>  }
> =20
> +/* Discard length bytes from channel.  Return -errno on failure and 0 =
on
> + * success*/

Space before */, if you don't mind (yes, I know this was just code
motion, and that the old spot was wrong).

> +int drop_sync(QIOChannel *ioc, size_t size, Error **errp)

As part of moving it into nbd/common.c, please rename this function to
an nbd_ prefix, since non-static functions are more likely to collide
with the rest of the code base if not properly named.  Better yet: do it
in multiple patches:
- rename the static functions and fallout to callers (all of
nbd_drop_sync, nbd_read_sync, and nbd_write_sync)
- code motion (promote nbd_drop_sync from static in client.c to exported
in common.c)
- drop nbd_negotiate_ functions in favor of common nbd_*_sync functions

The idea makes sense, but I think there's too much going on in this one
commit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NACfu5TSLSdmkQ1CVDuI0DAl4WSB4sdpd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLdHLAAoJEKeha0olJ0Nq3IsH/0A5qleWykmyriMjjdNzjKEg
7oOjCqMRUijkK3lDRIHZBI48dHVbRSany/ROeeqwG6RtUI0ntdu8bKnMF10apl/s
AhhiLmmyfgWja9Yvmni5lZBQmU6e37OAmKBx4unHulWeWG1Mj/iFVOV/XhukJtR2
s6LXBLp/LvZGsa8RrQeOcLqT4ci4/ThMX/t+c+ZY4fFrxLx9AlR9NzvHAD/vzp++
s92jlf0R1ZeCWW5dfy3sVxvmTMWQAq5qt4ZpbFODcW8tBnyxpM2ugZfmhSHFTgO8
nb6gNMBwDHO+ozh6Ey+szHxE5eAnZM14o80r3OYQzTd5cOFY8u4nkfJNV+4voYY=
=ZQLX
-----END PGP SIGNATURE-----

--NACfu5TSLSdmkQ1CVDuI0DAl4WSB4sdpd--
