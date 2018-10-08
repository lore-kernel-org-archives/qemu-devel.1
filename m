Received: from eggs.gnu.org ([2001:4830:134:3::10]:52302)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9YVQ-0005OH-3M
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9YVP-0002fS-4t
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:35:40 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:57390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9YVN-0002ZB-2O
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:35:39 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
From: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>
Date: Mon,  8 Oct 2018 09:35:19 -0700
Message-Id: <20181008163521.17341-2-cst@tolva.net>
In-Reply-To: <20181008163521.17341-1-cst@tolva.net>
References: <20181008163521.17341-1-cst@tolva.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/3] linux-user: Check for Linux USBFS in
 configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>, Laurent Vivier <laurent@vivier.eu>

In preparation for adding user mode emulation support for the
Linux usbfs interface, check for its kernel header.

Signed-off-by: Cortland Tölva <cst@tolva.net>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180925071228.32040-2-cst@tolva.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index f89d293585..19d66bbdeb 100755
--- a/configure
+++ b/configure
@@ -4236,7 +4236,14 @@ if compile_prog "" "" ; then
   memfd=yes
 fi
 
-
+# check for usbfs
+have_usbfs=no
+if test "$linux_user" = "yes"; then
+  if check_include linux/usbdevice_fs.h; then
+    have_usbfs=yes
+  fi
+  have_usbfs=yes
+fi
 
 # check for fallocate
 fallocate=no
@@ -6350,6 +6357,9 @@ fi
 if test "$memfd" = "yes" ; then
   echo "CONFIG_MEMFD=y" >> $config_host_mak
 fi
+if test "$have_usbfs" = "yes" ; then
+  echo "CONFIG_USBFS=y" >> $config_host_mak
+fi
 if test "$fallocate" = "yes" ; then
   echo "CONFIG_FALLOCATE=y" >> $config_host_mak
 fi
-- 
2.11.0
