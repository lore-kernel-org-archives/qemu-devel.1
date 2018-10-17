Received: from eggs.gnu.org ([2001:4830:134:3::10]:51479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB5-0000L6-2K
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChB3-000218-64
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChB2-0001hi-Ll
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:36 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:28 +0200
Message-Id: <20181017082702.5581-5-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 04/38] cpus hw target: Use warn_report() &
 friends to report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alex Williamson <alex.williamson@redhat.com>, Fam Zheng <famz@redhat.com>, Wei Huang <wei@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  Convert a few that are actually warnings to
warn_report().

While there, split a warning consisting of multiple sentences to
conform to conventions spelled out in warn_report()'s contract.

Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Fam Zheng <famz@redhat.com>
Cc: Wei Huang <wei@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 cpus.c                          |  8 ++++----
 hw/display/cg3.c                |  2 +-
 hw/display/tcx.c                |  2 +-
 hw/misc/ivshmem.c               |  4 ++--
 hw/net/virtio-net.c             |  8 ++++----
 hw/virtio/virtio-pci.c          |  4 ++--
 target/i386/cpu.c               | 17 +++++++++--------
 target/ppc/translate_init.inc.c |  4 ++--
 8 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/cpus.c b/cpus.c
index 361678e459..7804071872 100644
--- a/cpus.c
+++ b/cpus.c
@@ -211,12 +211,12 @@ void qemu_tcg_configure(QemuOpts *opts, Error **err=
p)
                 error_setg(errp, "No MTTCG when icount is enabled");
             } else {
 #ifndef TARGET_SUPPORTS_MTTCG
-                error_report("Guest not yet converted to MTTCG - "
-                             "you may get unexpected results");
+                warn_report("Guest not yet converted to MTTCG - "
+                            "you may get unexpected results");
 #endif
                 if (!check_tcg_memory_orders_compatible()) {
-                    error_report("Guest expects a stronger memory orderi=
ng "
-                                 "than the host provides");
+                    warn_report("Guest expects a stronger memory orderin=
g "
+                                "than the host provides");
                     error_printf("This may cause strange/hard to debug e=
rrors\n");
                 }
                 mttcg_enabled =3D true;
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 1c199ab369..e50d97e48c 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -307,7 +307,7 @@ static void cg3_realizefn(DeviceState *dev, Error **e=
rrp)
         ret =3D load_image_mr(fcode_filename, &s->rom);
         g_free(fcode_filename);
         if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
-            error_report("cg3: could not load prom '%s'", CG3_ROM_FILE);
+            warn_report("cg3: could not load prom '%s'", CG3_ROM_FILE);
         }
     }
=20
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index b2786ee8d0..66f2459226 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -823,7 +823,7 @@ static void tcx_realizefn(DeviceState *dev, Error **e=
rrp)
         ret =3D load_image_mr(fcode_filename, &s->rom);
         g_free(fcode_filename);
         if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
-            error_report("tcx: could not load prom '%s'", TCX_ROM_FILE);
+            warn_report("tcx: could not load prom '%s'", TCX_ROM_FILE);
         }
     }
=20
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 8cb17b9dd4..f88910e55c 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1288,8 +1288,8 @@ static void ivshmem_realize(PCIDevice *dev, Error *=
*errp)
     IVShmemState *s =3D IVSHMEM_COMMON(dev);
=20
     if (!qtest_enabled()) {
-        error_report("ivshmem is deprecated, please use ivshmem-plain"
-                     " or ivshmem-doorbell instead");
+        warn_report("ivshmem is deprecated, please use ivshmem-plain"
+                    " or ivshmem-doorbell instead");
     }
=20
     if (qemu_chr_fe_backend_connected(&s->server_chr) + !!s->shmobj !=3D=
 1) {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4bdd5b8532..385b1a03e9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2020,10 +2020,10 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
=20
     if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")
                        && strcmp(n->net_conf.tx, "bh")) {
-        error_report("virtio-net: "
-                     "Unknown option tx=3D%s, valid options: \"timer\" \=
"bh\"",
-                     n->net_conf.tx);
-        error_report("Defaulting to \"bh\"");
+        warn_report("virtio-net: "
+                    "Unknown option tx=3D%s, valid options: \"timer\" \"=
bh\"",
+                    n->net_conf.tx);
+        error_printf("Defaulting to \"bh\"");
     }
=20
     n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..a954799267 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1683,8 +1683,8 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
         if (err) {
             /* Notice when a system that supports MSIx can't initialize =
it */
             if (err !=3D -ENOTSUP) {
-                error_report("unable to init msix vectors to %" PRIu32,
-                             proxy->nvectors);
+                warn_report("unable to init msix vectors to %" PRIu32,
+                            proxy->nvectors);
             }
             proxy->nvectors =3D 0;
         }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c88876dfe3..9d4217afba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5123,14 +5123,15 @@ static void x86_cpu_realizefn(DeviceState *dev, E=
rror **errp)
      * NOTE: the following code has to follow qemu_init_vcpu(). Otherwis=
e
      * cs->nr_threads hasn't be populated yet and the checking is incorr=
ect.
      */
-     if (IS_AMD_CPU(env) &&
-         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-         cs->nr_threads > 1 && !ht_warned) {
-            error_report("This family of AMD CPU doesn't support "
-                         "hyperthreading(%d). Please configure -smp "
-                         "options properly or try enabling topoext featu=
re.",
-                         cs->nr_threads);
-        ht_warned =3D true;
+    if (IS_AMD_CPU(env) &&
+        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+        cs->nr_threads > 1 && !ht_warned) {
+            warn_report("This family of AMD CPU doesn't support "
+                        "hyperthreading(%d)",
+                        cs->nr_threads);
+            error_printf("Please configure -smp options properly"
+                         " or try enabling topoext feature.\n");
+            ht_warned =3D true;
     }
=20
     x86_cpu_apic_realize(cpu, &local_err);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 263e63cb03..ee9432eb15 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8381,8 +8381,8 @@ static void getset_compat_deprecated(Object *obj, V=
isitor *v, const char *name,
     QNull *null =3D NULL;
=20
     if (!qtest_enabled()) {
-        error_report("CPU 'compat' property is deprecated and has no eff=
ect; "
-                     "use max-cpu-compat machine property instead");
+        warn_report("CPU 'compat' property is deprecated and has no effe=
ct; "
+                    "use max-cpu-compat machine property instead");
     }
     visit_type_null(v, name, &null, NULL);
     qobject_unref(null);
--=20
2.17.1
