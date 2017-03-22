Received: from eggs.gnu.org ([2001:4830:134:3::10]:45175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1cqhpx-00016s-2P
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1cqhpv-0002F0-FM
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:06:09 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1cqhpv-0002E5-AT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:06:07 -0400
Received: by mail-ot0-x241.google.com with SMTP id a12so25976461ota.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:06:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315144825.3108-1-alex.bennee@linaro.org>
References: <20170315144825.3108-1-alex.bennee@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 22 Mar 2017 16:06:05 +0100
Message-ID: <CABoDooPQt2WJWJcf0FzwvJQU8Yb7OQjfAwbioY_+0ED_nVq-dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] ui/console: ensure graphic updates
 don't race with TCG vCPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Alex,

this patch breaks:

  http://wiki.qemu.org/download/arm-test-0.2.tar.gz

qemu-system-arm -kernel zImage.integrator -initrd arm_root.img
-append "console=3DttyAMA0" -machine integratorcp -serial stdio -icount
0
Uncompressing Linux........................................................=
..................
done, booting the kernel.
qemu-system-arm: /work/qemu/qemu/memory.c:920:
memory_region_transaction_commit: Assertion
`qemu_mutex_iothread_locked()' failed.

The backtrace looks like this:

#4  0x00005555557ced26 in memory_region_transaction_commit ()
    at /work/qemu/qemu/memory.c:920
#5  0x0000555555959b82 in pl110_update_display (opaque=3D0x555556a839e0)
    at hw/display/pl110.c:245
#6  0x0000555555a60931 in sdl_refresh (dcl=3D0x555556b90d40) at ui/sdl.c:82=
1
#7  0x00005555558f9f91 in process_queued_cpu_work (
    cpu=3Dcpu@entry=3D0x5555566c6810) at cpus-common.c:338
#8  0x00005555557ba5a8 in qemu_wait_io_event_common (
    cpu=3Dcpu@entry=3D0x5555566c6810) at /work/qemu/qemu/cpus.c:1027
#9  0x00005555557ba9bb in qemu_tcg_wait_io_event (cpu=3Dcpu@entry=3D0x55555=
66c6810)
    at /work/qemu/qemu/cpus.c:1048
#10 0x00005555557bc2bd in qemu_tcg_cpu_thread_fn (arg=3D0x5555566c6810)
    at /work/qemu/qemu/cpus.c:1440
#11 0x00007ffff5f4a6ba in start_thread (arg=3D0x7fffee650700)
    at pthread_create.c:333
#12 0x00007ffff5c8082d in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109

BTW is it easier if I enter such bug reports in QEMU launchpad?

Thanks,

Laurent

On Wed, Mar 15, 2017 at 3:48 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Commit 8d04fb55..
>
>   tcg: drop global lock during TCG code execution
>
> ..broke the assumption that updates to the GUI couldn't happen at the
> same time as TCG vCPUs where running. As a result the TCG vCPU could
> still be updating a directly mapped frame-buffer while the display
> side was updating. This would cause artefacts to appear when the
> update code assumed that memory block hadn't changed.
>
> The simplest solution is to ensure the two things can't happen at the
> same time like the old BQL locking scheme. Here we use the solution
> introduced for MTTCG and schedule the update as async_safe_work when
> we know no vCPUs can be running.
>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  ui/console.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index d1ff7504ec..37a69e27de 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1575,13 +1575,29 @@ bool dpy_gfx_check_format(QemuConsole *con,
>      return true;
>  }
>
> +/*
> + * Safe DPY refresh for TCG guests. This runs when the TCG vCPUs are
> + * quiescent so we can avoid races between dirty page tracking for
> + * direct frame-buffer access by the guest.
> + */
> +static void do_safe_dpy_refresh(CPUState *cpu, run_on_cpu_data opaque)
> +{
> +    DisplayChangeListener *dcl =3D opaque.host_ptr;
> +    dcl->ops->dpy_refresh(dcl);
> +}
> +
>  static void dpy_refresh(DisplayState *s)
>  {
>      DisplayChangeListener *dcl;
>
>      QLIST_FOREACH(dcl, &s->listeners, next) {
>          if (dcl->ops->dpy_refresh) {
> -            dcl->ops->dpy_refresh(dcl);
> +            if (tcg_enabled()) {
> +                async_safe_run_on_cpu(first_cpu, do_safe_dpy_refresh,
> +                                      RUN_ON_CPU_HOST_PTR(dcl));
> +            } else {
> +                dcl->ops->dpy_refresh(dcl);
> +            }
>          }
>      }
>  }
> --
> 2.11.0
>
>
