Received: from eggs.gnu.org ([2001:4830:134:3::10]:58533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG1Hv-0002H4-Hg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dG1Hu-00087K-ED
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:55:39 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dG1Hu-00086e-2Z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:55:38 -0400
Received: by mail-lf0-x241.google.com with SMTP id q24so1033443lfb.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <1496227532-15192-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1496227532-15192-1-git-send-email-wangyunjian@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 May 2017 10:55:26 +0000
Message-ID: <CAJ+F1CKHYUg+WRKe_29i8hs2JF_5as-Zj0GB09LHB0Yt7No01Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yunjian Wang <wangyunjian@huawei.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, caihe@huawei.com, mst@redhat.com

On Wed, May 31, 2017 at 2:49 PM Yunjian Wang <wangyunjian@huawei.com> wrote=
:

> From: w00273186 <wangyunjian@huawei.com>
>
> "nc" is freed after hotplug vhost-user, but the watcher don't be removed.
> The QEMU crash when the watcher access the "nc" on socket disconnect.
>
> Call Trace:
>     #0  object_get_class (obj=3Dobj@entry=3D0x2) at qom/object.c:751
>     #1  0x00007fc031c79f41 in qemu_chr_fe_disconnect (be=3D<optimized out=
>)
> at chardev/char.c:1048
>     #2  0x00007fc031bd62e0 in net_vhost_user_watch (chan=3D<optimized out=
>,
> cond=3D<optimized out>, opaque=3D<optimized out>) at net/vhost-user.c:191
>     #3  0x00007fc02c23e99a in g_main_context_dispatch () from
> /lib64/libglib-2.0.so.0
>     #4  0x00007fc031ccfc0c in glib_pollfds_poll () at util/main-loop.c:21=
3
>     #5  os_host_main_loop_wait (timeout=3D<optimized out>) at
> util/main-loop.c:261
>     #6  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at
> util/main-loop.c:517
>     #7  0x00007fc03193bc87 in main_loop () at vl.c:1899
>     #8  main (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<opt=
imized
> out>) at vl.c:4719
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  net/vhost-user.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 00a0c1c..8da314d 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -153,6 +153,10 @@ static void vhost_user_cleanup(NetClientState *nc)
>      if (nc->queue_index =3D=3D 0) {
>          Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
>
> +        if (s->watch) {
> +            g_source_remove(s->watch);
> +            s->watch =3D 0;
> +        }
>          qemu_chr_fe_deinit(&s->chr);
>          object_unparent(OBJECT(chr));
>      }
> --
> 1.8.3.1
>
>
>
> --
Marc-Andr=C3=A9 Lureau
