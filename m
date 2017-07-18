Received: from eggs.gnu.org ([2001:4830:134:3::10]:50217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG14-00050w-3G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG12-00048H-Pk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:05:30 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXG12-00047p-KD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:05:28 -0400
Received: by mail-qk0-x244.google.com with SMTP id d136so631025qkg.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:05:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-29-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4bf3acbe-1996-37ab-fba5-a37c30ac6cc9@twiddle.net>
Date: Mon, 17 Jul 2017 14:05:23 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-29-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/45] translate-all: use a binary
 search tree to track TBs in TBContext
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
> This is a prerequisite for supporting multiple TCG contexts, since
> we will have threads generating code in separate regions of
> code_gen_buffer.
> 
> For this we need a new field (.size) in struct tb_tc to keep
> track of the size of the translated code. This field adds a 4-byte
> hole to the struct (and therefore to TranslationBlock), but we can
> live with that.
> 
> The comparison function we use is optimized for the common case:
> insertions. Profiling shows that upon booting debian-arm, 98%
> of comparisons are between existing tb's (i.e. a->size and b->size
> are both !0), which happens during insertions (and removals, but
> those are rare). The remaining cases are lookups. From reading the glib
> sources we see that the first key is always the lookup key. However,
> the code does not assume this to always be the case because this
> behaviour is not guaranteed in the glib docs. However, we embed
> this knowledge in the code as a branch hint for the compiler.
> 
> Note that tb_free does not free space in the code_gen_buffer anymore,
> since we cannot easily know whether the tb is the last one inserted
> in code_gen_buffer. The next patch in this series renames tb_free
> to tb_remove to reflect this.
> 
> Performance-wise, lookups in tb_find_pc are the same as before:
> O(log n). However, insertions are O(log n) instead of O(1), which
> results in a small slowdown when booting debian-arm:
> 
> Performance counter stats for 'build/arm-softmmu/qemu-system-arm \
> 	-machine type=virt -nographic -smp 1 -m 4096 \
> 	-netdev user,id=unet,hostfwd=tcp::2222-:22 \
> 	-device virtio-net-device,netdev=unet \
> 	-drive file=img/arm/jessie-arm32.qcow2,id=myblock,index=0,if=none \
> 	-device virtio-blk-device,drive=myblock \
> 	-kernel img/arm/aarch32-current-linux-kernel-only.img \
> 	-append console=ttyAMA0 root=/dev/vda1 \
> 	-name arm,debug-threads=on -smp 1' (10 runs):
> 
> - Before:
> 
>         8048.598422      task-clock (msec)         #    0.931 CPUs utilized            ( +-  0.28% )
>              16,974      context-switches          #    0.002 M/sec                    ( +-  0.12% )
>                   0      cpu-migrations            #    0.000 K/sec
>              10,125      page-faults               #    0.001 M/sec                    ( +-  1.23% )
>      35,144,901,879      cycles                    #    4.367 GHz                      ( +-  0.14% )
>     <not supported>      stalled-cycles-frontend
>     <not supported>      stalled-cycles-backend
>      65,758,252,643      instructions              #    1.87  insns per cycle          ( +-  0.33% )
>      10,871,298,668      branches                  # 1350.707 M/sec                    ( +-  0.41% )
>         192,322,212      branch-misses             #    1.77% of all branches          ( +-  0.32% )
> 
>         8.640869419 seconds time elapsed                                          ( +-  0.57% )
> 
> - After:
>         8146.242027      task-clock (msec)         #    0.923 CPUs utilized            ( +-  1.23% )
>              17,016      context-switches          #    0.002 M/sec                    ( +-  0.40% )
>                   0      cpu-migrations            #    0.000 K/sec
>              18,769      page-faults               #    0.002 M/sec                    ( +-  0.45% )
>      35,660,956,120      cycles                    #    4.378 GHz                      ( +-  1.22% )
>     <not supported>      stalled-cycles-frontend
>     <not supported>      stalled-cycles-backend
>      65,095,366,607      instructions              #    1.83  insns per cycle          ( +-  1.73% )
>      10,803,480,261      branches                  # 1326.192 M/sec                    ( +-  1.95% )
>         195,601,289      branch-misses             #    1.81% of all branches          ( +-  0.39% )
> 
>         8.828660235 seconds time elapsed                                          ( +-  0.38% )
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>   include/exec/exec-all.h   |   5 ++
>   include/exec/tb-context.h |   4 +-
>   accel/tcg/translate-all.c | 217 ++++++++++++++++++++++++----------------------
>   3 files changed, 118 insertions(+), 108 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 7356c3e..c7bf683 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -317,10 +317,15 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
>   
>   /*
>    * Translation Cache-related fields of a TB.
> + * This struct exists just for convenience; we keep track of TB's in a binary
> + * search tree, and the only fields needed to compare TB's in the tree are
> + * @ptr and @size. @search is brought here for consistency, since it is also
> + * a TC-related field.
>    */
>   struct tb_tc {
>       void *ptr;    /* pointer to the translated code */
>       uint8_t *search;  /* pointer to search data */
> +    unsigned int size;

You might as well just use size_t and avoid the hole.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
