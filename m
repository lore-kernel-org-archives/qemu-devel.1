Received: from eggs.gnu.org ([2001:4830:134:3::10]:39100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCnaH-0003vg-5B
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCnaC-0007CN-7Y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:18:05 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gCnaB-00078t-OI
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:18:00 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 18:17:38 +0300
Message-Id: <20181017151738.20299-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] scripts: Remove check-qerror.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

qerror.h contains leftovers from the now-defunct QError API.

There's only a handful of string macros left, and no one is supposed
to add anything else. The check-qerror.sh script was used to make sure
that all definitions on the qerror.c and qerror.h files were sorted
alphabetically. The former was removed three years ago, and the latter
is now in a different location, so the script doesn't even work (as
a matter of fact the alphabetical order was broken last time someone
added a macro -also in 2015- and no one seemed to notice).

There's no point in fixing this script so let's just remove it.
The rogue macro is also moved to its correct location.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 include/qapi/qmp/qerror.h |  6 +++---
 scripts/check-qerror.sh   | 22 ----------------------
 2 files changed, 3 insertions(+), 25 deletions(-)
 delete mode 100755 scripts/check-qerror.sh

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 145571f618..7c76e24aa7 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -79,6 +79,9 @@
 #define QERR_QGA_COMMAND_FAILED \
     "Guest agent command failed, error was '%s'"
 
+#define QERR_REPLAY_NOT_SUPPORTED \
+    "Record/replay feature is not supported for '%s'"
+
 #define QERR_SET_PASSWD_FAILED \
     "Could not set password"
 
@@ -88,7 +91,4 @@
 #define QERR_UNSUPPORTED \
     "this feature or command is not currently supported"
 
-#define QERR_REPLAY_NOT_SUPPORTED \
-    "Record/replay feature is not supported for '%s'"
-
 #endif /* QERROR_H */
diff --git a/scripts/check-qerror.sh b/scripts/check-qerror.sh
deleted file mode 100755
index af7fbd5249..0000000000
--- a/scripts/check-qerror.sh
+++ /dev/null
@@ -1,22 +0,0 @@
-#!/bin/sh
-# This script verifies that qerror definitions and table entries are
-# alphabetically ordered.
-
-check_order() {
-  errmsg=$1
-  shift
-
-  # sort -C verifies order but does not print a message.  sort -c does print a
-  # message.  These options are both in POSIX.
-  if ! "$@" | sort -C; then
-    echo "$errmsg"
-    "$@" | sort -c
-    exit 1
-  fi
-  return 0
-}
-
-check_order 'Definitions in qerror.h must be in alphabetical order:' \
-            grep '^#define QERR_' qerror.h
-check_order 'Entries in qerror.c:qerror_table must be in alphabetical order:' \
-            sed -n '/^static.*qerror_table\[\]/,/^};/s/QERR_/&/gp' qerror.c
-- 
2.11.0
