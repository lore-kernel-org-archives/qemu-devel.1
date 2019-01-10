Received: from eggs.gnu.org ([209.51.188.92]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghZmc-0003Gh-0R
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghZma-00078P-Uz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghZma-00078C-Mb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:50:00 -0500
Date: Thu, 10 Jan 2019 12:49:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190110124946.GL2178@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-2-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109112728.9214-2-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 1/7] char-socket: Enable
 "nowait" option on client sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com
Cc: mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Wed, Jan 09, 2019 at 07:27:22PM +0800, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
> 
> Enable "nowait" option to make QEMU not do a connect
> on client sockets during initialization of the chardev.
> Then we can use qemu_chr_fe_wait_connected() to connect
> when necessary. Now it would be used for unix domain
> socket of vhost-user-blk device to support reconnect.
> 
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> ---
>  chardev/char-socket.c | 56 +++++++++++++++++++++----------------------
>  qapi/char.json        |  3 +--
>  qemu-options.hx       |  9 ++++---
>  3 files changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index eaa8e8b68f..f803f4f7d3 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1072,37 +1072,37 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          s->reconnect_time = reconnect;
>      }
>  
> -    if (s->reconnect_time) {
> -        tcp_chr_connect_async(chr);
> -    } else {
> -        if (s->is_listen) {
> -            char *name;
> -            s->listener = qio_net_listener_new();
> +    if (s->is_listen) {
> +        char *name;
> +        s->listener = qio_net_listener_new();
>  
> -            name = g_strdup_printf("chardev-tcp-listener-%s", chr->label);
> -            qio_net_listener_set_name(s->listener, name);
> -            g_free(name);
> +        name = g_strdup_printf("chardev-tcp-listener-%s", chr->label);
> +        qio_net_listener_set_name(s->listener, name);
> +        g_free(name);
>  
> -            if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
> -                object_unref(OBJECT(s->listener));
> -                s->listener = NULL;
> -                goto error;
> -            }
> +        if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0) {
> +            object_unref(OBJECT(s->listener));
> +            s->listener = NULL;
> +            goto error;
> +        }
>  
> -            qapi_free_SocketAddress(s->addr);
> -            s->addr = socket_local_address(s->listener->sioc[0]->fd, errp);
> -            update_disconnected_filename(s);
> +        qapi_free_SocketAddress(s->addr);
> +        s->addr = socket_local_address(s->listener->sioc[0]->fd, errp);
> +        update_disconnected_filename(s);
>  
> -            if (is_waitconnect &&
> -                qemu_chr_wait_connected(chr, errp) < 0) {
> -                return;
> -            }
> -            if (!s->ioc) {
> -                qio_net_listener_set_client_func_full(s->listener,
> -                                                      tcp_chr_accept,
> -                                                      chr, NULL,
> -                                                      chr->gcontext);
> -            }
> +        if (is_waitconnect &&
> +            qemu_chr_wait_connected(chr, errp) < 0) {
> +            return;
> +        }
> +        if (!s->ioc) {
> +            qio_net_listener_set_client_func_full(s->listener,
> +                                                  tcp_chr_accept,
> +                                                  chr, NULL,
> +                                                  chr->gcontext);
> +        }
> +    } else if (is_waitconnect) {
> +        if (s->reconnect_time) {
> +            tcp_chr_connect_async(chr);
>          } else if (qemu_chr_wait_connected(chr, errp) < 0) {
>              goto error;
>          }

This skips everything when 'is_waitconnect' is false.

This combines with a bug in tests/libqtest.c which adds the 'nowait'
flag to the -chardevs it cteates. This mistake was previously ignored
because the chardevs were socket clients, but now we honour it.

We shoul remove 'nowait' from the qtest chardevs, but separately
from that this code should also still attempt a non-blocking
connect when is_waitconnect is false.

ie

    } else if (is_waitconnect) {
        if (s->reconnect_time || !is_waitconnect) {
            tcp_chr_connect_async(chr);
        } else if (qemu_chr_wait_connected(chr, errp) < 0) {
            goto error;
        }
    }


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
