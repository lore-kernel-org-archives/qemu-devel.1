Received: from eggs.gnu.org ([2001:4830:134:3::10]:37793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1elyHR-0002lf-QI
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1elyHO-0002xl-MO
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:43:29 -0500
Received: from mail-ve1eur01on0106.outbound.protection.outlook.com
	([104.47.1.106]:32289
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1elyHO-0002uh-AU
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:43:26 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
References: <20180207094844.21402-1-klim.kireev@virtuozzo.com>
Message-ID: <ad218d8b-0cac-50ca-2c69-43d150c3599a@virtuozzo.com>
Date: Wed, 14 Feb 2018 17:43:19 +0300
MIME-Version: 1.0
In-Reply-To: <20180207094844.21402-1-klim.kireev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3] vnc: fix segfault in closed connection
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kraxel@redhat.com

ping

On 02/07/2018 12:48 PM, Klim Kireev wrote:
> On one of our client's node, due to trying to read from closed ioc,
> a segmentation fault occured. Corresponding backtrace:
>
> 0  object_get_class (obj=obj@entry=0x0)
> 1  qio_channel_readv_full (ioc=0x0, iov=0x7ffe55277180 ...
> 2  qio_channel_read (ioc=<optimized out> ...
> 3  vnc_client_read_buf (vs=vs@entry=0x55625f3c6000, ...
> 4  vnc_client_read_plain (vs=0x55625f3c6000)
> 5  vnc_client_read (vs=0x55625f3c6000)
> 6  vnc_client_io (ioc=<optimized out>, condition=G_IO_IN, ...
> 7  g_main_dispatch (context=0x556251568a50)
> 8  g_main_context_dispatch (context=context@entry=0x556251568a50)
> 9  glib_pollfds_poll ()
> 10 os_host_main_loop_wait (timeout=<optimized out>)
> 11 main_loop_wait (nonblocking=nonblocking@entry=0)
> 12 main_loop () at vl.c:1909
> 13 main (argc=<optimized out>, argv=<optimized out>, ...
>
> Having analyzed the coredump, I understood that the reason is that
> ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
> in vnc_disconnect_finish. Between these two events due to some
> reasons the ioc_tag was set again and after vnc_disconnect_finish
> the handler is running with freed ioc,
> which led to the segmentation fault.
>
> The patch checks vs->disconnecting in places where we call
> qio_channel_add_watch and resets handler if disconnecting == TRUE
> to prevent such an occurrence.
>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> ---
> Changelog:
> v2: Attach the backtrace
>
> v3: Change checks
>
>   ui/vnc-jobs.c |  6 ++++--
>   ui/vnc.c      | 15 ++++++++++++++-
>   2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index e326679dd0..868dddef4b 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -148,8 +148,10 @@ void vnc_jobs_consume_buffer(VncState *vs)
>               if (vs->ioc_tag) {
>                   g_source_remove(vs->ioc_tag);
>               }
> -            vs->ioc_tag = qio_channel_add_watch(
> -                vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
> +            if (vs->disconnecting == FALSE) {
> +                vs->ioc_tag = qio_channel_add_watch(
> +                    vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
> +            }
>           }
>           buffer_move(&vs->output, &vs->jobs_buffer);
>   
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 93731accb6..67ccc8160f 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1536,12 +1536,19 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
>       VncState *vs = opaque;
>       if (condition & G_IO_IN) {
>           if (vnc_client_read(vs) < 0) {
> -            return TRUE;
> +            goto end;
>           }
>       }
>       if (condition & G_IO_OUT) {
>           vnc_client_write(vs);
>       }
> +end:
> +    if (vs->disconnecting) {
> +        if (vs->ioc_tag != 0) {
> +            g_source_remove(vs->ioc_tag);
> +        }
> +        vs->ioc_tag = 0;
> +    }
>       return TRUE;
>   }
>   
> @@ -1630,6 +1637,12 @@ void vnc_flush(VncState *vs)
>       if (vs->ioc != NULL && vs->output.offset) {
>           vnc_client_write_locked(vs);
>       }
> +    if (vs->disconnecting) {
> +        if (vs->ioc_tag != 0) {
> +            g_source_remove(vs->ioc_tag);
> +        }
> +        vs->ioc_tag = 0;
> +    }
>       vnc_unlock_output(vs);
>   }
>   
