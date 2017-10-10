Received: from eggs.gnu.org ([2001:4830:134:3::10]:47738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1rDu-0001tL-VE
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:53:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1rDr-0006FD-Si
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:53:15 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:54380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e1rDr-0006EJ-Ic
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:53:11 -0400
Received: by mail-wm0-x232.google.com with SMTP id i124so3548135wmf.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 02:53:09 -0700 (PDT)
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
Date: Tue, 10 Oct 2017 10:53:07 +0100
Message-ID: <87zi8z9vng.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> Running the test program
> http://people.linaro.org/~peter.maydell/thumb-over-page
> (source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
> in the usermode emulator:
>  ./build/x86/arm-linux-user/qemu-arm
> ~/linaro/qemu-misc-tests/thumb-over-page

Does this fail when run via system mode as well?

>
> results in an assertion failure:
> write_insns1: T32 insn crossing page boundary
> Calling into buffer at 0x6fff9
> qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate=
-all.c:169:
> tb_lock: Assertion `!have_tb_lock' failed.
> qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate=
-all.c:169:
> tb_lock: Assertion `!have_tb_lock' failed.
> Segmentation fault (core dumped)
>
> It ought to exit successfully:
> write_insns1: T32 insn crossing page boundary
> Calling into buffer at 0x6fff9
> got sig 11
> fault pc 0x6fffe r0 0x1
> e104462:xenial:qemu$
>
> (so this is a regression).

OK I'll have a look at how we broke this.

>
> Here's a backtrace:
>
> qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate=
-all.c:169:
> tb_lock: Assertion `!have_tb_lock' failed.
>
> Thread 1 "qemu-arm" received signal SIGABRT, Aborted.
> 0x00007ffff6851428 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff6851428 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007ffff685302a in __GI_abort () at abort.c:89
> #2  0x00007ffff6849bd7 in __assert_fail_base (fmt=3D<optimised out>,
>     assertion=3Dassertion@entry=3D0x55555570a0ae "!have_tb_lock",
>     file=3Dfile@entry=3D0x55555570a020
> "/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c",
> line=3Dline@entry=3D169,
>     function=3Dfunction@entry=3D0x55555570a208 <__PRETTY_FUNCTION__.27063>
> "tb_lock") at assert.c:92
> #3  0x00007ffff6849c82 in __GI___assert_fail (assertion=3D0x55555570a0ae
> "!have_tb_lock",
>     file=3D0x55555570a020
> "/home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c",
>     line=3D169, function=3D0x55555570a208 <__PRETTY_FUNCTION__.27063>
> "tb_lock") at assert.c:101
> #4  0x00005555555cd50c in tb_lock ()
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-al=
l.c:169
> #5  0x00005555555cda34 in cpu_restore_state (cpu=3D0x555557a1d930,
> retaddr=3D93824992991167)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-al=
l.c:353
> #6  0x00005555555d0765 in handle_cpu_signal (pc=3D93824992991165,
> address=3D458752, is_write=3D0,
>     old_set=3D0x7fffffffd2a8) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/user-exec.c:125
> #7  0x00005555555d0808 in cpu_arm_signal_handler (host_signum=3D11,
> pinfo=3D0x7fffffffd2b0,
>     puc=3D0x7fffffffd180) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/user-exec.c:230
> #8  0x00005555555fce44 in host_signal_handler (host_signum=3D11,
> info=3D0x7fffffffd2b0,
>     puc=3D0x7fffffffd180) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/signal.c:646
> #9  <signal handler called>
> #10 0x000055555560d7bd in lduw_he_p (ptr=3D0x7ffefee1b000)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/include/qemu/bswap.h:3=
17
> #11 0x000055555560d836 in lduw_le_p (ptr=3D0x7ffefee1b000)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/include/qemu/bswap.h:3=
59
> #12 0x000055555561f868 in cpu_lduw_code (env=3D0x555557a25bc0, ptr=3D4587=
52)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/include/exec/cpu_ldst_=
useronly_template.h:68
> #13 0x000055555561f8fd in arm_lduw_code (env=3D0x555557a25bc0,
> addr=3D458752, sctlr_b=3Dfalse)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/arm_ldst.h:=
50
> #14 0x000055555563c059 in disas_thumb2_insn (env=3D0x555557a25bc0,
> s=3D0x7fffffffd9e0, insn_hw1=3D61952)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c=
:9739
> #15 0x00005555556416c7 in disas_thumb_insn (env=3D0x555557a25bc0,
> s=3D0x7fffffffd9e0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c=
:11821
> #16 0x0000555555641f3f in thumb_tr_translate_insn
> (dcbase=3D0x7fffffffd9e0, cpu=3D0x555557a1d930)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c=
:12104
> #17 0x00005555555d0218 in translator_loop (ops=3D0x555555982480
> <thumb_translator_ops>,
>     db=3D0x7fffffffd9e0, cpu=3D0x555557a1d930, tb=3D0x555555a21cc0
> <static_code_gen_buffer+206880>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translator.c=
:104
> #18 0x0000555555642446 in gen_intermediate_code (cpu=3D0x555557a1d930,
>     tb=3D0x555555a21cc0 <static_code_gen_buffer+206880>)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c=
:12300
> #19 0x00005555555ceac0 in tb_gen_code (cpu=3D0x555557a1d930, pc=3D458750,
> cs_base=3D0, flags=3D524417,
>     cflags=3D0) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:1283
> #20 0x00005555555cba65 in tb_find (cpu=3D0x555557a1d930,
>     last_tb=3D0x555555a21bc0 <static_code_gen_buffer+206624>, tb_exit=3D1)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:4=
02
> #21 0x00005555555cc18a in cpu_exec (cpu=3D0x555557a1d930)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/cpu-exec.c:7=
10
> #22 0x00005555555d36ea in cpu_loop (env=3D0x555557a25bc0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:570
> #23 0x00005555555d59f9 in main (argc=3D2, argv=3D0x7fffffffe458,
> envp=3D0x7fffffffe470)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/main.c:4858
>
> This is probably partly because of the silly way we handle guest
> faults trying to read code in the translator.
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
