Received: from eggs.gnu.org ([2001:4830:134:3::10]:52557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftqp-00056r-BW
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cftqm-0007y8-43
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cftql-0007xS-RO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:42:20 -0500
References: <1487614915-18710-1-git-send-email-den@openvz.org>
	<1487614915-18710-2-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad551a5d-16c0-54fc-97c2-0c28ee1219f6@redhat.com>
Date: Mon, 20 Feb 2017 13:42:17 -0600
MIME-Version: 1.0
In-Reply-To: <1487614915-18710-2-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xhmm4fkqu1o8PABkscCLNjfix6nDNQGxD"
Subject: Re: [Qemu-devel] [PATCH 1/3] i386/cpu: release
 GuestPanicInformation memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xhmm4fkqu1o8PABkscCLNjfix6nDNQGxD
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad551a5d-16c0-54fc-97c2-0c28ee1219f6@redhat.com>
Subject: Re: [PATCH 1/3] i386/cpu: release GuestPanicInformation memory
References: <1487614915-18710-1-git-send-email-den@openvz.org>
 <1487614915-18710-2-git-send-email-den@openvz.org>
In-Reply-To: <1487614915-18710-2-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 12:21 PM, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> Do not make some foreign function do it.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  kvm-all.c |  5 ++++-
>  vl.c      | 22 +++++++++-------------
>  2 files changed, 13 insertions(+), 14 deletions(-)
>=20

> +++ b/vl.c
> @@ -1682,6 +1682,15 @@ void qemu_system_reset(bool report)
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

Why are we hoisting this code earlier in the function (which changes the
log order, if I'm reading correctly)...

> =20
>      if (current_cpu) {
>          current_cpu->crash_occurred =3D true;
> @@ -1694,19 +1703,6 @@ void qemu_system_guest_panicked(GuestPanicInform=
ation *info)
>                                         !!info, info, &error_abort);
>          qemu_system_shutdown_request();
>      }
> -
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

=2E..instead of just cleaning up this code in place?

But the rest of the patch looks fine.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Xhmm4fkqu1o8PABkscCLNjfix6nDNQGxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYq0aZAAoJEKeha0olJ0NqRDsH/iDnpGKEw/etVQEaB/AnwkzF
8vPtXZGZJc5/prF8ZTH4pIW255+27aYoaEx3qj80Exn8I6pEaGK6t636ZIo0ieC7
n29wq1W6UsgndkTRD4mXtZDTvAlAkjhvnFCfz3MzcjlyoPfEpWjKKEUeyovfnRUy
wmmfXZPh4P+45Iqmr4BWgFIzatyrT3lXocV6nlYDRzizOyDRVE41X8G1FWRjPmMv
k0vvnnfuKpFBknSjtDe7OCs/8pNL23fgymHw76WlH/nwDC6J7tEQ1TOHgwD4Kjzp
Dcqr+wLgFL7piCwSrVFpJuMRNdyl+bPtt1cIZo7Nca0w5o6snkkkrhONX2dBMK4=
=fZIz
-----END PGP SIGNATURE-----

--Xhmm4fkqu1o8PABkscCLNjfix6nDNQGxD--
