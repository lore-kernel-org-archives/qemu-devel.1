Received: from eggs.gnu.org ([2001:4830:134:3::10]:52952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUo0m-00072h-E5
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUo0l-0005hi-Ic
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:23:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUo0l-0005eF-8a
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:23:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id c126so15277427wmh.0
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 23:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<20181206063552.6701-2-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-2-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Dec 2018 11:23:38 +0400
Message-ID: <CAJ+F1C+hedZC1EkvpScEP5aw3a-exvBauwyecfrM-LB_2rt=bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, nixun@baidu.com, QEMU <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, xieyongji@baidu.com

Hi

On Thu, Dec 6, 2018 at 10:38 AM <elohimes@gmail.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> Now we attempt to connect asynchronously for "reconnect socket"
> during open(). But vhost-user device prefer a connected socket
> during initialization. That means we may still need to support
> sync connection during open() for the "reconnect socket".
>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>

I am not sure this makes much sense, since upon reconnect it won't
"wait" (if I am not mistaken)

> ---
>  chardev/char-socket.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index eaa8e8b68f..f2819d52e7 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1072,7 +1072,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          s->reconnect_time =3D reconnect;
>      }
>
> -    if (s->reconnect_time) {
> +    if (s->reconnect_time && !is_waitconnect) {
>          tcp_chr_connect_async(chr);
>      } else {
>          if (s->is_listen) {
> @@ -1120,7 +1120,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,
>                                    Error **errp)
>  {
>      bool is_listen      =3D qemu_opt_get_bool(opts, "server", false);
> -    bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wait",=
 true);
> +    bool is_waitconnect =3D is_listen ? qemu_opt_get_bool(opts, "wait", =
true) :
> +                          qemu_opt_get_bool(opts, "wait", false);
>      bool is_telnet      =3D qemu_opt_get_bool(opts, "telnet", false);
>      bool is_tn3270      =3D qemu_opt_get_bool(opts, "tn3270", false);
>      bool is_websock     =3D qemu_opt_get_bool(opts, "websocket", false);
> --
> 2.17.1
>
>


--
Marc-Andr=C3=A9 Lureau
