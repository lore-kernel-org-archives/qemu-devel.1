Received: from eggs.gnu.org ([2001:4830:134:3::10]:43227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4w9-0001rN-Jv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4w4-0005rV-JA
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:24:56 +0100
Message-Id: <20180209092524.31348-2-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/29] Fix configure for s390 qemu on alpine and
 other busybox environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Alice Frosi <alice@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Alice Frosi <alice@linux.vnet.ibm.com>

In alpine docker image the qemu-system-s390x build is broken and
it throws this error:
qemu-system-s390x: Initialization of device s390-ipl failed: could not
load bootloader 's390-ccw.img'

The grep command of busybox uses regex. This fails on binary data
(e.g. stops on every \0), so it does not identify the string
BiGeNdIaN in the test case big/little. Therefore, it assumes
that the architecture is little endian.

This fix solves the grep problem by printing the content of
TMPO with strings

Signed-off-by: Alice Frosi <alice@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[some changes to patch description, add -a option to strings]
Message-Id: <20180130133828.77336-2-borntraeger@de.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 831ebf248f..1be413a004 100755
--- a/configure
+++ b/configure
@@ -1933,9 +1933,9 @@ int main(int argc, char *argv[]) {
 EOF
 
 if compile_object ; then
-    if grep -q BiGeNdIaN $TMPO ; then
+    if strings -a $TMPO | grep -q BiGeNdIaN ; then
         bigendian="yes"
-    elif grep -q LiTtLeEnDiAn $TMPO ; then
+    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then
         bigendian="no"
     else
         echo big/little test failed
-- 
2.13.6
