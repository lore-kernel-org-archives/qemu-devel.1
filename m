Received: from eggs.gnu.org ([2001:4830:134:3::10]:55101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozU-0008S0-D7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozP-0003zU-JF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozP-0003zG-D5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:19 +0200
Message-Id: <1498564100-10045-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 13/14] pc-bios/s390-ccw: Allow loading to
 address 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Kernels are normally loaded to address 0, so the check for NULL
in the TFTP code has to be replaced.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libnet/tftp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/libnet/tftp.c b/pc-bios/s390-ccw/libnet/tftp.c
index 34f448c..108092b 100644
--- a/pc-bios/s390-ccw/libnet/tftp.c
+++ b/pc-bios/s390-ccw/libnet/tftp.c
@@ -26,6 +26,7 @@
 
 #define MAX_BLOCKSIZE 1428
 #define BUFFER_LEN 256
+#define INVALID_BUFFER ((void *)-1L)
 
 #define ENOTFOUND 1
 #define EACCESS   2
@@ -45,7 +46,7 @@
 
 /* Local variables */
 static unsigned char packet[BUFFER_LEN];
-static unsigned char  *buffer = NULL;
+static unsigned char  *buffer = INVALID_BUFFER;
 static unsigned short block;
 static unsigned short blocksize;
 static char blocksize_str[6];    /* Blocksize string for read request */
@@ -337,7 +338,7 @@ int32_t handle_tftp(int fd, uint8_t *pkt, int32_t packetsize)
 	struct tftphdr *tftp;
 
 	/* buffer is only set if we are handling TFTP */
-	if (buffer == NULL )
+	if (buffer == INVALID_BUFFER)
 		return 0;
 
 #ifndef __DEBUG__
@@ -536,7 +537,7 @@ int tftp(filename_ip_t * _fn_ip, unsigned char *_buffer, int _len,
 	printf("  Receiving data:  ");
 	print_progress(-1, 0);
 
-	// Setting buffer to a non-zero address enabled handling of received TFTP packets.
+	/* Set buffer to a valid address, enables handling of received packets */
 	buffer = _buffer;
 
 	set_timer(TICKS_SEC);
@@ -579,8 +580,8 @@ int tftp(filename_ip_t * _fn_ip, unsigned char *_buffer, int _len,
 		}
 	}
 
-	// Setting buffer to NULL disables handling of received TFTP packets.
-	buffer = NULL;
+	/* Setting buffer invalid to disable handling of received packets */
+	buffer = INVALID_BUFFER;
 
 	if (tftp_errno)
 		return tftp_errno;
-- 
1.8.3.1
