Received: from eggs.gnu.org ([2001:4830:134:3::10]:48422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0001Ul-MW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCb-0005kg-Fw
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCb-0005jC-6o
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0F3Fr052211
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmwga06ku-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:18 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:39 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-5-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 04/79] qemu-img/convert: Use @opts for one
 thing only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

After storing the creation options for the new image into @opts, we
fetch some things for our own information, like the backing file name,
or whether to use encryption or preallocation.

With the -n parameter, there will not be any creation options; this is
not too bad because this just means that querying a NULL @opts will
always return the default value.

However, we also use @opts for the --object options. Therefore, @opts is
not necessarily NULL if -n was specified; instead, it may contain those
options. In practice, this probably does not cause any problems because
there most likely is no object that supports any of the parameters we
query here, but this is neither something we should rely on nor does
this variable reuse make the code very nice to read.

Therefore, just use an own variable for the --object options.

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
* applied patch from v1 of series as suggested by author
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9aa7823..cfc3bc3 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2065,14 +2065,16 @@ static int img_convert(int argc, char **argv)
         case 'W':
             wr_in_order = false;
             break;
-        case OPTION_OBJECT:
-            opts = qemu_opts_parse_noisily(&qemu_object_opts,
-                                           optarg, true);
-            if (!opts) {
+        case OPTION_OBJECT: {
+            QemuOpts *object_opts;
+            object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                                  optarg, true);
+            if (!object_opts) {
                 ret = -1;
                 goto fail_getopt;
             }
             break;
+        }
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
-- 
2.7.4
