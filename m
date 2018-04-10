Received: from eggs.gnu.org ([2001:4830:134:3::10]:52827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5lPM-0006If-0N
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5lPI-0003Yc-4d
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:01:28 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5lPH-0003WB-SE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:01:24 -0400
Received: by mail-pf0-x243.google.com with SMTP id q9so7268008pff.1
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 22:01:23 -0700 (PDT)
Date: Tue, 10 Apr 2018 13:01:19 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180410050119.GA30685@stefanha-x1.localdomain>
References: <20180410044942.17059-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20180410044942.17059-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] monitor: bind dispatch bh to
 iohandler context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 12:49:42PM +0800, Peter Xu wrote:
> Eric Auger reported the problem days ago that OOB broke ARM when running
> with libvirt:
>=20
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>=20
> The problem was that the monitor dispatcher bottom half was bound to
> qemu_aio_context now, which could be polled unexpectedly in block code.

And TPM and 9P code, who all use nested event loops.

> We should keep the dispatchers run in iohandler_ctx just like what we
> did before the Out-Of-Band series (chardev uses qio, and qio binds
> everything with iohandler_ctx).
>=20
> If without this change, QMP dispatcher might be run even before reaching
> main loop in block IO path, for example, in a stack like (the ARM case,
> "cont" command handler run even during machine init phase):
>=20
>         #0  qmp_cont ()
>         #1  0x00000000006bd210 in qmp_marshal_cont ()
>         #2  0x0000000000ac05c4 in do_qmp_dispatch ()
>         #3  0x0000000000ac07a0 in qmp_dispatch ()
>         #4  0x0000000000472d60 in monitor_qmp_dispatch_one ()
>         #5  0x000000000047302c in monitor_qmp_bh_dispatcher ()
>         #6  0x0000000000acf374 in aio_bh_call ()
>         #7  0x0000000000acf428 in aio_bh_poll ()
>         #8  0x0000000000ad5110 in aio_poll ()
>         #9  0x0000000000a08ab8 in blk_prw ()
>         #10 0x0000000000a091c4 in blk_pread ()
>         #11 0x0000000000734f94 in pflash_cfi01_realize ()
>         #12 0x000000000075a3a4 in device_set_realized ()
>         #13 0x00000000009a26cc in property_set_bool ()
>         #14 0x00000000009a0a40 in object_property_set ()
>         #15 0x00000000009a3a08 in object_property_set_qobject ()
>         #16 0x00000000009a0c8c in object_property_set_bool ()
>         #17 0x0000000000758f94 in qdev_init_nofail ()
>         #18 0x000000000058e190 in create_one_flash ()
>         #19 0x000000000058e2f4 in create_flash ()
>         #20 0x00000000005902f0 in machvirt_init ()
>         #21 0x00000000007635cc in machine_run_board_init ()
>         #22 0x00000000006b135c in main ()
>=20
> Actually the problem is more severe than that.  After we switched to the
> qemu AIO handler it means the monitor dispatcher code can even be called
> with nested aio_poll(), then it can be an explicit aio_poll() inside
> another main loop aio_poll() which could be racy too.
>=20
> Switch to use the iohandler_ctx for monitor dispatchers.
>=20
> My sincere thanks to Eric Auger who offered great help during both
> debugging and verifying the problem.  The ARM test was carried out by
> applying this patch upon QEMU 2.12.0-rc0 and problem is gone after the
> patch.
>=20
> A quick test of mine shows that after this patch applied we can pass all
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
> v2:
> - enhanced commit message
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
> -    mon_global.qmp_dispatcher_bh =3D aio_bh_new(qemu_get_aio_context(),
> +    mon_global.qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_contex=
t(),
>                                                monitor_qmp_bh_dispatcher,
>                                                NULL);

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazEUeAAoJEJykq7OBq3PIVPQH/jDC3T6zNA9WiPmyqmL0jRW8
bmcN8SDnFQo/YkpuApWtUxiMVLXbtdwITFy9tqJwR606xlCKx0GgExvCGxspZOF2
b3m8696Yrds66/3yPAdiv8zUnt8kNaCfehRsgwwYgtNjbnJJelXQuwglbtGK7DOD
1hbzlFjiFn28M56x53GK45pEGMftR/R2z3WGVqkPpNqTouIhAaxjOr0m5OW6swby
CQLPzXPqP45cXshDknADRGEpUoevc5zhgpNjkQzxZIb9udX93gfTXdLZEhgYCrns
l3uDp/ULWFfDq10ZKhQB+R/RXOe6oNo562zgP6A0aFF0rIlRhZax7u2Ct4JJ8cY=
=S0pF
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
