Received: from eggs.gnu.org ([2001:4830:134:3::10]:49341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcZ-0007f8-8p
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcW-00054C-Lw
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:05 -0500
Message-Id: <20180327143014.1767669-6-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] qdict: remove useless cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:NVMe Block Driver" <qemu-block@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Re-run Coccinelle script scripts/coccinelle/qobject.cocci

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20180323143202.28879-5-lvivier@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nvme.c | 11 +++++------
 monitor.c    |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8bca57aae69..c4f3a7bc94a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -695,12 +695,11 @@ static void nvme_parse_filename(const char *filename, QDict *options,
         unsigned long ns;
         const char *slash = strchr(tmp, '/');
         if (!slash) {
-            qdict_put(options, NVME_BLOCK_OPT_DEVICE,
-                      qstring_from_str(tmp));
+            qdict_put_str(options, NVME_BLOCK_OPT_DEVICE, tmp);
             return;
         }
         device = g_strndup(tmp, slash - tmp);
-        qdict_put(options, NVME_BLOCK_OPT_DEVICE, qstring_from_str(device));
+        qdict_put_str(options, NVME_BLOCK_OPT_DEVICE, device);
         g_free(device);
         namespace = slash + 1;
         if (*namespace && qemu_strtoul(namespace, NULL, 10, &ns)) {
@@ -708,8 +707,8 @@ static void nvme_parse_filename(const char *filename, QDict *options,
                        namespace);
             return;
         }
-        qdict_put(options, NVME_BLOCK_OPT_NAMESPACE,
-                  qstring_from_str(*namespace ? namespace : "1"));
+        qdict_put_str(options, NVME_BLOCK_OPT_NAMESPACE,
+                      *namespace ? namespace : "1");
     }
 }

@@ -1082,7 +1081,7 @@ static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
                  bs->drv->format_name);
     }

-    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
+    qdict_put_str(opts, "driver", bs->drv->format_name);
     bs->full_open_options = opts;
 }

diff --git a/monitor.c b/monitor.c
index 77f4c41cfa6..de709fc2e5d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4315,7 +4315,7 @@ static QObject *get_qmp_greeting(Monitor *mon)
             /* Monitors that are not using IOThread won't support OOB */
             continue;
         }
-        qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)));
+        qlist_append_str(cap_list, QMPCapability_str(cap));
     }

     return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': %p}}",
-- 
2.14.3
