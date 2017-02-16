Received: from eggs.gnu.org ([2001:4830:134:3::10]:58546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceRrS-0007aw-At
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceRrP-0000Cp-6j
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:37:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceRrO-0000CN-U7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:36:59 -0500
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
Date: Thu, 16 Feb 2017 13:36:55 -0600
MIME-Version: 1.0
In-Reply-To: <1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8lDTwi3WlV0P11LAKD8XxmQ9iQK6PVnai"
Subject: Re: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8lDTwi3WlV0P11LAKD8XxmQ9iQK6PVnai
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <6882690d-5972-8b42-61ad-302531dc6d7e@redhat.com>
Subject: Re: [PATCH] qmp-events: fix GUEST_PANICKED description formatting
References: <1487266760-80500-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1487266760-80500-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2017 11:39 AM, Anton Nefedov wrote:
> also remove a useless NULL check in the event reporting code
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/event.json |  4 ++--
>  vl.c            | 22 ++++++++++------------
>  2 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/qapi/event.json b/qapi/event.json
> index 970ff02..e02852c 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -488,9 +488,9 @@
>  #
>  # @action: action that has been taken, currently always "pause"
>  #
> -# @info: optional information about a panic
> +# @info: #optional information about a panic (since 2.9)
>  #
> -# Since: 1.5 (@info since 2.9)
> +# Since: 1.5

This part's fine, but

> +++ b/vl.c
> @@ -1710,6 +1710,15 @@ void qemu_system_reset(bool report)
>  void qemu_system_guest_panicked(GuestPanicInformation *info)
>  {
>      qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
> +    if (info && info->type =3D=3D GUEST_PANIC_INFORMATION_KIND_HYPER_V=
) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx6=
4
> +                      " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n=
",
> +                      info->u.hyper_v.data->arg1,
> +                      info->u.hyper_v.data->arg2,
> +                      info->u.hyper_v.data->arg3,
> +                      info->u.hyper_v.data->arg4,
> +                      info->u.hyper_v.data->arg5);
> +    }

This code motion doesn't seem to match up with the pull request...

> =20
>      if (current_cpu) {
>          current_cpu->crash_occurred =3D true;
> @@ -1723,18 +1732,7 @@ void qemu_system_guest_panicked(GuestPanicInform=
ation *info)
>          qemu_system_shutdown_request();
>      }
> =20
> -    if (info) {
> -        if (info->type =3D=3D GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"P=
RIx64
> -                          " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64=
")\n",
> -                          info->u.hyper_v.data->arg1,
> -                          info->u.hyper_v.data->arg2,
> -                          info->u.hyper_v.data->arg3,
> -                          info->u.hyper_v.data->arg4,
> -                          info->u.hyper_v.data->arg5);
> -        }
> -        qapi_free_GuestPanicInformation(info);
> -    }

The pull request for 21/23 just had:

+
+    if (info) {
+        qapi_free_GuestPanicInformation(info);
+    }
 }

where did the qemu_log_mask() stuff come from?  Oh, I see now - it was
in 22/23.

On that grounds, you already need the 'if (info)' for more than just the
free, so this code motion is no longer quite as important.  But now I'm
noticing that it looks weird because you are freeing an input parameter.
 Generally, transfer semantics like that are screwy - it's probably
better if the caller of qemu_system_guest_panicked() is the one freeing
info, rather than requiring that the caller pass in malloc'd memory that
gets freed as a side effect and must not be referenced afterwards in the
caller.  In other words, I think the code motion is unnecessary, but
that the qapi_free_GuestPanicInformation() call is probably in the wrong
function to begin with.

Sorry for not noticing sooner (it shows that I didn't read the full pull
request, but just the one patch that caught my eye because of the .json
edit).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8lDTwi3WlV0P11LAKD8XxmQ9iQK6PVnai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpf9XAAoJEKeha0olJ0NqgJMIAKiL2MAXhxgl4pYa6SzaWShP
1+eQw20qLag8lmvANkjyvdF93fzRRzSgNO9Pwuq7AWGT2Z+c8TkTWfj5sX5Dzs1w
FjQXitxiQf4CRZCiE3EzocfliPdWZB/56GlVOgRUAH0bwFYfPYvLJwLPA+pKumcZ
rdZlnxHly0xHwPrk7Xz/VRVJOPQB17pKBH3G5mIKg7Q2orRQSEjwkGykElZaPqin
Fhmc52y+4OPH9vw6R3HRfUJNhT207pGBUOWPkY9XtGv1zXD2VxpE+NnFx5pESBKw
DvbxbwYk+1LIdaL2CnY/B+driI/lNlnoGIMmcPLG3ue7Q+4VHP2x0B7E8IcQ45M=
=oe1e
-----END PGP SIGNATURE-----

--8lDTwi3WlV0P11LAKD8XxmQ9iQK6PVnai--
