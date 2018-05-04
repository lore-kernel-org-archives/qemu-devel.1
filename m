Received: from eggs.gnu.org ([2001:4830:134:3::10]:34265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV69-0004Xj-TS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV68-0007Si-HV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:10 +0200
Message-Id: <20180504072514.8450-12-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] pc-bios/s390-ccw/net: Split up net_load()
 into init, load and release parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

When we want to support pxelinux-style network booting later, we've got
to do several TFTP transfers - and we do not want to apply for a new IP
address via DHCP each time. So split up net_load into three parts:

1. net_init(), which initializes virtio-net, gets an IP address via DHCP
   and prints out the related information.

2. The tftp_load call is now moved directly into the main() function

3. A new net_release() function which should tear down the network stack
   before we are done in the firmware.

This will make it easier to extend the code in the next patches.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netmain.c | 63 +++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index d86d46b03f..8fa9e6c945 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -128,13 +128,13 @@ static void seed_rng(uint8_t mac[])
     srand(seed);
 }
 
-static int tftp_load(filename_ip_t *fnip, void *buffer, int len,
-                     unsigned int retries, int ip_vers)
+static int tftp_load(filename_ip_t *fnip, void *buffer, int len)
 {
     tftp_err_t tftp_err;
     int rc;
 
-    rc = tftp(fnip, buffer, len, retries, &tftp_err, 1, 1428, ip_vers);
+    rc = tftp(fnip, buffer, len, DEFAULT_TFTP_RETRIES, &tftp_err, 1, 1428,
+              ip_version);
 
     if (rc > 0) {
         printf("  TFTP: Received %s (%d KBytes)\n", fnip->filename,
@@ -199,20 +199,19 @@ static int tftp_load(filename_ip_t *fnip, void *buffer, int len,
     return rc;
 }
 
-static int net_load(char *buffer, int len)
+static int net_init(filename_ip_t *fn_ip)
 {
-    filename_ip_t fn_ip;
     uint8_t mac[6];
     int rc;
 
-    memset(&fn_ip, 0, sizeof(filename_ip_t));
+    memset(fn_ip, 0, sizeof(filename_ip_t));
 
     rc = virtio_net_init(mac);
     if (rc < 0) {
         puts("Could not initialize network device");
         return -101;
     }
-    fn_ip.fd = rc;
+    fn_ip->fd = rc;
 
     printf("  Using MAC address: %02x:%02x:%02x:%02x:%02x:%02x\n",
            mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
@@ -220,10 +219,10 @@ static int net_load(char *buffer, int len)
     set_mac_address(mac);    /* init ethernet layer */
     seed_rng(mac);
 
-    rc = dhcp(&fn_ip, DEFAULT_BOOT_RETRIES);
+    rc = dhcp(fn_ip, DEFAULT_BOOT_RETRIES);
     if (rc >= 0) {
         if (ip_version == 4) {
-            set_ipv4_address(fn_ip.own_ip);
+            set_ipv4_address(fn_ip->own_ip);
         }
     } else {
         puts("Could not get IP address");
@@ -232,18 +231,18 @@ static int net_load(char *buffer, int len)
 
     if (ip_version == 4) {
         printf("  Using IPv4 address: %d.%d.%d.%d\n",
-              (fn_ip.own_ip >> 24) & 0xFF, (fn_ip.own_ip >> 16) & 0xFF,
-              (fn_ip.own_ip >>  8) & 0xFF, fn_ip.own_ip & 0xFF);
+              (fn_ip->own_ip >> 24) & 0xFF, (fn_ip->own_ip >> 16) & 0xFF,
+              (fn_ip->own_ip >>  8) & 0xFF, fn_ip->own_ip & 0xFF);
     } else if (ip_version == 6) {
         char ip6_str[40];
-        ipv6_to_str(fn_ip.own_ip6.addr, ip6_str);
+        ipv6_to_str(fn_ip->own_ip6.addr, ip6_str);
         printf("  Using IPv6 address: %s\n", ip6_str);
     }
 
     if (rc == -2) {
         printf("ARP request to TFTP server (%d.%d.%d.%d) failed\n",
-               (fn_ip.server_ip >> 24) & 0xFF, (fn_ip.server_ip >> 16) & 0xFF,
-               (fn_ip.server_ip >>  8) & 0xFF, fn_ip.server_ip & 0xFF);
+               (fn_ip->server_ip >> 24) & 0xFF, (fn_ip->server_ip >> 16) & 0xFF,
+               (fn_ip->server_ip >>  8) & 0xFF, fn_ip->server_ip & 0xFF);
         return -102;
     }
     if (rc == -4 || rc == -3) {
@@ -251,28 +250,31 @@ static int net_load(char *buffer, int len)
         return -107;
     }
 
+    printf("  Using TFTP server: ");
     if (ip_version == 4) {
-        printf("  Requesting file \"%s\" via TFTP from %d.%d.%d.%d\n",
-               fn_ip.filename,
-               (fn_ip.server_ip >> 24) & 0xFF, (fn_ip.server_ip >> 16) & 0xFF,
-               (fn_ip.server_ip >>  8) & 0xFF, fn_ip.server_ip & 0xFF);
+        printf("%d.%d.%d.%d\n",
+               (fn_ip->server_ip >> 24) & 0xFF, (fn_ip->server_ip >> 16) & 0xFF,
+               (fn_ip->server_ip >>  8) & 0xFF, fn_ip->server_ip & 0xFF);
     } else if (ip_version == 6) {
         char ip6_str[40];
-        printf("  Requesting file \"%s\" via TFTP from ", fn_ip.filename);
-        ipv6_to_str(fn_ip.server_ip6.addr, ip6_str);
+        ipv6_to_str(fn_ip->server_ip6.addr, ip6_str);
         printf("%s\n", ip6_str);
     }
 
-    /* Do the TFTP load and print error message if necessary */
-    rc = tftp_load(&fn_ip, buffer, len, DEFAULT_TFTP_RETRIES, ip_version);
-
-    if (ip_version == 4) {
-        dhcp_send_release(fn_ip.fd);
+    if (strlen((char *)fn_ip->filename) > 0) {
+        printf("  Bootfile name: '%s'\n", fn_ip->filename);
     }
 
     return rc;
 }
 
+static void net_release(filename_ip_t *fn_ip)
+{
+    if (ip_version == 4) {
+        dhcp_send_release(fn_ip->fd);
+    }
+}
+
 void panic(const char *string)
 {
     sclp_print(string);
@@ -344,6 +346,7 @@ static void virtio_setup(void)
 
 void main(void)
 {
+    filename_ip_t fn_ip;
     int rc;
 
     sclp_setup();
@@ -351,7 +354,15 @@ void main(void)
 
     virtio_setup();
 
-    rc = net_load(NULL, (long)_start);
+    rc = net_init(&fn_ip);
+    if (rc) {
+        panic("Network initialization failed. Halting.\n");
+    }
+
+    rc = tftp_load(&fn_ip, NULL, (long)_start);
+
+    net_release(&fn_ip);
+
     if (rc > 0) {
         sclp_print("Network loading done, starting kernel...\n");
         asm volatile (" lpsw 0(%0) " : : "r"(0) : "memory");
-- 
2.14.3
