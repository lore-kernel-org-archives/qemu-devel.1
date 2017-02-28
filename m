Received: from eggs.gnu.org ([2001:4830:134:3::10]:40332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih6J-0000Mq-TX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih6J-0000dI-8g
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih6J-0000cT-3t
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:55 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:56 +0000
Message-Id: <20170228124056.5074-28-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 27/27] postcopy: Add extra check for COPY
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

As an extra sanity check, make sure the region we're registering
can perform UFFDIO_COPY;  the COPY will fail later but this
gives a cleaner failure.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170224182844.32452-17-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 102fb61..effbeb6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -378,6 +378,10 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
         error_report("%s userfault register: %s", __func__, strerror(errno));
         return -1;
     }
+    if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+        error_report("%s userfault: Region doesn't support COPY", __func__);
+        return -1;
+    }
 
     return 0;
 }
-- 
2.9.3
