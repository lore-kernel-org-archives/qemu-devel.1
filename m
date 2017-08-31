Received: from eggs.gnu.org ([2001:4830:134:3::10]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJEB-0000aI-VX
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJE8-0007ID-Sj
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnJE8-0007Hv-J5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:45:20 -0400
Date: Thu, 31 Aug 2017 14:45:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831064511.GI17741@lemon.lan>
References: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
	<1503991359-3353-2-git-send-email-wang.yong155@zte.com.cn>
	<20170831021838.GG17741@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831021838.GG17741@lemon.lan>
Subject: Re: [Qemu-devel] [PATCHv5 01/03] qemu-iothread: IOThread supports
 the GMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>
Cc: lizhijian@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, jasowang@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com

On Thu, 08/31 10:18, Fam Zheng wrote:
> On Tue, 08/29 15:22, Wang yong wrote:
> > From: Wang Yong <wang.yong155@zte.com.cn>
> > 
> > IOThread uses AioContext event loop and does not run a GMainContext.
> > Therefore,chardev cannot work in IOThread,such as the chardev is
> > used for colo-compare packets reception.
> > 
> > This patch makes the IOThread run the GMainContext event loop,
> > chardev and IOThread can work together.
> > 
> > Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
> > Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
> > ---
> >  include/sysemu/iothread.h |  4 ++++
> >  iothread.c                | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+)
> > 
> > diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
> > index e6da1a4..d2985b3 100644
> > --- a/include/sysemu/iothread.h
> > +++ b/include/sysemu/iothread.h
> > @@ -24,6 +24,9 @@ typedef struct {
> >  
> >      QemuThread thread;
> >      AioContext *ctx;
> > +    GMainContext *worker_context;
> > +    GMainLoop *main_loop;
> > +    GOnce once;
> >      QemuMutex init_done_lock;
> >      QemuCond init_done_cond;    /* is thread initialization done? */
> >      bool stopping;
> > @@ -41,5 +44,6 @@ typedef struct {
> >  char *iothread_get_id(IOThread *iothread);
> >  AioContext *iothread_get_aio_context(IOThread *iothread);
> >  void iothread_stop_all(void);
> > +GMainContext *iothread_get_g_main_context(IOThread *iothread);
> >  
> >  #endif /* IOTHREAD_H */
> > diff --git a/iothread.c b/iothread.c
> > index beeb870..44c8944 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -57,6 +57,23 @@ static void *iothread_run(void *opaque)
> >  
> >      while (!atomic_read(&iothread->stopping)) {
> >          aio_poll(iothread->ctx, true);
> > +
> > +        if (atomic_read(&iothread->worker_context)) {
> > +            GMainLoop *loop;
> > +
> > +            g_main_context_push_thread_default(iothread->worker_context);
> > +            iothread->main_loop =
> > +                g_main_loop_new(iothread->worker_context, TRUE);
> > +            loop = iothread->main_loop;
> > +
> > +            g_main_loop_run(iothread->main_loop);
> > +            iothread->main_loop = NULL;
> > +            g_main_loop_unref(loop);
> > +
> > +            g_main_context_pop_thread_default(iothread->worker_context);
> > +            g_main_context_unref(iothread->worker_context);
> > +            iothread->worker_context = NULL;
> > +        }
> >      }
> >  
> >      rcu_unregister_thread();
> > @@ -73,6 +90,9 @@ static int iothread_stop(Object *object, void *opaque)
> >      }
> >      iothread->stopping = true;
> >      aio_notify(iothread->ctx);
> > +    if (atomic_read(&iothread->main_loop)) {
> > +        g_main_loop_quit(iothread->main_loop);
> > +    }
> >      qemu_thread_join(&iothread->thread);
> >      return 0;
> >  }
> > @@ -125,6 +145,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
> >  
> >      qemu_mutex_init(&iothread->init_done_lock);
> >      qemu_cond_init(&iothread->init_done_cond);
> > +    iothread->once = (GOnce) G_ONCE_INIT;
> 
> In last review I suggested removing this type cast, otherwise looks good. Drop
> it and please add

No, Yong is right, because this is not varialble initializer, type cast is
required by C. Sorry for the noise.

Fam
