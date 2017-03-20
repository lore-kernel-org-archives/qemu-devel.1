Received: from eggs.gnu.org ([2001:4830:134:3::10]:45906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cptaq-0002r4-B9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cptan-0001nI-6k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:27:12 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:32103 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cptam-0001mE-Rq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:27:09 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 20 Mar 2017 12:27:02 +0300
Message-Id: <1490002022-22653-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] parallels: fix default options parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: qemu-devel@nongnu.org, Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>, "Denis V . Lunev" <den@openvz.org>, Markus Armbruster <armbru@redhat.com>

From: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>

parallels block driver is completely broken since commit
    commit 75cdcd1553e74b5edc58aed23e3b2da8dabb1876
    Author: Markus Armbruster <armbru@redhat.com>
    Date:   Tue Feb 21 21:14:08 2017 +0100
    option: Fix checking of sizes for overflow and trailing crap
Right now even simple
    qemu-io -c "read 512 64k" 1.hds
ends up with
    Unexpected error in parse_option_size() at util/qemu-option.c:188:
    Parameter 'prealloc-size' expects a non-negative number below 2^64
    Aborted (core dumped)
The cure is simple - we should use 'M' as a suffix in default option value
instead of 'MiB'.

Signed-off-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 19935e2..6bf9375 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -114,7 +114,7 @@ static QemuOptsList parallels_runtime_opts = {
             .name = PARALLELS_OPT_PREALLOC_SIZE,
             .type = QEMU_OPT_SIZE,
             .help = "Preallocation size on image expansion",
-            .def_value_str = "128MiB",
+            .def_value_str = "128M",
         },
         {
             .name = PARALLELS_OPT_PREALLOC_MODE,
-- 
2.7.4
