Received: from eggs.gnu.org ([2001:4830:134:3::10]:35705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxv-0003KH-R2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxr-000207-Rw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxr-0001yw-Kr
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:03 -0400
Received: by mail-wm0-x243.google.com with SMTP id i124so11136520wmf.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:55 +0200
Message-Id: <1508343141-31835-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/29] ide: support reporting of rotation rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The Linux kernel will query the ATA IDENTITY DEVICE data, word 217
to determine the rotations per minute of the disk. If this has
the value 1, it is taken to be an SSD and so Linux sets the
'rotational' flag to 0 for the I/O queue and will stop using that
disk as a source of random entropy. Other operating systems may
also take into account rotation rate when setting up default
behaviour.

Mgmt apps should be able to set the rotation rate for virtualized
block devices, based on characteristics of the host storage in use,
so that the guest OS gets sensible behaviour out of the box. This
patch thus adds a 'rotation-rate' parameter for 'ide-hd' device
types.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20171004114008.14849-3-berrange@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/core.c             | 1 +
 hw/ide/qdev.c             | 1 +
 include/hw/ide/internal.h | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5f1cd3b..a04766a 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -208,6 +208,7 @@ static void ide_identify(IDEState *s)
     if (dev && dev->conf.discard_granularity) {
         put_le16(p + 169, 1); /* TRIM support */
     }
+    put_le16(p + 217, dev->rotation_rate); /* Nominal media rotation rate */
 
     ide_identify_size(s);
     s->identify_set = 1;
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index d60ac25..a5181b4 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -299,6 +299,7 @@ static Property ide_hd_properties[] = {
     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
                 IDEDrive, dev.chs_trans, BIOS_ATA_TRANSLATION_AUTO),
+    DEFINE_PROP_UINT16("rotation_rate", IDEDrive, dev.rotation_rate, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index e641012..31851b4 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -508,6 +508,14 @@ struct IDEDevice {
     char *serial;
     char *model;
     uint64_t wwn;
+    /*
+     * 0x0000        - rotation rate not reported
+     * 0x0001        - non-rotating medium (SSD)
+     * 0x0002-0x0400 - reserved
+     * 0x0401-0xffe  - rotations per minute
+     * 0xffff        - reserved
+     */
+    uint16_t rotation_rate;
 };
 
 /* These are used for the error_status field of IDEBus */
-- 
1.8.3.1
