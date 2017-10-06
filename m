Received: from eggs.gnu.org ([2001:4830:134:3::10]:41158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPB-0007at-3x
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPA-0005IM-AF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:15 -0300
Message-Id: <20171006235023.11952-21-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/88] Migration: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: indented, added migration/migration.c and migration/page_cache.c]
---
 migration/migration.c    | 2 +-
 migration/page_cache.c   | 2 +-
 migration/postcopy-ram.c | 2 +-
 migration/ram.c          | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 98429dc843..4899182b32 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -485,7 +485,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     MigrationState *s = migrate_get_current();
 
     /* TODO use QAPI_CLONE() instead of duplicating it inline */
-    params = g_malloc0(sizeof(*params));
+    params = g_new0(MigrationParameters, 1);
     params->has_compress_level = true;
     params->compress_level = s->parameters.compress_level;
     params->has_compress_threads = true;
diff --git a/migration/page_cache.c b/migration/page_cache.c
index ba984c4858..30169a1dd3 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -57,7 +57,7 @@ PageCache *cache_init(int64_t num_pages, unsigned int page_size)
     }
 
     /* We prefer not to abort if there is no memory */
-    cache = g_try_malloc(sizeof(*cache));
+    cache = g_try_new(PageCache, 1);
     if (!cache) {
         DPRINTF("Failed to allocate cache\n");
         return NULL;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0de68e8b25..d51684ce30 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -811,7 +811,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
                                                  const char *name)
 {
-    PostcopyDiscardState *res = g_malloc0(sizeof(PostcopyDiscardState));
+    PostcopyDiscardState *res = g_new0(PostcopyDiscardState, 1);
 
     if (res) {
         res->ramblock_name = name;
diff --git a/migration/ram.c b/migration/ram.c
index b83f8977c5..3f5407ee43 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1376,8 +1376,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
         goto err;
     }
 
-    struct RAMSrcPageRequest *new_entry =
-        g_malloc0(sizeof(struct RAMSrcPageRequest));
+    struct RAMSrcPageRequest *new_entry = g_new0(struct RAMSrcPageRequest, 1);
     new_entry->rb = ramblock;
     new_entry->offset = start;
     new_entry->len = len;
-- 
2.14.2
