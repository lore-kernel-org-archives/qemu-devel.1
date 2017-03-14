Received: from eggs.gnu.org ([2001:4830:134:3::10]:47513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkLE-0004qd-AS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkLA-0004m1-Tk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:10:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnkLA-0004kM-NA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:10:08 -0400
References: <20170314100838.12647-1-roman.penyaev@profitbricks.com>
	<20170314100838.12647-2-roman.penyaev@profitbricks.com>
	<f191552b-88c8-e5d4-b7b7-953a201971b4@redhat.com>
	<CAJrWOzCXEz=c_oR-TX2pSHcLEj6VX_m5OywkhOs2v-p-jKX6aw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0d01ca6-d991-eb4e-6488-9db9cc99bd56@redhat.com>
Date: Tue, 14 Mar 2017 12:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAJrWOzCXEz=c_oR-TX2pSHcLEj6VX_m5OywkhOs2v-p-jKX6aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Roman Penyaev <roman.penyaev@profitbricks.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>



On 14/03/2017 12:00, Roman Penyaev wrote:
> Linux is always the same, no worries, take a look
> 
>    gdb/linux-thread-db.c: thread_db_pid_to_str():
>         snprintf (buf, sizeof (buf), "Thread 0x%lx (LWP %ld)",
> 
> but e.g. bsd output should be different:
> 
>    gdb/bsd-uthread.c: bsd_uthread_pid_to_str():
>         xsnprintf (buf, sizeof buf, "process %d, thread 0x%lx",
> 
> If this is the issue I can add third variant of getting correct
> pthread_self() and make the priority:
> 
>   1. parse 'info thread'
>   2. parse 'start_thread(arg=XXX)'
>   3. go to arch_prctl() invocation.
> 
> But frankly this is far from simplification, from what I've started :)

I think it's okay.  Absence of libc debugging symbols is not an issue,
but the existing code was Linux-specific anyway and your version has
some advantages for robustness.

Paolo
