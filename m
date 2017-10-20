Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuQ-0003UT-Dd
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuP-0003vd-O0
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:07 +0200
Message-Id: <20171020115418.2050-36-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 35/46] s390x: fix cpu object referrence leak in
 s390x_new_cpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

object_new() returns cpu with refcnt == 1 and after realize
refcnt == 2*. s390x_new_cpu() as an owner of the first refcnt
should have released it on exit in both cases (on error and
success) to avoid it leaking. Do so for both cases.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1508247680-98800-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index c41aa4c4ff..9ff7ff4acc 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -73,9 +73,9 @@ S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
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
2.13.6
