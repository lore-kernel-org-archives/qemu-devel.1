Received: from eggs.gnu.org ([2001:4830:134:3::10]:47043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhET-0007LN-O5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhES-0005xQ-FZ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGhES-0005wN-6r
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:42:52 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 11:40:40 +0400
Message-Id: <20170602074040.7400-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170602074040.7400-1-marcandre.lureau@redhat.com>
References: <20170602074040.7400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/15] char: move char devices to chardev/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Suggested by Paolo Bonzini during series review.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 {backends =3D> chardev}/baum.c         |  0
 {backends =3D> chardev}/msmouse.c      |  0
 spice-qemu-char.c =3D> chardev/spice.c |  2 +-
 {backends =3D> chardev}/testdev.c      |  0
 {backends =3D> chardev}/wctablet.c     |  0
 MAINTAINERS                          |  4 +---
 Makefile.objs                        |  4 ++--
 backends/Makefile.objs               |  4 ----
 backends/trace-events                | 10 ----------
 chardev/Makefile.objs                |  6 ++++++
 chardev/trace-events                 | 18 ++++++++++++++++++
 trace-events                         |  7 -------
 12 files changed, 28 insertions(+), 27 deletions(-)
 rename {backends =3D> chardev}/baum.c (100%)
 rename {backends =3D> chardev}/msmouse.c (100%)
 rename spice-qemu-char.c =3D> chardev/spice.c (99%)
 rename {backends =3D> chardev}/testdev.c (100%)
 rename {backends =3D> chardev}/wctablet.c (100%)
 create mode 100644 chardev/trace-events

diff --git a/backends/baum.c b/chardev/baum.c
similarity index 100%
rename from backends/baum.c
rename to chardev/baum.c
diff --git a/backends/msmouse.c b/chardev/msmouse.c
similarity index 100%
rename from backends/msmouse.c
rename to chardev/msmouse.c
diff --git a/spice-qemu-char.c b/chardev/spice.c
similarity index 99%
rename from spice-qemu-char.c
rename to chardev/spice.c
index 1c6c2e3969..a312078812 100644
--- a/spice-qemu-char.c
+++ b/chardev/spice.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "ui/qemu-spice.h"
 #include "chardev/char.h"
 #include "qemu/error-report.h"
diff --git a/backends/testdev.c b/chardev/testdev.c
similarity index 100%
rename from backends/testdev.c
rename to chardev/testdev.c
diff --git a/backends/wctablet.c b/chardev/wctablet.c
similarity index 100%
rename from backends/wctablet.c
rename to chardev/wctablet.c
diff --git a/MAINTAINERS b/MAINTAINERS
index 48e2964ed8..120788d8fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1239,13 +1239,11 @@ M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
 S: Maintained
 F: chardev/
 F: include/chardev/
-F: backends/msmouse.c
-F: backends/testdev.c
=20
 Character Devices (Braille)
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
-F: backends/baum.c
+F: chardev/baum.c
=20
 Command line option argument parsing
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/Makefile.objs b/Makefile.objs
index 2100845ce2..0575802440 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -50,8 +50,6 @@ common-obj-$(CONFIG_LINUX) +=3D fsdev/
=20
 common-obj-y +=3D migration/
=20
-common-obj-$(CONFIG_SPICE) +=3D spice-qemu-char.o
-
 common-obj-y +=3D audio/
 common-obj-y +=3D hw/
 common-obj-y +=3D accel.o
@@ -70,6 +68,7 @@ common-obj-y +=3D tpm.o
 common-obj-$(CONFIG_SLIRP) +=3D slirp/
=20
 common-obj-y +=3D backends/
+common-obj-y +=3D chardev/
=20
 common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
=20
@@ -121,6 +120,7 @@ trace-events-subdirs +=3D io
 trace-events-subdirs +=3D migration
 trace-events-subdirs +=3D block
 trace-events-subdirs +=3D backends
+trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D hw/block
 trace-events-subdirs +=3D hw/block/dataplane
 trace-events-subdirs +=3D hw/char
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 0e0f1567b2..0400799efd 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -1,10 +1,6 @@
 common-obj-y +=3D rng.o rng-egd.o
 common-obj-$(CONFIG_POSIX) +=3D rng-random.o
=20
-common-obj-y +=3D msmouse.o wctablet.o testdev.o
-common-obj-$(CONFIG_BRLAPI) +=3D baum.o
-baum.o-cflags :=3D $(SDL_CFLAGS)
-
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
 common-obj-y +=3D hostmem.o hostmem-ram.o
diff --git a/backends/trace-events b/backends/trace-events
index 8c3289a3f9..e69de29bb2 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -1,10 +0,0 @@
-# See docs/tracing.txt for syntax documentation.
-
-# backends/wctablet.c
-wct_init(void) ""
-wct_cmd_re(void) ""
-wct_cmd_st(void) ""
-wct_cmd_sp(void) ""
-wct_cmd_ts(int input) "0x%02x"
-wct_cmd_other(const char *cmd) "%s"
-wct_speed(int speed) "%d"
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index e0b37dbfd8..52a8127606 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -16,3 +16,9 @@ chardev-obj-y +=3D char-stdio.o
 chardev-obj-y +=3D char-udp.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win.o
 chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
+
+common-obj-y +=3D msmouse.o wctablet.o testdev.o
+common-obj-$(CONFIG_BRLAPI) +=3D baum.o
+baum.o-cflags :=3D $(SDL_CFLAGS)
+
+common-obj-$(CONFIG_SPICE) +=3D spice.o
diff --git a/chardev/trace-events b/chardev/trace-events
new file mode 100644
index 0000000000..822dde668b
--- /dev/null
+++ b/chardev/trace-events
@@ -0,0 +1,18 @@
+# See docs/tracing.txt for syntax documentation.
+
+# chardev/wctablet.c
+wct_init(void) ""
+wct_cmd_re(void) ""
+wct_cmd_st(void) ""
+wct_cmd_sp(void) ""
+wct_cmd_ts(int input) "0x%02x"
+wct_cmd_other(const char *cmd) "%s"
+wct_speed(int speed) "%d"
+
+# chardev/spice.c
+spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
+spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
+spice_vmc_register_interface(void *scd) "spice vmc registered interface =
%p"
+spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interf=
ace %p"
+spice_vmc_event(int event) "spice vmc event %d"
+
diff --git a/trace-events b/trace-events
index 433865fa97..d7a4d94168 100644
--- a/trace-events
+++ b/trace-events
@@ -41,13 +41,6 @@ system_wakeup_request(int reason) "reason=3D%d"
 qemu_system_shutdown_request(int reason) "reason=3D%d"
 qemu_system_powerdown_request(void) ""
=20
-# spice-qemu-char.c
-spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
-spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
-spice_vmc_register_interface(void *scd) "spice vmc registered interface =
%p"
-spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interf=
ace %p"
-spice_vmc_event(int event) "spice vmc event %d"
-
 # monitor.c
 monitor_protocol_event_handler(uint32_t event, void *qdict) "event=3D%d =
data=3D%p"
 monitor_protocol_event_emit(uint32_t event, void *data) "event=3D%d data=
=3D%p"
--=20
2.13.0.91.g00982b8dd
