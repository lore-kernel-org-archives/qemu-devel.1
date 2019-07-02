Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A463C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9DB205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9DB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiA5N-0001Vi-KF
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50432)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aH-0004mF-Ua
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aG-0003e7-MM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aE-0003az-Pf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA1B1C0495A1;
 Tue,  2 Jul 2019 02:31:44 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 170E560C43;
 Tue,  2 Jul 2019 02:31:42 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:17 +0800
Message-Id: <1562034689-6539-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 02 Jul 2019 02:31:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/17] net: avoid using variable length array in
 net_client_init()
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

net_client_init() uses a variable length array to store the prefix
of 'ipv6-net' parameter (e.g. if ipv6-net=fec0::0/64, the prefix
is 'fec0::0').
This patch introduces g_strsplit() to split the 'ipv6-net' parameter,
so we can remove the variable length array.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/net.c b/net/net.c
index d21c2c7..76ba0b7 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1105,6 +1105,7 @@ static void show_netdevs(void)
 
 static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
 {
+    gchar **substrings = NULL;
     void *object = NULL;
     Error *err = NULL;
     int ret = -1;
@@ -1120,28 +1121,33 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
         const char *ip6_net = qemu_opt_get(opts, "ipv6-net");
 
         if (ip6_net) {
-            char buf[strlen(ip6_net) + 1];
+            char *prefix_addr;
+            unsigned long prefix_len = 64; /* Default 64bit prefix length. */
+
+            substrings = g_strsplit(ip6_net, "/", 2);
+            if (!substrings || !substrings[0]) {
+                error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "ipv6-net",
+                           "a valid IPv6 prefix");
+                goto out;
+            }
 
-            if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
-                /* Default 64bit prefix length.  */
-                qemu_opt_set(opts, "ipv6-prefix", ip6_net, &error_abort);
-                qemu_opt_set_number(opts, "ipv6-prefixlen", 64, &error_abort);
-            } else {
+            prefix_addr = substrings[0];
+
+            if (substrings[1]) {
                 /* User-specified prefix length.  */
-                unsigned long len;
                 int err;
 
-                qemu_opt_set(opts, "ipv6-prefix", buf, &error_abort);
-                err = qemu_strtoul(ip6_net, NULL, 10, &len);
-
+                err = qemu_strtoul(substrings[1], NULL, 10, &prefix_len);
                 if (err) {
                     error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                                "ipv6-prefixlen", "a number");
                     goto out;
                 }
-
-                qemu_opt_set_number(opts, "ipv6-prefixlen", len, &error_abort);
             }
+
+            qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abort);
+            qemu_opt_set_number(opts, "ipv6-prefixlen", prefix_len,
+                                &error_abort);
             qemu_opt_unset(opts, "ipv6-net");
         }
     }
@@ -1164,6 +1170,7 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
 
 out:
     error_propagate(errp, err);
+    g_strfreev(substrings);
     visit_free(v);
     return ret;
 }
-- 
2.5.0


