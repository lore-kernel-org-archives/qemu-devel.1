Received: from eggs.gnu.org ([2001:4830:134:3::10]:52159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fadxR-0000mn-S4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fadxO-0005MV-Q1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:20:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fadxO-0005M6-LR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:20:14 -0400
Date: Wed, 4 Jul 2018 10:20:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704092007.GA32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704033642.15996-1-caoxinhua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704033642.15996-1-caoxinhua@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-char: check errno together with ret <
 0
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

On Wed, Jul 04, 2018 at 11:36:42AM +0800, xinhua.Cao wrote:
> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> we need check errno together with ret < 0.
>=20
> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
> ---
>  chardev/char-socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 17519ec..efbad6e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -134,8 +134,11 @@ static int tcp_chr_write(Chardev *chr, const uint8=
_t *buf, int len)
>                                          s->write_msgfds,
>                                          s->write_msgfds_num);
> =20
> -        /* free the written msgfds in any cases other than errno=3D=3D=
EAGAIN */
> -        if (EAGAIN !=3D errno && s->write_msgfds_num) {
> +        /* free the written msgfds in any cases
> +         * other than ret < 0 && errno =3D=3D EAGAIN
> +         */
> +        if (!(ret < 0 && EAGAIN =3D=3D errno)
> +            && s->write_msgfds_num) {
>              g_free(s->write_msgfds);
>              s->write_msgfds =3D 0;
>              s->write_msgfds_num =3D 0;

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
