Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1AEC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A511206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnU/TBoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A511206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYU81-0005Ej-RH
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYU4q-00020I-Mh
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:32:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYU4p-0007lN-J8
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589286722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=6z1U8sO9SLfuN1XFZYy2zfWRK5y8vCJCBZ1CUTt7ekQ=;
 b=WnU/TBoj7FrxlXRms/OaKvkWDNpHgqVbULQgVeKiBrRSzD9Vlc3n+BgRmN7cE7c++/57Qy
 bHzDjpF9dze5DNRx6Isxe9A3uQILQiXpmjOYfZvDGRhvEVgTfPekW+Yr8rUVEXOvujkP0e
 e7lWh/D09H6K9lYv5Pq3PPWOQkq7LTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-uCFY12LDMVi2v2xut0vMKg-1; Tue, 12 May 2020 08:32:00 -0400
X-MC-Unique: uCFY12LDMVi2v2xut0vMKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA0C1005510
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:31:59 +0000 (UTC)
Received: from thuth.com (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE735100034E;
 Tue, 12 May 2020 12:31:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 2/2] net: Drop the NetLegacy structure,
 always use Netdev instead
Date: Tue, 12 May 2020 14:31:49 +0200
Message-Id: <20200512123149.30207-3-thuth@redhat.com>
In-Reply-To: <20200512123149.30207-1-thuth@redhat.com>
References: <20200512123149.30207-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
between NetLegacy and Netdev anymore. Drop NetLegacy and always use
Netdev to simplify the code quite a bit.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/net.c     | 74 ++++++++-------------------------------------------
 qapi/net.json | 48 +--------------------------------
 2 files changed, 12 insertions(+), 110 deletions(-)

diff --git a/net/net.c b/net/net.c
index a24da66e66..4177224939 100644
--- a/net/net.c
+++ b/net/net.c
@@ -967,13 +967,14 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
 
 static int net_client_init1(const void *object, bool is_netdev, Error **errp)
 {
-    Netdev legacy = {0};
-    const Netdev *netdev;
+    const Netdev *netdev = object;
     NetClientState *peer = NULL;
 
     if (is_netdev) {
-        netdev = object;
-
+        if (!netdev->has_id) {
+            error_setg(errp, QERR_MISSING_PARAMETER, "id");
+            return -1;
+        }
         if (netdev->type == NET_CLIENT_DRIVER_NIC ||
             !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
@@ -981,56 +982,11 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
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
@@ -1039,7 +995,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
 
         /* Do not add to a hub if it's a nic with a netdev= parameter. */
         if (netdev->type != NET_CLIENT_DRIVER_NIC ||
-            !opts->u.nic.has_netdev) {
+            !netdev->u.nic.has_netdev) {
             peer = net_hub_add_port(0, NULL, NULL);
         }
     }
@@ -1143,21 +1099,13 @@ static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
         }
     }
 
-    if (is_netdev) {
-        visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
-    } else {
-        visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
-    }
+    visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
 
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
index fc7c95f6d8..e344825c43 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -453,7 +453,7 @@
 #        'l2tpv3' - since 2.1
 ##
 { 'union': 'Netdev',
-  'base': { 'id': 'str', 'type': 'NetClientDriver' },
+  'base': { '*id': 'str', 'type': 'NetClientDriver' },
   'discriminator': 'type',
   'data': {
     'nic':      'NetLegacyNicOptions',
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


