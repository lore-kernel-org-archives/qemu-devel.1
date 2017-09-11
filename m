Received: from eggs.gnu.org ([2001:4830:134:3::10]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1drM2Q-000111-T9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1drM2N-0003tk-RJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:33:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35966
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1drM2N-0003tJ-LY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:33:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8BASo49102049
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:33:54 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cwpmn8vtn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:33:53 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Mon, 11 Sep 2017 11:33:51 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 12:33:47 +0200
Message-Id: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] s390: set DHCP client architecure id for
 netboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com

Setting the client architecture DHCP option to 0x001f (s390 Basic) [1]
allows the DHCP server to return a s390-specific bootfile if wanted.
DHCP servers not configured for the option (or not yet recognizing the
option value) will continue to work as they have done before.

[1] https://www.iana.org/assignments/dhcpv6-parameters

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/netboot.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index a9e1374..a25d238 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -50,7 +50,7 @@ libc.a: $(LIBCOBJS)
 
 LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
 	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o
-LIBNETCFLAGS := $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+LIBNETCFLAGS := $(QEMU_CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
 
 %.o : $(SLOF_DIR)/lib/libnet/%.c
 	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-- 
1.9.1
