Received: from eggs.gnu.org ([2001:4830:134:3::10]:58420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctKG4-0003jv-5Y
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctKG0-0006Zb-5o
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ctKFz-0006ZO-TI
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 16:31:52 -0400
References: <1490717566-25516-1-git-send-email-den@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0d2f0723-1fea-fb59-776b-1b569045fe11@redhat.com>
Date: Wed, 29 Mar 2017 22:31:48 +0200
MIME-Version: 1.0
In-Reply-To: <1490717566-25516-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ArIUVHDEepJVHMXCEPifKp44W0W412RQB"
Subject: Re: [Qemu-devel] [PATCH for 2.9 1/1] block: add missed
 aio_context_acquire into release_drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ArIUVHDEepJVHMXCEPifKp44W0W412RQB
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <0d2f0723-1fea-fb59-776b-1b569045fe11@redhat.com>
Subject: Re: [PATCH for 2.9 1/1] block: add missed aio_context_acquire into
 release_drive
References: <1490717566-25516-1-git-send-email-den@openvz.org>
In-Reply-To: <1490717566-25516-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.03.2017 18:12, Denis V. Lunev wrote:
> Recently we expirience hang with iothreads enabled with the following
> call trace:
> Thread 1 (Thread 0x7fa95efebc80 (LWP 177117)):
> 0  ppoll () from /lib64/libc.so.6
> 2  qemu_poll_ns () at qemu-timer.c:313
> 3  aio_poll () at aio-posix.c:457
> 4  bdrv_flush () at block/io.c:2641
> 5  bdrv_close () at block.c:2143
> 6  bdrv_delete () at block.c:2352
> 7  bdrv_unref () at block.c:3429
> 8  blk_remove_bs () at block/block-backend.c:427
> 9  blk_delete () at block/block-backend.c:178
> 10 blk_unref () at block/block-backend.c:226
> 11 object_property_del_all () at qom/object.c:399
> 12 object_finalize () at qom/object.c:461
> 13 object_unref () at qom/object.c:898
> 14 object_property_del_child () at qom/object.c:422
> 15 qmp_marshal_device_del () at qmp-marshal.c:1145
> 16 handle_qmp_command () at /usr/src/debug/qemu-2.6.0/monitor.c:3929
>=20
> Technically bdrv_flush() stucks in
>     while (rwco.ret =3D=3D NOT_DONE) {
>         aio_poll(aio_context, true);
>     }
> but rwco.ret is equal to 0 thus we have missed wakeup. Code investigati=
on
> reveals that we do not have performed aio_context_acquire() on this cal=
l
> stack.
>=20
> This patch adds missed lock.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 4 ++++
>  1 file changed, 4 insertions(+)

Since this file is unmaintained but this patch is mostly a matter of the
block layer (and the subject starts with "block" :-)):

Thanks, applied to my block tree:

https://github.com/xanClic/qemu/commits/block

Max


--ArIUVHDEepJVHMXCEPifKp44W0W412RQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcGbQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALacH/1RUavs83fQZfft72zdMw7VZ0X7I1ce+
v4FM06ZcEo1JrTH5SVvzr/l6ivL6QMiqH0urHCgrxpd+ke9qdnoKqWIp1bd++FzJ
JM7fO8wyk/I/54smg/5XOF8YRObghEs55+U/KvdsTo1v9vcEXLf6H1YoDqXAc+jB
REtUw7PLAAMPcAwWdDscAkf4S09nm1cuZhqkv7p2vBqM2jA5mOlJmUM1/2fnz5BU
Fd6iEaQfirF/QijbubF/qWzFAXDlpfHTQeVpxxlHJrwJWtr4uHa8Oa1be7FRP+A0
lbPjL5qK1vPhCYwqrMrNKWiOMHmCulQaVpTw5utNQyojGKExEIp3CA0=
=XFlP
-----END PGP SIGNATURE-----

--ArIUVHDEepJVHMXCEPifKp44W0W412RQB--
