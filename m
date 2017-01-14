Received: from eggs.gnu.org ([2001:4830:134:3::10]:55067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cSUCL-0006qz-N5
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 14:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cSUCI-0001ro-JL
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 14:41:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cSUCI-0001rk-9y
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 14:41:06 -0500
References: <20170111021820.24416-1-rth@twiddle.net>
	<20170111021820.24416-15-rth@twiddle.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7763a9ed-0a79-83fc-cb0e-324b86d05297@redhat.com>
Date: Sat, 14 Jan 2017 20:41:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170111021820.24416-15-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 14/65] target-arm: Use new deposit and
 extract ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 01/11/17 03:17, Richard Henderson wrote:
> Use the new primitives for UBFX and SBFX.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate-a64.c | 81 +++++++++++++++++-----------------------------
>  target/arm/translate.c     | 37 +++++----------------
>  2 files changed, 37 insertions(+), 81 deletions(-)

This patch causes an assertion to fail:

> qemu-system-aarch64: .../tcg/tcg-op.c:1829: tcg_gen_deposit_z_i64: Assertion `ofs + len <= 64' failed.

See the details below.

> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index f673d93..a59c90c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3216,67 +3216,44 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
>         low 32-bits anyway.  */
>      tcg_tmp = read_cpu_reg(s, rn, 1);
>  
> -    /* Recognize the common aliases.  */
> -    if (opc == 0) { /* SBFM */
> -        if (ri == 0) {
> -            if (si == 7) { /* SXTB */
> -                tcg_gen_ext8s_i64(tcg_rd, tcg_tmp);
> -                goto done;
> -            } else if (si == 15) { /* SXTH */
> -                tcg_gen_ext16s_i64(tcg_rd, tcg_tmp);
> -                goto done;
> -            } else if (si == 31) { /* SXTW */
> -                tcg_gen_ext32s_i64(tcg_rd, tcg_tmp);
> -                goto done;
> -            }
> -        }
> -        if (si == 63 || (si == 31 && ri <= si)) { /* ASR */
> -            if (si == 31) {
> -                tcg_gen_ext32s_i64(tcg_tmp, tcg_tmp);
> -            }
> -            tcg_gen_sari_i64(tcg_rd, tcg_tmp, ri);
> +    /* Recognize simple(r) extractions.  */
> +    if (si <= ri) {
> +        /* Wd<s-r:0> = Wn<s:r> */
> +        len = (si - ri) + 1;
> +        if (opc == 0) { /* SBFM: ASR, SBFX, SXTB, SXTH, SXTW */
> +            tcg_gen_sextract_i64(tcg_rd, tcg_tmp, ri, len);
>              goto done;
> -        }
> -    } else if (opc == 2) { /* UBFM */
> -        if (ri == 0) { /* UXTB, UXTH, plus non-canonical AND */
> -            tcg_gen_andi_i64(tcg_rd, tcg_tmp, bitmask64(si + 1));
> +        } else if (opc == 2) { /* UBFM: UBFX, LSR, UXTB, UXTH */
> +            tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
>              return;
>          }
> -        if (si == 63 || (si == 31 && ri <= si)) { /* LSR */
> -            if (si == 31) {
> -                tcg_gen_ext32u_i64(tcg_tmp, tcg_tmp);
> -            }
> -            tcg_gen_shri_i64(tcg_rd, tcg_tmp, ri);
> -            return;
> -        }
> -        if (si + 1 == ri && si != bitsize - 1) { /* LSL */
> -            int shift = bitsize - 1 - si;
> -            tcg_gen_shli_i64(tcg_rd, tcg_tmp, shift);
> -            goto done;
> -        }
> -    }
> -
> -    if (opc != 1) { /* SBFM or UBFM */
> -        tcg_gen_movi_i64(tcg_rd, 0);
> -    }
> -
> -    /* do the bit move operation */
> -    if (si >= ri) {
> -        /* Wd<s-r:0> = Wn<s:r> */
> -        tcg_gen_shri_i64(tcg_tmp, tcg_tmp, ri);
> +        /* opc == 1, BXFIL fall through to deposit */
> +        tcg_gen_extract_i64(tcg_tmp, tcg_tmp, ri, len);
>          pos = 0;
> -        len = (si - ri) + 1;
>      } else {
> -        /* Wd<32+s-r,32-r> = Wn<s:0> */
> -        pos = bitsize - ri;
> +        /* Handle the ri > si case with a deposit
> +         * Wd<32+s-r,32-r> = Wn<s:0>
> +         */
>          len = si + 1;
> +        pos = (bitsize - ri) & (bitsize - 1);
>      }
>  
> -    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
> +    if (opc == 0 && len < ri) {
> +        /* SBFM: sign extend the destination field from len to fill
> +           the balance of the word.  Let the deposit below insert all
> +           of those sign bits.  */
> +        tcg_gen_sextract_i64(tcg_tmp, tcg_tmp, 0, len);
> +        len = ri;
> +    }
>  
> -    if (opc == 0) { /* SBFM - sign extend the destination field */
> -        tcg_gen_shli_i64(tcg_rd, tcg_rd, 64 - (pos + len));
> -        tcg_gen_sari_i64(tcg_rd, tcg_rd, 64 - (pos + len));
> +    if (opc == 1) { /* BFM, BXFIL */
> +        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
> +    } else {
> +        /* SBFM or UBFM: We start with zero, and we haven't modified
> +           any bits outside bitsize, therefore the zero-extension
> +           below is unneeded.  */
> +        tcg_gen_deposit_z_i64(tcg_rd, tcg_tmp, pos, len);

^^^ Called from here.

> +        return;
>      }
>  
>   done:
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0ad9070..08da9ac 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -288,29 +288,6 @@ static void gen_revsh(TCGv_i32 var)
>      tcg_gen_ext16s_i32(var, var);
>  }
>  
> -/* Unsigned bitfield extract.  */
> -static void gen_ubfx(TCGv_i32 var, int shift, uint32_t mask)
> -{
> -    if (shift)
> -        tcg_gen_shri_i32(var, var, shift);
> -    tcg_gen_andi_i32(var, var, mask);
> -}
> -
> -/* Signed bitfield extract.  */
> -static void gen_sbfx(TCGv_i32 var, int shift, int width)
> -{
> -    uint32_t signbit;
> -
> -    if (shift)
> -        tcg_gen_sari_i32(var, var, shift);
> -    if (shift + width < 32) {
> -        signbit = 1u << (width - 1);
> -        tcg_gen_andi_i32(var, var, (1u << width) - 1);
> -        tcg_gen_xori_i32(var, var, signbit);
> -        tcg_gen_subi_i32(var, var, signbit);
> -    }
> -}
> -
>  /* Return (b << 32) + a. Mark inputs as dead */
>  static TCGv_i64 gen_addq_msw(TCGv_i64 a, TCGv_i32 b)
>  {
> @@ -9178,9 +9155,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                              goto illegal_op;
>                          if (i < 32) {
>                              if (op1 & 0x20) {
> -                                gen_ubfx(tmp, shift, (1u << i) - 1);
> +                                tcg_gen_extract_i32(tmp, tmp, shift, i);
>                              } else {
> -                                gen_sbfx(tmp, shift, i);
> +                                tcg_gen_sextract_i32(tmp, tmp, shift, i);
>                              }
>                          }
>                          store_reg(s, rd, tmp);
> @@ -10497,15 +10474,17 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
>                          imm++;
>                          if (shift + imm > 32)
>                              goto illegal_op;
> -                        if (imm < 32)
> -                            gen_sbfx(tmp, shift, imm);
> +                        if (imm < 32) {
> +                            tcg_gen_sextract_i32(tmp, tmp, shift, imm);
> +                        }
>                          break;
>                      case 6: /* Unsigned bitfield extract.  */
>                          imm++;
>                          if (shift + imm > 32)
>                              goto illegal_op;
> -                        if (imm < 32)
> -                            gen_ubfx(tmp, shift, (1u << imm) - 1);
> +                        if (imm < 32) {
> +                            tcg_gen_extract_i32(tmp, tmp, shift, imm);
> +                        }
>                          break;
>                      case 3: /* Bitfield insert/clear.  */
>                          if (imm < shift)
> 



Original QEMU command line (generated by libvirt, can be reproduced with a much simpler command line):

> QEMU_AUDIO_DRV=none \
>   .../qemu-system-aarch64 \
>   -name guest=aavmf.rhel7,debug-threads=on \
>   -S \
>   -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-20-aavmf.rhel7/master-key.aes \
>   -machine virt-2.7,accel=tcg,usb=off,dump-guest-core=off \
>   -cpu cortex-a57 \
>   -drive file=/home/virt-images/arm/QEMU_EFI.fd.padded,if=pflash,format=raw,unit=0,readonly=on \
>   -drive file=/var/lib/libvirt/qemu/nvram/aavmf.rhel7_VARS.fd,if=pflash,format=raw,unit=1 \
>   -m 4096 \
>   -realtime mlock=off \
>   -smp 1,sockets=1,cores=1,threads=1 \
>   -uuid 07e8be37-b3fd-4f31-9fec-80640dabf146 \
>   -no-user-config \
>   -nodefaults \
>   -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-20-aavmf.rhel7/monitor.sock,server,nowait \
>   -mon chardev=charmonitor,id=monitor,mode=control \
>   -rtc base=utc \
>   -no-shutdown \
>   -boot menu=on,splash-time=5000,strict=on \
>   -device ioh3420,port=0x8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 \
>   -device ioh3420,port=0x9,chassis=2,id=pci.2,bus=pcie.0,multifunction=on,addr=0x1.0x1 \
>   -device ioh3420,port=0xa,chassis=3,id=pci.3,bus=pcie.0,multifunction=on,addr=0x1.0x2 \
>   -device ioh3420,port=0xb,chassis=4,id=pci.4,bus=pcie.0,multifunction=on,addr=0x1.0x3 \
>   -device ioh3420,port=0xc,chassis=5,id=pci.5,bus=pcie.0,multifunction=on,addr=0x1.0x4 \
>   -device nec-usb-xhci,id=usb,bus=pci.2,addr=0x0 \
>   -device virtio-scsi-pci,id=scsi0,bus=pci.1,addr=0x0 \
>   -device virtio-serial-pci,id=virtio-serial0,bus=pci.5,addr=0x0 \
>   -drive file=/mnt/data/virt-images-big/aavmf.rhel7.img,format=raw,if=none,id=drive-scsi0-0-0-0,cache=writeback,discard=unmap,werror=enospc \
>   -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 \
>   -drive file=/mnt/data/isos/iso-rhel/RHEL-7.3-20161019.0-Server-aarch64-dvd1.iso,format=raw,if=none,id=drive-scsi0-0-0-1,readonly=on,cache=writeback \
>   -device scsi-cd,bus=scsi0.0,channel=0,scsi-id=0,lun=1,drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=2 \
>   -netdev tap,fd=26,id=hostnet0 \
>   -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:40:e0:7f,bus=pci.3,addr=0x0,rombar=0 \
>   -serial pty \
>   -chardev socket,id=charchannel0,path=/var/lib/libvirt/qemu/channel/target/domain-20-aavmf.rhel7/org.qemu.guest_agent.0,server,nowait \
>   -device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=org.qemu.guest_agent.0 \
>   -device usb-tablet,id=input0,bus=usb.0,port=1 \
>   -device usb-kbd,id=input1,bus=usb.0,port=2 \
>   -vnc 127.0.0.1:0 \
>   -device virtio-gpu-pci,id=video0,bus=pci.4,addr=0x0 \
>   -fw_cfg name=opt/org.tianocore.edk2.aavmf/PcdResizeXterm,string=y \
>   -msg timestamp=on

Simpler command line:

>  .../qemu-system-aarch64 \
>    -machine virt-2.7,accel=tcg,usb=off,dump-guest-core=off \
>   -cpu cortex-a57 \
>   -drive file=/home/virt-images/arm/QEMU_EFI.fd.padded,if=pflash,format=raw,unit=0,readonly=on \
>   -drive file=/var/lib/libvirt/qemu/nvram/aavmf.rhel7_VARS.fd,if=pflash,format=raw,unit=1 \
>   -m 4096 \
>   -realtime mlock=off \
>   -smp 1,sockets=1,cores=1,threads=1 \
>   -uuid 07e8be37-b3fd-4f31-9fec-80640dabf146 \
>   -no-user-config \
>   -nodefaults

As can be seen from the above, the guest code that triggers the assertion is UEFI firmware for aarch64 guests, built from edk2's ArmVirtQemu platform.

QEMU backtrace:

> #0  0x00007fffec2491d7 in raise () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007fffec24a8c8 in abort () from /lib64/libc.so.6
> No symbol table info available.
> #2  0x00007fffec242146 in __assert_fail_base () from /lib64/libc.so.6
> No symbol table info available.
> #3  0x00007fffec2421f2 in __assert_fail () from /lib64/libc.so.6
> No symbol table info available.
> #4  0x00005555557a7580 in tcg_gen_deposit_z_i64 (ret=0x1c, arg=0x3c, ofs=41, len=64) at .../tcg/tcg-op.c:2049
>         __PRETTY_FUNCTION__ = "tcg_gen_deposit_z_i64"
> #5  0x000055555595312b in disas_bitfield (s=0x7fff921ff560, insn=3545758819) at .../target/arm/translate-a64.c:3255
>         sf = 1
>         n = 1
>         opc = 2
>         ri = 23
>         si = 63
>         rn = 3
>         rd = 3
>         bitsize = 64
>         pos = 41
>         len = 64
>         tcg_rd = 0x1c
>         tcg_tmp = 0x3c
> #6  0x00005555559534a5 in disas_data_proc_imm (s=0x7fff921ff560, insn=3545758819) at .../target/arm/translate-a64.c:3342
> No locals.
> #7  0x00005555559640ea in disas_a64_insn (env=0x555556965410, s=0x7fff921ff560) at .../target/arm/translate-a64.c:11155
>         insn = 3545758819
>         __PRETTY_FUNCTION__ = "disas_a64_insn"
> #8  0x000055555596466d in gen_intermediate_code_a64 (cpu=0x55555695d190, tb=0x7fff922024b0) at .../target/arm/translate-a64.c:11313
>         cs = 0x55555695d190
>         env = 0x555556965410
>         dc1 = {
>           pc = 12296, insn = 3545758819, is_jmp = 0, condjmp = 0,
>           condlabel = 0x55555579693e <tcg_out_opc+439>, condexec_mask =
>           0, condexec_cond = 0, tb = 0x7fff922024b0, singlestep_enabled
>           = 0, thumb = 0, sctlr_b = 0, be_data = MO_8, user = 0, mmu_idx
>           = ARMMMUIdx_S12NSE1, tbi0 = false, tbi1 = false, ns = 83,
>           fp_excp_el = 0, secure_routed_to_el3 = false, vfp_enabled =
>           245, vec_len = 0, vec_stride = 0, svc_imm = 21845, aarch64 =
>           1, current_el = 1Python Exception <class 'gdb.error'> There is
>           no member named keys.:, cp_regs = 0x55555691a120, features =
>           51951420514035, fp_access_checked = false, ss_active = false,
>           pstate_ss = false, is_ldex = false, ss_same_el = true,
>           c15_cpar = -1521261276, insn_start_idx = 7, tmp_a64_count = 1,
>           tmp_a64 = {0x3c, 0xffffffffffffffff <repeats 15 times>}
>         }
>         dc = 0x7fff921ff560
>         pc_start = 12288
>         next_page_start = 13312
>         num_insns = 2
>         max_insns = 512
>         __PRETTY_FUNCTION__ = "gen_intermediate_code_a64"
> #9  0x0000555555911279 in gen_intermediate_code (env=0x555556965410, tb=0x7fff922024b0) at .../target/arm/translate.c:11588
>         cpu = 0x55555695d190
>         cs = 0x55555695d190
>         dc1 = {
>           pc = 93825000310048, insn = 1451516240, is_jmp = 21845,
>           condjmp = 4, condlabel = 0x5555563d19a0 <tcg_ctx>,
>           condexec_mask = -1843394816, condexec_cond = 32767, tb = 0x1,
>           singlestep_enabled = -1843398816, thumb = 32767, sctlr_b =
>           1438691441, be_data = 21845, user = 0, mmu_idx =
>           ARMMMUIdx_S12NSE0, tbi0 = 152, tbi1 = 5, ns = 32, fp_excp_el =
>           32767, secure_routed_to_el3 = 144, vfp_enabled = 247, vec_len
>           = 32767, vec_stride = 1433968911, svc_imm = 21845, aarch64 =
>           1439728928, current_el = 21845Python Exception <class
>           'gdb.error'> There is no member named keys.:, cp_regs =
>           0x7fff921ff7b0, features = 0, fp_access_checked = false,
>           ss_active = 48, pstate_ss = 96, is_ldex = 141, ss_same_el =
>           254, c15_cpar = -1843398768, insn_start_idx = 32767,
>           tmp_a64_count = 1433943445, tmp_a64 = {0x5555569c68b0,
>           0x55555695d190, 0x7ffe8d603000, 0x5555569c68b0,
>           0x7fff921ff7c0, 0x55555578a19f <qemu_ram_addr_from_host+33>,
>           0x555500000000, 0x7ffe8d603000, 0x3000, 0x5555569c68b0,
>           0x7fff921ff7f0, 0x5555557e1e91
>           <qemu_ram_addr_from_host_nofail+24>, 0x857600340,
>           0x5555563d19a0 <tcg_ctx>, 0x5555569a7a10, 0x7ffe740008c0}
>         }
>         dc = 0x7fff921ff6e0
>         pc_start = 93824994593322
>         next_page_start = 35812430864
>         num_insns = 21845
>         max_insns = 1452692496
>         end_of_page = 85
>         __PRETTY_FUNCTION__ = "gen_intermediate_code"
> #10 0x0000555555791de9 in tb_gen_code (cpu=0x55555695d190, pc=12288, cs_base=0, flags=2415919104, cflags=0) at .../translate-all.c:1311
>         env = 0x555556965410
>         tb = 0x7fff922024b0
>         phys_pc = 4294979584
>         phys_page2 = 4294979584
>         virt_page2 = 0
>         gen_code_buf = 0x7fffa55365a0 <code_gen_buffer+5496> ""
>         gen_code_size = 21845
>         search_size = 1452692496
>         __PRETTY_FUNCTION__ = "tb_gen_code"
> #11 0x0000555555794de5 in tb_find (cpu=0x55555695d190, last_tb=0x0, tb_exit=0) at .../cpu-exec.c:346
>         env = 0x555556965410
>         tb = 0x0
>         cs_base = 0
>         pc = 12288
>         flags = 2415919104
>         have_tb_lock = true
> #12 0x0000555555795606 in cpu_exec (cpu=0x55555695d190) at .../cpu-exec.c:637
>         tb = 0x7fff92202438
>         last_tb = 0x0
>         tb_exit = 0
>         cc = 0x5555568e63f0
>         __func__ = "cpu_exec"
>         ret = 21845
>         sc = {diff_clk = 140735644957088, last_cpu_icount = 40107364752, realtime_clock = 140735644957088}
>         __FUNCTION__ = "cpu_exec"
> #13 0x00005555557c4e6b in tcg_cpu_exec (cpu=0x55555695d190) at .../cpus.c:1117
>         ret = 1447261504
> #14 0x00005555557c50c8 in qemu_tcg_cpu_thread_fn (arg=0x55555695d190) at .../cpus.c:1197
>         r = 0
>         cpu = 0x55555695d190
> #15 0x00007fffef08edc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #16 0x00007fffec30b73d in clone () from /lib64/libc.so.6
> No symbol table info available.

Bisection log (from v2.7.0 to current master):

> git bisect start
> # bad: [b6af8ea60282df514f87d32e36afd1c9aeee28c8] Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging
> git bisect bad b6af8ea60282df514f87d32e36afd1c9aeee28c8
> # good: [1dc33ed90bf1fe1c2014dffa0d9e863c520d953a] Update version for v2.7.0 release
> git bisect good 1dc33ed90bf1fe1c2014dffa0d9e863c520d953a
> # good: [c8cccba3125d8d1a7ca66fc593a89543f3fe823d] xilinx: fix buffer overflow on realize
> git bisect good c8cccba3125d8d1a7ca66fc593a89543f3fe823d
> # good: [199a5bde46b0eab898ab1ec591f423000302569f] Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging
> git bisect good 199a5bde46b0eab898ab1ec591f423000302569f
> # good: [166dbda7e131f7b6540f56c3234bb2f8b23d84c0] scsi-disk: fix VERIFY for scsi-block
> git bisect good 166dbda7e131f7b6540f56c3234bb2f8b23d84c0
> # good: [e0a3c8ccaa51c4b6b2bf093a0b5ef230a74d5a9e] intel_iommu: name vtd address space with devfn
> git bisect good e0a3c8ccaa51c4b6b2bf093a0b5ef230a74d5a9e
> # bad: [5318420c62b6f6ce0bb7cfcf115fc21055015f90] target-microblaze: Use clz opcode
> git bisect bad 5318420c62b6f6ce0bb7cfcf115fc21055015f90
> # good: [987da7be996e63c294dc6485acb1c37af7696257] acpi-test: update expected files
> git bisect good 987da7be996e63c294dc6485acb1c37af7696257
> # good: [befbb3ced5869003ee2e806c4f36e306918d2374] tcg/mips: Implement field extraction opcodes
> git bisect good befbb3ced5869003ee2e806c4f36e306918d2374
> # bad: [f6156b8fb01177c7c8e82999e0b1ab6de8385179] target-s390x: Use the new deposit and extract ops
> git bisect bad f6156b8fb01177c7c8e82999e0b1ab6de8385179
> # good: [f49f1ae73be521f6118ea6c2c2ac3ab5e6c5918f] target-alpha: Use deposit and extract ops
> git bisect good f49f1ae73be521f6118ea6c2c2ac3ab5e6c5918f
> # bad: [04fc2f1c8fc030a11e08e81bb926392c0991282a] target-i386: Use new deposit and extract ops
> git bisect bad 04fc2f1c8fc030a11e08e81bb926392c0991282a
> # bad: [59a71b4c5b4ef2ef6425b9e21c972dd5bf450275] target-arm: Use new deposit and extract ops
> git bisect bad 59a71b4c5b4ef2ef6425b9e21c972dd5bf450275
> # first bad commit: [59a71b4c5b4ef2ef6425b9e21c972dd5bf450275] target-arm: Use new deposit and extract ops

Building QEMU at the direct parent (f49f1ae73be5 "target-alpha: Use deposit and extract ops", also tested by the bisection) prevents the symptom (or hides it, anyway).

Thanks
Laszlo
