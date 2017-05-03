Received: from eggs.gnu.org ([2001:4830:134:3::10]:32974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5wUW-0002lv-AI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5wUS-0003J4-Bb
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:47:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5wUS-0003In-2K
	for qemu-devel@nongnu.org; Wed, 03 May 2017 11:46:56 -0400
References: <20170227163447.20428-1-stefanha@redhat.com>
	<20170227163447.20428-2-stefanha@redhat.com>
	<20170503145418.GB27432@redhat.com>
	<182d640c-c892-993e-06d4-a9cdd9f363d6@redhat.com>
	<20170503153400.GD27432@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9489b184-019a-c644-a54f-b795f56f22a1@redhat.com>
Date: Wed, 3 May 2017 17:46:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170503153400.GD27432@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/4] curl: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



On 03/05/2017 17:34, Richard W.M. Jones wrote:
> Thread 1 (Thread 0x7f1d5a4e2c00 (LWP 29947)):
> #0  0x00007f1d57f861bd in __lll_lock_wait ()
>     at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> #1  0x00007f1d57f81d02 in _L_lock_791 () at /lib64/libpthread.so.0
> #2  0x00007f1d57f81c08 in __GI___pthread_mutex_lock (mutex=mutex@entry=0x55ea5e5ac178) at pthread_mutex_lock.c:64
> #3  0x000055ea5c3583e9 in qemu_mutex_lock (mutex=mutex@entry=0x55ea5e5ac178)
>     at util/qemu-thread-posix.c:60
> #4  0x000055ea5c2fb2d1 in curl_readv_bh_cb (p=0x55ea6013c620)
>     at block/curl.c:824
> #5  0x000055ea5c352fe1 in aio_bh_poll (bh=0x55ea60eb99d0) at util/async.c:90
> #6  0x000055ea5c352fe1 in aio_bh_poll (ctx=ctx@entry=0x55ea5e555970)
>     at util/async.c:118
> #7  0x000055ea5c3563c4 in aio_poll (ctx=0x55ea5e555970, blocking=blocking@entry=true) at util/aio-posix.c:682
> #8  0x000055ea5c2fb09e in curl_init_state (bs=0x55ea5e5a56b0, s=s@entry=0x55ea5e5ab100) at block/curl.c:470
> #9  0x000055ea5c2fb39b in curl_readv_bh_cb (p=0x55ea5f650c30)
>     at block/curl.c:839
> #10 0x000055ea5c352fe1 in aio_bh_poll (bh=0x55ea60eb1910) at util/async.c:90
> #11 0x000055ea5c352fe1 in aio_bh_poll (ctx=ctx@entry=0x55ea5e555970)
>     at util/async.c:118
> #12 0x000055ea5c355f80 in aio_dispatch (ctx=0x55ea5e555970)
>     at util/aio-posix.c:429
> #13 0x000055ea5c352ebe in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:261
> #14 0x00007f1d55489d7a in g_main_context_dispatch (context=0x55ea5e555d40)
>     at gmain.c:3152
> #15 0x00007f1d55489d7a in g_main_context_dispatch (context=context@entry=0x55ea5e555d40) at gmain.c:3767
> #16 0x000055ea5c35523c in main_loop_wait () at util/main-loop.c:213
> #17 0x000055ea5c35523c in main_loop_wait (timeout=<optimized out>)
>     at util/main-loop.c:261
> #18 0x000055ea5c35523c in main_loop_wait (nonblocking=nonblocking@entry=0)
>     at util/main-loop.c:517
> #19 0x000055ea5bfb44a7 in main () at vl.c:1899
> #20 0x000055ea5bfb44a7 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4717
> 
> 

Please test this:

diff --git a/block/curl.c b/block/curl.c
index 2708d57c2f..cfe02bfd79 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -467,7 +467,9 @@ static CURLState *curl_init_state(BlockDriverState
*bs, BDRVCURLState *s)
             break;
         }
         if (!state) {
+            qemu_mutex_unlock(&s->mutex);
             aio_poll(bdrv_get_aio_context(bs), true);
+            qemu_mutex_lock(&s->mutex);
         }
     } while(!state);


Thanks,

Paolo
