Received: from eggs.gnu.org ([2001:4830:134:3::10]:59374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfk9H-0005Ko-Gk
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfk9E-0004nL-Ac
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:53:03 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfk9E-0004n4-0f
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:53:00 -0400
Received: by mail-wm0-f48.google.com with SMTP id f15so17719734wmg.1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 02:52:59 -0700 (PDT)
References: <201708101717543503610@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a447dbd8-b2fc-1da9-606f-df10c3844d38@redhat.com>
Date: Thu, 10 Aug 2017 11:52:56 +0200
MIME-Version: 1.0
In-Reply-To: <201708101717543503610@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIXSBxZW11LWlvdGhy?=
 =?utf-8?q?ead=3A_IOThread_supports_the_GMainContext_eventloop?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn
Cc: lizhijian@cn.fujitsu.com, famz@redhat.com, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, wang.guang55@zte.com.cn, jasowang@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

On 10/08/2017 11:17, wang.yong155@zte.com.cn wrote:
>> Nice.  Just a note, I think an iothread should have its own (optional)
> 
>> GMainContext accessed with iothread_get_g_main_context(iothread).  When
> 
>> you call it for the first time, the iothread:
> 
>>
> 
>> 1) creates a GMainContext
> 
>>
> 
>> 2) adds the AioContext as a GSource in the GMainContext
> 
>>
> 
>> 3) asks iothread_run to switch from the AioContext loop to the
> 
>> GMainContext loop
> 
>>
> 
>>
> 
>> To simplify thread-safety:
> 
>>
> 
>> 1) the GMainContext can be wrapped with a GOnce
> 
>>
> 
>> 2) the GOnce callback can leave steps 2 and 3 to a bottom half.
> 
>>
> 
> Thanks, I will submit a patch v2.
> 
> 
> 
> 
> WangYong
> 
> 
> 
> 
> 
> 
> 原始邮件
> 
> 
> 
> 发件人： <pbonzini@redhat.com>
> 收件人：王勇10170530
> 抄送人： <stefanha@redhat.com> <famz@redhat.com> <jasowang@redhat.com>王广10165992 <zhangchen.fnst@cn.fujitsu.com> <zhang.zhanghailiang@huawei.com> <lizhijian@cn.fujitsu.com> <qemu-devel@nongnu.org>
> 日 期 ：2017年08月10日 16:51
> 主 题 ：Re: [PATCH] qemu-iothread: IOThread supports the GMainContext eventloop
> 
> 
> 
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Wang yong" <wang.yong155@zte.com.cn>
>> To: pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com
>> Cc: "wang yong155" <wang.yong155@zte.com.cn>, "wang guang55" <wang.guang55@zte.com.cn>, "zhangchen fnst"
>> <zhangchen.fnst@cn.fujitsu.com>, "zhang zhanghailiang" <zhang.zhanghailiang@huawei.com>, lizhijian@cn.fujitsu.com,
>> qemu-devel@nongnu.org
>> Sent: Friday, August 11, 2017 2:29:15 AM
>> Subject: [PATCH] qemu-iothread: IOThread supports the GMainContext event loop
>>
>> From: Wang Yong<wang.yong155@zte.com.cn>
>>
>> IOThread uses AioContext event loop and does not run a GMainContext.
>> Therefore,chardev cannot work in IOThread,such as the chardev is
>> used for colo-compare packets reception.
>>
>> This patch makes the IOThread run the GMainContext event loop,
>> chardev and IOThread can work together.
>>
>> Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
>> Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
> 
> Nice.  Just a note, I think an iothread should have its own (optional)
> GMainContext accessed with iothread_get_g_main_context(iothread).  When
> you call it for the first time, the iothread:
> 
> 1) creates a GMainContext
> 
> 2) adds the AioContext as a GSource in the GMainContext
> 
> 3) asks iothread_run to switch from the AioContext loop to the
> GMainContext loop
> 
> 
> To simplify thread-safety:
> 
> 1) the GMainContext can be wrapped with a GOnce
> 
> 2) the GOnce callback can leave steps 2 and 3 to a bottom half.

Thanks.  Another thing, please add a call to
g_main_context_push_thread_default() and
g_main_context_pop_thread_default().

Thanks,

Paolo

>> ---
>>  include/sysemu/iothread.h |  1 +
>>  iothread.c                | 13 +++++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
>> index e6da1a4..ffe4e8a 100644
>> --- a/include/sysemu/iothread.h
>> +++ b/include/sysemu/iothread.h
>> @@ -24,6 +24,7 @@ typedef struct {
>>  
>>      QemuThread thread
>>      AioContext *ctx
>> +    GMainLoop *loop
>>      QemuMutex init_done_lock
>>      QemuCond init_done_cond    /* is thread initialization done? */
>>      bool stopping
>> diff --git a/iothread.c b/iothread.c
>> index beeb870..b6f3c3c 100644
>> --- a/iothread.c
>> +++ b/iothread.c
>> @@ -46,6 +46,7 @@ AioContext *qemu_get_current_aio_context(void)
>>  static void *iothread_run(void *opaque)
>>  {
>>      IOThread *iothread = opaque
>> +    GMainContext *context
>>  
>>      rcu_register_thread()
>>  
>> @@ -57,6 +58,15 @@ static void *iothread_run(void *opaque)
>>  
>>      while (!atomic_read(&iothread->stopping)) {
>>          aio_poll(iothread->ctx, true)
>> +
>> +        context = iothread->ctx->source.context
>> +        if (context) {
>> +            iothread->loop = g_main_loop_new(context, TRUE)
>> +            g_main_loop_run(iothread->loop)
>> +
>> +            g_main_loop_unref(iothread->loop)
>> +            g_main_context_unref(context)
>> +        }
>>      }
>>  
>>      rcu_unregister_thread()
>> @@ -72,6 +82,9 @@ static int iothread_stop(Object *object, void *opaque)
>>          return 0
>>      }
>>      iothread->stopping = true
>> +    if (iothread->loop) {
>> +        g_main_loop_quit(iothread->loop)
>> +    }
>>      aio_notify(iothread->ctx)
>>      qemu_thread_join(&iothread->thread)
>>      return 0
>> --
>> 1.8.3.1
>>
>>
>>
> 
