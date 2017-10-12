Received: from eggs.gnu.org ([2001:4830:134:3::10]:59855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lZp-0007zx-C8
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lZo-00010D-5e
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:03:37 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e71300e-5205-7aef-d3f1-67f31a109a84@redhat.com>
Date: Thu, 12 Oct 2017 17:03:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IbptshxBxgjv9FiUl62Sf1SJp5tnNO7r7"
Subject: Re: [Qemu-devel] [PATCH v3 05/13] nbd/server: do not use NBDReply
 structure
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
--IbptshxBxgjv9FiUl62Sf1SJp5tnNO7r7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <8e71300e-5205-7aef-d3f1-67f31a109a84@redhat.com>
Subject: Re: [PATCH v3 05/13] nbd/server: do not use NBDReply structure
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBDReply structure will be upgraded in future patches to handle both
> simple and structured replies and will be used only in the client
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 43ade30ba3..3878145f63 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1196,7 +1196,9 @@ static inline void set_be_simple_reply(NBDSimpleR=
eply *reply, uint64_t error,
>      stq_be_p(&reply->handle, handle);
>  }
> =20
> -static int nbd_co_send_simple_reply(NBDRequestData *req, NBDReply *rep=
ly,
> +static int nbd_co_send_simple_reply(NBDRequestData *req,
> +                                    uint64_t handle,
> +                                    uint32_t error,

Feels a bit like a step backwards for the parameter list, but I'm not
opposed to the patch (it does make for some nice cleanup elsewhere).

>                                      int len, Error **errp)
>  {
>      NBDClient *client =3D req->client;
> @@ -1205,10 +1207,10 @@ static int nbd_co_send_simple_reply(NBDRequestD=
ata *req, NBDReply *reply,
> =20
>      g_assert(qemu_in_coroutine());
> =20
> -    trace_nbd_co_send_simple_reply(reply->handle, reply->error, len);
> +    trace_nbd_co_send_simple_reply(handle, error, len);

I had to tweak this to rebase on top of my churn on 4/13.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IbptshxBxgjv9FiUl62Sf1SJp5tnNO7r7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf5q4ACgkQp6FrSiUn
Q2oqWgf/fx1NXbMJfHmyHU7VNyCL9Ia41dHZo7SlLKya7UCv7Yt4cGOsYUda+Eta
mFVmHWeQb0jZu57XvFrh/jJW2b+h9H0jh/nxo9YajOzTNoJ2bOhwBvPgocYiT4Bc
ChJvGECVpXyvn6n8O0m+ZmW4fPilOp/Mlf6uMH1OIZL89d/C3ZedRkhUt4YEz7pa
IN/a5BccB3EsISdMPslG/XcIZ9sJSAWTnUqmMaRKgWQm+HrsHp2m4NsrMT07oV/r
ZrX66nR90HUklMVbF0ygVkkM6f2u9Ncdc0F8j+Oor+TPk3VdOEm0D+Itt+qc0dGj
nt3qrWi9DrXPPJJSamen6MP68C76dA==
=oRoV
-----END PGP SIGNATURE-----

--IbptshxBxgjv9FiUl62Sf1SJp5tnNO7r7--
