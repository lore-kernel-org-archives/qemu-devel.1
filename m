Received: from eggs.gnu.org ([209.51.188.92]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hC3PC-0004mp-Md
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hC3Ja-00087q-O3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:26:04 -0400
Date: Thu, 4 Apr 2019 16:25:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190404162555.0a2267ee@redhat.com>
In-Reply-To: <1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Daniel P.
	=?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, like.xu@intel.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, 29 Mar 2019 16:48:38 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  accel/kvm/kvm-all.c      |  3 +++
>  backends/hostmem.c       |  4 ++++
>  cpus.c                   |  4 ++++
>  exec.c                   |  2 ++
>  gdbstub.c                |  7 ++++++-
>  hw/cpu/core.c            |  3 +++
>  hw/smbios/smbios.c       | 11 +++++++++++
>  migration/postcopy-ram.c |  7 +++++++
>  numa.c                   |  1 +
>  tcg/tcg.c                | 15 +++++++++++++++
>  10 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 241db49..5385218 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1526,6 +1526,9 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
>  static int kvm_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> +    unsigned int max_cpus = ms->topo.max_cpus;
> +
>      static const char upgrade_note[] =
>          "Please upgrade to at least kernel 2.6.29 or recent kvm-kmod\n"
>          "(see http://sourceforge.net/projects/kvm).\n";

> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 04baf47..cecdfd5 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -222,6 +222,8 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
>  {
>      Error *local_err = NULL;
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>  
>      if (backend->force_prealloc) {
>          if (value) {
> @@ -311,6 +313,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>  {
>      HostMemoryBackend *backend = MEMORY_BACKEND(uc);
>      HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      Error *local_err = NULL;
>      void *ptr;
>      uint64_t sz;
I don't like us abusing smp_cpus for os_mem_prealloc in here as
it doesn't really have to do anything with machine and just adds
non necessary machine dependency to hostmem. And probably should
be a separate option for backend to specify a number of threads
to use for allocation.

But that's out of scope of this series, so it's fine is for now
and later we should get rid of it (which I suspect would be easier
once initial memoy also allocated by backends).

> diff --git a/cpus.c b/cpus.c
> index e83f72b..834a697 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2067,6 +2067,10 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
>  
>  void qemu_init_vcpu(CPUState *cpu)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cores = ms->topo.smp_cores;
> +    unsigned int smp_threads = ms->topo.smp_threads;

(***)
for once it probably will crash *-user builds
and secondly the purpose of getting rid of smp_foo globals
is disentangle layer violations and not replace it with another global
(qdev_get_machine()).

What should be done is to make a properties of nr_cores/nr_threads and set
them from the parent object that creates CPUs. The point is CPUs shouldn't
reach out outside itself to fish out data bits it needs, it's responsibility
of creator to feed to being create CPU needed properties.

This kind of refactoring probably deserves its own series and should precede
-smp refactoring as it doesn't depend on CpuTopology at all.

> +
>      cpu->nr_cores = smp_cores;
>      cpu->nr_threads = smp_threads;
>      cpu->stopped = true;
> diff --git a/exec.c b/exec.c
> index 86a38d3..a3c3db7 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1829,6 +1829,8 @@ static void *file_ram_alloc(RAMBlock *block,
>                              bool truncate,
>                              Error **errp)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      void *area;
>  
>      block->page_size = qemu_fd_getpagesize(fd);
> diff --git a/gdbstub.c b/gdbstub.c
> index d54abd1..35f6bbc 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -30,6 +30,7 @@
>  #include "sysemu/sysemu.h"
>  #include "exec/gdbstub.h"
>  #include "hw/cpu/cluster.h"
> +#include "hw/boards.h"
>  #endif
>  
>  #define MAX_PACKET_LENGTH 4096
> @@ -1154,11 +1155,15 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
>      CPUState *cpu;
>      GDBThreadIdKind kind;
>  #ifdef CONFIG_USER_ONLY
> -    int max_cpus = 1; /* global variable max_cpus exists only in system mode */
> +    /* global variable max_cpus exists only in system mode */
> +    unsigned int max_cpus = 1;
not related change

>  
>      CPU_FOREACH(cpu) {
>          max_cpus = max_cpus <= cpu->cpu_index ? cpu->cpu_index + 1 : max_cpus;
>      }
> +#else
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int max_cpus = ms->topo.max_cpus;
>  #endif
>      /* uninitialised CPUs stay 0 */
>      newstates = g_new0(char, max_cpus);
> diff --git a/hw/cpu/core.c b/hw/cpu/core.c
> index 7e42e2c..b75ffbb 100644
> --- a/hw/cpu/core.c
> +++ b/hw/cpu/core.c
> @@ -11,6 +11,7 @@
>  #include "qapi/visitor.h"
>  #include "qapi/error.h"
>  #include "sysemu/cpus.h"
> +#include "hw/boards.h"
>  
>  static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
> @@ -69,6 +70,8 @@ static void core_prop_set_nr_threads(Object *obj, Visitor *v, const char *name,
>  
>  static void cpu_core_instance_init(Object *obj)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_threads = ms->topo.smp_threads;
the same as [***]

>      CPUCore *core = CPU_CORE(obj);
>  
>      object_property_add(obj, "core-id", "int", core_prop_get_core_id,
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 47be907..a5eabe7 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -28,6 +28,7 @@
>  #include "hw/loader.h"
>  #include "exec/cpu-common.h"
>  #include "smbios_build.h"
> +#include "hw/boards.h"
>  
>  /* legacy structures and constants for <= 2.0 machines */
>  struct smbios_header {
> @@ -342,6 +343,9 @@ opts_init(smbios_register_config);
>  
>  static void smbios_validate_table(void)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> +
>      uint32_t expect_t4_count = smbios_legacy ? smp_cpus : smbios_smp_sockets;
>  
>      if (smbios_type4_count && smbios_type4_count != expect_t4_count) {
> @@ -571,6 +575,9 @@ static void smbios_build_type_3_table(void)
>  
>  static void smbios_build_type_4_table(unsigned instance)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_threads = ms->topo.smp_threads;
> +    unsigned int smp_cores = ms->topo.smp_cores;
>      char sock_str[128];
>  
>      SMBIOS_BUILD_TABLE_PRE(4, 0x400 + instance, true); /* required */
> @@ -843,7 +850,11 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
>                         uint8_t **tables, size_t *tables_len,
>                         uint8_t **anchor, size_t *anchor_len)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      unsigned i, dimm_cnt;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
> +    unsigned int smp_cores = ms->topo.smp_cores;
> +    unsigned int smp_threads = ms->topo.smp_threads;
>  
wrt whole smbios changes:
instead of accessing machine directly, I suggest to pass necessary values
as arguments and modify callers to provide them

>      if (smbios_legacy) {
>          *tables = *anchor = NULL;
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index e2aa57a..ae92f6e 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/balloon.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
> +#include "hw/boards.h"
>  
>  /* Arbitrary limit on size of each discard command,
>   * keeps them around ~200 bytes
> @@ -128,6 +129,8 @@ static void migration_exit_cb(Notifier *n, void *data)
>  
>  static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
>      ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
>      ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
> @@ -141,6 +144,8 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>  
>  static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      uint32List *list = NULL, *entry = NULL;
>      int i;
>  
> @@ -806,8 +811,10 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>  static void mark_postcopy_blocktime_end(uintptr_t addr)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>      int i, affected_cpu = 0;
> +    unsigned int smp_cpus = ms->topo.smp_cpus;
>      bool vcpu_total_blocktime = false;
>      uint32_t read_vcpu_time, low_time_offset;

I don't know enough about migration to say some thing useful here,
CCin David for comments.

>  
> diff --git a/numa.c b/numa.c
> index 3875e1e..127ddbe 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -64,6 +64,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      uint16_t nodenr;
>      uint16List *cpus = NULL;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    unsigned int max_cpus = ms->topo.max_cpus;
>  
>      if (node->has_nodeid) {
>          nodenr = node->nodeid;
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 9b2bf7f..d1501eb 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -44,6 +44,10 @@
>  #include "exec/cpu-common.h"
>  #include "exec/exec-all.h"
>  
> +#if !defined(CONFIG_USER_ONLY)
> +#include "hw/boards.h"
> +#endif
> +
>  #include "tcg-op.h"
>  
>  #if UINTPTR_MAX == UINT32_MAX
> @@ -602,6 +606,10 @@ static size_t tcg_n_regions(void)
>      size_t i;
>  
>      /* Use a single region if all we have is one vCPU thread */
> +#if !defined(CONFIG_USER_ONLY)
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int max_cpus = ms->topo.max_cpus;
> +#endif
>      if (max_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
>          return 1;
>      }
> @@ -751,7 +759,12 @@ void tcg_register_thread(void)
>  
>      /* Claim an entry in tcg_ctxs */
>      n = atomic_fetch_inc(&n_tcg_ctxs);
> +#if !defined(CONFIG_USER_ONLY)
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    g_assert(n < ms->topo.max_cpus);
> +#elif
>      g_assert(n < max_cpus);
> +#endif
>      atomic_set(&tcg_ctxs[n], s);
>  
>      tcg_ctx = s;
> @@ -961,6 +974,8 @@ void tcg_context_init(TCGContext *s)
>      tcg_ctxs = &tcg_ctx;
>      n_tcg_ctxs = 1;
>  #else
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int max_cpus = ms->topo.max_cpus;
>      tcg_ctxs = g_new(TCGContext *, max_cpus);
>  #endif

not sure what to in case of accelerators (TCG/KVM/...), as their code
eventually endups being used by cpus. Passing smp information down
from CPU would be a pain and might not work in every case. Maybe
we should pass it as part of configure_accelerator()
