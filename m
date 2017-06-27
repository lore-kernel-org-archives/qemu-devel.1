Received: from eggs.gnu.org ([2001:4830:134:3::10]:54868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozA-00087h-QF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoz9-0003q4-DJ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPoz9-0003pi-4A
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:13 +0200
Message-Id: <1498564100-10045-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 07/14] libnet: Rework error message printing
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

There is a repetive pattern of code in netload.c to print out
error message: snprintf(buf, ...) + bootmsg_error() + write_mm_log().
The code can be simplified / shortened quite a bit by consolidating
this pattern in a helper function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libnet/netload.c | 126 +++++++++++++-------------------------
 1 file changed, 44 insertions(+), 82 deletions(-)

diff --git a/pc-bios/s390-ccw/libnet/netload.c b/pc-bios/s390-ccw/libnet/netload.c
index cd3720a..8afe341 100644
--- a/pc-bios/s390-ccw/libnet/netload.c
+++ b/pc-bios/s390-ccw/libnet/netload.c
@@ -52,6 +52,23 @@ typedef struct {
 	int  tftp_retries;
 } obp_tftp_args_t;
 
+/**
+ * Print error with preceeding error code
+ */
+static void netload_error(int errcode, const char *format, ...)
+{
+	va_list vargs;
+	char buf[256];
+
+	sprintf(buf, "E%04X: (net) ", errcode);
+
+	va_start(vargs, format);
+	vsnprintf(&buf[13], sizeof(buf) - 13, format, vargs);
+	va_end(vargs);
+
+	bootmsg_error(errcode, &buf[7]);
+	write_mm_log(buf, strlen(buf), 0x91);
+}
 
 /**
  * Parses a argument string for IPv6 booting, extracts all
@@ -389,7 +406,6 @@ static void seed_rng(uint8_t mac[])
 int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 	    int block_size, char *args_fs, int alen)
 {
-	char buf[256];
 	int rc;
 	filename_ip_t fn_ip;
 	int fd_device;
@@ -427,17 +443,11 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 	}
 
 	if (fd_device == -1) {
-		strcpy(buf,"E3000: (net) Could not read MAC address");
-		bootmsg_error(0x3000, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3000, "Could not read MAC address");
 		return -100;
 	}
 	else if (fd_device == -2) {
-		strcpy(buf,"E3006: (net) Could not initialize network device");
-		bootmsg_error(0x3006, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3006, "Could not initialize network device");
 		return -101;
 	}
 
@@ -567,10 +577,7 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 			memcpy(&fn_ip.server_ip6.addr, &obp_tftp_args.si6addr.addr, 16);
 	}
 	if (rc == -1) {
-		strcpy(buf,"E3001: (net) Could not get IP address");
-		bootmsg_error(0x3001, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3001, "Could not get IP address");
 		close(fn_ip.fd);
 		return -101;
 	}
@@ -586,29 +593,21 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 	}
 
 	if (rc == -2) {
-		sprintf(buf,
-			"E3002: (net) ARP request to TFTP server "
+		netload_error(0x3002, "ARP request to TFTP server "
 			"(%d.%d.%d.%d) failed",
 			((fn_ip.server_ip >> 24) & 0xFF),
 			((fn_ip.server_ip >> 16) & 0xFF),
 			((fn_ip.server_ip >>  8) & 0xFF),
 			( fn_ip.server_ip        & 0xFF));
-		bootmsg_error(0x3002, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
 		close(fn_ip.fd);
 		return -102;
 	}
 	if (rc == -4 || rc == -3) {
-		strcpy(buf,"E3008: (net) Can't obtain TFTP server IP address");
-		bootmsg_error(0x3008, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3008, "Can't obtain TFTP server IP address");
 		close(fn_ip.fd);
 		return -107;
 	}
 
-
 	/***********************************************************
 	 *
 	 * Load file via TFTP into buffer provided by OpenFirmware
@@ -649,114 +648,77 @@ int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 		printf("  TFTP: Received %s (%d KBytes)\n", fn_ip.filename,
 		       rc / 1024);
 	} else if (rc == -1) {
-		bootmsg_error(0x3003, "(net) unknown TFTP error");
+		netload_error(0x3003, "unknown TFTP error");
 		return -103;
 	} else if (rc == -2) {
-		sprintf(buf,
-			"E3004: (net) TFTP buffer of %d bytes "
+		netload_error(0x3004, "TFTP buffer of %d bytes "
 			"is too small for %s",
 			len, fn_ip.filename);
-		bootmsg_error(0x3004, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
 		return -104;
 	} else if (rc == -3) {
-		sprintf(buf,"E3009: (net) file not found: %s",
-		       fn_ip.filename);
-		bootmsg_error(0x3009, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3009, "file not found: %s",
+			fn_ip.filename);
 		return -108;
 	} else if (rc == -4) {
-		strcpy(buf,"E3010: (net) TFTP access violation");
-		bootmsg_error(0x3010, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3010, "TFTP access violation");
 		return -109;
 	} else if (rc == -5) {
-		strcpy(buf,"E3011: (net) illegal TFTP operation");
-		bootmsg_error(0x3011, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3011, "illegal TFTP operation");
 		return -110;
 	} else if (rc == -6) {
-		strcpy(buf, "E3012: (net) unknown TFTP transfer ID");
-		bootmsg_error(0x3012, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3012, "unknown TFTP transfer ID");
 		return -111;
 	} else if (rc == -7) {
-		strcpy(buf, "E3013: (net) no such TFTP user");
-		bootmsg_error(0x3013, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3013, "no such TFTP user");
 		return -112;
 	} else if (rc == -8) {
-		strcpy(buf, "E3017: (net) TFTP blocksize negotiation failed");
-		bootmsg_error(0x3017, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3017, "TFTP blocksize negotiation failed");
 		return -116;
 	} else if (rc == -9) {
-		strcpy(buf,"E3018: (net) file exceeds maximum TFTP transfer size");
-		bootmsg_error(0x3018, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3018, "file exceeds maximum TFTP transfer size");
 		return -117;
 	} else if (rc <= -10 && rc >= -15) {
-		sprintf(buf,"E3005: (net) ICMP ERROR \"");
+		char *icmp_err_str;
 		switch (rc) {
 		case -ICMP_NET_UNREACHABLE - 10:
-			sprintf(buf+strlen(buf),"net unreachable");
+			icmp_err_str = "net unreachable";
 			break;
 		case -ICMP_HOST_UNREACHABLE - 10:
-			sprintf(buf+strlen(buf),"host unreachable");
+			icmp_err_str = "host unreachable";
 			break;
 		case -ICMP_PROTOCOL_UNREACHABLE - 10:
-			sprintf(buf+strlen(buf),"protocol unreachable");
+			icmp_err_str = "protocol unreachable";
 			break;
 		case -ICMP_PORT_UNREACHABLE - 10:
-			sprintf(buf+strlen(buf),"port unreachable");
+			icmp_err_str = "port unreachable";
 			break;
 		case -ICMP_FRAGMENTATION_NEEDED - 10:
-			sprintf(buf+strlen(buf),"fragmentation needed and DF set");
+			icmp_err_str = "fragmentation needed and DF set";
 			break;
 		case -ICMP_SOURCE_ROUTE_FAILED - 10:
-			sprintf(buf+strlen(buf),"source route failed");
+			icmp_err_str = "source route failed";
 			break;
 		default:
-			sprintf(buf+strlen(buf)," UNKNOWN");
+			icmp_err_str = " UNKNOWN";
 			break;
 		}
-		sprintf(buf+strlen(buf),"\"");
-		bootmsg_error(0x3005, &buf[7]);
-
-		write_mm_log(buf, strlen(buf), 0x91);
+		netload_error(0x3005, "ICMP ERROR \"%s\"", icmp_err_str);
 		return -105;
 	} else if (rc == -40) {
-		sprintf(buf,
-			"E3014: (net) TFTP error occurred after "
+		netload_error(0x3014, "TFTP error occurred after "
 			"%d bad packets received",
 			tftp_err.bad_tftp_packets);
-		bootmsg_error(0x3014, &buf[7]);
-		write_mm_log(buf, strlen(buf), 0x91);
 		return -113;
 	} else if (rc == -41) {
-		sprintf(buf,
-			"E3015: (net) TFTP error occurred after "
+		netload_error(0x3015, "TFTP error occurred after "
 			"missing %d responses",
 			tftp_err.no_packets);
-		bootmsg_error(0x3015, &buf[7]);
-		write_mm_log(buf, strlen(buf), 0x91);
 		return -114;
 	} else if (rc == -42) {
-		sprintf(buf,
-			"E3016: (net) TFTP error missing block %d, "
+		netload_error(0x3016, "TFTP error missing block %d, "
 			"expected block was %d",
 			tftp_err.blocks_missed,
 			tftp_err.blocks_received);
-		bootmsg_error(0x3016, &buf[7]);
-		write_mm_log(buf, strlen(buf), 0x91);
 		return -115;
 	}
 	return rc;
-- 
1.8.3.1
