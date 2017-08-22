Received: from eggs.gnu.org ([2001:4830:134:3::10]:49646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk94y-0002dE-V6
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk94v-0005mR-2G
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk94u-0005fz-I9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:18:44 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Aug 2017 15:18:24 +0200
Message-Id: <20170822131832.20191-3-pbonzini@redhat.com>
In-Reply-To: <20170822131832.20191-1-pbonzini@redhat.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] scsi: move non-emulation specific code
 to scsi/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com

There is a bunch of SCSI code that is shared by block/iscsi.c and
hw/scsi, and the introduction of the persistent reservation helper
will add more instances of this.  There is also include/block/scsi.h,
which actually is not part of the core block layer.

Create a directory for this kind of shared code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS            |   7 +
 Makefile.objs          |   2 +-
 hw/scsi/scsi-bus.c     | 397 ------------------------------------------------
 hw/scsi/scsi-generic.c |   8 -
 include/block/scsi.h   |   2 -
 include/hw/scsi/scsi.h |  94 +-----------
 include/scsi/utils.h   | 116 ++++++++++++++
 scsi/Makefile.objs     |   1 +
 scsi/utils.c           | 403 +++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 529 insertions(+), 501 deletions(-)
 create mode 100644 include/scsi/utils.h
 create mode 100644 scsi/Makefile.objs
 create mode 100644 scsi/utils.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ccee28b12d..fa6e21cd38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1213,6 +1213,13 @@ F: migration/block*
 F: include/block/aio.h
 T: git git://github.com/stefanha/qemu.git block
 
+Block SCSI subsystem
+M: Paolo Bonzini <pbonzini@redhat.com>
+L: qemu-block@nongnu.org
+S: Supported
+F: include/scsi/*
+F: scsi/*
+
 Block Jobs
 M: Jeff Cody <jcody@redhat.com>
 L: qemu-block@nongnu.org
diff --git a/Makefile.objs b/Makefile.objs
index 24a4ea08b8..f68aa3b60d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -11,7 +11,7 @@ chardev-obj-y = chardev/
 
 block-obj-y += nbd/
 block-obj-y += block.o blockjob.o
-block-obj-y += block/
+block-obj-y += block/ scsi/
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 890f8fcc83..300912d213 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -935,36 +935,6 @@ static int ata_passthrough_16_xfer(SCSIDevice *dev, uint8_t *buf)
     return xfer * unit;
 }
 
-uint32_t scsi_data_cdb_xfer(uint8_t *buf)
-{
-    if ((buf[0] >> 5) == 0 && buf[4] == 0) {
-        return 256;
-    } else {
-        return scsi_cdb_xfer(buf);
-    }
-}
-
-uint32_t scsi_cdb_xfer(uint8_t *buf)
-{
-    switch (buf[0] >> 5) {
-    case 0:
-        return buf[4];
-        break;
-    case 1:
-    case 2:
-        return lduw_be_p(&buf[7]);
-        break;
-    case 4:
-        return ldl_be_p(&buf[10]) & 0xffffffffULL;
-        break;
-    case 5:
-        return ldl_be_p(&buf[6]) & 0xffffffffULL;
-        break;
-    default:
-        return -1;
-    }
-}
-
 static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
 {
     cmd->xfer = scsi_cdb_xfer(buf);
@@ -1277,53 +1247,6 @@ static void scsi_cmd_xfer_mode(SCSICommand *cmd)
     }
 }
 
-static uint64_t scsi_cmd_lba(SCSICommand *cmd)
-{
-    uint8_t *buf = cmd->buf;
-    uint64_t lba;
-
-    switch (buf[0] >> 5) {
-    case 0:
-        lba = ldl_be_p(&buf[0]) & 0x1fffff;
-        break;
-    case 1:
-    case 2:
-    case 5:
-        lba = ldl_be_p(&buf[2]) & 0xffffffffULL;
-        break;
-    case 4:
-        lba = ldq_be_p(&buf[2]);
-        break;
-    default:
-        lba = -1;
-
-    }
-    return lba;
-}
-
-int scsi_cdb_length(uint8_t *buf) {
-    int cdb_len;
-
-    switch (buf[0] >> 5) {
-    case 0:
-        cdb_len = 6;
-        break;
-    case 1:
-    case 2:
-        cdb_len = 10;
-        break;
-    case 4:
-        cdb_len = 16;
-        break;
-    case 5:
-        cdb_len = 12;
-        break;
-    default:
-        cdb_len = -1;
-    }
-    return cdb_len;
-}
-
 int scsi_req_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf)
 {
     int rc;
@@ -1370,326 +1293,6 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense)
     }
 }
 
-/*
- * Predefined sense codes
- */
-
-/* No sense data available */
-const struct SCSISense sense_code_NO_SENSE = {
-    .key = NO_SENSE , .asc = 0x00 , .ascq = 0x00
-};
-
-/* LUN not ready, Manual intervention required */
-const struct SCSISense sense_code_LUN_NOT_READY = {
-    .key = NOT_READY, .asc = 0x04, .ascq = 0x03
-};
-
-/* LUN not ready, Medium not present */
-const struct SCSISense sense_code_NO_MEDIUM = {
-    .key = NOT_READY, .asc = 0x3a, .ascq = 0x00
-};
-
-/* LUN not ready, medium removal prevented */
-const struct SCSISense sense_code_NOT_READY_REMOVAL_PREVENTED = {
-    .key = NOT_READY, .asc = 0x53, .ascq = 0x02
-};
-
-/* Hardware error, internal target failure */
-const struct SCSISense sense_code_TARGET_FAILURE = {
-    .key = HARDWARE_ERROR, .asc = 0x44, .ascq = 0x00
-};
-
-/* Illegal request, invalid command operation code */
-const struct SCSISense sense_code_INVALID_OPCODE = {
-    .key = ILLEGAL_REQUEST, .asc = 0x20, .ascq = 0x00
-};
-
-/* Illegal request, LBA out of range */
-const struct SCSISense sense_code_LBA_OUT_OF_RANGE = {
-    .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x00
-};
-
-/* Illegal request, Invalid field in CDB */
-const struct SCSISense sense_code_INVALID_FIELD = {
-    .key = ILLEGAL_REQUEST, .asc = 0x24, .ascq = 0x00
-};
-
-/* Illegal request, Invalid field in parameter list */
-const struct SCSISense sense_code_INVALID_PARAM = {
-    .key = ILLEGAL_REQUEST, .asc = 0x26, .ascq = 0x00
-};
-
-/* Illegal request, Parameter list length error */
-const struct SCSISense sense_code_INVALID_PARAM_LEN = {
-    .key = ILLEGAL_REQUEST, .asc = 0x1a, .ascq = 0x00
-};
-
-/* Illegal request, LUN not supported */
-const struct SCSISense sense_code_LUN_NOT_SUPPORTED = {
-    .key = ILLEGAL_REQUEST, .asc = 0x25, .ascq = 0x00
-};
-
-/* Illegal request, Saving parameters not supported */
-const struct SCSISense sense_code_SAVING_PARAMS_NOT_SUPPORTED = {
-    .key = ILLEGAL_REQUEST, .asc = 0x39, .ascq = 0x00
-};
-
-/* Illegal request, Incompatible medium installed */
-const struct SCSISense sense_code_INCOMPATIBLE_FORMAT = {
-    .key = ILLEGAL_REQUEST, .asc = 0x30, .ascq = 0x00
-};
-
-/* Illegal request, medium removal prevented */
-const struct SCSISense sense_code_ILLEGAL_REQ_REMOVAL_PREVENTED = {
-    .key = ILLEGAL_REQUEST, .asc = 0x53, .ascq = 0x02
-};
-
-/* Illegal request, Invalid Transfer Tag */
-const struct SCSISense sense_code_INVALID_TAG = {
-    .key = ILLEGAL_REQUEST, .asc = 0x4b, .ascq = 0x01
-};
-
-/* Command aborted, I/O process terminated */
-const struct SCSISense sense_code_IO_ERROR = {
-    .key = ABORTED_COMMAND, .asc = 0x00, .ascq = 0x06
-};
-
-/* Command aborted, I_T Nexus loss occurred */
-const struct SCSISense sense_code_I_T_NEXUS_LOSS = {
-    .key = ABORTED_COMMAND, .asc = 0x29, .ascq = 0x07
-};
-
-/* Command aborted, Logical Unit failure */
-const struct SCSISense sense_code_LUN_FAILURE = {
-    .key = ABORTED_COMMAND, .asc = 0x3e, .ascq = 0x01
-};
-
-/* Command aborted, Overlapped Commands Attempted */
-const struct SCSISense sense_code_OVERLAPPED_COMMANDS = {
-    .key = ABORTED_COMMAND, .asc = 0x4e, .ascq = 0x00
-};
-
-/* Unit attention, Capacity data has changed */
-const struct SCSISense sense_code_CAPACITY_CHANGED = {
-    .key = UNIT_ATTENTION, .asc = 0x2a, .ascq = 0x09
-};
-
-/* Unit attention, Power on, reset or bus device reset occurred */
-const struct SCSISense sense_code_RESET = {
-    .key = UNIT_ATTENTION, .asc = 0x29, .ascq = 0x00
-};
-
-/* Unit attention, No medium */
-const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM = {
-    .key = UNIT_ATTENTION, .asc = 0x3a, .ascq = 0x00
-};
-
-/* Unit attention, Medium may have changed */
-const struct SCSISense sense_code_MEDIUM_CHANGED = {
-    .key = UNIT_ATTENTION, .asc = 0x28, .ascq = 0x00
-};
-
-/* Unit attention, Reported LUNs data has changed */
-const struct SCSISense sense_code_REPORTED_LUNS_CHANGED = {
-    .key = UNIT_ATTENTION, .asc = 0x3f, .ascq = 0x0e
-};
-
-/* Unit attention, Device internal reset */
-const struct SCSISense sense_code_DEVICE_INTERNAL_RESET = {
-    .key = UNIT_ATTENTION, .asc = 0x29, .ascq = 0x04
-};
-
-/* Data Protection, Write Protected */
-const struct SCSISense sense_code_WRITE_PROTECTED = {
-    .key = DATA_PROTECT, .asc = 0x27, .ascq = 0x00
-};
-
-/* Data Protection, Space Allocation Failed Write Protect */
-const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
-    .key = DATA_PROTECT, .asc = 0x27, .ascq = 0x07
-};
-
-/*
- * scsi_convert_sense
- *
- * Convert between fixed and descriptor sense buffers
- */
-int scsi_convert_sense(uint8_t *in_buf, int in_len,
-                       uint8_t *buf, int len, bool fixed)
-{
-    bool fixed_in;
-    SCSISense sense;
-    if (!fixed && len < 8) {
-        return 0;
-    }
-
-    if (in_len == 0) {
-        sense.key = NO_SENSE;
-        sense.asc = 0;
-        sense.ascq = 0;
-    } else {
-        fixed_in = (in_buf[0] & 2) == 0;
-
-        if (fixed == fixed_in) {
-            memcpy(buf, in_buf, MIN(len, in_len));
-            return MIN(len, in_len);
-        }
-
-        if (fixed_in) {
-            sense.key = in_buf[2];
-            sense.asc = in_buf[12];
-            sense.ascq = in_buf[13];
-        } else {
-            sense.key = in_buf[1];
-            sense.asc = in_buf[2];
-            sense.ascq = in_buf[3];
-        }
-    }
-
-    memset(buf, 0, len);
-    if (fixed) {
-        /* Return fixed format sense buffer */
-        buf[0] = 0x70;
-        buf[2] = sense.key;
-        buf[7] = 10;
-        buf[12] = sense.asc;
-        buf[13] = sense.ascq;
-        return MIN(len, SCSI_SENSE_LEN);
-    } else {
-        /* Return descriptor format sense buffer */
-        buf[0] = 0x72;
-        buf[1] = sense.key;
-        buf[2] = sense.asc;
-        buf[3] = sense.ascq;
-        return 8;
-    }
-}
-
-const char *scsi_command_name(uint8_t cmd)
-{
-    static const char *names[] = {
-        [ TEST_UNIT_READY          ] = "TEST_UNIT_READY",
-        [ REWIND                   ] = "REWIND",
-        [ REQUEST_SENSE            ] = "REQUEST_SENSE",
-        [ FORMAT_UNIT              ] = "FORMAT_UNIT",
-        [ READ_BLOCK_LIMITS        ] = "READ_BLOCK_LIMITS",
-        [ REASSIGN_BLOCKS          ] = "REASSIGN_BLOCKS/INITIALIZE ELEMENT STATUS",
-        /* LOAD_UNLOAD and INITIALIZE_ELEMENT_STATUS use the same operation code */
-        [ READ_6                   ] = "READ_6",
-        [ WRITE_6                  ] = "WRITE_6",
-        [ SET_CAPACITY             ] = "SET_CAPACITY",
-        [ READ_REVERSE             ] = "READ_REVERSE",
-        [ WRITE_FILEMARKS          ] = "WRITE_FILEMARKS",
-        [ SPACE                    ] = "SPACE",
-        [ INQUIRY                  ] = "INQUIRY",
-        [ RECOVER_BUFFERED_DATA    ] = "RECOVER_BUFFERED_DATA",
-        [ MAINTENANCE_IN           ] = "MAINTENANCE_IN",
-        [ MAINTENANCE_OUT          ] = "MAINTENANCE_OUT",
-        [ MODE_SELECT              ] = "MODE_SELECT",
-        [ RESERVE                  ] = "RESERVE",
-        [ RELEASE                  ] = "RELEASE",
-        [ COPY                     ] = "COPY",
-        [ ERASE                    ] = "ERASE",
-        [ MODE_SENSE               ] = "MODE_SENSE",
-        [ START_STOP               ] = "START_STOP/LOAD_UNLOAD",
-        /* LOAD_UNLOAD and START_STOP use the same operation code */
-        [ RECEIVE_DIAGNOSTIC       ] = "RECEIVE_DIAGNOSTIC",
-        [ SEND_DIAGNOSTIC          ] = "SEND_DIAGNOSTIC",
-        [ ALLOW_MEDIUM_REMOVAL     ] = "ALLOW_MEDIUM_REMOVAL",
-        [ READ_CAPACITY_10         ] = "READ_CAPACITY_10",
-        [ READ_10                  ] = "READ_10",
-        [ WRITE_10                 ] = "WRITE_10",
-        [ SEEK_10                  ] = "SEEK_10/POSITION_TO_ELEMENT",
-        /* SEEK_10 and POSITION_TO_ELEMENT use the same operation code */
-        [ WRITE_VERIFY_10          ] = "WRITE_VERIFY_10",
-        [ VERIFY_10                ] = "VERIFY_10",
-        [ SEARCH_HIGH              ] = "SEARCH_HIGH",
-        [ SEARCH_EQUAL             ] = "SEARCH_EQUAL",
-        [ SEARCH_LOW               ] = "SEARCH_LOW",
-        [ SET_LIMITS               ] = "SET_LIMITS",
-        [ PRE_FETCH                ] = "PRE_FETCH/READ_POSITION",
-        /* READ_POSITION and PRE_FETCH use the same operation code */
-        [ SYNCHRONIZE_CACHE        ] = "SYNCHRONIZE_CACHE",
-        [ LOCK_UNLOCK_CACHE        ] = "LOCK_UNLOCK_CACHE",
-        [ READ_DEFECT_DATA         ] = "READ_DEFECT_DATA/INITIALIZE_ELEMENT_STATUS_WITH_RANGE",
-        /* READ_DEFECT_DATA and INITIALIZE_ELEMENT_STATUS_WITH_RANGE use the same operation code */
-        [ MEDIUM_SCAN              ] = "MEDIUM_SCAN",
-        [ COMPARE                  ] = "COMPARE",
-        [ COPY_VERIFY              ] = "COPY_VERIFY",
-        [ WRITE_BUFFER             ] = "WRITE_BUFFER",
-        [ READ_BUFFER              ] = "READ_BUFFER",
-        [ UPDATE_BLOCK             ] = "UPDATE_BLOCK",
-        [ READ_LONG_10             ] = "READ_LONG_10",
-        [ WRITE_LONG_10            ] = "WRITE_LONG_10",
-        [ CHANGE_DEFINITION        ] = "CHANGE_DEFINITION",
-        [ WRITE_SAME_10            ] = "WRITE_SAME_10",
-        [ UNMAP                    ] = "UNMAP",
-        [ READ_TOC                 ] = "READ_TOC",
-        [ REPORT_DENSITY_SUPPORT   ] = "REPORT_DENSITY_SUPPORT",
-        [ SANITIZE                 ] = "SANITIZE",
-        [ GET_CONFIGURATION        ] = "GET_CONFIGURATION",
-        [ LOG_SELECT               ] = "LOG_SELECT",
-        [ LOG_SENSE                ] = "LOG_SENSE",
-        [ MODE_SELECT_10           ] = "MODE_SELECT_10",
-        [ RESERVE_10               ] = "RESERVE_10",
-        [ RELEASE_10               ] = "RELEASE_10",
-        [ MODE_SENSE_10            ] = "MODE_SENSE_10",
-        [ PERSISTENT_RESERVE_IN    ] = "PERSISTENT_RESERVE_IN",
-        [ PERSISTENT_RESERVE_OUT   ] = "PERSISTENT_RESERVE_OUT",
-        [ WRITE_FILEMARKS_16       ] = "WRITE_FILEMARKS_16",
-        [ EXTENDED_COPY            ] = "EXTENDED_COPY",
-        [ ATA_PASSTHROUGH_16       ] = "ATA_PASSTHROUGH_16",
-        [ ACCESS_CONTROL_IN        ] = "ACCESS_CONTROL_IN",
-        [ ACCESS_CONTROL_OUT       ] = "ACCESS_CONTROL_OUT",
-        [ READ_16                  ] = "READ_16",
-        [ COMPARE_AND_WRITE        ] = "COMPARE_AND_WRITE",
-        [ WRITE_16                 ] = "WRITE_16",
-        [ WRITE_VERIFY_16          ] = "WRITE_VERIFY_16",
-        [ VERIFY_16                ] = "VERIFY_16",
-        [ PRE_FETCH_16             ] = "PRE_FETCH_16",
-        [ SYNCHRONIZE_CACHE_16     ] = "SPACE_16/SYNCHRONIZE_CACHE_16",
-        /* SPACE_16 and SYNCHRONIZE_CACHE_16 use the same operation code */
-        [ LOCATE_16                ] = "LOCATE_16",
-        [ WRITE_SAME_16            ] = "ERASE_16/WRITE_SAME_16",
-        /* ERASE_16 and WRITE_SAME_16 use the same operation code */
-        [ SERVICE_ACTION_IN_16     ] = "SERVICE_ACTION_IN_16",
-        [ WRITE_LONG_16            ] = "WRITE_LONG_16",
-        [ REPORT_LUNS              ] = "REPORT_LUNS",
-        [ ATA_PASSTHROUGH_12       ] = "BLANK/ATA_PASSTHROUGH_12",
-        [ MOVE_MEDIUM              ] = "MOVE_MEDIUM",
-        [ EXCHANGE_MEDIUM          ] = "EXCHANGE MEDIUM",
-        [ READ_12                  ] = "READ_12",
-        [ WRITE_12                 ] = "WRITE_12",
-        [ ERASE_12                 ] = "ERASE_12/GET_PERFORMANCE",
-        /* ERASE_12 and GET_PERFORMANCE use the same operation code */
-        [ SERVICE_ACTION_IN_12     ] = "SERVICE_ACTION_IN_12",
-        [ WRITE_VERIFY_12          ] = "WRITE_VERIFY_12",
-        [ VERIFY_12                ] = "VERIFY_12",
-        [ SEARCH_HIGH_12           ] = "SEARCH_HIGH_12",
-        [ SEARCH_EQUAL_12          ] = "SEARCH_EQUAL_12",
-        [ SEARCH_LOW_12            ] = "SEARCH_LOW_12",
-        [ READ_ELEMENT_STATUS      ] = "READ_ELEMENT_STATUS",
-        [ SEND_VOLUME_TAG          ] = "SEND_VOLUME_TAG/SET_STREAMING",
-        /* SEND_VOLUME_TAG and SET_STREAMING use the same operation code */
-        [ READ_CD                  ] = "READ_CD",
-        [ READ_DEFECT_DATA_12      ] = "READ_DEFECT_DATA_12",
-        [ READ_DVD_STRUCTURE       ] = "READ_DVD_STRUCTURE",
-        [ RESERVE_TRACK            ] = "RESERVE_TRACK",
-        [ SEND_CUE_SHEET           ] = "SEND_CUE_SHEET",
-        [ SEND_DVD_STRUCTURE       ] = "SEND_DVD_STRUCTURE",
-        [ SET_CD_SPEED             ] = "SET_CD_SPEED",
-        [ SET_READ_AHEAD           ] = "SET_READ_AHEAD",
-        [ ALLOW_OVERWRITE          ] = "ALLOW_OVERWRITE",
-        [ MECHANISM_STATUS         ] = "MECHANISM_STATUS",
-        [ GET_EVENT_STATUS_NOTIFICATION ] = "GET_EVENT_STATUS_NOTIFICATION",
-        [ READ_DISC_INFORMATION    ] = "READ_DISC_INFORMATION",
-    };
-
-    if (cmd >= ARRAY_SIZE(names) || names[cmd] == NULL)
-        return "*UNKNOWN*";
-    return names[cmd];
-}
-
 SCSIRequest *scsi_req_ref(SCSIRequest *req)
 {
     assert(req->refcount > 0);
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7e1cbab77e..7a8f500934 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -36,14 +36,6 @@ do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
 #include <scsi/sg.h>
 #include "block/scsi.h"
 
-#define SG_ERR_DRIVER_TIMEOUT  0x06
-#define SG_ERR_DRIVER_SENSE    0x08
-
-#define SG_ERR_DID_OK          0x00
-#define SG_ERR_DID_NO_CONNECT  0x01
-#define SG_ERR_DID_BUS_BUSY    0x02
-#define SG_ERR_DID_TIME_OUT    0x03
-
 #ifndef MAX_UINT
 #define MAX_UINT ((unsigned int)-1)
 #endif
diff --git a/include/block/scsi.h b/include/block/scsi.h
index cdf0a58a07..a141dd71f8 100644
--- a/include/block/scsi.h
+++ b/include/block/scsi.h
@@ -150,8 +150,6 @@
 #define READ_CD               0xbe
 #define SEND_DVD_STRUCTURE    0xbf
 
-const char *scsi_command_name(uint8_t cmd);
-
 /*
  * SERVICE ACTION IN subcodes
  */
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 6ef67fb504..23a8ee6a7d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -4,45 +4,20 @@
 #include "hw/qdev.h"
 #include "hw/block/block.h"
 #include "sysemu/sysemu.h"
+#include "scsi/utils.h"
 #include "qemu/notify.h"
 
 #define MAX_SCSI_DEVS	255
 
-#define SCSI_CMD_BUF_SIZE      16
-#define SCSI_SENSE_LEN         18
-#define SCSI_SENSE_LEN_SCANNER 32
-#define SCSI_INQUIRY_LEN       36
-
 typedef struct SCSIBus SCSIBus;
 typedef struct SCSIBusInfo SCSIBusInfo;
-typedef struct SCSICommand SCSICommand;
 typedef struct SCSIDevice SCSIDevice;
 typedef struct SCSIRequest SCSIRequest;
 typedef struct SCSIReqOps SCSIReqOps;
 
-enum SCSIXferMode {
-    SCSI_XFER_NONE,      /*  TEST_UNIT_READY, ...            */
-    SCSI_XFER_FROM_DEV,  /*  READ, INQUIRY, MODE_SENSE, ...  */
-    SCSI_XFER_TO_DEV,    /*  WRITE, MODE_SELECT, ...         */
-};
-
-typedef struct SCSISense {
-    uint8_t key;
-    uint8_t asc;
-    uint8_t ascq;
-} SCSISense;
-
 #define SCSI_SENSE_BUF_SIZE_OLD 96
 #define SCSI_SENSE_BUF_SIZE 252
 
-struct SCSICommand {
-    uint8_t buf[SCSI_CMD_BUF_SIZE];
-    int len;
-    size_t xfer;
-    uint64_t lba;
-    enum SCSIXferMode mode;
-};
-
 struct SCSIRequest {
     SCSIBus           *bus;
     SCSIDevice        *dev;
@@ -180,73 +155,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus, bool deprecated);
 void scsi_legacy_handle_cmdline(void);
 
-/*
- * Predefined sense codes
- */
-
-/* No sense data available */
-extern const struct SCSISense sense_code_NO_SENSE;
-/* LUN not ready, Manual intervention required */
-extern const struct SCSISense sense_code_LUN_NOT_READY;
-/* LUN not ready, Medium not present */
-extern const struct SCSISense sense_code_NO_MEDIUM;
-/* LUN not ready, medium removal prevented */
-extern const struct SCSISense sense_code_NOT_READY_REMOVAL_PREVENTED;
-/* Hardware error, internal target failure */
-extern const struct SCSISense sense_code_TARGET_FAILURE;
-/* Illegal request, invalid command operation code */
-extern const struct SCSISense sense_code_INVALID_OPCODE;
-/* Illegal request, LBA out of range */
-extern const struct SCSISense sense_code_LBA_OUT_OF_RANGE;
-/* Illegal request, Invalid field in CDB */
-extern const struct SCSISense sense_code_INVALID_FIELD;
-/* Illegal request, Invalid field in parameter list */
-extern const struct SCSISense sense_code_INVALID_PARAM;
-/* Illegal request, Parameter list length error */
-extern const struct SCSISense sense_code_INVALID_PARAM_LEN;
-/* Illegal request, LUN not supported */
-extern const struct SCSISense sense_code_LUN_NOT_SUPPORTED;
-/* Illegal request, Saving parameters not supported */
-extern const struct SCSISense sense_code_SAVING_PARAMS_NOT_SUPPORTED;
-/* Illegal request, Incompatible format */
-extern const struct SCSISense sense_code_INCOMPATIBLE_FORMAT;
-/* Illegal request, medium removal prevented */
-extern const struct SCSISense sense_code_ILLEGAL_REQ_REMOVAL_PREVENTED;
-/* Illegal request, Invalid Transfer Tag */
-extern const struct SCSISense sense_code_INVALID_TAG;
-/* Command aborted, I/O process terminated */
-extern const struct SCSISense sense_code_IO_ERROR;
-/* Command aborted, I_T Nexus loss occurred */
-extern const struct SCSISense sense_code_I_T_NEXUS_LOSS;
-/* Command aborted, Logical Unit failure */
-extern const struct SCSISense sense_code_LUN_FAILURE;
-/* Command aborted, Overlapped Commands Attempted */
-extern const struct SCSISense sense_code_OVERLAPPED_COMMANDS;
-/* LUN not ready, Capacity data has changed */
-extern const struct SCSISense sense_code_CAPACITY_CHANGED;
-/* LUN not ready, Medium not present */
-extern const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM;
-/* Unit attention, Power on, reset or bus device reset occurred */
-extern const struct SCSISense sense_code_RESET;
-/* Unit attention, Medium may have changed*/
-extern const struct SCSISense sense_code_MEDIUM_CHANGED;
-/* Unit attention, Reported LUNs data has changed */
-extern const struct SCSISense sense_code_REPORTED_LUNS_CHANGED;
-/* Unit attention, Device internal reset */
-extern const struct SCSISense sense_code_DEVICE_INTERNAL_RESET;
-/* Data Protection, Write Protected */
-extern const struct SCSISense sense_code_WRITE_PROTECTED;
-/* Data Protection, Space Allocation Failed Write Protect */
-extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
-
-#define SENSE_CODE(x) sense_code_ ## x
-
-uint32_t scsi_data_cdb_xfer(uint8_t *buf);
-uint32_t scsi_cdb_xfer(uint8_t *buf);
-int scsi_cdb_length(uint8_t *buf);
-int scsi_convert_sense(uint8_t *in_buf, int in_len,
-                       uint8_t *buf, int len, bool fixed);
-
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
                             uint32_t tag, uint32_t lun, void *hba_private);
 SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
new file mode 100644
index 0000000000..35a74436bf
--- /dev/null
+++ b/include/scsi/utils.h
@@ -0,0 +1,116 @@
+#ifndef SCSI_UTILS_H
+#define SCSI_UTILS_H 1
+
+#ifdef CONFIG_LINUX
+#include <scsi/sg.h>
+#endif
+
+#define SCSI_CMD_BUF_SIZE      16
+#define SCSI_SENSE_LEN         18
+#define SCSI_SENSE_LEN_SCANNER 32
+#define SCSI_INQUIRY_LEN       36
+
+enum SCSIXferMode {
+    SCSI_XFER_NONE,      /*  TEST_UNIT_READY, ...            */
+    SCSI_XFER_FROM_DEV,  /*  READ, INQUIRY, MODE_SENSE, ...  */
+    SCSI_XFER_TO_DEV,    /*  WRITE, MODE_SELECT, ...         */
+};
+
+typedef struct SCSICommand {
+    uint8_t buf[SCSI_CMD_BUF_SIZE];
+    int len;
+    size_t xfer;
+    uint64_t lba;
+    enum SCSIXferMode mode;
+} SCSICommand;
+
+typedef struct SCSISense {
+    uint8_t key;
+    uint8_t asc;
+    uint8_t ascq;
+} SCSISense;
+
+/*
+ * Predefined sense codes
+ */
+
+/* No sense data available */
+extern const struct SCSISense sense_code_NO_SENSE;
+/* LUN not ready, Manual intervention required */
+extern const struct SCSISense sense_code_LUN_NOT_READY;
+/* LUN not ready, Medium not present */
+extern const struct SCSISense sense_code_NO_MEDIUM;
+/* LUN not ready, medium removal prevented */
+extern const struct SCSISense sense_code_NOT_READY_REMOVAL_PREVENTED;
+/* Hardware error, internal target failure */
+extern const struct SCSISense sense_code_TARGET_FAILURE;
+/* Illegal request, invalid command operation code */
+extern const struct SCSISense sense_code_INVALID_OPCODE;
+/* Illegal request, LBA out of range */
+extern const struct SCSISense sense_code_LBA_OUT_OF_RANGE;
+/* Illegal request, Invalid field in CDB */
+extern const struct SCSISense sense_code_INVALID_FIELD;
+/* Illegal request, Invalid field in parameter list */
+extern const struct SCSISense sense_code_INVALID_PARAM;
+/* Illegal request, Parameter list length error */
+extern const struct SCSISense sense_code_INVALID_PARAM_LEN;
+/* Illegal request, LUN not supported */
+extern const struct SCSISense sense_code_LUN_NOT_SUPPORTED;
+/* Illegal request, Saving parameters not supported */
+extern const struct SCSISense sense_code_SAVING_PARAMS_NOT_SUPPORTED;
+/* Illegal request, Incompatible format */
+extern const struct SCSISense sense_code_INCOMPATIBLE_FORMAT;
+/* Illegal request, medium removal prevented */
+extern const struct SCSISense sense_code_ILLEGAL_REQ_REMOVAL_PREVENTED;
+/* Illegal request, Invalid Transfer Tag */
+extern const struct SCSISense sense_code_INVALID_TAG;
+/* Command aborted, I/O process terminated */
+extern const struct SCSISense sense_code_IO_ERROR;
+/* Command aborted, I_T Nexus loss occurred */
+extern const struct SCSISense sense_code_I_T_NEXUS_LOSS;
+/* Command aborted, Logical Unit failure */
+extern const struct SCSISense sense_code_LUN_FAILURE;
+/* Command aborted, Overlapped Commands Attempted */
+extern const struct SCSISense sense_code_OVERLAPPED_COMMANDS;
+/* LUN not ready, Capacity data has changed */
+extern const struct SCSISense sense_code_CAPACITY_CHANGED;
+/* LUN not ready, Medium not present */
+extern const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM;
+/* Unit attention, Power on, reset or bus device reset occurred */
+extern const struct SCSISense sense_code_RESET;
+/* Unit attention, Medium may have changed*/
+extern const struct SCSISense sense_code_MEDIUM_CHANGED;
+/* Unit attention, Reported LUNs data has changed */
+extern const struct SCSISense sense_code_REPORTED_LUNS_CHANGED;
+/* Unit attention, Device internal reset */
+extern const struct SCSISense sense_code_DEVICE_INTERNAL_RESET;
+/* Data Protection, Write Protected */
+extern const struct SCSISense sense_code_WRITE_PROTECTED;
+/* Data Protection, Space Allocation Failed Write Protect */
+extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
+
+#define SENSE_CODE(x) sense_code_ ## x
+
+int scsi_convert_sense(uint8_t *in_buf, int in_len,
+                       uint8_t *buf, int len, bool fixed);
+const char *scsi_command_name(uint8_t cmd);
+
+uint64_t scsi_cmd_lba(SCSICommand *cmd);
+uint32_t scsi_data_cdb_xfer(uint8_t *buf);
+uint32_t scsi_cdb_xfer(uint8_t *buf);
+int scsi_cdb_length(uint8_t *buf);
+
+/* Linux SG_IO interface.  */
+#ifdef CONFIG_LINUX
+#define SG_ERR_DRIVER_TIMEOUT  0x06
+#define SG_ERR_DRIVER_SENSE    0x08
+
+#define SG_ERR_DID_OK          0x00
+#define SG_ERR_DID_NO_CONNECT  0x01
+#define SG_ERR_DID_BUS_BUSY    0x02
+#define SG_ERR_DID_TIME_OUT    0x03
+
+#define SG_ERR_DRIVER_SENSE    0x08
+#endif
+
+#endif
diff --git a/scsi/Makefile.objs b/scsi/Makefile.objs
new file mode 100644
index 0000000000..31b82a5a36
--- /dev/null
+++ b/scsi/Makefile.objs
@@ -0,0 +1 @@
+block-obj-y += utils.o
diff --git a/scsi/utils.c b/scsi/utils.c
new file mode 100644
index 0000000000..0db727591f
--- /dev/null
+++ b/scsi/utils.c
@@ -0,0 +1,403 @@
+#include "qemu/osdep.h"
+#include "block/scsi.h"
+#include "scsi/utils.h"
+#include "qemu/bswap.h"
+
+uint32_t scsi_data_cdb_xfer(uint8_t *buf)
+{
+    if ((buf[0] >> 5) == 0 && buf[4] == 0) {
+        return 256;
+    } else {
+        return scsi_cdb_xfer(buf);
+    }
+}
+
+uint32_t scsi_cdb_xfer(uint8_t *buf)
+{
+    switch (buf[0] >> 5) {
+    case 0:
+        return buf[4];
+        break;
+    case 1:
+    case 2:
+        return lduw_be_p(&buf[7]);
+        break;
+    case 4:
+        return ldl_be_p(&buf[10]) & 0xffffffffULL;
+        break;
+    case 5:
+        return ldl_be_p(&buf[6]) & 0xffffffffULL;
+        break;
+    default:
+        return -1;
+    }
+}
+
+uint64_t scsi_cmd_lba(SCSICommand *cmd)
+{
+    uint8_t *buf = cmd->buf;
+    uint64_t lba;
+
+    switch (buf[0] >> 5) {
+    case 0:
+        lba = ldl_be_p(&buf[0]) & 0x1fffff;
+        break;
+    case 1:
+    case 2:
+    case 5:
+        lba = ldl_be_p(&buf[2]) & 0xffffffffULL;
+        break;
+    case 4:
+        lba = ldq_be_p(&buf[2]);
+        break;
+    default:
+        lba = -1;
+
+    }
+    return lba;
+}
+
+int scsi_cdb_length(uint8_t *buf)
+{
+    int cdb_len;
+
+    switch (buf[0] >> 5) {
+    case 0:
+        cdb_len = 6;
+        break;
+    case 1:
+    case 2:
+        cdb_len = 10;
+        break;
+    case 4:
+        cdb_len = 16;
+        break;
+    case 5:
+        cdb_len = 12;
+        break;
+    default:
+        cdb_len = -1;
+    }
+    return cdb_len;
+}
+
+/*
+ * Predefined sense codes
+ */
+
+/* No sense data available */
+const struct SCSISense sense_code_NO_SENSE = {
+    .key = NO_SENSE , .asc = 0x00 , .ascq = 0x00
+};
+
+/* LUN not ready, Manual intervention required */
+const struct SCSISense sense_code_LUN_NOT_READY = {
+    .key = NOT_READY, .asc = 0x04, .ascq = 0x03
+};
+
+/* LUN not ready, Medium not present */
+const struct SCSISense sense_code_NO_MEDIUM = {
+    .key = NOT_READY, .asc = 0x3a, .ascq = 0x00
+};
+
+/* LUN not ready, medium removal prevented */
+const struct SCSISense sense_code_NOT_READY_REMOVAL_PREVENTED = {
+    .key = NOT_READY, .asc = 0x53, .ascq = 0x02
+};
+
+/* Hardware error, internal target failure */
+const struct SCSISense sense_code_TARGET_FAILURE = {
+    .key = HARDWARE_ERROR, .asc = 0x44, .ascq = 0x00
+};
+
+/* Illegal request, invalid command operation code */
+const struct SCSISense sense_code_INVALID_OPCODE = {
+    .key = ILLEGAL_REQUEST, .asc = 0x20, .ascq = 0x00
+};
+
+/* Illegal request, LBA out of range */
+const struct SCSISense sense_code_LBA_OUT_OF_RANGE = {
+    .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x00
+};
+
+/* Illegal request, Invalid field in CDB */
+const struct SCSISense sense_code_INVALID_FIELD = {
+    .key = ILLEGAL_REQUEST, .asc = 0x24, .ascq = 0x00
+};
+
+/* Illegal request, Invalid field in parameter list */
+const struct SCSISense sense_code_INVALID_PARAM = {
+    .key = ILLEGAL_REQUEST, .asc = 0x26, .ascq = 0x00
+};
+
+/* Illegal request, Parameter list length error */
+const struct SCSISense sense_code_INVALID_PARAM_LEN = {
+    .key = ILLEGAL_REQUEST, .asc = 0x1a, .ascq = 0x00
+};
+
+/* Illegal request, LUN not supported */
+const struct SCSISense sense_code_LUN_NOT_SUPPORTED = {
+    .key = ILLEGAL_REQUEST, .asc = 0x25, .ascq = 0x00
+};
+
+/* Illegal request, Saving parameters not supported */
+const struct SCSISense sense_code_SAVING_PARAMS_NOT_SUPPORTED = {
+    .key = ILLEGAL_REQUEST, .asc = 0x39, .ascq = 0x00
+};
+
+/* Illegal request, Incompatible medium installed */
+const struct SCSISense sense_code_INCOMPATIBLE_FORMAT = {
+    .key = ILLEGAL_REQUEST, .asc = 0x30, .ascq = 0x00
+};
+
+/* Illegal request, medium removal prevented */
+const struct SCSISense sense_code_ILLEGAL_REQ_REMOVAL_PREVENTED = {
+    .key = ILLEGAL_REQUEST, .asc = 0x53, .ascq = 0x02
+};
+
+/* Illegal request, Invalid Transfer Tag */
+const struct SCSISense sense_code_INVALID_TAG = {
+    .key = ILLEGAL_REQUEST, .asc = 0x4b, .ascq = 0x01
+};
+
+/* Command aborted, I/O process terminated */
+const struct SCSISense sense_code_IO_ERROR = {
+    .key = ABORTED_COMMAND, .asc = 0x00, .ascq = 0x06
+};
+
+/* Command aborted, I_T Nexus loss occurred */
+const struct SCSISense sense_code_I_T_NEXUS_LOSS = {
+    .key = ABORTED_COMMAND, .asc = 0x29, .ascq = 0x07
+};
+
+/* Command aborted, Logical Unit failure */
+const struct SCSISense sense_code_LUN_FAILURE = {
+    .key = ABORTED_COMMAND, .asc = 0x3e, .ascq = 0x01
+};
+
+/* Command aborted, Overlapped Commands Attempted */
+const struct SCSISense sense_code_OVERLAPPED_COMMANDS = {
+    .key = ABORTED_COMMAND, .asc = 0x4e, .ascq = 0x00
+};
+
+/* Unit attention, Capacity data has changed */
+const struct SCSISense sense_code_CAPACITY_CHANGED = {
+    .key = UNIT_ATTENTION, .asc = 0x2a, .ascq = 0x09
+};
+
+/* Unit attention, Power on, reset or bus device reset occurred */
+const struct SCSISense sense_code_RESET = {
+    .key = UNIT_ATTENTION, .asc = 0x29, .ascq = 0x00
+};
+
+/* Unit attention, No medium */
+const struct SCSISense sense_code_UNIT_ATTENTION_NO_MEDIUM = {
+    .key = UNIT_ATTENTION, .asc = 0x3a, .ascq = 0x00
+};
+
+/* Unit attention, Medium may have changed */
+const struct SCSISense sense_code_MEDIUM_CHANGED = {
+    .key = UNIT_ATTENTION, .asc = 0x28, .ascq = 0x00
+};
+
+/* Unit attention, Reported LUNs data has changed */
+const struct SCSISense sense_code_REPORTED_LUNS_CHANGED = {
+    .key = UNIT_ATTENTION, .asc = 0x3f, .ascq = 0x0e
+};
+
+/* Unit attention, Device internal reset */
+const struct SCSISense sense_code_DEVICE_INTERNAL_RESET = {
+    .key = UNIT_ATTENTION, .asc = 0x29, .ascq = 0x04
+};
+
+/* Data Protection, Write Protected */
+const struct SCSISense sense_code_WRITE_PROTECTED = {
+    .key = DATA_PROTECT, .asc = 0x27, .ascq = 0x00
+};
+
+/* Data Protection, Space Allocation Failed Write Protect */
+const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
+    .key = DATA_PROTECT, .asc = 0x27, .ascq = 0x07
+};
+
+/*
+ * scsi_convert_sense
+ *
+ * Convert between fixed and descriptor sense buffers
+ */
+int scsi_convert_sense(uint8_t *in_buf, int in_len,
+                       uint8_t *buf, int len, bool fixed)
+{
+    bool fixed_in;
+    SCSISense sense;
+    if (!fixed && len < 8) {
+        return 0;
+    }
+
+    if (in_len == 0) {
+        sense.key = NO_SENSE;
+        sense.asc = 0;
+        sense.ascq = 0;
+    } else {
+        fixed_in = (in_buf[0] & 2) == 0;
+
+        if (fixed == fixed_in) {
+            memcpy(buf, in_buf, MIN(len, in_len));
+            return MIN(len, in_len);
+        }
+
+        if (fixed_in) {
+            sense.key = in_buf[2];
+            sense.asc = in_buf[12];
+            sense.ascq = in_buf[13];
+        } else {
+            sense.key = in_buf[1];
+            sense.asc = in_buf[2];
+            sense.ascq = in_buf[3];
+        }
+    }
+
+    memset(buf, 0, len);
+    if (fixed) {
+        /* Return fixed format sense buffer */
+        buf[0] = 0x70;
+        buf[2] = sense.key;
+        buf[7] = 10;
+        buf[12] = sense.asc;
+        buf[13] = sense.ascq;
+        return MIN(len, SCSI_SENSE_LEN);
+    } else {
+        /* Return descriptor format sense buffer */
+        buf[0] = 0x72;
+        buf[1] = sense.key;
+        buf[2] = sense.asc;
+        buf[3] = sense.ascq;
+        return 8;
+    }
+}
+
+const char *scsi_command_name(uint8_t cmd)
+{
+    static const char *names[] = {
+        [ TEST_UNIT_READY          ] = "TEST_UNIT_READY",
+        [ REWIND                   ] = "REWIND",
+        [ REQUEST_SENSE            ] = "REQUEST_SENSE",
+        [ FORMAT_UNIT              ] = "FORMAT_UNIT",
+        [ READ_BLOCK_LIMITS        ] = "READ_BLOCK_LIMITS",
+        [ REASSIGN_BLOCKS          ] = "REASSIGN_BLOCKS/INITIALIZE ELEMENT STATUS",
+        /* LOAD_UNLOAD and INITIALIZE_ELEMENT_STATUS use the same operation code */
+        [ READ_6                   ] = "READ_6",
+        [ WRITE_6                  ] = "WRITE_6",
+        [ SET_CAPACITY             ] = "SET_CAPACITY",
+        [ READ_REVERSE             ] = "READ_REVERSE",
+        [ WRITE_FILEMARKS          ] = "WRITE_FILEMARKS",
+        [ SPACE                    ] = "SPACE",
+        [ INQUIRY                  ] = "INQUIRY",
+        [ RECOVER_BUFFERED_DATA    ] = "RECOVER_BUFFERED_DATA",
+        [ MAINTENANCE_IN           ] = "MAINTENANCE_IN",
+        [ MAINTENANCE_OUT          ] = "MAINTENANCE_OUT",
+        [ MODE_SELECT              ] = "MODE_SELECT",
+        [ RESERVE                  ] = "RESERVE",
+        [ RELEASE                  ] = "RELEASE",
+        [ COPY                     ] = "COPY",
+        [ ERASE                    ] = "ERASE",
+        [ MODE_SENSE               ] = "MODE_SENSE",
+        [ START_STOP               ] = "START_STOP/LOAD_UNLOAD",
+        /* LOAD_UNLOAD and START_STOP use the same operation code */
+        [ RECEIVE_DIAGNOSTIC       ] = "RECEIVE_DIAGNOSTIC",
+        [ SEND_DIAGNOSTIC          ] = "SEND_DIAGNOSTIC",
+        [ ALLOW_MEDIUM_REMOVAL     ] = "ALLOW_MEDIUM_REMOVAL",
+        [ READ_CAPACITY_10         ] = "READ_CAPACITY_10",
+        [ READ_10                  ] = "READ_10",
+        [ WRITE_10                 ] = "WRITE_10",
+        [ SEEK_10                  ] = "SEEK_10/POSITION_TO_ELEMENT",
+        /* SEEK_10 and POSITION_TO_ELEMENT use the same operation code */
+        [ WRITE_VERIFY_10          ] = "WRITE_VERIFY_10",
+        [ VERIFY_10                ] = "VERIFY_10",
+        [ SEARCH_HIGH              ] = "SEARCH_HIGH",
+        [ SEARCH_EQUAL             ] = "SEARCH_EQUAL",
+        [ SEARCH_LOW               ] = "SEARCH_LOW",
+        [ SET_LIMITS               ] = "SET_LIMITS",
+        [ PRE_FETCH                ] = "PRE_FETCH/READ_POSITION",
+        /* READ_POSITION and PRE_FETCH use the same operation code */
+        [ SYNCHRONIZE_CACHE        ] = "SYNCHRONIZE_CACHE",
+        [ LOCK_UNLOCK_CACHE        ] = "LOCK_UNLOCK_CACHE",
+        [ READ_DEFECT_DATA         ] = "READ_DEFECT_DATA/INITIALIZE_ELEMENT_STATUS_WITH_RANGE",
+        /* READ_DEFECT_DATA and INITIALIZE_ELEMENT_STATUS_WITH_RANGE use the same operation code */
+        [ MEDIUM_SCAN              ] = "MEDIUM_SCAN",
+        [ COMPARE                  ] = "COMPARE",
+        [ COPY_VERIFY              ] = "COPY_VERIFY",
+        [ WRITE_BUFFER             ] = "WRITE_BUFFER",
+        [ READ_BUFFER              ] = "READ_BUFFER",
+        [ UPDATE_BLOCK             ] = "UPDATE_BLOCK",
+        [ READ_LONG_10             ] = "READ_LONG_10",
+        [ WRITE_LONG_10            ] = "WRITE_LONG_10",
+        [ CHANGE_DEFINITION        ] = "CHANGE_DEFINITION",
+        [ WRITE_SAME_10            ] = "WRITE_SAME_10",
+        [ UNMAP                    ] = "UNMAP",
+        [ READ_TOC                 ] = "READ_TOC",
+        [ REPORT_DENSITY_SUPPORT   ] = "REPORT_DENSITY_SUPPORT",
+        [ SANITIZE                 ] = "SANITIZE",
+        [ GET_CONFIGURATION        ] = "GET_CONFIGURATION",
+        [ LOG_SELECT               ] = "LOG_SELECT",
+        [ LOG_SENSE                ] = "LOG_SENSE",
+        [ MODE_SELECT_10           ] = "MODE_SELECT_10",
+        [ RESERVE_10               ] = "RESERVE_10",
+        [ RELEASE_10               ] = "RELEASE_10",
+        [ MODE_SENSE_10            ] = "MODE_SENSE_10",
+        [ PERSISTENT_RESERVE_IN    ] = "PERSISTENT_RESERVE_IN",
+        [ PERSISTENT_RESERVE_OUT   ] = "PERSISTENT_RESERVE_OUT",
+        [ WRITE_FILEMARKS_16       ] = "WRITE_FILEMARKS_16",
+        [ EXTENDED_COPY            ] = "EXTENDED_COPY",
+        [ ATA_PASSTHROUGH_16       ] = "ATA_PASSTHROUGH_16",
+        [ ACCESS_CONTROL_IN        ] = "ACCESS_CONTROL_IN",
+        [ ACCESS_CONTROL_OUT       ] = "ACCESS_CONTROL_OUT",
+        [ READ_16                  ] = "READ_16",
+        [ COMPARE_AND_WRITE        ] = "COMPARE_AND_WRITE",
+        [ WRITE_16                 ] = "WRITE_16",
+        [ WRITE_VERIFY_16          ] = "WRITE_VERIFY_16",
+        [ VERIFY_16                ] = "VERIFY_16",
+        [ PRE_FETCH_16             ] = "PRE_FETCH_16",
+        [ SYNCHRONIZE_CACHE_16     ] = "SPACE_16/SYNCHRONIZE_CACHE_16",
+        /* SPACE_16 and SYNCHRONIZE_CACHE_16 use the same operation code */
+        [ LOCATE_16                ] = "LOCATE_16",
+        [ WRITE_SAME_16            ] = "ERASE_16/WRITE_SAME_16",
+        /* ERASE_16 and WRITE_SAME_16 use the same operation code */
+        [ SERVICE_ACTION_IN_16     ] = "SERVICE_ACTION_IN_16",
+        [ WRITE_LONG_16            ] = "WRITE_LONG_16",
+        [ REPORT_LUNS              ] = "REPORT_LUNS",
+        [ ATA_PASSTHROUGH_12       ] = "BLANK/ATA_PASSTHROUGH_12",
+        [ MOVE_MEDIUM              ] = "MOVE_MEDIUM",
+        [ EXCHANGE_MEDIUM          ] = "EXCHANGE MEDIUM",
+        [ READ_12                  ] = "READ_12",
+        [ WRITE_12                 ] = "WRITE_12",
+        [ ERASE_12                 ] = "ERASE_12/GET_PERFORMANCE",
+        /* ERASE_12 and GET_PERFORMANCE use the same operation code */
+        [ SERVICE_ACTION_IN_12     ] = "SERVICE_ACTION_IN_12",
+        [ WRITE_VERIFY_12          ] = "WRITE_VERIFY_12",
+        [ VERIFY_12                ] = "VERIFY_12",
+        [ SEARCH_HIGH_12           ] = "SEARCH_HIGH_12",
+        [ SEARCH_EQUAL_12          ] = "SEARCH_EQUAL_12",
+        [ SEARCH_LOW_12            ] = "SEARCH_LOW_12",
+        [ READ_ELEMENT_STATUS      ] = "READ_ELEMENT_STATUS",
+        [ SEND_VOLUME_TAG          ] = "SEND_VOLUME_TAG/SET_STREAMING",
+        /* SEND_VOLUME_TAG and SET_STREAMING use the same operation code */
+        [ READ_CD                  ] = "READ_CD",
+        [ READ_DEFECT_DATA_12      ] = "READ_DEFECT_DATA_12",
+        [ READ_DVD_STRUCTURE       ] = "READ_DVD_STRUCTURE",
+        [ RESERVE_TRACK            ] = "RESERVE_TRACK",
+        [ SEND_CUE_SHEET           ] = "SEND_CUE_SHEET",
+        [ SEND_DVD_STRUCTURE       ] = "SEND_DVD_STRUCTURE",
+        [ SET_CD_SPEED             ] = "SET_CD_SPEED",
+        [ SET_READ_AHEAD           ] = "SET_READ_AHEAD",
+        [ ALLOW_OVERWRITE          ] = "ALLOW_OVERWRITE",
+        [ MECHANISM_STATUS         ] = "MECHANISM_STATUS",
+        [ GET_EVENT_STATUS_NOTIFICATION ] = "GET_EVENT_STATUS_NOTIFICATION",
+        [ READ_DISC_INFORMATION    ] = "READ_DISC_INFORMATION",
+    };
+
+    if (cmd >= ARRAY_SIZE(names) || names[cmd] == NULL) {
+        return "*UNKNOWN*";
+    }
+    return names[cmd];
+}
-- 
2.13.5
