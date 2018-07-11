Received: from eggs.gnu.org ([2001:4830:134:3::10]:52417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdFFO-0003C3-7z
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdFFN-0000am-5j
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:33:34 -0400
Date: Wed, 11 Jul 2018 15:33:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180711153321.15d2237a.cohuck@redhat.com>
In-Reply-To: <20180711151545.7e55234a.cohuck@redhat.com>
References: <20180709154549.7df475b9.cohuck@redhat.com>
	<20180711130617.GH31228@stefanha-x1.localdomain>
	<20180711151545.7e55234a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, 11 Jul 2018 15:15:45 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 11 Jul 2018 14:06:17 +0100
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
> 
> > On Mon, Jul 09, 2018 at 03:45:49PM +0200, Cornelia Huck wrote:  
> > > Hi,
> > > 
> > > I recently noticed that iotest 147 was hanging on my laptop, but worked
> > > fine on my s390x LPAR. Turned out that the architecture was a red
> > > herring; on both platforms, things fail with the 'simple' trace backend
> > > and work with e.g. the 'log' trace backend. Some details on the
> > > failures with the 'simple' backend:
> > > 
> > > - The first run of 147 passes. However, there are two processes hanging
> > >   around, one using a unix socket and one using an inet socket:
> > > 
> > > cohuck   22912  0.0  0.0 156580  3836 ?        Ss   14:32   0:00 /home/cohuck/git/qemu/build/tests/qemu-iotests/../../qemu-nbd --fork -f qcow2 /home/cohuck/git/qemu/build/tests/qemu-iotests/scratch/test.img -p 10811
> > > cohuck   22925  0.0  0.0 156580  3840 ?        Ss   14:32   0:00 /home/cohuck/git/qemu/build/tests/qemu-iotests/../../qemu-nbd --fork -f qcow2 /home/cohuck/git/qemu/build/tests/qemu-iotests/scratch/test.img -k /home/cohuck/git/qemu/build/tests/qemu-iotests/scratch/nbd.socket
> > > 
> > > Attaching a gdb shows that we seem to be waiting on flushing:
> > > 
> > > (gdb) bt
> > > #0  0x00007f461c078b99 in syscall () from /lib64/libc.so.6
> > > #1  0x00007f461d13650f in g_cond_wait () from /lib64/libglib-2.0.so.0
> > > #2  0x0000560cf3a1caf2 in flush_trace_file (wait=255)
> > >     at /home/cohuck/git/qemu/trace/simple.c:139
> > > #3  st_flush_trace_buffer () at /home/cohuck/git/qemu/trace/simple.c:374
> > > #4  0x00007f461bfc01d8 in __run_exit_handlers () from /lib64/libc.so.6
> > > #5  0x00007f461bfc022a in exit () from /lib64/libc.so.6
> > > #6  0x0000560cf392eb7e in main (argc=<optimized out>, argv=<optimized out>)
> > >     at /home/cohuck/git/qemu/qemu-nbd.c:1076
> > > 
> > > (for both processes)    
> > 
> > Please also print backtraces for the other threads:
> > 
> >   (gdb) thread apply all bt
> > 
> > There should be another thread in writeout_thread() so I'm surprised
> > that flush_trace_file() is getting stuck in g_cond_wait().  
> 
> I'll re-run to check, but there was only one thread in the process in
> question.

OK, I have two threads for one of the qemu-nbds using inet created on
the second run (when it fails with the 'port already in use' message):

(gdb) thread apply all bt

Thread 2 (Thread 0x7f639be49700 (LWP 3091)):
#0  0x00007f639d549b99 in syscall () from /lib64/libc.so.6
#1  0x00007f639e60750f in g_cond_wait () from /lib64/libglib-2.0.so.0
#2  0x00005619516d298f in wait_for_trace_records_available ()
    at /home/cohuck/git/qemu/trace/simple.c:150
#3  writeout_thread (opaque=<optimized out>)
    at /home/cohuck/git/qemu/trace/simple.c:169
#4  0x00007f639e5e9486 in g_thread_proxy () from /lib64/libglib-2.0.so.0
#5  0x00007f639d81750b in start_thread () from /lib64/libpthread.so.0
#6  0x00007f639d54f16f in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7f63a05bba40 (LWP 3090)):
#0  0x00007f639d820d68 in read () from /lib64/libpthread.so.0
#1  0x00005619515ec61c in main (argc=<optimized out>, argv=0x7ffc1220bfb8)
    at /home/cohuck/git/qemu/qemu-nbd.c:881

That one goes away after I Ctrl-C out of the hanging iotest (together
with the zombie qemu-ndb).

The other qemu-nbds (the inet and the unix socket ones from the first
run, the second inet one from the second run) have a single thread with
the same backtrace I posted above.
