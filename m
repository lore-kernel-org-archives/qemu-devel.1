Received: from eggs.gnu.org ([2001:4830:134:3::10]:59217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zdai@linux.vnet.ibm.com>) id 1cW3H5-00007d-5R
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zdai@linux.vnet.ibm.com>) id 1cW3H2-0007cc-2a
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:44:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zdai@linux.vnet.ibm.com>)
	id 1cW3H1-0007by-Ow
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:44:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OFZb2t047488
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:44:40 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 285ee5u7tw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:44:39 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zdai@linux.vnet.ibm.com>;
	Tue, 24 Jan 2017 08:44:38 -0700
From: David Dai <zdai@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 09:44:33 -0600
Message-Id: <1485272673-5877-1-git-send-email-zdai@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] Migration: libvirt live migration over
 RDMA of ipv6 addr failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, mdroth@linux.vnet.ibm.com, zdai@us.ibm.com

Using libvirt to do live migration over RDMA via ip v6 address failed. 
For example:
# virsh migrate  --live --migrateuri rdma://[deba::2222]:49152  \
              rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verbose
root@deba::2222's password:
error: internal error: unable to execute QEMU command 'migrate': RDMA ERROR:  
                  could not rdma_getaddrinfo address deba

As we can see, the ip v6 address used by rdma_getaddrinfo() has only "deba" 
part. It should be "deba::2222".

1) According to rfc 3986, a literal ip v6 address should be enclosed 
in '[' and ']'.
When using virsh command to do live migration via ip v6 addresss, user
will input the ip v6 address with brackets (i.e. rdma://[deba::2222]:49152).
libvirt will parse command line option by calling virURIParse(). 
Inside it calls virStringStripIPv6Brackets() to strip off the brackets.
The uri passed in to virURIParse()  is:
   "uri = rdma://[deba::2222]:49152"
Inside virURIParse() routine, it will strip off the bracket '[' and ']' if
it's ip v6 address. Then save the ip v6 address in this format "deba::2222" 
in the virURI->server field, and to be passed to qemu.

2) At the beginning of migration, in qemu's qemu_rdma_data_init(host_port) 
routine, it calls inet_parse(host_port) routine to parse the ip v6 address and 
port string obtained from libvirt.
The input string host_port passed to qemu_rdma_data_init() can be:
    "hostname:port", or
    "ipv4address:port", or
    "[ipv6address]:port" (i.e "[deba::2222]:49152"), or
    "ipv6address:port" (i.e "deba::2222:49152").
Existing qemu api inet_parse() can handle the above first 3 cases properly,  
but didn't handle the last case ("ipv6address:port") correctly.
In this live migration over rdma via ip v6 address case, the server ip v6 
address obtained from libvirt doesn't contain the brackets '[' and ']' 
(i.e. "deba::2222:49152"). It caused inet_parse() to parse only "deba" part, 
and stopped at the 1st colon ':'. As the result, the subsequent 
rdma_getaddrinfo() with ip address "deba" will fail.

If we don't strip off brackets '[' and ']' for an ip v6 address in libvirt's 
virURIParse(), it will cause libvirt ipv6 ssh authentication failure.

NOTE:
If using libvirt to do live migration over TCP via ip v6 address:
# virsh migrate  --live --migrateuri tcp://[deba::2222]:49152  \
              rhel73_host1_guest1 qemu+ssh://[deba::2222]/system --verbose
It works fine.
In migrateuri of tcp case, libvirt will call virNetSocketNewConnectTCP()
directly to connect to remote "deba::2222:49152" after it strips off
the bracket '[' and ']' for an ip v6 address. 
On qemu side, fd_start_outgoing_migration() will be called to do migration.
It doesn't call inet_parse(). So we don't see issue in tcp case.

Solution:
I choose to fix the code in qemu's inet_parse() routine to parse the
ip v6 addresss w/o brackets properly (i.e. "deba::2222:49152" format).

Signed-off-by: David Dai <zdai@linux.vnet.ibm.com>
---
 util/qemu-sockets.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 7c120c4..e09191c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -584,6 +584,8 @@ InetSocketAddress *inet_parse(const char *str, Error **errp)
     char port[33];
     int to;
     int pos;
+    char *first_col_p = strchr(str, ':');
+    char *last_col_p = strrchr(str, ':');
 
     addr = g_new0(InetSocketAddress, 1);
 
@@ -595,11 +597,27 @@ InetSocketAddress *inet_parse(const char *str, Error **errp)
             error_setg(errp, "error parsing port in address '%s'", str);
             goto fail;
         }
-    } else if (str[0] == '[') {
-        /* IPv6 addr */
-        if (sscanf(str, "[%64[^]]]:%32[^,]%n", host, port, &pos) != 2) {
-            error_setg(errp, "error parsing IPv6 address '%s'", str);
-            goto fail;
+    } else if (first_col_p != last_col_p) {
+        if (str[0] != '[') {
+            /* IPv6 addr w/o brackets */
+            char *port_p;
+            char *comma_p;
+
+            pstrcpy(host, sizeof(host), str);
+            port_p = strrchr(host, ':');
+            *port_p++ = '\0';
+            pstrcpy(port, sizeof(port), port_p);
+            comma_p = strchr(port, ',');
+            if (comma_p != NULL) {
+                *comma_p = '\0';
+            }
+            pos = strlen(host) + strlen(port) + 1;
+        } else {
+            /* IPv6 addr with brackets */
+            if (2 != sscanf(str, "[%64[^]]]:%32[^,]%n", host, port, &pos)) {
+                error_setg(errp, "error parsing IPv6 address '%s'", str);
+                goto fail;
+            }
         }
         addr->ipv6 = addr->has_ipv6 = true;
     } else {
-- 
1.7.1
