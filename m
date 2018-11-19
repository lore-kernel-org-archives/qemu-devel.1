Received: from eggs.gnu.org ([2001:4830:134:3::10]:54412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgyP-0004LQ-VH
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgyP-0006fZ-02
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:40:09 -0500
Date: Mon, 19 Nov 2018 10:39:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119103959.GJ19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <353b130c-aefb-ec4c-411b-571a79ec76e2@redhat.com>
	<20181117223221.2198751-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181117223221.2198751-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1.5/6] nbd/server: Ignore write errors when
 replying to NBD_OPT_ABORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On Sat, Nov 17, 2018 at 04:32:21PM -0600, Eric Blake wrote:
> Commit 37ec36f6 intentionally ignores errors when trying to reply
> to an NBD_OPT_ABORT request for plaintext clients, but did not make
> the same change for a TLS server.  Since NBD_OPT_ABORT is
> documented as being a potential for an EPIPE when the client hangs
> up without waiting for our reply, we don't need to pollute the
> server's output with that failure.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/server.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 056cfa5ad47..dc04513de70 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1134,12 +1134,16 @@ static int nbd_negotiate_options(NBDClient *cli=
ent, uint16_t myflags,
>                  return -EINVAL;
>=20
>              default:
> -                ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD, err=
p,
> +                /* Let the client keep trying, unless they asked to
> +                 * quit. Always try to give an error back to the
> +                 * client; but when replying to OPT_ABORT, be aware
> +                 * that the client may hang up before receiving the
> +                 * error, in which case we are fine ignoring the
> +                 * resulting EPIPE. */
> +                ret =3D nbd_opt_drop(client, NBD_REP_ERR_TLS_REQD,
> +                                   option =3D=3D NBD_OPT_ABORT ? NULL =
: errp,
>                                     "Option 0x%" PRIx32
>                                     " not permitted before TLS", option=
);
> -                /* Let the client keep trying, unless they asked to
> -                 * quit. In this mode, we've already sent an error, so
> -                 * we can't ack the abort.  */
>                  if (option =3D=3D NBD_OPT_ABORT) {
>                      return 1;
>                  }

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
