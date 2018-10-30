Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa2A-00083w-Ud
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa29-0002Ma-Oa
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:38 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa29-0002KY-Em
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id x12-v6so13961008wrw.8
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:37 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	g76-v6sm17480094wmd.25.2018.10.30.12.50.34
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Oct 2018 12:50:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:10 +0100
Message-Id: <1540929011-19894-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/10] scripts/dump-guest-memory: Synchronize
 with guest_phys_blocks_region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Recent patches have removed ram_device and nonvolatile RAM
from dump-guest-memory's output.  Do the same for dumps
that are extracted from a QEMU core file.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/dump-guest-memory.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 5a857ce..f04697b 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -417,7 +417,9 @@ def get_guest_phys_blocks():
         memory_region = flat_range["mr"].dereference()
 
         # we only care about RAM
-        if not memory_region["ram"]:
+        if not memory_region["ram"] \
+           or memory_region["ram_device"] \
+           or memory_region["nonvolatile"]:
             continue
 
         section_size = int128_get64(flat_range["addr"]["size"])
-- 
1.8.3.1
