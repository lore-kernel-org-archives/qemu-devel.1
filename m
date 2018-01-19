Received: from eggs.gnu.org ([2001:4830:134:3::10]:48903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ecZl5-0004uJ-T6
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ecZl1-000310-T2
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:43:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50204
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ecZl1-00030U-NS
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:43:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JGeF7X113877
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 11:43:11 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fkkt59utk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 11:43:10 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 19 Jan 2018 09:43:10 -0700
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 19 Jan 2018 17:42:59 +0100
Message-Id: <1516380179-12737-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 12/12] Fix configure for s390 qemu on alpine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alice Frosi <alice@linux.vnet.ibm.comx>Alice Frosi <alice@linux.vnet.ibm.com>

From: Alice Frosi <alice@linux.vnet.ibm.comx>

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
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 6d8c996..383b14e 100755
--- a/configure
+++ b/configure
@@ -1906,9 +1906,9 @@ int main(int argc, char *argv[]) {
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
1.8.3.1
