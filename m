Received: from eggs.gnu.org ([2001:4830:134:3::10]:38677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2Uy-0001V0-Rr
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2Ux-0003Gv-L7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:39:20 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:38180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2Ux-0003Ff-DP
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:39:19 -0400
Received: by mail-ot0-x232.google.com with SMTP id 95-v6so18981916ote.5
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:39:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319194242.GQ2787@redhat.com>
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
	<CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
	<20180319194242.GQ2787@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:39:18 -0700
Message-ID: <CAHNT7Ntu=LAm2r3G8ZiGioYC_FkhArA=0kXj8SxphaFTY6rV4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Mar 19, 2018 at 12:42 PM, Richard W.M. Jones <rjones@redhat.com>
wrote:

> On Mon, Mar 19, 2018 at 11:35:51AM -0700, Michael Clark wrote:
> > The RISC-V post-merge spec conformance and cleanup series has had a lot
> of
> > testing. I've been using it to compile QEMU inside of QEMU using the
> RISC-V
> > Fedora Image and its native RISC-V GCC toolchain running inside SMP Linux
> > 4.16-rc2. It appears to be pretty rock-solid. The rcu lock fix would
> likely
> > only affect users who are ballooning memory while a guest is under load.
> > The page walker changes have also been tested under load (including
> > performance tests).
>
> Did you see the problem with restoring floating point registers on
> context switch?  The test case is quite simple:
>
>   http://oirase.annexia.org/tmp/sched.c


No I didn't. Thanks.


> Note you must compile it with gcc -O2 to manifest the bug.  (We
> originally thought it was a problem with gcc's optimization, but it
> isn't.)
>

Okay. I must admit most of my testing has been integer heavy workloads.


> In Fedora's qemu tree are carrying the following patch which is just a
> workaround:
>
>   https://github.com/rwmjones/fedora-riscv-bootstrap/blob/
> master/stage1-riscv-qemu/force-float-save.patch


I will take a look...

There were some changes around v4 of our port upstream patch series to add
MSTATUS.FS (TB_FLAGS_FP_ENABLE) to to tb->flags to avoid checking the flags
on all FP ops.

static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong
*pc,
                                        target_ulong *cs_base, uint32_t
*flags)
{
    *pc = env->pc;
    *cs_base = 0;
#ifdef CONFIG_USER_ONLY
    *flags = TB_FLAGS_FP_ENABLE;
#else
    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
#endif
}

I'll have to get my head around the implication of this or with the
privilege level and how MSTATUS.FS is currently set...
