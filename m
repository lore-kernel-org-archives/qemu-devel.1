Received: from eggs.gnu.org ([2001:4830:134:3::10]:45240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fa0KS-00056R-3T
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fa0KI-0002VO-Gp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:01:24 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fa0KI-0002V1-89
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:01:14 -0400
Received: by mail-wr0-x243.google.com with SMTP id h10-v6so15872351wrq.8
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:01:14 -0700 (PDT)
Date: Mon, 2 Jul 2018 16:01:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702150111.GI2155@stefanha-x1.localdomain>
References: <20180702004910.13216-1-caoxinhua@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline
In-Reply-To: <20180702004910.13216-1-caoxinhua@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-char: reset errno before qemu char
 write or read action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "xinhua.Cao" <caoxinhua@huawei.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com, weidong.huang@huawei.com, weifuqiang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com, liuyongan@huawei.com, arei.gonglei@huawei.com


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 08:49:10AM +0800, xinhua.Cao wrote:
> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> We reset errno before reading and writing to
> ensure the correctness of errno's judgment
>=20
> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
> ---
>  chardev/char-fe.c | 1 +
>  chardev/char.c    | 2 ++
>  2 files changed, 3 insertions(+)

The C11x standard "7.4 Errors <errno.h>" says that errno "is never set
to zero by any library function".  Please follow the errno usage
convention described in the C standard.

Instead of making functions called by tcp_chr_write() clear errno,
please fix tcp_chr_write() so that errno is only accessed when ret < 0.

Thanks,
Stefan

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOj43AAoJEJykq7OBq3PIIjEH/20Yi2CPiGZK4TKlorytMRwY
gASQN2w5lHdUuMvegUJY8hk9pndoxANZGAAWBQjOSF4hM7pX+pM9Pd6rBHEDLn0j
ecWMsADubdm9CCsurhXClz+kSznhq4NZ3RFzrpuvLbruFTGyFTE5dAqjzdFIRiHE
XNmkhnrathSW5XcsdG2zspWM9rEldq/CRUSdQi6RWHtX5EZ8QrT9TMdPq4bhuaIE
ndNm3o2bDBrVYd/z4++7ncX+XR3HGoJ5ehJwdQSSev2CVvLB00ubGXTQBiMkiO04
3dsBxnUfXMdFWEj/r7wriWvTytRyFOBPcoR0pcunHqwoieMTG04mCs7oQ6nR+aQ=
=MWYu
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--
