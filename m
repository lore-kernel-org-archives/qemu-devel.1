Received: from eggs.gnu.org ([2001:4830:134:3::10]:59500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqrQO-0007TG-F3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 22:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqrQJ-0002Mn-HF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 22:57:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 17 Aug 2018 23:56:53 -0300
Message-Id: <20180818025653.21192-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] migration: Replace strncpy() by g_strlcpy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Fedora 29 comes with GCC 8.1 which added the 'stringop-truncation' checks.

Replace the strncpy() calls by g_strlcpy() to avoid the following warning:

  migration/global_state.c: In function 'global_state_store_running':
  migration/global_state.c:45:5: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
       strncpy((char *)global_state.runstate,
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              state, sizeof(global_state.runstate));
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
See http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03723.html

 migration/global_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 8e8ab5c51e..d5df502cd5 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -42,7 +42,7 @@ int global_state_store(void)
 void global_state_store_running(void)
 {
     const char *state = RunState_str(RUN_STATE_RUNNING);
-    strncpy((char *)global_state.runstate,
+    g_strlcpy((char *)global_state.runstate,
            state, sizeof(global_state.runstate));
 }
 
-- 
2.18.0
