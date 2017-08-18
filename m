Received: from eggs.gnu.org ([2001:4830:134:3::10]:42892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rene@exactcode.com>) id 1dihJS-0000cU-CJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rene@exactcode.com>) id 1dihJP-0008BA-86
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:27:46 -0400
Received: from [144.76.154.42] (port=35088 helo=exactco.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rene@exactcode.com>) id 1dihJO-0008A6-V6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:27:43 -0400
Received: from exactco.de ([90.187.5.221]) by exactco.de with esmtp (Exim 4.82)
	(envelope-from <rene@exactcode.com>) id 1digvB-0008TR-Sq
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:02:41 +0000
Received: from 14.red-81-36-154.dynamicip.rima-tde.net ([81.36.154.14]
	helo=[192.168.10.100])
	by exactco.de with esmtpsa (TLSv1:AES128-SHA:128) (Exim 4.54)
	id 1digvN-0007pr-NX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:02:54 +0000
From: =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.com>
Message-ID: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
Date: Fri, 18 Aug 2017 15:02:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] [PATCH] QXL: always show default cursor,
 even for unsupported chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I was testing a Windows 10 guest with HiDPI scaling which

actually made the cursor disappear and only multiple chunks

warnings being printed.

When the cursor is using currently unsupported multiple chunks, the
builtin-left cursor is better than none.

PS: if TB damages the white-space just let me know, only recently 
started using it, ...

   - René Rebe <rene@exactcode.de>

diff -u -ur qemu-2.10.0-rc3/hw/display/qxl-render.c 
qemu-2.10.0-rc3-fixed/hw/display/qxl-render.c
--- qemu-2.10.0-rc3/hw/display/qxl-render.c    2017-08-15 
20:39:41.000000000 +0200
+++ qemu-2.10.0-rc3-fixed/hw/display/qxl-render.c    2017-08-17 
13:42:37.108953910 +0200
@@ -270,9 +270,10 @@
          }
          if (cursor->chunk.data_size != cursor->data_size) {
              fprintf(stderr, "%s: multiple chunks\n", __FUNCTION__);
-            return 1;
+            c = NULL; /* fall back to built-in left cursor */
+        } else {
+            c = qxl_cursor(qxl, cursor);
          }
-        c = qxl_cursor(qxl, cursor);
          if (c == NULL) {
              c = cursor_builtin_left_ptr();
          }
