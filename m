Received: from eggs.gnu.org ([2001:4830:134:3::10]:54788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1faeDf-0004ji-Is
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1faeDe-0005yP-Av
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:37:03 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1faeDe-0005xh-3i
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:37:02 -0400
Received: by mail-wm0-x242.google.com with SMTP id v25-v6so5107171wmc.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 02:37:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704033642.15996-1-caoxinhua@huawei.com>
References: <20180704033642.15996-1-caoxinhua@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Jul 2018 11:36:59 +0200
Message-ID: <CAJ+F1CKTPE+gKbR5sHvRFxcMnN4ToxxhMoQzeZVcnri+WJVyow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, weidong.huang@huawei.com, weifuqiang@huawei.com, QEMU <qemu-devel@nongnu.org>, king.wang@huawei.com, liuyongan@huawei.com, Gonglei <arei.gonglei@huawei.com>

On Wed, Jul 4, 2018 at 5:36 AM, xinhua.Cao <caoxinhua@huawei.com> wrote:
> In the tcp_chr_write function, we checked errno,
> but errno was not reset before a read or write operation.
> Therefore, this check of errno's actions is often
> incorrect after EAGAIN has occurred.
> we need check errno together with ret < 0.
>
> Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>


Can you point out this is fixing commit
9fc53a10f81d3a9027b23fa810147d21be29e614 in commit message?

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 17519ec..efbad6e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -134,8 +134,11 @@ static int tcp_chr_write(Chardev *chr, const uint8_t=
 *buf, int len)
>                                          s->write_msgfds,
>                                          s->write_msgfds_num);
>
> -        /* free the written msgfds in any cases other than errno=3D=3DEA=
GAIN */
> -        if (EAGAIN !=3D errno && s->write_msgfds_num) {
> +        /* free the written msgfds in any cases
> +         * other than ret < 0 && errno =3D=3D EAGAIN
> +         */
> +        if (!(ret < 0 && EAGAIN =3D=3D errno)
> +            && s->write_msgfds_num) {
>              g_free(s->write_msgfds);
>              s->write_msgfds =3D 0;
>              s->write_msgfds_num =3D 0;
> --
> 2.8.3
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
