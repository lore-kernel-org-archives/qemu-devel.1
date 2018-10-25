Received: from eggs.gnu.org ([2001:4830:134:3::10]:50347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gFbzT-0007Zv-0b
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gFbzO-0008Uf-1O
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gFbzM-0008Ib-C9
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6184E30F5593
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:31:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Oct 2018 10:52:55 +0200
Message-Id: <20181025085256.20522-3-kraxel@redhat.com>
In-Reply-To: <20181025085256.20522-1-kraxel@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <ppandit@redhat.com>

We have a lovely, guest-triggerable buffer overflow in opl2 emulation.

Reproducer:
    outw(0xff60, 0x220);
    outw(0x1020, 0x220);
    outw(0xffb0, 0x220);
Result:
    Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])

The specs google finds (http://www.symphoniae.com/Yamaha/YSC/YM3812.pdf)
are rather sparse, possibly incomplete (looks like scanned fax with a
scrambled page at the end) and not really helpful in identifying which
of the register writes sets some illegal value.

So, go tag the device as deprecated with a warning messge, to notify
users and schedule it for removal according to our deprecation policy.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/adlib.c     | 1 +
 qemu-deprecated.texi | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 97b876c..fb4a29c 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -311,6 +311,7 @@ static void adlib_class_initfn (ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->desc = ADLIB_DESC;
     dc->props = adlib_properties;
+    dc->deprecation_reason = "insecure, buffer overflow in opl2 emulation";
 }
 
 static const TypeInfo adlib_info = {
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 11b870c..7951a4f 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -116,6 +116,10 @@ The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
+@subsection adlib (since 3.1)
+
+Has known buffer overflow.
+
 @section System emulator machines
 
 @subsection pc-0.10 and pc-0.11 (since 3.0)
-- 
2.9.3
