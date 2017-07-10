Received: from eggs.gnu.org ([2001:4830:134:3::10]:55282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUagd-0005HL-2L
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUaga-0003Dk-9f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUaga-0003D6-0d
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:33:20 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 10 Jul 2017 17:32:40 +0200
Message-Id: <1499700760-4777-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1499700760-4777-1-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/10] pc-bios/s390-ccw: Link libnet into
 the netboot image and do the TFTP load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

Most of the code has been taken from SLOF's netload.c file. Now we
can finally load an image via TFTP and execute the downloaded kernel.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netboot.mak |  12 ++-
 pc-bios/s390-ccw/netmain.c   | 225 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index dd9119a..8c54b05 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,7 +1,7 @@
 
 SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-NETOBJS := start.o sclp.o virtio.o virtio-net.o netmain.o sbrk.o libc.a
+NETOBJS := start.o sclp.o virtio.o virtio-net.o netmain.o sbrk.o libnet.a libc.a
 
 LIBC_INC := -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
@@ -39,3 +39,13 @@ libc.a: $(LIBCOBJS)
 
 sbrk.o: $(SLOF_DIR)/slof/sbrk.c
 	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(LIBC_INC) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
+	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o
+LIBNETCFLAGS :=  $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+
+%.o : $(SLOF_DIR)/lib/libnet/%.c
+	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+libnet.a: $(LIBNETOBJS)
+	$(call quiet-command,$(AR) -rc $@ $^,"AR","$(TARGET_DIR)$@")
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index fcdd7a1..ba0ccb3 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -6,6 +6,9 @@
  * Based on the S390 virtio-ccw loading program (main.c)
  * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
  *
+ * And based on the network loading code from SLOF (netload.c)
+ * Copyright (c) 2004, 2008 IBM Corporation
+ *
  * This code is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -18,17 +21,29 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
+#include <tftp.h>
+#include <ethernet.h>
+#include <dhcp.h>
+#include <dhcpv6.h>
+#include <ipv4.h>
+#include <ipv6.h>
+#include <dns.h>
 #include <time.h>
 
 #include "s390-ccw.h"
 #include "virtio.h"
 
+#define DEFAULT_BOOT_RETRIES 10
+#define DEFAULT_TFTP_RETRIES 20
+
 extern char _start[];
 
 char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
 IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
 
 static SubChannelId blk_schid = { .one = 1 };
+static int ip_version = 4;
 static uint64_t dest_timer;
 
 static uint64_t get_timer_ms(void)
@@ -56,6 +71,208 @@ int get_sec_ticks(void)
     return 1000;    /* number of ticks in 1 second */
 }
 
+/**
+ * Obtain IP and configuration info from DHCP server (either IPv4 or IPv6).
+ * @param  fn_ip     contains the following configuration information:
+ *                   client MAC, client IP, TFTP-server MAC, TFTP-server IP,
+ *                   boot file name
+ * @param  retries   Number of DHCP attempts
+ * @return           0 : IP and configuration info obtained;
+ *                   non-0 : error condition occurred.
+ */
+static int dhcp(struct filename_ip *fn_ip, int retries)
+{
+    int i = retries + 1;
+    int rc = -1;
+
+    printf("  Requesting information via DHCP:     ");
+
+    dhcpv4_generate_transaction_id();
+    dhcpv6_generate_transaction_id();
+
+    do {
+        printf("\b\b\b%03d", i - 1);
+        if (!--i) {
+            printf("\nGiving up after %d DHCP requests\n", retries);
+            return -1;
+        }
+        ip_version = 4;
+        rc = dhcpv4(NULL, fn_ip);
+        if (rc == -1) {
+            ip_version = 6;
+            set_ipv6_address(fn_ip->fd, 0);
+            rc = dhcpv6(NULL, fn_ip);
+            if (rc == 0) {
+                memcpy(&fn_ip->own_ip6, get_ipv6_address(), 16);
+                break;
+            }
+        }
+        if (rc != -1) {    /* either success or non-dhcp failure */
+            break;
+        }
+    } while (1);
+    printf("\b\b\b\bdone\n");
+
+    return rc;
+}
+
+/**
+ * Seed the random number generator with our mac and current timestamp
+ */
+static void seed_rng(uint8_t mac[])
+{
+    uint64_t seed;
+
+    asm volatile(" stck %0 " : : "Q"(seed) : "memory");
+    seed ^= (mac[2] << 24) | (mac[3] << 16) | (mac[4] << 8) | mac[5];
+    srand(seed);
+}
+
+static int tftp_load(filename_ip_t *fnip, void *buffer, int len,
+                     unsigned int retries, int ip_vers)
+{
+    tftp_err_t tftp_err;
+    int rc;
+
+    rc = tftp(fnip, buffer, len, retries, &tftp_err, 1, 1428, ip_vers);
+
+    if (rc > 0) {
+        printf("  TFTP: Received %s (%d KBytes)\n", fnip->filename,
+               rc / 1024);
+    } else if (rc == -1) {
+        puts("unknown TFTP error");
+    } else if (rc == -2) {
+        printf("TFTP buffer of %d bytes is too small for %s\n",
+            len, fnip->filename);
+    } else if (rc == -3) {
+        printf("file not found: %s\n", fnip->filename);
+    } else if (rc == -4) {
+        puts("TFTP access violation");
+    } else if (rc == -5) {
+        puts("illegal TFTP operation");
+    } else if (rc == -6) {
+        puts("unknown TFTP transfer ID");
+    } else if (rc == -7) {
+        puts("no such TFTP user");
+    } else if (rc == -8) {
+        puts("TFTP blocksize negotiation failed");
+    } else if (rc == -9) {
+        puts("file exceeds maximum TFTP transfer size");
+    } else if (rc <= -10 && rc >= -15) {
+        const char *icmp_err_str;
+        switch (rc) {
+        case -ICMP_NET_UNREACHABLE - 10:
+            icmp_err_str = "net unreachable";
+            break;
+        case -ICMP_HOST_UNREACHABLE - 10:
+            icmp_err_str = "host unreachable";
+            break;
+        case -ICMP_PROTOCOL_UNREACHABLE - 10:
+            icmp_err_str = "protocol unreachable";
+            break;
+        case -ICMP_PORT_UNREACHABLE - 10:
+            icmp_err_str = "port unreachable";
+            break;
+        case -ICMP_FRAGMENTATION_NEEDED - 10:
+            icmp_err_str = "fragmentation needed and DF set";
+            break;
+        case -ICMP_SOURCE_ROUTE_FAILED - 10:
+            icmp_err_str = "source route failed";
+            break;
+        default:
+            icmp_err_str = " UNKNOWN";
+            break;
+        }
+        printf("ICMP ERROR \"%s\"\n", icmp_err_str);
+    } else if (rc == -40) {
+        printf("TFTP error occurred after %d bad packets received",
+            tftp_err.bad_tftp_packets);
+    } else if (rc == -41) {
+        printf("TFTP error occurred after missing %d responses",
+            tftp_err.no_packets);
+    } else if (rc == -42) {
+        printf("TFTP error missing block %d, expected block was %d",
+            tftp_err.blocks_missed,
+            tftp_err.blocks_received);
+    }
+
+    return rc;
+}
+
+static int net_load(char *buffer, int len)
+{
+    filename_ip_t fn_ip;
+    uint8_t mac[6];
+    int rc;
+
+    memset(&fn_ip, 0, sizeof(filename_ip_t));
+
+    rc = virtio_net_init(mac);
+    if (rc < 0) {
+        puts("Could not initialize network device");
+        return -101;
+    }
+    fn_ip.fd = rc;
+
+    printf("  Using MAC address: %02x:%02x:%02x:%02x:%02x:%02x\n",
+           mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+
+    set_mac_address(mac);    /* init ethernet layer */
+    seed_rng(mac);
+
+    rc = dhcp(&fn_ip, DEFAULT_BOOT_RETRIES);
+    if (rc >= 0) {
+        if (ip_version == 4) {
+            set_ipv4_address(fn_ip.own_ip);
+        }
+    } else {
+        puts("Could not get IP address");
+        return -101;
+    }
+
+    if (ip_version == 4) {
+        printf("  Using IPv4 address: %d.%d.%d.%d\n",
+              (fn_ip.own_ip >> 24) & 0xFF, (fn_ip.own_ip >> 16) & 0xFF,
+              (fn_ip.own_ip >>  8) & 0xFF, fn_ip.own_ip & 0xFF);
+    } else if (ip_version == 6) {
+        char ip6_str[40];
+        ipv6_to_str(fn_ip.own_ip6.addr, ip6_str);
+        printf("  Using IPv6 address: %s\n", ip6_str);
+    }
+
+    if (rc == -2) {
+        printf("ARP request to TFTP server (%d.%d.%d.%d) failed\n",
+               (fn_ip.server_ip >> 24) & 0xFF, (fn_ip.server_ip >> 16) & 0xFF,
+               (fn_ip.server_ip >>  8) & 0xFF, fn_ip.server_ip & 0xFF);
+        return -102;
+    }
+    if (rc == -4 || rc == -3) {
+        puts("Can't obtain TFTP server IP address");
+        return -107;
+    }
+
+    if (ip_version == 4) {
+        printf("  Requesting file \"%s\" via TFTP from %d.%d.%d.%d\n",
+               fn_ip.filename,
+               (fn_ip.server_ip >> 24) & 0xFF, (fn_ip.server_ip >> 16) & 0xFF,
+               (fn_ip.server_ip >>  8) & 0xFF, fn_ip.server_ip & 0xFF);
+    } else if (ip_version == 6) {
+        char ip6_str[40];
+        printf("  Requesting file \"%s\" via TFTP from ", fn_ip.filename);
+        ipv6_to_str(fn_ip.server_ip6.addr, ip6_str);
+        printf("%s\n", ip6_str);
+    }
+
+    /* Do the TFTP load and print error message if necessary */
+    rc = tftp_load(&fn_ip, buffer, len, DEFAULT_TFTP_RETRIES, ip_version);
+
+    if (ip_version == 4) {
+        dhcp_send_release(fn_ip.fd);
+    }
+
+    return rc;
+}
+
 void panic(const char *string)
 {
     sclp_print(string);
@@ -131,10 +348,18 @@ static void virtio_setup(void)
 
 void main(void)
 {
+    int rc;
+
     sclp_setup();
     sclp_print("Network boot starting...\n");
 
     virtio_setup();
 
+    rc = net_load(NULL, (long)_start);
+    if (rc > 0) {
+        sclp_print("Network loading done, starting kernel...\n");
+        asm volatile (" lpsw 0(%0) " : : "r"(0) : "memory");
+    }
+
     panic("Failed to load OS from network\n");
 }
-- 
1.8.3.1
