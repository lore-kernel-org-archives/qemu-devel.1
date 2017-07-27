Received: from eggs.gnu.org ([2001:4830:134:3::10]:36131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dad0p-0001LP-Ks
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dad0m-00040A-70
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:15:11 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:32872)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dad0l-0003y3-HT
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 03:15:08 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Thu, 27 Jul 2017 10:14:59 +0300
Message-Id: <150113969973.25904.10482311955061924490.stgit@frigg.lan>
In-Reply-To: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
References: <150113848793.25904.12006041120076726256.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 5/5] hypertrace: Add guest-side user-level
 library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Provides guest library "libqemu-hypertrace-guest.a" to abstract access
to the hypertrace channel.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile                           |    5 +
 configure                          |    2=20
 hypertrace/guest/Makefile          |   30 ++++
 hypertrace/guest/common.c          |  301 ++++++++++++++++++++++++++++++=
++++++
 hypertrace/guest/qemu-hypertrace.h |   80 ++++++++++
 5 files changed, 418 insertions(+)
 create mode 100644 hypertrace/guest/Makefile
 create mode 100644 hypertrace/guest/common.c
 create mode 100644 hypertrace/guest/qemu-hypertrace.h

diff --git a/Makefile b/Makefile
index d45158cf29..f3a39b6c7c 100644
--- a/Makefile
+++ b/Makefile
@@ -601,8 +601,13 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
 endif
 endif
=20
+install-hypertrace:
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
+	$(INSTALL_DATA) "$(SRC_PATH)/hypertrace/guest/qemu-hypertrace.h" "$(DES=
TDIR)$(includedir)/"
+
=20
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loc=
alstatedir
+install: install-hypertrace
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDI=
R)$(bindir))
 endif
diff --git a/configure b/configure
index e6f752c242..9c7358d0b4 100755
--- a/configure
+++ b/configure
@@ -6286,6 +6286,8 @@ if [ "$TARGET_BASE_ARCH" =3D "" ]; then
 fi
=20
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
+mkdir -p $target_dir/hypertrace/guest
+symlink $source_path/hypertrace/guest/Makefile $target_dir/hypertrace/gu=
est/Makefile
=20
 upper() {
     echo "$@"| LC_ALL=3DC tr '[a-z]' '[A-Z]'
diff --git a/hypertrace/guest/Makefile b/hypertrace/guest/Makefile
new file mode 100644
index 0000000000..cbc956bde1
--- /dev/null
+++ b/hypertrace/guest/Makefile
@@ -0,0 +1,30 @@
+include ../../../config-host.mak
+include ../../config-target.mak
+include $(SRC_PATH)/rules.mak
+
+vpath % $(SRC_PATH)/hypertrace/guest
+
+# do not use QEMU's per-host cflags when building guest code
+QEMU_CFLAGS  =3D -Werror -Wall
+
+QEMU_CFLAGS +=3D $(GLIB_CFLAGS)
+QEMU_CFLAGS +=3D -I$(SRC_PATH)/include
+QEMU_CFLAGS +=3D -I../../../linux-headers
+QEMU_CFLAGS +=3D -I../../../
+QEMU_CFLAGS +=3D -I../../
+
+ifdef CONFIG_SOFTMMU
+QEMU_CFLAGS +=3D -DNEED_CPU_H
+QEMU_CFLAGS +=3D -I$(SRC_PATH)/target-$(TARGET_BASE_ARCH)
+endif
+
+QEMU_CFLAGS +=3D -g -O2
+
+obj-y =3D common.o
+
+libqemu-hypertrace-guest.a: $(obj-y)
+
+all: libqemu-hypertrace-guest.a
+
+clean:
+	rm -f $(obj-y) libqemu-hypertrace-guest.a
diff --git a/hypertrace/guest/common.c b/hypertrace/guest/common.c
new file mode 100644
index 0000000000..96ae4464bc
--- /dev/null
+++ b/hypertrace/guest/common.c
@@ -0,0 +1,301 @@
+/*
+ * Guest-side management of hypertrace.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu-hypertrace.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <glob.h>
+
+#include "config-host.h"
+#include "config-target.h"
+#if defined(CONFIG_SOFTMMU)
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#endif
+#include "hypertrace/common.h"
+
+static pthread_mutex_t init_mutex =3D PTHREAD_MUTEX_INITIALIZER;
+
+static char *config_path;
+static int config_fd =3D -1;
+static uint64_t *config_addr;
+static struct hypertrace_config *config;
+
+static char *data_path;
+static int data_fd =3D -1;
+static uint64_t *data_addr;
+
+static char *control_path;
+static int control_fd =3D -1;
+#if defined(CONFIG_USER_ONLY)
+static __thread uint64_t *control_addr;
+static __thread uint64_t *control_addr_1;
+#else
+static uint64_t *control_addr;
+#endif
+
+static int page_size;
+
+
+static int init_channel_file(const char *base, const char *suffix, size_=
t size,
+                             char **path, int *fd, uint64_t **addr, bool=
 write)
+{
+    int prot;
+
+    *path =3D malloc(strlen(base) + strlen(suffix) + 1);
+    sprintf(*path, "%s%s", base, suffix);
+
+    prot =3D O_RDONLY;
+    if (write) {
+        prot =3D O_RDWR;
+    }
+    *fd =3D open(*path, prot);
+    if (*fd =3D=3D -1) {
+        return -1;
+    }
+
+    prot =3D PROT_READ;
+    if (write) {
+        prot |=3D PROT_WRITE;
+    }
+    *addr =3D mmap(NULL, size, prot, MAP_SHARED, *fd, 0);
+    if (*addr =3D=3D MAP_FAILED) {
+        return -1;
+    }
+    return 0;
+}
+
+#if !defined(CONFIG_USER_ONLY) && defined(__linux__)
+static int check_device_id(const char *base, const char *name, uint64_t =
value)
+{
+    char tmp[1024];
+    sprintf(tmp, "%s/%s", base, name);
+
+    int fd =3D open(tmp, O_RDONLY);
+    if (fd < 0) {
+        return -1;
+    }
+
+    char v[1024];
+    ssize_t s =3D read(fd, v, sizeof(v));
+    if (s < 0) {
+        close(fd);
+        return -1;
+    }
+    v[s] =3D '\0';
+
+    char *res;
+    uint64_t vv =3D strtoull(v, &res, 16);
+    if (*res =3D=3D '\n' && vv =3D=3D value) {
+        return 0;
+    } else {
+        return -1;
+    }
+}
+
+static char *find_device(void)
+{
+    static char tmp[1024];
+    char *res =3D NULL;
+
+    glob_t g;
+    if (glob("/sys/devices/pci*/*", GLOB_NOSORT, NULL, &g) !=3D 0) {
+        return NULL;
+    }
+
+
+    int i;
+    for (i =3D 0; i < g.gl_pathc; i++) {
+        char *path =3D g.gl_pathv[i];
+
+        if (check_device_id(path, "vendor",
+                            PCI_VENDOR_ID_REDHAT_QUMRANET) < 0) {
+            continue;
+        }
+        if (check_device_id(path, "device",
+                            PCI_DEVICE_ID_HYPERTRACE) < 0) {
+            continue;
+        }
+
+        sprintf(tmp, "%s", path);
+        res =3D tmp;
+        break;
+    }
+
+    globfree(&g);
+
+    return res;
+}
+#endif
+
+int qemu_hypertrace_init(const char *base)
+{
+#if defined(CONFIG_USER_ONLY)
+    const char *config_suff =3D "-config";
+    const char *data_suff =3D "-data";
+    const char *control_suff =3D "-control";
+#elif defined(__linux__)
+    const char *config_suff =3D "/resource0";
+    const char *data_suff =3D "/resource1";
+    const char *control_suff =3D "/resource2";
+#else
+#error Unsupported OS
+#endif
+
+#if defined(CONFIG_USER_ONLY)
+    if (base =3D=3D NULL) {
+        errno =3D ENOENT;
+        return -1;
+    }
+#elif defined(__linux__)
+    if (base =3D=3D NULL) {
+        /* try to guess the base path */
+        base =3D find_device();
+        if (base =3D=3D NULL) {
+            errno =3D ENOENT;
+            return -1;
+        }
+    }
+#endif
+
+    if (config_addr =3D=3D NULL) {
+        int res;
+
+        if (pthread_mutex_lock(&init_mutex)) {
+            return -1;
+        }
+
+        page_size =3D getpagesize();
+
+        res =3D init_channel_file(base, config_suff, page_size,
+                                &config_path, &config_fd, &config_addr,
+                                false);
+        if (res !=3D 0) {
+            return res;
+        }
+
+        config =3D (struct hypertrace_config *)config_addr;
+
+        if (pthread_mutex_unlock(&init_mutex)) {
+            return -1;
+        }
+    }
+
+    if (data_addr =3D=3D NULL) {
+        int res;
+
+        if (pthread_mutex_lock(&init_mutex)) {
+            return -1;
+        }
+
+        res =3D init_channel_file(base, data_suff, config->data_size,
+                                &data_path, &data_fd, &data_addr,
+                                true);
+        if (res !=3D 0) {
+            return res;
+        }
+
+        if (pthread_mutex_unlock(&init_mutex)) {
+            return -1;
+        }
+    }
+
+    if (control_addr =3D=3D NULL) {
+        int res;
+        uint64_t control_size =3D config->control_size;
+
+        if (pthread_mutex_lock(&init_mutex)) {
+            return -1;
+        }
+
+        res =3D init_channel_file(base, control_suff, control_size,
+                                &control_path, &control_fd, &control_add=
r,
+                                true);
+        if (res !=3D 0) {
+            return res;
+        }
+
+#if defined(CONFIG_USER_ONLY)
+        control_addr_1 =3D (uint64_t *)((char *)control_addr +
+                                      config->control_size / 2);
+#endif
+
+        if (pthread_mutex_unlock(&init_mutex)) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+
+static int fini_channel(int *fd, char **path)
+{
+    if (*fd !=3D -1) {
+        if (close(*fd) =3D=3D -1) {
+            return -1;
+        }
+        *fd =3D -1;
+    }
+    if (*path !=3D NULL) {
+        free(*path);
+        *path =3D  NULL;
+    }
+    return 0;
+}
+
+int qemu_hypertrace_fini(void)
+{
+    if (fini_channel(&data_fd, &data_path) !=3D 0) {
+        return -1;
+    }
+    if (fini_channel(&control_fd, &control_path) !=3D 0) {
+        return -1;
+    }
+    return 0;
+}
+
+
+uint64_t qemu_hypertrace_max_clients(void)
+{
+    return config->max_clients;
+}
+
+uint64_t qemu_hypertrace_num_args(void)
+{
+    return config->client_args;
+}
+
+uint64_t *qemu_hypertrace_data(uint64_t client)
+{
+    return &data_addr[client * CONFIG_HYPERTRACE_ARGS * sizeof(uint64_t)=
];
+}
+
+void qemu_hypertrace(uint64_t client, uint64_t arg1)
+{
+    uint64_t offset;
+#if defined(CONFIG_USER_ONLY)
+    offset =3D client * page_size;
+#endif
+    *(uint64_t *)((char *)control_addr + offset) =3D arg1;
+#if defined(CONFIG_USER_ONLY)
+    /* QEMU in 'user' mode uses two faulting pages to detect invocations=
 */
+    *(uint64_t *)((char *)control_addr_1 + offset) =3D arg1;
+#endif
+}
diff --git a/hypertrace/guest/qemu-hypertrace.h b/hypertrace/guest/qemu-h=
ypertrace.h
new file mode 100644
index 0000000000..7c7a17c64d
--- /dev/null
+++ b/hypertrace/guest/qemu-hypertrace.h
@@ -0,0 +1,80 @@
+/*
+ * Guest-side management of hypertrace.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdint.h>
+#include <sys/types.h>
+
+
+/**
+ * qemu_hypertrace_init:
+ * @base: Base path to the hypertrace channel.
+ *
+ * Initialize the hypertrace channel. The operation is idempotent, and m=
ust be
+ * called once per thread if running in QEMU's "user" mode.
+ *
+ * The base path to the hypertrace channel depends on the type of QEMU t=
arget:
+ *
+ * - User (single-application)
+ *   The base path provided when starting QEMU ("-hypertrace" commandlin=
e
+ *   option).
+ *
+ * - System (OS-dependant)
+ *   + Linux
+ *     The base path to the hypertrace channel virtual device; on a defa=
ult QEMU
+ *     device setup for x86 this is "/sys/devices/pci0000:00/0000:00:04.=
0". If
+ *     NULL is provided, the hypertrace device will be automatically det=
ected.
+ *
+ * Returns: Zero on success.
+ */
+int qemu_hypertrace_init(const char *base);
+
+/**
+ * qemu_hypertrace_fini:
+ *
+ * Deinitialize the hypertrace channel.
+ *
+ * Returns: Zero on success.
+ */
+int qemu_hypertrace_fini(void);
+
+/**
+ * qemu_hypertrace_max_clients:
+ *
+ * Maximum number of concurrent clients accepted by other calls.
+ */
+uint64_t qemu_hypertrace_max_clients(void);
+
+/**
+ * qemu_hypertrace_num_args:
+ *
+ * Number of uint64_t values read by each call to qemu_hypertrace().
+ */
+uint64_t qemu_hypertrace_num_args(void);
+
+/**
+ * qemu_hypertrace_data:
+ * @client: Client identifier.
+ *
+ * Pointer to the start of the data channel for the given client. Client=
s must
+ * write their arguments there (all but the first one).
+ */
+uint64_t *qemu_hypertrace_data(uint64_t client);
+
+/**
+ * qemu_hypertrace:
+ * @client: Client identifier.
+ * @arg1: First argument of the hypertrace event.
+ *
+ * Emit a hypertrace event.
+ *
+ * Each of the clients (e.g., thread) must use a different client identi=
fier to
+ * ensure they can work concurrently without using locks (i.e., each use=
s a
+ * different portion of the data channel).
+ */
+void qemu_hypertrace(uint64_t client, uint64_t arg1);
