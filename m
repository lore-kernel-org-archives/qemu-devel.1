Received: from eggs.gnu.org ([2001:4830:134:3::10]:55027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozM-0008Mv-Lu
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozL-0003xz-HU
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozL-0003xG-9S
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:59 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:18 +0200
Message-Id: <1498564100-10045-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 12/14] pc-bios/s390-ccw: Load file via an
 intermediate .INS file
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

We need to know which files have to be loaded at which address.
Normally you need at least two files, a kernel image and an initrd
image. Since the normal DHCP information only provides one file,
we now load an intermediate .INS file first which has to contain
the information about the other files. The .INS file has the
same syntax as the .INS files that are already used on s390x
Linux distribution CD-ROMs: First line is the title (starting
with "* "), and in the following lines you can find the file
names followed by the address where they should be loaded.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libnet/netapps.h |  2 +-
 pc-bios/s390-ccw/libnet/netload.c | 72 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/libnet/netapps.h b/pc-bios/s390-ccw/libnet/netapps.h
index d2283af..61e8a11 100644
--- a/pc-bios/s390-ccw/libnet/netapps.h
+++ b/pc-bios/s390-ccw/libnet/netapps.h
@@ -18,7 +18,7 @@
 
 struct filename_ip;
 
-extern int netload(char *buffer, int len, char *ret_buffer);
+extern int netload(void);
 extern int dhcp(char *ret_buffer, struct filename_ip *fn_ip,
 		unsigned int retries, int flags);
 
diff --git a/pc-bios/s390-ccw/libnet/netload.c b/pc-bios/s390-ccw/libnet/netload.c
index eae8333..28e8711 100644
--- a/pc-bios/s390-ccw/libnet/netload.c
+++ b/pc-bios/s390-ccw/libnet/netload.c
@@ -26,6 +26,8 @@
 #include "args.h"
 #include "netapps.h"
 
+#define MAX_INS_FILE_LEN 16384
+
 #define IP_INIT_DEFAULT 5
 #define IP_INIT_NONE    0
 #define IP_INIT_BOOTP   1
@@ -138,7 +140,7 @@ static void seed_rng(uint8_t mac[])
 	srand(seed);
 }
 
-static int tftp_load(filename_ip_t *fnip, unsigned char *buffer, int len,
+static int tftp_load(filename_ip_t *fnip, void *buffer, int len,
 		     unsigned int retries, int ip_vers)
 {
 	tftp_err_t tftp_err;
@@ -227,7 +229,56 @@ static int tftp_load(filename_ip_t *fnip, unsigned char *buffer, int len,
 	return rc;
 }
 
-int netload(char *buffer, int len, char *ret_buffer)
+static int load_from_ins_file(char *insbuf, filename_ip_t *fn_ip, int retries,
+			      int ip_version)
+{
+	char *ptr;
+	int rc = -1, llen;
+	void *destaddr;
+
+	ptr = strchr(insbuf, '\n');
+
+	if (!ptr || insbuf[0] != '*' || insbuf[1] != ' ') {
+		puts("Does not seem to be a valid .INS file");
+		return -1;
+	}
+
+	*ptr = 0;
+	printf("\nParsing .INS file:\n  %s\n", &insbuf[2]);
+
+	insbuf = ptr + 1;
+	while (*insbuf) {
+		ptr = strchr(insbuf, '\n');
+		if (ptr) {
+			*ptr = 0;
+		}
+		llen = strlen(insbuf);
+		if (!llen) {
+			insbuf = ptr + 1;
+			continue;
+		}
+		ptr = strchr(insbuf, ' ');
+		if (!ptr) {
+			puts("Missing space separator in .INS file");
+			return -1;
+		}
+		*ptr = 0;
+		strncpy((char *)fn_ip->filename, insbuf,
+			sizeof(fn_ip->filename));
+		destaddr = (char *)atol(ptr + 1);
+		printf("\n  Loading file \"%s\" via TFTP to %p\n", insbuf,
+		       destaddr);
+		rc = tftp_load(fn_ip, destaddr, 50000000, retries, ip_version);
+		if (rc <= 0) {
+			break;
+		}
+		insbuf += llen + 1;
+	}
+
+	return rc;
+}
+
+int netload(void)
 {
 	int rc;
 	filename_ip_t fn_ip;
@@ -239,6 +290,7 @@ int netload(char *buffer, int len, char *ret_buffer)
 			     0x00, 0x00, 0x00, 0x00, 
 			     0x00, 0x00, 0x00, 0x00 };
 	uint8_t own_mac[6];
+	char *ins_buf, *ret_buffer = NULL;
 
 	puts("\n Initializing NIC");
 	memset(&fn_ip, 0, sizeof(filename_ip_t));
@@ -420,9 +472,19 @@ int netload(char *buffer, int len, char *ret_buffer)
 		printf("%s\n", ip6_str);
 	}
 
-	/* Do the TFTP load and print error message if necessary */
-	rc = tftp_load(&fn_ip, (unsigned char *)buffer, len,
-		       obp_tftp_args.tftp_retries, ip_version);
+	ins_buf = malloc(MAX_INS_FILE_LEN);
+	if (!ins_buf) {
+		puts("Failed to allocate memory for the .INS file");
+		return -1;
+	}
+	memset(ins_buf, 0, MAX_INS_FILE_LEN);
+	rc = tftp_load(&fn_ip, ins_buf, MAX_INS_FILE_LEN - 1,
+	               obp_tftp_args.tftp_retries, ip_version);
+	if (rc > 0) {
+		rc = load_from_ins_file(ins_buf, &fn_ip,
+					obp_tftp_args.tftp_retries, ip_version);
+	}
+	free(ins_buf);
 
 	if (obp_tftp_args.ip_init == IP_INIT_DHCP)
 		dhcp_send_release(fn_ip.fd);
-- 
1.8.3.1
