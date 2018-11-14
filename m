Received: from eggs.gnu.org ([2001:4830:134:3::10]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMyos-0001vo-0n
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMyor-00032B-3k
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:19:14 -0500
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-6-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ac12d41-2095-f0ad-db1b-0e3ceea8f44e@redhat.com>
Date: Wed, 14 Nov 2018 18:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] accel/tcg: Return -1 for execution
 from MMIO regions in get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2018-07-10 18:00, Peter Maydell wrote:
> Now that all the callers can handle get_page_addr_code() returning -1,
> remove all the code which tries to handle execution from MMIO regions
> or small-MMU-region RAM areas. This will mean that we can correctly
> execute from these areas, rather than ending up either aborting QEMU
> or delivering an incorrect guest exception.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/cputlb.c | 95 +++++-----------------------------------------
>  1 file changed, 10 insertions(+), 85 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c491703f15f..abb0225dc79 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -741,39 +741,6 @@ void tlb_set_page(CPUState *cpu, target_ulong vadd=
r,
>                              prot, mmu_idx, size);
>  }
> =20
> -static void report_bad_exec(CPUState *cpu, target_ulong addr)
> -{
> -    /* Accidentally executing outside RAM or ROM is quite common for
> -     * several user-error situations, so report it in a way that
> -     * makes it clear that this isn't a QEMU bug and provide suggestio=
ns
> -     * about what a user could do to fix things.
> -     */
> -    error_report("Trying to execute code outside RAM or ROM at 0x"
> -                 TARGET_FMT_lx, addr);
> -    error_printf("This usually means one of the following happened:\n\=
n"
> -                 "(1) You told QEMU to execute a kernel for the wrong =
machine "
> -                 "type, and it crashed on startup (eg trying to run a =
"
> -                 "raspberry pi kernel on a versatilepb QEMU machine)\n=
"
> -                 "(2) You didn't give QEMU a kernel or BIOS filename a=
t all, "
> -                 "and QEMU executed a ROM full of no-op instructions u=
ntil "
> -                 "it fell off the end\n"
> -                 "(3) Your guest kernel has a bug and crashed by jumpi=
ng "
> -                 "off into nowhere\n\n"
> -                 "This is almost always one of the first two, so check=
 your "
> -                 "command line and that you are using the right type o=
f kernel "
> -                 "for this machine.\n"
> -                 "If you think option (3) is likely then you can try d=
ebugging "
> -                 "your guest with the -d debug options; in particular =
"
> -                 "-d guest_errors will cause the log to include a dump=
 of the "
> -                 "guest register state at this point.\n\n"
> -                 "Execution cannot continue; stopping here.\n\n");

 Hi Peter!

Looks like this patch now causes QEMU to segfault instead of printing the
above error message in certain cases, e.g.:

$ gdb --args aarch64-softmmu/qemu-system-aarch64 -M n800
[...]
(gdb) r
Starting program: aarch64-softmmu/qemu-system-aarch64 -M n800
[...]
Program received signal SIGSEGV, Segmentation fault.
[...]
(gdb) bt
#0  0x0000555555addc68 in onenand_read (opaque=3D0x555557600600, addr=3D9=
8304, size=3D4) at hw/block/onenand.c:612
#1  0x00005555558b175c in memory_region_read_accessor (mr=3D0x555557600b8=
0, addr=3D98304, value=3D0x7fffdbffe360, size=3D4, shift=3D0, mask=3D4294=
967295, attrs=3D...)
    at memory.c:440
#2  0x00005555558ae669 in access_with_adjusted_size (addr=3Daddr@entry=3D=
98304, value=3Dvalue@entry=3D0x7fffdbffe360, size=3Dsize@entry=3D4, acces=
s_size_min=3D<optimized out>, access_size_max=3D<optimized out>, access_f=
n=3Daccess_fn@entry=3D0x5555558b1720 <memory_region_read_accessor>, mr=3D=
mr@entry=3D0x555557600b80, attrs=3Dattrs@entry=3D...) at memory.c:570
#3  0x00005555558b3016 in memory_region_dispatch_read (attrs=3D..., size=3D=
4, pval=3D0x7fffdbffe360, addr=3D98304, mr=3D0x555557600b80) at memory.c:=
1375
#4  0x00005555558b3016 in memory_region_dispatch_read (mr=3D0x555557600b8=
0, addr=3Daddr@entry=3D98304, pval=3Dpval@entry=3D0x7fffdbffe360, size=3D=
size@entry=3D4, attrs=3D...)
    at memory.c:1402
#5  0x000055555583cb23 in io_readx (env=3Denv@entry=3D0x555556b58a30, iot=
lbentry=3Diotlbentry@entry=3D0x555556b6d6b0, mmu_idx=3Dmmu_idx@entry=3D1,=
 addr=3Daddr@entry=3D98304, retaddr=3Dretaddr@entry=3D0, recheck=3D<optim=
ized out>, access_type=3Daccess_type@entry=3DMMU_INST_FETCH, size=3Dsize@=
entry=3D4) at accel/tcg/cputlb.c:729
#6  0x00005555558d79cd in helper_le_ldl_cmmu (access_type=3DMMU_INST_FETC=
H, recheck=3D<optimized out>, retaddr=3D0, addr=3D98304, index=3D96, mmu_=
idx=3D1, env=3D0x555556b58a30)
    at accel/tcg/softmmu_template.h:106
#7  0x00005555558d79cd in helper_le_ldl_cmmu (env=3Denv@entry=3D0x555556b=
58a30, addr=3Daddr@entry=3D98304, oi=3D33, retaddr=3Dretaddr@entry=3D0)
    at accel/tcg/softmmu_template.h:144
#8  0x00005555559d2595 in arm_tr_translate_insn (retaddr=3D0, ptr=3D98304=
, env=3D0x555556b58a30) at include/exec/cpu_ldst_template.h:102

Any clue what's going on here?

 Thomas
