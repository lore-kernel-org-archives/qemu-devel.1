Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43ECC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9609E208A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edqZwDW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9609E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jak6K-0006Jj-Ny
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jak4v-0005PH-9Z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:01:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jak4u-00036K-1H
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589824886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=F1c+oilfDsSd/2cwkS5kVulDw/AxgAERhejaQ3GHa+0=;
 b=edqZwDW9CvjSBnZGWxgerTA21ReAOOJ4RIfzpbQR8y2tX3N35PZGmWOTIADV6Dn4VLI7k6
 rhBv23AgjSIupZeDufQU+2B1DOErx+cmZgsKB9T47uqGDH7XCAUymwce2ArVEsCRfyuwGg
 l7PiBnmNKiYbEug+iwbTBLR8DaPDIEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-bb1anneAOi6ocpVjo3Byjg-1; Mon, 18 May 2020 14:01:10 -0400
X-MC-Unique: bb1anneAOi6ocpVjo3Byjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F34CA1800D42
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 18:01:09 +0000 (UTC)
Received: from thuth.com (ovpn-112-242.ams2.redhat.com [10.36.112.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4CB410013D9;
 Mon, 18 May 2020 18:01:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] net: Drop the NetLegacy structure,
 always use Netdev instead
Date: Mon, 18 May 2020 20:01:03 +0200
Message-Id: <20200518180103.32484-3-thuth@redhat.com>
In-Reply-To: <20200518180103.32484-1-thuth@redhat.com>
References: <20200518180103.32484-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 Note: I did not rename the "is_netdev" parameter of the function (as
 Eric suggested) - you really have to think of "-netdev" vs. "-net"
 here and not about "Netdev" vs. "NetLegacy". But if this "is_netdev"
 thing still confuses us in the future, we can still rename it with an
 additional follow-up patch later instead.

 net/net.c     | 77 +++++++++------------------------------------------
 qapi/net.json | 46 ------------------------------
 2 files changed, 13 insertions(+), 110 deletions(-)

diff --git a/net/net.c b/net/net.c
index a24da66e66..d4cc5bd73e 100644
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
index fc7c95f6d8..9244c9af56 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -467,52 +467,6 @@
     'netmap':   'NetdevNetmapOptions',
     'vhost-user': 'NetdevVhostUserOptions' } }
 
-##
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
 ##
 # @NetFilterDirection:
 #
-- 
2.18.1


