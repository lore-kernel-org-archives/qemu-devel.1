Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFAC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5D32245C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUd5ikrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5D32245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id6Jt-0002bI-8R
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1id6IS-0001fH-JG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1id6IQ-0004Cu-Ve
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:36:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1id6IQ-000493-MO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575610613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7SYa5Y0MKv0DgLCV2kisaAhsF152yZqIf5SgmK1aWI=;
 b=iUd5ikrMz+YPbNBksgm3Y1QSPI/fL7iySO4DHtt6e0W679A21A9o7HJP8uAQ4nSgKVvb0c
 iuc2TGahF6aIQCtslTAoYF7ugosSm2/N/dLEfYyRUjyzv8DL908ppSLuvPVx2l6QXIvhFb
 xLVs6q2Xk1YdLTuEGXWb839Qz8SAb2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-gIcX_4yXOCqIKJKAMwfQug-1; Fri, 06 Dec 2019 00:36:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D4071005512
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 05:36:51 +0000 (UTC)
Received: from thuth.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E06BD60FC4;
 Fri,  6 Dec 2019 05:36:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] net: Drop the NetLegacy structure,
 always use Netdev instead
Date: Fri,  6 Dec 2019 06:36:40 +0100
Message-Id: <20191206053640.29368-3-thuth@redhat.com>
In-Reply-To: <20191206053640.29368-1-thuth@redhat.com>
References: <20191206053640.29368-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gIcX_4yXOCqIKJKAMwfQug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the "name" parameter is gone, there is hardly any difference
between NetLegacy and Netdev anymore. Drop NetLegacy and always use
Netdev to simplify the code quite a bit.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/net.c     | 74 ++++++++-------------------------------------------
 qapi/net.json | 51 +----------------------------------
 2 files changed, 12 insertions(+), 113 deletions(-)

diff --git a/net/net.c b/net/net.c
index ee4a76eb3e..cfe524b4d1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -967,13 +967,14 @@ static int (* const net_client_init_fun[NET_CLIENT_DR=
IVER__MAX])(
=20
 static int net_client_init1(const void *object, bool is_netdev, Error **er=
rp)
 {
-    Netdev legacy =3D {0};
-    const Netdev *netdev;
+    const Netdev *netdev =3D object;
     NetClientState *peer =3D NULL;
=20
     if (is_netdev) {
-        netdev =3D object;
-
+        if (!netdev->has_id) {
+            error_setg(errp, QERR_MISSING_PARAMETER, "id");
+            return -1;
+        }
         if (netdev->type =3D=3D NET_CLIENT_DRIVER_NIC ||
             !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
@@ -981,56 +982,11 @@ static int net_client_init1(const void *object, bool =
is_netdev, Error **errp)
             return -1;
         }
     } else {
-        const NetLegacy *net =3D object;
-        const NetLegacyOptions *opts =3D net->opts;
-        legacy.id =3D net->id;
-        netdev =3D &legacy;
-
-        /* Map the old options to the new flat type */
-        switch (opts->type) {
-        case NET_LEGACY_OPTIONS_TYPE_NONE:
+        if (netdev->type =3D=3D NET_CLIENT_DRIVER_NONE) {
             return 0; /* nothing to do */
-        case NET_LEGACY_OPTIONS_TYPE_NIC:
-            legacy.type =3D NET_CLIENT_DRIVER_NIC;
-            legacy.u.nic =3D opts->u.nic;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_USER:
-            legacy.type =3D NET_CLIENT_DRIVER_USER;
-            legacy.u.user =3D opts->u.user;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_TAP:
-            legacy.type =3D NET_CLIENT_DRIVER_TAP;
-            legacy.u.tap =3D opts->u.tap;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_L2TPV3:
-            legacy.type =3D NET_CLIENT_DRIVER_L2TPV3;
-            legacy.u.l2tpv3 =3D opts->u.l2tpv3;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_SOCKET:
-            legacy.type =3D NET_CLIENT_DRIVER_SOCKET;
-            legacy.u.socket =3D opts->u.socket;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_VDE:
-            legacy.type =3D NET_CLIENT_DRIVER_VDE;
-            legacy.u.vde =3D opts->u.vde;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_BRIDGE:
-            legacy.type =3D NET_CLIENT_DRIVER_BRIDGE;
-            legacy.u.bridge =3D opts->u.bridge;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_NETMAP:
-            legacy.type =3D NET_CLIENT_DRIVER_NETMAP;
-            legacy.u.netmap =3D opts->u.netmap;
-            break;
-        case NET_LEGACY_OPTIONS_TYPE_VHOST_USER:
-            legacy.type =3D NET_CLIENT_DRIVER_VHOST_USER;
-            legacy.u.vhost_user =3D opts->u.vhost_user;
-            break;
-        default:
-            abort();
         }
-
-        if (!net_client_init_fun[netdev->type]) {
+        if (netdev->type =3D=3D NET_CLIENT_DRIVER_HUBPORT ||
+            !net_client_init_fun[netdev->type]) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
                        "a net backend type (maybe it is not compiled "
                        "into this binary)");
@@ -1039,7 +995,7 @@ static int net_client_init1(const void *object, bool i=
s_netdev, Error **errp)
=20
         /* Do not add to a hub if it's a nic with a netdev=3D parameter. *=
/
         if (netdev->type !=3D NET_CLIENT_DRIVER_NIC ||
-            !opts->u.nic.has_netdev) {
+            !netdev->u.nic.has_netdev) {
             peer =3D net_hub_add_port(0, NULL, NULL);
         }
     }
@@ -1137,21 +1093,13 @@ static int net_client_init(QemuOpts *opts, bool is_=
netdev, Error **errp)
         }
     }
=20
-    if (is_netdev) {
-        visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
-    } else {
-        visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
-    }
+    visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
=20
     if (!err) {
         ret =3D net_client_init1(object, is_netdev, &err);
     }
=20
-    if (is_netdev) {
-        qapi_free_Netdev(object);
-    } else {
-        qapi_free_NetLegacy(object);
-    }
+    qapi_free_Netdev(object);
=20
 out:
     error_propagate(errp, err);
diff --git a/qapi/net.json b/qapi/net.json
index ff280ccd16..fcf693924e 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -467,7 +467,7 @@
 # 'l2tpv3' - since 2.1
 ##
 { 'union': 'Netdev',
-  'base': { 'id': 'str', 'type': 'NetClientDriver' },
+  'base': { '*id': 'str', 'type': 'NetClientDriver' },
   'discriminator': 'type',
   'data': {
     'nic':      'NetLegacyNicOptions',
@@ -481,55 +481,6 @@
     'netmap':   'NetdevNetmapOptions',
     'vhost-user': 'NetdevVhostUserOptions' } }
=20
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
-#
-# 'vlan': dropped in 3.0
-# 'name': dropped in 5.0
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
--=20
2.18.1


