Received: from eggs.gnu.org ([2001:4830:134:3::10]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbzJ-0002OW-2p
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbzF-0003Fk-Os
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:35:17 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:50879 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbzF-0003El-5o
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:35:13 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 21:35:10 +0100
Message-Id: <148278451049.8988.5349519787388002909.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 6/6] hypertrace: Add guest-side Linux module
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

Provides guest Linux kernel module "qemu-hypertrace.ko" to abstract
access to the hypertrace channel.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile                                           |    4 -
 configure                                          |    4 +
 hypertrace/guest/linux-module/Kbuild.in            |    7 +
 hypertrace/guest/linux-module/Makefile             |   23 +++
 .../include/linux/qemu-hypertrace-internal.h       |   46 ++++++
 .../linux-module/include/linux/qemu-hypertrace.h   |   73 ++++++++++
 hypertrace/guest/linux-module/qemu-hypertrace.c    |  149 ++++++++++++++=
++++++
 7 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 hypertrace/guest/linux-module/Kbuild.in
 create mode 100644 hypertrace/guest/linux-module/Makefile
 create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace-internal.h
 create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace.h
 create mode 100644 hypertrace/guest/linux-module/qemu-hypertrace.c

diff --git a/Makefile b/Makefile
index aa3fd4a79b..1a18c570cf 100644
--- a/Makefile
+++ b/Makefile
@@ -460,8 +460,10 @@ endif
 endif
=20
 install-hypertrace:
-	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)/linux"
 	$(INSTALL_DATA) "$(SRC_PATH)/hypertrace/guest/user/qemu-hypertrace.h" "=
$(DESTDIR)$(includedir)/"
+	$(INSTALL_DATA) "$(SRC_PATH)/hypertrace/guest/linux-module/include/linu=
x/qemu-hypertrace.h" "$(DESTDIR)$(includedir)/linux"
+	$(INSTALL_DATA) "$(SRC_PATH)/hypertrace/guest/linux-module/include/linu=
x/qemu-hypertrace-internal.h" "$(DESTDIR)$(includedir)/linux"
=20
=20
 install: all $(if $(BUILD_DOCS),install-doc) \
diff --git a/configure b/configure
index 4dfb9ff586..28dd570033 100755
--- a/configure
+++ b/configure
@@ -6023,6 +6023,10 @@ fi
 symlink "$source_path/Makefile.target" "$target_dir/Makefile"
 mkdir -p $target_dir/hypertrace/guest/user
 symlink $source_path/hypertrace/guest/user/Makefile $target_dir/hypertra=
ce/guest/user/Makefile
+if test "$target_softmmu" =3D "yes"; then
+    mkdir -p $target_dir/hypertrace/guest/linux-module
+    symlink $source_path/hypertrace/guest/linux-module/Makefile $target_=
dir/hypertrace/guest/linux-module/Makefile
+fi
=20
 upper() {
     echo "$@"| LC_ALL=3DC tr '[a-z]' '[A-Z]'
diff --git a/hypertrace/guest/linux-module/Kbuild.in b/hypertrace/guest/l=
inux-module/Kbuild.in
new file mode 100644
index 0000000000..56abaeac8c
--- /dev/null
+++ b/hypertrace/guest/linux-module/Kbuild.in
@@ -0,0 +1,7 @@
+# -*- mode: makefile -*-
+
+COMMON_H =3D $(shell readlink -f $(MOD_SRC_PATH)/../../common.h)
+
+src =3D $(MOD_SRC_PATH)
+ccflags-y :=3D -I$(src)/include/ -DCOMMON_H=3D$(COMMON_H)
+obj-m :=3D qemu-hypertrace.o
diff --git a/hypertrace/guest/linux-module/Makefile b/hypertrace/guest/li=
nux-module/Makefile
new file mode 100644
index 0000000000..b30cdeb00b
--- /dev/null
+++ b/hypertrace/guest/linux-module/Makefile
@@ -0,0 +1,23 @@
+include ../../../../config-host.mak
+include ../../../config-target.mak
+include $(SRC_PATH)/rules.mak
+
+MOD_SRC_PATH =3D $(SRC_PATH)/hypertrace/guest/linux-module
+
+LINUX_BUILD_PATH =3D /lib/modules/$(shell uname -r)/build
+
+vpath % $(MOD_SRC_PATH)
+
+
+all: Kbuild
+	$(MAKE) -C $(LINUX_BUILD_PATH) M=3D$(shell pwd) \
+	  MOD_SRC_PATH=3D$(MOD_SRC_PATH) \
+	  modules
+
+clean: Kbuild
+	$(MAKE) -C $(LINUX_BUILD_PATH) M=3D$(shell pwd) clean
+	rm -f $<
+
+Kbuild: $(MOD_SRC_PATH)/Kbuild.in Makefile
+	rm -f $@
+	cp $< $@
diff --git a/hypertrace/guest/linux-module/include/linux/qemu-hypertrace-=
internal.h b/hypertrace/guest/linux-module/include/linux/qemu-hypertrace-=
internal.h
new file mode 100644
index 0000000000..c439107efc
--- /dev/null
+++ b/hypertrace/guest/linux-module/include/linux/qemu-hypertrace-interna=
l.h
@@ -0,0 +1,46 @@
+/* -*- C -*-
+ *
+ * Guest-side management of hypertrace.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, either version 3 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see http://www.gnu.org/licenses/.
+ */
+
+extern uint64_t _qemu_hypertrace_channel_max_clients;
+extern uint64_t _qemu_hypertrace_channel_num_args;
+extern uint64_t *_qemu_hypertrace_channel_data;
+extern uint64_t *_qemu_hypertrace_channel_control;
+
+static inline uint64_t qemu_hypertrace_max_clients(void)
+{
+    return _qemu_hypertrace_channel_max_clients;
+}
+
+static inline uint64_t qemu_hypertrace_num_args(void)
+{
+    return _qemu_hypertrace_channel_num_args;
+}
+
+static inline uint64_t *qemu_hypertrace_data(uint64_t client)
+{
+    size_t args_size =3D qemu_hypertrace_num_args() * sizeof(uint64_t);
+    return &_qemu_hypertrace_channel_data[client * args_size];
+}
+
+static inline void qemu_hypertrace(uint64_t client, uint64_t arg1)
+{
+    uint64_t *ctrlp =3D _qemu_hypertrace_channel_control;
+    ctrlp[client] =3D arg1;
+}
diff --git a/hypertrace/guest/linux-module/include/linux/qemu-hypertrace.=
h b/hypertrace/guest/linux-module/include/linux/qemu-hypertrace.h
new file mode 100644
index 0000000000..f4b70c90d2
--- /dev/null
+++ b/hypertrace/guest/linux-module/include/linux/qemu-hypertrace.h
@@ -0,0 +1,73 @@
+/* -*- C -*-
+ *
+ * Guest-side management of hypertrace.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, either version 3 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see http://www.gnu.org/licenses/.
+ */
+
+#ifndef QEMU_HYPERTRACE_H
+#define QEMU_HYPERTRACE_H
+
+#include <linux/types.h>
+
+
+/**
+ * qemu_hypertrace_max_clients:
+ *
+ * Maximum number of concurrent clients accepted by other calls.
+ */
+static uint64_t qemu_hypertrace_max_clients(void);
+
+/**
+ * qemu_hypertrace_num_args:
+ *
+ * Number of uint64_t values read by each call to qemu_hypertrace().
+ */
+static uint64_t qemu_hypertrace_num_args(void);
+
+/**
+ * qemu_hypertrace_data:
+ * @client: Client identifier.
+ *
+ * Pointer to the start of the data channel for the given client. Client=
s must
+ * write their arguments there (all but the first one).
+ */
+static uint64_t *qemu_hypertrace_data(uint64_t client);
+
+/**
+ * qemu_hypertrace:
+ * @client: Client identifier.
+ * @arg1: First argument of the hypertrace event.
+ *
+ * Emit a hypertrace event.
+ *
+ * Each of the clients (e.g., CPU) must use a different client identifie=
r to
+ * ensure they can work concurrently without using locks (i.e., each use=
s a
+ * different portion of the data channel).
+ *
+ * Note: You should use wmb() before writing into the control channel if=
f you
+ * have written into the data channel.
+ *
+ * Note: Use preempt_disable() and preempt_enable() if you're using data=
 offsets
+ * based on the CPU identifiers (or else data might be mixed if a task i=
s
+ * re-scheduled).
+ */
+static void qemu_hypertrace(uint64_t client, uint64_t arg1);
+
+
+#include <linux/qemu-hypertrace-internal.h>
+
+#endif  /* QEMU_HYPERTRACE_H */
diff --git a/hypertrace/guest/linux-module/qemu-hypertrace.c b/hypertrace=
/guest/linux-module/qemu-hypertrace.c
new file mode 100644
index 0000000000..5f16ef00c2
--- /dev/null
+++ b/hypertrace/guest/linux-module/qemu-hypertrace.c
@@ -0,0 +1,149 @@
+/*
+ * Guest-side management of hypertrace.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, either version 3 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see http://www.gnu.org/licenses/.
+ */
+
+#include <linux/qemu-hypertrace.h>
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+
+#define xstr(s) #s
+#define str(s) xstr(s)
+#include str(COMMON_H)
+
+
+#define VERSION_STR "0.1"
+#define PCI_VENDOR_ID_REDHAT_QUMRANET    0x1af4
+#define PCI_DEVICE_ID_HYPERTRACE         0x10f0
+
+
+MODULE_DESCRIPTION("Kernel interface to QEMU's hypertrace device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Llu=C3=ADs Vilanova");
+MODULE_VERSION(VERSION_STR);
+
+
+/*********************************************************************
+ * Kernel interface
+ */
+
+uint64_t _qemu_hypertrace_channel_max_clients;
+uint64_t _qemu_hypertrace_channel_num_args;
+static uint64_t *_qemu_hypertrace_channel_config;
+uint64_t *_qemu_hypertrace_channel_data;
+uint64_t *_qemu_hypertrace_channel_control;
+
+EXPORT_SYMBOL(_qemu_hypertrace_channel_max_clients);
+EXPORT_SYMBOL(_qemu_hypertrace_channel_num_args);
+EXPORT_SYMBOL(_qemu_hypertrace_channel_data);
+EXPORT_SYMBOL(_qemu_hypertrace_channel_control);
+
+
+/*********************************************************************
+ * Channel initialization
+ */
+
+static int init_channel(uint64_t **vaddr, struct pci_dev *dev, int bar)
+{
+    void *res;
+    resource_size_t start, size;
+
+    start =3D pci_resource_start(dev, bar);
+    size =3D pci_resource_len(dev, bar);
+
+    if (start =3D=3D 0 || size =3D=3D 0) {
+        return -ENOENT;
+    }
+
+    res =3D ioremap(start, size);
+    if (res =3D=3D 0) {
+        return -EINVAL;
+    }
+
+    *vaddr =3D res;
+    return 0;
+}
+
+/*********************************************************************
+ * Module (de)initialization
+ */
+
+int init_module(void)
+{
+    int res =3D 0;
+    struct pci_dev *dev =3D NULL;
+    struct hypertrace_config *config;
+
+    printk(KERN_NOTICE "Loading QEMU hypertrace module (version %s)\n",
+           VERSION_STR);
+
+    dev =3D pci_get_device(PCI_VENDOR_ID_REDHAT_QUMRANET,
+                         PCI_DEVICE_ID_HYPERTRACE,
+                         NULL);
+    if (dev =3D=3D NULL) {
+        res =3D -ENOENT;
+        printk(KERN_ERR "Unable to find hypertrace device\n");
+        goto error;
+    }
+
+    res =3D init_channel(&_qemu_hypertrace_channel_config, dev, 0);
+    if (res !=3D 0) {
+        printk(KERN_ERR "Unable to find hypertrace config channel\n");
+        goto error;
+    }
+
+    config =3D (struct hypertrace_config *)_qemu_hypertrace_channel_conf=
ig;
+    _qemu_hypertrace_channel_max_clients =3D config->max_clients;
+    _qemu_hypertrace_channel_num_args =3D config->client_args;
+
+    res =3D init_channel(&_qemu_hypertrace_channel_data, dev, 1);
+    if (res !=3D 0) {
+        printk(KERN_ERR "Unable to find hypertrace data channel\n");
+        goto error_config;
+    }
+
+    res =3D init_channel(&_qemu_hypertrace_channel_control, dev, 2);
+    if (res !=3D 0) {
+        printk(KERN_ERR "Unable to find hypertrace control channel\n");
+        goto error_data;
+    }
+
+    goto ok;
+
+error_data:
+    iounmap(_qemu_hypertrace_channel_data);
+
+error_config:
+    iounmap(_qemu_hypertrace_channel_config);
+    _qemu_hypertrace_channel_config =3D NULL;
+    _qemu_hypertrace_channel_data =3D NULL;
+
+error:
+ok:
+    return res;
+}
+
+void cleanup_module(void)
+{
+    printk(KERN_NOTICE "Unloading QEMU hypertrace module\n");
+
+    iounmap(_qemu_hypertrace_channel_config);
+    iounmap(_qemu_hypertrace_channel_data);
+    iounmap(_qemu_hypertrace_channel_control);
+}
