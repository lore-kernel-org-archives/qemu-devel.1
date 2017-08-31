Received: from eggs.gnu.org ([2001:4830:134:3::10]:53504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJIF-0003to-Ai
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJIC-0000oy-8b
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnJIB-0000od-W8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:49:32 -0400
Date: Thu, 31 Aug 2017 14:49:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831064926.GA14622@lemon.lan>
References: <201708311127423071469@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201708311127423071469@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCHv5 01/03] qemu-iothread: IOThread supports
 theGMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn
Cc: lizhijian@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, jasowang@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

On Thu, 08/31 11:27, wang.yong155@zte.com.cn wrote:
> >> From: Wang Yong <wang.yong155@zte.com.cn>
> 
> >> 
> 
> >> IOThread uses AioContext event loop and does not run a GMainContext.
> 
> >> Therefore,chardev cannot work in IOThread,such as the chardev is
> 
> >> used for colo-compare packets reception.
> 
> >> 
> 
> >> This patch makes the IOThread run the GMainContext event loop,
> 
> >> chardev and IOThread can work together.
> 
> >> 
> 
> >> Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
> 
> >> Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
> 
> >> ---
> 
> >>  include/sysemu/iothread.h |  4 ++++
> 
> >>  iothread.c                | 45 +++++++++++++++++++++++++++++++++++++++++++++
> 
> >>  2 files changed, 49 insertions(+)
> 
> >> 
> 
> >> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> 
> >> index e6da1a4..d2985b3 100644
> 
> >> --- a/include/sysemu/iothread.h
> 
> >> +++ b/include/sysemu/iothread.h
> 
> >> @@ -24,6 +24,9 @@ typedef struct {
> 
> >>  
> 
> >>      QemuThread thread
> 
> >>      AioContext *ctx
> 
> >> +    GMainContext *worker_context
> 
> >> +    GMainLoop *main_loop
> 
> >> +    GOnce once
> 
> >>      QemuMutex init_done_lock
> 
> >>      QemuCond init_done_cond    /* is thread initialization done? */
> 
> >>      bool stopping
> 
> >> @@ -41,5 +44,6 @@ typedef struct {
> 
> >>  char *iothread_get_id(IOThread *iothread)
> 
> >>  AioContext *iothread_get_aio_context(IOThread *iothread)
> 
> >>  void iothread_stop_all(void)
> 
> >> +GMainContext *iothread_get_g_main_context(IOThread *iothread)
> 
> >>  
> 
> >>  #endif /* IOTHREAD_H */
> 
> >> diff --git a/iothread.c b/iothread.c
> 
> >> index beeb870..44c8944 100644
> 
> >> --- a/iothread.c
> 
> >> +++ b/iothread.c
> 
> >> @@ -57,6 +57,23 @@ static void *iothread_run(void *opaque)
> 
> >>  
> 
> >>      while (!atomic_read(&iothread->stopping)) {
> 
> >>          aio_poll(iothread->ctx, true)
> 
> >> +
> 
> >> +        if (atomic_read(&iothread->worker_context)) {
> 
> >> +            GMainLoop *loop
> 
> >> +
> 
> >> +            g_main_context_push_thread_default(iothread->worker_context)
> 
> >> +            iothread->main_loop =
> 
> >> +                g_main_loop_new(iothread->worker_context, TRUE)
> 
> >> +            loop = iothread->main_loop
> 
> >> +
> 
> >> +            g_main_loop_run(iothread->main_loop)
> 
> >> +            iothread->main_loop = NULL
> 
> >> +            g_main_loop_unref(loop)
> 
> >> +
> 
> >> +            g_main_context_pop_thread_default(iothread->worker_context)
> 
> >> +            g_main_context_unref(iothread->worker_context)
> 
> >> +            iothread->worker_context = NULL
> 
> >> +        }
> 
> >>      }
> 
> >>  
> 
> >>      rcu_unregister_thread()
> 
> >> @@ -73,6 +90,9 @@ static int iothread_stop(Object *object, void *opaque)
> 
> >>      }
> 
> >>      iothread->stopping = true
> 
> >>      aio_notify(iothread->ctx)
> 
> >> +    if (atomic_read(&iothread->main_loop)) {
> 
> >> +        g_main_loop_quit(iothread->main_loop)
> 
> >> +    }
> 
> >>      qemu_thread_join(&iothread->thread)
> 
> >>      return 0
> 
> >>  }
> 
> >> @@ -125,6 +145,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
> 
> >>  
> 
> >>      qemu_mutex_init(&iothread->init_done_lock)
> 
> >>      qemu_cond_init(&iothread->init_done_cond)
> 
> >> +    iothread->once = (GOnce) G_ONCE_INIT
> 
> >
> 
> >In last review I suggested removing this type cast, otherwise looks good. Drop
> 
> >it and please add
> 
> >
> 
> >Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> 
> 
> 
> Sorry, There's something wrong with our company's mail format.

Yes, not only the format. There isn't "In-Reply-To" in the header in the other
message, which is a big issue because they won't be added to the original
thread. Please fix your email setup.

> 
> Please ignore my last reply mail.
> 
> 
> 
> 
> Hi Fam,
> 
> Here, iothread->once can't be initialized with G_ONCE_INIT directly, must use type cast.
> 
> if  remove type cast , we will get an error.

Yes, you are right, thanks. I've also replied in the thread.

Fam
