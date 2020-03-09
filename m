Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB178C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BEF20866
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezm3raCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BEF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOU9-0003PD-Ki
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMq-00067q-SU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBOMp-00007s-9m
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBOMp-00007J-5G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583783230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJBV+28rB+qWj4imlLqi5ZAwAVNhuWvoD1lasvHrGQ0=;
 b=ezm3raCa+ksz9r4uUDGJGKOCWjwceFwx/uTVw4J3V+8AiTy9yZ7XwdQHRA2mJl8Z/0Rwj3
 UGnzHh0qh9G1T7rj9S21+scfizMPvOAvZ2Y8lwxZZQFdINwGvfZQ+G8jbPl+wUcKUT9dqN
 6RrLHK+ldI4UFw9VTjlQv4O2l/01aU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-QejU-jk5MjuglryfhnnyQg-1; Mon, 09 Mar 2020 15:47:08 -0400
X-MC-Unique: QejU-jk5MjuglryfhnnyQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E636C801E66
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 19:47:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACFB5C54A;
 Mon,  9 Mar 2020 19:47:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mlevitsk@redhat.com,
	thuth@redhat.com
Subject: [PULL 12/12] net: Remove deprecated [hub_id name] tuple of
 'hostfwd_add' / 'hostfwd_remove'
Date: Mon,  9 Mar 2020 19:46:50 +0000
Message-Id: <20200309194650.160552-13-dgilbert@redhat.com>
In-Reply-To: <20200309194650.160552-1-dgilbert@redhat.com>
References: <20200309194650.160552-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

It's been deprecated since QEMU v3.1.0. Time to finally remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191205104109.18680-1-thuth@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Reworked Thomas's deprecated.texi to the rst
---
 docs/system/deprecated.rst | 15 +++++++------
 hmp-commands.hx            |  8 +++----
 net/hub.c                  | 23 --------------------
 net/hub.h                  |  2 --
 net/slirp.c                | 44 +++++++++++---------------------------
 5 files changed, 25 insertions(+), 67 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 6c1d9034d9..0838338d8f 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -248,12 +248,6 @@ the 'wait' field, which is only applicable to sockets =
in server mode
 Human Monitor Protocol (HMP) commands
 -------------------------------------
=20
-The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (since 3.=
1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''
-
-The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
-'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
-
 ``cpu-add`` (since 4.0)
 '''''''''''''''''''''''
=20
@@ -430,6 +424,15 @@ QEMU Machine Protocol (QMP) commands
 The "autoload" parameter has been ignored since 2.12.0. All bitmaps
 are automatically loaded from qcow2 images.
=20
+Human Monitor Protocol (HMP) commands
+-------------------------------------
+
+The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed =
in 5.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
'''''''
+
+The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
+'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
+
 Related binaries
 ----------------
=20
diff --git a/hmp-commands.hx b/hmp-commands.hx
index eb3d1605fd..f12263e071 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1369,8 +1369,8 @@ ERST
 #ifdef CONFIG_SLIRP
     {
         .name       =3D "hostfwd_add",
-        .args_type  =3D "arg1:s,arg2:s?,arg3:s?",
-        .params     =3D "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr]:ho=
stport-[guestaddr]:guestport",
+        .args_type  =3D "arg1:s,arg2:s?",
+        .params     =3D "[netdev_id] [tcp|udp]:[hostaddr]:hostport-[guesta=
ddr]:guestport",
         .help       =3D "redirect TCP or UDP connections from host to gues=
t (requires -net user)",
         .cmd        =3D hmp_hostfwd_add,
     },
@@ -1383,8 +1383,8 @@ ERST
 #ifdef CONFIG_SLIRP
     {
         .name       =3D "hostfwd_remove",
-        .args_type  =3D "arg1:s,arg2:s?,arg3:s?",
-        .params     =3D "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr]:ho=
stport",
+        .args_type  =3D "arg1:s,arg2:s?",
+        .params     =3D "[netdev_id] [tcp|udp]:[hostaddr]:hostport",
         .help       =3D "remove host-to-guest TCP or UDP redirection",
         .cmd        =3D hmp_hostfwd_remove,
     },
diff --git a/net/hub.c b/net/hub.c
index 5795a678ed..88cfb876f3 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -193,29 +193,6 @@ NetClientState *net_hub_add_port(int hub_id, const cha=
r *name,
     return &port->nc;
 }
=20
-/**
- * Find a specific client on a hub
- */
-NetClientState *net_hub_find_client_by_name(int hub_id, const char *name)
-{
-    NetHub *hub;
-    NetHubPort *port;
-    NetClientState *peer;
-
-    QLIST_FOREACH(hub, &hubs, next) {
-        if (hub->id =3D=3D hub_id) {
-            QLIST_FOREACH(port, &hub->ports, next) {
-                peer =3D port->nc.peer;
-
-                if (peer && strcmp(peer->name, name) =3D=3D 0) {
-                    return peer;
-                }
-            }
-        }
-    }
-    return NULL;
-}
-
 /**
  * Find a available port on a hub; otherwise create one new port
  */
diff --git a/net/hub.h b/net/hub.h
index 66d3322fac..ce45f7b399 100644
--- a/net/hub.h
+++ b/net/hub.h
@@ -15,10 +15,8 @@
 #ifndef NET_HUB_H
 #define NET_HUB_H
=20
-
 NetClientState *net_hub_add_port(int hub_id, const char *name,
                                  NetClientState *hubpeer);
-NetClientState *net_hub_find_client_by_name(int hub_id, const char *name);
 void net_hub_info(Monitor *mon);
 void net_hub_check_clients(void);
 bool net_hub_flush(NetClientState *nc);
diff --git a/net/slirp.c b/net/slirp.c
index c4334ee876..77042e6df7 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -610,25 +610,13 @@ error:
     return -1;
 }
=20
-static SlirpState *slirp_lookup(Monitor *mon, const char *hub_id,
-                                const char *name)
+static SlirpState *slirp_lookup(Monitor *mon, const char *id)
 {
-    if (name) {
-        NetClientState *nc;
-        if (hub_id) {
-            nc =3D net_hub_find_client_by_name(strtol(hub_id, NULL, 0), na=
me);
-            if (!nc) {
-                monitor_printf(mon, "unrecognized (hub-id, stackname) pair=
\n");
-                return NULL;
-            }
-            warn_report("Using 'hub-id' is deprecated, specify the netdev =
id "
-                        "directly instead");
-        } else {
-            nc =3D qemu_find_netdev(name);
-            if (!nc) {
-                monitor_printf(mon, "unrecognized netdev id '%s'\n", name)=
;
-                return NULL;
-            }
+    if (id) {
+        NetClientState *nc =3D qemu_find_netdev(id);
+        if (!nc) {
+            monitor_printf(mon, "unrecognized netdev id '%s'\n", id);
+            return NULL;
         }
         if (strcmp(nc->model, "user")) {
             monitor_printf(mon, "invalid device specified\n");
@@ -655,16 +643,12 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qd=
ict)
     int err;
     const char *arg1 =3D qdict_get_str(qdict, "arg1");
     const char *arg2 =3D qdict_get_try_str(qdict, "arg2");
-    const char *arg3 =3D qdict_get_try_str(qdict, "arg3");
=20
-    if (arg3) {
-        s =3D slirp_lookup(mon, arg1, arg2);
-        src_str =3D arg3;
-    } else if (arg2) {
-        s =3D slirp_lookup(mon, NULL, arg1);
+    if (arg2) {
+        s =3D slirp_lookup(mon, arg1);
         src_str =3D arg2;
     } else {
-        s =3D slirp_lookup(mon, NULL, NULL);
+        s =3D slirp_lookup(mon, NULL);
         src_str =3D arg1;
     }
     if (!s) {
@@ -784,16 +768,12 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict=
)
     SlirpState *s;
     const char *arg1 =3D qdict_get_str(qdict, "arg1");
     const char *arg2 =3D qdict_get_try_str(qdict, "arg2");
-    const char *arg3 =3D qdict_get_try_str(qdict, "arg3");
=20
-    if (arg3) {
-        s =3D slirp_lookup(mon, arg1, arg2);
-        redir_str =3D arg3;
-    } else if (arg2) {
-        s =3D slirp_lookup(mon, NULL, arg1);
+    if (arg2) {
+        s =3D slirp_lookup(mon, arg1);
         redir_str =3D arg2;
     } else {
-        s =3D slirp_lookup(mon, NULL, NULL);
+        s =3D slirp_lookup(mon, NULL);
         redir_str =3D arg1;
     }
     if (s) {
--=20
2.24.1


