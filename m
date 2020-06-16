Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863F22074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y70ltuxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863F22074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5Xu-0002hl-Ph
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5NK-0002WG-7J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:47:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52889
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5NG-0005qO-U1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592290030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=IDvJc4lUGQTwqv7uiU+Gab1nKluMeqbegsioSAJZHC0=;
 b=Y70ltuxtRykbU7i67+DMxbPR/L6W7S3kKhlNcKURTXWw5Yl5qqZOtfwrGSz94n48Lrk3nP
 v3jTxfUFwfn9EY/pEqE3MYNgn0efSzHk9DbHK+gOKTBIzbdJVRC/+1WhNUSlHE1tSmTXfg
 C9Rpz0GAiJ2Z6VRF1vi/sgwnk/oudmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-AJVUl9t2M5Sl5j0jYyW0ow-1; Tue, 16 Jun 2020 02:47:08 -0400
X-MC-Unique: AJVUl9t2M5Sl5j0jYyW0ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 515071138300;
 Tue, 16 Jun 2020 06:47:07 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE39390343;
 Tue, 16 Jun 2020 06:47:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 33/33] net: Drop the NetLegacy structure,
 always use Netdev instead
Date: Tue, 16 Jun 2020 14:45:44 +0800
Message-Id: <1592289944-13727-34-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Now that the "name" parameter is gone, there is hardly any difference
between NetLegacy and Netdev anymore, so we can drop NetLegacy and always
use Netdev to simplify the code quite a bit.

The only two differences that were really left between Netdev and NetLegacy:

1) NetLegacy does not allow a "hubport" type. We can continue to block
   this with a simple check in net_client_init1() for this type.

2) The "id" parameter was optional in NetLegacy (and an internal id
   was chosen via assign_name() during initialization), but it is mandatory
   for Netdev. To avoid that the visitor code bails out here, we have to
   add an internal id to the QemuOpts already earlier now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/net.c     | 77 ++++++++++-------------------------------------------------
 qapi/net.json | 46 -----------------------------------
 2 files changed, 13 insertions(+), 110 deletions(-)

diff --git a/net/net.c b/net/net.c
index e55d357..d113029 100644
--- a/net/net.c
+++ b/net/net.c
@@ -965,15 +965,11 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 };
 
 
-static int net_client_init1(const void *object, bool is_netdev, Error **errp)
+static int net_client_init1(const Netdev *netdev, bool is_netdev, Error **errp)
 {
-    Netdev legacy = {0};
-    const Netdev *netdev;
     NetClientState *peer = NULL;
 
     if (is_netdev) {
-        netdev = object;
-
         if (netdev->type == NET_CLIENT_DRIVER_NIC ||
             !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
@@ -981,56 +977,11 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
             return -1;
         }
     } else {
-        const NetLegacy *net = object;
-        const NetLegacyOptions *opts = net->opts;
-        legacy.id = net->id;
-        netdev = &legacy;
-
-        /* Map the old options to the new flat type */
-        switch (opts->type) {
-        case NET_LEGACY_OPTIONS_TYPE_NONE:
+        if (netdev->type == NET_CLIENT_DRIVER_NONE) {
             return 0; /* nothing to do */
-        case NET_LEGACY_OPTIONS_TYPE_NIC:
-            legacy.type = NET_CLIENT_DRIVER_NIC;
-            legacy.u.nic = opts->u.nic;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_USER:
-            legacy.type = NET_CLIENT_DRIVER_USER;
-            legacy.u.user = opts->u.user;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_TAP:
-            legacy.type = NET_CLIENT_DRIVER_TAP;
-            legacy.u.tap = opts->u.tap;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_L2TPV3:
-            legacy.type = NET_CLIENT_DRIVER_L2TPV3;
-            legacy.u.l2tpv3 = opts->u.l2tpv3;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_SOCKET:
-            legacy.type = NET_CLIENT_DRIVER_SOCKET;
-            legacy.u.socket = opts->u.socket;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_VDE:
-            legacy.type = NET_CLIENT_DRIVER_VDE;
-            legacy.u.vde = opts->u.vde;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_BRIDGE:
-            legacy.type = NET_CLIENT_DRIVER_BRIDGE;
-            legacy.u.bridge = opts->u.bridge;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_NETMAP:
-            legacy.type = NET_CLIENT_DRIVER_NETMAP;
-            legacy.u.netmap = opts->u.netmap;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_VHOST_USER:
-            legacy.type = NET_CLIENT_DRIVER_VHOST_USER;
-            legacy.u.vhost_user = opts->u.vhost_user;
-            break;
-        default:
-            abort();
         }
-
-        if (!net_client_init_fun[netdev->type]) {
+        if (netdev->type == NET_CLIENT_DRIVER_HUBPORT ||
+            !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
                        "a net backend type (maybe it is not compiled "
                        "into this binary)");
@@ -1039,7 +990,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
 
         /* Do not add to a hub if it's a nic with a netdev= parameter. */
         if (netdev->type != NET_CLIENT_DRIVER_NIC ||
-            !opts->u.nic.has_netdev) {
+            !netdev->u.nic.has_netdev) {
             peer = net_hub_add_port(0, NULL, NULL);
         }
     }
@@ -1100,7 +1051,7 @@ static void show_netdevs(void)
 static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
 {
     gchar **substrings = NULL;
-    void *object = NULL;
+    Netdev *object = NULL;
     Error *err = NULL;
     int ret = -1;
     Visitor *v = opts_visitor_new(opts);
@@ -1143,21 +1094,19 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
         }
     }
 
-    if (is_netdev) {
-        visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
-    } else {
-        visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
+    /* Create an ID for -net if the user did not specify one */
+    if (!is_netdev && !qemu_opts_id(opts)) {
+        static int idx;
+        qemu_opts_set_id(opts, g_strdup_printf("__org.qemu.net%i", idx++));
     }
 
+    visit_type_Netdev(v, NULL, &object, &err);
+
     if (!err) {
         ret = net_client_init1(object, is_netdev, &err);
     }
 
-    if (is_netdev) {
-        qapi_free_Netdev(object);
-    } else {
-        qapi_free_NetLegacy(object);
-    }
+    qapi_free_Netdev(object);
 
 out:
     error_propagate(errp, err);
diff --git a/qapi/net.json b/qapi/net.json
index fc7c95f..9244c9a 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -468,52 +468,6 @@
     'vhost-user': 'NetdevVhostUserOptions' } }
 
 ##
-# @NetLegacy:
-#
-# Captures the configuration of a network device; legacy.
-#
-# @id: identifier for monitor commands
-#
-# @opts: device type specific properties (legacy)
-#
-# Since: 1.2
-##
-{ 'struct': 'NetLegacy',
-  'data': {
-    '*id':   'str',
-    'opts':  'NetLegacyOptions' } }
-
-##
-# @NetLegacyOptionsType:
-#
-# Since: 1.2
-##
-{ 'enum': 'NetLegacyOptionsType',
-  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-           'bridge', 'netmap', 'vhost-user'] }
-
-##
-# @NetLegacyOptions:
-#
-# Like Netdev, but for use only by the legacy command line options
-#
-# Since: 1.2
-##
-{ 'union': 'NetLegacyOptions',
-  'base': { 'type': 'NetLegacyOptionsType' },
-  'discriminator': 'type',
-  'data': {
-    'nic':      'NetLegacyNicOptions',
-    'user':     'NetdevUserOptions',
-    'tap':      'NetdevTapOptions',
-    'l2tpv3':   'NetdevL2TPv3Options',
-    'socket':   'NetdevSocketOptions',
-    'vde':      'NetdevVdeOptions',
-    'bridge':   'NetdevBridgeOptions',
-    'netmap':   'NetdevNetmapOptions',
-    'vhost-user': 'NetdevVhostUserOptions' } }
-
-##
 # @NetFilterDirection:
 #
 # Indicates whether a netfilter is attached to a netdev's transmit queue or
-- 
2.5.0


