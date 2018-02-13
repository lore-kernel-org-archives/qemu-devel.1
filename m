Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eldxB-0007I3-4E
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eldxA-0002Pg-D9
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:01:13 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eldxA-0002Ol-6u
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:01:12 -0500
Received: by mail-wm0-x241.google.com with SMTP id a84so6048203wmi.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 09:01:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180213050837.40964-1-linzhecheng@huawei.com>
References: <20180213050837.40964-1-linzhecheng@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Feb 2018 18:01:09 +0100
Message-ID: <CAJ+F1CK1c+demhjd4kWJzm-gjmg0Bf2e+4zhj9P2ENgDZoe2Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, wangxinxin.wang@huawei.com, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, lidonglin@huawei.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Feb 13, 2018 at 6:08 AM, linzhecheng <linzhecheng@huawei.com> wrote=
:
> g_free() was moved from vhost_net_cleanup in commit e6bcb1b, so we should
> free net after vhost_net_cleanup
>
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>

This can be reproduced and catched by ASAN too:

=3D=3D11833=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 784 byte(s) in 1 object(s) allocated from:
    #0 0x7fa1aed89a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea38)
    #1 0x7fa1adadff75 in g_malloc0 ../glib/gmem.c:124
    #2 0x56082a195515 in vhost_net_init
/home/elmarco/src/qemu/hw/net/vhost_net.c:147
    #3 0x61500000bbff  (<unknown module>)


good catch,

Reviewed-by: Marc-Andr=C3=A9 Lureau < marcandre.lureau@redhat.com>

>
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index cb45512506..d024573e45 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -109,6 +109,7 @@ static int vhost_user_start(int queues, NetClientStat=
e *ncs[], CharBackend *be)
>  err:
>      if (net) {
>          vhost_net_cleanup(net);
> +        g_free(net);
>      }
>      vhost_user_stop(i, ncs);
>      return -1;
> --
> 2.12.2.windows.2
>
>
>



--=20
Marc-Andr=C3=A9 Lureau
