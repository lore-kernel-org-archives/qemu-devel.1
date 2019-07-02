Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E05EC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453B92146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453B92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48167 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9dv-0003fP-GM
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aG-0004jI-Nh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aE-0003d3-Re
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aD-0003by-5C
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C42CF7E428;
 Tue,  2 Jul 2019 02:31:46 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 323DC60C43;
 Tue,  2 Jul 2019 02:31:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:18 +0800
Message-Id: <1562034689-6539-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 02:31:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/17] net: use g_strsplit() for parsing host
 address and port
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Use the glib function to split host address and port in
the parse_host_port() function.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/net.c b/net/net.c
index 76ba0b7..5ce3996 100644
--- a/net/net.c
+++ b/net/net.c
@@ -87,32 +87,39 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
 int parse_host_port(struct sockaddr_in *saddr, const char *str,
                     Error **errp)
 {
-    char buf[512];
+    gchar **substrings;
     struct hostent *he;
-    const char *p, *r;
-    int port;
+    const char *addr, *p, *r;
+    int port, ret = 0;
 
-    p = str;
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+    substrings = g_strsplit(str, ":", 2);
+    if (!substrings || !substrings[0] || !substrings[1]) {
         error_setg(errp, "host address '%s' doesn't contain ':' "
                    "separating host from port", str);
-        return -1;
+        ret = -1;
+        goto out;
     }
+
+    addr = substrings[0];
+    p = substrings[1];
+
     saddr->sin_family = AF_INET;
-    if (buf[0] == '\0') {
+    if (addr[0] == '\0') {
         saddr->sin_addr.s_addr = 0;
     } else {
-        if (qemu_isdigit(buf[0])) {
-            if (!inet_aton(buf, &saddr->sin_addr)) {
+        if (qemu_isdigit(addr[0])) {
+            if (!inet_aton(addr, &saddr->sin_addr)) {
                 error_setg(errp, "host address '%s' is not a valid "
-                           "IPv4 address", buf);
-                return -1;
+                           "IPv4 address", addr);
+                ret = -1;
+                goto out;
             }
         } else {
-            he = gethostbyname(buf);
+            he = gethostbyname(addr);
             if (he == NULL) {
-                error_setg(errp, "can't resolve host address '%s'", buf);
-                return - 1;
+                error_setg(errp, "can't resolve host address '%s'", addr);
+                ret = -1;
+                goto out;
             }
             saddr->sin_addr = *(struct in_addr *)he->h_addr;
         }
@@ -120,10 +127,14 @@ int parse_host_port(struct sockaddr_in *saddr, const char *str,
     port = strtol(p, (char **)&r, 0);
     if (r == p) {
         error_setg(errp, "port number '%s' is invalid", p);
-        return -1;
+        ret = -1;
+        goto out;
     }
     saddr->sin_port = htons(port);
-    return 0;
+
+out:
+    g_strfreev(substrings);
+    return ret;
 }
 
 char *qemu_mac_strdup_printf(const uint8_t *macaddr)
-- 
2.5.0


