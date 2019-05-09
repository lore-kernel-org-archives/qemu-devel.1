Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E5C04AB2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDFC216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDFC216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOimJ-0002e8-PO
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:08:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOiii-0007j4-W9
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOiih-0007hj-7M
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOiig-0007Rv-W8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FAE0306D329
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 13:03:54 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-227.ams2.redhat.com
	[10.36.116.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5FF4460E37;
	Thu,  9 May 2019 13:03:53 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:03:43 +0200
Message-Id: <20190509130345.227526-3-sgarzare@redhat.com>
In-Reply-To: <20190509130345.227526-1-sgarzare@redhat.com>
References: <20190509130345.227526-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 09 May 2019 13:03:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/4] net: avoid using variable length array
 in net_client_init()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

net_client_init() uses a variable length array to store the prefix
of 'ipv6-net' parameter (e.g. if ipv6-net=3Dfec0::0/64, the prefix
is 'fec0::0').
This patch introduces g_strsplit() to split the 'ipv6-net' parameter,
so we can remove the variable length array.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/net.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/net.c b/net/net.c
index d5071e49e2..932fa5abb5 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1118,29 +1118,38 @@ static int net_client_init(QemuOpts *opts, bool i=
s_netdev, Error **errp)
         const char *ip6_net =3D qemu_opt_get(opts, "ipv6-net");
=20
         if (ip6_net) {
-            char buf[strlen(ip6_net) + 1];
+            gchar **substrings;
+            char *prefix_addr;
+            unsigned long prefix_len =3D 64; /* Default 64bit prefix len=
gth. */
=20
-            if (get_str_sep(buf, sizeof(buf), &ip6_net, '/') < 0) {
-                /* Default 64bit prefix length.  */
-                qemu_opt_set(opts, "ipv6-prefix", ip6_net, &error_abort)=
;
-                qemu_opt_set_number(opts, "ipv6-prefixlen", 64, &error_a=
bort);
-            } else {
+            substrings =3D g_strsplit(ip6_net, "/", 2);
+            if (!substrings || !substrings[0]) {
+                    error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                               "ipv6-net", "a valid IPv6 prefix");
+                    g_strfreev(substrings);
+                    goto out;
+            }
+
+            *prefix_addr =3D substrings[0];
+
+            if (substrings[1]) {
                 /* User-specified prefix length.  */
-                unsigned long len;
                 int err;
=20
-                qemu_opt_set(opts, "ipv6-prefix", buf, &error_abort);
-                err =3D qemu_strtoul(ip6_net, NULL, 10, &len);
-
+                err =3D qemu_strtoul(substrings[1], NULL, 10, &prefix_le=
n);
                 if (err) {
                     error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                                "ipv6-prefixlen", "a number");
+                    g_strfreev(substrings);
                     goto out;
                 }
-
-                qemu_opt_set_number(opts, "ipv6-prefixlen", len, &error_=
abort);
             }
+
+            qemu_opt_set(opts, "ipv6-prefix", prefix_addr, &error_abort)=
;
+            qemu_opt_set_number(opts, "ipv6-prefixlen", prefix_len,
+                                &error_abort);
             qemu_opt_unset(opts, "ipv6-net");
+            g_strfreev(substrings);
         }
     }
=20
--=20
2.20.1


