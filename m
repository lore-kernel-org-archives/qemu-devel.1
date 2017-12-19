Received: from eggs.gnu.org ([2001:4830:134:3::10]:38917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDap-0002pl-63
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDak-0002DE-BD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:49:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDak-0002CV-4S
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:49:38 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:50 +0800
Message-Id: <20171219084557.9801-21-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 20/27] qmp: export qmp_dispatch_check_obj and
 allow "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

We need this for earlier check for OOB, before reaching
do_qmp_dispatch().  Meanwhile, a small touch-up to allow "id" field,
after all we allow that for sure in the spec (in any form).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qapi/qmp/dispatch.h | 1 +
 qapi/qmp-dispatch.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index b76798800c..cf2657b5c9 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -49,6 +49,7 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QObject *qmp_build_error_object(Error *err);
+QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp);
 
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
 
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b41fa174fe..b16f2f1d3f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -20,7 +20,7 @@
 #include "qapi-types.h"
 #include "qapi/qmp/qerror.h"
 
-static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
+QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
 {
     const QDictEntry *ent;
     const char *arg_name;
@@ -52,6 +52,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
+        } else if (!strcmp(arg_name, "id")) {
+            continue;
         } else {
             error_setg(errp, "QMP input member '%s' is unexpected",
                        arg_name);
-- 
2.14.3
