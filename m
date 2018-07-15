Received: from eggs.gnu.org ([2001:4830:134:3::10]:51150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fegME-0007Hs-OP
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 08:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fegMB-0002cL-Fx
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 08:42:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fegMB-0002aq-42
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 08:42:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D14881A4EA0
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 12:42:29 +0000 (UTC)
References: <20180713184213.25301-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36833724-11e5-42b9-e2bc-8f52734bd640@redhat.com>
Date: Sun, 15 Jul 2018 14:42:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180713184213.25301-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] trace/simple: fix hang in child after
 fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>

On 13/07/2018 20:42, Stefan Hajnoczi wrote:
> +#ifndef _WIN32
> +static void stop_writeout_thread(void)
> +{
> +    g_mutex_lock(&trace_lock);
> +    trace_writeout_running = false;
> +    g_cond_signal(&trace_available_cond);
> +    g_mutex_unlock(&trace_lock);
> +
> +    g_thread_join(trace_writeout_thread);
> +    trace_writeout_thread = NULL;
> +}

After stop_writeout_thread returns, another could start a write to the
shared data structure---and the write would never finish, because the
thread disappears after fork(2) returns.  This would leave the mutex
locked, causing a deadlock soon after the fork.  So you need to lock
trace_lock again here, and unlock it in restart_writeout_thread.

Apart from this, it looks good!

Thanks,

Paolo

> +static void restart_writeout_thread(void)
> +{
> +    trace_writeout_running = true;
> +    trace_writeout_thread = trace_thread_create(writeout_thread);
> +    if (!trace_writeout_thread) {
> +        warn_report("unable to initialize simple trace backend");
> +    }
> +}
> +#endif /* !_WIN32 */
> +
>  bool st_init(void)
>  {
> -    GThread *thread;
> -
>      trace_pid = getpid();
> +    trace_writeout_running = true;
>  
> -    thread = trace_thread_create(writeout_thread);
> -    if (!thread) {
> +    trace_writeout_thread = trace_thread_create(writeout_thread);
> +    if (!trace_writeout_thread) {
>          warn_report("unable to initialize simple trace backend");
>          return false;
>      }
>  
> +#ifndef _WIN32
> +    /* Terminate writeout thread across fork and restart it in parent and
> +     * child afterwards.
> +     */
> +    pthread_atfork(stop_writeout_thread,
> +                   restart_writeout_thread,
> +                   restart_writeout_thread);
> +#endif
> +
>      atexit(st_flush_trace_buffer);
>      return true;
>  }
> 
