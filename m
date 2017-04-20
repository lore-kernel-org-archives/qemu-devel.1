Received: from eggs.gnu.org ([2001:4830:134:3::10]:35802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1Aku-0006LJ-Jq
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1Aka-0001C2-Bp
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 08:00:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170419222258.13415-1-eblake@redhat.com>
Date: Thu, 20 Apr 2017 13:59:29 +0200
In-Reply-To: <20170419222258.13415-1-eblake@redhat.com> (Eric Blake's message
	of "Wed, 19 Apr 2017 17:22:58 -0500")
Message-ID: <87k26fffxa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Eric Blake <eblake@redhat.com> writes:

> Libvirt would like to be able to distinguish between a SHUTDOWN
> event triggered solely by guest request and one triggered by a
> SIGTERM or other action on the host.  qemu_kill_report() is
> already able to tell whether a shutdown was triggered by a host
> signal (but NOT by a host UI event, such as clicking the X on
> the window), but that information was then lost after being
> printed to stderr.
>
> Enhance the shutdown request path to take a parameter of which
> way it is being triggered, and update ALL callers.  It would have
> been less churn to keep the common case with no arguments as
> meaning guest-triggered, and only modified the host-triggered
> code paths, via a wrapper function, but then we'd still have to
> audit that I didn't miss any host-triggered spots; changing the
> signature forces us to double-check that I correctly categorized
> all callers.
>
> Here is output from 'virsh qemu-monitor-event --loop' with the
> patch installed:
>
> event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":true}
> event STOP at 1492639680.732116 for domain fedora_13: <null>
> event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":false}
>
> Note that libvirt runs qemu with -no-quit: the first SHUTDOWN event
> was triggered by an action I took directly in the guest (shutdown -h),
> at which point qemu stops the vcpus and waits for libvirt to do any
> final cleanups; the second SHUTDOWN event is the result of libvirt
> sending SIGTERM now that it has completed cleanup.
>
> See also https://bugzilla.redhat.com/1384007
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> I did not wire up the RESET event to report guest-triggered, although
> I had to plumb that through all the guests since qemu has options that
> allow remapping reset to shutdown.  It's easy to add that if we want
> it in v3.
>
> The replay driver needs a followup patch if we want to be able to
> faithfully replay the difference between a host- and guest-initiated
> shutdown (for now, the replayed event is always attributed to host).
>
>
> v2: retitle (was "event: Add signal information to SHUTDOWN"),
> completely rework to post bool based on whether it is guest-initiated
> v1: initial submission, exposing just Unix signals from host
> ---
>  qapi/event.json             |  8 ++++++--
>  include/sysemu/sysemu.h     |  4 ++--
>  vl.c                        | 19 +++++++++++--------
>  hw/acpi/core.c              |  4 ++--
>  hw/arm/highbank.c           |  4 ++--
>  hw/arm/integratorcp.c       |  2 +-
>  hw/arm/musicpal.c           |  2 +-
>  hw/arm/omap1.c              |  6 +++---
>  hw/arm/omap2.c              |  2 +-
>  hw/arm/spitz.c              |  2 +-
>  hw/arm/stellaris.c          |  2 +-
>  hw/arm/tosa.c               |  2 +-
>  hw/i386/pc.c                |  2 +-
>  hw/input/pckbd.c            |  4 ++--
>  hw/ipmi/ipmi.c              |  4 ++--
>  hw/isa/lpc_ich9.c           |  2 +-
>  hw/mips/boston.c            |  2 +-
>  hw/mips/mips_malta.c        |  2 +-
>  hw/mips/mips_r4k.c          |  4 ++--
>  hw/misc/arm_sysctl.c        |  8 ++++----
>  hw/misc/cbus.c              |  2 +-
>  hw/misc/macio/cuda.c        |  4 ++--
>  hw/misc/slavio_misc.c       |  4 ++--
>  hw/misc/zynq_slcr.c         |  2 +-
>  hw/pci-host/apb.c           |  4 ++--
>  hw/pci-host/bonito.c        |  2 +-
>  hw/pci-host/piix.c          |  2 +-
>  hw/ppc/e500.c               |  2 +-
>  hw/ppc/mpc8544_guts.c       |  2 +-
>  hw/ppc/ppc.c                |  2 +-
>  hw/ppc/ppc405_uc.c          |  2 +-
>  hw/ppc/spapr_hcall.c        |  2 +-
>  hw/ppc/spapr_rtas.c         |  4 ++--
>  hw/s390x/ipl.c              |  2 +-
>  hw/sh4/r2d.c                |  2 +-
>  hw/timer/etraxfs_timer.c    |  2 +-
>  hw/timer/m48t59.c           |  4 ++--
>  hw/timer/milkymist-sysctl.c |  4 ++--
>  hw/timer/pxa2xx_timer.c     |  2 +-
>  hw/watchdog/watchdog.c      |  2 +-
>  hw/xenpv/xen_domainbuild.c  |  2 +-
>  hw/xtensa/xtfpga.c          |  2 +-
>  kvm-all.c                   |  6 +++---
>  os-win32.c                  |  2 +-
>  qmp.c                       |  4 ++--
>  replay/replay.c             |  5 ++++-
>  target/alpha/sys_helper.c   |  4 ++--
>  target/arm/psci.c           |  4 ++--
>  target/i386/excp_helper.c   |  2 +-
>  target/i386/hax-all.c       |  6 +++---
>  target/i386/helper.c        |  2 +-
>  target/i386/kvm.c           |  2 +-
>  target/s390x/helper.c       |  2 +-
>  target/s390x/kvm.c          |  4 ++--
>  target/s390x/misc_helper.c  |  4 ++--
>  target/sparc/int32_helper.c |  2 +-
>  ui/sdl.c                    |  2 +-
>  ui/sdl2.c                   |  4 ++--
>  xen-hvm.c                   |  2 +-
>  trace-events                |  2 +-
>  ui/cocoa.m                  |  2 +-
>  61 files changed, 106 insertions(+), 96 deletions(-)
>
> diff --git a/qapi/event.json b/qapi/event.json
> index e80f3f4..c230265 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -10,6 +10,10 @@
>  # Emitted when the virtual machine has shut down, indicating that qemu is
>  # about to exit.
>  #
> +# @guest: If true, the shutdown was triggered by a guest request (such as
> +# executing a halt instruction) rather than a host request (such as send=
ing
> +# qemu a SIGINT). (since 2.10)
> +#

"executing a halt instruction" suggests "halt" is a machine instruction.
I think you mean /usr/sbin/halt.  Suggest something like "executing a
halt command".

No objection to Alistair's idea to turn this into an enumeration.

>  # Note: If the command-line option "-no-shutdown" has been specified, qe=
mu will
>  # not exit, and a STOP event will eventually follow the SHUTDOWN event
>  #
> @@ -17,11 +21,11 @@
>  #
>  # Example:
>  #
> -# <- { "event": "SHUTDOWN",
> +# <- { "event": "SHUTDOWN", "data": { "guest": true },
>  #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
>  #
>  ##
> -{ 'event': 'SHUTDOWN' }
> +{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
>
>  ##
>  # @POWERDOWN:
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 576c7ce..d9c8316 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -49,13 +49,13 @@ typedef enum WakeupReason {
>      QEMU_WAKEUP_REASON_OTHER,
>  } WakeupReason;
>
> -void qemu_system_reset_request(void);
> +void qemu_system_reset_request(bool from_guest);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
>  void qemu_system_wakeup_request(WakeupReason reason);
>  void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>  void qemu_register_wakeup_notifier(Notifier *notifier);
> -void qemu_system_shutdown_request(void);
> +void qemu_system_shutdown_request(bool from_guest);
>  void qemu_system_powerdown_request(void);
>  void qemu_register_powerdown_notifier(Notifier *notifier);
>  void qemu_system_debug_request(void);
> diff --git a/vl.c b/vl.c
> index 0b4ed52..599e7cc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1717,7 +1717,7 @@ void qemu_system_guest_panicked(GuestPanicInformati=
on *info)
>      if (!no_shutdown) {
>          qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
>                                         !!info, info, &error_abort);
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(false);

Panicking is a guest action.  Whether the shutdown on panic should be
attributed to guest or host is perhaps debatable.

>      }
>
>      if (info) {
> @@ -1734,10 +1734,10 @@ void qemu_system_guest_panicked(GuestPanicInforma=
tion *info)
>      }
>  }
>
> -void qemu_system_reset_request(void)
> +void qemu_system_reset_request(bool from_guest)
>  {
>      if (no_reboot) {
> -        shutdown_requested =3D 1;
> +        shutdown_requested =3D 1 + from_guest;
>      } else {
>          reset_requested =3D 1;
>      }
> @@ -1810,11 +1810,11 @@ void qemu_system_killed(int signal, pid_t pid)
>      qemu_notify_event();
>  }
>
> -void qemu_system_shutdown_request(void)
> +void qemu_system_shutdown_request(bool from_guest)
>  {
> -    trace_qemu_system_shutdown_request();
> +    trace_qemu_system_shutdown_request(from_guest);
>      replay_shutdown_request();
> -    shutdown_requested =3D 1;
> +    shutdown_requested =3D 1 + from_guest;
>      qemu_notify_event();
>  }
>
> @@ -1845,15 +1845,18 @@ void qemu_system_debug_request(void)
>  static bool main_loop_should_exit(void)
>  {
>      RunState r;
> +    int request;
> +
>      if (qemu_debug_requested()) {
>          vm_stop(RUN_STATE_DEBUG);
>      }
>      if (qemu_suspend_requested()) {
>          qemu_system_suspend();
>      }
> -    if (qemu_shutdown_requested()) {
> +    request =3D qemu_shutdown_requested();
> +    if (request) {
>          qemu_kill_report();
> -        qapi_event_send_shutdown(&error_abort);
> +        qapi_event_send_shutdown(request > 1, &error_abort);
>          if (no_shutdown) {
>              vm_stop(RUN_STATE_SHUTDOWN);
>          } else {
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index e890a5d..8dd2ef1 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -561,7 +561,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t=
 val)
>          uint16_t sus_typ =3D (val >> 10) & 7;
>          switch(sus_typ) {
>          case 0: /* soft power off */
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>              break;
>          case 1:
>              qemu_system_suspend_request();
> @@ -569,7 +569,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t=
 val)
>          default:
>              if (sus_typ =3D=3D ar->pm1.cnt.s4_val) { /* S4 request */
>                  qapi_event_send_suspend_disk(&error_abort);
> -                qemu_system_shutdown_request();
> +                qemu_system_shutdown_request(true);
>              }
>              break;
>          }
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 0a4508c..500582b 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -108,9 +108,9 @@ static void hb_regs_write(void *opaque, hwaddr offset,
>
>      if (offset =3D=3D 0xf00) {
>          if (value =3D=3D 1 || value =3D=3D 2) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          } else if (value =3D=3D 3) {
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>          }
>      }
>
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 5610ffc..efb12e2 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -158,7 +158,7 @@ static void integratorcm_do_remap(IntegratorCMState *=
s)
>  static void integratorcm_set_ctrl(IntegratorCMState *s, uint32_t value)
>  {
>      if (value & 8) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>      if ((s->cm_ctrl ^ value) & 1) {
>          /* (value & 1) !=3D 0 means the green "MISC LED" is lit.
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index cbbca4e..ca79548 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -898,7 +898,7 @@ static void mv88w8618_pit_write(void *opaque, hwaddr =
offset,
>
>      case MP_BOARD_RESET:
>          if (value =3D=3D MP_BOARD_RESET_MAGIC) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      }
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index b3cf0ec..cd329c3 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -355,7 +355,7 @@ static void omap_wd_timer_write(void *opaque, hwaddr =
addr,
>                  /* XXX: on T|E hardware somehow this has no effect,
>                   * on Zire 71 it works as specified.  */
>                  s->reset =3D 1;
> -                qemu_system_reset_request();
> +                qemu_system_reset_request(true);
>              }
>          }
>          s->last_wr =3D value & 0xff;
> @@ -1546,7 +1546,7 @@ static inline void omap_clkm_idlect1_update(struct =
omap_mpu_state_s *s,
>          cpu_interrupt(CPU(s->cpu), CPU_INTERRUPT_HALT);
>      }
>      if (!(value & (1 << 10)))				/* WKUP_MODE */
> -        qemu_system_shutdown_request();	/* XXX: disable wakeup from IRQ =
*/
> +        qemu_system_shutdown_request(true); /* XXX: disable wakeup from =
IRQ */
>
>  #define SET_CANIDLE(clock, bit)				\
>      if (diff & (1 << bit)) {				\
> @@ -1693,7 +1693,7 @@ static void omap_clkm_write(void *opaque, hwaddr ad=
dr,
>          diff =3D s->clkm.arm_rstct1 ^ value;
>          s->clkm.arm_rstct1 =3D value & 0x0007;
>          if (value & 9) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              s->clkm.cold_start =3D 0xa;
>          }
>          if (diff & ~value & 4) {				/* DSP_RST */
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index cf1b4ba..3e9f195 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -1610,7 +1610,7 @@ static void omap_prcm_write(void *opaque, hwaddr ad=
dr,
>      case 0x450:	/* RM_RSTCTRL_WKUP */
>          /* TODO: reset */
>          if (value & 2)
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          break;
>      case 0x454:	/* RM_RSTTIME_WKUP */
>          s->rsttime_wkup =3D value & 0x1fff;
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index fe2d5a7..85023d8 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -848,7 +848,7 @@ static void spitz_lcd_hsync_handler(void *opaque, int=
 line, int level)
>  static void spitz_reset(void *opaque, int line, int level)
>  {
>      if (level) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>  }
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 9edcd49..cbf6b92 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1183,7 +1183,7 @@ static
>  void do_sys_reset(void *opaque, int n, int level)
>  {
>      if (level) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>  }
>
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 9f58a23..6c88818 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -90,7 +90,7 @@ static void tosa_out_switch(void *opaque, int line, int=
 level)
>  static void tosa_reset(void *opaque, int line, int level)
>  {
>      if (level) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>  }
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d24388e..be52c82 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -519,7 +519,7 @@ static void port92_write(void *opaque, hwaddr addr, u=
int64_t val,
>      s->outport =3D val;
>      qemu_set_irq(s->a20_out, (val >> 1) & 1);
>      if ((val & 1) && !(oldval & 1)) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>  }
>
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index d414288..2513be8 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -226,7 +226,7 @@ static void outport_write(KBDState *s, uint32_t val)
>      s->outport =3D val;
>      qemu_set_irq(s->a20_out, (val >> 1) & 1);
>      if (!(val & 1)) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>  }
>
> @@ -301,7 +301,7 @@ static void kbd_write_command(void *opaque, hwaddr ad=
dr,
>          s->outport &=3D ~KBD_OUT_A20;
>          break;
>      case KBD_CCMD_RESET:
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          break;
>      case KBD_CCMD_NO_OP:
>          /* ignore that */
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index 5cf1caa..a64fc25 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -44,14 +44,14 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_=
op op, int checkonly)
>          if (checkonly) {
>              return 0;
>          }
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          return 0;
>
>      case IPMI_POWEROFF_CHASSIS:
>          if (checkonly) {
>              return 0;
>          }
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>          return 0;
>
>      case IPMI_SEND_NMI:
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index a0866c3..8578a17 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -606,7 +606,7 @@ static void ich9_rst_cnt_write(void *opaque, hwaddr a=
ddr, uint64_t val,
>      ICH9LPCState *lpc =3D opaque;
>
>      if (val & 4) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          return;
>      }
>      lpc->rst_cnt =3D val & 0xA; /* keep FULL_RST (bit 3) and SYS_RST (bi=
t 1) */
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 83f7b82..d54fc0c 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -232,7 +232,7 @@ static void boston_platreg_write(void *opaque, hwaddr=
 addr,
>          break;
>      case PLAT_SOFTRST_CTL:
>          if (val & PLAT_SOFTRST_CTL_SYSRESET) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      default:
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 5dd177e..e1c58b5 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -470,7 +470,7 @@ static void malta_fpga_write(void *opaque, hwaddr add=
r,
>      /* SOFTRES Register */
>      case 0x00500:
>          if (val =3D=3D 0x42)
> -            qemu_system_reset_request ();
> +            qemu_system_reset_request(true);
>          break;
>
>      /* BRKRES Register */
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 748586e..3863a7a 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -53,9 +53,9 @@ static void mips_qemu_write (void *opaque, hwaddr addr,
>                               uint64_t val, unsigned size)
>  {
>      if ((addr & 0xffff) =3D=3D 0 && val =3D=3D 42)
> -        qemu_system_reset_request ();
> +        qemu_system_reset_request(true);
>      else if ((addr & 0xffff) =3D=3D 4 && val =3D=3D 42)
> -        qemu_system_shutdown_request ();
> +        qemu_system_shutdown_request(true);
>  }
>
>  static uint64_t mips_qemu_read (void *opaque, hwaddr addr,
> diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
> index 8524008..bc1dfc6 100644
> --- a/hw/misc/arm_sysctl.c
> +++ b/hw/misc/arm_sysctl.c
> @@ -351,13 +351,13 @@ static bool vexpress_cfgctrl_write(arm_sysctl_state=
 *s, unsigned int dcc,
>          break;
>      case SYS_CFG_SHUTDOWN:
>          if (site =3D=3D SYS_CFG_SITE_MB && device =3D=3D 0) {
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>              return true;
>          }
>          break;
>      case SYS_CFG_REBOOT:
>          if (site =3D=3D SYS_CFG_SITE_MB && device =3D=3D 0) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              return true;
>          }
>          break;
> @@ -429,7 +429,7 @@ static void arm_sysctl_write(void *opaque, hwaddr off=
set,
>              if (s->lockval =3D=3D LOCK_VALUE) {
>                  s->resetlevel =3D val;
>                  if (val & 0x100) {
> -                    qemu_system_reset_request();
> +                    qemu_system_reset_request(true);
>                  }
>              }
>              break;
> @@ -438,7 +438,7 @@ static void arm_sysctl_write(void *opaque, hwaddr off=
set,
>              if (s->lockval =3D=3D LOCK_VALUE) {
>                  s->resetlevel =3D val;
>                  if (val & 0x04) {
> -                    qemu_system_reset_request();
> +                    qemu_system_reset_request(true);
>                  }
>              }
>              break;
> diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
> index 0c207e3..cf9b82d 100644
> --- a/hw/misc/cbus.c
> +++ b/hw/misc/cbus.c
> @@ -356,7 +356,7 @@ static inline void retu_write(CBusRetu *s, int reg, u=
int16_t val)
>
>      case RETU_REG_WATCHDOG:
>          if (val =3D=3D 0 && (s->cc[0] & 2))
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>          break;
>
>      case RETU_REG_TXCR:
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 05c02fb..0c9299c 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -612,7 +612,7 @@ static bool cuda_cmd_powerdown(CUDAState *s,
>          return false;
>      }
>
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(true);
>      return true;
>  }
>
> @@ -624,7 +624,7 @@ static bool cuda_cmd_reset_system(CUDAState *s,
>          return false;
>      }
>
> -    qemu_system_reset_request();
> +    qemu_system_reset_request(true);
>      return true;
>  }
>
> diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
> index edd5de0..7555ebf 100644
> --- a/hw/misc/slavio_misc.c
> +++ b/hw/misc/slavio_misc.c
> @@ -258,7 +258,7 @@ static void slavio_aux2_mem_writeb(void *opaque, hwad=
dr addr,
>          val &=3D AUX2_PWROFF;
>      s->aux2 =3D val;
>      if (val & AUX2_PWROFF)
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>      slavio_misc_update_irq(s);
>  }
>
> @@ -338,7 +338,7 @@ static void slavio_sysctrl_mem_writel(void *opaque, h=
waddr addr,
>      case 0:
>          if (val & SYS_RESET) {
>              s->sysctrl =3D SYS_RESETSTAT;
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      default:
> diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
> index 7891219..d819069 100644
> --- a/hw/misc/zynq_slcr.c
> +++ b/hw/misc/zynq_slcr.c
> @@ -405,7 +405,7 @@ static void zynq_slcr_write(void *opaque, hwaddr offs=
et,
>      switch (offset) {
>      case PSS_RST_CTRL:
>          if (val & R_PSS_RST_CTRL_SOFT_RST) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      }
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 653e711..e04b8e7 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -482,9 +482,9 @@ static void apb_config_writel (void *opaque, hwaddr a=
ddr,
>              s->reset_control |=3D val & RESET_WMASK;
>              if (val & SOFT_POR) {
>                  s->nr_resets =3D 0;
> -                qemu_system_reset_request();
> +                qemu_system_reset_request(true);
>              } else if (val & SOFT_XIR) {
> -                qemu_system_reset_request();
> +                qemu_system_reset_request(true);
>              }
>          }
>          break;
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 1999ece..03c8589 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -269,7 +269,7 @@ static void bonito_writel(void *opaque, hwaddr addr,
>          }
>          s->regs[saddr] =3D val;
>          if (reset) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      case BONITO_INTENSET:
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index f9218aa..68c91eb 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -638,7 +638,7 @@ static void rcr_write(void *opaque, hwaddr addr, uint=
64_t val, unsigned len)
>      PIIX3State *d =3D opaque;
>
>      if (val & 4) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          return;
>      }
>      d->rcr =3D val & 2; /* keep System Reset type only */
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index f7df238..c62de18 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -774,7 +774,7 @@ static qemu_irq *ppce500_init_mpic(MachineState *mach=
ine, PPCE500Params *params,
>  static void ppce500_power_off(void *opaque, int line, int on)
>  {
>      if (on) {
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>      }
>  }
>
> diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
> index ba69178..5f1fc56 100644
> --- a/hw/ppc/mpc8544_guts.c
> +++ b/hw/ppc/mpc8544_guts.c
> @@ -98,7 +98,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr add=
r,
>      switch (addr) {
>      case MPC8544_GUTS_ADDR_RSTCR:
>          if (value & MPC8544_GUTS_RSTCR_RESET) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      default:
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 5f93083..4598f47 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -412,7 +412,7 @@ static void ppce500_set_irq(void *opaque, int pin, in=
t level)
>              if (level) {
>                  LOG_IRQ("%s: reset the PowerPC system\n",
>                              __func__);
> -                qemu_system_reset_request();
> +                qemu_system_reset_request(true);
>              }
>              break;
>          case PPCE500_INPUT_RESET_CORE:
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index d5df94a..0b8a283 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -1807,7 +1807,7 @@ void ppc40x_chip_reset(PowerPCCPU *cpu)
>  void ppc40x_system_reset(PowerPCCPU *cpu)
>  {
>      printf("Reset PowerPC system\n");
> -    qemu_system_reset_request();
> +    qemu_system_reset_request(true);
>  }
>
>  void store_40x_dbcr0 (CPUPPCState *env, uint32_t val)
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index f05a90e..6885400 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1008,7 +1008,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      spapr_ovec_cleanup(ov5_updates);
>
>      if (spapr->cas_reboot) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      }
>
>      return H_SUCCESS;
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 619f32c..5647208 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -110,7 +110,7 @@ static void rtas_power_off(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>      }
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(true);
>      cpu_stop_current();
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> @@ -124,7 +124,7 @@ static void rtas_system_reboot(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>      }
> -    qemu_system_reset_request();
> +    qemu_system_reset_request(true);
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 7978c7d..91de8a8 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -363,7 +363,7 @@ void s390_reipl_request(void)
>      S390IPLState *ipl =3D get_ipl_device();
>
>      ipl->reipl_requested =3D true;
> -    qemu_system_reset_request();
> +    qemu_system_reset_request(true);
>  }
>
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index 6d06968..6e23386 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -164,7 +164,7 @@ r2d_fpga_write(void *opaque, hwaddr addr, uint64_t va=
lue, unsigned int size)
>  	break;
>      case PA_POWOFF:
>          if (value & 1) {
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>          }
>          break;
>      case PA_VERREG:
> diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
> index 8e18236..9fc6582 100644
> --- a/hw/timer/etraxfs_timer.c
> +++ b/hw/timer/etraxfs_timer.c
> @@ -207,7 +207,7 @@ static void watchdog_hit(void *opaque)
>          qemu_irq_raise(t->nmi);
>      }
>      else
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>
>      t->wd_hits++;
>  }
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index 474981a..7e17fa3 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU M48T59 and M48T08 NVRAM emulation for PPC PREP and Sparc platfor=
ms
>   *
> - * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
> + * Copyright (c) 2003-2005, 2007, 2017 Jocelyn Mayer
>   * Copyright (c) 2013 Herv=C3=A9 Poussineau
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> @@ -159,7 +159,7 @@ static void watchdog_cb (void *opaque)
>  	NVRAM->buffer[0x1FF7] =3D 0x00;
>  	NVRAM->buffer[0x1FFC] &=3D ~0x40;
>          /* May it be a hw CPU Reset instead ? */
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      } else {
>  	qemu_set_irq(NVRAM->IRQ, 1);
>  	qemu_set_irq(NVRAM->IRQ, 0);
> diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
> index 4488590..f7cedd9 100644
> --- a/hw/timer/milkymist-sysctl.c
> +++ b/hw/timer/milkymist-sysctl.c
> @@ -90,7 +90,7 @@ static void sysctl_icap_write(MilkymistSysctlState *s, =
uint32_t value)
>      trace_milkymist_sysctl_icap_write(value);
>      switch (value & 0xffff) {
>      case 0x000e:
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>          break;
>      }
>  }
> @@ -195,7 +195,7 @@ static void sysctl_write(void *opaque, hwaddr addr, u=
int64_t value,
>          s->regs[addr] =3D 1;
>          break;
>      case R_SYSTEM_ID:
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          break;
>
>      case R_GPIO_IN:
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index 59002b4..52fe234 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -401,7 +401,7 @@ static void pxa2xx_timer_tick(void *opaque)
>      if (t->num =3D=3D 3)
>          if (i->reset3 & 1) {
>              i->reset3 =3D 0;
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>  }
>
> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
> index 2aeaf1f..685f976 100644
> --- a/hw/watchdog/watchdog.c
> +++ b/hw/watchdog/watchdog.c
> @@ -110,7 +110,7 @@ void watchdog_perform_action(void)
>      switch (watchdog_action) {
>      case WDT_RESET:             /* same as 'system_reset' in monitor */
>          qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_RESET, &erro=
r_abort);
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          break;
>
>      case WDT_SHUTDOWN:          /* same as 'system_powerdown' in monitor=
 */
> diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
> index 457a897..1f2f9d5 100644
> --- a/hw/xenpv/xen_domainbuild.c
> +++ b/hw/xenpv/xen_domainbuild.c
> @@ -148,7 +148,7 @@ static void xen_domain_poll(void *opaque)
>      return;
>
>  quit:
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(true);
>  }
>
>  static int xen_domain_watcher(void)
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 11176e2..b6d42f0 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -100,7 +100,7 @@ static void lx60_fpga_write(void *opaque, hwaddr addr,
>
>      case 0x10: /*board reset*/
>          if (val =3D=3D 0xdead) {
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>          }
>          break;
>      }
> diff --git a/kvm-all.c b/kvm-all.c
> index 90b8573..bc6a7e7 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -2052,7 +2052,7 @@ int kvm_cpu_exec(CPUState *cpu)
>              break;
>          case KVM_EXIT_SHUTDOWN:
>              DPRINTF("shutdown\n");
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              ret =3D EXCP_INTERRUPT;
>              break;
>          case KVM_EXIT_UNKNOWN:
> @@ -2066,11 +2066,11 @@ int kvm_cpu_exec(CPUState *cpu)
>          case KVM_EXIT_SYSTEM_EVENT:
>              switch (run->system_event.type) {
>              case KVM_SYSTEM_EVENT_SHUTDOWN:
> -                qemu_system_shutdown_request();
> +                qemu_system_shutdown_request(true);
>                  ret =3D EXCP_INTERRUPT;
>                  break;
>              case KVM_SYSTEM_EVENT_RESET:
> -                qemu_system_reset_request();
> +                qemu_system_reset_request(true);
>                  ret =3D EXCP_INTERRUPT;
>                  break;
>              case KVM_SYSTEM_EVENT_CRASH:
> diff --git a/os-win32.c b/os-win32.c
> index ae98574..0d2b0dc 100644
> --- a/os-win32.c
> +++ b/os-win32.c
> @@ -52,7 +52,7 @@ int setenv(const char *name, const char *value, int ove=
rwrite)
>
>  static BOOL WINAPI qemu_ctrl_handler(DWORD type)
>  {
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(false);
>      /* Windows 7 kills application when the function returns.
>         Sleep here to give QEMU a try for closing.
>         Sleep period is 10000ms because Windows kills the program
> diff --git a/qmp.c b/qmp.c
> index a744e44..8874afb 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -84,7 +84,7 @@ UuidInfo *qmp_query_uuid(Error **errp)
>  void qmp_quit(Error **errp)
>  {
>      no_shutdown =3D 0;
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(false);
>  }
>
>  void qmp_stop(Error **errp)
> @@ -105,7 +105,7 @@ void qmp_stop(Error **errp)
>
>  void qmp_system_reset(Error **errp)
>  {
> -    qemu_system_reset_request();
> +    qemu_system_reset_request(false);
>  }
>
>  void qmp_system_powerdown(Error **erp)
> diff --git a/replay/replay.c b/replay/replay.c
> index f810628..36b7fd6 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -51,7 +51,10 @@ bool replay_next_event_is(int event)
>          switch (replay_state.data_kind) {
>          case EVENT_SHUTDOWN:
>              replay_finish_event();
> -            qemu_system_shutdown_request();
> +            /* TODO: track source of shutdown request, to replay a
> +             * guest-initiated request rather than always claiming to
> +             * be from the host? */
> +            qemu_system_shutdown_request(false);

This is what your "need a followup patch" refers to.  I'd like to have
an opinion from someone familiar with replay on what exactly we need
here.

>              break;
>          default:
>              /* clock, time_t, checkpoint and other events */
> diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
> index 652195d..3025709 100644
> --- a/target/alpha/sys_helper.c
> +++ b/target/alpha/sys_helper.c
> @@ -60,9 +60,9 @@ void helper_tb_flush(CPUAlphaState *env)
>  void helper_halt(uint64_t restart)
>  {
>      if (restart) {
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>      } else {
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>      }
>  }
>
> diff --git a/target/arm/psci.c b/target/arm/psci.c
> index ade9fe2..d48a51f 100644
> --- a/target/arm/psci.c
> +++ b/target/arm/psci.c
> @@ -137,7 +137,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
>          }
>          break;
>      case QEMU_PSCI_0_2_FN_SYSTEM_RESET:
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          /* QEMU reset and shutdown are async requests, but PSCI
>           * mandates that we never return from the reset/shutdown
>           * call, so power the CPU off now so it doesn't execute
> @@ -145,7 +145,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
>           */
>          goto cpu_off;
>      case QEMU_PSCI_0_2_FN_SYSTEM_OFF:
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>          goto cpu_off;
>      case QEMU_PSCI_0_1_FN_CPU_ON:
>      case QEMU_PSCI_0_2_FN_CPU_ON:
> diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
> index ee596c6..ca62f47 100644
> --- a/target/i386/excp_helper.c
> +++ b/target/i386/excp_helper.c
> @@ -59,7 +59,7 @@ static int check_exception(CPUX86State *env, int intno,=
 int *error_code,
>
>          qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
>
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          return EXCP_HLT;
>      }
>  #endif
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index ef13015..682ab98 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -540,14 +540,14 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>          /* Guest state changed, currently only for shutdown */
>          case HAX_EXIT_STATECHANGE:
>              fprintf(stdout, "VCPU shutdown request\n");
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>              hax_vcpu_sync_state(env, 0);
>              ret =3D 1;
>              break;
>          case HAX_EXIT_UNKNOWN_VMEXIT:
>              fprintf(stderr, "Unknown VMX exit %x from guest\n",
>                      ht->_exit_reason);
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              hax_vcpu_sync_state(env, 0);
>              cpu_dump_state(cpu, stderr, fprintf, 0);
>              ret =3D -1;
> @@ -578,7 +578,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
>              break;
>          default:
>              fprintf(stderr, "Unknown exit %x from HAX\n", ht->_exit_stat=
us);
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              hax_vcpu_sync_state(env, 0);
>              cpu_dump_state(cpu, stderr, fprintf, 0);
>              ret =3D 1;
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index f11cac6..922ebcc 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -1212,7 +1212,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_=
cpu_data data)
>                             " triple fault\n",
>                             cs->cpu_index);
>              qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              return;
>          }
>          if (banks[1] & MCI_STATUS_VAL) {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 55865db..6545433 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2930,7 +2930,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>
>          if (env->exception_injected =3D=3D EXCP08_DBLE) {
>              /* this means triple fault */
> -            qemu_system_reset_request();
> +            qemu_system_reset_request(true);
>              cs->exit_request =3D 1;
>              return 0;
>          }
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 68bd2f9..3a407db 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -266,7 +266,7 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint=
64_t addr)
>          S390CPU *cpu =3D s390_env_get_cpu(env);
>          if (s390_cpu_halt(cpu) =3D=3D 0) {
>  #ifndef CONFIG_USER_ONLY
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>  #endif
>          }
>      }
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ac47154..dffa446 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1929,7 +1929,7 @@ static int handle_intercept(S390CPU *cpu)
>              cpu_synchronize_state(cs);
>              if (s390_cpu_halt(cpu) =3D=3D 0) {
>                  if (is_special_wait_psw(cs)) {
> -                    qemu_system_shutdown_request();
> +                    qemu_system_shutdown_request(true);
>                  } else {
>                      qemu_system_guest_panicked(NULL);
>                  }
> @@ -1938,7 +1938,7 @@ static int handle_intercept(S390CPU *cpu)
>              break;
>          case ICPT_CPU_STOP:
>              if (s390_cpu_set_state(CPU_STATE_STOPPED, cpu) =3D=3D 0) {
> -                qemu_system_shutdown_request();
> +                qemu_system_shutdown_request(true);
>              }
>              if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS) {
>                  kvm_s390_store_status(cpu, KVM_S390_STORE_STATUS_DEF_ADD=
R,
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 93b0e61..f67525b 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -530,11 +530,11 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t =
order_code, uint32_t r1,
>          break;
>  #if !defined(CONFIG_USER_ONLY)
>      case SIGP_RESTART:
> -        qemu_system_reset_request();
> +        qemu_system_reset_request(true);
>          cpu_loop_exit(CPU(s390_env_get_cpu(env)));
>          break;
>      case SIGP_STOP:
> -        qemu_system_shutdown_request();
> +        qemu_system_shutdown_request(true);
>          cpu_loop_exit(CPU(s390_env_get_cpu(env)));
>          break;
>  #endif
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index 09afe13..a059575 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -109,7 +109,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>      if (env->psret =3D=3D 0) {
>          if (cs->exception_index =3D=3D 0x80 &&
>              env->def->features & CPU_FEATURE_TA0_SHUTDOWN) {
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(true);
>          } else {
>              cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Error =
state",
>                        cs->exception_index);
> diff --git a/ui/sdl.c b/ui/sdl.c
> index 37c21a0..331db83 100644
> --- a/ui/sdl.c
> +++ b/ui/sdl.c
> @@ -837,7 +837,7 @@ static void sdl_refresh(DisplayChangeListener *dcl)
>          case SDL_QUIT:
>              if (!no_quit) {
>                  no_shutdown =3D 0;
> -                qemu_system_shutdown_request();
> +                qemu_system_shutdown_request(false);
>              }
>              break;
>          case SDL_MOUSEMOTION:
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index faf9bdf..f6af693 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -568,7 +568,7 @@ static void handle_windowevent(SDL_Event *ev)
>      case SDL_WINDOWEVENT_CLOSE:
>          if (!no_quit) {
>              no_shutdown =3D 0;
> -            qemu_system_shutdown_request();
> +            qemu_system_shutdown_request(false);
>          }
>          break;
>      case SDL_WINDOWEVENT_SHOWN:
> @@ -611,7 +611,7 @@ void sdl2_poll_events(struct sdl2_console *scon)
>          case SDL_QUIT:
>              if (!no_quit) {
>                  no_shutdown =3D 0;
> -                qemu_system_shutdown_request();
> +                qemu_system_shutdown_request(false);
>              }
>              break;
>          case SDL_MOUSEMOTION:
> diff --git a/xen-hvm.c b/xen-hvm.c
> index 5043beb..9ac311f 100644
> --- a/xen-hvm.c
> +++ b/xen-hvm.c
> @@ -1388,7 +1388,7 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
>      va_end(ap);
>      fprintf(stderr, "Will destroy the domain.\n");
>      /* destroy the domain */
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(false);
>  }
>
>  void xen_modified_memory(ram_addr_t start, ram_addr_t length)
> diff --git a/trace-events b/trace-events
> index b07a09b..aefaa0c 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -38,7 +38,7 @@ vm_state_notify(int running, int reason) "running %d re=
ason %d"
>  load_file(const char *name, const char *path) "name %s location %s"
>  runstate_set(int new_state) "new state %d"
>  system_wakeup_request(int reason) "reason=3D%d"
> -qemu_system_shutdown_request(void) ""
> +qemu_system_shutdown_request(bool from_guest) "from_guest=3D%d"
>  qemu_system_powerdown_request(void) ""
>
>  # spice-qemu-char.c
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index c81f7b6..4cac11c 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -905,7 +905,7 @@ QemuCocoaView *cocoaView;
>  {
>      COCOA_DEBUG("QemuCocoaAppController: applicationWillTerminate\n");
>
> -    qemu_system_shutdown_request();
> +    qemu_system_shutdown_request(false);
>      exit(0);
>  }

Amazing number of ways to shut down or reset a machine.

Looks sane on first glance.
