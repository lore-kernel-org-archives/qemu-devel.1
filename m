Received: from eggs.gnu.org ([2001:4830:134:3::10]:38539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBG-0007wn-GL
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBD-0001ZA-QK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:14 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdBD-0001Wp-E0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:11 -0400
Received: by mail-wr0-x232.google.com with SMTP id c5-v6so6682654wrs.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:07 +0200
Message-Id: <1530216310-52873-58-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 57/60] hw/scsi: cleanups before VPD BL emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

To add support for the emulation of Block Limits VPD page
for passthrough devices, a few adjustments in the current code
base is required to avoid repetition and improve clarity.

In scsi-generic.c, detach the Inquiry handling from
scsi_read_complete and put it into a new function called
scsi_handle_inquiry_reply. This change aims to avoid
cluttering of scsi_read_complete when we more logic in the
Inquiry response handling is added in the next patches,
centralizing the changes in the new function.

In scsi-disk.c, take the build of all emulated VPD pages
from scsi_disk_emulate_inquiry and make it available to
other files into a non-static function called
scsi_disk_emulate_vpd_page. Making it public will allow
the future VPD BL emulation code for passthrough devices
to use it from scsi-generic.c, avoiding copy/pasting this
code solely for that purpose. It also has the advantage of
providing emulation of all VPD pages in case we need to
emulate other pages in other scenarios. As a bonus,
scsi_disk_emulate_inquiry got tidier.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20180627172432.11120-2-danielhb413@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    | 407 +++++++++++++++++++++++++------------------------
 hw/scsi/scsi-generic.c |  71 +++++----
 include/hw/scsi/scsi.h |   1 +
 3 files changed, 249 insertions(+), 230 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index aeaf611..664d634 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -585,219 +585,228 @@ static uint8_t *scsi_get_buf(SCSIRequest *req)
     return (uint8_t *)r->iov.iov_base;
 }
 
-static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
+int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
-    int buflen = 0;
-    int start;
-
-    if (req->cmd.buf[1] & 0x1) {
-        /* Vital product data */
-        uint8_t page_code = req->cmd.buf[2];
-
-        outbuf[buflen++] = s->qdev.type & 0x1f;
-        outbuf[buflen++] = page_code ; // this page
-        outbuf[buflen++] = 0x00;
-        outbuf[buflen++] = 0x00;
-        start = buflen;
-
-        switch (page_code) {
-        case 0x00: /* Supported page codes, mandatory */
-        {
-            DPRINTF("Inquiry EVPD[Supported pages] "
-                    "buffer size %zd\n", req->cmd.xfer);
-            outbuf[buflen++] = 0x00; // list of supported pages (this page)
-            if (s->serial) {
-                outbuf[buflen++] = 0x80; // unit serial number
-            }
-            outbuf[buflen++] = 0x83; // device identification
-            if (s->qdev.type == TYPE_DISK) {
-                outbuf[buflen++] = 0xb0; // block limits
-                outbuf[buflen++] = 0xb1; /* block device characteristics */
-                outbuf[buflen++] = 0xb2; // thin provisioning
-            }
-            break;
-        }
-        case 0x80: /* Device serial number, optional */
-        {
-            int l;
+    uint8_t page_code = req->cmd.buf[2];
+    int start, buflen = 0;
 
-            if (!s->serial) {
-                DPRINTF("Inquiry (EVPD[Serial number] not supported\n");
-                return -1;
-            }
+    outbuf[buflen++] = s->qdev.type & 0x1f;
+    outbuf[buflen++] = page_code;
+    outbuf[buflen++] = 0x00;
+    outbuf[buflen++] = 0x00;
+    start = buflen;
 
-            l = strlen(s->serial);
-            if (l > 36) {
-                l = 36;
-            }
+    switch (page_code) {
+    case 0x00: /* Supported page codes, mandatory */
+    {
+        DPRINTF("Inquiry EVPD[Supported pages] "
+                "buffer size %zd\n", req->cmd.xfer);
+        outbuf[buflen++] = 0x00; /* list of supported pages (this page) */
+        if (s->serial) {
+            outbuf[buflen++] = 0x80; /* unit serial number */
+        }
+        outbuf[buflen++] = 0x83; /* device identification */
+        if (s->qdev.type == TYPE_DISK) {
+            outbuf[buflen++] = 0xb0; /* block limits */
+            outbuf[buflen++] = 0xb1; /* block device characteristics */
+            outbuf[buflen++] = 0xb2; /* thin provisioning */
+        }
+        break;
+    }
+    case 0x80: /* Device serial number, optional */
+    {
+        int l;
 
-            DPRINTF("Inquiry EVPD[Serial number] "
-                    "buffer size %zd\n", req->cmd.xfer);
-            memcpy(outbuf+buflen, s->serial, l);
-            buflen += l;
-            break;
+        if (!s->serial) {
+            DPRINTF("Inquiry (EVPD[Serial number] not supported\n");
+            return -1;
         }
 
-        case 0x83: /* Device identification page, mandatory */
-        {
-            const char *str = s->serial ?: blk_name(s->qdev.conf.blk);
-            int max_len = s->serial ? 20 : 255 - 8;
-            int id_len = strlen(str);
+        l = strlen(s->serial);
+        if (l > 36) {
+            l = 36;
+        }
 
-            if (id_len > max_len) {
-                id_len = max_len;
-            }
-            DPRINTF("Inquiry EVPD[Device identification] "
-                    "buffer size %zd\n", req->cmd.xfer);
-
-            outbuf[buflen++] = 0x2; // ASCII
-            outbuf[buflen++] = 0;   // not officially assigned
-            outbuf[buflen++] = 0;   // reserved
-            outbuf[buflen++] = id_len; // length of data following
-            memcpy(outbuf+buflen, str, id_len);
-            buflen += id_len;
-
-            if (s->qdev.wwn) {
-                outbuf[buflen++] = 0x1; // Binary
-                outbuf[buflen++] = 0x3; // NAA
-                outbuf[buflen++] = 0;   // reserved
-                outbuf[buflen++] = 8;
-                stq_be_p(&outbuf[buflen], s->qdev.wwn);
-                buflen += 8;
-            }
+        DPRINTF("Inquiry EVPD[Serial number] "
+                "buffer size %zd\n", req->cmd.xfer);
+        memcpy(outbuf + buflen, s->serial, l);
+        buflen += l;
+        break;
+    }
 
-            if (s->qdev.port_wwn) {
-                outbuf[buflen++] = 0x61; // SAS / Binary
-                outbuf[buflen++] = 0x93; // PIV / Target port / NAA
-                outbuf[buflen++] = 0;    // reserved
-                outbuf[buflen++] = 8;
-                stq_be_p(&outbuf[buflen], s->qdev.port_wwn);
-                buflen += 8;
-            }
+    case 0x83: /* Device identification page, mandatory */
+    {
+        const char *str = s->serial ?: blk_name(s->qdev.conf.blk);
+        int max_len = s->serial ? 20 : 255 - 8;
+        int id_len = strlen(str);
 
-            if (s->port_index) {
-                outbuf[buflen++] = 0x61; // SAS / Binary
-                outbuf[buflen++] = 0x94; // PIV / Target port / relative target port
-                outbuf[buflen++] = 0;    // reserved
-                outbuf[buflen++] = 4;
-                stw_be_p(&outbuf[buflen + 2], s->port_index);
-                buflen += 4;
-            }
-            break;
+        if (id_len > max_len) {
+            id_len = max_len;
         }
-        case 0xb0: /* block limits */
-        {
-            unsigned int unmap_sectors =
-                    s->qdev.conf.discard_granularity / s->qdev.blocksize;
-            unsigned int min_io_size =
-                    s->qdev.conf.min_io_size / s->qdev.blocksize;
-            unsigned int opt_io_size =
-                    s->qdev.conf.opt_io_size / s->qdev.blocksize;
-            unsigned int max_unmap_sectors =
-                    s->max_unmap_size / s->qdev.blocksize;
-            unsigned int max_io_sectors =
-                    s->max_io_size / s->qdev.blocksize;
-
-            if (s->qdev.type == TYPE_ROM) {
-                DPRINTF("Inquiry (EVPD[%02X] not supported for CDROM\n",
-                        page_code);
-                return -1;
-            }
-            if (s->qdev.type == TYPE_DISK) {
-                int max_transfer_blk = blk_get_max_transfer(s->qdev.conf.blk);
-                int max_io_sectors_blk =
-                    max_transfer_blk / s->qdev.blocksize;
-
-                max_io_sectors =
-                    MIN_NON_ZERO(max_io_sectors_blk, max_io_sectors);
-
-                /* min_io_size and opt_io_size can't be greater than
-                 * max_io_sectors */
-                if (min_io_size) {
-                    min_io_size = MIN(min_io_size, max_io_sectors);
-                }
-                if (opt_io_size) {
-                    opt_io_size = MIN(opt_io_size, max_io_sectors);
-                }
-            }
-            /* required VPD size with unmap support */
-            buflen = 0x40;
-            memset(outbuf + 4, 0, buflen - 4);
-
-            outbuf[4] = 0x1; /* wsnz */
-
-            /* optimal transfer length granularity */
-            outbuf[6] = (min_io_size >> 8) & 0xff;
-            outbuf[7] = min_io_size & 0xff;
-
-            /* maximum transfer length */
-            outbuf[8] = (max_io_sectors >> 24) & 0xff;
-            outbuf[9] = (max_io_sectors >> 16) & 0xff;
-            outbuf[10] = (max_io_sectors >> 8) & 0xff;
-            outbuf[11] = max_io_sectors & 0xff;
-
-            /* optimal transfer length */
-            outbuf[12] = (opt_io_size >> 24) & 0xff;
-            outbuf[13] = (opt_io_size >> 16) & 0xff;
-            outbuf[14] = (opt_io_size >> 8) & 0xff;
-            outbuf[15] = opt_io_size & 0xff;
-
-            /* max unmap LBA count, default is 1GB */
-            outbuf[20] = (max_unmap_sectors >> 24) & 0xff;
-            outbuf[21] = (max_unmap_sectors >> 16) & 0xff;
-            outbuf[22] = (max_unmap_sectors >> 8) & 0xff;
-            outbuf[23] = max_unmap_sectors & 0xff;
-
-            /* max unmap descriptors, 255 fit in 4 kb with an 8-byte header.  */
-            outbuf[24] = 0;
-            outbuf[25] = 0;
-            outbuf[26] = 0;
-            outbuf[27] = 255;
-
-            /* optimal unmap granularity */
-            outbuf[28] = (unmap_sectors >> 24) & 0xff;
-            outbuf[29] = (unmap_sectors >> 16) & 0xff;
-            outbuf[30] = (unmap_sectors >> 8) & 0xff;
-            outbuf[31] = unmap_sectors & 0xff;
-
-            /* max write same size */
-            outbuf[36] = 0;
-            outbuf[37] = 0;
-            outbuf[38] = 0;
-            outbuf[39] = 0;
-
-            outbuf[40] = (max_io_sectors >> 24) & 0xff;
-            outbuf[41] = (max_io_sectors >> 16) & 0xff;
-            outbuf[42] = (max_io_sectors >> 8) & 0xff;
-            outbuf[43] = max_io_sectors & 0xff;
-            break;
+        DPRINTF("Inquiry EVPD[Device identification] "
+                "buffer size %zd\n", req->cmd.xfer);
+
+        outbuf[buflen++] = 0x2; /* ASCII */
+        outbuf[buflen++] = 0;   /* not officially assigned */
+        outbuf[buflen++] = 0;   /* reserved */
+        outbuf[buflen++] = id_len; /* length of data following */
+        memcpy(outbuf + buflen, str, id_len);
+        buflen += id_len;
+
+        if (s->qdev.wwn) {
+            outbuf[buflen++] = 0x1; /* Binary */
+            outbuf[buflen++] = 0x3; /* NAA */
+            outbuf[buflen++] = 0;   /* reserved */
+            outbuf[buflen++] = 8;
+            stq_be_p(&outbuf[buflen], s->qdev.wwn);
+            buflen += 8;
         }
-        case 0xb1: /* block device characteristics */
-        {
-            buflen = 8;
-            outbuf[4] = (s->rotation_rate >> 8) & 0xff;
-            outbuf[5] = s->rotation_rate & 0xff;
-            outbuf[6] = 0;
-            outbuf[7] = 0;
-            break;
+
+        if (s->qdev.port_wwn) {
+            outbuf[buflen++] = 0x61; /* SAS / Binary */
+            outbuf[buflen++] = 0x93; /* PIV / Target port / NAA */
+            outbuf[buflen++] = 0;    /* reserved */
+            outbuf[buflen++] = 8;
+            stq_be_p(&outbuf[buflen], s->qdev.port_wwn);
+            buflen += 8;
         }
-        case 0xb2: /* thin provisioning */
-        {
-            buflen = 8;
-            outbuf[4] = 0;
-            outbuf[5] = 0xe0; /* unmap & write_same 10/16 all supported */
-            outbuf[6] = s->qdev.conf.discard_granularity ? 2 : 1;
-            outbuf[7] = 0;
-            break;
+
+        if (s->port_index) {
+            outbuf[buflen++] = 0x61; /* SAS / Binary */
+
+            /* PIV/Target port/relative target port */
+            outbuf[buflen++] = 0x94;
+
+            outbuf[buflen++] = 0;    /* reserved */
+            outbuf[buflen++] = 4;
+            stw_be_p(&outbuf[buflen + 2], s->port_index);
+            buflen += 4;
         }
-        default:
+        break;
+    }
+    case 0xb0: /* block limits */
+    {
+        unsigned int unmap_sectors =
+            s->qdev.conf.discard_granularity / s->qdev.blocksize;
+        unsigned int min_io_size =
+            s->qdev.conf.min_io_size / s->qdev.blocksize;
+        unsigned int opt_io_size =
+            s->qdev.conf.opt_io_size / s->qdev.blocksize;
+        unsigned int max_unmap_sectors =
+            s->max_unmap_size / s->qdev.blocksize;
+        unsigned int max_io_sectors =
+            s->max_io_size / s->qdev.blocksize;
+
+        if (s->qdev.type == TYPE_ROM) {
+            DPRINTF("Inquiry (EVPD[%02X] not supported for CDROM\n",
+                    page_code);
             return -1;
         }
-        /* done with EVPD */
-        assert(buflen - start <= 255);
-        outbuf[start - 1] = buflen - start;
-        return buflen;
+        if (s->qdev.type == TYPE_DISK) {
+            int max_transfer_blk = blk_get_max_transfer(s->qdev.conf.blk);
+            int max_io_sectors_blk =
+                max_transfer_blk / s->qdev.blocksize;
+
+            max_io_sectors =
+                MIN_NON_ZERO(max_io_sectors_blk, max_io_sectors);
+
+            /* min_io_size and opt_io_size can't be greater than
+             * max_io_sectors */
+            if (min_io_size) {
+                min_io_size = MIN(min_io_size, max_io_sectors);
+            }
+            if (opt_io_size) {
+                opt_io_size = MIN(opt_io_size, max_io_sectors);
+            }
+        }
+        /* required VPD size with unmap support */
+        buflen = 0x40;
+        memset(outbuf + 4, 0, buflen - 4);
+
+        outbuf[4] = 0x1; /* wsnz */
+
+        /* optimal transfer length granularity */
+        outbuf[6] = (min_io_size >> 8) & 0xff;
+        outbuf[7] = min_io_size & 0xff;
+
+        /* maximum transfer length */
+        outbuf[8] = (max_io_sectors >> 24) & 0xff;
+        outbuf[9] = (max_io_sectors >> 16) & 0xff;
+        outbuf[10] = (max_io_sectors >> 8) & 0xff;
+        outbuf[11] = max_io_sectors & 0xff;
+
+        /* optimal transfer length */
+        outbuf[12] = (opt_io_size >> 24) & 0xff;
+        outbuf[13] = (opt_io_size >> 16) & 0xff;
+        outbuf[14] = (opt_io_size >> 8) & 0xff;
+        outbuf[15] = opt_io_size & 0xff;
+
+        /* max unmap LBA count, default is 1GB */
+        outbuf[20] = (max_unmap_sectors >> 24) & 0xff;
+        outbuf[21] = (max_unmap_sectors >> 16) & 0xff;
+        outbuf[22] = (max_unmap_sectors >> 8) & 0xff;
+        outbuf[23] = max_unmap_sectors & 0xff;
+
+        /* max unmap descriptors, 255 fit in 4 kb with an 8-byte header */
+        outbuf[24] = 0;
+        outbuf[25] = 0;
+        outbuf[26] = 0;
+        outbuf[27] = 255;
+
+        /* optimal unmap granularity */
+        outbuf[28] = (unmap_sectors >> 24) & 0xff;
+        outbuf[29] = (unmap_sectors >> 16) & 0xff;
+        outbuf[30] = (unmap_sectors >> 8) & 0xff;
+        outbuf[31] = unmap_sectors & 0xff;
+
+        /* max write same size */
+        outbuf[36] = 0;
+        outbuf[37] = 0;
+        outbuf[38] = 0;
+        outbuf[39] = 0;
+
+        outbuf[40] = (max_io_sectors >> 24) & 0xff;
+        outbuf[41] = (max_io_sectors >> 16) & 0xff;
+        outbuf[42] = (max_io_sectors >> 8) & 0xff;
+        outbuf[43] = max_io_sectors & 0xff;
+        break;
+    }
+    case 0xb1: /* block device characteristics */
+    {
+        buflen = 8;
+        outbuf[4] = (s->rotation_rate >> 8) & 0xff;
+        outbuf[5] = s->rotation_rate & 0xff;
+        outbuf[6] = 0;
+        outbuf[7] = 0;
+        break;
+    }
+    case 0xb2: /* thin provisioning */
+    {
+        buflen = 8;
+        outbuf[4] = 0;
+        outbuf[5] = 0xe0; /* unmap & write_same 10/16 all supported */
+        outbuf[6] = s->qdev.conf.discard_granularity ? 2 : 1;
+        outbuf[7] = 0;
+        break;
+    }
+    default:
+        return -1;
+    }
+    /* done with EVPD */
+    assert(buflen - start <= 255);
+    outbuf[start - 1] = buflen - start;
+    return buflen;
+}
+
+static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
+{
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    int buflen = 0;
+
+    if (req->cmd.buf[1] & 0x1) {
+        /* Vital product data */
+        return scsi_disk_emulate_vpd_page(req, outbuf);
     }
 
     /* Standard INQUIRY data */
@@ -3039,6 +3048,10 @@ static Property scsi_block_properties[] = {
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
+    DEFINE_PROP_UINT64("max_unmap_size", SCSIDiskState, max_unmap_size,
+                       DEFAULT_MAX_UNMAP_SIZE),
+    DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
+                       DEFAULT_MAX_IO_SIZE),
     DEFINE_PROP_INT32("scsi_version", SCSIDiskState, qdev.default_scsi_version,
                       -1),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 03bce8f..a04a704 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -142,6 +142,43 @@ static int execute_command(BlockBackend *blk,
     return 0;
 }
 
+static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
+{
+    /*
+     *  EVPD set to zero returns the standard INQUIRY data.
+     *
+     *  Check if scsi_version is unset (-1) to avoid re-defining it
+     *  each time an INQUIRY with standard data is received.
+     *  scsi_version is initialized with -1 in scsi_generic_reset
+     *  and scsi_disk_reset, making sure that we'll set the
+     *  scsi_version after a reset. If the version field of the
+     *  INQUIRY response somehow changes after a guest reboot,
+     *  we'll be able to keep track of it.
+     *
+     *  On SCSI-2 and older, first 3 bits of byte 2 is the
+     *  ANSI-approved version, while on later versions the
+     *  whole byte 2 contains the version. Check if we're dealing
+     *  with a newer version and, in that case, assign the
+     *  whole byte.
+     */
+    if (s->scsi_version == -1 && !(r->req.cmd.buf[1] & 0x01)) {
+        s->scsi_version = r->buf[2] & 0x07;
+        if (s->scsi_version > 2) {
+            s->scsi_version = r->buf[2];
+        }
+    }
+    if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
+        uint32_t max_transfer =
+            blk_get_max_transfer(s->conf.blk) / s->blocksize;
+
+        assert(max_transfer);
+        stl_be_p(&r->buf[8], max_transfer);
+        /* Also take care of the opt xfer len. */
+        stl_be_p(&r->buf[12],
+                 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+    }
+}
+
 static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
@@ -194,39 +231,7 @@ static void scsi_read_complete(void * opaque, int ret)
         }
     }
     if (r->req.cmd.buf[0] == INQUIRY) {
-        /*
-         *  EVPD set to zero returns the standard INQUIRY data.
-         *
-         *  Check if scsi_version is unset (-1) to avoid re-defining it
-         *  each time an INQUIRY with standard data is received.
-         *  scsi_version is initialized with -1 in scsi_generic_reset
-         *  and scsi_disk_reset, making sure that we'll set the
-         *  scsi_version after a reset. If the version field of the
-         *  INQUIRY response somehow changes after a guest reboot,
-         *  we'll be able to keep track of it.
-         *
-         *  On SCSI-2 and older, first 3 bits of byte 2 is the
-         *  ANSI-approved version, while on later versions the
-         *  whole byte 2 contains the version. Check if we're dealing
-         *  with a newer version and, in that case, assign the
-         *  whole byte.
-         */
-        if (s->scsi_version == -1 && !(r->req.cmd.buf[1] & 0x01)) {
-            s->scsi_version = r->buf[2] & 0x07;
-            if (s->scsi_version > 2) {
-                s->scsi_version = r->buf[2];
-            }
-        }
-        if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
-            uint32_t max_transfer =
-                blk_get_max_transfer(s->conf.blk) / s->blocksize;
-
-            assert(max_transfer);
-            stl_be_p(&r->buf[8], max_transfer);
-            /* Also take care of the opt xfer len. */
-            stl_be_p(&r->buf[12],
-                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
-        }
+        scsi_handle_inquiry_reply(r, s);
     }
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index e35137e..138eb79 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -186,6 +186,7 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense);
 void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_identification(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
+int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
 
 /* scsi-generic.c. */
-- 
1.8.3.1
