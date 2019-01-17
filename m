Received: from eggs.gnu.org ([209.51.188.92]:58401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCGh-00049n-Ir
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCGd-0006NE-LO
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:19:53 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:42733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkCGa-0005qK-3g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:19:48 -0500
Received: by mail-oi1-x22c.google.com with SMTP id w13so6899892oiw.9
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20190107163117.16269-1-peter.maydell@linaro.org>
	<20190107163117.16269-7-peter.maydell@linaro.org>
	<CAFEAcA9-rLt5H_+qci8tMZ5p67i56VYfow5ZJZyKUjrYftr3gw@mail.gmail.com>
In-Reply-To: <CAFEAcA9-rLt5H_+qci8tMZ5p67i56VYfow5ZJZyKUjrYftr3gw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 18:19:20 +0000
Message-ID: <CAFEAcA9L3PigRydywfwwtx-wjjJ0-nhKRzOxZ1qPDSJaphrquA@mail.gmail.com>
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

On Thu, 17 Jan 2019 at 18:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 7 Jan 2019 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: Luc Michel <luc.michel@greensocs.com>
> >
> > Add a couple of helper functions to cope with GDB threads and processes.
> >
> > The gdb_get_process() function looks for a process given a pid.
> >
> > The gdb_get_cpu() function returns the CPU corresponding to the (pid,
> > tid) pair given as parameters.
> >
> > The read_thread_id() function parses the thread-id sent by the peer.
> > This function supports the multiprocess extension thread-id syntax.  The
> > return value specifies if the parsing failed, or if a special case was
> > encountered (all processes or all threads).
> >
> > Use them in 'H' and 'T' packets handling to support the multiprocess
> > extension.
>
> > +static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
> > +{
> > +    GDBProcess *process;
> > +    CPUState *cpu;
> > +
> > +    if (!tid) {
> > +        /* 0 means any thread, we take the first one */
> > +        tid = 1;
> > +    }
> > +
> > +    cpu = find_cpu(tid);
> > +
> > +    if (cpu == NULL) {
> > +        return NULL;
> > +    }
> > +
> > +    process = gdb_get_cpu_process(s, cpu);
> > +
> > +    if (process->pid != pid) {
> > +        return NULL;
> > +    }
> > +
> > +    if (!process->attached) {
> > +        return NULL;
> > +    }
> > +
> > +    return cpu;
> > +}
>
> I'm finding that (with my out-of-tree board model) gdb
> asks for "process 0 thread 0", which should mean "anything you
> like", so we end up calling gdb_get_cpu(s, 0, 0). Then we
> find a CPU via its TID, and of course it has some specific
> PID in process->pid which is not zero, so we fail the
> "process->pid != pid" test and return NULL here incorrectly.

Also, the "use TID 1 if asked for any-task" logic assumes
that TID 1 is actually part of the requested process and
that that task is attached. Shouldn't we instead find the
requested process (or any random attached process, if tid == 0)
and then pick one of the TIDs it has?

thanks
-- PMM
