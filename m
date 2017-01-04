Received: from eggs.gnu.org ([2001:4830:134:3::10]:41798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOis2-0006dU-Ru
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOirz-0007Jx-N2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:32:38 -0500
Date: Wed, 4 Jan 2017 10:32:27 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104103227.GD10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1483493521-9604-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1483493521-9604-1-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-thread: fix qemu_thread_set_name()
 race in qemu_thread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, qemu-stable@nongnu.org, Caoxinhua <caoxinhua@huawei.com>, arei.gonglei@huawei.com, pbonzini@redhat.com

On Wed, Jan 04, 2017 at 09:32:01AM +0800, zhanghailiang wrote:
> From: Caoxinhua <caoxinhua@huawei.com>
> 
> QEMU will crash with the follow backtrace if the new created thread exited before
> we call qemu_thread_set_name() for it.
> 
>   (gdb) bt
>   #0 0x00007f9a68b095d7 in __GI_raise (sig=sig@entry=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
>   #1 0x00007f9a68b0acc8 in __GI_abort () at abort.c:90
>   #2 0x00007f9a69cda389 in PAT_abort () from /usr/lib64/libuvpuserhotfix.so
>   #3 0x00007f9a69cdda0d in patchIllInsHandler () from /usr/lib64/libuvpuserhotfix.so
>   #4 <signal handler called>
>   #5 pthread_setname_np (th=140298470549248, name=name@entry=0x8cc74a "io-task-worker") at ../nptl/sysdeps/unix/sysv/linux/pthread_setname.c:49
>   #6 0x00000000007f5f20 in qemu_thread_set_name (thread=thread@entry=0x7ffd2ac09680, name=name@entry=0x8cc74a "io-task-worker") at util/qemu_thread_posix.c:459
>   #7 0x00000000007f679e in qemu_thread_create (thread=thread@entry=0x7ffd2ac09680, name=name@entry=0x8cc74a "io-task-worker",start_routine=start_routine@entry=0x7c1300 <qio_task_thread_worker>, arg=arg@entry=0x7f99b8001720, mode=mode@entry=1) at util/qemu_thread_posix.c:498
>   #8 0x00000000007c15b6 in qio_task_run_in_thread (task=task@entry=0x7f99b80033d0, worker=worker@entry=0x7bd920 <qio_channel_socket_connect_worker>, opaque=0x7f99b8003370, destroy=0x7c6220 <qapi_free_SocketAddress>) at io/task.c:133
>   #9 0x00000000007bda04 in qio_channel_socket_connect_async (ioc=0x7f99b80014c0, addr=0x37235d0, callback=callback@entry=0x54ad00 <qemu_chr_socket_connected>, opaque=opaque@entry=0x38118b0, destroy=destroy@entry=0x0) at io/channel_socket.c:191
>   #10 0x00000000005487f6 in socket_reconnect_timeout (opaque=0x38118b0) at qemu_char.c:4402
>   #11 0x00007f9a6a1533b3 in g_timeout_dispatch () from /usr/lib64/libglib-2.0.so.0
>   #12 0x00007f9a6a15299a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
>   #13 0x0000000000747386 in glib_pollfds_poll () at main_loop.c:227
>   #14 0x0000000000747424 in os_host_main_loop_wait (timeout=404000000) at main_loop.c:272
>   #15 0x0000000000747575 in main_loop_wait (nonblocking=nonblocking@entry=0) at main_loop.c:520
>   #16 0x0000000000557d31 in main_loop () at vl.c:2170
>   #17 0x000000000041c8b7 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:5083
> 
> Let's detach the new thread after calling qemu_thread_set_name().
> 
> Signed-off-by: Caoxinhua <caoxinhua@huawei.com>
> ---
> v2:
>  Fix missing title
> ---
>  util/qemu-thread-posix.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index d20cdde..d31793d 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -481,12 +481,6 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>      if (err) {
>          error_exit(err, __func__);
>      }
> -    if (mode == QEMU_THREAD_DETACHED) {
> -        err = pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
> -        if (err) {
> -            error_exit(err, __func__);
> -        }
> -    }
>  
>      /* Leave signal handling to the iothread.  */
>      sigfillset(&set);
> @@ -499,6 +493,12 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>          qemu_thread_set_name(thread, name);
>      }
>  
> +    if (mode == QEMU_THREAD_DETACHED) {
> +        err = pthread_detach(thread->thread);
> +        if (err) {
> +            error_exit(err, __func__);
> +        }
> +    }

Is it permitted to be calling pthread_detach(), if there is a chance that
the thread has already exited ? It seems reasonable, since a non-detached
thread shouldl remain in a zombie state waiting to be join'd, but the man
page is unclear on behaviour.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
