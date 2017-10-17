Received: from eggs.gnu.org ([2001:4830:134:3::10]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4S7e-0004rV-EP
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4S7a-0007z5-JO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4S7a-0007yg-DE
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:41:26 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 17 Oct 2017 15:41:19 +0200
Message-Id: <1508247680-98800-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
References: <1508247680-98800-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] s390x: fix cpu object referrence leak in
 s390x_new_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

object_new() returns cpu with refcnt == 1 and after realize
refcnt == 2*. s390x_new_cpu() as an owner of the first refcnt
should have released it on exit in both cases (on error and
success) to avoid it leaking. Do so for both cases.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 97adbcc..64d4c48 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -80,9 +80,9 @@ S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
     object_property_set_bool(OBJECT(cpu), true, "realized", &err);
 
 out:
+    object_unref(OBJECT(cpu));
     if (err) {
         error_propagate(errp, err);
-        object_unref(OBJECT(cpu));
         cpu = NULL;
     }
     return cpu;
-- 
2.7.4
