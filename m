Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWNFA-0005C8-LK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWNF9-0002Wj-HU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:40:56 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:32799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWNF9-0002WY-CE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:40:55 -0400
Received: by mail-ot0-x242.google.com with SMTP id h6-v6so7759617otj.0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jUTAZmYrkvrS60PSqiiWc2sw20GvQnY+-bbXjvvMz7A@mail.gmail.com>
References: <20180621143715.27176-1-richard.henderson@linaro.org>
	<CAFEAcA9dGUOLhxHr+AYHCfTvStM+M7DLVBiHEmnDzpX38aggBw@mail.gmail.com>
	<CAFEAcA8jUTAZmYrkvrS60PSqiiWc2sw20GvQnY+-bbXjvvMz7A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 15:40:33 +0100
Message-ID: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2.5 00/19] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>

On 22 June 2018 at 13:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 June 2018 at 09:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 21 June 2018 at 15:37, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> The following changes since commit 42747d6abb5035473e5585fa17620c1e8983a70b:
>>>
>>>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-06-15.for-upstream' into staging (2018-06-15 17:28:37 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180615
>>>
>>> for you to fetch changes up to 9f754620651d3432114f4bb89c7f12cbea814b3e:
>>>
>>>   tcg: Reduce max TB opcode count (2018-06-15 09:39:53 -1000)
>>>
>>> ----------------------------------------------------------------
>>> TCG patch queue:
>>>
>>> Workaround macos assembler lossage.
>>> Eliminate tb_lock.
>>> Fix TB code generation overflow.
>>>
>> Applied, thanks.
>
> ...looks like it's broken builds with --disable-tcg, though.
> Travis builds with that config fail:
>
> /home/travis/build/qemu/qemu/accel/stubs/tcg-stub.c:24:6: error: no
> previous prototype for "tb_unlock" [-Werror=missing-prototypes]
>  void tb_unlock(void)
>       ^
> cc1: all warnings being treated as errors
>
> (sample failing job log: https://api.travis-ci.org/v3/job/395399220/log.txt)
>
> Should just be a matter of deleting the stub function, I guess.

Hmm, not quite that easy. After that the link fails:

  LINK    x86_64-softmmu/qemu-system-x86_64
exec.o: In function `tlb_reset_dirty_range_all':
/home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:1334: undefined
reference to `tlb_reset_dirty'
exec.o: In function `memory_notdirty_write_complete':
/home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:2658: undefined
reference to `page_collection_unlock'
exec.o: In function `tcg_commit':
/home/petmay01/linaro/qemu-from-laptop/qemu/exec.c:3052: undefined
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

Some of those are probably best handled with stub functions
(eg tcg_register_thread()), but some of them might be better
off handled by guarding functions with #ifndef CONFIG_TCG
or moving them to source files in accel/tcg ?

This is probably best fixed by somebody familiar with the
commits in question...

thanks
-- PMM
