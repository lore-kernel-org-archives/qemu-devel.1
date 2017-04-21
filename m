Received: from eggs.gnu.org ([2001:4830:134:3::10]:56545)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d1W2u-0005bj-7A
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d1W2q-0000i7-4W
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:44:12 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34581 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d1W2p-0000h2-RC
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 06:44:08 -0400
References: <1492769076-64466-1-git-send-email-anton.nefedov@virtuozzo.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <98514b87-d2a3-254d-f03e-0c6d3cd73ff6@kamp.de>
Date: Fri, 21 Apr 2017 12:44:03 +0200
MIME-Version: 1.0
In-Reply-To: <1492769076-64466-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu-img: wait for convert
 coroutines to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Am 21.04.2017 um 12:04 schrieb Anton Nefedov:
> On error path (like i/o error in one of the coroutines), it's required to
>   - wait for coroutines completion before cleaning the common structures
>   - reenter dependent coroutines so they ever finish
>
> Introduced in 2d9187bc65.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qemu-img.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
>
> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf7..24950c1 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1735,6 +1735,27 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
>      return 0;
>  }
>  
> +static void coroutine_fn convert_reenter_waiting(ImgConvertState *s,
> +                                                 uint64_t wr_offs)
> +{
> +    int i;
> +    if (s->wr_in_order) {
> +        /* reenter the coroutine that might have waited
> +         * for the write to complete */
> +        for (i = 0; i < s->num_coroutines; i++) {
> +            if (s->co[i] && s->wait_sector_num[i] == wr_offs) {
> +                /*
> +                 * A -> B -> A cannot occur because A has
> +                 * s->wait_sector_num[i] == -1 during A -> B.  Therefore
> +                 * B will never enter A during this time window.
> +                 */
> +                qemu_coroutine_enter(s->co[i]);
> +                break;
> +            }
> +        }
> +    }
> +}
> +
>  static void coroutine_fn convert_co_do_copy(void *opaque)
>  {
>      ImgConvertState *s = opaque;
> @@ -1792,6 +1813,7 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
>                  error_report("error while reading sector %" PRId64
>                               ": %s", sector_num, strerror(-ret));
>                  s->ret = ret;
> +                convert_reenter_waiting(s, sector_num + n);
>                  goto out;
>              }
>          } else if (!s->min_sparse && status == BLK_ZERO) {
> @@ -1803,6 +1825,7 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
>              /* keep writes in order */
>              while (s->wr_offs != sector_num) {
>                  if (s->ret != -EINPROGRESS) {
> +                    convert_reenter_waiting(s, sector_num + n);
>                      goto out;
>                  }
>                  s->wait_sector_num[index] = sector_num;
> @@ -1816,25 +1839,12 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
>              error_report("error while writing sector %" PRId64
>                           ": %s", sector_num, strerror(-ret));
>              s->ret = ret;
> +            convert_reenter_waiting(s, sector_num + n);
>              goto out;
>          }
>  
> -        if (s->wr_in_order) {
> -            /* reenter the coroutine that might have waited
> -             * for this write to complete */
> -            s->wr_offs = sector_num + n;
> -            for (i = 0; i < s->num_coroutines; i++) {
> -                if (s->co[i] && s->wait_sector_num[i] == s->wr_offs) {
> -                    /*
> -                     * A -> B -> A cannot occur because A has
> -                     * s->wait_sector_num[i] == -1 during A -> B.  Therefore
> -                     * B will never enter A during this time window.
> -                     */
> -                    qemu_coroutine_enter(s->co[i]);
> -                    break;
> -                }
> -            }
> -        }
> +        s->wr_offs = sector_num + n;
> +        convert_reenter_waiting(s, s->wr_offs);
>      }
>  
>  out:
> @@ -1899,7 +1909,7 @@ static int convert_do_copy(ImgConvertState *s)
>          qemu_coroutine_enter(s->co[i]);
>      }
>  
> -    while (s->ret == -EINPROGRESS) {
> +    while (s->running_coroutines) {
>          main_loop_wait(false);
>      }
>  


And what if we error out in the read path? Wouldn't be something like this easier?


diff --git a/qemu-img.c b/qemu-img.c
index 22f559a..4ff1085 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1903,6 +1903,16 @@ static int convert_do_copy(ImgConvertState *s)
         main_loop_wait(false);
     }
 
+    /* on error path we need to enter all coroutines that are still
+     * running before cleaning up common structures */
+    if (s->ret) {
+        for (i = 0; i < s->num_coroutines; i++) {
+             if (s->co[i]) {
+                 qemu_coroutine_enter(s->co[i]);
+             }
+        }
+    }
+
     if (s->compressed && !s->ret) {
         /* signal EOF to align */
         ret = blk_pwrite_compressed(s->target, 0, NULL, 0);


Peter
