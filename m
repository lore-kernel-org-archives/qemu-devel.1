Received: from eggs.gnu.org ([2001:4830:134:3::10]:53882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx9OD-00038k-8f
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx9O9-00067Z-8o
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:20:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fx9O9-00066p-1V
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:20:53 -0400
Date: Tue, 4 Sep 2018 12:20:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180904112049.GE22349@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180904110822.12863-1-fli@suse.com>
	<20180904110822.12863-6-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180904110822.12863-6-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] Propagate qemu_thread_create's error
 to all callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org

On Tue, Sep 04, 2018 at 07:08:22PM +0800, Fei Li wrote:
> Let's propagate qemu_thread_create's error to make all callers check
> it. For those critical callers, just pass the &error_abort.
> 
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  cpus.c                      | 48 ++++++++++++++++++++++++++++++++++++++-------
>  dump.c                      |  6 +++++-
>  hw/misc/edu.c               |  8 +++++++-
>  hw/ppc/spapr_hcall.c        |  9 ++++++++-
>  hw/rdma/rdma_backend.c      |  3 ++-
>  hw/usb/ccid-card-emulated.c | 13 ++++++++++--
>  io/task.c                   |  3 ++-
>  iothread.c                  | 15 +++++++++-----
>  migration/migration.c       | 47 ++++++++++++++++++++++++++++++++------------
>  migration/postcopy-ram.c    | 11 ++++++++++-
>  migration/ram.c             | 32 ++++++++++++++++++++++++++----
>  migration/savevm.c          |  8 +++++++-
>  tests/atomic_add-bench.c    |  3 ++-
>  tests/iothread.c            |  2 +-
>  tests/qht-bench.c           |  3 ++-
>  tests/rcutorture.c          |  3 ++-
>  tests/test-aio.c            |  2 +-
>  tests/test-rcu-list.c       |  3 ++-
>  ui/vnc-jobs.c               | 11 +++++++++--
>  util/compatfd.c             |  8 +++++++-
>  util/oslib-posix.c          | 10 +++++++++-
>  util/rcu.c                  |  3 ++-
>  util/thread-pool.c          |  4 +++-
>  23 files changed, 206 insertions(+), 49 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 41efddc218..24159af1e6 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1904,6 +1904,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
>      static QemuCond *single_tcg_halt_cond;
>      static QemuThread *single_tcg_cpu_thread;
>      static int tcg_region_inited;
> +    Error *local_err = NULL;
>  
>      assert(tcg_enabled());
>      /*
> @@ -1929,14 +1930,22 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
>                   cpu->cpu_index);
>  
>              qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
> -                               cpu, QEMU_THREAD_JOINABLE);
> +                               cpu, QEMU_THREAD_JOINABLE, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }

Having to use a local error object & error_propagate calls is making this
patch larger than it needs.

I'd suggest changing qemu_thread_create() so that it returns a boolean,
so it can then do

  if (!qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
                         cpu, QEMU_THREAD_JOINABLE, errp) {
      return;
  }

avoiding the local error object & shortening the code.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
