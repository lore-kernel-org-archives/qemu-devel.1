Received: from eggs.gnu.org ([2001:4830:134:3::10]:55057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlt-0005y6-So
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlt-0008I3-47
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:22 -0300
Message-Id: <20170727024224.22900-18-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 18/20] 9pfs: avoid sign conversion
 error simplifying the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

(note this is how other functions also handle the errors).

hw/9pfs/9p.c:948:18: warning: Loss of sign in implicit conversion
        offset = err;
                 ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/9pfs/9p.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 333dbb6f8e..0a37c8bd13 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -945,7 +945,6 @@ static void coroutine_fn v9fs_version(void *opaque)
     v9fs_string_init(&version);
     err = pdu_unmarshal(pdu, offset, "ds", &s->msize, &version);
     if (err < 0) {
-        offset = err;
         goto out;
     }
     trace_v9fs_version(pdu->tag, pdu->id, s->msize, version.data);
@@ -962,13 +961,12 @@ static void coroutine_fn v9fs_version(void *opaque)
 
     err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
     if (err < 0) {
-        offset = err;
         goto out;
     }
-    offset += err;
+    err += offset;
     trace_v9fs_version_return(pdu->tag, pdu->id, s->msize, version.data);
 out:
-    pdu_complete(pdu, offset);
+    pdu_complete(pdu, err);
     v9fs_string_free(&version);
 }
 
-- 
2.13.3
