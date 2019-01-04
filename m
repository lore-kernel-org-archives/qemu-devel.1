Received: from eggsout.gnu.org ([209.51.188.92]:53386 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfXuV-000406-Lv
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfXuU-0003tg-MG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:25:48 -0500
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
	<20180731173033.75467-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac7e2dbf-0399-3b99-5cd5-42597b3027c1@redhat.com>
Date: Fri, 4 Jan 2019 16:25:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180731173033.75467-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ffUpF1NSdLBIHyehungaQmcW1AXAnqmWy"
Subject: Re: [Qemu-devel] [PATCH v4 08/10] block/nbd: add cmdline and qapi
 parameter reconnect-delay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ffUpF1NSdLBIHyehungaQmcW1AXAnqmWy
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <ac7e2dbf-0399-3b99-5cd5-42597b3027c1@redhat.com>
Subject: Re: [PATCH v4 08/10] block/nbd: add cmdline and qapi parameter
 reconnect-delay
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
 <20180731173033.75467-9-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/31/18 12:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Reconnect will be implemented in the following commit, so for now,
> in semantics below, disconnect itself is a "serious error".
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json | 12 +++++++++++-
>  block/nbd-client.h   |  1 +
>  block/nbd-client.c   |  1 +
>  block/nbd.c          | 16 +++++++++++++++-
>  4 files changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5b9084a394..cf03402ec5 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3511,13 +3511,23 @@
>  #                  traditional "base:allocation" block status (see
>  #                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (sin=
ce 3.0)
>  #
> +# @reconnect-delay: Reconnect delay. On disconnect, nbd client tries t=
o connect

Maybe 'On unexpected disconnect', since intentional disconnect is not
unexpected.

> +#                   again, until success or serious error. During firs=
t
> +#                   @reconnect-delay seconds of reconnecting loop all =
requests
> +#                   are paused and have a chance to rerun, if successf=
ul
> +#                   connect occures during this time. After @reconnect=
-delay

occurs

> +#                   seconds all delayed requests are failed and all fo=
llowing
> +#                   requests will be failed to (until successfull reco=
nnect).

successful

> +#                   Default 300 seconds (Since 3.1)

My delay in reviewing means this now has to be 4.0.

I'm guessing that a delay of 0 means disable auto-reconnect.  From a
backwards-compatibility standpoint, no auto-reconnect is more in line
with what we previously had - but from a usability standpoint, trying to
reconnect can avoid turning transient network hiccups into permanent
loss of a device to EIO errors, especially if the retry timeout is long
enough to allow an administrator to reroute the network to an
alternative server.  So I'm probably okay with the default being
non-zero - but it DOES mean that where you used to get instant EIO
failures when a network connection was severed, you now have to wait for
the reconnect delay to expire, and 5 minutes can be a long wait.  Since
the long delay is guest-observable, can we run into issues where a guest
that is currently used to instant EIO and total loss of the device could
instead get confused by not getting any response for up to 5 minutes,
whether or not that response eventually turns out to be EIO or a
successful recovery?

> +++ b/block/nbd.c
> @@ -360,6 +360,18 @@ static QemuOptsList nbd_runtime_opts =3D {
>              .help =3D "experimental: expose named dirty bitmap in plac=
e of "
>                      "block status",
>          },
> +        {
> +            .name =3D "reconnect-delay",
> +            .type =3D QEMU_OPT_NUMBER,
> +            .help =3D "Reconnect delay. On disconnect, nbd client trie=
s to"
> +                    "connect again, until success or serious error. Du=
ring"
> +                    "first @reconnect-delay seconds of reconnecting lo=
op all"
> +                    "requests are paused and have a chance to rerun, i=
f"
> +                    "successful connect occures during this time. Afte=
r"
> +                    "@reconnect-delay seconds all delayed requests are=
 failed"
> +                    "and all following requests will be failed to (unt=
il"
> +                    "successfull reconnect). Default 300 seconds",

Same typos as in qapi.

The UI aspects look fine, now I need to review the patch series for code
issues :)


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ffUpF1NSdLBIHyehungaQmcW1AXAnqmWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwv3WEACgkQ3g5py3or
ov2vKwf+M3M0qVVdJSu4kQ4WJEU+m+2WmbfKOX6Gpjt0A0OEaXoRwu1Idyjc7cna
mOkI/OVaVjpXfGGeS/YT9g7BcVY4PRgiw8gr4fhaWtO1zITQnhC2imQQaQv/Fu/D
b7cM9cm+VH+4M4SRSzq78VImnM3Pq1XPgW9SjogkgGEfGxsdIQxTg9DmuYD7FhYC
+KJuDpFCt4DI6oEfaKZVvnWBKgPZkHrI50QwhjZ+IadJCede6bK9DPajPEMXlpjl
H5A22s6yx4O4QOFX73J1qqod///lTJsVNExY6eqMia9IBXPbXCeNGiwBJIMPXuxZ
9EQXx2DLrDUSjJ4XOB5neueNtn+Ryg==
=ed7f
-----END PGP SIGNATURE-----

--ffUpF1NSdLBIHyehungaQmcW1AXAnqmWy--
