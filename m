Received: from eggs.gnu.org ([209.51.188.92]:40767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44W-0001Ir-2z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44U-0003MH-Hb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44Q-0003CF-Jz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:20 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1oZL061872
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s07y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:01 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:00 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:05 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-32-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 31/97] slirp: Add sanity check for str option
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Fam Zheng <famz@redhat.com>

When user provides a long domainname or hostname that doesn't fit in the
DHCP packet, we mustn't overflow the response packet buffer. Instead,
report errors, following the g_warning() in the slirp->vdnssearch
branch.

Also check the strlen against 256 when initializing slirp, which limit
is also from the protocol where one byte represents the string length.
This gives an early error before the warning which is harder to notice
or diagnose.

Reported-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
(cherry picked from commit 6e157a0339793bb081705f52318fc77afd10addf)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/slirp.c   |  9 +++++++++
 slirp/bootp.c | 32 ++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 1e14318b4d..fd21dc728c 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -365,6 +365,15 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         return -1;
     }
 
+    if (vdomainname && strlen(vdomainname) > 255) {
+        error_setg(errp, "'domainname' parameter cannot exceed 255 bytes");
+        return -1;
+    }
+
+    if (vhostname && strlen(vhostname) > 255) {
+        error_setg(errp, "'vhostname' parameter cannot exceed 255 bytes");
+        return -1;
+    }
 
     nc = qemu_new_net_client(&net_slirp_info, peer, model, name);
 
diff --git a/slirp/bootp.c b/slirp/bootp.c
index 9e7b53ba94..1e8185f0ec 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -159,6 +159,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
     struct in_addr preq_addr;
     int dhcp_msg_type, val;
     uint8_t *q;
+    uint8_t *end;
     uint8_t client_ethaddr[ETH_ALEN];
 
     /* extract exact DHCP msg type */
@@ -240,6 +241,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
     rbp->bp_siaddr = saddr.sin_addr; /* Server IP address */
 
     q = rbp->bp_vend;
+    end = (uint8_t *)&rbp[1];
     memcpy(q, rfc1533_cookie, 4);
     q += 4;
 
@@ -292,24 +294,33 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
 
         if (*slirp->client_hostname) {
             val = strlen(slirp->client_hostname);
-            *q++ = RFC1533_HOSTNAME;
-            *q++ = val;
-            memcpy(q, slirp->client_hostname, val);
-            q += val;
+            if (q + val + 2 >= end) {
+                g_warning("DHCP packet size exceeded, "
+                    "omitting host name option.");
+            } else {
+                *q++ = RFC1533_HOSTNAME;
+                *q++ = val;
+                memcpy(q, slirp->client_hostname, val);
+                q += val;
+            }
         }
 
         if (slirp->vdomainname) {
             val = strlen(slirp->vdomainname);
-            *q++ = RFC1533_DOMAINNAME;
-            *q++ = val;
-            memcpy(q, slirp->vdomainname, val);
-            q += val;
+            if (q + val + 2 >= end) {
+                g_warning("DHCP packet size exceeded, "
+                    "omitting domain name option.");
+            } else {
+                *q++ = RFC1533_DOMAINNAME;
+                *q++ = val;
+                memcpy(q, slirp->vdomainname, val);
+                q += val;
+            }
         }
 
         if (slirp->vdnssearch) {
-            size_t spaceleft = sizeof(rbp->bp_vend) - (q - rbp->bp_vend);
             val = slirp->vdnssearch_len;
-            if (val + 1 > spaceleft) {
+            if (q + val >= end) {
                 g_warning("DHCP packet size exceeded, "
                     "omitting domain-search option.");
             } else {
@@ -331,6 +342,7 @@ static void bootp_reply(Slirp *slirp, const struct bootp_t *bp)
         memcpy(q, nak_msg, sizeof(nak_msg) - 1);
         q += sizeof(nak_msg) - 1;
     }
+    assert(q < end);
     *q = RFC1533_END;
 
     daddr.sin_addr.s_addr = 0xffffffffu;
-- 
2.17.1
