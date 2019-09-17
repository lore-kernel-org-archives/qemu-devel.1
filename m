Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137B9C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E3C214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 12:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E3C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iACe4-0001oz-Mj
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 08:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1iACZJ-00077i-BG
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1iACZF-0006qR-DN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:53 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:59370
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1iACZF-0006pt-2V
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 08:26:49 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1iACZD-0003tX-Uh; Tue, 17 Sep 2019 14:26:48 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 14:26:44 +0200
Message-Id: <20190917122644.15736-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [RFC] contrib: add vhost-user-sim
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

This implements
 * the UM protocol to access the simulation calendar,
 * the underlying simulation calendar, and
 * a very trivial simulated network as a vhost-user
   virtio_net device.

Currently the code is a bit rough and mostly an example,
things such as the network propagation delay and the
number of clients expected to connect before the whole
simulation starts are both hardcoded; nevertheless, it
serves as an example of how to build such a simulation.

There are also some bugs in the calendar code that are
hard to fix using glib - all the file descriptors should
be handled recursively at all times. The code does some
of that, but then may deadlock in the calendar.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .gitignore                                    |   1 +
 Makefile                                      |   3 +
 Makefile.objs                                 |   1 +
 contrib/vhost-user-sim/Makefile.objs          |   1 +
 contrib/vhost-user-sim/cal.c                  | 288 ++++++++++++++++++
 contrib/vhost-user-sim/cal.h                  |  45 +++
 contrib/vhost-user-sim/main.c                 | 122 ++++++++
 contrib/vhost-user-sim/main.h                 |  22 ++
 contrib/vhost-user-sim/net.c                  | 246 +++++++++++++++
 contrib/vhost-user-sim/simtime.c              | 267 ++++++++++++++++
 .../standard-headers/linux/um_timetravel.h    | 107 +++++++
 11 files changed, 1103 insertions(+)
 create mode 100644 contrib/vhost-user-sim/Makefile.objs
 create mode 100644 contrib/vhost-user-sim/cal.c
 create mode 100644 contrib/vhost-user-sim/cal.h
 create mode 100644 contrib/vhost-user-sim/main.c
 create mode 100644 contrib/vhost-user-sim/main.h
 create mode 100644 contrib/vhost-user-sim/net.c
 create mode 100644 contrib/vhost-user-sim/simtime.c
 create mode 100644 include/standard-headers/linux/um_timetravel.h

diff --git a/.gitignore b/.gitignore
index e9bbc006d39e..3417ffec3988 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,6 +67,7 @@
 /vhost-user-blk
 /vhost-user-gpu
 /vhost-user-input
+/vhost-user-sim
 /fsdev/virtfs-proxy-helper
 *.tmp
 *.[1-9]
diff --git a/Makefile b/Makefile
index 111082ce545d..f74f5d89cff2 100644
--- a/Makefile
+++ b/Makefile
@@ -418,6 +418,7 @@ dummy := $(call unnest-vars,, \
                 vhost-user-blk-obj-y \
                 vhost-user-input-obj-y \
                 vhost-user-gpu-obj-y \
+                vhost-user-sim-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
@@ -638,6 +639,8 @@ vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
 	$(call LINK, $^)
 vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
 	$(call LINK, $^)
+vhost-user-sim$(EXESUF): $(vhost-user-sim-obj-y) libvhost-user.a
+	$(call LINK, $^)
 
 rdmacm-mux$(EXESUF): LIBS += "-libumad"
 rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index 6a143dcd5790..0536665faff0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -122,6 +122,7 @@ vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
 vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
 vhost-user-blk-obj-y = contrib/vhost-user-blk/
+vhost-user-sim-obj-y = contrib/vhost-user-sim/
 rdmacm-mux-obj-y = contrib/rdmacm-mux/
 vhost-user-input-obj-y = contrib/vhost-user-input/
 vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
diff --git a/contrib/vhost-user-sim/Makefile.objs b/contrib/vhost-user-sim/Makefile.objs
new file mode 100644
index 000000000000..ffc9e25ac5d2
--- /dev/null
+++ b/contrib/vhost-user-sim/Makefile.objs
@@ -0,0 +1 @@
+vhost-user-sim-obj-y = cal.o simtime.o net.o main.o
diff --git a/contrib/vhost-user-sim/cal.c b/contrib/vhost-user-sim/cal.c
new file mode 100644
index 000000000000..a9e0ff9460fc
--- /dev/null
+++ b/contrib/vhost-user-sim/cal.c
@@ -0,0 +1,288 @@
+/*
+ * vhost-user-sim calendar
+ *
+ * Copyright (c) 2019 Intel Corporation. All rights reserved.
+ *
+ * Author:
+ *  Johannes Berg <johannes.berg@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 only.
+ * See the COPYING file in the top-level directory.
+ */
+#include <stdbool.h>
+#include <stdio.h>
+#include "cal.h"
+
+#define CAL_DEBUG 1
+
+static unsigned long long simtime;
+static G_LOCK_DEFINE(calendar);
+static GSequence *calendar;
+static GAsyncQueue *queue;
+static bool scheduling;
+static unsigned int required_clients;
+static unsigned int running_clients;
+static SimCalendarEntry *running_entry;
+
+#define DPRINT(...) do {              \
+    if (CAL_DEBUG) {                  \
+        fprintf(stderr, __VA_ARGS__); \
+        fflush(stderr);               \
+    }                                 \
+} while (0)
+
+typedef enum {
+    CAL_OP_INVALID,
+    CAL_OP_RUN_DONE,
+    CAL_OP_QUIT,
+} CalMessage;
+
+static void dump_scheduler(gpointer data, gpointer user)
+{
+    SimCalendarEntry *entry = data;
+
+    DPRINT("<CAL>| %.20lld | %s\n", entry->time, entry->name);
+}
+
+static void dump_calendar(void)
+{
+    DPRINT("<CAL>|----------- calendar state at %lld\n", simtime);
+    g_sequence_foreach(calendar, dump_scheduler, NULL);
+}
+
+unsigned long long calendar_get_time(void)
+{
+    return simtime;
+}
+
+static void count_clients(gpointer data, gpointer user)
+{
+    SimCalendarEntry *entry = data;
+    unsigned int *count = user;
+
+    if (entry->client) {
+        (*count)++;
+    }
+}
+
+static unsigned long long calendar_get_next_time(void)
+{
+    GSequenceIter *first;
+
+    first = g_sequence_get_iter_at_pos(calendar, 0);
+    if (!g_sequence_iter_is_end(first)) {
+        SimCalendarEntry *next = g_sequence_get(first);
+        return next->time;
+    }
+
+    return (unsigned long long)-1;
+}
+
+void calendar_set_time(unsigned long long time)
+{
+    g_assert(time >= simtime);
+    G_LOCK(calendar);
+    if (time > calendar_get_next_time()) {
+        dump_calendar();
+        DPRINT("CAL: setting time to %lld which is > %lld\n",
+                time, calendar_get_next_time());
+        g_assert(0);
+    }
+    simtime = time;
+    G_UNLOCK(calendar);
+}
+
+static void calendar_schedule(void)
+{
+    GSequenceIter *first;
+    SimCalendarEntry *entry;
+    unsigned long long nexttime;
+
+    G_LOCK(calendar);
+    if (CAL_DEBUG) {
+        dump_calendar();
+    }
+
+    if (!scheduling) {
+        unsigned int count = 0;
+
+        g_sequence_foreach(calendar, count_clients, &count);
+
+        if (count < required_clients) {
+            G_UNLOCK(calendar);
+            return;
+        }
+        scheduling = true;
+    }
+
+    first = g_sequence_get_iter_at_pos(calendar, 0);
+    if (g_sequence_iter_is_end(first)) {
+        /* Everything disappeared, stop the simulation. */
+        g_async_queue_push(queue, (void *)CAL_OP_QUIT);
+        G_UNLOCK(calendar);
+        return;
+    }
+
+    entry = g_sequence_get(first);
+    g_sequence_remove(first);
+    entry->iter = NULL;
+    simtime = entry->time;
+    entry->running = true;
+    running_clients++;
+
+    nexttime = calendar_get_next_time();
+    running_entry = entry;
+    G_UNLOCK(calendar);
+
+    if (entry->update_until) {
+        DPRINT("update %s to be free until %lld\n", entry->name, nexttime);
+        entry->update_until(entry, nexttime);
+    }
+    entry->callback(entry);
+}
+
+static int entry_cmp_func(gconstpointer _a, gconstpointer _b, gpointer data)
+{
+    const SimCalendarEntry *a = _a;
+    const SimCalendarEntry *b = _b;
+
+    if (a->time == b->time) {
+        return 0;
+    }
+
+    if (a->time < b->time) {
+        return -1;
+    }
+
+    return 1;
+}
+
+void calendar_entry_add_unless_present(SimCalendarEntry *entry,
+                                       unsigned long long time)
+{
+    G_LOCK(calendar);
+    if (!entry->iter) {
+        entry->time = time;
+        entry->iter = g_sequence_insert_sorted(calendar, entry,
+                                               entry_cmp_func, NULL);
+        g_assert(entry->iter);
+        dump_calendar();
+        if (running_entry && entry != running_entry && running_entry->update_until) {
+            unsigned long long nexttime = calendar_get_next_time();
+
+            DPRINT("update %s to be free until %lld (due to add unless of %s)\n", running_entry->name, nexttime, entry->name);
+            running_entry->update_until(running_entry, nexttime);
+        } else {
+            DPRINT("no update for running entry %s\n", running_entry ? running_entry->name : "<none>");
+        }
+    }
+    G_UNLOCK(calendar);
+}
+
+void calendar_entry_add(SimCalendarEntry *entry)
+{
+    G_LOCK(calendar);
+    g_assert(!entry->iter);
+    entry->iter = g_sequence_insert_sorted(calendar, entry,
+                                           entry_cmp_func, NULL);
+    g_assert(entry->iter);
+    dump_calendar();
+    if (running_entry && entry != running_entry &&
+        running_entry->update_until) {
+        unsigned long long nexttime = calendar_get_next_time();
+
+        DPRINT("update %s to be free until %lld (due to add of %s)\n", running_entry->name, nexttime, entry->name);
+        running_entry->update_until(running_entry, nexttime);
+    } else {
+        DPRINT("no update for running entry %s\n", running_entry ? running_entry->name : "<none>");
+    }
+    G_UNLOCK(calendar);
+}
+
+static void _calendar_run_done(SimCalendarEntry *entry)
+{
+    /*
+     * This will happen while new clients join the
+     * simulation and go into wait - their events
+     * will be marked as "done" even though they
+     * never started ...
+     * Currently we don't let any clients join the
+     * simulation after it has started, but that's
+     * not really controllable anyway, so better.
+     */
+    if (scheduling) {
+        g_assert(entry->running);
+        entry->running = false;
+        running_clients--;
+        g_assert(running_clients == 0);
+    }
+    g_async_queue_push(queue, (void *)CAL_OP_RUN_DONE);
+}
+
+static bool _calendar_entry_remove(SimCalendarEntry *entry)
+{
+    if (entry->iter) {
+        g_sequence_remove(entry->iter);
+        entry->iter = NULL;
+        return true;
+    }
+
+    return false;
+}
+
+bool calendar_entry_remove(SimCalendarEntry *entry)
+{
+    bool scheduled;
+
+    G_LOCK(calendar);
+    scheduled = _calendar_entry_remove(entry);
+    G_UNLOCK(calendar);
+
+    return scheduled;
+}
+
+void calendar_run_done(SimCalendarEntry *entry)
+{
+    G_LOCK(calendar);
+    _calendar_run_done(entry);
+    G_UNLOCK(calendar);
+}
+
+void calendar_entry_destroy(SimCalendarEntry *entry)
+{
+    G_LOCK(calendar);
+    if (running_entry == entry) {
+        running_entry = NULL;
+    }
+    if (entry->running) {
+        DPRINT("destroying running client %s\n", entry->name);
+        _calendar_run_done(entry);
+    }
+    _calendar_entry_remove(entry);
+    G_UNLOCK(calendar);
+}
+
+void calendar_init(unsigned int required)
+{
+    calendar = g_sequence_new(NULL);
+    queue = g_async_queue_new();
+    required_clients = required;
+}
+
+void calendar_run(void)
+{
+    while (1) {
+        CalMessage msg = (CalMessage)g_async_queue_pop(queue);
+
+        switch (msg) {
+        case CAL_OP_INVALID:
+            g_assert(0);
+            break;
+        case CAL_OP_RUN_DONE:
+            calendar_schedule();
+            break;
+        case CAL_OP_QUIT:
+            return;
+        }
+    }
+}
diff --git a/contrib/vhost-user-sim/cal.h b/contrib/vhost-user-sim/cal.h
new file mode 100644
index 000000000000..1468ecc4f4eb
--- /dev/null
+++ b/contrib/vhost-user-sim/cal.h
@@ -0,0 +1,45 @@
+/*
+ * vhost-user-sim calendar (header file)
+ *
+ * Copyright (c) 2019 Intel Corporation. All rights reserved.
+ *
+ * Author:
+ *  Johannes Berg <johannes.berg@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 only.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef _SIM_CAL_H
+#define _SIM_CAL_H
+#include <stdbool.h>
+#include <gmodule.h>
+
+typedef struct SimCalendarEntry SimCalendarEntry;
+typedef void (*start_callback_t)(SimCalendarEntry *entry);
+typedef void (*update_until_callback_t)(SimCalendarEntry *entry,
+                                        unsigned long long until);
+
+struct SimCalendarEntry {
+    unsigned long long time;
+    start_callback_t callback;
+    update_until_callback_t update_until;
+    gchar *name;
+    GSequenceIter *iter;
+    bool running;
+    bool client;
+};
+
+void calendar_init(unsigned int required_clients);
+void calendar_run(void);
+
+unsigned long long calendar_get_time(void);
+void calendar_set_time(unsigned long long time);
+void calendar_entry_add(SimCalendarEntry *entry);
+void calendar_entry_add_unless_present(SimCalendarEntry *entry,
+                                       unsigned long long time);
+bool calendar_entry_remove(SimCalendarEntry *entry);
+void calendar_entry_destroy(SimCalendarEntry *entry);
+
+void calendar_run_done(SimCalendarEntry *entry);
+
+#endif /* _SIM_CAL_H */
diff --git a/contrib/vhost-user-sim/main.c b/contrib/vhost-user-sim/main.c
new file mode 100644
index 000000000000..10123b28bb56
--- /dev/null
+++ b/contrib/vhost-user-sim/main.c
@@ -0,0 +1,122 @@
+/*
+ * vhost-user sim main application
+ *
+ * Copyright (c) 2019 Intel Corporation. All rights reserved.
+ *
+ * Author:
+ *  Johannes Berg <johannes.berg@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 only.
+ * See the COPYING file in the top-level directory.
+ */
+#include <gmodule.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include "main.h"
+#include "cal.h"
+
+static int unix_sock_new(const char *unix_fn)
+{
+    int sock;
+    struct sockaddr_un un;
+    size_t len;
+
+    g_assert(unix_fn);
+
+    sock = socket(AF_UNIX, SOCK_STREAM, 0);
+    if (sock <= 0) {
+        perror("socket");
+        g_assert(0);
+        return -1;
+    }
+
+    un.sun_family = AF_UNIX;
+    (void)snprintf(un.sun_path, sizeof(un.sun_path), "%s", unix_fn);
+    len = sizeof(un.sun_family) + strlen(un.sun_path);
+
+    (void)unlink(unix_fn);
+    if (bind(sock, (struct sockaddr *)&un, len) < 0) {
+        perror("bind");
+        goto fail;
+    }
+
+    if (listen(sock, 1) < 0) {
+        perror("listen");
+        goto fail;
+    }
+
+    return sock;
+
+fail:
+    (void)close(sock);
+    g_assert(0);
+    return -1;
+}
+
+static gpointer thread_func(gpointer data)
+{
+    g_main_context_push_thread_default(g_main_loop_get_context(data));
+    g_main_loop_run(data);
+    return NULL;
+}
+
+static GThread *new_device_thread(GIOFunc cb, const char *socket,
+                                  const char *name)
+{
+    GMainContext *ctx = g_main_context_new();
+    GMainLoop *loop = g_main_loop_new(ctx, FALSE);
+    int lsock = unix_sock_new(socket);
+    GIOChannel *chan = g_io_channel_unix_new(lsock);
+    GSource *src = g_io_create_watch(chan, G_IO_IN);
+
+    g_source_set_callback(src, G_SOURCE_FUNC(cb), NULL, NULL);
+    g_source_attach(src, ctx);
+
+    return g_thread_new(name, thread_func, loop);
+}
+
+int main(int argc, char **argv)
+{
+    char *time_socket = NULL, *net_socket = NULL;
+    int opt;
+
+    while ((opt = getopt(argc, argv, "s:n:h")) != -1) {
+        switch (opt) {
+        case 's':
+            time_socket = g_strdup(optarg);
+            break;
+        case 'n':
+            net_socket = g_strdup(optarg);
+            break;
+        case 'h':
+        default:
+            printf("Usage: %s -s time-device-socket [-n net-device-socket] | [ -h ]\n",
+                   argv[0]);
+            return 0;
+        }
+    }
+
+    g_assert(time_socket);
+#define N_CLIENTS 2
+    fprintf(stderr,
+            "============ starting up simulation, requires %d clients ============\n",
+            N_CLIENTS);
+
+    calendar_init(N_CLIENTS);
+
+    new_device_thread(simtime_client_connected, time_socket, "time");
+    if (net_socket) {
+        new_device_thread(vu_net_client_connected, net_socket, "net");
+    }
+
+    calendar_run();
+
+    unlink(time_socket);
+    if (net_socket)
+        unlink(net_socket);
+
+    return 0;
+}
diff --git a/contrib/vhost-user-sim/main.h b/contrib/vhost-user-sim/main.h
new file mode 100644
index 000000000000..9681474581ac
--- /dev/null
+++ b/contrib/vhost-user-sim/main.h
@@ -0,0 +1,22 @@
+/*
+ * vhost-user sim main application header file
+ *
+ * Copyright (c) 2019 Intel Corporation. All rights reserved.
+ *
+ * Author:
+ *  Johannes Berg <johannes.berg@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 only.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef _SIM_MAIN_H
+#define _SIM_MAIN_H
+
+gboolean simtime_client_connected(GIOChannel *src,
+                                  GIOCondition cond,
+                                  gpointer data);
+gboolean vu_net_client_connected(GIOChannel *src,
+                                 GIOCondition cond,
+                                 gpointer data);
+
+#endif /* _SIM_MAIN_H */
diff --git a/contrib/vhost-user-sim/net.c b/contrib/vhost-user-sim/net.c
new file mode 100644
index 000000000000..337341f5fdcb
--- /dev/null
+++ b/contrib/vhost-user-sim/net.c
@@ -0,0 +1,246 @@
+/*
+ * vhost-user sim network device
+ *
+ * Copyright (c) 2017 Intel Corporation. All rights reserved.
+ * Copyright (c) 2019 Intel Corporation. All rights reserved.
+ *
+ * Author:
+ *  Johannes Berg <johannes.berg@intel.com>
+ *
+ * This work is based on the "vhost-user-blk" sample code by
+ * Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 only.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "contrib/libvhost-user/libvhost-user-glib.h"
+#include "contrib/libvhost-user/libvhost-user.h"
+#include "qemu/iov.h"
+#include <gmodule.h>
+#include "main.h"
+#include "cal.h"
+
+static unsigned int clients;
+static GList *netdevs;
+G_LOCK_DEFINE(net);
+
+typedef struct VuNetDev {
+    SimCalendarEntry entry;
+    VugDev parent;
+    VuVirtq *rxq, *txq;
+    GSequenceIter *iter;
+    int idx;
+} VuNetDev;
+
+typedef struct VuNetPacket {
+    SimCalendarEntry entry;
+    void *transmitter;
+    int txidx;
+    unsigned int len;
+    char buf[];
+} VuNetPacket;
+
+static void vu_net_panic_cb(VuDev *vu_dev, const char *buf)
+{
+    if (buf) {
+        g_warning("vu_net_panic_cb: %s", buf);
+    }
+}
+
+static void send_to_one(VuNetDev *ndev, VuNetPacket *pkt)
+{
+    VuVirtqElement *elem;
+    VuDev *vu_dev = &ndev->parent.parent;
+
+    elem = vu_queue_pop(vu_dev, ndev->rxq, sizeof(VuVirtqElement));
+    if (!elem) {
+        /* no space on this device, drop the frame for it */
+        fprintf(stderr, "dropped packet to net %d!\n", ndev->idx);
+        return;
+    }
+    fprintf(stderr, "forwarding packet to net %d\n", ndev->idx);
+    g_assert(elem->in_num && !elem->out_num);
+    iov_from_buf(elem->in_sg, elem->in_num, 0, pkt->buf, pkt->len);
+
+    vu_queue_push(vu_dev, ndev->rxq, elem, pkt->len);
+    /* this _sync is key so the recipient can request scheduler time */
+    vu_queue_notify_sync(vu_dev, ndev->rxq);
+
+    free(elem);
+}
+
+static void vu_netpkt_calendar_cb(SimCalendarEntry *entry)
+{
+    VuNetPacket *pkt = container_of(entry, VuNetPacket, entry);
+    /* send to all devices */
+    GList *l;
+
+    G_LOCK(net);
+    for (l = netdevs; l; l = l->next) {
+        if (l->data != pkt->transmitter) {
+            send_to_one(l->data, pkt);
+        }
+    }
+    G_UNLOCK(net);
+
+    calendar_run_done(&pkt->entry);
+    g_free((void *)pkt->entry.name);
+    g_free(pkt);
+}
+
+static int vu_net_virtio_process_pkt(VuNetDev *ndev)
+{
+    VuVirtq *vq = ndev->txq;
+    VugDev *gdev = &ndev->parent;
+    VuDev *vu_dev = &gdev->parent;
+    VuVirtqElement *elem;
+    VuNetPacket *pkt;
+    ssize_t sz;
+
+    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement));
+    if (!elem) {
+        return -1;
+    }
+
+    g_assert(elem->out_num);
+
+    sz = iov_size(elem->out_sg, elem->out_num);
+    pkt = g_malloc(sizeof(*pkt) + sz);
+    pkt->entry.time = calendar_get_time() + 50 * 1000 * 1000; /* 50ms */
+    pkt->entry.callback = vu_netpkt_calendar_cb;
+    pkt->entry.name = g_strdup_printf("packet from %d", ndev->idx);
+    pkt->len = sz;
+    pkt->transmitter = ndev;
+    pkt->txidx = ndev->idx;
+    iov_to_buf(elem->out_sg, elem->out_num, 0, pkt->buf, sz);
+    calendar_entry_add(&pkt->entry);
+
+    vu_queue_push(vu_dev, vq, elem, 0);
+    /* the reclaim interrupt should also be predictable, so _sync() */
+    vu_queue_notify_sync(vu_dev, vq);
+
+    return 0;
+}
+
+static void vu_netdev_calendar_cb(SimCalendarEntry *entry)
+{
+    VuNetDev *ndev = container_of(entry, VuNetDev, entry);
+    int ret;
+
+    G_LOCK(net);
+    fprintf(stderr, "NET: handle TX IRQ from net %d\n", ndev->idx);
+    /* here we handle TX from the VQ */
+    do {
+        ret = vu_net_virtio_process_pkt(ndev);
+    } while (!ret);
+    fprintf(stderr, "NET: handle TX from net %d completed\n", ndev->idx);
+    G_UNLOCK(net);
+
+    calendar_run_done(entry);
+}
+
+static uint64_t vu_net_get_protocol_features(VuDev *dev)
+{
+    return 1ULL << VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS;
+}
+
+static void vu_net_process_vq(VuDev *vu_dev, int idx)
+{
+    VugDev *gdev = container_of(vu_dev, VugDev, parent);
+    VuNetDev *ndev = container_of(gdev, VuNetDev, parent);
+
+    assert(vu_dev && ndev);
+
+    fprintf(stderr, "insert IRQ from %s at %lld\n", ndev->entry.name, calendar_get_time());
+
+    /* insert the calendar entry to handle the interrupt */
+    calendar_entry_add_unless_present(&ndev->entry, calendar_get_time());
+}
+
+static void vu_net_queue_set_started(VuDev *vu_dev, int idx, bool started)
+{
+    VugDev *gdev = container_of(vu_dev, VugDev, parent);
+    VuNetDev *ndev = container_of(gdev, VuNetDev, parent);
+    VuVirtq *vq;
+
+    assert(vu_dev);
+
+    vq = vu_get_queue(vu_dev, idx);
+    /* set up the read fd */
+    switch (idx) {
+    case 0:
+        ndev->rxq = vq;
+        break;
+    case 1:
+        ndev->txq = vq;
+        vu_set_queue_handler(vu_dev, vq, started ? vu_net_process_vq : NULL);
+        break;
+    }
+}
+
+static int
+vu_net_process_msg(VuDev *vu_dev, VhostUserMsg *msg, int *do_reply)
+{
+    VugDev *gdev = container_of(vu_dev, VugDev, parent);
+    VuNetDev *ndev = container_of(gdev, VuNetDev, parent);
+
+    if (msg->request != VHOST_USER_NONE) {
+        return 0;
+    }
+
+    *do_reply = 0;
+    fprintf(stderr, "net client %d disconnected\n", ndev->idx);
+
+    G_LOCK(net);
+    netdevs = g_list_remove(netdevs, ndev);
+    clients--;
+
+    vug_deinit(gdev);
+    G_UNLOCK(net);
+    calendar_entry_destroy(&ndev->entry);
+    g_free((void *)ndev->entry.name);
+    g_free(ndev);
+
+    return 1;
+}
+
+static const VuDevIface vu_net_iface = {
+    .queue_set_started = vu_net_queue_set_started,
+    .get_protocol_features = vu_net_get_protocol_features,
+    .process_msg = vu_net_process_msg,
+};
+
+gboolean vu_net_client_connected(GIOChannel *src,
+                                 GIOCondition cond,
+                                 gpointer data)
+{
+    int lsock = g_io_channel_unix_get_fd(src);
+    int csock = accept(lsock, NULL, NULL);
+    VuNetDev *ndev;
+
+    if (csock < 0) {
+        fprintf(stderr, "Accept error %s\n", strerror(errno));
+        return TRUE;
+    }
+
+    ndev = g_new0(VuNetDev, 1);
+    if (!ndev) {
+        return TRUE;
+    }
+
+    clients++;
+    ndev->idx = clients;
+    ndev->entry.name = g_strdup_printf("net-irq %d", clients);
+    ndev->entry.callback = vu_netdev_calendar_cb;
+    vug_init(&ndev->parent, 2, csock, vu_net_panic_cb,
+             &vu_net_iface);
+    fprintf(stderr, "net client %d connected\n", clients);
+
+    G_LOCK(net);
+    netdevs = g_list_prepend(netdevs, ndev);
+    G_UNLOCK(net);
+
+    return TRUE;
+}
diff --git a/contrib/vhost-user-sim/simtime.c b/contrib/vhost-user-sim/simtime.c
new file mode 100644
index 000000000000..96bd7863790a
--- /dev/null
+++ b/contrib/vhost-user-sim/simtime.c
@@ -0,0 +1,267 @@
+/*
+ * vhost-user simtime device application
+ *
+ * Copyright (c) 2017 Intel Corporation. All rights reserved.
+ * Copyright (c) 2019 Intel Corporation. All rights reserved.
+ *
+ * Author:
+ *  Johannes Berg <johannes.berg@intel.com>
+ *
+ * This work is based on the "vhost-user-blk" sample code by
+ * Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 only.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "standard-headers/linux/um_timetravel.h"
+#include "cal.h"
+#include "main.h"
+
+#define DEBUG 1
+#define DPRINT(...) do {              \
+    if (DEBUG) {                      \
+        fprintf(stderr, __VA_ARGS__); \
+        fflush(stderr);               \
+    }                                 \
+} while (0)
+
+typedef struct SimTimeConnection {
+    GMutex lock;
+    __u64 offset;
+    GIOChannel *chan;
+    GMainLoop *loop;
+    int idx;
+    SimCalendarEntry entry;
+    unsigned long long num_requests, num_waits, num_updates;
+    bool waiting;
+} SimTimeConnection;
+
+static int clients;
+
+static const char *simtime_op_str(uint64_t op)
+{
+#define OPSTR(x) case UM_TIMETRAVEL_##x: return "UM_TIMETRAVEL_" #x
+    switch (op) {
+    OPSTR(ACK);
+    OPSTR(REQUEST);
+    OPSTR(WAIT);
+    OPSTR(GET);
+    OPSTR(UPDATE);
+    OPSTR(RUN);
+    OPSTR(FREE_UNTIL);
+    default:
+        return "unknown";
+    }
+}
+
+static int full_read(int fd, void *_buf, size_t len)
+{
+    unsigned char *buf = _buf;
+    ssize_t ret;
+
+    do {
+        ret = read(fd, buf, len);
+        if (ret > 0) {
+            buf += ret;
+            len -= ret;
+        } else if (ret == 0) {
+            return 0;
+        } else {
+            return -errno;
+        }
+    } while (len > 0);
+
+    return buf - (unsigned char *)_buf;
+}
+
+static int full_write(int fd, const void *_buf, size_t len)
+{
+    const unsigned char *buf = _buf;
+    ssize_t ret;
+
+    do {
+        ret = write(fd, buf, len);
+        if (ret > 0) {
+            buf += ret;
+            len -= ret;
+        } else if (ret == 0) {
+            return 0;
+        } else {
+            return -errno;
+        }
+    } while (len > 0);
+
+    return buf - (const unsigned char *)_buf;
+}
+
+static void simtime_handle_message(SimTimeConnection *conn,
+                                   struct um_timetravel_msg *msg)
+{
+    struct um_timetravel_msg resp = {
+        .op = UM_TIMETRAVEL_ACK,
+    };
+
+    DPRINT(" %d | message %s (%lld, time=%lld)\n",
+           conn->idx, simtime_op_str(msg->op), msg->op, msg->time);
+
+    switch (msg->op) {
+    case UM_TIMETRAVEL_REQUEST:
+        if (calendar_entry_remove(&conn->entry)) {
+            conn->entry.time = conn->offset + msg->time;
+            calendar_entry_add(&conn->entry);
+            DPRINT(" %d | calendar entry added for %lld\n", conn->idx, msg->time);
+        } else {
+            conn->entry.time = conn->offset + msg->time;
+            DPRINT(" %d | calendar entry time updated for %lld\n", conn->idx, msg->time);
+        }
+        conn->num_requests++;
+        break;
+    case UM_TIMETRAVEL_WAIT:
+        conn->num_waits++;
+        calendar_entry_add(&conn->entry);
+        calendar_run_done(&conn->entry);
+        break;
+    case UM_TIMETRAVEL_GET:
+        resp.time = calendar_get_time() - conn->offset;
+        DPRINT(" %d | returning time %lld\n", conn->idx, resp.time);
+        break;
+    case UM_TIMETRAVEL_UPDATE:
+        if (conn->offset + msg->time > conn->entry.time) {
+            calendar_entry_remove(&conn->entry);
+        }
+        calendar_set_time(conn->offset + msg->time);
+        conn->num_updates++;
+        break;
+    default:
+        printf("ignoring invalid message %llu (time %llu)\n",
+               msg->op, msg->time);
+        break;
+    }
+
+    g_assert(full_write(g_io_channel_unix_get_fd(conn->chan), &resp, sizeof(resp)) == sizeof(resp));
+    DPRINT(" %d | sent ACK for message %s (%lld, time %lld)\n", conn->idx, simtime_op_str(msg->op), msg->op, msg->time);
+}
+
+static void simtime_send_message(SimTimeConnection *conn,
+                                 struct um_timetravel_msg *msg)
+{
+    g_mutex_lock(&conn->lock);
+    DPRINT(" %d | send %s (%lld, time=%lld)\n",
+           conn->idx, simtime_op_str(msg->op), msg->op, msg->time);
+    g_io_channel_set_flags(conn->chan, 0, NULL);
+    g_assert(full_write(g_io_channel_unix_get_fd(conn->chan), msg, sizeof(*msg)) == sizeof(*msg));
+    do {
+        g_assert(full_read(g_io_channel_unix_get_fd(conn->chan), msg, sizeof(*msg)) == sizeof(*msg));
+        DPRINT(" %d | read %s (%lld, time=%lld), expecting ACK (0)\n",
+               conn->idx, simtime_op_str(msg->op), msg->op, msg->time);
+        if (msg->op == UM_TIMETRAVEL_ACK)
+            break;
+        simtime_handle_message(conn, msg);
+    } while (1);
+    g_io_channel_set_flags(conn->chan, G_IO_FLAG_NONBLOCK, NULL);
+    g_mutex_unlock(&conn->lock);
+}
+
+static void simtime_calendar_cb(SimCalendarEntry *entry)
+{
+    SimTimeConnection *conn = container_of(entry, SimTimeConnection, entry);
+    struct um_timetravel_msg msg = {
+        .op = UM_TIMETRAVEL_RUN,
+        .time = entry->time - conn->offset,
+    };
+
+    simtime_send_message(conn, &msg);
+}
+
+static void __attribute__((used))
+simtime_update_until_cb(SimCalendarEntry *entry, unsigned long long time)
+{
+    SimTimeConnection *conn = container_of(entry, SimTimeConnection, entry);
+    struct um_timetravel_msg msg = {
+        .op = UM_TIMETRAVEL_FREE_UNTIL,
+        .time = time - conn->offset,
+    };
+
+    simtime_send_message(conn, &msg);
+}
+
+static gboolean simtime_read_cb(GIOChannel *src, GIOCondition c, gpointer data)
+{
+    SimTimeConnection *conn = data;
+    int fd = g_io_channel_unix_get_fd(src);
+    struct um_timetravel_msg msg;
+    int bytes;
+
+    g_mutex_lock(&conn->lock);
+    DPRINT(" %d | locked connection for reading\n", conn->idx);
+    bytes = full_read(fd, &msg, sizeof(msg));
+    if (bytes < 0 && bytes == -EAGAIN) {
+        g_mutex_unlock(&conn->lock);
+        return TRUE;
+    }
+    if (bytes <= 0) {
+        clients--;
+        printf("client disconnected, made %lld requests and waited %lld times, sent %lld updates\n",
+               conn->num_requests, conn->num_waits, conn->num_updates);
+        printf("we now have %d clients left\n", clients);
+
+        calendar_entry_destroy(&conn->entry);
+        // leak for now ... source is still attached
+        //g_free(conn);
+        g_mutex_unlock(&conn->lock);
+        return FALSE;
+    }
+    g_assert(bytes == sizeof(msg));
+
+    simtime_handle_message(conn, &msg);
+    g_mutex_unlock(&conn->lock);
+    DPRINT(" %d | unlocked connection\n", conn->idx);
+    return TRUE;
+}
+
+gboolean simtime_client_connected(GIOChannel *listen_src,
+                                  GIOCondition cond,
+                                  gpointer data)
+{
+    int lsock = g_io_channel_unix_get_fd(listen_src);
+    int csock = accept(lsock, NULL, NULL);
+    SimTimeConnection *conn;
+    GSource *src;
+
+    if (csock < 0) {
+        fprintf(stderr, "Accept error %s\n", strerror(errno));
+        return TRUE;
+    }
+
+    conn = g_new0(SimTimeConnection, 1);
+    if (!conn) {
+        return TRUE;
+    }
+
+    g_mutex_init(&conn->lock);
+
+    conn->chan = g_io_channel_unix_new(csock);
+    g_io_channel_set_flags(conn->chan, G_IO_FLAG_NONBLOCK, NULL);
+    src = g_io_create_watch(conn->chan, G_IO_IN);
+    g_source_set_callback(src, G_SOURCE_FUNC(simtime_read_cb), conn, NULL);
+    g_source_attach(src, g_main_context_get_thread_default());
+
+    conn->entry.callback = simtime_calendar_cb;
+    conn->entry.update_until = simtime_update_until_cb;
+    /*
+     * Mark this as a real scheduling client for purposes of
+     * tracking the number of them connected to the sim.
+     */
+    conn->entry.client = true;
+
+    clients++;
+    printf("client connected (now have %d)\n", clients);
+
+    conn->offset = calendar_get_time();
+    conn->idx = clients;
+    conn->entry.name = g_strdup_printf("time %d", clients);
+
+    return TRUE;
+}
diff --git a/include/standard-headers/linux/um_timetravel.h b/include/standard-headers/linux/um_timetravel.h
new file mode 100644
index 000000000000..3aaced426a92
--- /dev/null
+++ b/include/standard-headers/linux/um_timetravel.h
@@ -0,0 +1,107 @@
+/*
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ * Copyright (C) 2019 Intel Corporation
+ */
+#ifndef _UAPI_LINUX_UM_TIMETRAVEL_H
+#define _UAPI_LINUX_UM_TIMETRAVEL_H
+#include <linux/types.h>
+
+/**
+ * struct um_timetravel_msg - UM time travel message
+ *
+ * This is the basic message type, going in both directions.
+ *
+ * This is the message passed between the host (user-mode Linux instance)
+ * and the calendar (the application on the other side of the socket) in
+ * order to implement common scheduling.
+ *
+ * Whenever UML has an event it will request runtime for it from the
+ * calendar, and then wait for its turn until it can run, etc. Note
+ * that it will only ever request the single next runtime, i.e. multiple
+ * REQUEST messages override each other.
+ */
+struct um_timetravel_msg {
+	/**
+	 * @op: operation value from &enum um_timetravel_ops
+	 */
+	__u64 op;
+
+	/**
+	 * @time: time in nanoseconds
+	 */
+	__u64 time;
+};
+
+/**
+ * enum um_timetravel_ops - Operation codes
+ */
+enum um_timetravel_ops {
+	/**
+	 * @UM_TIMETRAVEL_ACK: response (ACK) to any previous message,
+	 *	this usually doesn't carry any data in the 'time' field
+	 *	unless otherwise specified below
+	 */
+	UM_TIMETRAVEL_ACK		= 0,
+
+	/**
+	 * @UM_TIMETRAVEL_REQUEST: request to run at the given time
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_REQUEST		= 1,
+
+	/**
+	 * @UM_TIMETRAVEL_WAIT: Indicate waiting for the previously requested
+	 *	runtime, new requests may be made while waiting (e.g. due to
+	 *	interrupts); the time field is ignored. The calendar must process
+	 *	this message and later	send a %UM_TIMETRAVEL_RUN message when
+	 *	the host can run again.
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_WAIT		= 2,
+
+	/**
+	 * @UM_TIMETRAVEL_GET: return the current time from the calendar in the
+	 *	ACK message, the time in the request message is ignored
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_GET		= 3,
+
+	/**
+	 * @UM_TIMETRAVEL_UPDATE: time update to the calendar, must be sent e.g.
+	 *	before kicking an interrupt to another calendar
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_UPDATE		= 4,
+
+	/**
+	 * @UM_TIMETRAVEL_RUN: run time request granted, current time is in
+	 *	the time field
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_RUN		= 5,
+
+	/**
+	 * @UM_TIMETRAVEL_FREE_UNTIL: Enable free-running until the given time,
+	 *	this is a message from the calendar telling the host that it can
+	 *	freely do its own scheduling for anything before the indicated
+	 *	time.
+	 *	Note that if a calendar sends this message once, the host may
+	 *	assume that it will also do so in the future, if it implements
+	 *	wraparound semantics for the time field.
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_FREE_UNTIL	= 6,
+};
+
+#endif /* _UAPI_LINUX_UM_TIMETRAVEL_H */
-- 
2.20.1


