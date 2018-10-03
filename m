Received: from eggs.gnu.org ([2001:4830:134:3::10]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erj-0000dB-T7
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erf-0002s6-Q0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7erf-0002re-Gw
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 14:57:54 +0400
Message-Id: <20181003105755.10862-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181003105755.10862-1-marcandre.lureau@redhat.com>
References: <20181003105755.10862-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/6] chardev: mark the calls that allow an
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This is mostly for readability of the code. Let's make it clear which
callers can create an implicit monitor when the chardev is muxed.

This will also enforce a safer behaviour, as we don't really support
creating monitor anywhere/anytime at the moment. Add an assert() to
make sure the programmer explicitely wanted that behaviour.

There are documented cases, such as: -serial/-parallel/-virtioconsole
and to less extent -debugcon.

Less obvious and questionable ones are -gdb, SLIRP -guestfwd and Xen
console. Add a FIXME note for those, but keep the support for now.

Other qemu_chr_new() callers either have a fixed parameter/filename
string or do not need it, such as -qtest:

* qtest.c: qtest_init()
  Afaik, only used by tests/libqtest.c, without mux. I don't think we
  support it outside of qemu testing: drop support for implicit mux
  monitor (qemu_chr_new() call: no implicit mux now).

* hw/
  All with literal @filename argument that doesn't enable mux monitor.

* tests/
  All with @filename argument that doesn't enable mux monitor.

On a related note, the list of monitor creation places:

- the chardev creators listed above: all from command line (except
  perhaps Xen console?)

- -gdb & hmp gdbserver will create a "GDB monitor command" chardev
  that is wired to an HMP monitor.

- -mon command line option

>From this short study, I would like to think that a monitor may only
be created in the main thread today, though I remain skeptical :)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h | 24 ++++++++++++++++++++----
 chardev/char.c         | 37 ++++++++++++++++++++++++++++++-------
 gdbstub.c              |  6 +++++-
 hw/char/xen_console.c  |  6 +++++-
 net/slirp.c            |  6 +++++-
 vl.c                   | 10 +++++-----
 6 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 3e4fe6dad0..7becd8c80c 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -105,14 +105,27 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
  * @filename: the URI
  *
  * Create a new character backend from a URI.
+ * Do not implicitly initialize a monitor if the chardev is muxed.
  *
  * Returns: a new character backend
  */
 Chardev *qemu_chr_new(const char *label, const char *filename);
=20
 /**
- * qemu_chr_change:
- * @opts: the new backend options
+ * qemu_chr_new_mux_mon:
+ * @label: the name of the backend
+ * @filename: the URI
+ *
+ * Create a new character backend from a URI.
+ * Implicitly initialize a monitor if the chardev is muxed.
+ *
+ * Returns: a new character backend
+ */
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename);
+
+/**
+* qemu_chr_change:
+* @opts: the new backend options
  *
  * Change an existing character backend
  */
@@ -129,6 +142,7 @@ void qemu_chr_cleanup(void);
  * qemu_chr_new_noreplay:
  * @label: the name of the backend
  * @filename: the URI
+ * @permit_mux_mon: if chardev is muxed, initialize a monitor
  *
  * Create a new character backend from a URI.
  * Character device communications are not written
@@ -136,7 +150,8 @@ void qemu_chr_cleanup(void);
  *
  * Returns: a new character backend
  */
-Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
+                               bool permit_mux_mon);
=20
 /**
  * qemu_chr_be_can_write:
@@ -194,7 +209,8 @@ bool qemu_chr_has_feature(Chardev *chr,
                           ChardevFeature feature);
 void qemu_chr_set_feature(Chardev *chr,
                           ChardevFeature feature);
-QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)=
;
+QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
+                                bool permit_mux_mon);
 int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_a=
ll);
 #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true=
)
 int qemu_chr_wait_connected(Chardev *chr, Error **errp);
diff --git a/chardev/char.c b/chardev/char.c
index 76d866e6fe..e115166995 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -329,7 +329,8 @@ int qemu_chr_wait_connected(Chardev *chr, Error **err=
p)
     return 0;
 }
=20
-QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename)
+QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
+                                bool permit_mux_mon)
 {
     char host[65], port[33], width[8], height[8];
     int pos;
@@ -344,6 +345,10 @@ QemuOpts *qemu_chr_parse_compat(const char *label, c=
onst char *filename)
     }
=20
     if (strstart(filename, "mon:", &p)) {
+        if (!permit_mux_mon) {
+            error_report("mon: isn't supported in this context");
+            return NULL;
+        }
         filename =3D p;
         qemu_opt_set(opts, "mux", "on", &error_abort);
         if (strcmp(filename, "stdio") =3D=3D 0) {
@@ -683,7 +688,8 @@ out:
     return chr;
 }
=20
-Chardev *qemu_chr_new_noreplay(const char *label, const char *filename)
+Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
+                               bool permit_mux_mon)
 {
     const char *p;
     Chardev *chr;
@@ -694,25 +700,32 @@ Chardev *qemu_chr_new_noreplay(const char *label, c=
onst char *filename)
         return qemu_chr_find(p);
     }
=20
-    opts =3D qemu_chr_parse_compat(label, filename);
+    opts =3D qemu_chr_parse_compat(label, filename, permit_mux_mon);
     if (!opts)
         return NULL;
=20
     chr =3D qemu_chr_new_from_opts(opts, &err);
-    if (err) {
+    if (!chr) {
         error_report_err(err);
+        goto out;
     }
-    if (chr && qemu_opt_get_bool(opts, "mux", 0)) {
+
+    if (qemu_opt_get_bool(opts, "mux", 0)) {
+        assert(permit_mux_mon);
         monitor_init(chr, MONITOR_USE_READLINE);
     }
+
+out:
     qemu_opts_del(opts);
     return chr;
 }
=20
-Chardev *qemu_chr_new(const char *label, const char *filename)
+static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
+                                          const char *filename,
+                                          bool permit_mux_mon)
 {
     Chardev *chr;
-    chr =3D qemu_chr_new_noreplay(label, filename);
+    chr =3D qemu_chr_new_noreplay(label, filename, permit_mux_mon);
     if (chr) {
         if (replay_mode !=3D REPLAY_MODE_NONE) {
             qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
@@ -726,6 +739,16 @@ Chardev *qemu_chr_new(const char *label, const char =
*filename)
     return chr;
 }
=20
+Chardev *qemu_chr_new(const char *label, const char *filename)
+{
+    return qemu_chr_new_permit_mux_mon(label, filename, false);
+}
+
+Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename)
+{
+    return qemu_chr_new_permit_mux_mon(label, filename, true);
+}
+
 static int qmp_query_chardev_foreach(Object *obj, void *data)
 {
     Chardev *chr =3D CHARDEV(obj);
diff --git a/gdbstub.c b/gdbstub.c
index d6ab95006c..c8478de8f5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2038,7 +2038,11 @@ int gdbserver_start(const char *device)
             sigaction(SIGINT, &act, NULL);
         }
 #endif
-        chr =3D qemu_chr_new_noreplay("gdb", device);
+        /*
+         * FIXME: it's a bit weird to allow using a mux chardev here
+         * and implicitly setup a monitor. We may want to break this.
+         */
+        chr =3D qemu_chr_new_noreplay("gdb", device, true);
         if (!chr)
             return -1;
     }
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 8b4b4bf523..44f7236382 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -207,7 +207,11 @@ static int con_init(struct XenDevice *xendev)
     } else {
         snprintf(label, sizeof(label), "xencons%d", con->xendev.dev);
         qemu_chr_fe_init(&con->chr,
-                         qemu_chr_new(label, output), &error_abort);
+                         /*
+                          * FIXME: sure we want to support implicit
+                          * muxed monitors here?
+                          */
+                         qemu_chr_new_mux_mon(label, output), &error_abo=
rt);
     }
=20
     xenstore_store_pv_console_info(con->xendev.dev,
diff --git a/net/slirp.c b/net/slirp.c
index c93b64dd91..99884de204 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -764,7 +764,11 @@ static int slirp_guestfwd(SlirpState *s, const char =
*config_str, Error **errp)
         }
     } else {
         Error *err =3D NULL;
-        Chardev *chr =3D qemu_chr_new(buf, p);
+        /*
+         * FIXME: sure we want to support implicit
+         * muxed monitors here?
+         */
+        Chardev *chr =3D qemu_chr_new_mux_mon(buf, p);
=20
         if (!chr) {
             error_setg(errp, "Could not open guest forwarding device '%s=
'",
diff --git a/vl.c b/vl.c
index 0388852deb..a867c9c4d9 100644
--- a/vl.c
+++ b/vl.c
@@ -2310,7 +2310,7 @@ static void monitor_parse(const char *optarg, const=
 char *mode, bool pretty)
     } else {
         snprintf(label, sizeof(label), "compat_monitor%d",
                  monitor_device_index);
-        opts =3D qemu_chr_parse_compat(label, optarg);
+        opts =3D qemu_chr_parse_compat(label, optarg, true);
         if (!opts) {
             error_report("parse error: %s", optarg);
             exit(1);
@@ -2382,7 +2382,7 @@ static int serial_parse(const char *devname)
     snprintf(label, sizeof(label), "serial%d", index);
     serial_hds =3D g_renew(Chardev *, serial_hds, index + 1);
=20
-    serial_hds[index] =3D qemu_chr_new(label, devname);
+    serial_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
     if (!serial_hds[index]) {
         error_report("could not connect serial device"
                      " to character backend '%s'", devname);
@@ -2418,7 +2418,7 @@ static int parallel_parse(const char *devname)
         exit(1);
     }
     snprintf(label, sizeof(label), "parallel%d", index);
-    parallel_hds[index] =3D qemu_chr_new(label, devname);
+    parallel_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
     if (!parallel_hds[index]) {
         error_report("could not connect parallel device"
                      " to character backend '%s'", devname);
@@ -2449,7 +2449,7 @@ static int virtcon_parse(const char *devname)
     qemu_opt_set(dev_opts, "driver", "virtconsole", &error_abort);
=20
     snprintf(label, sizeof(label), "virtcon%d", index);
-    virtcon_hds[index] =3D qemu_chr_new(label, devname);
+    virtcon_hds[index] =3D qemu_chr_new_mux_mon(label, devname);
     if (!virtcon_hds[index]) {
         error_report("could not connect virtio console"
                      " to character backend '%s'", devname);
@@ -2465,7 +2465,7 @@ static int debugcon_parse(const char *devname)
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
2.19.0.271.gfe8321ec05
