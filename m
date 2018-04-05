Received: from eggs.gnu.org ([2001:4830:134:3::10]:48375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47g3-0002TB-Uh
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47g2-0002LQ-NE
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:23:55 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:41709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f47g2-0002L3-D0
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:23:54 -0400
Received: by mail-wr0-x234.google.com with SMTP id s12so18800516wrc.8
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 09:23:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  5 Apr 2018 18:23:47 +0200
Message-Id: <20180405162347.5623-3-pbonzini@redhat.com>
In-Reply-To: <20180405162347.5623-1-pbonzini@redhat.com>
References: <20180405162347.5623-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, danielhb@linux.vnet.ibm.com

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

QEMU SCSI code makes assumptions about how the PROTECT and BYTCHK
works in the protocol, denying support for PI (Protection
Information) in case the guest OS requests it. However, in SCSI versions 2
and older, there is no PI concept in the protocol.

This means that when dealing with such devices:

- there is no PROTECT bit in byte 5 of the standard INQUIRY response. The
whole byte is marked as "Reserved";

- there is no RDPROTECT in byte 2 of READ. We have 'Logical Unit Number'
in this field instead;

- there is no VRPROTECT in byte 2 of VERIFY. We have 'Logical Unit Number'
in this field instead. This also means that the BYTCHK bit in this case
is not related to PI.

Since QEMU does not consider these changes, a SCSI passthrough using
a SCSI-2 device will not work. It will mistake these fields with
PI information and return Illegal Request SCSI SENSE thinking
that the driver is asking for PI support.

This patch fixes it by adding a new attribute called 'scsi_version'
that is read from the standard INQUIRY response of passthrough
devices. This allows for a version verification before applying
conditions related to PI that doesn't apply for older versions.

Reported-by: Dac Nguyen <dacng@us.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Message-Id: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    |  2 +-
 hw/scsi/scsi-generic.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 9400b97387..ded23d36ca 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3041,7 +3041,7 @@ static Property scsi_block_properties[] = {
     DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
     DEFINE_PROP_INT32("scsi_version", SCSIDiskState, qdev.default_scsi_version,
-                      5),
+                      -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 1870085762..381f04e339 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -194,17 +194,40 @@ static void scsi_read_complete(void * opaque, int ret)
             r->buf[3] |= 0x80;
         }
     }
-    if (s->type == TYPE_DISK &&
-        r->req.cmd.buf[0] == INQUIRY &&
-        r->req.cmd.buf[2] == 0xb0) {
-        uint32_t max_transfer =
-            blk_get_max_transfer(s->conf.blk) / s->blocksize;
-
-        assert(max_transfer);
-        stl_be_p(&r->buf[8], max_transfer);
-        /* Also take care of the opt xfer len. */
-        stl_be_p(&r->buf[12],
-                 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+    if (r->req.cmd.buf[0] == INQUIRY) {
+        /*
+         *  EVPD set to zero returns the standard INQUIRY data.
+         *
+         *  Check if scsi_version is unset (-1) to avoid re-defining it
+         *  each time an INQUIRY with standard data is received.
+         *  scsi_version is initialized with -1 in scsi_generic_reset
+         *  and scsi_disk_reset, making sure that we'll set the
+         *  scsi_version after a reset. If the version field of the
+         *  INQUIRY response somehow changes after a guest reboot,
+         *  we'll be able to keep track of it.
+         *
+         *  On SCSI-2 and older, first 3 bits of byte 2 is the
+         *  ANSI-approved version, while on later versions the
+         *  whole byte 2 contains the version. Check if we're dealing
+         *  with a newer version and, in that case, assign the
+         *  whole byte.
+         */
+        if (s->scsi_version == -1 && !(r->req.cmd.buf[1] & 0x01)) {
+            s->scsi_version = r->buf[2] & 0x07;
+            if (s->scsi_version > 2) {
+                s->scsi_version = r->buf[2];
+            }
+        }
+        if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
+            uint32_t max_transfer =
+                blk_get_max_transfer(s->conf.blk) / s->blocksize;
+
+            assert(max_transfer);
+            stl_be_p(&r->buf[8], max_transfer);
+            /* Also take care of the opt xfer len. */
+            stl_be_p(&r->buf[12],
+                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+        }
     }
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
@@ -550,6 +573,8 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
 
     DPRINTF("block size %d\n", s->blocksize);
 
+    /* Only used by scsi-block, but initialize it nevertheless to be clean.  */
+    s->default_scsi_version = -1;
     scsi_generic_read_device_identification(s);
 }
 
-- 
2.16.2
