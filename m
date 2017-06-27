Received: from eggs.gnu.org ([2001:4830:134:3::10]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozD-0008A7-40
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozB-0003sG-KT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozB-0003rn-C6
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:14 +0200
Message-Id: <1498564100-10045-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/14] libnet: Refactor some code of
 netload() into a separate function
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

netload() is a huge function, it's easy to lose track here. So
let's refactor the TFTP-related loading and error printing code
into a separate function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libnet/netload.c | 177 ++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 84 deletions(-)

diff --git a/pc-bios/s390-ccw/libnet/netload.c b/pc-bios/s390-ccw/libnet/netload.c
index 8afe341..f872884 100644
--- a/pc-bios/s390-ccw/libnet/netload.c
+++ b/pc-bios/s390-ccw/libnet/netload.c
@@ -403,13 +403,101 @@ static void seed_rng(uint8_t mac[])
 	srand(seed);
 }
 
+static int tftp_load(filename_ip_t *fnip, unsigned char *buffer, int len,
+		     unsigned int retries, int ip_vers)
+{
+	tftp_err_t tftp_err;
+	int rc;
+
+	rc = tftp(fnip, buffer, len, retries, &tftp_err, 1, 1428, ip_vers);
+
+	if (rc > 0) {
+		printf("  TFTP: Received %s (%d KBytes)\n", fnip->filename,
+		       rc / 1024);
+	} else if (rc == -1) {
+		netload_error(0x3003, "unknown TFTP error");
+		return -103;
+	} else if (rc == -2) {
+		netload_error(0x3004, "TFTP buffer of %d bytes "
+			"is too small for %s",
+			len, fnip->filename);
+		return -104;
+	} else if (rc == -3) {
+		netload_error(0x3009, "file not found: %s",
+			fnip->filename);
+		return -108;
+	} else if (rc == -4) {
+		netload_error(0x3010, "TFTP access violation");
+		return -109;
+	} else if (rc == -5) {
+		netload_error(0x3011, "illegal TFTP operation");
+		return -110;
+	} else if (rc == -6) {
+		netload_error(0x3012, "unknown TFTP transfer ID");
+		return -111;
+	} else if (rc == -7) {
+		netload_error(0x3013, "no such TFTP user");
+		return -112;
+	} else if (rc == -8) {
+		netload_error(0x3017, "TFTP blocksize negotiation failed");
+		return -116;
+	} else if (rc == -9) {
+		netload_error(0x3018, "file exceeds maximum TFTP transfer size");
+		return -117;
+	} else if (rc <= -10 && rc >= -15) {
+		char *icmp_err_str;
+		switch (rc) {
+		case -ICMP_NET_UNREACHABLE - 10:
+			icmp_err_str = "net unreachable";
+			break;
+		case -ICMP_HOST_UNREACHABLE - 10:
+			icmp_err_str = "host unreachable";
+			break;
+		case -ICMP_PROTOCOL_UNREACHABLE - 10:
+			icmp_err_str = "protocol unreachable";
+			break;
+		case -ICMP_PORT_UNREACHABLE - 10:
+			icmp_err_str = "port unreachable";
+			break;
+		case -ICMP_FRAGMENTATION_NEEDED - 10:
+			icmp_err_str = "fragmentation needed and DF set";
+			break;
+		case -ICMP_SOURCE_ROUTE_FAILED - 10:
+			icmp_err_str = "source route failed";
+			break;
+		default:
+			icmp_err_str = " UNKNOWN";
+			break;
+		}
+		netload_error(0x3005, "ICMP ERROR \"%s\"", icmp_err_str);
+		return -105;
+	} else if (rc == -40) {
+		netload_error(0x3014, "TFTP error occurred after "
+			"%d bad packets received",
+			tftp_err.bad_tftp_packets);
+		return -113;
+	} else if (rc == -41) {
+		netload_error(0x3015, "TFTP error occurred after "
+			"missing %d responses",
+			tftp_err.no_packets);
+		return -114;
+	} else if (rc == -42) {
+		netload_error(0x3016, "TFTP error missing block %d, "
+			"expected block was %d",
+			tftp_err.blocks_missed,
+			tftp_err.blocks_received);
+		return -115;
+	}
+
+	return rc;
+}
+
 int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 	    int block_size, char *args_fs, int alen)
 {
 	int rc;
 	filename_ip_t fn_ip;
 	int fd_device;
-	tftp_err_t tftp_err;
 	obp_tftp_args_t obp_tftp_args;
 	char null_ip[4] = { 0x00, 0x00, 0x00, 0x00 };
 	char null_ip6[16] = { 0x00, 0x00, 0x00, 0x00,
@@ -633,94 +721,15 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 		printf("%s\n", ip6_str);
 	}
 
-	// accept at most 20 bad packets
-	// wait at most for 40 packets
-	rc = tftp(&fn_ip, (unsigned char *) buffer,
-	          len, obp_tftp_args.tftp_retries,
-	          &tftp_err, huge_load, block_size, ip_version);
+	/* Do the TFTP load and print error message if necessary */
+	rc = tftp_load(&fn_ip, (unsigned char *)buffer, len,
+		       obp_tftp_args.tftp_retries, ip_version);
 
-	if(obp_tftp_args.ip_init == IP_INIT_DHCP)
+	if (obp_tftp_args.ip_init == IP_INIT_DHCP)
 		dhcp_send_release(fn_ip.fd);
 
 	close(fn_ip.fd);
 
-	if (rc > 0) {
-		printf("  TFTP: Received %s (%d KBytes)\n", fn_ip.filename,
-		       rc / 1024);
-	} else if (rc == -1) {
-		netload_error(0x3003, "unknown TFTP error");
-		return -103;
-	} else if (rc == -2) {
-		netload_error(0x3004, "TFTP buffer of %d bytes "
-			"is too small for %s",
-			len, fn_ip.filename);
-		return -104;
-	} else if (rc == -3) {
-		netload_error(0x3009, "file not found: %s",
-			fn_ip.filename);
-		return -108;
-	} else if (rc == -4) {
-		netload_error(0x3010, "TFTP access violation");
-		return -109;
-	} else if (rc == -5) {
-		netload_error(0x3011, "illegal TFTP operation");
-		return -110;
-	} else if (rc == -6) {
-		netload_error(0x3012, "unknown TFTP transfer ID");
-		return -111;
-	} else if (rc == -7) {
-		netload_error(0x3013, "no such TFTP user");
-		return -112;
-	} else if (rc == -8) {
-		netload_error(0x3017, "TFTP blocksize negotiation failed");
-		return -116;
-	} else if (rc == -9) {
-		netload_error(0x3018, "file exceeds maximum TFTP transfer size");
-		return -117;
-	} else if (rc <= -10 && rc >= -15) {
-		char *icmp_err_str;
-		switch (rc) {
-		case -ICMP_NET_UNREACHABLE - 10:
-			icmp_err_str = "net unreachable";
-			break;
-		case -ICMP_HOST_UNREACHABLE - 10:
-			icmp_err_str = "host unreachable";
-			break;
-		case -ICMP_PROTOCOL_UNREACHABLE - 10:
-			icmp_err_str = "protocol unreachable";
-			break;
-		case -ICMP_PORT_UNREACHABLE - 10:
-			icmp_err_str = "port unreachable";
-			break;
-		case -ICMP_FRAGMENTATION_NEEDED - 10:
-			icmp_err_str = "fragmentation needed and DF set";
-			break;
-		case -ICMP_SOURCE_ROUTE_FAILED - 10:
-			icmp_err_str = "source route failed";
-			break;
-		default:
-			icmp_err_str = " UNKNOWN";
-			break;
-		}
-		netload_error(0x3005, "ICMP ERROR \"%s\"", icmp_err_str);
-		return -105;
-	} else if (rc == -40) {
-		netload_error(0x3014, "TFTP error occurred after "
-			"%d bad packets received",
-			tftp_err.bad_tftp_packets);
-		return -113;
-	} else if (rc == -41) {
-		netload_error(0x3015, "TFTP error occurred after "
-			"missing %d responses",
-			tftp_err.no_packets);
-		return -114;
-	} else if (rc == -42) {
-		netload_error(0x3016, "TFTP error missing block %d, "
-			"expected block was %d",
-			tftp_err.blocks_missed,
-			tftp_err.blocks_received);
-		return -115;
-	}
 	return rc;
 }
 
-- 
1.8.3.1
