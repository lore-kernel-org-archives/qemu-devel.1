Received: from eggs.gnu.org ([2001:4830:134:3::10]:56646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cXOV2-0005zC-SV
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 03:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cXOV1-0004iF-Vp
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 03:36:44 -0500
Received: from mail.weilnetz.de ([37.221.199.173]:59440)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cXOV1-0004i5-PB
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 03:36:43 -0500
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <69936381-a99e-adc4-5de0-0f9bdf85323b@weilnetz.de>
Date: Sat, 28 Jan 2017 09:36:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

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
@@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel 
*max_model,
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
  -- 2.1.4
