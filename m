Received: from eggs.gnu.org ([2001:4830:134:3::10]:56245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRth-0007Kx-Sy
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRte-0007sQ-OS
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:41:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePRte-0007rb-FN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:41:50 -0500
Date: Thu, 14 Dec 2017 11:41:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214114136.GG14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-19-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-19-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 18/26] monitor: send event when request
 queue full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:52PM +0800, Peter Xu wrote:
> Set maximum QMP request queue length to 8.  If queue full, instead of
> queue the command, we directly return a "request-dropped" event, telling
> client that specific command is dropped.
>=20
> Note that this flow control mechanism is only valid if OOB is enabled.
> If it's not, the effective queue length will always be 1, which strictly
> follows original behavior of QMP command handling (which never drop
> messages).
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/monitor.c b/monitor.c
> index c20e659740..f7923c4590 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4029,6 +4029,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      }
>  }
> =20
> +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> +
>  static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
>                                 void *opaque)
>  {
> @@ -4061,6 +4063,19 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens,
>      req_obj->id =3D id;
>      req_obj->req =3D req;
> =20
> +    if (qmp_oob_enabled(mon)) {
> +        /* Drop the request if queue is full. */
> +        if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {

qmp_queue_lock must be held.  Perhaps it's simplest to move this check
into the qmp_queue_lock critical section below and unlock before calling
qapi_event_send_request_dropped()...

> +            qapi_event_send_request_dropped(id,
> +                                            REQUEST_DROP_REASON_QUEUE_FU=
LL,
> +                                            NULL);
> +            qobject_decref(id);
> +            qobject_decref(req);
> +            g_free(req_obj);
> +            return;
> +        }
> +    }
> +
>      /*
>       * Put the request to the end of queue so that requests will be
>       * handled in time order.  Ownership for req_obj, req, id,

=2E.. down here.

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMmNwAAoJEJykq7OBq3PI3KwIALgcGJNhDnUrjeNNifOw3HOo
yD5PYQt3vxz5U4sIkSrZqlb8ZBaqzbNycp5W/C0bbO/z0pZPnJ8BwPrs+LDFV2MG
bAPVAFmiTUY9FxRctRayFAwkDmqlCvoNv95mZ6HNl7kXTfsXz+hnc8P0DCLkYjgh
axZG8rLNED8n5COVI/dUTbE6GHre9+SHga8q8cgwyOmPvhfuBUHBHr7R7NGTLI5w
olpgwEz3VUhSVQ2DYrgbbgrnepMDrrYnI7qvH/ylQShlEqfCQfShmU01MacEn1Ja
yciUMFxIwXqXwK+An3XPAEZeIMulAox654tTE0VUw3km4etHWb5L8y1VlHUmm6k=
=z2IX
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
