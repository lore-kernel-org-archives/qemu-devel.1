Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0WYR-0000gH-Ks
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0WYQ-0005nl-7j
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:36:55 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:53436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0WYP-0005mU-UG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:36:54 -0400
Received: by mail-wr0-x22d.google.com with SMTP id y44so5807580wry.10
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 10:36:53 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 18:36:31 +0100
Message-ID: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Running the test program
http://people.linaro.org/~peter.maydell/thumb-over-page
(source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
in the usermode emulator:
 ./build/x86/arm-linux-user/qemu-arm ~/linaro/qemu-misc-tests/thumb-over-page

results in an assertion failure:
write_insns1: T32 insn crossing page boundary
Calling into buffer at 0x6fff9
qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:169:
tb_lock: Assertion `!have_tb_lock' failed.
qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:169:
tb_lock: Assertion `!have_tb_lock' failed.
Segmentation fault (core dumped)

It ought to exit successfully:
write_insns1: T32 insn crossing page boundary
Calling into buffer at 0x6fff9
got sig 11
fault pc 0x6fffe r0 0x1
e104462:xenial:qemu$

(so this is a regression).

Here's a backtrace:

qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:169:
tb_lock: Assertion `!have_tb_lock' failed.

Thread 1 "qemu-arm" received signal SIGABRT, Aborted.
0x00007ffff6851428 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:54
54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff6851428 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:54
#1  0x00007ffff685302a in __GI_abort () at abort.c:89
#2  0x00007ffff6849bd7 in __assert_fail_base (fmt=<optimised out>,
    assertion=assertion@entry=0x55555570a0ae "!have_tb_lock",
    file=file@entry=0x55555570a020
"/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c",
line=line@entry=169,
    function=function@entry=0x55555570a208 <__PRETTY_FUNCTION__.27063>
"tb_lock") at assert.c:92
#3  0x00007ffff6849c82 in __GI___assert_fail (assertion=0x55555570a0ae
"!have_tb_lock",
    file=0x55555570a020
"/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c",
    line=169, function=0x55555570a208 <__PRETTY_FUNCTION__.27063>
"tb_lock") at assert.c:101
#4  0x00005555555cd50c in tb_lock ()
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:169
#5  0x00005555555cda34 in cpu_restore_state (cpu=0x555557a1d930,
retaddr=93824992991167)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:353
#6  0x00005555555d0765 in handle_cpu_signal (pc=93824992991165,
address=458752, is_write=0,
    old_set=0x7fffffffd2a8) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/user-exec.c:125
#7  0x00005555555d0808 in cpu_arm_signal_handler (host_signum=11,
pinfo=0x7fffffffd2b0,
    puc=0x7fffffffd180) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/user-exec.c:230
#8  0x00005555555fce44 in host_signal_handler (host_signum=11,
info=0x7fffffffd2b0,
    puc=0x7fffffffd180) at
/home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/signal.c:646
#9  <signal handler called>
#10 0x000055555560d7bd in lduw_he_p (ptr=0x7ffefee1b000)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/include/qemu/bswap.h:317
#11 0x000055555560d836 in lduw_le_p (ptr=0x7ffefee1b000)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/include/qemu/bswap.h:359
#12 0x000055555561f868 in cpu_lduw_code (env=0x555557a25bc0, ptr=458752)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/cpu_ldst_useronly_template.h:68
#13 0x000055555561f8fd in arm_lduw_code (env=0x555557a25bc0,
addr=458752, sctlr_b=false)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/arm_ldst.h:50
#14 0x000055555563c059 in disas_thumb2_insn (env=0x555557a25bc0,
s=0x7fffffffd9e0, insn_hw1=61952)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:9739
#15 0x00005555556416c7 in disas_thumb_insn (env=0x555557a25bc0,
s=0x7fffffffd9e0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:11821
#16 0x0000555555641f3f in thumb_tr_translate_insn
(dcbase=0x7fffffffd9e0, cpu=0x555557a1d930)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:12104
#17 0x00005555555d0218 in translator_loop (ops=0x555555982480
<thumb_translator_ops>,
    db=0x7fffffffd9e0, cpu=0x555557a1d930, tb=0x555555a21cc0
<static_code_gen_buffer+206880>)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translator.c:104
#18 0x0000555555642446 in gen_intermediate_code (cpu=0x555557a1d930,
    tb=0x555555a21cc0 <static_code_gen_buffer+206880>)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:12300
#19 0x00005555555ceac0 in tb_gen_code (cpu=0x555557a1d930, pc=458750,
cs_base=0, flags=524417,
    cflags=0) at
/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:1283
#20 0x00005555555cba65 in tb_find (cpu=0x555557a1d930,
    last_tb=0x555555a21bc0 <static_code_gen_buffer+206624>, tb_exit=1)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:402
#21 0x00005555555cc18a in cpu_exec (cpu=0x555557a1d930)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:710
#22 0x00005555555d36ea in cpu_loop (env=0x555557a25bc0)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:570
#23 0x00005555555d59f9 in main (argc=2, argv=0x7fffffffe458,
envp=0x7fffffffe470)
    at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:4858

This is probably partly because of the silly way we handle guest
faults trying to read code in the translator.

thanks
-- PMM
