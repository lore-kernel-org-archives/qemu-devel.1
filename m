Received: from eggs.gnu.org ([2001:4830:134:3::10]:58090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVhm-0006Sm-L4
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dIVhc-00073A-GM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dIVhb-00070j-QT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:48:28 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  7 Jun 2017 11:46:32 +0400
Message-Id: <20170607074632.13162-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-1-marcandre.lureau@redhat.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The g_new() familly of macros is simpler and safer than g_malloc().

"The return pointer is cast to the given type... Care is taken to
avoid overflow when calculating the size of the allocated block."

I left out the common g_malloc(sizeof(*ptr)) pattern, since
alternative "g_new(typeof(*ptr))" isn't very common. But we may want
to change that too?

Here is the cocci script I used, then I edited manually a few
changes (I removed useless cast for ex):

@@
expression e1;
expression e2;
expression mem;
type t1;
@@
(
- g_malloc0(sizeof(*e2))
+ g_malloc0(sizeof(*e2))
|
- g_malloc(sizeof(*e2))
+ g_malloc(sizeof(*e2))
|
- g_realloc(mem, (e1) * sizeof(*e2))
+ g_renew(typeof(*e2), mem, e1)
|
- g_malloc0((e1) * sizeof(*e2))
+ g_new0(typeof(*e2), e1)
|
- g_malloc((e1) * sizeof(*e2))
+ g_new(typeof(*e2), e1)
|
- g_realloc(mem, (e1) * sizeof(e2[0]))
+ g_renew(typeof(e2[0]), mem, e1)
|
- g_realloc(mem, (e1) * sizeof(e2))
+ g_renew(e2, mem, e1)
|
- g_malloc0((e1) * sizeof(e2[0]))
+ g_new0(typeof(e2[0]), e1)
|
- g_malloc0((e1) * sizeof(e2))
+ g_new0(e2, e1)
|
- g_malloc((e1) * sizeof(e2[0]))
+ g_new(typeof(e2[0]), e1)
|
- g_malloc((e1) * sizeof(e2))
+ g_new(e2, e1)
|
- g_realloc(mem, (e1) * sizeof(t1))
+ g_renew(t1, mem, e1)
|
- g_malloc0((e1) * sizeof(t1))
+ g_new0(t1, e1)
|
- g_malloc((e1) * sizeof(t1))
+ g_new(t1, e1)
|
- g_malloc0(sizeof(e2[0]))
+ g_new0(typeof(e2[0]), 1)
|
- g_malloc0(sizeof(e2))
+ g_new0(e2, 1)
|
- g_malloc(sizeof(e2[0]))
+ g_new(typeof(e2[0]), 1)
|
- g_malloc(sizeof(e2))
+ g_new(e2, 1)
|
- g_malloc0(sizeof(t1))
+ g_new0(t1, 1)
|
- g_malloc(sizeof(t1))
+ g_new(t1, 1)
)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/lm32/lm32_hwsetup.h              |  2 +-
 include/hw/elf_ops.h                |  2 +-
 include/qemu/timer.h                |  2 +-
 audio/alsaaudio.c                   |  2 +-
 audio/coreaudio.c                   |  2 +-
 audio/dsoundaudio.c                 |  2 +-
 audio/ossaudio.c                    |  2 +-
 audio/paaudio.c                     |  2 +-
 audio/wavaudio.c                    |  2 +-
 backends/cryptodev.c                |  2 +-
 bootdevice.c                        |  2 +-
 bsd-user/syscall.c                  |  2 +-
 bt-host.c                           |  2 +-
 bt-vhci.c                           |  2 +-
 cpus-common.c                       |  4 ++--
 cpus.c                              | 16 ++++++++--------
 dma-helpers.c                       |  4 ++--
 dump.c                              | 10 +++++-----
 gdbstub.c                           |  4 ++--
 hw/9pfs/9p-handle.c                 |  2 +-
 hw/9pfs/9p-proxy.c                  |  2 +-
 hw/9pfs/9p-synth.c                  |  2 +-
 hw/9pfs/9p.c                        |  6 +++---
 hw/9pfs/xen-9p-backend.c            |  6 +++---
 hw/acpi/memory_hotplug.c            |  2 +-
 hw/audio/intel-hda.c                |  2 +-
 hw/bt/core.c                        |  4 ++--
 hw/bt/hci.c                         |  4 ++--
 hw/bt/l2cap.c                       |  4 ++--
 hw/bt/sdp.c                         |  6 +++---
 hw/char/parallel.c                  |  2 +-
 hw/char/serial.c                    |  4 ++--
 hw/char/sh_serial.c                 |  2 +-
 hw/char/virtio-serial-bus.c         | 12 +++++-------
 hw/core/irq.c                       |  2 +-
 hw/core/ptimer.c                    |  2 +-
 hw/core/reset.c                     |  2 +-
 hw/cris/axis_dev88.c                |  2 +-
 hw/display/pxa2xx_lcd.c             |  2 +-
 hw/display/tc6393xb.c               |  2 +-
 hw/display/virtio-gpu.c             |  4 ++--
 hw/display/xenfb.c                  |  4 ++--
 hw/dma/etraxfs_dma.c                |  2 +-
 hw/dma/rc4030.c                     |  4 ++--
 hw/dma/soc_dma.c                    |  6 ++----
 hw/i2c/bitbang_i2c.c                |  2 +-
 hw/i2c/core.c                       |  4 ++--
 hw/i386/amd_iommu.c                 |  4 ++--
 hw/i386/intel_iommu.c               |  2 +-
 hw/i386/kvm/pci-assign.c            |  2 +-
 hw/i386/pc.c                        |  5 ++---
 hw/i386/xen/xen-hvm.c               | 12 ++++++------
 hw/i386/xen/xen-mapcache.c          | 14 +++++++-------
 hw/input/pckbd.c                    |  2 +-
 hw/input/ps2.c                      |  4 ++--
 hw/input/pxa2xx_keypad.c            |  2 +-
 hw/input/tsc2005.c                  |  3 +--
 hw/input/virtio-input.c             |  4 ++--
 hw/intc/exynos4210_gic.c            |  2 +-
 hw/intc/heathrow_pic.c              |  2 +-
 hw/intc/xics.c                      |  2 +-
 hw/intc/xics_kvm.c                  |  2 +-
 hw/lm32/lm32_boards.c               |  4 ++--
 hw/lm32/milkymist.c                 |  2 +-
 hw/m68k/mcf5206.c                   |  4 ++--
 hw/m68k/mcf5208.c                   |  2 +-
 hw/mips/mips_malta.c                |  2 +-
 hw/mips/mips_mipssim.c              |  2 +-
 hw/mips/mips_r4k.c                  |  2 +-
 hw/misc/applesmc.c                  |  2 +-
 hw/misc/imx6_src.c                  |  2 +-
 hw/misc/ivshmem.c                   |  4 ++--
 hw/misc/macio/mac_dbdma.c           |  2 +-
 hw/misc/pci-testdev.c               |  2 +-
 hw/net/net_rx_pkt.c                 |  2 +-
 hw/net/virtio-net.c                 |  2 +-
 hw/pci/msix.c                       |  2 +-
 hw/pci/pci.c                        |  2 +-
 hw/pci/pcie_aer.c                   |  4 ++--
 hw/ppc/e500.c                       |  4 ++--
 hw/ppc/mac_newworld.c               |  2 +-
 hw/ppc/mac_oldworld.c               |  2 +-
 hw/ppc/ppc.c                        |  8 ++++----
 hw/ppc/ppc405_boards.c              |  8 ++++----
 hw/ppc/ppc405_uc.c                  | 28 ++++++++++++++--------------
 hw/ppc/ppc440_bamboo.c              |  4 ++--
 hw/ppc/ppc4xx_devs.c                |  4 ++--
 hw/ppc/ppc_booke.c                  |  4 ++--
 hw/ppc/prep.c                       |  2 +-
 hw/ppc/spapr.c                      |  4 ++--
 hw/ppc/spapr_events.c               |  2 +-
 hw/ppc/spapr_iommu.c                |  2 +-
 hw/ppc/spapr_pci.c                  |  2 +-
 hw/ppc/spapr_vio.c                  |  2 +-
 hw/ppc/virtex_ml507.c               |  2 +-
 hw/s390x/css.c                      |  8 ++++----
 hw/s390x/s390-pci-bus.c             |  4 ++--
 hw/sh4/r2d.c                        |  4 ++--
 hw/sh4/sh7750.c                     |  2 +-
 hw/sparc/leon3.c                    |  2 +-
 hw/sparc64/sparc64.c                |  4 ++--
 hw/timer/arm_timer.c                |  2 +-
 hw/timer/grlib_gptimer.c            |  2 +-
 hw/timer/sh_timer.c                 |  4 ++--
 hw/timer/slavio_timer.c             |  2 +-
 hw/timer/xilinx_timer.c             |  2 +-
 hw/vfio/common.c                    |  2 +-
 hw/vfio/pci.c                       |  4 ++--
 hw/vfio/platform.c                  |  4 ++--
 hw/virtio/virtio-crypto.c           |  2 +-
 hw/virtio/virtio-pci.c              |  4 ++--
 hw/virtio/virtio.c                  |  4 ++--
 hw/xtensa/xtfpga.c                  |  2 +-
 kvm-all.c                           |  4 ++--
 linux-user/elfload.c                |  2 +-
 memory.c                            | 12 ++++++------
 memory_mapping.c                    |  2 +-
 migration/block.c                   |  2 +-
 migration/postcopy-ram.c            |  2 +-
 migration/ram.c                     |  2 +-
 monitor.c                           |  2 +-
 nbd/server.c                        |  4 ++--
 net/slirp.c                         |  2 +-
 qga/commands-win32.c                |  2 +-
 qga/commands.c                      |  2 +-
 qmp.c                               |  2 +-
 qobject/json-parser.c               |  2 +-
 replay/replay-char.c                |  8 ++++----
 replay/replay-events.c              | 10 +++++-----
 replay/replay-net.c                 |  5 ++---
 slirp/dnssearch.c                   |  4 ++--
 slirp/slirp.c                       |  2 +-
 target/i386/cpu.c                   |  2 +-
 target/mips/translate_init.c        |  4 ++--
 target/openrisc/mmu.c               |  2 +-
 target/ppc/translate_init.c         |  6 +++---
 target/s390x/misc_helper.c          |  2 +-
 target/s390x/mmu_helper.c           |  2 +-
 tcg/tcg.c                           |  4 ++--
 tests/ahci-test.c                   |  2 +-
 tests/fw_cfg-test.c                 |  4 ++--
 tests/libqos/ahci.c                 |  2 +-
 tests/libqos/libqos.c               |  2 +-
 tests/libqos/malloc.c               |  6 +++---
 tests/pc-cpu-test.c                 |  2 +-
 tests/qht-bench.c                   |  4 ++--
 tests/test-hbitmap.c                |  2 +-
 tests/test-iov.c                    |  2 +-
 tests/test-qmp-commands.c           | 14 +++++++-------
 tests/test-qobject-output-visitor.c |  2 +-
 ui/console.c                        |  2 +-
 ui/input-legacy.c                   |  2 +-
 ui/vnc-enc-tight.c                  |  2 +-
 ui/vnc.c                            |  2 +-
 util/acl.c                          |  2 +-
 util/envlist.c                      |  2 +-
 util/hbitmap.c                      |  2 +-
 util/iohandler.c                    |  2 +-
 util/main-loop.c                    |  2 +-
 util/qemu-timer.c                   |  2 +-
 vl.c                                |  2 +-
 161 files changed, 278 insertions(+), 285 deletions(-)

diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index a01f6bc5df..38ade3db0e 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -58,7 +58,7 @@ static inline HWSetup *hwsetup_init(void)
 {
     HWSetup *hw;
=20
-    hw =3D g_malloc(sizeof(HWSetup));
+    hw =3D g_new(HWSetup, 1);
     hw->data =3D g_malloc0(TARGET_PAGE_SIZE);
     hw->ptr =3D hw->data;
=20
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index a172a6068a..edfd70c335 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -154,7 +154,7 @@ static int glue(load_symbols, SZ)(struct elfhdr *ehdr=
, int fd, int must_swab,
         }
         i++;
     }
-    syms =3D g_realloc(syms, nsyms * sizeof(*syms));
+    syms =3D g_renew(typeof(*syms), syms, nsyms);
=20
     qsort(syms, nsyms, sizeof(*syms), glue(symcmp, SZ));
     for (i =3D 0; i < nsyms - 1; i++) {
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8a1eb74839..767a277040 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -518,7 +518,7 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *=
timer_list,
                                       QEMUTimerCB *cb,
                                       void *opaque)
 {
-    QEMUTimer *ts =3D g_malloc0(sizeof(QEMUTimer));
+    QEMUTimer *ts =3D g_new0(QEMUTimer, 1);
     timer_init_tl(ts, timer_list, scale, cb, opaque);
     return ts;
 }
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3652a7b5fa..1a129c79e3 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -1126,7 +1126,7 @@ static ALSAConf glob_conf =3D {
=20
 static void *alsa_audio_init (void)
 {
-    ALSAConf *conf =3D g_malloc(sizeof(ALSAConf));
+    ALSAConf *conf =3D g_new(ALSAConf, 1);
     *conf =3D glob_conf;
     return conf;
 }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index c75142084f..651b390b5e 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -687,7 +687,7 @@ static CoreaudioConf glob_conf =3D {
=20
 static void *coreaudio_audio_init (void)
 {
-    CoreaudioConf *conf =3D g_malloc(sizeof(CoreaudioConf));
+    CoreaudioConf *conf =3D g_new(CoreaudioConf, 1);
     *conf =3D glob_conf;
=20
     return conf;
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 516846eb80..0492d9075e 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -787,7 +787,7 @@ static void *dsound_audio_init (void)
 {
     int err;
     HRESULT hr;
-    dsound *s =3D g_malloc0(sizeof(dsound));
+    dsound *s =3D g_new0(dsound, 1);
=20
     s->conf =3D glob_conf;
     hr =3D CoInitialize (NULL);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0edd7ea5fe..50d772011c 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -846,7 +846,7 @@ static OSSConf glob_conf =3D {
=20
 static void *oss_audio_init (void)
 {
-    OSSConf *conf =3D g_malloc(sizeof(OSSConf));
+    OSSConf *conf =3D g_new(OSSConf, 1);
     *conf =3D glob_conf;
=20
     if (access(conf->devpath_in, R_OK | W_OK) < 0 ||
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 65beb6f010..fc32960c25 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -814,7 +814,7 @@ static PAConf glob_conf =3D {
=20
 static void *qpa_audio_init (void)
 {
-    paaudio *g =3D g_malloc(sizeof(paaudio));
+    paaudio *g =3D g_new(paaudio, 1);
     g->conf =3D glob_conf;
     g->mainloop =3D NULL;
     g->context =3D NULL;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 341eec3121..f90a02610f 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -231,7 +231,7 @@ static WAVConf glob_conf =3D {
=20
 static void *wav_audio_init (void)
 {
-    WAVConf *conf =3D g_malloc(sizeof(WAVConf));
+    WAVConf *conf =3D g_new(WAVConf, 1);
     *conf =3D glob_conf;
     return conf;
 }
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 832f056266..ecadf61781 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -42,7 +42,7 @@ cryptodev_backend_new_client(const char *model,
 {
     CryptoDevBackendClient *cc;
=20
-    cc =3D g_malloc0(sizeof(CryptoDevBackendClient));
+    cc =3D g_new0(CryptoDevBackendClient, 1);
     cc->model =3D g_strdup(model);
     if (name) {
         cc->name =3D g_strdup(name);
diff --git a/bootdevice.c b/bootdevice.c
index 33e3029e40..4000e7a772 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -165,7 +165,7 @@ void add_boot_device_path(int32_t bootindex, DeviceSt=
ate *dev,
=20
     del_boot_device_path(dev, suffix);
=20
-    node =3D g_malloc0(sizeof(FWBootEntry));
+    node =3D g_new0(FWBootEntry, 1);
     node->bootindex =3D bootindex;
     node->suffix =3D g_strdup(suffix);
     node->dev =3D dev;
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 66492aaf5d..a8f4b88991 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -227,7 +227,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, in=
t32_t namelen, abi_ulong ol
     void *hnamep, *holdp, *hnewp =3D NULL;
     size_t holdlen;
     abi_ulong oldlen =3D 0;
-    int32_t *snamep =3D g_malloc(sizeof(int32_t) * namelen), *p, *q, i;
+    int32_t *snamep =3D g_new(int32_t, namelen), *p, *q, i;
     uint32_t kind =3D 0;
=20
     if (oldlenp)
diff --git a/bt-host.c b/bt-host.c
index 2f8f631c25..ad9e45ea43 100644
--- a/bt-host.c
+++ b/bt-host.c
@@ -177,7 +177,7 @@ struct HCIInfo *bt_host_hci(const char *id)
     }
 # endif
=20
-    s =3D g_malloc0(sizeof(struct bt_host_hci_s));
+    s =3D g_new0(struct bt_host_hci_s, 1);
     s->fd =3D fd;
     s->hci.cmd_send =3D bt_host_cmd;
     s->hci.sco_send =3D bt_host_sco;
diff --git a/bt-vhci.c b/bt-vhci.c
index 9d277c32bf..a885e2b8b9 100644
--- a/bt-vhci.c
+++ b/bt-vhci.c
@@ -157,7 +157,7 @@ void bt_vhci_init(struct HCIInfo *info)
         exit(-1);
     }
=20
-    s =3D g_malloc0(sizeof(struct bt_vhci_s));
+    s =3D g_new0(struct bt_vhci_s, 1);
     s->fd =3D fd;
     s->info =3D info ?: qemu_next_hci();
     s->info->opaque =3D s;
diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..e613cc33ef 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -158,7 +158,7 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func =
func, run_on_cpu_data data)
 {
     struct qemu_work_item *wi;
=20
-    wi =3D g_malloc0(sizeof(struct qemu_work_item));
+    wi =3D g_new0(struct qemu_work_item, 1);
     wi->func =3D func;
     wi->data =3D data;
     wi->free =3D true;
@@ -301,7 +301,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_=
func func,
 {
     struct qemu_work_item *wi;
=20
-    wi =3D g_malloc0(sizeof(struct qemu_work_item));
+    wi =3D g_new0(struct qemu_work_item, 1);
     wi->func =3D func;
     wi->data =3D data;
     wi->free =3D true;
diff --git a/cpus.c b/cpus.c
index 516e5cbac1..c575de50e4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1657,8 +1657,8 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     static QemuThread *single_tcg_cpu_thread;
=20
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
-        cpu->thread =3D g_malloc0(sizeof(QemuThread));
-        cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
+        cpu->thread =3D g_new0(QemuThread, 1);
+        cpu->halt_cond =3D g_new0(QemuCond, 1);
         qemu_cond_init(cpu->halt_cond);
=20
         if (qemu_tcg_mttcg_enabled()) {
@@ -1697,8 +1697,8 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
=20
-    cpu->thread =3D g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
+    cpu->thread =3D g_new0(QemuThread, 1);
+    cpu->halt_cond =3D g_new0(QemuCond, 1);
     qemu_cond_init(cpu->halt_cond);
=20
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
@@ -1717,8 +1717,8 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
=20
-    cpu->thread =3D g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
+    cpu->thread =3D g_new0(QemuThread, 1);
+    cpu->halt_cond =3D g_new0(QemuCond, 1);
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
@@ -1733,8 +1733,8 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
=20
-    cpu->thread =3D g_malloc0(sizeof(QemuThread));
-    cpu->halt_cond =3D g_malloc0(sizeof(QemuCond));
+    cpu->thread =3D g_new0(QemuThread, 1);
+    cpu->halt_cond =3D g_new0(QemuCond, 1);
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d35e..e327fc21c4 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -40,7 +40,7 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, u=
int8_t c, dma_addr_t len)
 void qemu_sglist_init(QEMUSGList *qsg, DeviceState *dev, int alloc_hint,
                       AddressSpace *as)
 {
-    qsg->sg =3D g_malloc(alloc_hint * sizeof(ScatterGatherEntry));
+    qsg->sg =3D g_new(ScatterGatherEntry, alloc_hint);
     qsg->nsg =3D 0;
     qsg->nalloc =3D alloc_hint;
     qsg->size =3D 0;
@@ -53,7 +53,7 @@ void qemu_sglist_add(QEMUSGList *qsg, dma_addr_t base, =
dma_addr_t len)
 {
     if (qsg->nsg =3D=3D qsg->nalloc) {
         qsg->nalloc =3D 2 * qsg->nalloc + 1;
-        qsg->sg =3D g_realloc(qsg->sg, qsg->nalloc * sizeof(ScatterGathe=
rEntry));
+        qsg->sg =3D g_renew(ScatterGatherEntry, qsg->sg, qsg->nalloc);
     }
     qsg->sg[qsg->nsg].base =3D base;
     qsg->sg[qsg->nsg].len =3D len;
diff --git a/dump.c b/dump.c
index d9090a24cc..eb3fa7a5f4 100644
--- a/dump.c
+++ b/dump.c
@@ -1823,28 +1823,28 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_m=
emory_capability(Error **errp)
 {
     DumpGuestMemoryFormatList *item;
     DumpGuestMemoryCapability *cap =3D
-                                  g_malloc0(sizeof(DumpGuestMemoryCapabi=
lity));
+                                  g_new0(DumpGuestMemoryCapability, 1);
=20
     /* elf is always available */
-    item =3D g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item =3D g_new0(DumpGuestMemoryFormatList, 1);
     cap->formats =3D item;
     item->value =3D DUMP_GUEST_MEMORY_FORMAT_ELF;
=20
     /* kdump-zlib is always available */
-    item->next =3D g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item->next =3D g_new0(DumpGuestMemoryFormatList, 1);
     item =3D item->next;
     item->value =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
=20
     /* add new item if kdump-lzo is available */
 #ifdef CONFIG_LZO
-    item->next =3D g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item->next =3D g_new0(DumpGuestMemoryFormatList, 1);
     item =3D item->next;
     item->value =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
 #endif
=20
     /* add new item if kdump-snappy is available */
 #ifdef CONFIG_SNAPPY
-    item->next =3D g_malloc0(sizeof(DumpGuestMemoryFormatList));
+    item->next =3D g_new0(DumpGuestMemoryFormatList, 1);
     item =3D item->next;
     item->value =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
 #endif
diff --git a/gdbstub.c b/gdbstub.c
index ec4e4b25be..077087cbed 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1789,7 +1789,7 @@ static void gdb_accept(void)
     /* set short latency */
     socket_set_nodelay(fd);
=20
-    s =3D g_malloc0(sizeof(GDBState));
+    s =3D g_new0(GDBState, 1);
     s->c_cpu =3D first_cpu;
     s->g_cpu =3D first_cpu;
     s->fd =3D fd;
@@ -1983,7 +1983,7 @@ int gdbserver_start(const char *device)
=20
     s =3D gdbserver_state;
     if (!s) {
-        s =3D g_malloc0(sizeof(GDBState));
+        s =3D g_new0(GDBState, 1);
         gdbserver_state =3D s;
=20
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 9875f1894c..357ced3079 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -609,7 +609,7 @@ static int handle_init(FsContext *ctx)
     int ret, mnt_id;
     struct statfs stbuf;
     struct file_handle fh;
-    struct handle_data *data =3D g_malloc(sizeof(struct handle_data));
+    struct handle_data *data =3D g_new(struct handle_data, 1);
=20
     data->mountfd =3D open(ctx->fs_root, O_DIRECTORY);
     if (data->mountfd < 0) {
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 28b20a7c3d..2de303d713 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1136,7 +1136,7 @@ static int proxy_parse_opts(QemuOpts *opts, struct =
FsDriverEntry *fs)
=20
 static int proxy_init(FsContext *ctx)
 {
-    V9fsProxy *proxy =3D g_malloc(sizeof(V9fsProxy));
+    V9fsProxy *proxy =3D g_new(V9fsProxy, 1);
     int sock_id;
=20
     if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index df0a8de08a..eab91237f4 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -43,7 +43,7 @@ static V9fsSynthNode *v9fs_add_dir_node(V9fsSynthNode *=
parent, int mode,
=20
     /* Add directory type and remove write bits */
     mode =3D ((mode & 0777) | S_IFDIR) & ~(S_IWUSR | S_IWGRP | S_IWOTH);
-    node =3D g_malloc0(sizeof(V9fsSynthNode));
+    node =3D g_new0(V9fsSynthNode, 1);
     if (attr) {
         /* We are adding .. or . entries */
         node->attr =3D attr;
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 96d2683348..0a0cdbb7dd 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -298,7 +298,7 @@ static V9fsFidState *alloc_fid(V9fsState *s, int32_t =
fid)
             return NULL;
         }
     }
-    f =3D g_malloc0(sizeof(V9fsFidState));
+    f =3D g_new0(V9fsFidState, 1);
     f->fid =3D fid;
     f->fid_type =3D P9_FID_NONE;
     f->ref =3D 1;
@@ -1307,8 +1307,8 @@ static void coroutine_fn v9fs_walk(void *opaque)
     trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
=20
     if (nwnames && nwnames <=3D P9_MAXWELEM) {
-        wnames =3D g_malloc0(sizeof(wnames[0]) * nwnames);
-        qids   =3D g_malloc0(sizeof(qids[0]) * nwnames);
+        wnames =3D g_new0(typeof(wnames[0]), nwnames);
+        qids   =3D g_new0(typeof(qids[0]), nwnames);
         for (i =3D 0; i < nwnames; i++) {
             err =3D pdu_unmarshal(pdu, offset, "s", &wnames[i]);
             if (err < 0) {
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 922cc967be..5825378ad8 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -155,7 +155,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *p=
du,
=20
     g_free(ring->sg);
=20
-    ring->sg =3D g_malloc0(sizeof(*ring->sg) * 2);
+    ring->sg =3D g_new0(typeof(*ring->sg), 2);
     xen_9pfs_out_sg(ring, ring->sg, &num, pdu->idx);
     *piov =3D ring->sg;
     *pniov =3D num;
@@ -172,7 +172,7 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pd=
u,
=20
     g_free(ring->sg);
=20
-    ring->sg =3D g_malloc0(sizeof(*ring->sg) * 2);
+    ring->sg =3D g_new0(typeof(*ring->sg), 2);
     xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
     *piov =3D ring->sg;
     *pniov =3D num;
@@ -316,7 +316,7 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
         return -1;
     }
=20
-    xen_9pdev->rings =3D g_malloc0(xen_9pdev->num_rings * sizeof(Xen9pfs=
Ring));
+    xen_9pdev->rings =3D g_new0(Xen9pfsRing, xen_9pdev->num_rings);
     for (i =3D 0; i < xen_9pdev->num_rings; i++) {
         char *str;
         int ring_order;
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 210073d283..ae465a2d6d 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -217,7 +217,7 @@ void acpi_memory_hotplug_init(MemoryRegion *as, Objec=
t *owner,
=20
     assert(!memhp_io_base);
     memhp_io_base =3D io_base;
-    state->devs =3D g_malloc0(sizeof(*state->devs) * state->dev_count);
+    state->devs =3D g_new0(typeof(*state->devs), state->dev_count);
     memory_region_init_io(&state->io, owner, &acpi_memory_hotplug_ops, s=
tate,
                           "acpi-mem-hotplug", MEMORY_HOTPLUG_IO_LEN);
     memory_region_add_subregion(as, memhp_io_base, &state->io);
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 06acc98f7b..7847ea7e9b 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -469,7 +469,7 @@ static void intel_hda_parse_bdl(IntelHDAState *d, Int=
elHDAStream *st)
     addr =3D intel_hda_addr(st->bdlp_lbase, st->bdlp_ubase);
     st->bentries =3D st->lvi +1;
     g_free(st->bpl);
-    st->bpl =3D g_malloc(sizeof(bpl) * st->bentries);
+    st->bpl =3D g_new(bpl, st->bentries);
     for (i =3D 0; i < st->bentries; i++, addr +=3D 16) {
         pci_dma_read(&d->pci, addr, buf, 16);
         st->bpl[i].addr  =3D le64_to_cpu(*(uint64_t *)buf);
diff --git a/hw/bt/core.c b/hw/bt/core.c
index 615f0af073..281bb40501 100644
--- a/hw/bt/core.c
+++ b/hw/bt/core.c
@@ -55,7 +55,7 @@ static void bt_dummy_lmp_acl_resp(struct bt_link_s *lin=
k,
 /* Slaves that don't hold any additional per link state can use these */
 static void bt_dummy_lmp_connection_request(struct bt_link_s *req)
 {
-    struct bt_link_s *link =3D g_malloc0(sizeof(struct bt_link_s));
+    struct bt_link_s *link =3D g_new0(struct bt_link_s, 1);
=20
     link->slave =3D req->slave;
     link->host =3D req->host;
@@ -135,7 +135,7 @@ struct bt_scatternet_s *qemu_find_bt_vlan(int id)
         if (vlan->id =3D=3D id)
             return &vlan->net;
     }
-    vlan =3D g_malloc0(sizeof(struct bt_vlan_s));
+    vlan =3D g_new0(struct bt_vlan_s, 1);
     vlan->id =3D id;
     pvlan =3D &first_bt_vlan;
     while (*pvlan !=3D NULL)
diff --git a/hw/bt/hci.c b/hw/bt/hci.c
index 476ebec0ab..08e65eb62e 100644
--- a/hw/bt/hci.c
+++ b/hw/bt/hci.c
@@ -742,7 +742,7 @@ static void bt_hci_connection_reject_event(struct bt_=
hci_s *hci,
 static void bt_hci_connection_accept(struct bt_hci_s *hci,
                 struct bt_device_s *host)
 {
-    struct bt_hci_link_s *link =3D g_malloc0(sizeof(struct bt_hci_link_s=
));
+    struct bt_hci_link_s *link =3D g_new0(struct bt_hci_link_s, 1);
     evt_conn_complete params;
     uint16_t handle;
     uint8_t status =3D HCI_SUCCESS;
@@ -2158,7 +2158,7 @@ static void bt_hci_destroy(struct bt_device_s *dev)
=20
 struct HCIInfo *bt_new_hci(struct bt_scatternet_s *net)
 {
-    struct bt_hci_s *s =3D g_malloc0(sizeof(struct bt_hci_s));
+    struct bt_hci_s *s =3D g_new0(struct bt_hci_s, 1);
=20
     s->lm.inquiry_done =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, bt_hci_inqui=
ry_done, s);
     s->lm.inquiry_next =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, bt_hci_inqui=
ry_next, s);
diff --git a/hw/bt/l2cap.c b/hw/bt/l2cap.c
index e342045140..b716fb7d98 100644
--- a/hw/bt/l2cap.c
+++ b/hw/bt/l2cap.c
@@ -1241,7 +1241,7 @@ static void l2cap_lmp_connection_request(struct bt_=
link_s *link)
=20
     /* Always accept - we only get called if (dev->device->page_scan).  =
*/
=20
-    l2cap =3D g_malloc0(sizeof(struct slave_l2cap_instance_s));
+    l2cap =3D g_new0(struct slave_l2cap_instance_s, 1);
     l2cap->link.slave =3D &dev->device;
     l2cap->link.host =3D link->host;
     l2cap_init(&l2cap->l2cap, &l2cap->link, 0);
@@ -1262,7 +1262,7 @@ static void l2cap_lmp_connection_complete(struct bt=
_link_s *link)
         return;
     }
=20
-    l2cap =3D g_malloc0(sizeof(struct l2cap_instance_s));
+    l2cap =3D g_new0(struct l2cap_instance_s, 1);
     l2cap_init(l2cap, link, 1);
=20
     link->acl_mode =3D acl_active;
diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index f67b3b89c0..446e71df6f 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -722,9 +722,9 @@ static void sdp_service_record_build(struct sdp_servi=
ce_record_s *record,
     }
     record->uuids =3D pow2ceil(record->uuids);
     record->attribute_list =3D
-            g_malloc0(record->attributes * sizeof(*record->attribute_lis=
t));
+            g_new0(typeof(*record->attribute_list), record->attributes);
     record->uuid =3D
-            g_malloc0(record->uuids * sizeof(*record->uuid));
+            g_new0(typeof(*record->uuid), record->uuids);
     data =3D g_malloc(len);
=20
     record->attributes =3D 0;
@@ -766,7 +766,7 @@ static void sdp_service_db_build(struct bt_l2cap_sdp_=
state_s *sdp,
     while (service[sdp->services])
         sdp->services ++;
     sdp->service_list =3D
-            g_malloc0(sdp->services * sizeof(*sdp->service_list));
+            g_new0(typeof(*sdp->service_list), sdp->services);
=20
     sdp->services =3D 0;
     while (*service) {
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 75a1a2f55e..67681b4c8c 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -608,7 +608,7 @@ bool parallel_mm_init(MemoryRegion *address_space,
 {
     ParallelState *s;
=20
-    s =3D g_malloc0(sizeof(ParallelState));
+    s =3D g_new0(ParallelState, 1);
     s->irq =3D irq;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     s->it_shift =3D it_shift;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index e1f12507bf..1da46d0803 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -941,7 +941,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
 {
     SerialState *s;
=20
-    s =3D g_malloc0(sizeof(SerialState));
+    s =3D g_new0(SerialState, 1);
=20
     s->irq =3D irq;
     s->baudbase =3D baudbase;
@@ -997,7 +997,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
 {
     SerialState *s;
=20
-    s =3D g_malloc0(sizeof(SerialState));
+    s =3D g_new0(SerialState, 1);
=20
     s->it_shift =3D it_shift;
     s->irq =3D irq;
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index ca9816d045..de68d7120c 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -365,7 +365,7 @@ void sh_serial_init(MemoryRegion *sysmem,
 {
     sh_serial_state *s;
=20
-    s =3D g_malloc0(sizeof(sh_serial_state));
+    s =3D g_new0(sh_serial_state, 1);
=20
     s->feat =3D feat;
     s->flags =3D SH_SERIAL_FLAG_TEND | SH_SERIAL_FLAG_TDE;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 823e1c915c..53ede44ecf 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -742,7 +742,7 @@ static int fetch_active_ports_list(QEMUFile *f,
     s->post_load =3D g_malloc0(sizeof(*s->post_load));
     s->post_load->nr_active_ports =3D nr_active_ports;
     s->post_load->connected =3D
-        g_malloc0(sizeof(*s->post_load->connected) * nr_active_ports);
+        g_new0(typeof(*s->post_load->connected), nr_active_ports);
=20
     s->post_load->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                             virtio_serial_post_load_time=
r_cb,
@@ -1047,10 +1047,8 @@ static void virtio_serial_device_realize(DeviceSta=
te *dev, Error **errp)
     QTAILQ_INIT(&vser->ports);
=20
     vser->bus.max_nr_ports =3D vser->serial.max_virtserial_ports;
-    vser->ivqs =3D g_malloc(vser->serial.max_virtserial_ports
-                          * sizeof(VirtQueue *));
-    vser->ovqs =3D g_malloc(vser->serial.max_virtserial_ports
-                          * sizeof(VirtQueue *));
+    vser->ivqs =3D g_new(VirtQueue *, vser->serial.max_virtserial_ports)=
;
+    vser->ovqs =3D g_new(VirtQueue *, vser->serial.max_virtserial_ports)=
;
=20
     /* Add a queue for host to guest transfers for port 0 (backward comp=
at) */
     vser->ivqs[0] =3D virtio_add_queue(vdev, 128, handle_input);
@@ -1076,8 +1074,8 @@ static void virtio_serial_device_realize(DeviceStat=
e *dev, Error **errp)
     }
=20
     vser->ports_map =3D
-        g_malloc0(DIV_ROUND_UP(vser->serial.max_virtserial_ports, 32)
-                  * sizeof(vser->ports_map[0]));
+        g_new0(typeof(vser->ports_map[0]),
+               DIV_ROUND_UP(vser->serial.max_virtserial_ports, 32));
     /*
      * Reserve location 0 for a console port for backward compat
      * (old kernel, new qemu)
diff --git a/hw/core/irq.c b/hw/core/irq.c
index b98d1d69f5..d9b13b1762 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -115,7 +115,7 @@ static void qemu_splitirq(void *opaque, int line, int=
 level)
=20
 qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2)
 {
-    qemu_irq *s =3D g_malloc0(2 * sizeof(qemu_irq));
+    qemu_irq *s =3D g_new0(qemu_irq, 2);
     s[0] =3D irq1;
     s[1] =3D irq2;
     return qemu_allocate_irq(qemu_splitirq, s, 0);
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7221c68a98..554aa33d05 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -349,7 +349,7 @@ ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_=
mask)
 {
     ptimer_state *s;
=20
-    s =3D (ptimer_state *)g_malloc0(sizeof(ptimer_state));
+    s =3D (ptimer_state *) g_new0(ptimer_state, 1);
     s->bh =3D bh;
     s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, ptimer_tick, s);
     s->policy_mask =3D policy_mask;
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 84c8869371..01d86c3a95 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -40,7 +40,7 @@ static QTAILQ_HEAD(reset_handlers, QEMUResetEntry) rese=
t_handlers =3D
=20
 void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 {
-    QEMUResetEntry *re =3D g_malloc0(sizeof(QEMUResetEntry));
+    QEMUResetEntry *re =3D g_new0(QEMUResetEntry, 1);
=20
     re->func =3D func;
     re->opaque =3D opaque;
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 60df8877c1..39924dd7c8 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -323,7 +323,7 @@ void axisdev88_init(MachineState *machine)
     }
=20
     /* Add the two ethernet blocks.  */
-    dma_eth =3D g_malloc0(sizeof dma_eth[0] * 4); /* Allocate 4 channels=
.  */
+    dma_eth =3D g_new0(typeof(dma_eth[0]), 4); /* Allocate 4 channels.  =
*/
     etraxfs_eth_init(&nd_table[0], 0x30034000, 1, &dma_eth[0], &dma_eth[=
1]);
     if (nb_nics > 1) {
         etraxfs_eth_init(&nd_table[1], 0x30036000, 2, &dma_eth[2], &dma_=
eth[3]);
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 845521c5b2..0ca997cae2 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -1006,7 +1006,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysm=
em,
     PXA2xxLCDState *s;
     DisplaySurface *surface;
=20
-    s =3D (PXA2xxLCDState *) g_malloc0(sizeof(PXA2xxLCDState));
+    s =3D g_new0(PXA2xxLCDState, 1);
     s->invalidated =3D 1;
     s->irq =3D irq;
     s->sysmem =3D sysmem;
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 92f7120acc..2f71da1ee9 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -570,7 +570,7 @@ TC6393xbState *tc6393xb_init(MemoryRegion *sysmem, ui=
nt32_t base, qemu_irq irq)
         },
     };
=20
-    s =3D (TC6393xbState *) g_malloc0(sizeof(TC6393xbState));
+    s =3D g_new0(TC6393xbState, 1);
     s->irq =3D irq;
     s->gpio_in =3D qemu_allocate_irqs(tc6393xb_gpio_set, s, TC6393XB_GPI=
OS);
=20
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 641f57e7c5..201b69002a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -628,9 +628,9 @@ int virtio_gpu_create_mapping_iov(struct virtio_gpu_r=
esource_attach_backing *ab,
         return -1;
     }
=20
-    *iov =3D g_malloc0(sizeof(struct iovec) * ab->nr_entries);
+    *iov =3D g_new0(struct iovec, ab->nr_entries);
     if (addr) {
-        *addr =3D g_malloc0(sizeof(uint64_t) * ab->nr_entries);
+        *addr =3D g_new0(uint64_t, ab->nr_entries);
     }
     for (i =3D 0; i < ab->nr_entries; i++) {
         hwaddr len =3D ents[i].length;
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index e76c0d805c..aa9821b6e6 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -475,8 +475,8 @@ static int xenfb_map_fb(struct XenFB *xenfb)
     n_fbdirs =3D xenfb->fbpages * mode / 8;
     n_fbdirs =3D DIV_ROUND_UP(n_fbdirs, XC_PAGE_SIZE);
=20
-    pgmfns =3D g_malloc0(sizeof(xen_pfn_t) * n_fbdirs);
-    fbmfns =3D g_malloc0(sizeof(xen_pfn_t) * xenfb->fbpages);
+    pgmfns =3D g_new0(xen_pfn_t, n_fbdirs);
+    fbmfns =3D g_new0(xen_pfn_t, xenfb->fbpages);
=20
     xenfb_copy_mfns(mode, n_fbdirs, pgmfns, pd);
     map =3D xenforeignmemory_map(xen_fmem, xenfb->c.xendev.dom,
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index d5650eb885..014efe9c1b 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -773,7 +773,7 @@ void *etraxfs_dmac_init(hwaddr base, int nr_channels)
         ctrl->bh =3D qemu_bh_new(DMA_run, ctrl);
=20
 	ctrl->nr_channels =3D nr_channels;
-	ctrl->channels =3D g_malloc0(sizeof ctrl->channels[0] * nr_channels);
+	ctrl->channels =3D g_new0(typeof(ctrl->channels[0]), nr_channels);
=20
 	memory_region_init_io(&ctrl->mmio, NULL, &dma_ops, ctrl, "etraxfs-dma",
 			      nr_channels * 0x2000);
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index edf9432051..89248e7418 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -638,8 +638,8 @@ static rc4030_dma *rc4030_allocate_dmas(void *opaque,=
 int n)
     struct rc4030DMAState *p;
     int i;
=20
-    s =3D (rc4030_dma *)g_malloc0(sizeof(rc4030_dma) * n);
-    p =3D (struct rc4030DMAState *)g_malloc0(sizeof(struct rc4030DMAStat=
e) * n);
+    s =3D g_new0(rc4030_dma, n);
+    p =3D g_new0(struct rc4030DMAState, n);
     for (i =3D 0; i < n; i++) {
         p->opaque =3D opaque;
         p->n =3D i;
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 9bb499bf9c..f1b520ffb9 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -262,8 +262,7 @@ void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwa=
ddr virt_base,
     struct memmap_entry_s *entry;
     struct dma_s *dma =3D (struct dma_s *) soc;
=20
-    dma->memmap =3D g_realloc(dma->memmap, sizeof(*entry) *
-                    (dma->memmap_size + 1));
+    dma->memmap =3D g_renew(typeof(*entry), dma->memmap, dma->memmap_siz=
e + 1);
     entry =3D soc_dma_lookup(dma, virt_base);
=20
     if (dma->memmap_size) {
@@ -312,8 +311,7 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint=
8_t *phys_base,
     struct memmap_entry_s *entry;
     struct dma_s *dma =3D (struct dma_s *) soc;
=20
-    dma->memmap =3D g_realloc(dma->memmap, sizeof(*entry) *
-                    (dma->memmap_size + 1));
+    dma->memmap =3D g_renew(typeof(*entry), dma->memmap, dma->memmap_siz=
e + 1);
     entry =3D soc_dma_lookup(dma, virt_base);
=20
     if (dma->memmap_size) {
diff --git a/hw/i2c/bitbang_i2c.c b/hw/i2c/bitbang_i2c.c
index 8be88ee265..20a9deef1a 100644
--- a/hw/i2c/bitbang_i2c.c
+++ b/hw/i2c/bitbang_i2c.c
@@ -186,7 +186,7 @@ bitbang_i2c_interface *bitbang_i2c_init(I2CBus *bus)
 {
     bitbang_i2c_interface *s;
=20
-    s =3D g_malloc0(sizeof(bitbang_i2c_interface));
+    s =3D g_new0(bitbang_i2c_interface, 1);
=20
     s->bus =3D bus;
     s->last_data =3D 1;
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 2c1234cdff..1c7959254f 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -130,7 +130,7 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, =
int recv)
             DeviceState *qdev =3D kid->child;
             I2CSlave *candidate =3D I2C_SLAVE(qdev);
             if ((candidate->address =3D=3D address) || (bus->broadcast))=
 {
-                node =3D g_malloc(sizeof(struct I2CNode));
+                node =3D g_new(struct I2CNode, 1);
                 node->elt =3D candidate;
                 QLIST_INSERT_HEAD(&bus->current_devs, node, next);
                 if (!bus->broadcast) {
@@ -256,7 +256,7 @@ static int i2c_slave_post_load(void *opaque, int vers=
ion_id)
     bus =3D I2C_BUS(qdev_get_parent_bus(DEVICE(dev)));
     if ((bus->saved_address =3D=3D dev->address) ||
         (bus->saved_address =3D=3D I2C_BROADCAST)) {
-        node =3D g_malloc(sizeof(struct I2CNode));
+        node =3D g_new(struct I2CNode, 1);
         node->elt =3D dev;
         QLIST_INSERT_HEAD(&bus->current_devs, node, next);
     }
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7b6d4ea3f3..78fafc8eeb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1033,13 +1033,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus =
*bus, void *opaque, int devfn)
=20
     /* allocate memory during the first run */
     if (!iommu_as) {
-        iommu_as =3D g_malloc0(sizeof(AMDVIAddressSpace *) * PCI_DEVFN_M=
AX);
+        iommu_as =3D g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
         s->address_spaces[bus_num] =3D iommu_as;
     }
=20
     /* set up AMD-Vi region */
     if (!iommu_as[devfn]) {
-        iommu_as[devfn] =3D g_malloc0(sizeof(AMDVIAddressSpace));
+        iommu_as[devfn] =3D g_new0(AMDVIAddressSpace, 1);
         iommu_as[devfn]->bus_num =3D (uint8_t)bus_num;
         iommu_as[devfn]->devfn =3D (uint8_t)devfn;
         iommu_as[devfn]->iommu_state =3D s;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 15610b9de8..e7e9eed416 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2790,7 +2790,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s=
, PCIBus *bus, int devfn)
=20
     if (!vtd_dev_as) {
         snprintf(name, sizeof(name), "intel_iommu_devfn_%d", devfn);
-        vtd_bus->dev_as[devfn] =3D vtd_dev_as =3D g_malloc0(sizeof(VTDAd=
dressSpace));
+        vtd_bus->dev_as[devfn] =3D vtd_dev_as =3D g_new0(VTDAddressSpace=
, 1);
=20
         vtd_dev_as->bus =3D bus;
         vtd_dev_as->devfn =3D (uint8_t)devfn;
diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
index 87dcbdd51a..41df0cc7f6 100644
--- a/hw/i386/kvm/pci-assign.c
+++ b/hw/i386/kvm/pci-assign.c
@@ -1068,7 +1068,7 @@ static int assigned_dev_update_msix_mmio(PCIDevice =
*pci_dev)
     free_msi_virqs(adev);
=20
     adev->msi_virq_nr =3D adev->msix_max;
-    adev->msi_virq =3D g_malloc(adev->msix_max * sizeof(*adev->msi_virq)=
);
+    adev->msi_virq =3D g_new(typeof(*adev->msi_virq), adev->msix_max);
=20
     entry =3D adev->msix_table;
     for (i =3D 0; i < adev->msix_max; i++, entry++) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5b8c6fbbea..e8eed042ae 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -720,7 +720,7 @@ static void pc_build_smbios(PCMachineState *pcms)
     }
=20
     /* build the array of physical mem area from e820 table */
-    mem_array =3D g_malloc0(sizeof(*mem_array) * e820_get_num_entries())=
;
+    mem_array =3D g_new0(typeof(*mem_array), e820_get_num_entries());
     for (i =3D 0, array_count =3D 0; i < e820_get_num_entries(); i++) {
         uint64_t addr, len;
=20
@@ -1280,8 +1280,7 @@ void pc_guest_info_init(PCMachineState *pcms)
=20
     pcms->apic_xrupt_override =3D kvm_allows_irq0_override();
     pcms->numa_nodes =3D nb_numa_nodes;
-    pcms->node_mem =3D g_malloc0(pcms->numa_nodes *
-                                    sizeof *pcms->node_mem);
+    pcms->node_mem =3D g_new0(typeof(*pcms->node_mem), pcms->numa_nodes)=
;
     for (i =3D 0; i < nb_numa_nodes; i++) {
         pcms->node_mem[i] =3D numa_info[i].node_mem;
     }
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 1acd4de405..17285a6f84 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -260,7 +260,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t si=
ze, MemoryRegion *mr,
     trace_xen_ram_alloc(ram_addr, size);
=20
     nr_pfn =3D size >> TARGET_PAGE_BITS;
-    pfn_list =3D g_malloc(sizeof (*pfn_list) * nr_pfn);
+    pfn_list =3D g_new(typeof(*pfn_list), nr_pfn);
=20
     for (i =3D 0; i < nr_pfn; i++) {
         pfn_list[i] =3D (ram_addr >> TARGET_PAGE_BITS) + i;
@@ -355,7 +355,7 @@ go_physmap:
=20
     mr_name =3D memory_region_name(mr);
=20
-    physmap =3D g_malloc(sizeof (XenPhysmap));
+    physmap =3D g_new(XenPhysmap, 1);
=20
     physmap->start_addr =3D start_addr;
     physmap->size =3D size;
@@ -1167,7 +1167,7 @@ static void xen_read_physmap(XenIOState *state)
         return;
=20
     for (i =3D 0; i < num; i++) {
-        physmap =3D g_malloc(sizeof (XenPhysmap));
+        physmap =3D g_new(XenPhysmap, 1);
         physmap->phys_offset =3D strtoull(entries[i], NULL, 16);
         snprintf(path, sizeof(path),
                 "/local/domain/0/device-model/%d/physmap/%s/start_addr",
@@ -1214,7 +1214,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegio=
n **ram_memory)
     evtchn_port_t bufioreq_evtchn;
     XenIOState *state;
=20
-    state =3D g_malloc0(sizeof (XenIOState));
+    state =3D g_new0(XenIOState, 1);
=20
     state->xce_handle =3D xenevtchn_open(NULL, 0);
     if (state->xce_handle =3D=3D NULL) {
@@ -1295,7 +1295,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegio=
n **ram_memory)
     }
=20
     /* Note: cpus is empty at this point in init */
-    state->cpu_by_vcpu_id =3D g_malloc0(max_cpus * sizeof(CPUState *));
+    state->cpu_by_vcpu_id =3D g_new0(CPUState *, max_cpus);
=20
     rc =3D xen_set_ioreq_server_state(xen_domid, state->ioservid, true);
     if (rc < 0) {
@@ -1304,7 +1304,7 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegio=
n **ram_memory)
         goto err;
     }
=20
-    state->ioreq_local_port =3D g_malloc0(max_cpus * sizeof (evtchn_port=
_t));
+    state->ioreq_local_port =3D g_new0(evtchn_port_t, max_cpus);
=20
     /* FIXME: how about if we overflow the page here? */
     for (i =3D 0; i < max_cpus; i++) {
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index e60156c04f..bbfd60e1ec 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -106,7 +106,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, voi=
d *opaque)
     unsigned long size;
     struct rlimit rlimit_as;
=20
-    mapcache =3D g_malloc0(sizeof (MapCache));
+    mapcache =3D g_new0(MapCache, 1);
=20
     mapcache->phys_offset_to_gaddr =3D f;
     mapcache->opaque =3D opaque;
@@ -160,8 +160,8 @@ static void xen_remap_bucket(MapCacheEntry *entry,
=20
     trace_xen_remap_bucket(address_index);
=20
-    pfns =3D g_malloc0(nb_pfn * sizeof (xen_pfn_t));
-    err =3D g_malloc0(nb_pfn * sizeof (int));
+    pfns =3D g_new0(xen_pfn_t, nb_pfn);
+    err =3D g_new0(int, nb_pfn);
=20
     if (entry->vaddr_base !=3D NULL) {
         ram_block_notify_remove(entry->vaddr_base, entry->size);
@@ -187,8 +187,8 @@ static void xen_remap_bucket(MapCacheEntry *entry,
     entry->vaddr_base =3D vaddr_base;
     entry->paddr_index =3D address_index;
     entry->size =3D size;
-    entry->valid_mapping =3D (unsigned long *) g_malloc0(sizeof(unsigned=
 long) *
-            BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
+    entry->valid_mapping =3D g_new0(unsigned long,
+                                  BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
=20
     ram_block_notify_add(entry->vaddr_base, entry->size);
     bitmap_zero(entry->valid_mapping, nb_pfn);
@@ -260,7 +260,7 @@ tryagain:
         entry =3D entry->next;
     }
     if (!entry) {
-        entry =3D g_malloc0(sizeof (MapCacheEntry));
+        entry =3D g_new0(MapCacheEntry, 1);
         pentry->next =3D entry;
         xen_remap_bucket(entry, cache_size, address_index);
     } else if (!entry->lock) {
@@ -288,7 +288,7 @@ tryagain:
=20
     mapcache->last_entry =3D entry;
     if (lock) {
-        MapCacheRev *reventry =3D g_malloc0(sizeof(MapCacheRev));
+        MapCacheRev *reventry =3D g_new0(MapCacheRev, 1);
         entry->lock++;
         reventry->dma =3D dma;
         reventry->vaddr_req =3D mapcache->last_entry->vaddr_base + addre=
ss_offset;
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f827b6..ef9e055b1d 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -465,7 +465,7 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_i=
rq,
                    MemoryRegion *region, ram_addr_t size,
                    hwaddr mask)
 {
-    KBDState *s =3D g_malloc0(sizeof(KBDState));
+    KBDState *s =3D g_new0(KBDState, 1);
=20
     s->irq_kbd =3D kbd_irq;
     s->irq_mouse =3D mouse_irq;
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 1d3a440bbd..8976b55a64 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1294,7 +1294,7 @@ static QemuInputHandler ps2_keyboard_handler =3D {
=20
 void *ps2_kbd_init(void (*update_irq)(void *, int), void *update_arg)
 {
-    PS2KbdState *s =3D (PS2KbdState *)g_malloc0(sizeof(PS2KbdState));
+    PS2KbdState *s =3D g_new0(PS2KbdState, 1);
=20
     trace_ps2_kbd_init(s);
     s->common.update_irq =3D update_irq;
@@ -1316,7 +1316,7 @@ static QemuInputHandler ps2_mouse_handler =3D {
=20
 void *ps2_mouse_init(void (*update_irq)(void *, int), void *update_arg)
 {
-    PS2MouseState *s =3D (PS2MouseState *)g_malloc0(sizeof(PS2MouseState=
));
+    PS2MouseState *s =3D g_new0(PS2MouseState, 1);
=20
     trace_ps2_mouse_init(s);
     s->common.update_irq =3D update_irq;
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
index 2b70bbb95c..016b095e94 100644
--- a/hw/input/pxa2xx_keypad.c
+++ b/hw/input/pxa2xx_keypad.c
@@ -310,7 +310,7 @@ PXA2xxKeyPadState *pxa27x_keypad_init(MemoryRegion *s=
ysmem,
 {
     PXA2xxKeyPadState *s;
=20
-    s =3D (PXA2xxKeyPadState *) g_malloc0(sizeof(PXA2xxKeyPadState));
+    s =3D g_new0(PXA2xxKeyPadState, 1);
     s->irq =3D irq;
=20
     memory_region_init_io(&s->iomem, NULL, &pxa2xx_keypad_ops, s,
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index eb5320af40..34dd4ea0da 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -485,8 +485,7 @@ void *tsc2005_init(qemu_irq pintdav)
 {
     TSC2005State *s;
=20
-    s =3D (TSC2005State *)
-            g_malloc0(sizeof(TSC2005State));
+    s =3D g_new0(TSC2005State, 1);
     s->x =3D 400;
     s->y =3D 240;
     s->pressure =3D false;
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 0e42f0d02c..f485658cb1 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -31,8 +31,8 @@ void virtio_input_send(VirtIOInput *vinput, virtio_inpu=
t_event *event)
     /* queue up events ... */
     if (vinput->qindex =3D=3D vinput->qsize) {
         vinput->qsize++;
-        vinput->queue =3D g_realloc(vinput->queue, vinput->qsize *
-                                  sizeof(vinput->queue[0]));
+        vinput->queue =3D g_renew(typeof(vinput->queue[0]), vinput->queu=
e,
+                                vinput->qsize);
     }
     vinput->queue[vinput->qindex++].event =3D *event;
=20
diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 2a55817b76..5bf2301bee 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -444,7 +444,7 @@ static void exynos4210_irq_gate_realize(DeviceState *=
dev, Error **errp)
      * them */
     qdev_init_gpio_in(dev, exynos4210_irq_gate_handler, s->n_in);
=20
-    s->level =3D g_malloc0(s->n_in * sizeof(*s->level));
+    s->level =3D g_new0(typeof(*s->level), s->n_in);
 }
=20
 static void exynos4210_irq_gate_class_init(ObjectClass *klass, void *dat=
a)
diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
index 171f5ed814..90c1e6a4b1 100644
--- a/hw/intc/heathrow_pic.c
+++ b/hw/intc/heathrow_pic.c
@@ -201,7 +201,7 @@ qemu_irq *heathrow_pic_init(MemoryRegion **pmem,
 {
     HeathrowPICS *s;
=20
-    s =3D g_malloc0(sizeof(HeathrowPICS));
+    s =3D g_new0(HeathrowPICS, 1);
     /* only 1 CPU */
     s->irqs =3D irqs[0];
     memory_region_init_io(&s->mem, NULL, &heathrow_pic_ops, s,
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ea3516794a..2db63b6192 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -609,7 +609,7 @@ static void ics_simple_realize(DeviceState *dev, Erro=
r **errp)
         error_setg(errp, "Number of interrupts needs to be greater 0");
         return;
     }
-    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
+    ics->irqs =3D g_new0(ICSIRQState, ics->nr_irqs);
     ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
=20
     qemu_register_reset(ics_simple_reset, dev);
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 14b8f6f6e4..fe0dd5eb73 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -359,7 +359,7 @@ static void ics_kvm_realize(DeviceState *dev, Error *=
*errp)
         error_setg(errp, "Number of interrupts needs to be greater 0");
         return;
     }
-    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
+    ics->irqs =3D g_new0(ICSIRQState, ics->nr_irqs);
     ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs=
);
=20
     qemu_register_reset(ics_kvm_reset, dev);
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 8f0c3079d6..276d6a62ac 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -99,7 +99,7 @@ static void lm32_evr_init(MachineState *machine)
     int timer0_irq                 =3D 1;
     int timer1_irq                 =3D 3;
=20
-    reset_info =3D g_malloc0(sizeof(ResetInfo));
+    reset_info =3D g_new0(ResetInfo, 1);
=20
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "lm32-full";
@@ -200,7 +200,7 @@ static void lm32_uclinux_init(MachineState *machine)
     hwaddr initrd_base  =3D 0x08400000;
     size_t initrd_max               =3D 0x01000000;
=20
-    reset_info =3D g_malloc0(sizeof(ResetInfo));
+    reset_info =3D g_new0(ResetInfo, 1);
=20
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "lm32-full";
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 5cae0f19dd..339a80f40b 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -106,7 +106,7 @@ milkymist_init(MachineState *machine)
     hwaddr cmdline_base =3D sdram_base + 0x1000000;
     size_t initrd_max =3D sdram_size - 0x1002000;
=20
-    reset_info =3D g_malloc0(sizeof(ResetInfo));
+    reset_info =3D g_new0(ResetInfo, 1);
=20
     if (cpu_model =3D=3D NULL) {
         cpu_model =3D "lm32-full";
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b81901fdfd..df45e99547 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -137,7 +137,7 @@ static m5206_timer_state *m5206_timer_init(qemu_irq i=
rq)
     m5206_timer_state *s;
     QEMUBH *bh;
=20
-    s =3D (m5206_timer_state *)g_malloc0(sizeof(m5206_timer_state));
+    s =3D g_new0(m5206_timer_state, 1);
     bh =3D qemu_bh_new(m5206_timer_trigger, s);
     s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
     s->irq =3D irq;
@@ -533,7 +533,7 @@ qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t=
 base, M68kCPU *cpu)
     m5206_mbar_state *s;
     qemu_irq *pic;
=20
-    s =3D (m5206_mbar_state *)g_malloc0(sizeof(m5206_mbar_state));
+    s =3D g_new0(m5206_mbar_state, 1);
=20
     memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
                           "mbar", 0x00001000);
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 656351834e..5540719309 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -183,7 +183,7 @@ static void mcf5208_sys_init(MemoryRegion *address_sp=
ace, qemu_irq *pic)
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
     /* Timers.  */
     for (i =3D 0; i < 2; i++) {
-        s =3D (m5208_timer_state *)g_malloc0(sizeof(m5208_timer_state));
+        s =3D g_new0(m5208_timer_state, 1);
         bh =3D qemu_bh_new(m5208_timer_trigger, s);
         s->timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
         memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 95cdabb2dd..0adbfae39a 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -555,7 +555,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *=
address_space,
     MaltaFPGAState *s;
     Chardev *chr;
=20
-    s =3D (MaltaFPGAState *)g_malloc0(sizeof(MaltaFPGAState));
+    s =3D g_new0(MaltaFPGAState, 1);
=20
     memory_region_init_io(&s->iomem, NULL, &malta_fpga_ops, s,
                           "malta-fpga", 0x100000);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 1b91195006..ff624d71ef 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -169,7 +169,7 @@ mips_mipssim_init(MachineState *machine)
     }
     env =3D &cpu->env;
=20
-    reset_info =3D g_malloc0(sizeof(ResetData));
+    reset_info =3D g_new0(ResetData, 1);
     reset_info->cpu =3D cpu;
     reset_info->vector =3D env->active_tc.PC;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index f4de9fc343..6780e60094 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -198,7 +198,7 @@ void mips_r4k_init(MachineState *machine)
     }
     env =3D &cpu->env;
=20
-    reset_info =3D g_malloc0(sizeof(ResetData));
+    reset_info =3D g_new0(ResetData, 1);
     reset_info->cpu =3D cpu;
     reset_info->vector =3D env->active_tc.PC;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 77fab5b9d2..416875dea7 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -179,7 +179,7 @@ static void applesmc_add_key(AppleSMCState *s, const =
char *key,
 {
     struct AppleSMCData *def;
=20
-    def =3D g_malloc0(sizeof(struct AppleSMCData));
+    def =3D g_new0(struct AppleSMCData, 1);
     def->key =3D key;
     def->len =3D len;
     def->data =3D data;
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index cfb08710fb..9342bce6de 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -149,7 +149,7 @@ static void imx6_defer_clear_reset_bit(int cpuid,
         return;
     }
=20
-    ri =3D g_malloc(sizeof(struct SRCSCRResetInfo));
+    ri =3D g_new(struct SRCSCRResetInfo, 1);
     ri->s =3D s;
     ri->reset_bit =3D reset_shift;
=20
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6367d041f0..75832c02a3 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -429,7 +429,7 @@ static void resize_peers(IVShmemState *s, int nb_peer=
s)
     assert(nb_peers > old_nb_peers);
     IVSHMEM_DPRINTF("bumping storage to %d peers\n", nb_peers);
=20
-    s->peers =3D g_realloc(s->peers, nb_peers * sizeof(Peer));
+    s->peers =3D g_renew(Peer, s->peers, nb_peers);
     s->nb_peers =3D nb_peers;
=20
     for (i =3D old_nb_peers; i < nb_peers; i++) {
@@ -752,7 +752,7 @@ static void ivshmem_reset(DeviceState *d)
 static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
 {
     /* allocate QEMU callback data for receiving interrupts */
-    s->msi_vectors =3D g_malloc0(s->vectors * sizeof(MSIVector));
+    s->msi_vectors =3D g_new0(MSIVector, s->vectors);
=20
     if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
         if (msix_init_exclusive_bar(PCI_DEVICE(s), s->vectors, 1, errp))=
 {
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 15452b9a28..1b8c80ba75 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -803,7 +803,7 @@ void* DBDMA_init (MemoryRegion **dbdma_mem)
     DBDMAState *s;
     int i;
=20
-    s =3D g_malloc0(sizeof(DBDMAState));
+    s =3D g_new0(DBDMAState, 1);
=20
     for (i =3D 0; i < DBDMA_CHANNELS; i++) {
         DBDMA_io *io =3D &s->channels[i].io;
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 7d5990213e..c08049d570 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -254,7 +254,7 @@ static void pci_testdev_realize(PCIDevice *pci_dev, E=
rror **errp)
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->portio);
=20
     d->current =3D -1;
-    d->tests =3D g_malloc0(IOTEST_MAX * sizeof *d->tests);
+    d->tests =3D g_new0(typeof(*d->tests), IOTEST_MAX);
     for (i =3D 0; i < IOTEST_MAX; ++i) {
         IOTest *test =3D &d->tests[i];
         name =3D g_strdup_printf("%s-%s", IOTEST_TYPE(i), IOTEST_TEST(i)=
);
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index cef1c2e0d1..8d9454c719 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -78,7 +78,7 @@ net_rx_pkt_iovec_realloc(struct NetRxPkt *pkt,
 {
     if (pkt->vec_len_total < new_iov_len) {
         g_free(pkt->vec);
-        pkt->vec =3D g_malloc(sizeof(*pkt->vec) * new_iov_len);
+        pkt->vec =3D g_new(typeof(*pkt->vec), new_iov_len);
         pkt->vec_len_total =3D new_iov_len;
     }
 }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9a3d769aa2..84c13cdc29 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1934,7 +1934,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
         virtio_cleanup(vdev);
         return;
     }
-    n->vqs =3D g_malloc0(sizeof(VirtIONetQueue) * n->max_queues);
+    n->vqs =3D g_new0(VirtIONetQueue, n->max_queues);
     n->curr_queues =3D 1;
     n->tx_timeout =3D n->net_conf.txtimer;
=20
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 4af09afe6b..e94a88594a 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -317,7 +317,7 @@ int msix_init(struct PCIDevice *dev, unsigned short n=
entries,
=20
     dev->msix_table =3D g_malloc0(table_size);
     dev->msix_pba =3D g_malloc0(pba_size);
-    dev->msix_entry_used =3D g_malloc0(nentries * sizeof *dev->msix_entr=
y_used);
+    dev->msix_entry_used =3D g_new0(typeof(*dev->msix_entry_used), nentr=
ies);
=20
     msix_mask_all(dev, nentries);
=20
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 98ccc27533..8b948c2c09 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -419,7 +419,7 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq=
, pci_map_irq_fn map_irq,
     bus->map_irq =3D map_irq;
     bus->irq_opaque =3D irq_opaque;
     bus->nirq =3D nirq;
-    bus->irq_count =3D g_malloc0(nirq * sizeof(bus->irq_count[0]));
+    bus->irq_count =3D g_new0(typeof(bus->irq_count[0]), nirq);
 }
=20
 PCIBus *pci_register_bus(DeviceState *parent, const char *name,
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 828052b0c0..59753a7f18 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -117,8 +117,8 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, ui=
nt16_t offset,
                 "is %d", dev->exp.aer_log.log_max, PCIE_AER_LOG_MAX_LIMI=
T);
         return -EINVAL;
     }
-    dev->exp.aer_log.log =3D g_malloc0(sizeof dev->exp.aer_log.log[0] *
-                                        dev->exp.aer_log.log_max);
+    dev->exp.aer_log.log =3D g_new0(typeof(dev->exp.aer_log.log[0]),
+                                  dev->exp.aer_log.log_max);
=20
     pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
                  PCI_ERR_UNC_SUPPORTED);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 62f1857206..60cf07777a 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -812,7 +812,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
         machine->cpu_model =3D "e500v2_v30";
     }
=20
-    irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
+    irqs =3D g_new0(qemu_irq *, smp_cpus);
     irqs[0] =3D g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_N=
B);
     for (i =3D 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
@@ -851,7 +851,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
         if (!i) {
             /* Primary CPU */
             struct boot_info *boot_info;
-            boot_info =3D g_malloc0(sizeof(struct boot_info));
+            boot_info =3D g_new0(struct boot_info, 1);
             qemu_register_reset(ppce500_cpu_reset, cpu);
             env->load_info =3D boot_info;
         } else {
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bae1c0ac99..9e4c06e2e6 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -304,7 +304,7 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_init_io(unin2_memory, NULL, &unin_ops, token, "unin", =
0x1000);
     memory_region_add_subregion(get_system_memory(), 0xf3000000, unin2_m=
emory);
=20
-    openpic_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
+    openpic_irqs =3D g_new0(qemu_irq *, smp_cpus);
     openpic_irqs[0] =3D
         g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
     for (i =3D 0; i < smp_cpus; i++) {
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 97bb8541d7..d1cae32293 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -241,7 +241,7 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0xfe000000, isa);
=20
     /* XXX: we register only 1 output pin for heathrow PIC */
-    heathrow_irqs =3D g_malloc0(smp_cpus * sizeof(qemu_irq *));
+    heathrow_irqs =3D g_new0(qemu_irq *, smp_cpus);
     heathrow_irqs[0] =3D
         g_malloc0(smp_cpus * sizeof(qemu_irq) * 1);
     /* Connect the heathrow PIC outputs to the 6xx bus */
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 224184d66d..66fa2f5629 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -963,7 +963,7 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint3=
2_t freq)
     PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
     ppc_tb_t *tb_env;
=20
-    tb_env =3D g_malloc0(sizeof(ppc_tb_t));
+    tb_env =3D g_new0(ppc_tb_t, 1);
     env->tb_env =3D tb_env;
     tb_env->flags =3D PPC_DECR_UNDERFLOW_TRIGGERED;
     if (env->insns_flags & PPC_SEGMENT_64B) {
@@ -1222,10 +1222,10 @@ clk_setup_cb ppc_40x_timers_init (CPUPPCState *en=
v, uint32_t freq,
     ppc_tb_t *tb_env;
     ppc40x_timer_t *ppc40x_timer;
=20
-    tb_env =3D g_malloc0(sizeof(ppc_tb_t));
+    tb_env =3D g_new0(ppc_tb_t, 1);
     env->tb_env =3D tb_env;
     tb_env->flags =3D PPC_DECR_UNDERFLOW_TRIGGERED;
-    ppc40x_timer =3D g_malloc0(sizeof(ppc40x_timer_t));
+    ppc40x_timer =3D g_new0(ppc40x_timer_t, 1);
     tb_env->tb_freq =3D freq;
     tb_env->decr_freq =3D freq;
     tb_env->opaque =3D ppc40x_timer;
@@ -1330,7 +1330,7 @@ int ppc_dcr_init (CPUPPCState *env, int (*read_erro=
r)(int dcrn),
 {
     ppc_dcr_t *dcr_env;
=20
-    dcr_env =3D g_malloc0(sizeof(ppc_dcr_t));
+    dcr_env =3D g_new0(ppc_dcr_t, 1);
     dcr_env->read_error =3D read_error;
     dcr_env->write_error =3D write_error;
     env->dcr_env =3D dcr_env;
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index d01798f245..4968c3fb70 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -169,7 +169,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, =
uint32_t base)
     ref405ep_fpga_t *fpga;
     MemoryRegion *fpga_memory =3D g_new(MemoryRegion, 1);
=20
-    fpga =3D g_malloc0(sizeof(ref405ep_fpga_t));
+    fpga =3D g_new0(ref405ep_fpga_t, 1);
     memory_region_init_io(fpga_memory, NULL, &ref405ep_fpga_ops, fpga,
                           "fpga", 0x00000100);
     memory_region_add_subregion(sysmem, base, fpga_memory);
@@ -189,7 +189,7 @@ static void ref405ep_init(MachineState *machine)
     MemoryRegion *bios;
     MemoryRegion *sram =3D g_new(MemoryRegion, 1);
     ram_addr_t bdloc;
-    MemoryRegion *ram_memories =3D g_malloc(2 * sizeof(*ram_memories));
+    MemoryRegion *ram_memories =3D g_new(typeof(*ram_memories), 2);
     hwaddr ram_bases[2], ram_sizes[2];
     target_ulong sram_size;
     long bios_size;
@@ -474,7 +474,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uin=
t32_t base)
     taihu_cpld_t *cpld;
     MemoryRegion *cpld_memory =3D g_new(MemoryRegion, 1);
=20
-    cpld =3D g_malloc0(sizeof(taihu_cpld_t));
+    cpld =3D g_new0(taihu_cpld_t, 1);
     memory_region_init_io(cpld_memory, NULL, &taihu_cpld_ops, cpld, "cpl=
d", 0x100);
     memory_region_add_subregion(sysmem, base, cpld_memory);
     qemu_register_reset(&taihu_cpld_reset, cpld);
@@ -489,7 +489,7 @@ static void taihu_405ep_init(MachineState *machine)
     qemu_irq *pic;
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *bios;
-    MemoryRegion *ram_memories =3D g_malloc(2 * sizeof(*ram_memories));
+    MemoryRegion *ram_memories =3D g_new(typeof(*ram_memories), 2);
     MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     hwaddr ram_bases[2], ram_sizes[2];
     long bios_size;
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index fc32e96bf4..eb1908dc0a 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -179,7 +179,7 @@ static void ppc4xx_plb_init(CPUPPCState *env)
 {
     ppc4xx_plb_t *plb;
=20
-    plb =3D g_malloc0(sizeof(ppc4xx_plb_t));
+    plb =3D g_new0(ppc4xx_plb_t, 1);
     ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_plb)=
;
     ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_plb)=
;
@@ -261,7 +261,7 @@ static void ppc4xx_pob_init(CPUPPCState *env)
 {
     ppc4xx_pob_t *pob;
=20
-    pob =3D g_malloc0(sizeof(ppc4xx_pob_t));
+    pob =3D g_new0(ppc4xx_pob_t, 1);
     ppc_dcr_register(env, POB0_BEAR, pob, &dcr_read_pob, &dcr_write_pob)=
;
     ppc_dcr_register(env, POB0_BESR0, pob, &dcr_read_pob, &dcr_write_pob=
);
     ppc_dcr_register(env, POB0_BESR1, pob, &dcr_read_pob, &dcr_write_pob=
);
@@ -392,7 +392,7 @@ static void ppc4xx_opba_init(hwaddr base)
 {
     ppc4xx_opba_t *opba;
=20
-    opba =3D g_malloc0(sizeof(ppc4xx_opba_t));
+    opba =3D g_new0(ppc4xx_opba_t, 1);
 #ifdef DEBUG_OPBA
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
 #endif
@@ -590,7 +590,7 @@ static void ppc405_ebc_init(CPUPPCState *env)
 {
     ppc4xx_ebc_t *ebc;
=20
-    ebc =3D g_malloc0(sizeof(ppc4xx_ebc_t));
+    ebc =3D g_new0(ppc4xx_ebc_t, 1);
     qemu_register_reset(&ebc_reset, ebc);
     ppc_dcr_register(env, EBC0_CFGADDR,
                      ebc, &dcr_read_ebc, &dcr_write_ebc);
@@ -673,7 +673,7 @@ static void ppc405_dma_init(CPUPPCState *env, qemu_ir=
q irqs[4])
 {
     ppc405_dma_t *dma;
=20
-    dma =3D g_malloc0(sizeof(ppc405_dma_t));
+    dma =3D g_new0(ppc405_dma_t, 1);
     memcpy(dma->irqs, irqs, 4 * sizeof(qemu_irq));
     qemu_register_reset(&ppc405_dma_reset, dma);
     ppc_dcr_register(env, DMA0_CR0,
@@ -814,7 +814,7 @@ static void ppc405_gpio_init(hwaddr base)
 {
     ppc405_gpio_t *gpio;
=20
-    gpio =3D g_malloc0(sizeof(ppc405_gpio_t));
+    gpio =3D g_new0(ppc405_gpio_t, 1);
 #ifdef DEBUG_GPIO
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
 #endif
@@ -976,7 +976,7 @@ static void ppc405_ocm_init(CPUPPCState *env)
 {
     ppc405_ocm_t *ocm;
=20
-    ocm =3D g_malloc0(sizeof(ppc405_ocm_t));
+    ocm =3D g_new0(ppc405_ocm_t, 1);
     /* XXX: Size is 4096 or 0x04000000 */
     memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
                            &error_fatal);
@@ -1224,7 +1224,7 @@ static void ppc405_i2c_init(hwaddr base, qemu_irq i=
rq)
 {
     ppc4xx_i2c_t *i2c;
=20
-    i2c =3D g_malloc0(sizeof(ppc4xx_i2c_t));
+    i2c =3D g_new0(ppc4xx_i2c_t, 1);
     i2c->irq =3D irq;
 #ifdef DEBUG_I2C
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
@@ -1500,7 +1500,7 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq i=
rqs[5])
     ppc4xx_gpt_t *gpt;
     int i;
=20
-    gpt =3D g_malloc0(sizeof(ppc4xx_gpt_t));
+    gpt =3D g_new0(ppc4xx_gpt_t, 1);
     for (i =3D 0; i < 5; i++) {
         gpt->irqs[i] =3D irqs[i];
     }
@@ -1731,7 +1731,7 @@ static void ppc405_mal_init(CPUPPCState *env, qemu_=
irq irqs[4])
     ppc40x_mal_t *mal;
     int i;
=20
-    mal =3D g_malloc0(sizeof(ppc40x_mal_t));
+    mal =3D g_new0(ppc40x_mal_t, 1);
     for (i =3D 0; i < 4; i++)
         mal->irqs[i] =3D irqs[i];
     qemu_register_reset(&ppc40x_mal_reset, mal);
@@ -2088,7 +2088,7 @@ static void ppc405cr_cpc_init (CPUPPCState *env, cl=
k_setup_t clk_setup[7],
 {
     ppc405cr_cpc_t *cpc;
=20
-    cpc =3D g_malloc0(sizeof(ppc405cr_cpc_t));
+    cpc =3D g_new0(ppc405cr_cpc_t, 1);
     memcpy(cpc->clk_setup, clk_setup,
            PPC405CR_CLK_NB * sizeof(clk_setup_t));
     cpc->sysclk =3D sysclk;
@@ -2138,7 +2138,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_sp=
ace_mem,
     /* OBP arbitrer */
     ppc4xx_opba_init(0xef600600);
     /* Universal interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D
@@ -2432,7 +2432,7 @@ static void ppc405ep_cpc_init (CPUPPCState *env, cl=
k_setup_t clk_setup[8],
 {
     ppc405ep_cpc_t *cpc;
=20
-    cpc =3D g_malloc0(sizeof(ppc405ep_cpc_t));
+    cpc =3D g_new0(ppc405ep_cpc_t, 1);
     memcpy(cpc->clk_setup, clk_setup,
            PPC405EP_CLK_NB * sizeof(clk_setup_t));
     cpc->jtagid =3D 0x20267049;
@@ -2495,7 +2495,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_sp=
ace_mem,
     /* Initialize timers */
     ppc_booke_timers_init(cpu, sysclk, 0);
     /* Universal interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 9d997bf743..bedf1acfcb 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -166,7 +166,7 @@ static void bamboo_init(MachineState *machine)
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *isa =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_memories
-        =3D g_malloc(PPC440EP_SDRAM_NR_BANKS * sizeof(*ram_memories));
+        =3D g_new(typeof(*ram_memories), PPC440EP_SDRAM_NR_BANKS);
     hwaddr ram_bases[PPC440EP_SDRAM_NR_BANKS];
     hwaddr ram_sizes[PPC440EP_SDRAM_NR_BANKS];
     qemu_irq *pic;
@@ -204,7 +204,7 @@ static void bamboo_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
=20
     /* interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
     pic =3D ppcuic_init(env, irqs, 0x0C0, 0, 1);
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index e7f413e49d..639053dd1f 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -305,7 +305,7 @@ qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *ir=
qs,
     ppcuic_t *uic;
     int i;
=20
-    uic =3D g_malloc0(sizeof(ppcuic_t));
+    uic =3D g_new0(ppcuic_t, 1);
     uic->dcr_base =3D dcr_base;
     uic->irqs =3D irqs;
     if (has_vr)
@@ -653,7 +653,7 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
 {
     ppc4xx_sdram_t *sdram;
=20
-    sdram =3D g_malloc0(sizeof(ppc4xx_sdram_t));
+    sdram =3D g_new0(ppc4xx_sdram_t, 1);
     sdram->irq =3D irq;
     sdram->nbanks =3D nbanks;
     sdram->ram_memories =3D ram_memories;
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 23bcf1b138..dafc6aa3fc 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -339,8 +339,8 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t =
freq, uint32_t flags)
     booke_timer_t *booke_timer;
     int ret =3D 0;
=20
-    tb_env      =3D g_malloc0(sizeof(ppc_tb_t));
-    booke_timer =3D g_malloc0(sizeof(booke_timer_t));
+    tb_env      =3D g_new0(ppc_tb_t, 1);
+    booke_timer =3D g_new0(booke_timer_t, 1);
=20
     cpu->env.tb_env =3D tb_env;
     tb_env->flags =3D flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d16646c95d..4893641e5d 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -513,7 +513,7 @@ static void ppc_prep_init(MachineState *machine)
     int ppc_boot_device;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
=20
-    sysctrl =3D g_malloc0(sizeof(sysctrl_t));
+    sysctrl =3D g_new0(sysctrl_t, 1);
=20
     linux_boot =3D (kernel_filename !=3D NULL);
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70eb60efed..72f29cbbbb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2680,7 +2680,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
         addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
     }
=20
-    ds =3D g_malloc0(sizeof(sPAPRDIMMState));
+    ds =3D g_new0(sPAPRDIMMState, 1);
     ds->nr_lmbs =3D avail_lmbs;
     ds->dimm =3D dimm;
     spapr_pending_dimm_unplugs_add(ms, ds);
@@ -2748,7 +2748,7 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
         goto out;
     }
=20
-    ds =3D g_malloc0(sizeof(sPAPRDIMMState));
+    ds =3D g_new0(sPAPRDIMMState, 1);
     ds->nr_lmbs =3D nr_lmbs;
     ds->dimm =3D dimm;
     spapr_pending_dimm_unplugs_add(spapr, ds);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 57acd85a87..1e1c6d46b2 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -494,7 +494,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_hp *hp;
=20
-    new_hp =3D g_malloc0(sizeof(struct hp_log_full));
+    new_hp =3D g_new0(struct hp_log_full, 1);
     hdr =3D &new_hp->hdr;
     v6hdr =3D &new_hp->v6hdr;
     maina =3D &new_hp->maina;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 0341bc069d..dd3e9b3a95 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -93,7 +93,7 @@ static uint64_t *spapr_tce_alloc_table(uint32_t liobn,
=20
     if (!table) {
         *fd =3D -1;
-        table =3D g_malloc0(nb_table * sizeof(uint64_t));
+        table =3D g_new0(uint64_t, nb_table);
     }
=20
     trace_spapr_iommu_new_table(liobn, table, *fd);
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e4daf8d5f1..ae2d0b7c7f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1904,7 +1904,7 @@ static void spapr_pci_pre_save(void *opaque)
     if (!sphb->msi_devs_num) {
         return;
     }
-    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_ms=
i_mig));
+    sphb->msi_devs =3D g_new(spapr_pci_msi_mig, sphb->msi_devs_num);
=20
     g_hash_table_iter_init(&iter, sphb->msi);
     for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index a0ee4fd265..a687337629 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -638,7 +638,7 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
     }
=20
     /* Copy out into an array of pointers */
-    qdevs =3D g_malloc(sizeof(qdev) * num);
+    qdevs =3D g_new(typeof(qdev), num);
     num =3D 0;
     QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
         qdevs[num++] =3D kid->child;
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index fdbcf22a0c..1efea10cbd 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -108,7 +108,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram=
_size,
     ppc_dcr_init(env, NULL, NULL);
=20
     /* interrupt controller */
-    irqs =3D g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs =3D g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_INP=
UT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =3D ((qemu_irq *)env->irq_inputs)[PPC40x_IN=
PUT_CINT];
     ppcuic_init(env, irqs, 0x0C0, 0, 1);
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1e2f26b65a..e7e095ce1d 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -147,7 +147,7 @@ int css_create_css_image(uint8_t cssid, bool default_=
image)
     if (channel_subsys.css[cssid]) {
         return -EBUSY;
     }
-    channel_subsys.css[cssid] =3D g_malloc0(sizeof(CssImage));
+    channel_subsys.css[cssid] =3D g_new0(CssImage, 1);
     if (default_image) {
         channel_subsys.default_cssid =3D cssid;
     }
@@ -1221,7 +1221,7 @@ void css_undo_stcrw(CRW *crw)
 {
     CrwContainer *crw_cont;
=20
-    crw_cont =3D g_try_malloc0(sizeof(CrwContainer));
+    crw_cont =3D g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost =3D true;
         return;
@@ -1628,7 +1628,7 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, =
uint16_t schid,
     css =3D channel_subsys.css[cssid];
=20
     if (!css->sch_set[ssid]) {
-        css->sch_set[ssid] =3D g_malloc0(sizeof(SubchSet));
+        css->sch_set[ssid] =3D g_new0(SubchSet, 1);
     }
     s_set =3D css->sch_set[ssid];
=20
@@ -1648,7 +1648,7 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int ch=
ain, uint16_t rsid)
=20
     trace_css_crw(rsc, erc, rsid, chain ? "(chained)" : "");
     /* TODO: Maybe use a static crw pool? */
-    crw_cont =3D g_try_malloc0(sizeof(CrwContainer));
+    crw_cont =3D g_try_new0(CrwContainer, 1);
     if (!crw_cont) {
         channel_subsys.crws_lost =3D true;
         return;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5651483781..339280510f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -250,7 +250,7 @@ static void s390_pci_generate_event(uint8_t cc, uint1=
6_t pec, uint32_t fh,
     SeiContainer *sei_cont;
     S390pciState *s =3D s390_get_phb();
=20
-    sei_cont =3D g_malloc0(sizeof(SeiContainer));
+    sei_cont =3D g_new0(SeiContainer, 1);
     sei_cont->fh =3D fh;
     sei_cont->fid =3D fid;
     sei_cont->cc =3D cc;
@@ -419,7 +419,7 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState =
*s, PCIBus *bus,
     S390PCIIOMMU *iommu;
=20
     if (!table) {
-        table =3D g_malloc0(sizeof(S390PCIIOMMUTable));
+        table =3D g_new0(S390PCIIOMMUTable, 1);
         table->key =3D key;
         g_hash_table_insert(s->iommu_table, &table->key, table);
     }
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e6fc74ed87..766d9d8c84 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -186,7 +186,7 @@ static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
 {
     r2d_fpga_t *s;
=20
-    s =3D g_malloc0(sizeof(r2d_fpga_t));
+    s =3D g_new0(r2d_fpga_t, 1);
=20
     s->irl =3D irl;
=20
@@ -253,7 +253,7 @@ static void r2d_init(MachineState *machine)
     }
     env =3D &cpu->env;
=20
-    reset_info =3D g_malloc0(sizeof(ResetData));
+    reset_info =3D g_new0(ResetData, 1);
     reset_info->cpu =3D cpu;
     reset_info->vector =3D env->pc;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 166e4bd947..49c49c110b 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -728,7 +728,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion=
 *sysmem)
 {
     SH7750State *s;
=20
-    s =3D g_malloc0(sizeof(SH7750State));
+    s =3D g_new0(SH7750State, 1);
     s->cpu =3D cpu;
     s->periph_freq =3D 60000000;	/* 60MHz */
     memory_region_init_io(&s->iomem, NULL, &sh7750_mem_ops, s,
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f415997649..6b16e19c18 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -136,7 +136,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
     cpu_sparc_set_id(env, 0);
=20
     /* Reset data */
-    reset_info        =3D g_malloc0(sizeof(ResetData));
+    reset_info        =3D g_new0(ResetData, 1);
     reset_info->cpu   =3D cpu;
     reset_info->sp    =3D 0x40000000 + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4e4fdab065..a16fe43262 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -160,7 +160,7 @@ static CPUTimer *cpu_timer_create(const char *name, S=
PARCCPU *cpu,
                                   QEMUBHFunc *cb, uint32_t frequency,
                                   uint64_t disabled_mask, uint64_t npt_m=
ask)
 {
-    CPUTimer *timer =3D g_malloc0(sizeof(CPUTimer));
+    CPUTimer *timer =3D g_new0(CPUTimer, 1);
=20
     timer->name =3D name;
     timer->frequency =3D frequency;
@@ -372,7 +372,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
                                     hstick_frequency, TICK_INT_DIS,
                                     TICK_NPT_MASK);
=20
-    reset_info =3D g_malloc0(sizeof(ResetData));
+    reset_info =3D g_new0(ResetData, 1);
     reset_info->cpu =3D cpu;
     reset_info->prom_addr =3D prom_addr;
     qemu_register_reset(main_cpu_reset, reset_info);
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 98fddd7ac1..75affcb8a6 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -166,7 +166,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
     arm_timer_state *s;
     QEMUBH *bh;
=20
-    s =3D (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
+    s =3D g_new0(arm_timer_state, 1);
     s->freq =3D freq;
     s->control =3D TIMER_CTRL_IE;
=20
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e970a..5f4829df94 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -355,7 +355,7 @@ static int grlib_gptimer_init(SysBusDevice *dev)
     assert(unit->nr_timers > 0);
     assert(unit->nr_timers <=3D GPTIMER_MAX_TIMERS);
=20
-    unit->timers =3D g_malloc0(sizeof unit->timers[0] * unit->nr_timers)=
;
+    unit->timers =3D g_new0(typeof(unit->timers[0]), unit->nr_timers);
=20
     for (i =3D 0; i < unit->nr_timers; i++) {
         GPTimer *timer =3D &unit->timers[i];
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 9afb2d048c..46f3eb9647 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -192,7 +192,7 @@ static void *sh_timer_init(uint32_t freq, int feat, q=
emu_irq irq)
     sh_timer_state *s;
     QEMUBH *bh;
=20
-    s =3D (sh_timer_state *)g_malloc0(sizeof(sh_timer_state));
+    s =3D g_new0(sh_timer_state, 1);
     s->freq =3D freq;
     s->feat =3D feat;
     s->tcor =3D 0xffffffff;
@@ -313,7 +313,7 @@ void tmu012_init(MemoryRegion *sysmem, hwaddr base,
     tmu012_state *s;
     int timer_feat =3D (feat & TMU012_FEAT_EXTCLK) ? TIMER_FEAT_EXTCLK :=
 0;
=20
-    s =3D (tmu012_state *)g_malloc0(sizeof(tmu012_state));
+    s =3D g_new0(tmu012_state, 1);
     s->feat =3D feat;
     s->timer[0] =3D sh_timer_init(freq, timer_feat, ch0_irq);
     s->timer[1] =3D sh_timer_init(freq, timer_feat, ch1_irq);
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index a8cc9c0148..6d0282a788 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -385,7 +385,7 @@ static void slavio_timer_init(Object *obj)
         uint64_t size;
         char timer_name[20];
=20
-        tc =3D g_malloc0(sizeof(TimerContext));
+        tc =3D g_new0(TimerContext, 1);
         tc->s =3D s;
         tc->timer_index =3D i;
=20
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 59439c05be..bae78dfc7e 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -211,7 +211,7 @@ static void xilinx_timer_realize(DeviceState *dev, Er=
ror **errp)
     unsigned int i;
=20
     /* Init all the ptimers.  */
-    t->timers =3D g_malloc0(sizeof t->timers[0] * num_timers(t));
+    t->timers =3D g_new0(typeof(t->timers[0]), num_timers(t));
     for (i =3D 0; i < num_timers(t); i++) {
         struct xlx_timer *xt =3D &t->timers[i];
=20
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b9abe77f5a..379c0b0f1c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -687,7 +687,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion =
*region,
     }
=20
     region->nr_mmaps =3D j;
-    region->mmaps =3D g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    region->mmaps =3D g_renew(VFIOMmap, region->mmaps, j);
=20
     return 0;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 32aca77701..4d9403ba3f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1434,8 +1434,8 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int=
 pos, Error **errp)
     int ret;
     Error *err =3D NULL;
=20
-    vdev->msix->pending =3D g_malloc0(BITS_TO_LONGS(vdev->msix->entries)=
 *
-                                    sizeof(unsigned long));
+    vdev->msix->pending =3D g_new0(unsigned long,
+                                 BITS_TO_LONGS(vdev->msix->entries));
     ret =3D msix_init(&vdev->pdev, vdev->msix->entries,
                     vdev->bars[vdev->msix->table_bar].region.mem,
                     vdev->msix->table_bar, vdev->msix->table_offset,
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a4663c918e..da9478c201 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -65,7 +65,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
     sysbus_init_irq(sbdev, &intp->qemuirq);
=20
     /* Get an eventfd for trigger */
-    intp->interrupt =3D g_malloc0(sizeof(EventNotifier));
+    intp->interrupt =3D g_new0(EventNotifier, 1);
     ret =3D event_notifier_init(intp->interrupt, 0);
     if (ret) {
         g_free(intp->interrupt);
@@ -76,7 +76,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
     }
     if (vfio_irq_is_automasked(intp)) {
         /* Get an eventfd for resample/unmask */
-        intp->unmask =3D g_malloc0(sizeof(EventNotifier));
+        intp->unmask =3D g_new0(EventNotifier, 1);
         ret =3D event_notifier_init(intp->unmask, 0);
         if (ret) {
             g_free(intp->interrupt);
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 0353eb6d5d..1054139f6d 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -793,7 +793,7 @@ static void virtio_crypto_device_realize(DeviceState =
*dev, Error **errp)
=20
     virtio_init(vdev, "virtio-crypto", VIRTIO_ID_CRYPTO, vcrypto->config=
_size);
     vcrypto->curr_queues =3D 1;
-    vcrypto->vqs =3D g_malloc0(sizeof(VirtIOCryptoQueue) * vcrypto->max_=
queues);
+    vcrypto->vqs =3D g_new0(VirtIOCryptoQueue, vcrypto->max_queues);
     for (i =3D 0; i < vcrypto->max_queues; i++) {
         vcrypto->vqs[i].dataq =3D
                  virtio_add_queue(vdev, 1024, virtio_crypto_handle_dataq=
_bh);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f9b7244808..ae703ac1a2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1033,8 +1033,8 @@ static int virtio_pci_set_guest_notifiers(DeviceSta=
te *d, int nvqs, bool assign)
     if ((with_irqfd || k->guest_notifier_mask) && assign) {
         if (with_irqfd) {
             proxy->vector_irqfd =3D
-                g_malloc0(sizeof(*proxy->vector_irqfd) *
-                          msix_nr_vectors_allocated(&proxy->pci_dev));
+                g_new0(typeof(*proxy->vector_irqfd),
+                       msix_nr_vectors_allocated(&proxy->pci_dev));
             r =3D kvm_virtio_pci_vector_use(proxy, nvqs);
             if (r < 0) {
                 goto assign_error;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 464947f76d..7090ff72f2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2238,7 +2238,7 @@ void virtio_init(VirtIODevice *vdev, const char *na=
me,
=20
     if (nvectors) {
         vdev->vector_queues =3D
-            g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
+            g_new0(typeof(*vdev->vector_queues), nvectors);
     }
=20
     vdev->device_id =3D device_id;
@@ -2246,7 +2246,7 @@ void virtio_init(VirtIODevice *vdev, const char *na=
me,
     atomic_set(&vdev->isr, 0);
     vdev->queue_sel =3D 0;
     vdev->config_vector =3D VIRTIO_NO_VECTOR;
-    vdev->vq =3D g_malloc0(sizeof(VirtQueue) * VIRTIO_QUEUE_MAX);
+    vdev->vq =3D g_new0(VirtQueue, VIRTIO_QUEUE_MAX);
     vdev->vm_running =3D runstate_is_running();
     vdev->broken =3D false;
     for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d5ac080d4a..300a2d9fe8 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -115,7 +115,7 @@ static const MemoryRegionOps lx60_fpga_ops =3D {
 static Lx60FpgaState *lx60_fpga_init(MemoryRegion *address_space,
         hwaddr base)
 {
-    Lx60FpgaState *s =3D g_malloc(sizeof(Lx60FpgaState));
+    Lx60FpgaState *s =3D g_new(Lx60FpgaState, 1);
=20
     memory_region_init_io(&s->iomem, NULL, &lx60_fpga_ops, s,
             "lx60.fpga", 0x10000);
diff --git a/kvm-all.c b/kvm-all.c
index 7df27c8522..c33601ad1f 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -957,7 +957,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMem=
oryListener *kml,
 {
     int i;
=20
-    kml->slots =3D g_malloc0(s->nr_slots * sizeof(KVMSlot));
+    kml->slots =3D g_new0(KVMSlot, s->nr_slots);
     kml->as_id =3D as_id;
=20
     for (i =3D 0; i < s->nr_slots; i++) {
@@ -1229,7 +1229,7 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage ms=
g)
             return virq;
         }
=20
-        route =3D g_malloc0(sizeof(KVMMSIRoute));
+        route =3D g_new0(KVMMSIRoute, 1);
         route->kroute.gsi =3D virq;
         route->kroute.type =3D KVM_IRQ_ROUTING_MSI;
         route->kroute.flags =3D 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ce77317e09..0ea3678c03 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2056,7 +2056,7 @@ static void load_elf_image(const char *image_name, =
int image_fd,
 #ifdef CONFIG_USE_FDPIC
     {
         struct elf32_fdpic_loadseg *loadsegs =3D info->loadsegs =3D
-            g_malloc(sizeof(*loadsegs) * info->nsegs);
+            g_new(typeof(*loadsegs), info->nsegs);
=20
         for (i =3D 0; i < ehdr->e_phnum; ++i) {
             switch (phdr[i].p_type) {
diff --git a/memory.c b/memory.c
index 0ddc4cc28d..843be37ebd 100644
--- a/memory.c
+++ b/memory.c
@@ -270,8 +270,8 @@ static void flatview_insert(FlatView *view, unsigned =
pos, FlatRange *range)
 {
     if (view->nr =3D=3D view->nr_allocated) {
         view->nr_allocated =3D MAX(2 * view->nr, 10);
-        view->ranges =3D g_realloc(view->ranges,
-                                    view->nr_allocated * sizeof(*view->r=
anges));
+        view->ranges =3D g_renew(typeof(*view->ranges), view->ranges,
+                               view->nr_allocated);
     }
     memmove(view->ranges + pos + 1, view->ranges + pos,
             (view->nr - pos) * sizeof(FlatRange));
@@ -792,8 +792,8 @@ static void address_space_update_ioeventfds(AddressSp=
ace *as)
                                              int128_make64(fr->offset_in=
_region)));
             if (addrrange_intersects(fr->addr, tmp)) {
                 ++ioeventfd_nb;
-                ioeventfds =3D g_realloc(ioeventfds,
-                                          ioeventfd_nb * sizeof(*ioevent=
fds));
+                ioeventfds =3D g_renew(typeof(*ioeventfds), ioeventfds,
+                                     ioeventfd_nb);
                 ioeventfds[ioeventfd_nb-1] =3D fr->mr->ioeventfds[i];
                 ioeventfds[ioeventfd_nb-1].addr =3D tmp;
             }
@@ -2028,8 +2028,8 @@ void memory_region_add_eventfd(MemoryRegion *mr,
         }
     }
     ++mr->ioeventfd_nb;
-    mr->ioeventfds =3D g_realloc(mr->ioeventfds,
-                                  sizeof(*mr->ioeventfds) * mr->ioeventf=
d_nb);
+    mr->ioeventfds =3D g_renew(typeof(*mr->ioeventfds), mr->ioeventfds,
+                             mr->ioeventfd_nb);
     memmove(&mr->ioeventfds[i+1], &mr->ioeventfds[i],
             sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb-1 - i));
     mr->ioeventfds[i] =3D mrfd;
diff --git a/memory_mapping.c b/memory_mapping.c
index a5d38552a6..9c78b41363 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -43,7 +43,7 @@ static void create_new_memory_mapping(MemoryMappingList=
 *list,
 {
     MemoryMapping *memory_mapping;
=20
-    memory_mapping =3D g_malloc(sizeof(MemoryMapping));
+    memory_mapping =3D g_new(MemoryMapping, 1);
     memory_mapping->phys_addr =3D phys_addr;
     memory_mapping->virt_addr =3D virt_addr;
     memory_mapping->length =3D length;
diff --git a/migration/block.c b/migration/block.c
index 4d8c2e94b9..0109d15060 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -406,7 +406,7 @@ static int init_blk_migration(QEMUFile *f)
     for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
         num_bs++;
     }
-    bmds_bs =3D g_malloc0(num_bs * sizeof(*bmds_bs));
+    bmds_bs =3D g_new0(typeof(*bmds_bs), num_bs);
=20
     for (i =3D 0, bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it), i++=
) {
         if (bdrv_is_read_only(bs)) {
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9c4188724e..34a10a78d1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -731,7 +731,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *m=
is)
 PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
                                                  const char *name)
 {
-    PostcopyDiscardState *res =3D g_malloc0(sizeof(PostcopyDiscardState)=
);
+    PostcopyDiscardState *res =3D g_new0(PostcopyDiscardState, 1);
=20
     if (res) {
         res->ramblock_name =3D name;
diff --git a/migration/ram.c b/migration/ram.c
index f387e9cc5b..471d0c3dfe 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1250,7 +1250,7 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
     }
=20
     struct RAMSrcPageRequest *new_entry =3D
-        g_malloc0(sizeof(struct RAMSrcPageRequest));
+        g_new0(struct RAMSrcPageRequest, 1);
     new_entry->rb =3D ramblock;
     new_entry->offset =3D start;
     new_entry->len =3D len;
diff --git a/monitor.c b/monitor.c
index 1e63ace2d4..e9fb75db73 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1929,7 +1929,7 @@ void qmp_getfd(const char *fdname, Error **errp)
         return;
     }
=20
-    monfd =3D g_malloc0(sizeof(mon_fd_t));
+    monfd =3D g_new0(mon_fd_t, 1);
     monfd->name =3D g_strdup(fdname);
     monfd->fd =3D fd;
=20
diff --git a/nbd/server.c b/nbd/server.c
index 924a1fe2db..f807551e1e 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -890,7 +890,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t=
 dev_offset, off_t size,
                           Error **errp)
 {
     BlockBackend *blk;
-    NBDExport *exp =3D g_malloc0(sizeof(NBDExport));
+    NBDExport *exp =3D g_new0(NBDExport, 1);
     uint64_t perm;
     int ret;
=20
@@ -1402,7 +1402,7 @@ void nbd_client_new(NBDExport *exp,
     NBDClient *client;
     NBDClientNewData *data =3D g_new(NBDClientNewData, 1);
=20
-    client =3D g_malloc0(sizeof(NBDClient));
+    client =3D g_new0(NBDClient, 1);
     client->refcount =3D 1;
     client->exp =3D exp;
     client->tlscreds =3D tlscreds;
diff --git a/net/slirp.c b/net/slirp.c
index 6a6d727999..f9a95710a1 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -832,7 +832,7 @@ static const char **slirp_dnssearch(const StringList =
*dnsname)
         return NULL;
     }
=20
-    ret =3D g_malloc((num_opts + 1) * sizeof(*ret));
+    ret =3D g_new(typeof(*ret), num_opts + 1);
     c =3D dnsname;
     while (c) {
         ret[i++] =3D c->value->str;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229225..f61aebe7cc 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -874,7 +874,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, E=
rror **errp)
             continue;
         }
=20
-        uc_path =3D g_malloc(sizeof(WCHAR) * char_count);
+        uc_path =3D g_new(WCHAR, char_count);
         if (!GetVolumePathNamesForVolumeNameW(guid, uc_path, char_count,
                                               &char_count) || !*uc_path)=
 {
             /* strange, but this condition could be faced even with size=
 =3D=3D 2 */
diff --git a/qga/commands.c b/qga/commands.c
index 3333ed50b2..33102a2838 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -239,7 +239,7 @@ static char **guest_exec_get_args(const strList *entr=
y, bool log)
=20
     str =3D g_malloc(str_size);
     *str =3D 0;
-    args =3D g_malloc(count * sizeof(char *));
+    args =3D g_new(char *, count);
     for (it =3D entry; it !=3D NULL; it =3D it->next) {
         args[i++] =3D it->value;
         pstrcat(str, str_size, it->value);
diff --git a/qmp.c b/qmp.c
index 7ee9bcfdcf..fb5fd32db6 100644
--- a/qmp.c
+++ b/qmp.c
@@ -242,7 +242,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path=
, Error **errp)
     while ((prop =3D object_property_iter_next(&iter))) {
         ObjectPropertyInfoList *entry =3D g_malloc0(sizeof(*entry));
=20
-        entry->value =3D g_malloc0(sizeof(ObjectPropertyInfo));
+        entry->value =3D g_new0(ObjectPropertyInfo, 1);
         entry->next =3D props;
         props =3D entry;
=20
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index c18e48ab94..19fdac5429 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -246,7 +246,7 @@ static JSONParserContext *parser_context_new(GQueue *=
tokens)
         return NULL;
     }
=20
-    ctxt =3D g_malloc0(sizeof(JSONParserContext));
+    ctxt =3D g_new0(JSONParserContext, 1);
     ctxt->buf =3D tokens;
=20
     return ctxt;
diff --git a/replay/replay-char.c b/replay/replay-char.c
index cbf7c04a9f..07a1c97cc9 100755
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -44,14 +44,14 @@ void replay_register_char_driver(Chardev *chr)
     if (replay_mode =3D=3D REPLAY_MODE_NONE) {
         return;
     }
-    char_drivers =3D g_realloc(char_drivers,
-                             sizeof(*char_drivers) * (drivers_count + 1)=
);
+    char_drivers =3D g_renew(typeof(*char_drivers), char_drivers,
+                           drivers_count + 1);
     char_drivers[drivers_count++] =3D chr;
 }
=20
 void replay_chr_be_write(Chardev *s, uint8_t *buf, int len)
 {
-    CharEvent *event =3D g_malloc0(sizeof(CharEvent));
+    CharEvent *event =3D g_new0(CharEvent, 1);
=20
     event->id =3D find_char_driver(s);
     if (event->id < 0) {
@@ -86,7 +86,7 @@ void replay_event_char_read_save(void *opaque)
=20
 void *replay_event_char_read_load(void)
 {
-    CharEvent *event =3D g_malloc0(sizeof(CharEvent));
+    CharEvent *event =3D g_new0(CharEvent, 1);
=20
     event->id =3D replay_get_byte();
     replay_get_array_alloc(&event->buf, &event->len);
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 94a6dcccfc..c72dcaa708 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -128,7 +128,7 @@ void replay_add_event(ReplayAsyncEventKind event_kind=
,
         return;
     }
=20
-    Event *event =3D g_malloc0(sizeof(Event));
+    Event *event =3D g_new0(Event, 1);
     event->event_kind =3D event_kind;
     event->opaque =3D opaque;
     event->opaque2 =3D opaque2;
@@ -239,17 +239,17 @@ static Event *replay_read_event(int checkpoint)
         }
         break;
     case REPLAY_ASYNC_EVENT_INPUT:
-        event =3D g_malloc0(sizeof(Event));
+        event =3D g_new0(Event, 1);
         event->event_kind =3D read_event_kind;
         event->opaque =3D replay_read_input_event();
         return event;
     case REPLAY_ASYNC_EVENT_INPUT_SYNC:
-        event =3D g_malloc0(sizeof(Event));
+        event =3D g_new0(Event, 1);
         event->event_kind =3D read_event_kind;
         event->opaque =3D 0;
         return event;
     case REPLAY_ASYNC_EVENT_CHAR_READ:
-        event =3D g_malloc0(sizeof(Event));
+        event =3D g_new0(Event, 1);
         event->event_kind =3D read_event_kind;
         event->opaque =3D replay_event_char_read_load();
         return event;
@@ -259,7 +259,7 @@ static Event *replay_read_event(int checkpoint)
         }
         break;
     case REPLAY_ASYNC_EVENT_NET:
-        event =3D g_malloc0(sizeof(Event));
+        event =3D g_new0(Event, 1);
         event->event_kind =3D read_event_kind;
         event->opaque =3D replay_event_net_load();
         return event;
diff --git a/replay/replay-net.c b/replay/replay-net.c
index 80b7054156..676a2365b4 100644
--- a/replay/replay-net.c
+++ b/replay/replay-net.c
@@ -38,9 +38,8 @@ ReplayNetState *replay_register_net(NetFilterState *nfs=
)
     ReplayNetState *rns =3D g_new0(ReplayNetState, 1);
     rns->nfs =3D nfs;
     rns->id =3D network_filters_count++;
-    network_filters =3D g_realloc(network_filters,
-                                network_filters_count
-                                    * sizeof(*network_filters));
+    network_filters =3D g_renew(typeof(*network_filters), network_filter=
s,
+                              network_filters_count);
     network_filters[network_filters_count - 1] =3D nfs;
     return rns;
 }
diff --git a/slirp/dnssearch.c b/slirp/dnssearch.c
index 8fb563321b..557c6944c0 100644
--- a/slirp/dnssearch.c
+++ b/slirp/dnssearch.c
@@ -249,7 +249,7 @@ int translate_dnssearch(Slirp *s, const char **names)
         return -2;
     }
=20
-    domains =3D g_malloc(num_domains * sizeof(*domains));
+    domains =3D g_new(typeof(*domains), num_domains);
=20
     for (i =3D 0; i < num_domains; i++) {
         size_t nlen =3D strlen(names[i]);
@@ -262,7 +262,7 @@ int translate_dnssearch(Slirp *s, const char **names)
=20
     /* reserve extra 2 header bytes for each 255 bytes of output */
     memreq +=3D DIV_ROUND_UP(memreq, MAX_OPT_LEN) * OPT_HEADER_LEN;
-    result =3D g_malloc(memreq * sizeof(*result));
+    result =3D g_new(typeof(*result), memreq);
=20
     outptr =3D result;
     for (i =3D 0; i < num_domains; i++) {
diff --git a/slirp/slirp.c b/slirp/slirp.c
index e79345bdfc..3e8db3b46c 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -282,7 +282,7 @@ Slirp *slirp_init(int restricted, bool in_enabled, st=
ruct in_addr vnetwork,
                   struct in6_addr vnameserver6, const char **vdnssearch,
                   void *opaque)
 {
-    Slirp *slirp =3D g_malloc0(sizeof(Slirp));
+    Slirp *slirp =3D g_new0(Slirp, 1);
=20
     slirp_init_once();
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ffb5267162..710a3290bd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3809,7 +3809,7 @@ static GuestPanicInformation *x86_cpu_get_crash_inf=
o(CPUState *cs)
     GuestPanicInformation *panic_info =3D NULL;
=20
     if (env->features[FEAT_HYPERV_EDX] & HV_X64_GUEST_CRASH_MSR_AVAILABL=
E) {
-        panic_info =3D g_malloc0(sizeof(GuestPanicInformation));
+        panic_info =3D g_new0(GuestPanicInformation, 1);
=20
         panic_info->type =3D GUEST_PANIC_INFORMATION_TYPE_HYPER_V;
=20
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 6ae23e476f..91791ef9ec 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -855,7 +855,7 @@ static void mmu_init (CPUMIPSState *env, const mips_d=
ef_t *def)
 {
     MIPSCPU *cpu =3D mips_env_get_cpu(env);
=20
-    env->tlb =3D g_malloc0(sizeof(CPUMIPSTLBContext));
+    env->tlb =3D g_new0(CPUMIPSTLBContext, 1);
=20
     switch (def->mmu_type) {
         case MMU_TYPE_NONE:
@@ -888,7 +888,7 @@ static void fpu_init (CPUMIPSState *env, const mips_d=
ef_t *def)
=20
 static void mvp_init (CPUMIPSState *env, const mips_def_t *def)
 {
-    env->mvp =3D g_malloc0(sizeof(CPUMIPSMVPContext));
+    env->mvp =3D g_new0(CPUMIPSMVPContext, 1);
=20
     /* MVPConf1 implemented, TLB sharable, no gating storage support,
        programmable cache partitioning implemented, number of allocatabl=
e
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index ce2a29dd1a..4789a35b67 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -247,7 +247,7 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs,=
 vaddr addr)
=20
 void cpu_openrisc_mmu_init(OpenRISCCPU *cpu)
 {
-    cpu->env.tlb =3D g_malloc0(sizeof(CPUOpenRISCTLBContext));
+    cpu->env.tlb =3D g_new0(CPUOpenRISCTLBContext, 1);
=20
     cpu->env.tlb->cpu_openrisc_map_address_code =3D &cpu_openrisc_get_ph=
ys_nommu;
     cpu->env.tlb->cpu_openrisc_map_address_data =3D &cpu_openrisc_get_ph=
ys_nommu;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab22cf..150d0b00e2 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9225,13 +9225,13 @@ static void init_ppc_proc(PowerPCCPU *cpu)
             nb_tlb *=3D 2;
         switch (env->tlb_type) {
         case TLB_6XX:
-            env->tlb.tlb6 =3D g_malloc0(nb_tlb * sizeof(ppc6xx_tlb_t));
+            env->tlb.tlb6 =3D g_new0(ppc6xx_tlb_t, nb_tlb);
             break;
         case TLB_EMB:
-            env->tlb.tlbe =3D g_malloc0(nb_tlb * sizeof(ppcemb_tlb_t));
+            env->tlb.tlbe =3D g_new0(ppcemb_tlb_t, nb_tlb);
             break;
         case TLB_MAS:
-            env->tlb.tlbm =3D g_malloc0(nb_tlb * sizeof(ppcmas_tlb_t));
+            env->tlb.tlbm =3D g_new0(ppcmas_tlb_t, nb_tlb);
             break;
         }
         /* Pre-compute some useful values */
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 1b9f448875..96e8612003 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -237,7 +237,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
             program_interrupt(env, PGM_ADDRESSING, ILEN_LATER_INC);
             return;
         }
-        iplb =3D g_malloc0(sizeof(IplParameterBlock));
+        iplb =3D g_new0(IplParameterBlock, 1);
         cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b11a02706c..c91f63e397 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -479,7 +479,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, u=
int8_t ar, void *hostbuf,
=20
     nr_pages =3D (((laddr & ~TARGET_PAGE_MASK) + len - 1) >> TARGET_PAGE=
_BITS)
                + 1;
-    pages =3D g_malloc(nr_pages * sizeof(*pages));
+    pages =3D g_new(typeof(*pages), nr_pages);
=20
     ret =3D translate_pages(cpu, laddr, nr_pages, pages, is_write);
     if (ret =3D=3D 0 && hostbuf !=3D NULL) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 564292f54d..661ddce55b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -343,8 +343,8 @@ void tcg_context_init(TCGContext *s)
         total_args +=3D n;
     }
=20
-    args_ct =3D g_malloc(sizeof(TCGArgConstraint) * total_args);
-    sorted_args =3D g_malloc(sizeof(int) * total_args);
+    args_ct =3D g_new(TCGArgConstraint, total_args);
+    sorted_args =3D g_new(int, total_args);
=20
     for(op =3D 0; op < NB_OPS; op++) {
         def =3D &tcg_op_defs[op];
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index ef17629345..964e5155c5 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -155,7 +155,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_lis=
t ap)
 {
     AHCIQState *s;
=20
-    s =3D g_malloc0(sizeof(AHCIQState));
+    s =3D g_new0(AHCIQState, 1);
     s->parent =3D qtest_pc_vboot(cli, ap);
     alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);
=20
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 688342bed5..81f45bdfc8 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -79,8 +79,8 @@ static void test_fw_cfg_numa(void)
=20
     g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_nod=
es);
=20
-    cpu_mask =3D g_malloc0(sizeof(uint64_t) * max_cpus);
-    node_mask =3D g_malloc0(sizeof(uint64_t) * nb_nodes);
+    cpu_mask =3D g_new0(uint64_t, max_cpus);
+    node_mask =3D g_new0(uint64_t, nb_nodes);
=20
     qfw_cfg_read_data(fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
     qfw_cfg_read_data(fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes);
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 1ca7f456b5..13c0749582 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -843,7 +843,7 @@ AHCICommand *ahci_command_create(uint8_t command_name=
)
     AHCICommand *cmd;
=20
     g_assert(props);
-    cmd =3D g_malloc0(sizeof(AHCICommand));
+    cmd =3D g_new0(AHCICommand, 1);
     g_assert(!(props->dma && props->pio));
     g_assert(!(props->lba28 && props->lba48));
     g_assert(!(props->read && props->write));
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 6226546c28..991bc1aec2 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -17,7 +17,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_=
fmt, va_list ap)
 {
     char *cmdline;
=20
-    struct QOSState *qs =3D g_malloc(sizeof(QOSState));
+    struct QOSState *qs =3D g_new(QOSState, 1);
=20
     cmdline =3D g_strdup_vprintf(cmdline_fmt, ap);
     qs->qts =3D qtest_start(cmdline);
diff --git a/tests/libqos/malloc.c b/tests/libqos/malloc.c
index b8eff5f495..ac05874b0a 100644
--- a/tests/libqos/malloc.c
+++ b/tests/libqos/malloc.c
@@ -129,7 +129,7 @@ static MemBlock *mlist_new(uint64_t addr, uint64_t si=
ze)
     if (!size) {
         return NULL;
     }
-    block =3D g_malloc0(sizeof(MemBlock));
+    block =3D g_new0(MemBlock, 1);
=20
     block->addr =3D addr;
     block->size =3D size;
@@ -305,8 +305,8 @@ QGuestAllocator *alloc_init(uint64_t start, uint64_t =
end)
     s->start =3D start;
     s->end =3D end;
=20
-    s->used =3D g_malloc(sizeof(MemList));
-    s->free =3D g_malloc(sizeof(MemList));
+    s->used =3D g_new(MemList, 1);
+    s->free =3D g_new(MemList, 1);
     QTAILQ_INIT(s->used);
     QTAILQ_INIT(s->free);
=20
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index c4211a4e85..11d3e810ef 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -87,7 +87,7 @@ static void add_pc_test_case(const char *mname)
     if (!g_str_has_prefix(mname, "pc-")) {
         return;
     }
-    data =3D g_malloc(sizeof(PCTestData));
+    data =3D g_new(PCTestData, 1);
     data->machine =3D g_strdup(mname);
     data->cpu_model =3D "Haswell"; /* 1.3+ theoretically */
     data->sockets =3D 1;
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2afa09d859..4e635ae0df 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -229,7 +229,7 @@ th_create_n(QemuThread **threads, struct thread_info =
**infos, const char *name,
     QemuThread *th;
     int i;
=20
-    th =3D g_malloc(sizeof(*th) * n);
+    th =3D g_new(typeof(*th), n);
     *threads =3D th;
=20
     info =3D qemu_memalign(64, sizeof(*info) * n);
@@ -287,7 +287,7 @@ static void htable_init(void)
     size_t i;
=20
     /* avoid allocating memory later by allocating all the keys now */
-    keys =3D g_malloc(sizeof(*keys) * n);
+    keys =3D g_new(typeof(*keys), n);
     for (i =3D 0; i < n; i++) {
         keys[i] =3D populate_offset + i;
     }
diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 23773d2051..2a8add5a56 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -122,7 +122,7 @@ static void hbitmap_test_truncate_impl(TestHBitmapDat=
a *data,
=20
     n =3D hbitmap_test_array_size(size);
     m =3D hbitmap_test_array_size(data->old_size);
-    data->bits =3D g_realloc(data->bits, sizeof(unsigned long) * n);
+    data->bits =3D g_renew(unsigned long, data->bits, n);
     if (n > m) {
         memset(&data->bits[m], 0x00, sizeof(unsigned long) * (n - m));
     }
diff --git a/tests/test-iov.c b/tests/test-iov.c
index fa3d75aee1..e1d39f4d47 100644
--- a/tests/test-iov.c
+++ b/tests/test-iov.c
@@ -7,7 +7,7 @@
 static void iov_random(struct iovec **iovp, unsigned *iov_cntp)
 {
      unsigned niov =3D g_test_rand_int_range(3,8);
-     struct iovec *iov =3D g_malloc(niov * sizeof(*iov));
+     struct iovec *iov =3D g_new(typeof(*iov), niov);
      unsigned i;
      for (i =3D 0; i < niov; ++i) {
          iov[i].iov_len =3D g_test_rand_int_range(5,20);
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index acdded4d67..6d739ad339 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -28,8 +28,8 @@ UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
                               Error **errp)
 {
     UserDefTwo *ret;
-    UserDefOne *ud1c =3D g_malloc0(sizeof(UserDefOne));
-    UserDefOne *ud1d =3D g_malloc0(sizeof(UserDefOne));
+    UserDefOne *ud1c =3D g_new0(UserDefOne, 1);
+    UserDefOne *ud1d =3D g_new0(UserDefOne, 1);
=20
     ud1c->string =3D strdup(ud1a->string);
     ud1c->integer =3D ud1a->integer;
@@ -207,23 +207,23 @@ static void test_dealloc_types(void)
     UserDefOne *ud1test, *ud1a, *ud1b;
     UserDefOneList *ud1list;
=20
-    ud1test =3D g_malloc0(sizeof(UserDefOne));
+    ud1test =3D g_new0(UserDefOne, 1);
     ud1test->integer =3D 42;
     ud1test->string =3D g_strdup("hi there 42");
=20
     qapi_free_UserDefOne(ud1test);
=20
-    ud1a =3D g_malloc0(sizeof(UserDefOne));
+    ud1a =3D g_new0(UserDefOne, 1);
     ud1a->integer =3D 43;
     ud1a->string =3D g_strdup("hi there 43");
=20
-    ud1b =3D g_malloc0(sizeof(UserDefOne));
+    ud1b =3D g_new0(UserDefOne, 1);
     ud1b->integer =3D 44;
     ud1b->string =3D g_strdup("hi there 44");
=20
-    ud1list =3D g_malloc0(sizeof(UserDefOneList));
+    ud1list =3D g_new0(UserDefOneList, 1);
     ud1list->value =3D ud1a;
-    ud1list->next =3D g_malloc0(sizeof(UserDefOneList));
+    ud1list->next =3D g_new0(UserDefOneList, 1);
     ud1list->next->value =3D ud1b;
=20
     qapi_free_UserDefOneList(ud1list);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index 4e8fdf1397..7aed8b2f30 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -367,7 +367,7 @@ static void test_visitor_out_union_flat(TestOutputVis=
itorData *data,
 {
     QDict *qdict;
=20
-    UserDefFlatUnion *tmp =3D g_malloc0(sizeof(UserDefFlatUnion));
+    UserDefFlatUnion *tmp =3D g_new0(UserDefFlatUnion, 1);
     tmp->enum1 =3D ENUM_ONE_VALUE1;
     tmp->string =3D g_strdup("str");
     tmp->integer =3D 41;
diff --git a/ui/console.c b/ui/console.c
index d914cced53..8d3039aa64 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1262,7 +1262,7 @@ static QemuConsole *new_console(DisplayState *ds, c=
onsole_type_t console_type,
     s->ds =3D ds;
     s->console_type =3D console_type;
=20
-    consoles =3D g_realloc(consoles, sizeof(*consoles) * (nb_consoles+1)=
);
+    consoles =3D g_renew(typeof(*consoles), consoles, nb_consoles + 1);
     if (console_type !=3D GRAPHIC_CONSOLE) {
         s->index =3D nb_consoles;
         consoles[nb_consoles++] =3D s;
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 7159747404..581a41329a 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -93,7 +93,7 @@ void qmp_send_key(KeyValueList *keys, bool has_hold_tim=
e, int64_t hold_time,
     for (p =3D keys; p !=3D NULL; p =3D p->next) {
         qemu_input_event_send_key(NULL, copy_key_value(p->value), true);
         qemu_input_event_send_key_delay(hold_time);
-        up =3D g_realloc(up, sizeof(*up) * (count+1));
+        up =3D g_renew(typeof(*up), up, count + 1);
         up[count] =3D copy_key_value(p->value);
         count++;
     }
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 15a49ee53d..bf9b64f672 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -1476,7 +1476,7 @@ static int send_sub_rect(VncState *vs, int x, int y=
, int w, int h)
 #endif
=20
     if (!color_count_palette) {
-        color_count_palette =3D g_malloc(sizeof(VncPalette));
+        color_count_palette =3D g_new(VncPalette, 1);
         vnc_tight_cleanup_notifier.notify =3D vnc_tight_cleanup;
         qemu_thread_atexit_add(&vnc_tight_cleanup_notifier);
     }
diff --git a/ui/vnc.c b/ui/vnc.c
index e0952441fc..f8ca4c6d7a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2925,7 +2925,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelS=
ocket *sioc,
     VNC_DEBUG("Client sioc=3D%p ws=3D%d auth=3D%d subauth=3D%d\n",
               sioc, websocket, vs->auth, vs->subauth);
=20
-    vs->lossy_rect =3D g_malloc0(VNC_STAT_ROWS * sizeof (*vs->lossy_rect=
));
+    vs->lossy_rect =3D g_new0(typeof(*vs->lossy_rect), VNC_STAT_ROWS);
     for (i =3D 0; i < VNC_STAT_ROWS; ++i) {
         vs->lossy_rect[i] =3D g_new0(uint8_t, VNC_STAT_COLS);
     }
diff --git a/util/acl.c b/util/acl.c
index c105addadc..bd80c05bb7 100644
--- a/util/acl.c
+++ b/util/acl.c
@@ -66,7 +66,7 @@ qemu_acl *qemu_acl_init(const char *aclname)
     acl->nentries =3D 0;
     QTAILQ_INIT(&acl->entries);
=20
-    acls =3D g_realloc(acls, sizeof(*acls) * (nacls +1));
+    acls =3D g_renew(typeof(*acls), acls, nacls + 1);
     acls[nacls] =3D acl;
     nacls++;
=20
diff --git a/util/envlist.c b/util/envlist.c
index 1eeb7fca87..0079effd9a 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -218,7 +218,7 @@ envlist_to_environ(const envlist_t *envlist, size_t *=
count)
 	struct envlist_entry *entry;
 	char **env, **penv;
=20
-	penv =3D env =3D g_malloc((envlist->el_count + 1) * sizeof(char *));
+	penv =3D env =3D g_new(char *, envlist->el_count + 1);
=20
 	for (entry =3D envlist->el_entries.lh_first; entry !=3D NULL;
 	    entry =3D entry->ev_link.le_next) {
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 35088e19c4..277db3ee8d 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -629,7 +629,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
         }
         old =3D hb->sizes[i];
         hb->sizes[i] =3D size;
-        hb->levels[i] =3D g_realloc(hb->levels[i], size * sizeof(unsigne=
d long));
+        hb->levels[i] =3D g_renew(unsigned long, hb->levels[i], size);
         if (!shrink) {
             memset(&hb->levels[i][old], 0x00,
                    (size - old) * sizeof(*hb->levels[i]));
diff --git a/util/iohandler.c b/util/iohandler.c
index 623b55b9ec..518922dcea 100644
--- a/util/iohandler.c
+++ b/util/iohandler.c
@@ -128,7 +128,7 @@ int qemu_add_child_watch(pid_t pid)
             return 1;
         }
     }
-    rec =3D g_malloc0(sizeof(ChildProcessRecord));
+    rec =3D g_new0(ChildProcessRecord, 1);
     rec->pid =3D pid;
     QLIST_INSERT_HEAD(&child_watches, rec, next);
     return 0;
diff --git a/util/main-loop.c b/util/main-loop.c
index 19cad6b8b6..b82f1b24d0 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -279,7 +279,7 @@ static PollingEntry *first_polling_entry;
 int qemu_add_polling_cb(PollingFunc *func, void *opaque)
 {
     PollingEntry **ppe, *pe;
-    pe =3D g_malloc0(sizeof(PollingEntry));
+    pe =3D g_new0(PollingEntry, 1);
     pe->func =3D func;
     pe->opaque =3D opaque;
     for(ppe =3D &first_polling_entry; *ppe !=3D NULL; ppe =3D &(*ppe)->n=
ext);
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 82d56507a2..2f4e21c482 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -102,7 +102,7 @@ QEMUTimerList *timerlist_new(QEMUClockType type,
     QEMUTimerList *timer_list;
     QEMUClock *clock =3D qemu_clock_ptr(type);
=20
-    timer_list =3D g_malloc0(sizeof(QEMUTimerList));
+    timer_list =3D g_new0(QEMUTimerList, 1);
     qemu_event_init(&timer_list->timers_done_ev, true);
     timer_list->clock =3D clock;
     timer_list->notify_cb =3D cb;
diff --git a/vl.c b/vl.c
index be4dcf25ba..ee384bc809 100644
--- a/vl.c
+++ b/vl.c
@@ -1339,7 +1339,7 @@ static int add_semihosting_arg(void *opaque,
     if (strcmp(name, "arg") =3D=3D 0) {
         s->argc++;
         /* one extra element as g_strjoinv() expects NULL-terminated arr=
ay */
-        s->argv =3D g_realloc(s->argv, (s->argc + 1) * sizeof(void *));
+        s->argv =3D g_renew(const char *, s->argv, s->argc + 1);
         s->argv[s->argc - 1] =3D val;
         s->argv[s->argc] =3D NULL;
     }
--=20
2.13.0.91.g00982b8dd
