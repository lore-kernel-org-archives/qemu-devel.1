Received: from eggs.gnu.org ([2001:4830:134:3::10]:54996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlq-0005tz-8Y
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlp-0008Fu-Dt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:21 -0300
Message-Id: <20170727024224.22900-17-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 17/20] bt-sdp: fix memory leak in
 sdp_service_record_build()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

hw/bt/sdp.c:753:5: warning: Potential leak of memory pointed to by 'data'
    qsort(record->attribute_list, record->attributes,
    ^~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
hw/bt/*:
get_maintainer.pl: No maintainers found

 hw/bt/sdp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index f67b3b89c0..7b2186e1f4 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -711,7 +711,7 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
                 struct sdp_def_service_s *def, int handle)
 {
     int len = 0;
-    uint8_t *data;
+    uint8_t *buf, *data;
     int *uuid;
 
     record->uuids = 0;
@@ -725,7 +725,8 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
             g_malloc0(record->attributes * sizeof(*record->attribute_list));
     record->uuid =
             g_malloc0(record->uuids * sizeof(*record->uuid));
-    data = g_malloc(len);
+    buf = g_malloc(len);
+    data = buf;
 
     record->attributes = 0;
     uuid = record->uuid;
@@ -748,6 +749,7 @@ static void sdp_service_record_build(struct sdp_service_record_s *record,
         record->attribute_list[record->attributes ++].len = len;
         data += len;
     }
+    g_free(buf);
 
     /* Sort the attribute list by the AttributeID */
     qsort(record->attribute_list, record->attributes,
-- 
2.13.3
