Received: from eggs.gnu.org ([2001:4830:134:3::10]:55598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2oG-0004DR-Tm
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2oG-0000Jc-4a
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:33:08 -0400
Date: Wed, 31 May 2017 13:32:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123259.GK16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-11-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n83H03bbH672hrlY"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-11-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 10/29] qed: Remove callback
 from qed_write_header()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--n83H03bbH672hrlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:51PM +0200, Kevin Wolf wrote:
>  static void qed_clear_need_check(void *opaque, int ret)
>  {
>      BDRVQEDState *s =3D opaque;
> =20
>      if (ret) {
> -        qed_unplug_allocating_write_reqs(s);
> -        return;
> +        goto out;
>      }
> =20
>      s->header.features &=3D ~QED_F_NEED_CHECK;
> -    qed_write_header(s, qed_flush_after_clear_need_check, s);
> +    ret =3D qed_write_header(s);
> +    (void) ret;
> +
> +    ret =3D bdrv_flush(s->bs);
> +    (void) ret;
> +
> +out:
> +    qed_unplug_allocating_write_reqs(s);
>  }

Should we unplug allocating write reqs before flushing?  The async code
kicks off a flush but doesn't wait for it to complete.

--n83H03bbH672hrlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrf7AAoJEJykq7OBq3PIBDQH/1XGnJbvg9U5IF18Hfmu7S/1
SSN4vMn6BarcEkudU0t9Vgg1ge/GzoQZmo/BtDfsg51w4UpjBtq1v3HXGtYGMPb9
yXhj0uKLKwK6yqKj4jOzfDFJoSf6UmsRBoi2kmeNJNx1U2qErAjWiB24SjJ3pjr+
pWEFNkUT2S5hATdvY1WR8V3EQElc0nZF9ic4awPM4XevPi457W9SYCwcCI50UYvo
jsjqz8DzQjnJ5d1G4gNrU/FjW5QbVRzAZg3KdObrapb5FdFZiBAZGsJ3WHjWOhXp
zbkV32v/6qIA07CtCCkPApuifOn3vBpPOYcoMX9JKQpGr/hGHFOwY/sMi77TRoo=
=k9yT
-----END PGP SIGNATURE-----

--n83H03bbH672hrlY--
