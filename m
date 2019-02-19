Received: from eggs.gnu.org ([209.51.188.92]:60524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gw7FF-0003iN-0M
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gw7FD-0001aM-Lb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:23:40 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gw7FC-0001Zx-Qs
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:23:39 -0500
Received: by mail-wm1-x344.google.com with SMTP id y15so3234032wma.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 07:23:38 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
	<20190214040652.4811-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190214040652.4811-4-richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 15:23:35 +0000
Message-ID: <878syb6buw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] target/arm: Assert hflags is correct
 in cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Make sure that we are updating env->hflags everywhere required.

It's a good job you added it thought because on this commit with:

  -machine virt,graphics=3Don,gic-version=3D3,virtualization=3Don

We get:

  qemu-system-aarch64: /home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:=
14045: cpu_get_tb_cpu_state: Assertion `flags =3D=3D env->hflags' failed.

  Thread 3 "qemu-system-aar" received signal SIGABRT, Aborted.
  [Switching to Thread 0x7fffde05e700 (LWP 20621)]
  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:51
  51      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
  (gdb) bt
  #0  0x00007ffff278fe97 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
unix/sysv/linux/raise.c:51
  #1  0x00007ffff2791801 in __GI_abort () at abort.c:79
  #2  0x00007ffff278139a in __assert_fail_base (fmt=3D0x7ffff29087d8 "%s%s%=
s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3Dassertion@entry=3D0x5555=
55dbb012 "flags =3D=3D env->hflags", file=3Dfile@entry=3D0x555555db96e8 "/h=
ome/alex.bennee/lsrc/qemu.git/target/arm/helper.c", line=3Dline@entry=3D140=
45, function=3Dfunction@entry=3D0x555555dbd810 <__PRETTY_FUNCTION__.43682> =
"cpu_get_tb_cpu_state") at assert.c:92
  #3  0x00007ffff2781412 in __GI___assert_fail (assertion=3Dassertion@entry=
=3D0x555555dbb012 "flags =3D=3D env->hflags", file=3Dfile@entry=3D0x555555d=
b96e8 "/home/alex.bennee/lsrc/qemu.git/target/arm/helper.c", line=3Dline@en=
try=3D14045, function=3Dfunction@entry=3D0x555555dbd810 <__PRETTY_FUNCTION_=
_.43682> "cpu_get_tb_cpu_state") at assert.c:101
  #4  0x00005555559bf437 in cpu_get_tb_cpu_state (env=3D0x5555567150e0, pc=
=3Dpc@entry=3D0x7fffde05b0b8, cs_base=3Dcs_base@entry=3D0x7fffde05b0b0, pfl=
ags=3Dpflags@entry=3D0x7fffde05b0a8) at
  /home/alex.bennee/lsrc/qemu.git/target/arm/helper.c:14045
  #5  0x00005555558ab09b in tb_lookup__cpu_state (cf_mask=3D524288, flags=
=3D0x7fffde05b0a8, cs_base=3D0x7fffde05b0b0, pc=3D0x7fffde05b0b8, cpu=3D0x0=
) at /home/alex.bennee/lsrc/qemu.git/include/exec/tb-lookup.h:28
  #6  0x00005555558ab09b in tb_find (cf_mask=3D524288, tb_exit=3D0, last_tb=
=3D0x0, cpu=3D0x0) at /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:=
404
  #7  0x00005555558ab09b in cpu_exec (cpu=3Dcpu@entry=3D0x55555670ce30) at =
/home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:728
  #8  0x000055555586963f in tcg_cpu_exec (cpu=3D0x55555670ce30) at /home/al=
ex.bennee/lsrc/qemu.git/cpus.c:1429
  #9  0x000055555586b7c3 in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x555=
55670ce30) at /home/alex.bennee/lsrc/qemu.git/cpus.c:1733
  #10 0x0000555555d44e06 in qemu_thread_start (args=3D<optimized out>) at u=
til/qemu-thread-posix.c:502
  #11 0x00007ffff2b496db in start_thread (arg=3D0x7fffde05e700) at pthread_=
create.c:463
  #12 0x00007ffff287288f in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:95


>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d8249f0eae..3c8724883d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -13902,11 +13902,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>      if (is_a64(env)) {
>          *pc =3D env->pc;
>          flags =3D rebuild_hflags_a64(env, current_el);
> +        assert(flags =3D=3D env->hflags);
>          flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          pstate_for_ss =3D env->pstate;
>      } else {
>          *pc =3D env->regs[15];
>          flags =3D rebuild_hflags_a32(env, current_el);
> +        assert(flags =3D=3D env->hflags);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
>          pstate_for_ss =3D env->uncached_cpsr;


--
Alex Benn=C3=A9e
