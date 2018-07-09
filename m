Received: from eggs.gnu.org ([2001:4830:134:3::10]:45472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcWUL-0004Oj-Kd
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcWUK-00014C-Na
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:46:01 -0400
Date: Mon, 9 Jul 2018 15:45:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180709154549.7df475b9.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi,

I recently noticed that iotest 147 was hanging on my laptop, but worked
fine on my s390x LPAR. Turned out that the architecture was a red
herring; on both platforms, things fail with the 'simple' trace backend
and work with e.g. the 'log' trace backend. Some details on the
failures with the 'simple' backend:

- The first run of 147 passes. However, there are two processes hanging
  around, one using a unix socket and one using an inet socket:

cohuck   22912  0.0  0.0 156580  3836 ?        Ss   14:32   0:00 /home/cohuck/git/qemu/build/tests/qemu-iotests/../../qemu-nbd --fork -f qcow2 /home/cohuck/git/qemu/build/tests/qemu-iotests/scratch/test.img -p 10811
cohuck   22925  0.0  0.0 156580  3840 ?        Ss   14:32   0:00 /home/cohuck/git/qemu/build/tests/qemu-iotests/../../qemu-nbd --fork -f qcow2 /home/cohuck/git/qemu/build/tests/qemu-iotests/scratch/test.img -k /home/cohuck/git/qemu/build/tests/qemu-iotests/scratch/nbd.socket

Attaching a gdb shows that we seem to be waiting on flushing:

(gdb) bt
#0  0x00007f461c078b99 in syscall () from /lib64/libc.so.6
#1  0x00007f461d13650f in g_cond_wait () from /lib64/libglib-2.0.so.0
#2  0x0000560cf3a1caf2 in flush_trace_file (wait=255)
    at /home/cohuck/git/qemu/trace/simple.c:139
#3  st_flush_trace_buffer () at /home/cohuck/git/qemu/trace/simple.c:374
#4  0x00007f461bfc01d8 in __run_exit_handlers () from /lib64/libc.so.6
#5  0x00007f461bfc022a in exit () from /lib64/libc.so.6
#6  0x0000560cf392eb7e in main (argc=<optimized out>, argv=<optimized out>)
    at /home/cohuck/git/qemu/qemu-nbd.c:1076

(for both processes)

- When I'm running 147 again, the test using the inet socket is unhappy
  as the port is already in use:

test_inet (__main__.QemuNBD) ... DEBUG:QMP:>>> {'execute': 'qmp_capabilities'}
DEBUG:QMP:<<< {u'return': {}}
Failed to find an available port: Address already in use

...but then it sits there, with ps showing a zombie qemu-nbd process,
until I Ctrl-C out of it. There's now a new qemu-nbd process (command
line identical to the first process above), and it's hanging with the
same backtrace (so same root problem, presumably). I would have
expected 147 to either fail or continue, though, instead of hanging
around.

Running under Fedora 27, current QEMU master.
