Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWOrn-0001RJ-RL
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWOrm-0001Rs-OA
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:24:55 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWOrm-0001Rl-9j
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:24:54 -0400
Received: by mail-oi0-x244.google.com with SMTP id 14-v6so6640064oie.3
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:24:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529684183-17385-1-git-send-email-cota@braap.org>
References: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
	<1529684183-17385-1-git-send-email-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 17:24:33 +0100
Message-ID: <CAFEAcA8t7xJQCANL9OLbujuVp0MFX+Z0-_xsQ8iH4YQh2+SNpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: fix --disable-tcg build breakage
 introduced by tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 22 June 2018 at 17:16, Emilio G. Cota <cota@braap.org> wrote:
> Tested to build x86_64-softmmu and i386-softmmu targets.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/stubs/tcg-stub.c | 4 ----
>  exec.c                 | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)

This still doesn't link for me:

  LINK    x86_64-softmmu/qemu-system-x86_64
exec.o: In function `tlb_reset_dirty_range_all':
/home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:1334: undefined
reference to `tlb_reset_dirty'
exec.o: In function `tcg_commit':
/home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:3056: undefined
reference to `cpu_reloading_memory_map'
cpus.o: In function `tcg_cpu_exec':
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1362: undefined
reference to `cpu_exec'
cpus.o: In function `qemu_tcg_rr_cpu_thread_fn':
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1401: undefined
reference to `tcg_register_thread'
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1471: undefined
reference to `cpu_exec_step_atomic'
cpus.o: In function `qemu_tcg_cpu_thread_fn':
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1637: undefined
reference to `tcg_register_thread'
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1673: undefined
reference to `cpu_exec_step_atomic'
cpus.o: In function `qemu_tcg_init_vcpu':
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1865: undefined
reference to `tcg_region_init'
/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1875: undefined
reference to `parallel_cpus'
collect2: error: ld returned 1 exit status

Configured with --target-list=x86_64-softmmu --enable-debug --disable-tcg

It's probably the --enable-debug that makes the difference:
for instance cpu_reloading_memory_map() is referenced from
tcg_commit(), which is only called from within an "if (tcg_enabled())"
guard; with debug disabled the compiler probably figures out that
tcg_commit() is unreachable and doesn't put it in the .o file.

Possibly this has always been broken and wasn't a regression?
If so I guess we should apply your patch and then fix this
separately...

thanks
-- PMM
