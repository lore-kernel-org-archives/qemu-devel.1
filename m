Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvRpV-0003xv-P7
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvRpU-00030e-Td
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:01:17 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1cvRpU-00030L-QS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:01:16 -0400
Received: by mail-qk0-x241.google.com with SMTP id v75so4257767qkb.3
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 10:01:16 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Tue,  4 Apr 2017 13:01:04 -0400
Message-Id: <1491325264-14502-4-git-send-email-gsomlo@gmail.com>
In-Reply-To: <1491325264-14502-1-git-send-email-gsomlo@gmail.com>
References: <1491325264-14502-1-git-send-email-gsomlo@gmail.com>
Subject: [Qemu-devel] [PATCH v2 3/3] applesmc: fix port i/o access width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, agraf@suse.de, eshelton@pobox.com

Set width of the two i/o regions dedicated to the AppleSMC's 8-bit
data and command ports to 1 byte.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---

Setting these to 1-byte width works fine on any OS X version I could find
to test on: 10.(6-12), inclusive.

On linux, the applesmc kernel module tries *hard* to avoid loading on
anything that's not a Mac, by checking DMI board vendor and product
strings. If I force it using:

   -smbios type=1,manufacturer='Apple Inc.',product='iMac2',family='iMac' \
   -smbios type=2,manufacturer='Apple Inc.',version='iMac' \
   -device isa-applesmc

the module fails both before and after this whole series, suggesting it's
not (just) the access width but rather the overall incomplete emulation
that's the issue.

If we decide to go for implementing a more complete emulation, beyond
simply the minimum necessary to satisfy OS X, we should definitely ensure
that Linux is also happily able to initialize its applesmc driver...

 hw/misc/applesmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 0d882e8..7896812 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -316,12 +316,12 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     AppleSMCState *s = APPLE_SMC(dev);
 
     memory_region_init_io(&s->io_data, OBJECT(s), &applesmc_data_io_ops, s,
-                          "applesmc-data", 4);
+                          "applesmc-data", 1);
     isa_register_ioport(&s->parent_obj, &s->io_data,
                         s->iobase + APPLESMC_DATA_PORT);
 
     memory_region_init_io(&s->io_cmd, OBJECT(s), &applesmc_cmd_io_ops, s,
-                          "applesmc-cmd", 4);
+                          "applesmc-cmd", 1);
     isa_register_ioport(&s->parent_obj, &s->io_cmd,
                         s->iobase + APPLESMC_CMD_PORT);
 
-- 
2.7.4
