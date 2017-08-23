Received: from eggs.gnu.org ([2001:4830:134:3::10]:38345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkSiE-0005Xf-Cl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkSi8-0004ju-7a
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54627
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkSi8-0004jI-2D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 06:16:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7NAFldL031710
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 06:16:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ch542t7mp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 06:16:30 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 23 Aug 2017 11:16:28 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 23 Aug 2017 12:16:23 +0200
Message-Id: <1503483383-199649-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3] configure: enable --s390-pgste linker option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Dan Horak <dhorak@redhat.com>

KVM guests on s390 need a different page table layout than normal
processes (2kb page table + 2kb page status extensions vs 2kb page table
only). As of today this has to be enabled via the vm.allocate_pgste
sysctl.

Newer kernels (>= 4.12) on s390 check for an S390_PGSTE program header
and enable the pgste page table extensions in that case. This makes the
vm.allocate_pgste sysctl unnecessary. We enable this program header for
the s390 system emulation (qemu-system-s390x) if we build on s390
- for s390 system emulation
- the linker supports --s390-pgste (binutils >= 2.29)
- KVM is enabled

This will allow distributions to disable the global vm.allocate_pgste
sysctl, which will improve the page table allocation for non KVM
processes as only 2kb chunks are necessary.

Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Dan Horak <dhorak@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
V1->V2:
	- provide ld_has function
	- use ld_has to replace some open coded variants
	- check target arch and arch for s390
	- check for s390x before calling the linker
V2->V3: 
	- fix typos
 configure | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index dd73cce..fb7e34a 100755
--- a/configure
+++ b/configure
@@ -240,6 +240,11 @@ supported_target() {
     return 1
 }
 
+
+ld_has() {
+    $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
+}
+
 # default parameters
 source_path=$(dirname "$0")
 cpu=""
@@ -5043,7 +5048,7 @@ fi
 # Use ASLR, no-SEH and DEP if available
 if test "$mingw32" = "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
-        if $ld --help 2>/dev/null | grep ".$flag" >/dev/null 2>/dev/null ; then
+        if ld_has $flag ; then
             LDFLAGS="-Wl,$flag $LDFLAGS"
         fi
     done
@@ -6522,6 +6527,20 @@ if test "$target_linux_user" = "yes" -o "$target_bsd_user" = "yes" ; then
   ldflags="$ldflags $textseg_ldflags"
 fi
 
+# Newer kernels on s390 check for an S390_PGSTE program header and
+# enable the pgste page table extensions in that case. This makes
+# the vm.allocate_pgste sysctl unnecessary. We enable this program
+# header if
+#  - we build on s390x
+#  - we build the system emulation for s390x (qemu-system-s390x)
+#  - KVM is enabled
+#  - the linker supports --s390-pgste
+if test "$TARGET_ARCH" = "s390x" -a "$target_softmmu" = "yes"  -a "$ARCH" = "s390x" -a "$kvm" = "yes"; then
+    if ld_has --s390-pgste ; then
+        ldflags="-Wl,--s390-pgste $ldflags"
+    fi
+fi
+
 echo "LDFLAGS+=$ldflags" >> $config_target_mak
 echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
-- 
2.7.4
