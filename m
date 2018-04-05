Received: from eggs.gnu.org ([2001:4830:134:3::10]:55858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcJ-00054J-9A
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcH-00031Z-IF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:07 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcH-00031O-CB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:05 -0400
Received: by mail-qk0-x242.google.com with SMTP id 132so24686791qkd.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 18:23:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Apr 2018 22:22:41 -0300
Message-Id: <20180405012241.25714-5-f4bug@amsat.org>
In-Reply-To: <20180405012241.25714-1-f4bug@amsat.org>
References: <20180405012241.25714-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 4/4] memory: Add
 memory_region_set_priority()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Sadly I'm missing something, this does not work.

 memory.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index eaa5fa7f23..ae45ea7779 100644
--- a/memory.c
+++ b/memory.c
@@ -1225,6 +1225,22 @@ static void memory_region_get_priority(Object *obj, Visitor *v,
     visit_type_int32(v, name, &value, errp);
 }
 
+static void memory_region_set_priority(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    int32_t priority;
+    Error *local_err = NULL;
+
+    visit_type_int32(v, name, &priority, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    mr->priority = priority;
+}
+
 static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -1260,7 +1276,7 @@ static void memory_region_initfn(Object *obj)
                         NULL, NULL, &error_abort);
     object_property_add(OBJECT(mr), "priority", "int32",
                         memory_region_get_priority,
-                        NULL, /* memory_region_set_priority */
+                        memory_region_set_priority,
                         NULL, NULL, &error_abort);
     object_property_add(OBJECT(mr), "size", "uint64",
                         memory_region_get_size,
-- 
2.16.3
