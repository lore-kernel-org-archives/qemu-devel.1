Received: from eggs.gnu.org ([2001:4830:134:3::10]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEHuI-0001pb-JK
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEHuE-0003jo-Qs
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:43:50 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEHuE-0003jb-CN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:43:46 -0500
Received: by mail-vk0-f51.google.com with SMTP id 137so197876864vkl.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 07:43:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161206150004.19758-1-alex.bennee@linaro.org>
References: <20161206150004.19758-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 15:42:25 +0000
Message-ID: <CAFEAcA9qXOd1q+HYEMLtg9Ngqi2Atu1OQ3u07zPChOY_BLJB=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.9] gdbstub: remove spurious
 tb_flush() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 6 December 2016 at 15:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> These are (now) mostly harmless but not needed. The correct place to
> flush if you want to is in the TCG aware code and not in gdbstub.
> Currently flushes are triggered for cpu_single_step() and breakpoint
> manipulation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index de62d26..ea48415 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1274,7 +1274,6 @@ static void gdb_vm_state_change(void *opaque, int r=
unning, RunState state)
>              cpu->watchpoint_hit =3D NULL;
>              goto send_packet;
>          }
> -        tb_flush(cpu);
>          ret =3D GDB_SIGNAL_TRAP;
>          break;
>      case RUN_STATE_PAUSED:
> @@ -1513,7 +1512,6 @@ gdb_handlesig(CPUState *cpu, int sig)
>
>      /* disable single step if it was enabled */
>      cpu_single_step(cpu, 0);
> -    tb_flush(cpu);
>
>      if (sig !=3D 0) {
>          snprintf(buf, sizeof(buf), "S%02x", target_signal_to_gdb(sig));
> --
> 2.10.2

I think these are right in principle but we should probably
try to exercise the gdbstub fairly thoroughly to convince
ourselves they weren't hiding some bug...

I also think that cpu_single_step() doing a flush is wrong:
we should have the singlestep flag in the tbflags instead.

thanks
-- PMM
