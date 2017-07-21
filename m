Received: from eggs.gnu.org ([2001:4830:134:3::10]:41711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dYVxl-0005vb-UL
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dYVxk-0008RU-Mr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:19:17 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:37952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dYVxk-0008RI-Ap
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:19:16 -0400
Received: by mail-lf0-x241.google.com with SMTP id l125so3086198lfg.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 04:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <1500614191-13392-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1500614191-13392-1-git-send-email-wangyunjian@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 21 Jul 2017 11:19:04 +0000
Message-ID: <CAJ+F1CJ2FWZdY3xN2NOgQxZKYPOE4ykLXhcke+hFt6YDKuYiSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: w00273186 <wangyunjian@huawei.com>, qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com
Cc: caihe@huawei.com

Hi

On Fri, Jul 21, 2017 at 7:18 AM w00273186 <wangyunjian@huawei.com> wrote:

> From: Yunjian Wang <wangyunjian@huawei.com>
>
> "nc" is freed after hotplug vhost-user, but the watcher don't be removed.
> The QEMU crash when the watcher access the "nc" on socket disconnect.
>
>
This is actually your 3rd iteration on the patch

Could your describe your changes since:
"[PATCH v2] vhost-user: fix watcher need be removed when vhost-user hotplug=
"

Thanks


>     Program received signal SIGSEGV, Segmentation fault.
>     #0  object_get_class (obj=3Dobj@entry=3D0x2) at qom/object.c:750
>     #1  0x00007f9bb4180da1 in qemu_chr_fe_disconnect (be=3D<optimized out=
>)
> at chardev/char-fe.c:372
>     #2  0x00007f9bb40d1100 in net_vhost_user_watch (chan=3D<optimized out=
>,
> cond=3D<optimized out>, opaque=3D<optimized out>) at net/vhost-user.c:188
>     #3  0x00007f9baf97f99a in g_main_context_dispatch () from
> /usr/lib64/libglib-2.0.so.0
>     #4  0x00007f9bb41d7ebc in glib_pollfds_poll () at util/main-loop.c:21=
3
>     #5  os_host_main_loop_wait (timeout=3D<optimized out>) at
> util/main-loop.c:261
>     #6  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at
> util/main-loop.c:515
>     #7  0x00007f9bb3e266a7 in main_loop () at vl.c:1917
>     #8  main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<opt=
imized
> out>) at vl.c:4786
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  net/vhost-user.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 36f32a2..c23927c 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -151,6 +151,10 @@ static void vhost_user_cleanup(NetClientState *nc)
>          s->vhost_net =3D NULL;
>      }
>      if (nc->queue_index =3D=3D 0) {
> +        if (s->watch) {
> +            g_source_remove(s->watch);
> +            s->watch =3D 0;
> +        }
>          qemu_chr_fe_deinit(&s->chr, true);
>      }
>
> --
> 1.8.3.1
>
>
>
> --
Marc-Andr=C3=A9 Lureau
