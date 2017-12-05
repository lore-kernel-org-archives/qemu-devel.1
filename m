Received: from eggs.gnu.org ([2001:4830:134:3::10]:44713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMJvr-0002tk-Ur
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMJvn-0000wE-8E
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:35:11 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eMJvn-0000vc-1f
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:35:07 -0500
Received: by mail-wm0-x242.google.com with SMTP id g130so20510462wme.0
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 12:35:06 -0800 (PST)
References: <20171205170013.22337-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171205170013.22337-1-f4bug@amsat.org>
Date: Tue, 05 Dec 2017 20:35:04 +0000
Message-ID: <87374osykn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] target/sh4: add missing tcg_temp_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Vladimir Prus <vladimir.prus@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi,
>
> After reading Alex commenting on IRC "java --version failing on sh4" I re=
member
> this series staged for 2.12.
>
> This might help for:
>
>   root@6e10336e48ac:/etc/apt# java --version
>   qemu-sh4: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:703: temp_idx: Assert=
ion `n >=3D 0 && n < tcg_ctx->nb_temps' failed.
>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped

Sadly it's decode_gusa which trips for me:

  #0  0x00007ffff6941428 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:54
  #1  0x00007ffff694302a in __GI_abort () at abort.c:89
  #2  0x00007ffff6939bd7 in __assert_fail_base (fmt=3D<optimised out>, asse=
rtion=3Dassertion@entry=3D0x555555678fc8 "n >=3D 0 && n < tcg_ctx->nb_temps=
", file=3Dfile@entry=3D0x555555678fa0 "/home/alex/lsrc/qemu/qemu.git/tcg/tc=
g.h", line=3Dline@entry=3D703, function=3Dfunction@entry=3D0x55555567aa38 <=
__PRETTY_FUNCTION__.23740> "temp_idx") at assert.c:92
  #3  0x00007ffff6939c82 in __GI___assert_fail (assertion=3D0x555555678fc8 =
"n >=3D 0 && n < tcg_ctx->nb_temps", file=3D0x555555678fa0 "/home/alex/lsrc=
/qemu/qemu.git/tcg/tcg.h", line=3D703, function=3D0x55555567aa38 <__PRETTY_=
FUNCTION__.23740> "temp_idx") at assert.c:101
  #4  0x0000555555585e03 in temp_idx (ts=3D0x555555902f20 <tcg_init_ctx>) a=
t /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:703
  #5  0x0000555555585e5b in tcgv_i32_temp (v=3D0x0) at /home/alex/lsrc/qemu=
/qemu.git/tcg/tcg.h:724
  #6  0x000055555558bc2f in tcg_temp_free_i32 (arg=3D0x0) at /home/alex/lsr=
c/qemu/qemu.git/tcg/tcg.c:1053
  #7  0x00005555555ff077 in decode_gusa (ctx=3D0x7ffff7f67c00, env=3D0x5555=
579adf60, pmax_insns=3D0x7ffff7f67bec) at /home/alex/lsrc/qemu/qemu.git/tar=
get/sh4/translate.c:2193
  #8  0x00005555555ff303 in gen_intermediate_code (cs=3D0x5555579a5cc0, tb=
=3D0x55555593c6c0 <static_code_gen_buffer+78976>) at /home/alex/lsrc/qemu/q=
emu.git/target/sh4/translate.c:2268
  #9  0x00005555555bc656 in tb_gen_code (cpu=3D0x5555579a5cc0, pc=3D2134168=
040, cs_base=3D2134168044, flags=3D528320, cflags=3D524288) at /home/alex/l=
src/qemu/qemu.git/accel/tcg/translate-all.c:1292
  #10 0x00005555555b9ff9 in tb_find (cpu=3D0x5555579a5cc0, last_tb=3D0x0, t=
b_exit=3D0, cf_mask=3D524288) at /home/alex/lsrc/qemu/qemu.git/accel/tcg/cp=
u-exec.c:402
  #11 0x00005555555ba77d in cpu_exec (cpu=3D0x5555579a5cc0) at /home/alex/l=
src/qemu/qemu.git/accel/tcg/cpu-exec.c:735
  #12 0x00005555555c0ed2 in cpu_loop (env=3D0x5555579adf60) at /home/alex/l=
src/qemu/qemu.git/linux-user/main.c:2684
  #13 0x00005555555d001c in clone_func (arg=3D0x7fffffffc990) at /home/alex=
/lsrc/qemu/qemu.git/linux-user/syscall.c:6264
  #14 0x00007ffff6cdd6ba in start_thread (arg=3D0x7ffff7f68700) at pthread_=
create.c:333
  #15 0x00007ffff6a133dd in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:109
  #7  0x00005555555ff077 in decode_gusa (ctx=3D0x7ffff7f67c00, env=3D0x5555=
579adf60, pmax_insns=3D0x7ffff7f67bec) at /home/alex/lsrc/qemu/qemu.git/tar=
get/sh4/translate.c:2193
  2193	        tcg_temp_free_i32(op_arg);

The line:

    /* If op_src is not a valid register, then op_arg was a constant.  */
    if (op_src < 0) {
        tcg_temp_free_i32(op_arg);
    }

Looks pretty sketchy to me, why not check is op_arg is allocated
directly? Constants still need to be freed over a block. I think TCG
still keeps them around if it re-uses them.

>
> Regards,
>
> Philippe.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/sh4: add missing tcg_temp_free() in gen_conditional_jump()
>   target/sh4: add missing tcg_temp_free() in _decode_opc()
>
>  target/sh4/translate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)


--
Alex Benn=C3=A9e
