Received: from eggs.gnu.org ([2001:4830:134:3::10]:54358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfJw-0008Pt-TB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gJfJp-0003Ph-Dh
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:53:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gJfJk-0003Hf-9u
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:53:28 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181101101715.9443-10-fli@suse.com> (Fei Li's message of "Thu,
	1 Nov 2018 18:17:15 +0800")
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-10-fli@suse.com>
Reply-To: quintela@redhat.com
Date: Mon, 05 Nov 2018 14:53:12 +0100
Message-ID: <877ehrvdfb.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v7 9/9] qemu_thread_create: propagate
 the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, peterx@redhat.com

Fei Li <fli@suse.com> wrote:
> Make qemu_thread_create() return a Boolean to indicate if it succeeds
> rather than failing with an error. And add an Error parameter to hold
> the error message and let the callers handle it.

Nice work, thanks.


> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  cpus.c                      | 45 ++++++++++++++++++++++++-------------
>  dump.c                      |  6 +++--
>  hw/misc/edu.c               |  6 +++--
>  hw/ppc/spapr_hcall.c        | 10 +++++++--
>  hw/rdma/rdma_backend.c      |  4 +++-
>  hw/usb/ccid-card-emulated.c | 15 +++++++++----
>  include/qemu/thread.h       |  4 ++--
>  io/task.c                   |  3 ++-
>  iothread.c                  | 16 +++++++++-----
>  migration/migration.c       | 54 +++++++++++++++++++++++++++++----------------
>  migration/postcopy-ram.c    | 14 ++++++++++--
>  migration/ram.c             | 41 +++++++++++++++++++++++++---------
>  migration/savevm.c          | 11 ++++++---
>  tests/atomic_add-bench.c    |  3 ++-
>  tests/iothread.c            |  2 +-
>  tests/qht-bench.c           |  3 ++-
>  tests/rcutorture.c          |  3 ++-
>  tests/test-aio.c            |  2 +-
>  tests/test-rcu-list.c       |  3 ++-
>  ui/vnc-jobs.c               | 17 +++++++++-----
>  ui/vnc-jobs.h               |  2 +-
>  ui/vnc.c                    |  4 +++-
>  util/compatfd.c             | 12 ++++++++--
>  util/oslib-posix.c          | 17 ++++++++++----
>  util/qemu-thread-posix.c    | 24 +++++++++++++-------
>  util/qemu-thread-win32.c    | 16 ++++++++++----
>  util/rcu.c                  |  3 ++-
>  util/thread-pool.c          |  4 +++-
>  28 files changed, 243 insertions(+), 101 deletions(-)
>
> diff --git a/cpus.c b/cpus.c
> index ed71618e1f..0510f90e06 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1949,15 +1949,20 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
>              snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
>                   cpu->cpu_index);
>  
> -            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
> -                               cpu, QEMU_THREAD_JOINABLE);
> +            if (!qemu_thread_create(cpu->thread, thread_name,
> +                                    qemu_tcg_cpu_thread_fn, cpu,
> +                                    QEMU_THREAD_JOINABLE, errp)) {

I think that in this cases where you are not handling the error, you
should use an exit() here.  We can't continue.

I am not saying that you need to fix all the places that call
qmeu_thread_create() to handle the error gracefully, but in the places
where you don't do, you should just exit.

I.e. this patch should be split in something that does:

-   qemu_thread_create(...., errp);
+   if (!qemu_thread_create(..., errp))  {
+      error_report_err(errp);
+      exit(1);
+   }

So, we can fix any caller independtly from here.
Otherwise, we are ignoring an important error.

What do you think?

Later, Juan.
