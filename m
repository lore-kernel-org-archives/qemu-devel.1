Received: from eggs.gnu.org ([2001:4830:134:3::10]:45421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1cnkC6-0002up-TH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1cnkC1-0001yw-B1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:00:46 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:32881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1cnkC1-0001yY-4l
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:00:41 -0400
Received: by mail-io0-x236.google.com with SMTP id f84so100505948ioj.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:00:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f191552b-88c8-e5d4-b7b7-953a201971b4@redhat.com>
References: <20170314100838.12647-1-roman.penyaev@profitbricks.com>
	<20170314100838.12647-2-roman.penyaev@profitbricks.com>
	<f191552b-88c8-e5d4-b7b7-953a201971b4@redhat.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Tue, 14 Mar 2017 12:00:19 +0100
Message-ID: <CAJrWOzCXEz=c_oR-TX2pSHcLEj6VX_m5OywkhOs2v-p-jKX6aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/1] scripts/qemugdb/coroutine.py: get
 pthread pointer from '(gdb) thread info $id' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Mar 14, 2017 at 11:21 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 14/03/2017 11:08, Roman Pen wrote:
>> For sure under corefile debugging it is not possible to invoke
>> any syscalls, like arch_prctl(), so avoid doing that.  That will
>> simplify the script.
>
> Is the issue that start_thread only works in the main thread stack (i.e.
> not on coroutines)?

In my case I simply do not have libc6-dbg around.  And yes, what
you've mentioned is also the issue.

>
>> +    num = gdb.selected_thread().num
>> +    thr = gdb.execute('info thread %d' % num, to_string=True)
>
> What versions of gdb support gdb.execute?

Seems the beginning of python support in gdb (starting from gdb-7, right?).
At least git blame shows me this modification date on particular function:

d57a3c85f6eee (Thiago Jung Bauermann 2008-08-06 19:41:33 +0000 315)
execute_gdb_command (PyObject *self, PyObject *args)

and gdb-7 was released on October 06, 2009.

> Also, what happens if localization is in effect?

According to the gdb sources (I am not gdb developer, but this is quite
straightforward to find) this is not the issue.

What is the issue is that different targets output different lines.
Linux is always the same, no worries, take a look

   gdb/linux-thread-db.c: thread_db_pid_to_str():
        snprintf (buf, sizeof (buf), "Thread 0x%lx (LWP %ld)",

but e.g. bsd output should be different:

   gdb/bsd-uthread.c: bsd_uthread_pid_to_str():
        xsnprintf (buf, sizeof buf, "process %d, thread 0x%lx",

If this is the issue I can add third variant of getting correct
pthread_self() and make the priority:

  1. parse 'info thread'
  2. parse 'start_thread(arg=XXX)'
  3. go to arch_prctl() invocation.

But frankly this is far from simplification, from what I've started :)

--
Roman
