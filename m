Received: from eggs.gnu.org ([209.51.188.92]:39252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvG4-0003BZ-Rb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvG3-0002lX-KD
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:20 +0200
Message-Id: <20190412122523.24111-15-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 14/17] s390-bios: Add
 channel command codes/structs needed for dasd-ipl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.ibm.com>

The dasd IPL procedure needs to execute a few previously unused
channel commands. Let's define them and their associated data
structures.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-15-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/cio.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index 1637e32070..aaa432dedd 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -200,11 +200,14 @@ typedef struct ccw1 {
 #define CCW_FLAG_IDA             0x04
 #define CCW_FLAG_SUSPEND         0x02
=20
+/* Common CCW commands */
+#define CCW_CMD_READ_IPL         0x02
 #define CCW_CMD_NOOP             0x03
 #define CCW_CMD_BASIC_SENSE      0x04
 #define CCW_CMD_TIC              0x08
 #define CCW_CMD_SENSE_ID         0xe4
=20
+/* Virtio CCW commands */
 #define CCW_CMD_SET_VQ           0x13
 #define CCW_CMD_VDEV_RESET       0x33
 #define CCW_CMD_READ_FEAT        0x12
@@ -216,6 +219,12 @@ typedef struct ccw1 {
 #define CCW_CMD_SET_CONF_IND     0x53
 #define CCW_CMD_READ_VQ_CONF     0x32
=20
+/* DASD CCW commands */
+#define CCW_CMD_DASD_READ             0x06
+#define CCW_CMD_DASD_SEEK             0x07
+#define CCW_CMD_DASD_SEARCH_ID_EQ     0x31
+#define CCW_CMD_DASD_READ_MT          0x86
+
 /*
  * Command-mode operation request block
  */
@@ -333,6 +342,20 @@ typedef struct irb {
     __u32 emw[8];
 }  __attribute__ ((packed, aligned(4))) Irb;
=20
+/* Used for SEEK ccw commands */
+typedef struct CcwSeekData {
+    uint16_t reserved;
+    uint16_t cyl;
+    uint16_t head;
+} __attribute__((packed)) CcwSeekData;
+
+/* Used for SEARCH ID ccw commands */
+typedef struct CcwSearchIdData {
+    uint16_t cyl;
+    uint16_t head;
+    uint8_t record;
+} __attribute__((packed)) CcwSearchIdData;
+
 int enable_mss_facility(void);
 void enable_subchannel(SubChannelId schid);
 uint16_t cu_type(SubChannelId schid);
--=20
2.21.0
