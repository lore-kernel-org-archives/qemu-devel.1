Received: from eggs.gnu.org ([2001:4830:134:3::10]:42366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCj-0006NU-1q
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6yCf-00074a-41
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 08:21:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 24 Oct 2017 09:20:43 -0300
Message-Id: <20171024122045.30072-3-f4bug@amsat.org>
In-Reply-To: <20171024122045.30072-1-f4bug@amsat.org>
References: <20171024122045.30072-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/4] tpm: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Commit c37cacabf22 moved tpm_cleanup() in the main loop exit, however this
function is not available when compiling with --disable-tpm.

Provides necessary stubs to keep code clean of #ifdef'fery.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20171023102903.256AF7456A0@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
---
 Makefile.objs       |  2 +-
 stubs/tpm.c         | 33 +++++++++++++++++++++++++++++++++
 MAINTAINERS         |  1 +
 stubs/Makefile.objs |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 stubs/tpm.c

diff --git a/Makefile.objs b/Makefile.objs
index d4f973a8fc..285c6f3c15 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -62,7 +62,7 @@ bt-host.o-cflags := $(BLUEZ_CFLAGS)
 common-obj-y += dma-helpers.o
 common-obj-y += vl.o
 vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
-common-obj-y += tpm.o
+common-obj-$(CONFIG_TPM) += tpm.o
 
 common-obj-$(CONFIG_SLIRP) += slirp/
 
diff --git a/stubs/tpm.c b/stubs/tpm.c
new file mode 100644
index 0000000000..c18aac1c73
--- /dev/null
+++ b/stubs/tpm.c
@@ -0,0 +1,33 @@
+/*
+ * TPM stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "sysemu/tpm.h"
+#include "qmp-commands.h"
+
+int tpm_init(void)
+{
+    return 0;
+}
+
+void tpm_cleanup(void)
+{
+}
+
+TPMInfoList *qmp_query_tpm(Error **errp)
+{
+    return NULL;
+}
+
+TpmTypeList *qmp_query_tpm_types(Error **errp)
+{
+    return NULL;
+}
+
+TpmModelList *qmp_query_tpm_models(Error **errp)
+{
+    return NULL;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 12175425a7..2650063242 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1544,6 +1544,7 @@ TPM
 M: Stefan Berger <stefanb@linux.vnet.ibm.com>
 S: Maintained
 F: tpm.c
+F: stubs/tpm.c
 F: hw/tpm/*
 F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c7594796c3..8cfe34328a 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -28,6 +28,7 @@ stub-obj-y += runstate-check.o
 stub-obj-y += set-fd-handler.o
 stub-obj-y += slirp.o
 stub-obj-y += sysbus.o
+stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
 stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
-- 
2.15.0.rc1
