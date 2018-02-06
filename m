Received: from eggs.gnu.org ([2001:4830:134:3::10]:43598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iX-00056a-Pw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iS-0007oI-Mv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57424
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iS-0007nj-Hp
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:40 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JELu6126857
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:38 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhwn1eqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:38 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:37 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:30 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-10-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 09/54] block: Open backing image in force share
 mode for size probe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Fam Zheng <famz@redhat.com>

Management tools create overlays of running guests with qemu-img:

  $ qemu-img create -b /image/in/use.qcow2 -f qcow2 /overlay/image.qcow2

but this doesn't work anymore due to image locking:

    qemu-img: /overlay/image.qcow2: Failed to get shared "write" lock
    Is another process using the image?
    Could not open backing image to determine size.
Use the force share option to allow this use case again.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit cc954f01e3c004aad081aa36736a17e842b80211)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 9a1a0d1e73..f236431da1 100644
--- a/block.c
+++ b/block.c
@@ -4593,10 +4593,11 @@ void bdrv_img_create(const char *filename, const char *fmt,
         back_flags = flags;
         back_flags &= ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING);
 
+        backing_options = qdict_new();
         if (backing_fmt) {
-            backing_options = qdict_new();
             qdict_put_str(backing_options, "driver", backing_fmt);
         }
+        qdict_put_bool(backing_options, BDRV_OPT_FORCE_SHARE, true);
 
         bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
                        &local_err);
-- 
2.11.0
