Received: from eggs.gnu.org ([2001:4830:134:3::10]:51807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coQ6p-0006xW-8q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coQ6m-0004lB-4d
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:46:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coQ6l-0004je-P9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BB3388E60
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 07:46:03 +0000 (UTC)
Date: Thu, 16 Mar 2017 15:45:56 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316074556.GF17296@stefanha-x1.localdomain>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-30-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <20170313195547.21466-30-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 29/30] trace: Fix parameter types in
 hw/virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 02:55:46PM -0500, Eric Blake wrote:
> An upcoming patch will let the compiler warn us when we are silently
> losing precision in traces; update the trace definitions to pass
> through the full value at the callsite.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/virtio/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 6926eed..7b3743d 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -4,7 +4,7 @@
>  virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned in=
t idx) "vq %p elem %p len %u idx %u"
>  virtqueue_flush(void *vq, unsigned int count) "vq %p count %u"
>  virtqueue_pop(void *vq, void *elem, unsigned int in_num, unsigned int ou=
t_num) "vq %p elem %p in_num %u out_num %u"
> -virtio_queue_notify(void *vdev, int n, void *vq) "vdev %p n %d vq %p"
> +virtio_queue_notify(void *vdev, ptrdiff_t n, void *vq) "vdev %p n %td vq=
 %p"

I'm not sure about this change.  Logically the virtqueue number, n, is
not a ptrdiff_t.  The type for n is always int in
include/hw/virtio/virtio.h and it should be the same for the trace
event.

It just happens to be that the caller calculates it using pointer
subtraction.  The trace event shouldn't reflect this.  One day the
caller might change the calculation and it would then be necessary to
change the type of the trace event.

Stefan

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYykK0AAoJEJykq7OBq3PI+BYIAMYya48PrMgOJvbxl6kgRMFW
P/4Uv13M66y4J3T39UyiI2sv2rUuTOhRX5uEGTL+6dd4Ac1mjXyAAb2jbgtWO5YM
EvYn6XqEmBb9BwMbc5N3yA/CpSa/YqPhB0w0Rq6+FJLKDeWPaXny5u0UQu7KMeQH
7+1MTmSYkgj3r7UphECso91V7opaWjLpj2wTIbmfcdNfmM9nHLSglRlTfThF/jdA
uYS7UGsh0AiPqfk5+r3RBxduqQI0BxFl7k05niAf1PJCVrrUj5YkcmovD6gFaqZI
uwnUt4A/Jj4uba+9FxppRuzQ9dRfgCT49ewwc6cXpl1zfjHEjenyuO7WdsBar2o=
=CmCc
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
