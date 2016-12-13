Received: from eggs.gnu.org ([2001:4830:134:3::10]:40917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGoqK-0008RQ-Tx
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGoqG-0006Fa-RS
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:18:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Dec 2016 16:17:53 +0100
Message-Id: <20161213151753.17020-2-pbonzini@redhat.com>
In-Reply-To: <20161213151753.17020-1-pbonzini@redhat.com>
References: <20161213151753.17020-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] add fio plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                 |   3 +-
 contrib/fio/Makefile      |  62 +++++++
 contrib/fio/README        |  13 ++
 contrib/fio/fio.c         | 404 ++++++++++++++++++++++++++++++++++++++++++++++
 contrib/fio/qemu.fio      |  26 +++
 contrib/fio/uninclude.awk |  78 +++++++++
 6 files changed, 585 insertions(+), 1 deletion(-)
 create mode 100644 contrib/fio/Makefile
 create mode 100644 contrib/fio/README
 create mode 100644 contrib/fio/fio.c
 create mode 100644 contrib/fio/qemu.fio
 create mode 100644 contrib/fio/uninclude.awk

diff --git a/configure b/configure
index 7dec6cd..8687461 100755
--- a/configure
+++ b/configure
@@ -6181,13 +6181,14 @@ fi
 
 # build tree in object directory in case the source is not in the current directory
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
-DIRS="$DIRS fsdev"
+DIRS="$DIRS fsdev contrib/fio"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 DIRS="$DIRS qapi-generated"
 FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
 FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
+FILES="$FILES contrib/fio/Makefile"
 FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
 FILES="$FILES pc-bios/spapr-rtas/Makefile"
 FILES="$FILES pc-bios/s390-ccw/Makefile"
diff --git a/contrib/fio/Makefile b/contrib/fio/Makefile
new file mode 100644
index 0000000..4a86b3f
--- /dev/null
+++ b/contrib/fio/Makefile
@@ -0,0 +1,62 @@
+# -*- Mode: makefile -*-
+
+BUILD_DIR?=$(CURDIR)/../..
+
+include ../../config-host.mak
+include $(SRC_PATH)/rules.mak
+
+$(call set-vpath, $(SRC_PATH):$(SRC_PATH)/contrib/fio:$(CURDIR))
+
+PROGS=qemu.so
+
+all: $(PROGS)
+# Dummy command so that make thinks it has done something
+	@true
+
+QEMU_CFLAGS += -I$(BUILD_DIR) -Wno-error -Wno-redundant-decls
+LIBS += $(LIBS_TOOLS)
+
+# We need two fio header files, but we don't want to include
+# fio's config-host.h because its #defined symbols conflict
+# with QEMU's own config-host.h.  In general we do not want to
+# have -I$(FIO_PATH) while compiling fio.o because the possible
+# conflicts are a mess.
+#
+# optgroup.h is tame and we can just copy it to the build directory,
+# but fio.h includes a lot of other header files, from both fio
+# itself and the system.  Therefore we preprocess it so that
+# fio's headers are merged into a single file, fio-qemu.h, while
+# system headers are left as #include directives.  Because the
+# preprocessing step removes all preprocessor conditionals,
+# there is no dependency left on fio's config-host.h file.
+#
+# While at it, we hack some symbols that conflict with QEMU's,
+# by prefixing them with a "FIO_" or "fio_" namespace.
+fio.o: fio-qemu.h fio-optgroup-qemu.h
+
+fio-optgroup-qemu.h:
+	cp $(FIO_PATH)/optgroup.h $@
+
+FIO_HACK_SYMBOLS=sed -e 's/\<JSON_/FIO_&/' -e 's/\<cpu_to_/fio_&/'
+fio-qemu.h:
+	$(CC) -dD -dI -C -E -o - -I$(FIO_PATH) $(QEMU_CFLAGS) \
+            -include $(FIO_PATH)/config-host.h $(FIO_PATH)/fio.h | \
+            awk -f $(SRC_PATH)/contrib/fio/uninclude.awk | \
+            $(FIO_HACK_SYMBOLS) > $@
+
+include $(SRC_PATH)/Makefile.objs
+dummy := $(call unnest-vars,../.., \
+               block-obj-y \
+               block-obj-m \
+               crypto-obj-y \
+               qom-obj-y \
+               io-obj-y)
+obj-y := fio.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y)
+
+dummy := $(shell mkdir -p $(dir $(obj-y)))
+qemu.so: $(obj-y) ../../libqemuutil.a ../../libqemustub.a
+	$(call LINK, $^)
+
+clean: clean-target
+	rm -f *.a $(filter-out ../../%, $(obj-y))
+	rm -f $(shell find . -name '*.[od]')
diff --git a/contrib/fio/README b/contrib/fio/README
new file mode 100644
index 0000000..4aef2a0
--- /dev/null
+++ b/contrib/fio/README
@@ -0,0 +1,13 @@
+This is a plugin to test the QEMU block layer with fio,
+the flexible I/O tester.
+
+To build this plugin you have to:
+
+1) hack the configure file to use -fPIC instead of -fPIE
+
+2) configure qemu with --enable-pie
+
+3) build the plugin with
+
+	make qemu-img
+	make -C contrib/fio
diff --git a/contrib/fio/fio.c b/contrib/fio/fio.c
new file mode 100644
index 0000000..eedc3b9
--- /dev/null
+++ b/contrib/fio/fio.c
@@ -0,0 +1,404 @@
+/*
+ * QEMU engine for fio
+ *
+ */
+#include "fio-qemu.h"
+#include "fio-optgroup-qemu.h"
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "block/aio.h"
+#include "block/qapi.h"
+#include "crypto/init.h"
+#include "sysemu/block-backend.h"
+
+struct qemu_data {
+	AioContext *ctx;
+	unsigned int completed;
+	unsigned int to_submit;
+	struct io_u *aio_events[];
+};
+
+struct qemu_options {
+	void *pad;
+	const char *aio;
+	const char *format;
+	const char *driver;
+};
+
+static QemuMutex iothread_lock;
+
+static int str_aio_cb(void *data, const char *str)
+{
+	struct qemu_options *o = data;
+
+	if (!strcmp(str, "native") || !strcmp(str, "threads"))
+		o->aio = strdup(str);
+	else
+		return 1;
+
+	return 0;
+}
+
+static struct fio_option options[] = {
+	{
+		.name   = "qemu_driver",
+		.lname  = "QEMU block driver",
+		.type   = FIO_OPT_STR_STORE,
+		.off1   = offsetof(struct qemu_options, driver),
+		.category = FIO_OPT_C_ENGINE,
+		.group  = FIO_OPT_G_INVALID,
+	},
+	{
+		.name   = "qemu_format",
+		.lname  = "Image format",
+		.type   = FIO_OPT_STR_STORE,
+		.off1   = offsetof(struct qemu_options, format),
+		.category = FIO_OPT_C_ENGINE,
+		.group  = FIO_OPT_G_INVALID,
+	},
+	{
+		.name   = "qemu_aio",
+		.lname  = "Use native AIO",
+		.type   = FIO_OPT_STR_STORE,
+		.off1   = offsetof(struct qemu_options, aio),
+		.cb     = str_aio_cb,
+		.category = FIO_OPT_C_ENGINE,
+		.group  = FIO_OPT_G_INVALID,
+	},
+	{
+		.name   = NULL,
+	},
+};
+
+static int fio_qemu_getevents(struct thread_data *td, unsigned int min,
+			      unsigned int max, const struct timespec *t)
+{
+	struct qemu_data *qd = td->io_ops_data;
+
+	/* TODO: set timer */
+	do
+		aio_poll(qd->ctx, true);
+	while (qd->completed < min);
+
+	return qd->completed;
+}
+
+static struct io_u *fio_qemu_event(struct thread_data *td, int event)
+{
+	struct qemu_data *qd = td->io_ops_data;
+
+	qd->completed--;
+	return qd->aio_events[event];
+}
+
+static inline BlockBackend *fio_qemu_get_blk(struct fio_file *file)
+{
+	return (BlockBackend *)(uintptr_t)(file->engine_data & ~1);
+}
+
+static inline bool fio_qemu_mark_plugged(struct fio_file *file)
+{
+	bool plugged = (file->engine_data & 1);
+	file->engine_data |= 1;
+	return plugged;
+}
+
+static inline bool fio_qemu_test_and_clear_plugged(struct fio_file *file)
+{
+	bool plugged = (file->engine_data & 1);
+	file->engine_data &= ~1;
+	return plugged;
+}
+
+static void fio_qemu_entry(void *opaque)
+{
+	struct io_u *io_u = opaque;
+	struct fio_file *file = io_u->file;
+	BlockBackend *blk = fio_qemu_get_blk(file);
+	struct iovec iov = { io_u->xfer_buf, io_u->xfer_buflen };
+
+	struct thread_data *td;
+	struct qemu_data *qd;
+	unsigned r;
+	int ret;
+
+	if (!fio_qemu_mark_plugged(io_u->file))
+		blk_io_plug(blk);
+
+	if (io_u->ddir == DDIR_READ) {
+		QEMUIOVector qiov;
+		qemu_iovec_init_external(&qiov, &iov, 1);
+		ret = blk_co_preadv(blk, io_u->offset, iov.iov_len, &qiov, 0);
+	} else if (io_u->ddir == DDIR_WRITE) {
+		QEMUIOVector qiov;
+		qemu_iovec_init_external(&qiov, &iov, 1);
+		ret = blk_co_pwritev(blk, io_u->offset, iov.iov_len, &qiov, 0);
+	} else if (io_u->ddir == DDIR_TRIM) {
+		ret = blk_co_pdiscard(blk, io_u->offset, iov.iov_len);
+	} else {
+		ret = blk_flush(blk);
+	}
+
+	if (!ret) {
+		io_u->resid = 0;
+		io_u->error = 0;
+	} else if (ret == -ECANCELED) {
+		io_u->resid = io_u->xfer_buflen;
+		io_u->error = 0;
+	} else {
+		io_u->error = -ret;
+	}
+
+	td = io_u->engine_data;
+	qd = td->io_ops_data;
+	r = qd->completed++;
+	qd->aio_events[r] = io_u;
+}
+
+static int fio_qemu_queue(struct thread_data *td,
+			      struct io_u *io_u)
+{
+	Coroutine *co;
+	struct qemu_data *qd;
+
+	fio_ro_check(td, io_u);
+
+	co = qemu_coroutine_create(fio_qemu_entry, io_u);
+	io_u->error = EINPROGRESS;
+	io_u->engine_data = td;
+	qemu_coroutine_enter(co);
+
+	qd = td->io_ops_data;
+	if (io_u->error == EINPROGRESS) {
+		io_u->error = 0;
+		qd->to_submit++;
+		return FIO_Q_QUEUED;
+	}
+
+	/* This I/O operation has completed.  If all of them are, fio will not
+	 * call fio_qemu_commit, so unplug immediately.
+	 */
+	qd->completed--;
+	if (qd->to_submit == 0) {
+		BlockBackend *blk = fio_qemu_get_blk(io_u->file);
+		fio_qemu_test_and_clear_plugged(io_u->file);
+		blk_io_unplug(blk);
+	}
+
+	return FIO_Q_COMPLETED;
+}
+
+static int fio_qemu_commit(struct thread_data *td)
+{
+	struct qemu_data *qd = td->io_ops_data;
+	struct fio_file *file;
+	int i;
+
+	for_each_file(td, file, i) {
+		if (fio_qemu_test_and_clear_plugged(file)) {
+			BlockBackend *blk = fio_qemu_get_blk(file);
+			blk_io_unplug(blk);
+		}
+	}
+	qd->to_submit = 0;
+
+	return 0;
+}
+
+static int fio_qemu_invalidate(struct thread_data *td, struct fio_file *file)
+{
+	return 0;
+}
+static void fio_qemu_cleanup(struct thread_data *td)
+{
+	struct qemu_data *qd = td->io_ops_data;
+
+	if (qd) {
+		aio_context_unref(qd->ctx);
+		free(qd);
+	}
+}
+
+static QDict *fio_qemu_opts(struct thread_data *td, struct fio_file *file)
+{
+	QDict *bs_opts;
+	struct qemu_options *o = td->eo;
+
+	bs_opts = qdict_new();
+	if (td_read(td) && read_only)
+		qdict_put(bs_opts, BDRV_OPT_READ_ONLY,
+			  qstring_from_str("on"));
+	qdict_put(bs_opts, BDRV_OPT_CACHE_DIRECT,
+		  qstring_from_str(td->o.odirect ? "on" : "off"));
+	if (o->format)
+		qdict_put(bs_opts, "format", qstring_from_str(o->format));
+
+	/* If no format is provided, but a driver is, skip the raw format.  */
+	if (o->driver)
+		qdict_put(bs_opts, !o->format ? "driver" : "file.driver",
+			  qstring_from_str(o->driver));
+
+
+	/* This is mostly a convenience, because the aio option of the file
+	 * driver is commonly specified.
+	 */
+	if (o->aio)
+		qdict_put(bs_opts, !o->format && o->driver ? "aio" : "file.aio",
+			  qstring_from_str(o->aio));
+
+	return bs_opts;
+}
+
+static int fio_qemu_get_file_size(struct thread_data *td, struct fio_file *file)
+{
+	Error *local_error = NULL;
+	BlockBackend *blk;
+	QDict *bs_opts;
+	ImageInfo *info;
+
+	bs_opts = fio_qemu_opts(td, file);
+	blk = blk_new_open(file->file_name, NULL, bs_opts, 0, &local_error);
+	if (local_error) {
+		struct qemu_options *o = td->eo;
+		if (!td->o.create_on_open || !td->o.allow_create) {
+			error_report_err(local_error);
+			return -EINVAL;
+		}
+
+		error_free(local_error);
+		local_error = NULL;
+
+		bdrv_img_create(file->file_name, o->format ? : "raw", NULL, NULL,
+				NULL, td->o.size / td->o.nr_files, 0, &local_error, false);
+		if (local_error) {
+		    error_report_err(local_error);
+		    return -EINVAL;
+		}
+
+		bs_opts = fio_qemu_opts(td, file);
+		blk = blk_new_open(file->file_name, NULL, bs_opts, 0, &local_error);
+		if (local_error) {
+		    error_report_err(local_error);
+		    return -EINVAL;
+		}
+	}
+
+	/* QDECREF(bs_opts); ??? */
+	bdrv_query_image_info(blk_bs(blk), &info, &local_error);
+	blk_unref(blk);
+
+	file->real_file_size = info->virtual_size;
+	fio_file_set_size_known(file);
+	qapi_free_ImageInfo(info);
+
+	return 0;
+}
+
+static void fio_qemu_setup_globals(void)
+{
+	qemu_init_main_loop(&error_abort);
+	qcrypto_init(&error_fatal);
+	module_call_init(MODULE_INIT_QOM);
+	bdrv_init();
+	qemu_mutex_init(&iothread_lock);
+}
+
+static int fio_qemu_setup(struct thread_data *td)
+{
+	static pthread_once_t fio_qemu_globals = PTHREAD_ONCE_INIT;
+	struct fio_file *file;
+	int i;
+
+	td->o.use_thread = 1;
+	pthread_once(&fio_qemu_globals, fio_qemu_setup_globals);
+
+	for_each_file(td, file, i) {
+		int ret;
+		dprint(FD_FILE, "get file size for %p/%d/%p\n", file, i,
+								file->file_name);
+
+		ret = fio_qemu_get_file_size(td, file);
+		if (ret < 0) {
+			log_err("%s\n", strerror(-ret));
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int fio_qemu_init(struct thread_data *td)
+{
+	size_t sz = sizeof(struct qemu_data) + td->o.iodepth * sizeof(struct io_u *);
+	struct qemu_data *qd = malloc(sz);
+
+	memset(qd, 0, sz);
+	qd->ctx = aio_context_new(&error_abort);
+
+	/* dlclosing QEMU leaves a pthread_key behind.  We'd need RTLD_NODELETE,
+	 * but fio does not use it.  Instead, just prevent fio from dlclosing.
+	 */
+	td->io_ops_dlhandle = NULL;
+
+	td->io_ops_data = qd;
+	td->o.use_thread = 1;
+	return 0;
+}
+
+static int fio_qemu_open_file(struct thread_data *td, struct fio_file *file)
+{
+	struct qemu_data *qd = td->io_ops_data;
+	Error *local_error = NULL;
+	QDict *bs_opts;
+	BlockBackend *blk;
+
+	qemu_mutex_lock(&iothread_lock);
+	bs_opts = fio_qemu_opts(td, file);
+	blk = blk_new_open(file->file_name, NULL, bs_opts, 0, &local_error);
+	/* QDECREF(bs_opts); ??? */
+
+	if (local_error) {
+		error_report_err(local_error);
+		return -EINVAL;
+	}
+
+	blk_set_aio_context(blk, qd->ctx);
+	blk_set_enable_write_cache(blk, !td->o.sync_io);
+	qemu_mutex_unlock(&iothread_lock);
+
+	file->engine_data = (uintptr_t)blk;
+	td->o.open_files ++;
+	return 0;
+}
+
+static int fio_qemu_close_file(struct thread_data *td, struct fio_file *file)
+{
+	BlockBackend *blk = fio_qemu_get_blk(file);
+
+	if (blk) {
+		blk_unref(blk);
+		file->engine_data = 0;
+	}
+
+	return 0;
+}
+
+struct ioengine_ops ioengine = {
+	.name		= "qemu",
+	.version	= FIO_IOOPS_VERSION,
+	.init		= fio_qemu_init,
+	.queue		= fio_qemu_queue,
+	.commit		= fio_qemu_commit,
+	.getevents	= fio_qemu_getevents,
+	.event		= fio_qemu_event,
+	.invalidate	= fio_qemu_invalidate,
+	.cleanup	= fio_qemu_cleanup,
+	.setup		= fio_qemu_setup,
+	.open_file	= fio_qemu_open_file,
+	.close_file	= fio_qemu_close_file,
+	.options	= options,
+	.option_struct_size = sizeof(struct qemu_options),
+};
diff --git a/contrib/fio/qemu.fio b/contrib/fio/qemu.fio
new file mode 100644
index 0000000..565c015
--- /dev/null
+++ b/contrib/fio/qemu.fio
@@ -0,0 +1,26 @@
+; Read 4 files with aio at different depths
+[global]
+ioengine=./qemu.so
+direct=1
+qemu_aio=native
+rw=randread
+bs=128k
+filesize=128m
+runtime=10s
+time_based
+
+[file1]
+filename=file1
+iodepth=4
+
+[file2]
+filename=file2
+iodepth=32
+
+[file3]
+filename=file3
+iodepth=8
+
+[file4]
+filename=file4
+iodepth=16
diff --git a/contrib/fio/uninclude.awk b/contrib/fio/uninclude.awk
new file mode 100644
index 0000000..88afa59
--- /dev/null
+++ b/contrib/fio/uninclude.awk
@@ -0,0 +1,78 @@
+BEGIN {
+    # gcc strips #ifdef blocks, which removes the multiple-inclusion guard too.
+    # Repair with #pragma once.
+    print "#pragma once"
+}
+
+{
+    # Documentation says builtins are not printed by -dD, but reality disagrees.
+    if ($1 == "#" && $3 ~ "\"<built-in>\"") {
+        delete_until_hash = 1
+        next
+    }
+    if (delete_until_hash) {
+        if ($1 == "#") {
+            delete_until_hash = 0
+        } else {
+           next
+       }
+   }
+
+    # Handle the delete state: skip files included with <...> and -include,
+    # plus their nested includes
+    if (delete_depth) {
+        if ($1 == "#") {
+            if ($4 == "1") {
+                delete_depth++
+            } else if ($4 == "2") {
+                delete_depth--
+            }
+        }
+        if (delete_depth) {
+            next
+        } else {
+            # Out of delete state.  We are on a # directive, if necessary
+            # we can use it to set command_line again
+            command_line = 0
+        }
+    }
+
+    # Handle the command-line state: skip -D definitions and -included files
+    if ($1 == "#" && $3 == "\"<command-line>\"") {
+        command_line = 1
+    }
+
+    if (command_line) {
+        if ($1 == "#" && $4 == "1") {
+            # This is a -included file, enter the delete state
+            delete_depth = 1
+        }
+        next
+    }
+
+    if ($1 == "#include") {
+        if ($2 ~ /^</) {
+            print
+            # We printed the #include directive.  Now skip until the # line
+            # that enters the included file, and enter the delete state.
+            do {
+                getline
+            } while ($1 == "#" && $4 != "1")
+            if ($1 == "#" && $4 == "1") {
+                delete_depth = 1
+                next
+            }
+        } else {
+            # For local includes we include their content, so the #include
+            # directive must go.
+            next
+        }
+    }
+
+    # Remove line directives emitted by the preprocessor
+    if ($1 == "#") {
+        next
+    }
+
+    print
+}
-- 
2.9.3
