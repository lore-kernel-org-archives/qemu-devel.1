Received: from eggs.gnu.org ([2001:4830:134:3::10]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz3X-0007hN-GM
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhz3S-0002nA-P9
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:16:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhz3S-0002mb-JY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:16:50 -0400
References: <20180724142504.15092-1-stefanha@redhat.com>
	<20180724142504.15092-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f813b93d-4ed6-e059-abcf-34ea5f844ab1@redhat.com>
Date: Tue, 24 Jul 2018 10:16:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180724142504.15092-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL for-3.0 1/1] trace/simple: fix hang in child
 after fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 07/24/2018 09:25 AM, Stefan Hajnoczi wrote:
> The simple trace backend spawns a write-out thread which is used to
> asynchronously flush the in-memory ring buffer to disk.
> 
> fork(2) does not clone all threads, only the thread that invoked
> fork(2).  As a result there is no write-out thread in the child process!
> 
> This causes a hang during shutdown when atexit(3) handler installed by
> the simple trace backend waits for the non-existent write-out thread.
> 
> This patch uses pthread_atfork(3) to terminate the write-out thread
> before fork and restart it in both the parent and child after fork.
> This solves a hang in qemu-iotests 147 due to qemu-nbd --fork usage.
> 
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 20180717101944.11691-1-stefanha@redhat.com
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

> +static void restart_writeout_thread(void)
> +{
> +    trace_writeout_running = true;
> +    trace_writeout_thread = trace_thread_create(writeout_thread);
> +    if (!trace_writeout_thread) {
> +        warn_report("unable to initialize simple trace backend");
> +    }
> +
> +    /* This relies on undefined behavior in the fork() child (it's fine in the
> +     * fork() parent).  g_mutex_unlock() on a mutex acquired by another thread
> +     * is undefined (see glib documentation).
> +     */
> +    g_mutex_unlock(&trace_lock);

Dan's point about stopping tracing prior to fork, then restarting it 
from scratch in both the parent and in specific children, would also get 
rid of this risky non-portable behavior of trying to manipulate a mutex 
acquired by the parent process' thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
