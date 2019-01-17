Received: from eggs.gnu.org ([209.51.188.92]:52782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCAf-0007E3-7u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCAd-00033R-UL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:13:41 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkCAd-0002mc-C2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:13:39 -0500
Received: by mail-ot1-x332.google.com with SMTP id k98so11987099otk.3
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20190107163117.16269-1-peter.maydell@linaro.org>
	<20190107163117.16269-7-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-7-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 18:13:16 +0000
Message-ID: <CAFEAcA9-rLt5H_+qci8tMZ5p67i56VYfow5ZJZyKUjrYftr3gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 06/37] gdbstub: add multiprocess support to
 'H' and 'T' packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Luc Michel <luc.michel@greensocs.com>

On Mon, 7 Jan 2019 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Luc Michel <luc.michel@greensocs.com>
>
> Add a couple of helper functions to cope with GDB threads and processes.
>
> The gdb_get_process() function looks for a process given a pid.
>
> The gdb_get_cpu() function returns the CPU corresponding to the (pid,
> tid) pair given as parameters.
>
> The read_thread_id() function parses the thread-id sent by the peer.
> This function supports the multiprocess extension thread-id syntax.  The
> return value specifies if the parsing failed, or if a special case was
> encountered (all processes or all threads).
>
> Use them in 'H' and 'T' packets handling to support the multiprocess
> extension.

> +static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
> +{
> +    GDBProcess *process;
> +    CPUState *cpu;
> +
> +    if (!tid) {
> +        /* 0 means any thread, we take the first one */
> +        tid = 1;
> +    }
> +
> +    cpu = find_cpu(tid);
> +
> +    if (cpu == NULL) {
> +        return NULL;
> +    }
> +
> +    process = gdb_get_cpu_process(s, cpu);
> +
> +    if (process->pid != pid) {
> +        return NULL;
> +    }
> +
> +    if (!process->attached) {
> +        return NULL;
> +    }
> +
> +    return cpu;
> +}

I'm finding that (with my out-of-tree board model) gdb
asks for "process 0 thread 0", which should mean "anything you
like", so we end up calling gdb_get_cpu(s, 0, 0). Then we
find a CPU via its TID, and of course it has some specific
PID in process->pid which is not zero, so we fail the
"process->pid != pid" test and return NULL here incorrectly.

Should that check be
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -736,7 +736,8 @@ static CPUState *gdb_get_cpu(const GDBState *s,
uint32_t pid, uint32_t tid)

     process = gdb_get_cpu_process(s, cpu);

-    if (process->pid != pid) {
+    /* pid == 0 means any process, so this one is fine */
+    if (pid != 0 && process->pid != pid) {
         return NULL;
     }

?

thanks
-- PMM
