Received: from eggs.gnu.org ([2001:4830:134:3::10]:54621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7q4y-0007bS-Q6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7q4u-0003gd-Qx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:20:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  8 May 2017 16:19:51 -0500
Message-Id: <20170508211953.28017-4-eblake@redhat.com>
In-Reply-To: <20170508211953.28017-1-eblake@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Burton <paul.burton@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Stefan Weil <sw@weilnetz.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Old World" <qemu-ppc@nongnu.org>, "open list:Overall" <kvm@vger.kernel.org>

Time to wire up all the call sites that request a shutdown or
reset to use the enum added in the previous patch.

It would have been less churn to keep the common case with no
arguments as meaning guest-triggered, and only modified the
host-triggered code paths, via a wrapper function, but then we'd
still have to audit that I didn't miss any host-triggered spots;
changing the signature forces us to double-check that I correctly
categorized all callers.

Since command line options can change whether a guest reset request
causes an actual reset vs. a shutdown, it's easy to also add the
information to reset requests.

Replay adds a FIXME to preserve the cause across the replay stream,
that will be tackled in the next patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au> [ppc parts]
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> [SPARC part=
]

---
v7: no change
v6: defer event additions to later, add reviews of unchanged portions
v5: drop accidental addition of unrelated files
v4: s/ShutdownType/ShutdownCause/, no thanks to mingw header pollution
v3: retitle again, fix qemu-iotests, use enum rather than raw bool
in all callers
v2: retitle (was "event: Add signal information to SHUTDOWN"),
completely rework to post bool based on whether it is guest-initiated
v1: initial submission, exposing just Unix signals from host
---
 include/sysemu/sysemu.h     |  4 ++--
 vl.c                        | 17 ++++++++---------
 hw/acpi/core.c              |  4 ++--
 hw/arm/highbank.c           |  4 ++--
 hw/arm/integratorcp.c       |  2 +-
 hw/arm/musicpal.c           |  2 +-
 hw/arm/omap1.c              | 10 ++++++----
 hw/arm/omap2.c              |  2 +-
 hw/arm/spitz.c              |  2 +-
 hw/arm/stellaris.c          |  2 +-
 hw/arm/tosa.c               |  2 +-
 hw/i386/pc.c                |  2 +-
 hw/i386/xen/xen-hvm.c       |  2 +-
 hw/input/pckbd.c            |  4 ++--
 hw/ipmi/ipmi.c              |  4 ++--
 hw/isa/lpc_ich9.c           |  2 +-
 hw/mips/boston.c            |  2 +-
 hw/mips/mips_malta.c        |  2 +-
 hw/mips/mips_r4k.c          |  4 ++--
 hw/misc/arm_sysctl.c        |  8 ++++----
 hw/misc/cbus.c              |  2 +-
 hw/misc/macio/cuda.c        |  4 ++--
 hw/misc/slavio_misc.c       |  4 ++--
 hw/misc/zynq_slcr.c         |  2 +-
 hw/pci-host/apb.c           |  4 ++--
 hw/pci-host/bonito.c        |  2 +-
 hw/pci-host/piix.c          |  2 +-
 hw/ppc/e500.c               |  2 +-
 hw/ppc/mpc8544_guts.c       |  2 +-
 hw/ppc/ppc.c                |  2 +-
 hw/ppc/ppc405_uc.c          |  2 +-
 hw/ppc/spapr_hcall.c        |  2 +-
 hw/ppc/spapr_rtas.c         |  4 ++--
 hw/s390x/ipl.c              |  2 +-
 hw/sh4/r2d.c                |  2 +-
 hw/timer/etraxfs_timer.c    |  2 +-
 hw/timer/m48t59.c           |  4 ++--
 hw/timer/milkymist-sysctl.c |  4 ++--
 hw/timer/pxa2xx_timer.c     |  2 +-
 hw/watchdog/watchdog.c      |  2 +-
 hw/xenpv/xen_domainbuild.c  |  2 +-
 hw/xtensa/xtfpga.c          |  2 +-
 kvm-all.c                   |  6 +++---
 os-win32.c                  |  2 +-
 qmp.c                       |  4 ++--
 replay/replay.c             |  3 ++-
 target/alpha/sys_helper.c   |  4 ++--
 target/arm/psci.c           |  4 ++--
 target/i386/excp_helper.c   |  2 +-
 target/i386/hax-all.c       |  6 +++---
 target/i386/helper.c        |  2 +-
 target/i386/kvm.c           |  2 +-
 target/s390x/helper.c       |  2 +-
 target/s390x/kvm.c          |  4 ++--
 target/s390x/misc_helper.c  |  4 ++--
 target/sparc/int32_helper.c |  2 +-
 ui/sdl.c                    |  2 +-
 ui/sdl2.c                   |  4 ++--
 trace-events                |  2 +-
 ui/cocoa.m                  |  2 +-
 60 files changed, 98 insertions(+), 96 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 98b3274..fe197aa 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -61,13 +61,13 @@ typedef enum WakeupReason {
     QEMU_WAKEUP_REASON_OTHER,
 } WakeupReason;

-void qemu_system_reset_request(void);
+void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
 void qemu_system_wakeup_request(WakeupReason reason);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
-void qemu_system_shutdown_request(void);
+void qemu_system_shutdown_request(ShutdownCause reason);
 void qemu_system_powerdown_request(void);
 void qemu_register_powerdown_notifier(Notifier *notifier);
 void qemu_system_debug_request(void);
diff --git a/vl.c b/vl.c
index 8df886e..2d546460 100644
--- a/vl.c
+++ b/vl.c
@@ -1724,7 +1724,7 @@ void qemu_system_guest_panicked(GuestPanicInformati=
on *info)
     if (!no_shutdown) {
         qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
                                        !!info, info, &error_abort);
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_PANIC);
     }

     if (info) {
@@ -1741,13 +1741,12 @@ void qemu_system_guest_panicked(GuestPanicInforma=
tion *info)
     }
 }

-void qemu_system_reset_request(void)
+void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot) {
-        /* FIXME - add a parameter to allow callers to specify reason */
-        shutdown_requested =3D SHUTDOWN_CAUSE_HOST_ERROR;
+        shutdown_requested =3D reason;
     } else {
-        reset_requested =3D SHUTDOWN_CAUSE_HOST_ERROR;
+        reset_requested =3D reason;
     }
     cpu_stop_current();
     qemu_notify_event();
@@ -1818,12 +1817,12 @@ void qemu_system_killed(int signal, pid_t pid)
     qemu_notify_event();
 }

-void qemu_system_shutdown_request(void)
+void qemu_system_shutdown_request(ShutdownCause reason)
 {
-    trace_qemu_system_shutdown_request();
+    trace_qemu_system_shutdown_request(reason);
+    /* FIXME - add a parameter to let replay preserve reason */
     replay_shutdown_request();
-    /* FIXME - add a parameter to allow callers to specify reason */
-    shutdown_requested =3D SHUTDOWN_CAUSE_HOST_ERROR;
+    shutdown_requested =3D reason;
     qemu_notify_event();
 }

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index e890a5d..95fcac9 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -561,7 +561,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t=
 val)
         uint16_t sus_typ =3D (val >> 10) & 7;
         switch(sus_typ) {
         case 0: /* soft power off */
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             break;
         case 1:
             qemu_system_suspend_request();
@@ -569,7 +569,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t=
 val)
         default:
             if (sus_typ =3D=3D ar->pm1.cnt.s4_val) { /* S4 request */
                 qapi_event_send_suspend_disk(&error_abort);
-                qemu_system_shutdown_request();
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN);
             }
             break;
         }
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 0a4508c..d209b97 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -108,9 +108,9 @@ static void hb_regs_write(void *opaque, hwaddr offset=
,

     if (offset =3D=3D 0xf00) {
         if (value =3D=3D 1 || value =3D=3D 2) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         } else if (value =3D=3D 3) {
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         }
     }

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5610ffc..ca3eca1 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -158,7 +158,7 @@ static void integratorcm_do_remap(IntegratorCMState *=
s)
 static void integratorcm_set_ctrl(IntegratorCMState *s, uint32_t value)
 {
     if (value & 8) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
     if ((s->cm_ctrl ^ value) & 1) {
         /* (value & 1) !=3D 0 means the green "MISC LED" is lit.
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index cbbca4e..9c710f7 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -898,7 +898,7 @@ static void mv88w8618_pit_write(void *opaque, hwaddr =
offset,

     case MP_BOARD_RESET:
         if (value =3D=3D MP_BOARD_RESET_MAGIC) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     }
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index b3cf0ec..54582bd 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -355,7 +355,7 @@ static void omap_wd_timer_write(void *opaque, hwaddr =
addr,
                 /* XXX: on T|E hardware somehow this has no effect,
                  * on Zire 71 it works as specified.  */
                 s->reset =3D 1;
-                qemu_system_reset_request();
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             }
         }
         s->last_wr =3D value & 0xff;
@@ -1545,8 +1545,10 @@ static inline void omap_clkm_idlect1_update(struct=
 omap_mpu_state_s *s,
     if (value & (1 << 11)) {                            /* SETARM_IDLE *=
/
         cpu_interrupt(CPU(s->cpu), CPU_INTERRUPT_HALT);
     }
-    if (!(value & (1 << 10)))				/* WKUP_MODE */
-        qemu_system_shutdown_request();	/* XXX: disable wakeup from IRQ =
*/
+    if (!(value & (1 << 10))) {                         /* WKUP_MODE */
+        /* XXX: disable wakeup from IRQ */
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }

 #define SET_CANIDLE(clock, bit)				\
     if (diff & (1 << bit)) {				\
@@ -1693,7 +1695,7 @@ static void omap_clkm_write(void *opaque, hwaddr ad=
dr,
         diff =3D s->clkm.arm_rstct1 ^ value;
         s->clkm.arm_rstct1 =3D value & 0x0007;
         if (value & 9) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             s->clkm.cold_start =3D 0xa;
         }
         if (diff & ~value & 4) {				/* DSP_RST */
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index cf1b4ba..8afb854 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -1610,7 +1610,7 @@ static void omap_prcm_write(void *opaque, hwaddr ad=
dr,
     case 0x450:	/* RM_RSTCTRL_WKUP */
         /* TODO: reset */
         if (value & 2)
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;
     case 0x454:	/* RM_RSTTIME_WKUP */
         s->rsttime_wkup =3D value & 0x1fff;
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index fe2d5a7..7e9f579 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -848,7 +848,7 @@ static void spitz_lcd_hsync_handler(void *opaque, int=
 line, int level)
 static void spitz_reset(void *opaque, int line, int level)
 {
     if (level) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
 }

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index ea7a809..cf6e7be 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1197,7 +1197,7 @@ static
 void do_sys_reset(void *opaque, int n, int level)
 {
     if (level) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
 }

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 9f58a23..2421b81 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -90,7 +90,7 @@ static void tosa_out_switch(void *opaque, int line, int=
 level)
 static void tosa_reset(void *opaque, int line, int level)
 {
     if (level) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
 }

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f3b372a..427f123 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -519,7 +519,7 @@ static void port92_write(void *opaque, hwaddr addr, u=
int64_t val,
     s->outport =3D val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
     if ((val & 1) && !(oldval & 1)) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
 }

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 222d89a..919f09b 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1398,7 +1398,7 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
     va_end(ap);
     fprintf(stderr, "Will destroy the domain.\n");
     /* destroy the domain */
-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
 }

 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index d414288..c479f82 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -226,7 +226,7 @@ static void outport_write(KBDState *s, uint32_t val)
     s->outport =3D val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
     if (!(val & 1)) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
 }

@@ -301,7 +301,7 @@ static void kbd_write_command(void *opaque, hwaddr ad=
dr,
         s->outport &=3D ~KBD_OUT_A20;
         break;
     case KBD_CCMD_RESET:
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;
     case KBD_CCMD_NO_OP:
         /* ignore that */
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 5cf1caa..afafe14 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -44,14 +44,14 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_=
op op, int checkonly)
         if (checkonly) {
             return 0;
         }
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return 0;

     case IPMI_POWEROFF_CHASSIS:
         if (checkonly) {
             return 0;
         }
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         return 0;

     case IPMI_SEND_NMI:
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index a0866c3..2b09354 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -606,7 +606,7 @@ static void ich9_rst_cnt_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     ICH9LPCState *lpc =3D opaque;

     if (val & 4) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return;
     }
     lpc->rst_cnt =3D val & 0xA; /* keep FULL_RST (bit 3) and SYS_RST (bi=
t 1) */
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 83f7b82..53d1e0c 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -232,7 +232,7 @@ static void boston_platreg_write(void *opaque, hwaddr=
 addr,
         break;
     case PLAT_SOFTRST_CTL:
         if (val & PLAT_SOFTRST_CTL_SYSRESET) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     default:
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 5dd177e..7814c39 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -470,7 +470,7 @@ static void malta_fpga_write(void *opaque, hwaddr add=
r,
     /* SOFTRES Register */
     case 0x00500:
         if (val =3D=3D 0x42)
-            qemu_system_reset_request ();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;

     /* BRKRES Register */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 748586e..f4de9fc 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -53,9 +53,9 @@ static void mips_qemu_write (void *opaque, hwaddr addr,
                              uint64_t val, unsigned size)
 {
     if ((addr & 0xffff) =3D=3D 0 && val =3D=3D 42)
-        qemu_system_reset_request ();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     else if ((addr & 0xffff) =3D=3D 4 && val =3D=3D 42)
-        qemu_system_shutdown_request ();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }

 static uint64_t mips_qemu_read (void *opaque, hwaddr addr,
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 8524008..b20b44e 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -351,13 +351,13 @@ static bool vexpress_cfgctrl_write(arm_sysctl_state=
 *s, unsigned int dcc,
         break;
     case SYS_CFG_SHUTDOWN:
         if (site =3D=3D SYS_CFG_SITE_MB && device =3D=3D 0) {
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             return true;
         }
         break;
     case SYS_CFG_REBOOT:
         if (site =3D=3D SYS_CFG_SITE_MB && device =3D=3D 0) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return true;
         }
         break;
@@ -429,7 +429,7 @@ static void arm_sysctl_write(void *opaque, hwaddr off=
set,
             if (s->lockval =3D=3D LOCK_VALUE) {
                 s->resetlevel =3D val;
                 if (val & 0x100) {
-                    qemu_system_reset_request();
+                    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET=
);
                 }
             }
             break;
@@ -438,7 +438,7 @@ static void arm_sysctl_write(void *opaque, hwaddr off=
set,
             if (s->lockval =3D=3D LOCK_VALUE) {
                 s->resetlevel =3D val;
                 if (val & 0x04) {
-                    qemu_system_reset_request();
+                    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET=
);
                 }
             }
             break;
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
index 0c207e3..677274c 100644
--- a/hw/misc/cbus.c
+++ b/hw/misc/cbus.c
@@ -356,7 +356,7 @@ static inline void retu_write(CBusRetu *s, int reg, u=
int16_t val)

     case RETU_REG_WATCHDOG:
         if (val =3D=3D 0 && (s->cc[0] & 2))
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         break;

     case RETU_REG_TXCR:
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 05c02fb..008d8bd 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -612,7 +612,7 @@ static bool cuda_cmd_powerdown(CUDAState *s,
         return false;
     }

-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     return true;
 }

@@ -624,7 +624,7 @@ static bool cuda_cmd_reset_system(CUDAState *s,
         return false;
     }

-    qemu_system_reset_request();
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     return true;
 }

diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index edd5de0..18ff677 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -258,7 +258,7 @@ static void slavio_aux2_mem_writeb(void *opaque, hwad=
dr addr,
         val &=3D AUX2_PWROFF;
     s->aux2 =3D val;
     if (val & AUX2_PWROFF)
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     slavio_misc_update_irq(s);
 }

@@ -338,7 +338,7 @@ static void slavio_sysctrl_mem_writel(void *opaque, h=
waddr addr,
     case 0:
         if (val & SYS_RESET) {
             s->sysctrl =3D SYS_RESETSTAT;
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     default:
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 7891219..44304d4 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -405,7 +405,7 @@ static void zynq_slcr_write(void *opaque, hwaddr offs=
et,
     switch (offset) {
     case PSS_RST_CTRL:
         if (val & R_PSS_RST_CTRL_SOFT_RST) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     }
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 653e711..83fc6a9 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -482,9 +482,9 @@ static void apb_config_writel (void *opaque, hwaddr a=
ddr,
             s->reset_control |=3D val & RESET_WMASK;
             if (val & SOFT_POR) {
                 s->nr_resets =3D 0;
-                qemu_system_reset_request();
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             } else if (val & SOFT_XIR) {
-                qemu_system_reset_request();
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             }
         }
         break;
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1999ece..b1d41d0 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -269,7 +269,7 @@ static void bonito_writel(void *opaque, hwaddr addr,
         }
         s->regs[saddr] =3D val;
         if (reset) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     case BONITO_INTENSET:
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index f9218aa..c1d6a85 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -638,7 +638,7 @@ static void rcr_write(void *opaque, hwaddr addr, uint=
64_t val, unsigned len)
     PIIX3State *d =3D opaque;

     if (val & 4) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return;
     }
     d->rcr =3D val & 2; /* keep System Reset type only */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f7df238..62f1857 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -774,7 +774,7 @@ static qemu_irq *ppce500_init_mpic(MachineState *mach=
ine, PPCE500Params *params,
 static void ppce500_power_off(void *opaque, int line, int on)
 {
     if (on) {
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
 }

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index ba69178..ce1254b 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -98,7 +98,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr add=
r,
     switch (addr) {
     case MPC8544_GUTS_ADDR_RSTCR:
         if (value & MPC8544_GUTS_RSTCR_RESET) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     default:
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 5f93083..224184d 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -412,7 +412,7 @@ static void ppce500_set_irq(void *opaque, int pin, in=
t level)
             if (level) {
                 LOG_IRQ("%s: reset the PowerPC system\n",
                             __func__);
-                qemu_system_reset_request();
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             }
             break;
         case PPCE500_INPUT_RESET_CORE:
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index d5df94a..fc32e96 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -1807,7 +1807,7 @@ void ppc40x_chip_reset(PowerPCCPU *cpu)
 void ppc40x_system_reset(PowerPCCPU *cpu)
 {
     printf("Reset PowerPC system\n");
-    qemu_system_reset_request();
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
 }

 void store_40x_dbcr0 (CPUPPCState *env, uint32_t val)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9f18f75..2735fe9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1166,7 +1166,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     spapr_ovec_cleanup(ov5_updates);

     if (spapr->cas_reboot) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     } else {
         /* If ppc_spapr_reset() did not set up a HPT but one is necessar=
y
          * (because the guest isn't going to use radix) then set it up h=
ere. */
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 619f32c..128d993 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -110,7 +110,7 @@ static void rtas_power_off(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
     }
-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     cpu_stop_current();
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
@@ -124,7 +124,7 @@ static void rtas_system_reboot(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
     }
-    qemu_system_reset_request();
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 75d3c68..4e6469d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -396,7 +396,7 @@ void s390_reipl_request(void)
     S390IPLState *ipl =3D get_ipl_device();

     ipl->reipl_requested =3D true;
-    qemu_system_reset_request();
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
 }

 void s390_ipl_prepare_cpu(S390CPU *cpu)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 8f520ce..e6fc74e 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -164,7 +164,7 @@ r2d_fpga_write(void *opaque, hwaddr addr, uint64_t va=
lue, unsigned int size)
 	break;
     case PA_POWOFF:
         if (value & 1) {
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         }
         break;
     case PA_VERREG:
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index 8e18236..d13bc30 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -207,7 +207,7 @@ static void watchdog_hit(void *opaque)
         qemu_irq_raise(t->nmi);
     }
     else
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);

     t->wd_hits++;
 }
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 474981a..4a064fb 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -1,7 +1,7 @@
 /*
  * QEMU M48T59 and M48T08 NVRAM emulation for PPC PREP and Sparc platfor=
ms
  *
- * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
+ * Copyright (c) 2003-2005, 2007, 2017 Jocelyn Mayer
  * Copyright (c) 2013 Herv=C3=A9 Poussineau
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
@@ -159,7 +159,7 @@ static void watchdog_cb (void *opaque)
 	NVRAM->buffer[0x1FF7] =3D 0x00;
 	NVRAM->buffer[0x1FFC] &=3D ~0x40;
         /* May it be a hw CPU Reset instead ? */
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     } else {
 	qemu_set_irq(NVRAM->IRQ, 1);
 	qemu_set_irq(NVRAM->IRQ, 0);
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 4488590..93bc6e17 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -90,7 +90,7 @@ static void sysctl_icap_write(MilkymistSysctlState *s, =
uint32_t value)
     trace_milkymist_sysctl_icap_write(value);
     switch (value & 0xffff) {
     case 0x000e:
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         break;
     }
 }
@@ -195,7 +195,7 @@ static void sysctl_write(void *opaque, hwaddr addr, u=
int64_t value,
         s->regs[addr] =3D 1;
         break;
     case R_SYSTEM_ID:
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;

     case R_GPIO_IN:
diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 59002b4..68ba5a7 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -401,7 +401,7 @@ static void pxa2xx_timer_tick(void *opaque)
     if (t->num =3D=3D 3)
         if (i->reset3 & 1) {
             i->reset3 =3D 0;
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
 }

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 2aeaf1f..0c5c9cd 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -110,7 +110,7 @@ void watchdog_perform_action(void)
     switch (watchdog_action) {
     case WDT_RESET:             /* same as 'system_reset' in monitor */
         qapi_event_send_watchdog(WATCHDOG_EXPIRATION_ACTION_RESET, &erro=
r_abort);
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;

     case WDT_SHUTDOWN:          /* same as 'system_powerdown' in monitor=
 */
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
index 457a897..c89ced2 100644
--- a/hw/xenpv/xen_domainbuild.c
+++ b/hw/xenpv/xen_domainbuild.c
@@ -148,7 +148,7 @@ static void xen_domain_poll(void *opaque)
     return;

 quit:
-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }

 static int xen_domain_watcher(void)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 11176e2..4636f8e 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -100,7 +100,7 @@ static void lx60_fpga_write(void *opaque, hwaddr addr=
,

     case 0x10: /*board reset*/
         if (val =3D=3D 0xdead) {
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
     }
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..7df27c8 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2052,7 +2052,7 @@ int kvm_cpu_exec(CPUState *cpu)
             break;
         case KVM_EXIT_SHUTDOWN:
             DPRINTF("shutdown\n");
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             ret =3D EXCP_INTERRUPT;
             break;
         case KVM_EXIT_UNKNOWN:
@@ -2066,11 +2066,11 @@ int kvm_cpu_exec(CPUState *cpu)
         case KVM_EXIT_SYSTEM_EVENT:
             switch (run->system_event.type) {
             case KVM_SYSTEM_EVENT_SHUTDOWN:
-                qemu_system_shutdown_request();
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN);
                 ret =3D EXCP_INTERRUPT;
                 break;
             case KVM_SYSTEM_EVENT_RESET:
-                qemu_system_reset_request();
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
                 ret =3D EXCP_INTERRUPT;
                 break;
             case KVM_SYSTEM_EVENT_CRASH:
diff --git a/os-win32.c b/os-win32.c
index ae98574..586a7c7 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -52,7 +52,7 @@ int setenv(const char *name, const char *value, int ove=
rwrite)

 static BOOL WINAPI qemu_ctrl_handler(DWORD type)
 {
-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_SIGNAL);
     /* Windows 7 kills application when the function returns.
        Sleep here to give QEMU a try for closing.
        Sleep period is 10000ms because Windows kills the program
diff --git a/qmp.c b/qmp.c
index ab74cd7..95949d0 100644
--- a/qmp.c
+++ b/qmp.c
@@ -84,7 +84,7 @@ UuidInfo *qmp_query_uuid(Error **errp)
 void qmp_quit(Error **errp)
 {
     no_shutdown =3D 0;
-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP);
 }

 void qmp_stop(Error **errp)
@@ -105,7 +105,7 @@ void qmp_stop(Error **errp)

 void qmp_system_reset(Error **errp)
 {
-    qemu_system_reset_request();
+    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
 }

 void qmp_system_powerdown(Error **erp)
diff --git a/replay/replay.c b/replay/replay.c
index f810628..604fa4f 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -51,7 +51,8 @@ bool replay_next_event_is(int event)
         switch (replay_state.data_kind) {
         case EVENT_SHUTDOWN:
             replay_finish_event();
-            qemu_system_shutdown_request();
+            /* FIXME - store actual reason */
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
             break;
         default:
             /* clock, time_t, checkpoint and other events */
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 652195d..ac22323 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -60,9 +60,9 @@ void helper_tb_flush(CPUAlphaState *env)
 void helper_halt(uint64_t restart)
 {
     if (restart) {
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     } else {
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
 }

diff --git a/target/arm/psci.c b/target/arm/psci.c
index ade9fe2..fc34b26 100644
--- a/target/arm/psci.c
+++ b/target/arm/psci.c
@@ -137,7 +137,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
         }
         break;
     case QEMU_PSCI_0_2_FN_SYSTEM_RESET:
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         /* QEMU reset and shutdown are async requests, but PSCI
          * mandates that we never return from the reset/shutdown
          * call, so power the CPU off now so it doesn't execute
@@ -145,7 +145,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
          */
         goto cpu_off;
     case QEMU_PSCI_0_2_FN_SYSTEM_OFF:
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         goto cpu_off;
     case QEMU_PSCI_0_1_FN_CPU_ON:
     case QEMU_PSCI_0_2_FN_CPU_ON:
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index ee596c6..b769772 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -59,7 +59,7 @@ static int check_exception(CPUX86State *env, int intno,=
 int *error_code,

         qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");

-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return EXCP_HLT;
     }
 #endif
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index ef13015..7346931 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -540,14 +540,14 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         /* Guest state changed, currently only for shutdown */
         case HAX_EXIT_STATECHANGE:
             fprintf(stdout, "VCPU shutdown request\n");
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             hax_vcpu_sync_state(env, 0);
             ret =3D 1;
             break;
         case HAX_EXIT_UNKNOWN_VMEXIT:
             fprintf(stderr, "Unknown VMX exit %x from guest\n",
                     ht->_exit_reason);
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             hax_vcpu_sync_state(env, 0);
             cpu_dump_state(cpu, stderr, fprintf, 0);
             ret =3D -1;
@@ -578,7 +578,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             break;
         default:
             fprintf(stderr, "Unknown exit %x from HAX\n", ht->_exit_stat=
us);
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             hax_vcpu_sync_state(env, 0);
             cpu_dump_state(cpu, stderr, fprintf, 0);
             ret =3D 1;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index f11cac6..ee7eff2 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1212,7 +1212,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_=
cpu_data data)
                            " triple fault\n",
                            cs->cpu_index);
             qemu_log_mask(CPU_LOG_RESET, "Triple fault\n");
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
         }
         if (banks[1] & MCI_STATUS_VAL) {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865db..cfd7695 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2930,7 +2930,7 @@ int kvm_arch_process_async_events(CPUState *cs)

         if (env->exception_injected =3D=3D EXCP08_DBLE) {
             /* this means triple fault */
-            qemu_system_reset_request();
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             cs->exit_request =3D 1;
             return 0;
         }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 68bd2f9..d2bb9aa 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -266,7 +266,7 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint=
64_t addr)
         S390CPU *cpu =3D s390_env_get_cpu(env);
         if (s390_cpu_halt(cpu) =3D=3D 0) {
 #ifndef CONFIG_USER_ONLY
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 #endif
         }
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1a249d8..284f5ef 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1929,7 +1929,7 @@ static int handle_intercept(S390CPU *cpu)
             cpu_synchronize_state(cs);
             if (s390_cpu_halt(cpu) =3D=3D 0) {
                 if (is_special_wait_psw(cs)) {
-                    qemu_system_shutdown_request();
+                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SH=
UTDOWN);
                 } else {
                     qemu_system_guest_panicked(NULL);
                 }
@@ -1938,7 +1938,7 @@ static int handle_intercept(S390CPU *cpu)
             break;
         case ICPT_CPU_STOP:
             if (s390_cpu_set_state(CPU_STATE_STOPPED, cpu) =3D=3D 0) {
-                qemu_system_shutdown_request();
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDO=
WN);
             }
             if (cpu->env.sigp_order =3D=3D SIGP_STOP_STORE_STATUS) {
                 kvm_s390_store_status(cpu, KVM_S390_STORE_STATUS_DEF_ADD=
R,
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index eca8244..768043e 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -533,11 +533,11 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t =
order_code, uint32_t r1,
         break;
 #if !defined(CONFIG_USER_ONLY)
     case SIGP_RESTART:
-        qemu_system_reset_request();
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         cpu_loop_exit(CPU(s390_env_get_cpu(env)));
         break;
     case SIGP_STOP:
-        qemu_system_shutdown_request();
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         cpu_loop_exit(CPU(s390_env_get_cpu(env)));
         break;
 #endif
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 09afe13..eec9a4d 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -109,7 +109,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     if (env->psret =3D=3D 0) {
         if (cs->exception_index =3D=3D 0x80 &&
             env->def->features & CPU_FEATURE_TA0_SHUTDOWN) {
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
             cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Error =
state",
                       cs->exception_index);
diff --git a/ui/sdl.c b/ui/sdl.c
index 37c21a0..bd51ffd 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -837,7 +837,7 @@ static void sdl_refresh(DisplayChangeListener *dcl)
         case SDL_QUIT:
             if (!no_quit) {
                 no_shutdown =3D 0;
-                qemu_system_shutdown_request();
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
             break;
         case SDL_MOUSEMOTION:
diff --git a/ui/sdl2.c b/ui/sdl2.c
index faf9bdf..e092636 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -568,7 +568,7 @@ static void handle_windowevent(SDL_Event *ev)
     case SDL_WINDOWEVENT_CLOSE:
         if (!no_quit) {
             no_shutdown =3D 0;
-            qemu_system_shutdown_request();
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
         }
         break;
     case SDL_WINDOWEVENT_SHOWN:
@@ -611,7 +611,7 @@ void sdl2_poll_events(struct sdl2_console *scon)
         case SDL_QUIT:
             if (!no_quit) {
                 no_shutdown =3D 0;
-                qemu_system_shutdown_request();
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
             break;
         case SDL_MOUSEMOTION:
diff --git a/trace-events b/trace-events
index e582d63..433865f 100644
--- a/trace-events
+++ b/trace-events
@@ -38,7 +38,7 @@ vm_state_notify(int running, int reason) "running %d re=
ason %d"
 load_file(const char *name, const char *path) "name %s location %s"
 runstate_set(int new_state) "new state %d"
 system_wakeup_request(int reason) "reason=3D%d"
-qemu_system_shutdown_request(void) ""
+qemu_system_shutdown_request(int reason) "reason=3D%d"
 qemu_system_powerdown_request(void) ""

 # spice-qemu-char.c
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 207555e..f89f686 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -934,7 +934,7 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaAppController: applicationWillTerminate\n");

-    qemu_system_shutdown_request();
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
     exit(0);
 }

--=20
2.9.3
