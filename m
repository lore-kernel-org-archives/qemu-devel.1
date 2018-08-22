Received: from eggs.gnu.org ([2001:4830:134:3::10]:58520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsXTP-0007yu-21
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsXTJ-00081Q-Ts
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:03:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsXTJ-00080l-LV
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 14:03:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Aug 2018 20:02:59 +0200
Message-Id: <20180822180259.26365-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] RFC: chardev: mark the calls that allow an
 implicit mux monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

This is mostly for readability of the code. Let's make it clear which
callers can create an implicit monitor when the chardev is muxed.

This will also enforce a safer behaviour, as we don't really support
creating monitor anywhere/anytime at the moment.

There are documented cases, such as: -serial/-parallel/-virtioconsole
and to less extent -debugcon.

Less obvious and questionnable ones are -gdb and Xen console. Add a
FIXME note for those, but keep the support for now.

Other qemu_chr_new() callers either have a fixed parameter/filename
string, or do preliminary checks on the string (such as slirp), or do
not need it, such as -qtest.

On a related note, the list of monitor creation places:

- the chardev creators listed above: all from command line (except
  perhaps Xen console?)

- -gdb & hmp gdbserver will create a "GDB monitor command" chardev
  that is wired to an HMP monitor.

- -mon command line option

>From this short study, I would like to think that a monitor may only
be created in the main thread today, though I remain skeptical :)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char.h | 18 +++++++++++++++++-
 chardev/char.c         | 21 +++++++++++++++++----
 gdbstub.c              |  6 +++++-
 hw/char/xen_console.c  |  5 ++++-
 vl.c                   |  8 ++++----
 5 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 6f0576e214..be2b9b817e 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -105,6 +105,7 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
  * @qemu_chr_new:
  *
  * Create a new character backend from a URI.
+ * Do not implicitely initialize a monitor if the chardev is muxed.
  *
  * @label the name of the backend
  * @filename the URI
@@ -113,6 +114,19 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
  */
 Chardev *qemu_chr_new(const char *label, const char *filename);
=20
+/**
+ * @qemu_chr_new_mux_mon:
+ *
+ * Create a new character backend from a URI.
+ * Implicitely initialize a monitor if the chardev is muxed.
+ *
+ * @label the name of the backend
+ * @filename the URI
+ *
+ * Returns: a new character backend
+ */
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename);
+
 /**
  * @qemu_chr_change:
  *
@@ -138,10 +152,12 @@ void qemu_chr_cleanup(void);
  *
  * @label the name of the backend
  * @filename the URI
+ * @with_mux_mon if chardev is muxed, initialize a monitor
  *
  * Returns: a new character backend
  */
-Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
+                               bool with_mux_mon);
=20
 /**
  * @qemu_chr_be_can_write:
diff --git a/chardev/char.c b/chardev/char.c
index 76d866e6fe..2c295ad676 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -683,7 +683,8 @@ out:
     return chr;
 }
=20
-Chardev *qemu_chr_new_noreplay(const char *label, const char *filename)
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
+                               bool with_mux_mon)
 {
     const char *p;
     Chardev *chr;
@@ -702,17 +703,19 @@ Chardev *qemu_chr_new_noreplay(const char *label, c=
onst char *filename)
     if (err) {
         error_report_err(err);
     }
-    if (chr && qemu_opt_get_bool(opts, "mux", 0)) {
+    if (with_mux_mon && chr && qemu_opt_get_bool(opts, "mux", 0)) {
         monitor_init(chr, MONITOR_USE_READLINE);
     }
     qemu_opts_del(opts);
     return chr;
 }
=20
-Chardev *qemu_chr_new(const char *label, const char *filename)
+static Chardev *qemu_chr_new_with_mux_mon(const char *label,
+                                          const char *filename,
+                                          bool with_mux_mon)
 {
     Chardev *chr;
-    chr =3D qemu_chr_new_noreplay(label, filename);
+    chr =3D qemu_chr_new_noreplay(label, filename, with_mux_mon);
     if (chr) {
         if (replay_mode !=3D REPLAY_MODE_NONE) {
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
@@ -726,6 +729,16 @@ Chardev *qemu_chr_new(const char *label, const char =
*filename)
     return chr;
 }
=20
+Chardev *qemu_chr_new(const char *label, const char *filename)
+{
+    return qemu_chr_new_with_mux_mon(label, filename, false);
+}
+
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename)
+{
+    return qemu_chr_new_with_mux_mon(label, filename, true);
+}
+
 static int qmp_query_chardev_foreach(Object *obj, void *data)
 {
     Chardev *chr =3D CHARDEV(obj);
diff --git a/gdbstub.c b/gdbstub.c
index d6ab95006c..963531ea90 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2038,7 +2038,11 @@ int gdbserver_start(const char *device)
             sigaction(SIGINT, &act, NULL);
         }
 #endif
-        chr =3D qemu_chr_new_noreplay("gdb", device);
+        /*
+         * FIXME: it's a bit weird to allow using a mux chardev here
+         * and setup implicitely a monitor. We may want to break this.
+         */
+        chr =3D qemu_chr_new_noreplay("gdb", device, true);
         if (!chr)
             return -1;
     }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 8b4b4bf523..6a231d487b 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -207,7 +207,10 @@ static int con_init(struct XenDevice *xendev)
     } else {
         snprintf(label, sizeof(label), "xencons%d", con->xendev.dev);
         qemu_chr_fe_init(&con->chr,
-                         qemu_chr_new(label, output), &error_abort);
+                         /*
+                          * FIXME: should it support implicit muxed moni=
tors?
+                          */
+                         qemu_chr_new_mux_mon(label, output), &error_abo=
rt);
     }
=20
     xenstore_store_pv_console_info(con->xendev.dev,
diff --git a/vl.c b/vl.c
index 16b913f9d5..20b5f321ec 100644
--- a/vl.c
+++ b/vl.c
@@ -2425,7 +2425,7 @@ static int serial_parse(const char *devname)
     snprintf(label, sizeof(label), "serial%d", index);
     serial_hds =3D g_renew(Chardev *, serial_hds, index + 1);
=20
-    serial_hds[index] =3D qemu_chr_new(label, devname);
+    serial_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
     if (!serial_hds[index]) {
         error_report("could not connect serial device"
                      " to character backend '%s'", devname);
@@ -2461,7 +2461,7 @@ static int parallel_parse(const char *devname)
         exit(1);
     }
     snprintf(label, sizeof(label), "parallel%d", index);
-    parallel_hds[index] =3D qemu_chr_new(label, devname);
+    parallel_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
     if (!parallel_hds[index]) {
         error_report("could not connect parallel device"
                      " to character backend '%s'", devname);
@@ -2492,7 +2492,7 @@ static int virtcon_parse(const char *devname)
     qemu_opt_set(dev_opts, "driver", "virtconsole", &error_abort);
=20
     snprintf(label, sizeof(label), "virtcon%d", index);
-    virtcon_hds[index] =3D qemu_chr_new(label, devname);
+    virtcon_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
     if (!virtcon_hds[index]) {
         error_report("could not connect virtio console"
                      " to character backend '%s'", devname);
@@ -2508,7 +2508,7 @@ static int debugcon_parse(const char *devname)
 {
     QemuOpts *opts;
=20
-    if (!qemu_chr_new("debugcon", devname)) {
+    if (!qemu_chr_new_mux_mon("debugcon", devname)) {
         exit(1);
     }
     opts =3D qemu_opts_create(qemu_find_opts("device"), "debugcon", 1, N=
ULL);
--=20
2.18.0.547.g1d89318c48
