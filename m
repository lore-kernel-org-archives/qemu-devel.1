Received: from eggs.gnu.org ([209.51.188.92]:45614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1gmLAo-0002LF-No
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lcapitulino@redhat.com>) id 1gmLAn-0005se-VN
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:14:42 -0500
Date: Wed, 23 Jan 2019 11:04:17 -0500
From: Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <20190123110417.69e41c38@doriath>
In-Reply-To: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, dgilbert@redhat.com

On Wed, 23 Jan 2019 16:48:49 +0100
Max Reitz <mreitz@redhat.com> wrote:

> Hi,
> 
> When running 169 in parallel (e.g. like so:
> 
> $ while TEST_DIR=/tmp/t0 ./check -T -qcow2 169; do; done
> $ while TEST_DIR=/tmp/t1 ./check -T -qcow2 169; do; done
> $ while TEST_DIR=/tmp/t2 ./check -T -qcow2 169; do; done
> $ while TEST_DIR=/tmp/t3 ./check -T -qcow2 169; do; done
> 
> in four different shells), I get aborts:

OK, is this part of a test-suite that's also running migration
tests in parallel or in sequence? In other words, what does
iotests have to do with migration (sorry if this is stupid
question, but it's been years I don't do qemu).

More below.

[...]

> The backtrace always goes like this:
> 
> (gdb) bt
> #0  0x00007f0acf5cc53f in raise () at /lib64/libc.so.6
> #1  0x00007f0acf5b6895 in abort () at /lib64/libc.so.6
> #2  0x000055a46ebbb1a6 in runstate_set (new_state=RUN_STATE_POSTMIGRATE)
> at vl.c:742
> #3  0x000055a46ebbb1a6 in runstate_set
> (new_state=new_state@entry=RUN_STATE_POSTMIGRATE) at vl.c:730
> #4  0x000055a46ed39129 in migration_iteration_finish (s=0x55a4708be000)
> at migration/migration.c:2972
> #5  0x000055a46ed39129 in migration_thread
> (opaque=opaque@entry=0x55a4708be000) at migration/migration.c:3130
> #6  0x000055a46eea665a in qemu_thread_start (args=<optimized out>) at
> util/qemu-thread-posix.c:502
> 
> 
> #7  0x00007f0acf76258e in start_thread () at /lib64/libpthread.so.0
> #8  0x00007f0acf6916a3 in clone () at /lib64/libc.so.6
> (gdb) frame 2
> #2  0x000055a46ebbb1a6 in runstate_set (new_state=RUN_STATE_POSTMIGRATE)
> at vl.c:742
> 742             abort();
> (gdb) print current_run_state
> $1 = RUN_STATE_RUNNING
> 
> 
> Neither of migration or runstates are my strong suite, so I thought I'd
> report it before diving into it.

So, the problem seems to be that qemu is going from running state to
postmigrate state. IIRC, this is is an invalid state transition. The
valid states to transition to depends if this guest is the source or
target for migration.

When this happened in the past it meant some QEMU code skipped a
transition, but I can't tell what this has to do with iotests.
