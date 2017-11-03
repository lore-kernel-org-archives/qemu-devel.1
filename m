Received: from eggs.gnu.org ([2001:4830:134:3::10]:39875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAWrm-0007y1-L3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAWrh-0004Vw-PP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAWrh-0004Vp-Jw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:58:09 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  3 Nov 2017 08:57:53 +0100
Message-Id: <20171103075753.23217-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] Ignore sgabios rom in case sercon is enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

We don't want them both be active.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 src/optionroms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/optionroms.c b/src/optionroms.c
index 092393a56c..a5ecd4cd11 100644
--- a/src/optionroms.c
+++ b/src/optionroms.c
@@ -193,6 +193,11 @@ run_file_roms(const char *prefix, int isvga, u64 *sources)
         file = romfile_findprefix(prefix, file);
         if (!file)
             break;
+        if (strcmp(file->name, "vgaroms/sgabios.bin") == 0 &&
+            CONFIG_SERCON && romfile_loadint("etc/sercon-port", 0)) {
+            dprintf(1, "sercon: is enabled, not loading sgabios rom.\n");
+            continue;
+        }
         struct rom_header *rom = deploy_romfile(file);
         if (rom) {
             setRomSource(sources, rom, (u32)file);
-- 
2.9.3
