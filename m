Received: from eggs.gnu.org ([2001:4830:134:3::10]:55922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVcI-0006J3-Rp
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVcE-00015m-9t
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1evVcE-00015c-4S
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2CM4lJw004023
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gnx6y0npw-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:21 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Mon, 12 Mar 2018 18:08:20 -0400
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 19:07:53 -0300
In-Reply-To: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
Message-Id: <20180312220753.20096-6-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/5] include/block/block_int: Document
 protocol related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Clarify that:

- for protocols the brdv_file_open function is used instead
of bdrv_open;

- when protocol_name is set, a driver should expect
to be given only a filename and no other options.

Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
---
 include/block/block_int.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 27e17addba..c4dd1d4bb8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -126,6 +126,8 @@ struct BlockDriver {
 
     int (*bdrv_open)(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp);
+
+    /* Protocol drivers should implement this instead of bdrv_open */
     int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
@@ -251,6 +253,12 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush_to_os)(BlockDriverState *bs);
 
+    /*
+     * Drivers setting this field must be able to work with just a plain
+     * filename with '<protocol_name>:' as a prefix, and no other options.
+     * Options may be extracted from the filename by implementing
+     * bdrv_parse_filename.
+     */
     const char *protocol_name;
     int (*bdrv_truncate)(BlockDriverState *bs, int64_t offset,
                          PreallocMode prealloc, Error **errp);
-- 
2.13.6
