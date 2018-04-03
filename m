Received: from eggs.gnu.org ([2001:4830:134:3::10]:45428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3LaU-0006Nb-PL
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3LaP-000180-RQ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:02:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3LaP-00016S-KU
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:02:53 -0400
References: <20180403050115.6037-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9d37d29-82ae-ac3e-9919-62586206c88a@redhat.com>
Date: Tue, 3 Apr 2018 08:02:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180403050115.6037-1-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5ll1PVVbF4bcqC4uh3Zm0vuFKtHAAVZc4"
Subject: Re: [Qemu-devel] [PATCH for-2.12] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5ll1PVVbF4bcqC4uh3Zm0vuFKtHAAVZc4
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <e9d37d29-82ae-ac3e-9919-62586206c88a@redhat.com>
Subject: Re: [PATCH for-2.12] monitor: bind dispatch bh to iohandler context
References: <20180403050115.6037-1-peterx@redhat.com>
In-Reply-To: <20180403050115.6037-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2018 12:01 AM, Peter Xu wrote:
> Eric Auger reported the problem days ago that OOB broke ARM when runnin=
g
> with libvirt:
>=20
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>=20
> This patch fixes the problem.
>=20
> It's not really needed now since we have turned OOB off now, but it's
> still a bug fix, and it'll start to work when we turn OOB on for ARM.

It may be more than just ARM affected, and just that ARM happened to
trigger the problem easier.

I'm queuing this on my qapi tree, and will send a pull request,
hopefully for -rc2, but even if I miss that, this qualifies as -rc3
material.

>=20
> The problem was that the monitor dispatcher bottom half was bound to
> qemu_aio_context, but that context seems to be for block only.  For the=

> rest of the QEMU world we should be using iohandler context.  So
> assigning monitor dispatcher bottom half to that context.
>=20

>=20
> A quick test of mine shows that after this patch applied we can pass al=
l
> raw iotests even with OOB on by default.
>=20
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <famz@redhat.com>
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>=20
> This patch will fix all known OOB breakages I know so far, but I think
> for better safety I'll still keep OOB off, and I'll send another patch
> to turn default OOB on after 2.12 release.

Yes, leaving OOB defaulting to off unless you use x-oob=3Don for 2.12 is
the most conservative action, although we still want to fix all known
bugs that you can trigger by using that.

How did you run iotests with OOB on by default, by recompiling the
binary to undo commit be933ffc2, or by tweaking the iotests scripts to
pass x-oob=3Don by default?

> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 51f4cf480f..39f8ee17ba 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4467,7 +4467,7 @@ static void monitor_iothread_init(void)
>       * have assumption to be run on main loop thread.  It would be
>       * nice that one day we can remove this assumption in the future.
>       */
> -    mon_global.qmp_dispatcher_bh =3D aio_bh_new(qemu_get_aio_context()=
,
> +    mon_global.qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_cont=
ext(),
>                                                monitor_qmp_bh_dispatche=
r,
>                                                NULL);
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5ll1PVVbF4bcqC4uh3Zm0vuFKtHAAVZc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrDe3QACgkQp6FrSiUn
Q2oYHgf/YwBplyNcqWDu1YgpBLkbH25fZBK3xn7PWL4hyckzHi2uaXDBjA0wUhvE
IDrN/nebRjqjhZLUs6xtJPV0GZgI2/OsjkKCv/JtJ7aR5Iw4wbykLQ7U50RViiTW
ZxyMQgDhNfpnqIzCQdSMxhbGvFH5JWSF/51VkbERmha+b/puZ57aEyUVF2pXI6PP
Bc7gHKvnm1ir9oUZIqdh3BH6yyTETr+fRkcthXtKzAeMLPQloobRPeYYVadfVwYf
g9IMrqiU0klP5EtPRuxACMFgM5nANDnDTLwsnhL91M9HQsNFnZlZxqw8WFZ4tfnN
eF3nu4nU6KQWyi/64e/wwsoqm9Y8Ow==
=Qvro
-----END PGP SIGNATURE-----

--5ll1PVVbF4bcqC4uh3Zm0vuFKtHAAVZc4--
