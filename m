Received: from eggs.gnu.org ([2001:4830:134:3::10]:52305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafh-00043n-Uz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafd-0001Pg-Vy
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafd-0001PN-NI
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB1FD80F98
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:06:04 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:25 -0400
Message-Id: <1495649128-10529-10-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 09/12] hmp: add announce paraters info/set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Add HMP command to control and read annoucment parameters.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 hmp-commands-info.hx | 13 ++++++++
 hmp-commands.hx      | 14 +++++++++
 hmp.c                | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hmp.h                |  4 +++
 monitor.c            | 18 +++++++++++
 5 files changed, 135 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ae16901..7f1f0f1 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -830,6 +830,19 @@ ETEXI
     },
 
 STEXI
+@item info announce_parameters
+@findex announce_parameters
+Show current RARP/GARP announce parameters.
+ETEXI
+    {
+        .name       = "announce_parameters",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show current RARP/GARP announce parameters",
+        .cmd        = hmp_info_announce_parameters,
+    },
+
+STEXI
 @end table
 ETEXI
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 0aca984..c8dd816 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -921,7 +921,21 @@ character code in hexadecimal.  Character \ is printed \\.
 Bug: can screw up when the buffer contains invalid UTF-8 sequences,
 NUL characters, after the ring buffer lost data, and when reading
 stops because the size limit is reached.
+ETEXI
 
+    {
+        .name       = "announce_set_parameter",
+        .args_type  = "parameter:s,value:s",
+        .params     = "parameter value",
+        .help       = "Set the parameter for GARP/RARP announcements",
+        .cmd        = hmp_announce_set_parameter,
+        .command_completion = announce_set_parameter_completion,
+    },
+
+STEXI
+@item announce_set_parameter @var{parameter} @var{value}
+@findex announce_set_parameter
+Set the parameter @var{parameter} for GARP/RARP announcements.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 3dceaf8..7d41783 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1449,6 +1449,66 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 
 }
 
+void hmp_announce_set_parameter(Monitor *mon, const QDict *qdict)
+{
+    const char *param = qdict_get_str(qdict, "parameter");
+    const char *valuestr = qdict_get_str(qdict, "value");
+    Error *err = NULL;
+    bool use_int_value = false;
+    int64_t  *set;
+    int i;
+
+    for (i = 0; i < ANNOUNCE_PARAMETER__MAX; i++) {
+        if (strcmp(param, AnnounceParameter_lookup[i]) == 0) {
+            AnnounceParameters p = { 0 };
+            switch (i) {
+            case ANNOUNCE_PARAMETER_INITIAL:
+                p.has_initial = true;
+                use_int_value = true;
+                set = &p.initial;
+                break;
+            case ANNOUNCE_PARAMETER_MAX:
+                p.has_max = true;
+                use_int_value = true;
+                set = &p.max;
+                break;
+            case ANNOUNCE_PARAMETER_ROUNDS:
+                p.has_rounds = true;
+                use_int_value = true;
+                set = &p.rounds;
+                break;
+            case ANNOUNCE_PARAMETER_STEP:
+                p.has_step = true;
+                use_int_value = true;
+                set = &p.step;
+                break;
+            }
+
+            if (use_int_value) {
+                long valueint = 0;
+                if (qemu_strtol(valuestr, NULL, 10, &valueint) < 0) {
+                    error_setg(&err, "Unable to parse '%s' as an int",
+                               valuestr);
+                    goto cleanup;
+                }
+                *set = valueint;
+            }
+
+            qmp_announce_set_parameters(&p, &err);
+            break;
+        }
+    }
+
+    if (i == ANNOUNCE_PARAMETER__MAX) {
+        error_setg(&err, QERR_INVALID_PARAMETER, param);
+    }
+
+ cleanup:
+    if (err) {
+        error_report_err(err);
+    }
+}
+
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
@@ -2801,3 +2861,29 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
     qapi_free_GuidInfo(info);
 }
+
+void hmp_info_announce_parameters(Monitor *mon, const QDict *qdict)
+{
+    AnnounceParameters *params;
+
+    params = qmp_query_announce_parameters(NULL);
+
+    if (params) {
+        assert(params->has_initial);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            AnnounceParameter_lookup[ANNOUNCE_PARAMETER_INITIAL],
+            params->initial);
+        assert(params->has_max);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            AnnounceParameter_lookup[ANNOUNCE_PARAMETER_MAX],
+            params->max);
+        assert(params->has_rounds);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            AnnounceParameter_lookup[ANNOUNCE_PARAMETER_ROUNDS],
+            params->rounds);
+        assert(params->has_step);
+        monitor_printf(mon, "%s: %" PRId64 "\n",
+            AnnounceParameter_lookup[ANNOUNCE_PARAMETER_STEP],
+            params->step);
+    }
+}
diff --git a/hmp.h b/hmp.h
index d8b94ce..adf017c 100644
--- a/hmp.h
+++ b/hmp.h
@@ -67,6 +67,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
+void hmp_announce_set_parameter(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
 void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
@@ -130,6 +131,8 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
                                        const char *str);
 void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
                                       const char *str);
+void announce_set_parameter_completion(ReadLineState *rs, int nb_args,
+                                      const char *str);
 void host_net_add_completion(ReadLineState *rs, int nb_args, const char *str);
 void host_net_remove_completion(ReadLineState *rs, int nb_args,
                                 const char *str);
@@ -143,5 +146,6 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
+void hmp_info_announce_parameters(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/monitor.c b/monitor.c
index afbacfe..cb2c407 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3563,6 +3563,24 @@ void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
     }
 }
 
+void announce_set_parameter_completion(ReadLineState *rs, int nb_args,
+                                      const char *str)
+{
+    size_t len;
+
+    len = strlen(str);
+    readline_set_completion_index(rs, len);
+    if (nb_args == 2) {
+        int i;
+        for (i = 0; i < ANNOUNCE_PARAMETER__MAX; i++) {
+            const char *name = AnnounceParameter_lookup[i];
+            if (!strncmp(str, name, len)) {
+                readline_add_completion(rs, name);
+            }
+        }
+    }
+}
+
 void host_net_add_completion(ReadLineState *rs, int nb_args, const char *str)
 {
     int i;
-- 
2.7.4
