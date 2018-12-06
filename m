Received: from eggs.gnu.org ([2001:4830:134:3::10]:60475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gUq0r-0004Rd-3s
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gUq0l-0001dE-FE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:32:05 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:36337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gUq0k-0001Zf-2X
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:31:58 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20181206063552.6701-2-xieyongji@baidu.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<20181206063552.6701-2-xieyongji@baidu.com>
MIME-Version: 1.0
Date: Thu, 06 Dec 2018 12:31:51 +0300
Message-Id: <1167371544088711@myt4-a988562a11ab.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/6] char-socket: Enable "wait"
 option for client mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "elohimes@gmail.com" <elohimes@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Cc: "nixun@baidu.com" <nixun@baidu.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "lilin24@baidu.com" <lilin24@baidu.com>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, Xie Yongji <xieyongji@baidu.com>

Hi,

06.12.2018, 09:37, "elohimes@gmail.com" <elohimes@gmail.com>:
> From: Xie Yongji <xieyongji@baidu.com>
>
> Now we attempt to connect asynchronously for "reconnect socket"
> during open(). But vhost-user device prefer a connected socket
> during initialization. That means we may still need to support
> sync connection during open() for the "reconnect socket".
>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> ---
> =C2=A0chardev/char-socket.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index eaa8e8b68f..f2819d52e7 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1072,7 +1072,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s->reconnect_time=
 =3D reconnect;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> - if (s->reconnect_time) {
> + if (s->reconnect_time && !is_waitconnect) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tcp_chr_connect_a=
sync(chr);

Does reconnect+wait allow to start QEMU when the first connection was fai=
led?
I think it was the main reason to use tcp_chr_connect_async for reconnect=
 case.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (s->is_listen)=
 {
> @@ -1120,7 +1120,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts,=
 ChardevBackend *backend,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **er=
rp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool is_listen =3D qemu_opt_get_bool(opts=
, "server", false);
> - bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wait", =
true);
> + bool is_waitconnect =3D is_listen ? qemu_opt_get_bool(opts, "wait", t=
rue) :
> + qemu_opt_get_bool(opts, "wait", false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool is_telnet =3D qemu_opt_get_bool(opts=
, "telnet", false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool is_tn3270 =3D qemu_opt_get_bool(opts=
, "tn3270", false);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool is_websock =3D qemu_opt_get_bool(opt=
s, "websocket", false);
> --
> 2.17.1

Regards,
Yury
