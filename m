Received: from eggs.gnu.org ([2001:4830:134:3::10]:40457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cP8RA-0007Km-Ih
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cP8R9-0000dJ-42
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:50:36 -0500
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cP8R8-0000c9-Su
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:50:35 -0500
Received: by mail-io0-x22c.google.com with SMTP id n85so244916945ioi.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 05:50:32 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Thu, 5 Jan 2017 14:50:11 +0100
Message-ID: <CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 3/4] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Thu, Dec 22, 2016 at 10:57 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 19/12/2016 17:24, Vincent Palatin wrote:
>>  #else /* _WIN32 */
>> -    abort();
>> +    if (!qemu_cpu_is_self(cpu)) {
>> +        CONTEXT context;
>> +        if (SuspendThread(cpu->hThread) == (DWORD)(-1)) {
>> +            fprintf(stderr, "qemu:%s: GetLastError:%lu\n", __func__,
>> +                    GetLastError());
>> +            exit(1);
>> +        }
>> +
>> +        /* On multi-core systems, we are not sure that the thread is actually
>> +         * suspended until we can get the context.
>> +         */
>> +        context.ContextFlags = CONTEXT_CONTROL;
>> +        while (GetThreadContext(cpu->hThread, &context) != 0) {
>> +            continue;
>> +        }
>> +
>> +        if (hax_enabled()) {
>> +            cpu->exit_request = 1;
>> +        }
>
> As mentioned in the reply to patch 4, please leave the cpu->exit_request
> = 1 assignment to the caller.

Sorry I missed it.
I move it to qemu_cpu_kick() as asked in the Darwin patch.

>
> Apart from the above change, can you check if there are some less
> heavyeight methods to force an exit?  I can think of QueueUserAPC with
> an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_fn
> before qemu_wait_io_event_common.


Actually I don't know a good test case to verify such a change, any advice ?


>
>> +        if (ResumeThread(cpu->hThread) == (DWORD)(-1)) {
>> +            fprintf(stderr, "qemu:%s: GetLastError:%lu\n", __func__,
>> +                    GetLastError());
>> +            exit(1);
>> +        }
>> +    }
>
> [...]
>
>>
>> +            /*
>> +             * In Hax, the qemu allocate the virtual address, and HAX kernel
>> +             * populate the memory with physical memory. Currently we have no
>> +             * paging, so user should make sure enough free memory in advance
>> +             */
>> +            if (hax_enabled()) {
>> +                int ret;
>> +                ret = hax_populate_ram((uint64_t)(uintptr_t)new_block->host,
>> +                                       new_block->max_length);
>> +                if (ret < 0) {
>> +                    error_setg(errp, "Hax failed to populate ram");
>> +                    return;
>> +                }
>> +            }
>> +
>
> Can you check if the interface at
> http://marc.info/?l=qemu-devel&m=148225154320642&q=raw would be good for
> your purposes, and if so include that patch in your v6?

Seems to work, updated for v6.

-- 
Vincent
