Received: from eggs.gnu.org ([2001:4830:134:3::10]:57206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egW7V-0000rR-1K
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egW7Q-0008QX-VE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:38:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60560
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1egW7Q-0008Pv-PL
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:38:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0UDaP3X115316
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 08:38:33 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ftpu21ag9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 08:38:32 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 30 Jan 2018 13:38:31 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 30 Jan 2018 14:38:28 +0100
In-Reply-To: <20180130133828.77336-1-borntraeger@de.ibm.com>
References: <20180130133828.77336-1-borntraeger@de.ibm.com>
Message-Id: <20180130133828.77336-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] Fix configure for s390 qemu on alpine
 and other busybox environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alice Frosi <alice@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

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
---
v1->v2:
- Fix email address of Alice
- Fix patch prefix

 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 6d8c996c62..383b14e991 100755
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
2.13.4
