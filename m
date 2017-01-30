Received: from eggs.gnu.org ([2001:4830:134:3::10]:60788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cYBns-000752-Hs
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cYBnn-0008Qi-FD
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:15:28 -0500
Received: from mail.weilnetz.de ([37.221.199.173]:43666)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cYBnn-0008QH-8B
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:15:23 -0500
From: Stefan Weil <sw@weilnetz.de>
Date: Mon, 30 Jan 2017 14:15:17 +0100
Message-Id: <20170130131517.8092-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Weil <sw@weilnetz.de>

Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

v2: Re-sent as v1 was damaged by my mailer.

This is also broken in Debian.

In addition, there is no default CPU ("any"), so binfmt and related
actions currently don't work. I hacked my local installation by
duplicating the "qemu" cpu definition for "any", but maybe there is
a better solution.

Regards
Stefan

 target/s390x/cpu_models.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2a894ee..6e34763 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel *max_model,
 
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
-#ifndef CONFIG_USER_ONLY
     static S390CPUModel max_model;
     static bool cached;
 
@@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
         cached = true;
         return &max_model;
     }
-#endif
     return NULL;
 }
 
-- 
2.1.4
