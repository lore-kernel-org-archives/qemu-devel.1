Received: from eggs.gnu.org ([2001:4830:134:3::10]:55809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tcA-0004yF-PD
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tc9-0002w5-Uf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:22:58 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3tc9-0002vE-PF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 21:22:57 -0400
Received: by mail-qt0-x242.google.com with SMTP id z23so24597093qti.5
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 18:22:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Apr 2018 22:22:38 -0300
Message-Id: <20180405012241.25714-2-f4bug@amsat.org>
In-Reply-To: <20180405012241.25714-1-f4bug@amsat.org>
References: <20180405012241.25714-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/4] memory: Avoid to create tiny RAM
 regions, handled as subpages
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

If an user creates a RAM region smaller than TARGET_PAGE_SIZE,
this region will be handled as a subpage.
While the subpage behavior can be noticed by an experienced QEMU
developper, it might takes hours to a novice to figure it out.
To save time to novices, do not allow subpage creation via the
memory_region_init_ram_*() functions.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/memory.c b/memory.c
index e70b64b8b9..51d27b7b26 100644
--- a/memory.c
+++ b/memory.c
@@ -1519,6 +1519,15 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
                                              bool share,
                                              Error **errp)
 {
+    if (size < TARGET_PAGE_SIZE) {
+        /* Region less than PAGE_SIZE are handled as subpages, which are
+         * surely not what the caller expects.
+         * Limit the minimum ram region size to avoid annoying debugging.
+         */
+        error_setg(errp, "Invalid RAM size: %ld (minimum required: %d)",
+                   size, TARGET_PAGE_SIZE);
+        return;
+    }
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->terminates = true;
-- 
2.16.3
