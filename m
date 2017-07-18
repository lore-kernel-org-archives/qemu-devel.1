Received: from eggs.gnu.org ([2001:4830:134:3::10]:47127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXKlP-0005gV-Ed
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXKlM-0002rL-7B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:09:39 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXKlL-0002qy-VR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:09:36 -0400
Received: by mail-pg0-x241.google.com with SMTP id v190so1397479pgv.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 22:09:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-44-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0424e774-a832-5172-11a6-b36b412055e3@twiddle.net>
Date: Mon, 17 Jul 2017 19:09:28 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-44-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 43/45] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> +#ifdef CONFIG_SOFTMMU
> +/*
> + * It is likely that some vCPUs will translate more code than others, so we
> + * first try to set more regions than smp_cpus, with those regions being
> + * larger than the minimum code_gen_buffer size. If that's not possible we
> + * make do by evenly dividing the code_gen_buffer among the vCPUs.
> + */
> +void softmmu_tcg_region_init(void)
> +{
> +    size_t i;
> +
> +    /* Use a single region if all we have is one vCPU thread */
> +    if (smp_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
> +        tcg_region_init(0);
> +        return;
> +    }
> +
> +    for (i = 8; i > 0; i--) {
> +        size_t regions_per_thread = i;
> +        size_t region_size;
> +
> +        region_size = tcg_init_ctx.code_gen_buffer_size;
> +        region_size /= smp_cpus * regions_per_thread;
> +
> +        if (region_size >= 2 * MIN_CODE_GEN_BUFFER_SIZE) {
> +            tcg_region_init(smp_cpus * regions_per_thread);
> +            return;
> +        }
> +    }
> +    tcg_region_init(smp_cpus);
> +}
> +#endif

Any reason this code wouldn't just live in tcg_region_init?
It would certainly simplify the interface.

In particular it appears to be a mistake to ever call with n_regions == 0, 
since it's just as easy to call with n_regions == 1.

> diff --git a/cpus.c b/cpus.c
> index 14bb8d5..5455819 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1664,6 +1664,18 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
>       char thread_name[VCPU_THREAD_NAME_SIZE];
>       static QemuCond *single_tcg_halt_cond;
>       static QemuThread *single_tcg_cpu_thread;
> +    static int tcg_region_inited;
> +
> +    /*
> +     * Initialize TCG regions--once, of course. Now is a good time, because:
> +     * (1) TCG's init context, prologue and target globals have been set up.
> +     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
> +     *     -accel flag is processed, so the check doesn't work then).
> +     */
> +    if (!tcg_region_inited) {
> +        softmmu_tcg_region_init();
> +        tcg_region_inited = 1;
> +    }

Nit: Do not require the compiler to hold the address of the global across 
another call, or recompute it.  Generically this pattern is better as

   if (!flag) {
     flag = true;
     do_init();
   }

unless there's some compelling threaded reason to delay the set of the flag. 
Which is not the case here.

> +/* Call from a safe-work context */
> +void tcg_region_reset_all(void)
> +{
> +    unsigned int i;
> +
> +    qemu_mutex_lock(&region.lock);
> +    region.current = 0;
> +    region.n_full = 0;
> +
> +    for (i = 0; i < n_tcg_ctxs; i++) {
> +        if (unlikely(tcg_region_initial_alloc__locked(tcg_ctxs[i]))) {
> +            tcg_abort();
> +        }

Nit: I prefer

   bool ok = foo();
   assert(ok);

over

   if (!foo())
     abort();

> +static void tcg_region_set_guard_pages(void)
> +{
> +    size_t guard_size = qemu_real_host_page_size;
> +    size_t i;
> +
> +    for (i = 0; i < region.n; i++) {
> +        void *guard = region.buf + region.size + i * (region.size + guard_size);
> +
> +        if (qemu_mprotect_none(guard, qemu_real_host_page_size)) {

If you're going to have the local variable at all, guard_size here too.

> +            tcg_abort();
> +        }
> +    }
> +}
> +
> +/*
> + * Initializes region partitioning, setting the number of regions via
> + * @n_regions.
> + * Set @n_regions to 0 or 1 to use a single region that uses all of
> + * code_gen_buffer.
> + *
> + * Called at init time from the parent thread (i.e. the one calling
> + * tcg_context_init), after the target's TCG globals have been set.
> + *
> + * Region partitioning works by splitting code_gen_buffer into separate regions,
> + * and then assigning regions to TCG threads so that the threads can translate
> + * code in parallel without synchronization.
> + */
> +void tcg_region_init(size_t n_regions)
> +{
> +    void *buf = tcg_init_ctx.code_gen_buffer;
> +    size_t size = tcg_init_ctx.code_gen_buffer_size;
> +
> +    if (!n_regions) {
> +        n_regions = 1;
> +    }
> +
> +    /* start on a page-aligned address */
> +    buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
> +    if (unlikely(buf > tcg_init_ctx.code_gen_buffer + size)) {
> +        tcg_abort();
> +    }

assert.

> +    /* discard that initial portion */
> +    size -= buf - tcg_init_ctx.code_gen_buffer;
> +
> +    /* make region.size a multiple of page_size */
> +    region.size = size / n_regions;
> +    region.size &= qemu_real_host_page_mask;

QEMU_ALIGN_DOWN.

> +
> +    /* A region must have at least 2 pages; one code, one guard */
> +    if (unlikely(region.size < 2 * qemu_real_host_page_size)) {
> +        tcg_abort();
> +    }

assert.

> +
> +    /* do not count the guard page in region.size */
> +    region.size -= qemu_real_host_page_size;
> +    region.n = n_regions;
> +    region.buf = buf;
> +    tcg_region_set_guard_pages();

I think it would be clearer to inline the subroutine.  I was asking myself why 
we weren't subtracting the guard_size from region->size.


r~
