Received: from eggs.gnu.org ([2001:4830:134:3::10]:55869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlLyM-0005Iu-72
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlLyL-0006X6-3d
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:16:58 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e0d3570-11c3-ac91-6a06-7f6f1e0a093d@redhat.com>
Date: Fri, 25 Aug 2017 16:16:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RwFoqOGCFNeNBnH7H4LKOfklADor1BQ6V"
Subject: Re: [Qemu-devel] [PATCH 03/17] nbd/client: refactor
 nbd_receive_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RwFoqOGCFNeNBnH7H4LKOfklADor1BQ6V
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <5e0d3570-11c3-ac91-6a06-7f6f1e0a093d@redhat.com>
Subject: Re: [PATCH 03/17] nbd/client: refactor nbd_receive_reply
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Refactor nbd_receive_reply to return 1 on success, 0 on eof, when no
> data was read and <0 for other cases, because returned size of read
> data is not actually used.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h |  2 +-
>  nbd/client.c        | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20

> +++ b/nbd/client.c
> @@ -914,11 +914,16 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequ=
est *request)
>      return nbd_write(ioc, buf, sizeof(buf), NULL);
>  }
> =20
> -ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **er=
rp)
> +/* nbd_receive_reply
> + * Returns 1 on success
> + *         0 on eof, when no data was read from @ioc (errp is not set)=

> + *         < 0 on fail

Similar to the previous patch, I'd like to squash in:

diff --git i/nbd/client.c w/nbd/client.c
index a1758a1931..f8c213bc96 100644
--- i/nbd/client.c
+++ w/nbd/client.c
@@ -916,8 +916,8 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest
*request)

 /* nbd_receive_reply
  * Returns 1 on success
- *         0 on eof, when no data was read from @ioc (errp is not set)
- *         < 0 on fail
+ *         0 on eof, when no data was read (errp is not set)
+ *         negative errno on failure (errp is set)
  */
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {

With that,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RwFoqOGCFNeNBnH7H4LKOfklADor1BQ6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgk7kACgkQp6FrSiUn
Q2r6Ewf/do6X6WEhoaC9QUWkpFS4UolBWKymCPK2PlWLVqXkPRt9YhMFFoekg8JG
PqHVNe8rw26MkYO8NbVXSAsxuQ5UIT0vXb1GSpifLMX5YaMaUrEHuT313UDKE5W5
VLJsEK8peZnO4h1tizOIW8fDy4HcZw1XoAIWPI4nJkbJgjZ3yoF50x8O5Tl0O+iN
EHueEeF8oLR/BEDNubmQGVERZ7+RLXGhlLLz8x0OGs7YwtCeUtXPns5Hhw6WwGky
+TU5OAb3dayoHV8SmcPNJCWvcIBcf3lOvW0xu4NCoucQKHdBTevfdVDBwF7WC5W/
5srfAYFL0+Vws2L9xehSVAecrQeZ9A==
=gveP
-----END PGP SIGNATURE-----

--RwFoqOGCFNeNBnH7H4LKOfklADor1BQ6V--
