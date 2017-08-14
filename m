Received: from eggs.gnu.org ([2001:4830:134:3::10]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dhMEo-00073y-Gb
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dhMEj-0000wW-II
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:45:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47582
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1dhMEj-0000tZ-AN
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 16:45:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7EKhdx7189682
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:45:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cbe81e9e9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:45:19 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Mon, 14 Aug 2017 21:45:18 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 22:44:50 +0200
In-Reply-To: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
Message-Id: <20170814204450.24118-2-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] pc-bios/s390-ccw: Use rm command during
 make clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, thuth@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Eric Farman <farman@linux.vnet.ibm.com>

This reverts what I think was an accidental change that replaced
the "rm -f" command with an undefined variable RM, and causes the
"make clean" command to fail for a s390 target:

make[1]: Entering directory '/usr/src/qemu/build/pc-bios/s390-ccw'
rm -f *.timestamp
*.o *.d *.img *.elf *~ *.a
/bin/sh: *.o: command not found
Makefile:39: recipe for target 'clean' failed
make[1]: *** [clean] Error 127
make[1]: Leaving directory '/usr/src/qemu/build/pc-bios/s390-ccw'
Makefile:489: recipe for target 'clean' failed
make: *** [clean] Error 1

Fixes: 3e4415a751d2 ("pc-bios/s390-ccw: Add core files for the network
                      bootloading program")
Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index cbae74522a..6d0c2ee691 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -36,4 +36,4 @@ s390-netboot.img:
 endif
 
 clean:
-	$(RM) *.o *.d *.img *.elf *~ *.a
+	rm -f *.o *.d *.img *.elf *~ *.a
-- 
2.11.2
