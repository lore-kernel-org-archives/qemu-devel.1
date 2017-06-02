Received: from eggs.gnu.org ([2001:4830:134:3::10]:60115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGi3Z-0002KS-T2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGi3W-0005pj-O8
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGi3W-0005pO-Hm
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C6487F3E1
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 08:35:37 +0000 (UTC)
Date: Fri, 2 Jun 2017 09:35:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170602083532.GA2081@work-vm>
References: <20170602081519.15648-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170602081519.15648-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user-bridge: fix iov_restore_front()
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
>   CC      tests/vhost-user-bridge.o
> /home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warnin=
g: variables 'front' and 'iov' used in loop condition not modified in loo=
p body [-Wfor-loop-analysis]
>     for (cur =3D front; front !=3D iov; cur++) {
>                       ^~~~~    ~~~
> 1 warning generated.
>=20
> Fix the loop, document the function, and fix some related assert().
>=20
> In practice, the loop bug was harmless because the front sg buffer is
> enough to discard/restore the header size.
>=20
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/vhost-user-bridge.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 8618c20d53..1e5b5ca3da 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -220,12 +220,18 @@ vubr_handle_tx(VuDev *dev, int qidx)
>      free(elem);
>  }
> =20
> +
> +/* this function reverse the effect of iov_discard_front() it must be
> + * called with 'front' being the original struct iovec and 'bytes'
> + * being the number of bytes you shaved off
> + */
>  static void
>  iov_restore_front(struct iovec *front, struct iovec *iov, size_t bytes=
)
>  {
>      struct iovec *cur;
> =20
> -    for (cur =3D front; front !=3D iov; cur++) {
> +    for (cur =3D front; cur !=3D iov; cur++) {
> +        assert(bytes >=3D cur->iov_len);
>          bytes -=3D cur->iov_len;
>      }
> =20
> @@ -302,7 +308,8 @@ vubr_backend_recv_cb(int sock, void *ctx)
>              }
>              iov_from_buf(sg, elem->in_num, 0, &hdr, sizeof hdr);
>              total +=3D hdrlen;
> -            assert(iov_discard_front(&sg, &num, hdrlen) =3D=3D hdrlen)=
;
> +            ret =3D iov_discard_front(&sg, &num, hdrlen);
> +            assert(ret =3D=3D hdrlen);
>          }
> =20
>          struct msghdr msg =3D {
> --=20
> 2.13.0.91.g00982b8dd
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
