Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820ABC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED312080A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYBtQg8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED312080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHJe-0004bx-I5
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBy-0004B7-57
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXHBt-0003ke-E1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603775196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncY4NCXmT95SMTQF/f+jFlHPahOTtGHpjQn5yuHeqBc=;
 b=cYBtQg8pMPVLJLrlZKXA+1hpsAKDGOmUTVWbnp2Jiak9PuFnZFz2XpUtd40GshAxbpn3ZY
 +UMXtUFa6xEKoD+MsWtgOUB/q1uizpEyzA/Pa1JAJ5Akr0sBlbibbL/etNJwZfRWWHnqAg
 7gyHnoBadrW0sBvUq0F0KoIdPOdXWcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-HCpsqfczONKubSkswN28bA-1; Tue, 27 Oct 2020 01:06:33 -0400
X-MC-Unique: HCpsqfczONKubSkswN28bA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 880498049E0;
 Tue, 27 Oct 2020 05:06:30 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0119D10013C4;
 Tue, 27 Oct 2020 05:06:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 11/11] qapi: Use QAPI_LIST_ADD() where possible
Date: Tue, 27 Oct 2020 00:05:56 -0500
Message-Id: <20201027050556.269064-12-eblake@redhat.com>
In-Reply-To: <20201027050556.269064-1-eblake@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, pkrempa@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 rjones@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 armbru@redhat.com, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>,
 "open list:GLUSTER" <integration@gluster.org>, stefanha@redhat.com,
 Richard Henderson <rth@twiddle.net>, kwolf@redhat.com,
 vsementsov@virtuozzo.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anywhere we create a list of just one item or by prepending items
(typically because order doesn't matter), we can use the now-public
macro.  But places where we must keep the list in order by appending
remain open-coded.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 13 +++------
 hw/net/rocker/rocker_fp.h           |  2 +-
 block/gluster.c                     | 19 +++++--------
 chardev/char.c                      | 21 +++++++--------
 hw/core/machine.c                   |  6 +----
 hw/net/rocker/rocker.c              |  8 +++---
 hw/net/rocker/rocker_fp.c           | 14 +++++-----
 hw/net/virtio-net.c                 | 21 +++++----------
 migration/migration.c               |  7 ++---
 migration/postcopy-ram.c            |  7 ++---
 monitor/hmp-cmds.c                  | 11 ++++----
 qemu-img.c                          |  5 ++--
 qga/commands-posix.c                | 13 +++------
 qga/commands-win32.c                | 17 +++---------
 qga/commands.c                      |  6 +----
 qom/qom-qmp-cmds.c                  | 29 ++++++--------------
 target/arm/helper.c                 |  6 +----
 target/arm/monitor.c                | 13 ++-------
 target/i386/cpu.c                   |  6 +----
 target/mips/helper.c                |  6 +----
 target/s390x/cpu_models.c           | 12 ++-------
 tests/test-clone-visitor.c          |  7 ++---
 tests/test-qobject-output-visitor.c | 42 ++++++++++++++---------------
 tests/test-visitor-serialization.c  |  5 +---
 trace/qmp.c                         | 22 +++++++--------
 ui/vnc.c                            | 21 +++++----------
 util/qemu-config.c                  | 14 +++-------
 target/ppc/translate_init.c.inc     | 12 ++-------
 28 files changed, 119 insertions(+), 246 deletions(-)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
index 46a6c48683f5..3e11eeaa1893 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -531,15 +531,10 @@ TimerAlarmMethodList *qmp_query_alarm_methods(Error **errp)
     bool current = true;

     for (p = alarm_timers; p->name; p++) {
-        TimerAlarmMethodList *info = g_malloc0(sizeof(*info));
-        info->value = g_malloc0(sizeof(*info->value));
-        info->value->method_name = g_strdup(p->name);
-        info->value->current = current;
-
-        current = false;
-
-        info->next = method_list;
-        method_list = info;
+	TimerAlarmMethod *value = g_new0(TimerAlarmMethod, 1);
+        value->method_name = g_strdup(p->name);
+        value->current = current;
+        QAPI_LIST_ADD(method_list, value);
     }

     return method_list;
diff --git a/hw/net/rocker/rocker_fp.h b/hw/net/rocker/rocker_fp.h
index dbe1dd329a4b..4cb0bb9ccf81 100644
--- a/hw/net/rocker/rocker_fp.h
+++ b/hw/net/rocker/rocker_fp.h
@@ -28,7 +28,7 @@ int fp_port_eg(FpPort *port, const struct iovec *iov, int iovcnt);

 char *fp_port_get_name(FpPort *port);
 bool fp_port_get_link_up(FpPort *port);
-void fp_port_get_info(FpPort *port, RockerPortList *info);
+void fp_port_get_info(FpPort *port, RockerPort *info);
 void fp_port_get_macaddr(FpPort *port, MACAddr *macaddr);
 void fp_port_set_macaddr(FpPort *port, MACAddr *macaddr);
 uint8_t fp_port_get_learning(FpPort *port);
diff --git a/block/gluster.c b/block/gluster.c
index 4f1448e2bc88..cf446c23f85d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -359,8 +359,8 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
         return -EINVAL;
     }

-    gconf->server = g_new0(SocketAddressList, 1);
-    gconf->server->value = gsconf = g_new0(SocketAddress, 1);
+    gsconf = g_new0(SocketAddress, 1);
+    QAPI_LIST_ADD(gconf->server, gsconf);

     /* transport */
     if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
@@ -514,7 +514,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 {
     QemuOpts *opts;
     SocketAddress *gsconf = NULL;
-    SocketAddressList *curr = NULL;
+    SocketAddressList **curr;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
     char *str = NULL;
@@ -547,6 +547,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     }
     gconf->path = g_strdup(ptr);
     qemu_opts_del(opts);
+    curr = &gconf->server;

     for (i = 0; i < num_servers; i++) {
         str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
@@ -655,15 +656,9 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
             qemu_opts_del(opts);
         }

-        if (gconf->server == NULL) {
-            gconf->server = g_new0(SocketAddressList, 1);
-            gconf->server->value = gsconf;
-            curr = gconf->server;
-        } else {
-            curr->next = g_new0(SocketAddressList, 1);
-            curr->next->value = gsconf;
-            curr = curr->next;
-        }
+        *curr = g_new0(SocketAddressList, 1);
+        (*curr)->value = gsconf;
+        curr = &(*curr)->next;
         gsconf = NULL;

         qobject_unref(backing_options);
diff --git a/chardev/char.c b/chardev/char.c
index 78553125d311..8dd7ef4c5935 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -776,15 +776,14 @@ static int qmp_query_chardev_foreach(Object *obj, void *data)
 {
     Chardev *chr = CHARDEV(obj);
     ChardevInfoList **list = data;
-    ChardevInfoList *info = g_malloc0(sizeof(*info));
+    ChardevInfo *value;

-    info->value = g_malloc0(sizeof(*info->value));
-    info->value->label = g_strdup(chr->label);
-    info->value->filename = g_strdup(chr->filename);
-    info->value->frontend_open = chr->be && chr->be->fe_open;
+    value = g_malloc0(sizeof(*value));
+    value->label = g_strdup(chr->label);
+    value->filename = g_strdup(chr->filename);
+    value->frontend_open = chr->be && chr->be->fe_open;

-    info->next = *list;
-    *list = info;
+    QAPI_LIST_ADD(*list, value);

     return 0;
 }
@@ -803,12 +802,10 @@ static void
 qmp_prepend_backend(const char *name, void *opaque)
 {
     ChardevBackendInfoList **list = opaque;
-    ChardevBackendInfoList *info = g_malloc0(sizeof(*info));
+    ChardevBackendInfo *value = g_new0(ChardevBackendInfo, 1);

-    info->value = g_malloc0(sizeof(*info->value));
-    info->value->name = g_strdup(name);
-    info->next = *list;
-    *list = info;
+    value->name = g_strdup(name);
+    QAPI_LIST_ADD(*list, value);
 }

 ChardevBackendInfoList *qmp_query_chardev_backends(Error **errp)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5e0e79e6dbc..a05c4739ca7a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -492,11 +492,7 @@ static void machine_set_nvdimm_persistence(Object *obj, const char *value,

 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
 {
-    strList *item = g_new0(strList, 1);
-
-    item->value = g_strdup(type);
-    item->next = mc->allowed_dynamic_sysbus_devices;
-    mc->allowed_dynamic_sysbus_devices = item;
+    QAPI_LIST_ADD(mc->allowed_dynamic_sysbus_devices, g_strdup(type));
 }

 static void validate_sysbus_device(SysBusDevice *sbdev, void *opaque)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 1af1e6fa2f9b..a1137e11ff48 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -127,13 +127,11 @@ RockerPortList *qmp_query_rocker_ports(const char *name, Error **errp)
     }

     for (i = r->fp_ports - 1; i >= 0; i--) {
-        RockerPortList *info = g_malloc0(sizeof(*info));
-        info->value = g_malloc0(sizeof(*info->value));
+        RockerPort *value = g_malloc0(sizeof(*value));
         struct fp_port *port = r->fp_port[i];

-        fp_port_get_info(port, info);
-        info->next = list;
-        list = info;
+        fp_port_get_info(port, value);
+        QAPI_LIST_ADD(list, value);
     }

     return list;
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 4aa7da79b81d..a616e709292e 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -51,14 +51,14 @@ bool fp_port_get_link_up(FpPort *port)
     return !qemu_get_queue(port->nic)->link_down;
 }

-void fp_port_get_info(FpPort *port, RockerPortList *info)
+void fp_port_get_info(FpPort *port, RockerPort *value)
 {
-    info->value->name = g_strdup(port->name);
-    info->value->enabled = port->enabled;
-    info->value->link_up = fp_port_get_link_up(port);
-    info->value->speed = port->speed;
-    info->value->duplex = port->duplex;
-    info->value->autoneg = port->autoneg;
+    value->name = g_strdup(port->name);
+    value->enabled = port->enabled;
+    value->link_up = fp_port_get_link_up(port);
+    value->speed = port->speed;
+    value->duplex = port->duplex;
+    value->autoneg = port->autoneg;
 }

 void fp_port_get_macaddr(FpPort *port, MACAddr *macaddr)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 277289d56e76..6b13d3ca3c8f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -437,17 +437,14 @@ static void rxfilter_notify(NetClientState *nc)

 static intList *get_vlan_table(VirtIONet *n)
 {
-    intList *list, *entry;
+    intList *list;
     int i, j;

     list = NULL;
     for (i = 0; i < MAX_VLAN >> 5; i++) {
         for (j = 0; n->vlans[i] && j <= 0x1f; j++) {
             if (n->vlans[i] & (1U << j)) {
-                entry = g_malloc0(sizeof(*entry));
-                entry->value = (i << 5) + j;
-                entry->next = list;
-                list = entry;
+                QAPI_LIST_ADD(list, (i << 5) + j);
             }
         }
     }
@@ -460,7 +457,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)
     VirtIONet *n = qemu_get_nic_opaque(nc);
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     RxFilterInfo *info;
-    strList *str_list, *entry;
+    strList *str_list;
     int i;

     info = g_malloc0(sizeof(*info));
@@ -491,19 +488,15 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)

     str_list = NULL;
     for (i = 0; i < n->mac_table.first_multi; i++) {
-        entry = g_malloc0(sizeof(*entry));
-        entry->value = qemu_mac_strdup_printf(n->mac_table.macs + i * ETH_ALEN);
-        entry->next = str_list;
-        str_list = entry;
+        QAPI_LIST_ADD(str_list,
+                      qemu_mac_strdup_printf(n->mac_table.macs + i * ETH_ALEN));
     }
     info->unicast_table = str_list;

     str_list = NULL;
     for (i = n->mac_table.first_multi; i < n->mac_table.in_use; i++) {
-        entry = g_malloc0(sizeof(*entry));
-        entry->value = qemu_mac_strdup_printf(n->mac_table.macs + i * ETH_ALEN);
-        entry->next = str_list;
-        str_list = entry;
+        QAPI_LIST_ADD(str_list,
+                      qemu_mac_strdup_printf(n->mac_table.macs + i * ETH_ALEN));
     }
     info->multicast_table = str_list;
     info->vlan_table = get_vlan_table(n);
diff --git a/migration/migration.c b/migration/migration.c
index deb6005b8d37..239a7e430214 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -368,12 +368,9 @@ int migration_incoming_enable_colo(void)
 void migrate_add_address(SocketAddress *address)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    SocketAddressList *addrs;

-    addrs = g_new0(SocketAddressList, 1);
-    addrs->next = mis->socket_address_list;
-    mis->socket_address_list = addrs;
-    addrs->value = QAPI_CLONE(SocketAddress, address);
+    QAPI_LIST_ADD(mis->socket_address_list,
+                  QAPI_CLONE(SocketAddress, address));
 }

 void qemu_start_incoming_migration(const char *uri, Error **errp)
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0a2f88a87d06..18ac7e06c581 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -145,14 +145,11 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    uint32List *list = NULL, *entry = NULL;
+    uint32List *list = NULL;
     int i;

     for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        entry = g_new0(uint32List, 1);
-        entry->value = ctx->vcpu_blocktime[i];
-        entry->next = list;
-        list = entry;
+        QAPI_LIST_ADD(list, ctx->vcpu_blocktime[i]);
     }

     return list;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9789f4277f50..629c3d1bf741 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1248,7 +1248,8 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
     const char *cap = qdict_get_str(qdict, "capability");
     bool state = qdict_get_bool(qdict, "state");
     Error *err = NULL;
-    MigrationCapabilityStatusList *caps = g_malloc0(sizeof(*caps));
+    MigrationCapabilityStatusList *caps = NULL;
+    MigrationCapabilityStatus *value = NULL;
     int val;

     val = qapi_enum_parse(&MigrationCapability_lookup, cap, -1, &err);
@@ -1256,10 +1257,10 @@ void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
         goto end;
     }

-    caps->value = g_malloc0(sizeof(*caps->value));
-    caps->value->capability = val;
-    caps->value->state = state;
-    caps->next = NULL;
+    value = g_malloc0(sizeof(*value));
+    value->capability = val;
+    value->state = state;
+    QAPI_LIST_ADD(caps, value);
     qmp_migrate_set_capabilities(caps, &err);

 end:
diff --git a/qemu-img.c b/qemu-img.c
index 2103507936ea..4cfa8bccc5e7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1643,14 +1643,13 @@ static void do_dirty_bitmap_merge(const char *dst_node, const char *dst_name,
                                   Error **errp)
 {
     BlockDirtyBitmapMergeSource *merge_src;
-    BlockDirtyBitmapMergeSourceList *list;
+    BlockDirtyBitmapMergeSourceList *list = NULL;

     merge_src = g_new0(BlockDirtyBitmapMergeSource, 1);
     merge_src->type = QTYPE_QDICT;
     merge_src->u.external.node = g_strdup(src_node);
     merge_src->u.external.name = g_strdup(src_name);
-    list = g_new0(BlockDirtyBitmapMergeSourceList, 1);
-    list->value = merge_src;
+    QAPI_LIST_ADD(list, merge_src);
     qmp_block_dirty_bitmap_merge(dst_node, dst_name, list, errp);
     qapi_free_BlockDirtyBitmapMergeSourceList(list);
 }
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 3bffee99d4c9..06540425ded2 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1211,7 +1211,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
 {
     FsMountList mounts;
     struct FsMount *mount;
-    GuestFilesystemInfoList *new, *ret = NULL;
+    GuestFilesystemInfoList *ret = NULL;
     Error *local_err = NULL;

     QTAILQ_INIT(&mounts);
@@ -1224,10 +1224,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     QTAILQ_FOREACH(mount, &mounts, next) {
         g_debug("Building guest fsinfo for '%s'", mount->dirname);

-        new = g_malloc0(sizeof(*ret));
-        new->value = build_guest_fsinfo(mount, &local_err);
-        new->next = ret;
-        ret = new;
+        QAPI_LIST_ADD(ret, build_guest_fsinfo(mount, &local_err));
         if (local_err) {
             error_propagate(errp, local_err);
             qapi_free_GuestFilesystemInfoList(ret);
@@ -1493,7 +1490,6 @@ GuestFilesystemTrimResponse *
 qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 {
     GuestFilesystemTrimResponse *response;
-    GuestFilesystemTrimResultList *list;
     GuestFilesystemTrimResult *result;
     int ret = 0;
     FsMountList mounts;
@@ -1517,10 +1513,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
         result = g_malloc0(sizeof(*result));
         result->path = g_strdup(mount->dirname);

-        list = g_malloc0(sizeof(*list));
-        list->value = result;
-        list->next = response->paths;
-        response->paths = list;
+        QAPI_LIST_ADD(response->paths, result);

         fd = qemu_open_old(mount->dirname, O_RDONLY);
         if (fd == -1) {
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c3c05484f5f..cc5736c3bba8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -926,10 +926,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
                 error_free(local_err);
                 goto out;
             }
-            list = g_malloc0(sizeof(*list));
-            list->value = disk;
+            QAPI_LIST_ADD(list, disk);
             disk = NULL;
-            list->next = NULL;
             goto out;
         } else {
             error_setg_win32(errp, GetLastError(),
@@ -1064,7 +1062,7 @@ free:
 GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
 {
     HANDLE vol_h;
-    GuestFilesystemInfoList *new, *ret = NULL;
+    GuestFilesystemInfoList *ret = NULL;
     char guid[256];

     vol_h = FindFirstVolume(guid, sizeof(guid));
@@ -1082,10 +1080,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
             error_free(local_err);
             continue;
         }
-        new = g_malloc(sizeof(*ret));
-        new->value = info;
-        new->next = ret;
-        ret = new;
+        QAPI_LIST_ADD(ret, info);
     } while (FindNextVolume(vol_h, guid, sizeof(guid)));

     if (GetLastError() != ERROR_NO_MORE_FILES) {
@@ -1268,11 +1263,7 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)

         res->path = path;

-        list = g_new0(GuestFilesystemTrimResultList, 1);
-        list->value = res;
-        list->next = resp->paths;
-
-        resp->paths = list;
+        QAPI_LIST_ADD(resp->paths, res);

         memset(argv, 0, sizeof(argv));
         argv[0] = (gchar *)"defrag.exe";
diff --git a/qga/commands.c b/qga/commands.c
index 3dcd5fbe5c4d..27118df6caea 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -66,17 +66,13 @@ static void qmp_command_info(const QmpCommand *cmd, void *opaque)
 {
     GuestAgentInfo *info = opaque;
     GuestAgentCommandInfo *cmd_info;
-    GuestAgentCommandInfoList *cmd_info_list;

     cmd_info = g_new0(GuestAgentCommandInfo, 1);
     cmd_info->name = g_strdup(qmp_command_name(cmd));
     cmd_info->enabled = qmp_command_is_enabled(cmd);
     cmd_info->success_response = qmp_has_success_response(cmd);

-    cmd_info_list = g_new0(GuestAgentCommandInfoList, 1);
-    cmd_info_list->value = cmd_info;
-    cmd_info_list->next = info->supported_commands;
-    info->supported_commands = cmd_info_list;
+    QAPI_LIST_ADD(info->supported_commands, cmd_info);
 }

 struct GuestAgentInfo *qmp_guest_info(Error **errp)
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 310ab2d0481d..5ac9272ffeea 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -46,14 +46,12 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)

     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfoList *entry = g_malloc0(sizeof(*entry));
+        ObjectPropertyInfo *value = g_malloc0(sizeof(ObjectPropertyInfo));

-        entry->value = g_malloc0(sizeof(ObjectPropertyInfo));
-        entry->next = props;
-        props = entry;
+        QAPI_LIST_ADD(props, value);

-        entry->value->name = g_strdup(prop->name);
-        entry->value->type = g_strdup(prop->type);
+        value->name = g_strdup(prop->name);
+        value->type = g_strdup(prop->type);
     }

     return props;
@@ -90,7 +88,7 @@ QObject *qmp_qom_get(const char *path, const char *property, Error **errp)

 static void qom_list_types_tramp(ObjectClass *klass, void *data)
 {
-    ObjectTypeInfoList *e, **pret = data;
+    ObjectTypeInfoList **pret = data;
     ObjectTypeInfo *info;
     ObjectClass *parent = object_class_get_parent(klass);

@@ -102,10 +100,7 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
         info->parent = g_strdup(object_class_get_name(parent));
     }

-    e = g_malloc0(sizeof(*e));
-    e->value = info;
-    e->next = *pret;
-    *pret = e;
+    QAPI_LIST_ADD(*pret, info);
 }

 ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
@@ -155,7 +150,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
         ObjectPropertyInfo *info;
-        ObjectPropertyInfoList *entry;

         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
@@ -181,10 +175,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         info->default_value = qobject_ref(prop->defval);
         info->has_default_value = !!info->default_value;

-        entry = g_malloc0(sizeof(*entry));
-        entry->value = info;
-        entry->next = prop_list;
-        prop_list = entry;
+        QAPI_LIST_ADD(prop_list, info);
     }

     object_unref(obj);
@@ -222,7 +213,6 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
     }
     while ((prop = object_property_iter_next(&iter))) {
         ObjectPropertyInfo *info;
-        ObjectPropertyInfoList *entry;

         info = g_malloc0(sizeof(*info));
         info->name = g_strdup(prop->name);
@@ -230,10 +220,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         info->has_description = !!prop->description;
         info->description = g_strdup(prop->description);

-        entry = g_malloc0(sizeof(*entry));
-        entry->value = info;
-        entry->next = prop_list;
-        prop_list = entry;
+        QAPI_LIST_ADD(prop_list, info);
     }

     object_unref(obj);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 97bb6b8c01b4..df150f3c3eeb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8293,7 +8293,6 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     CpuDefinitionInfoList **cpu_list = user_data;
-    CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
     const char *typename;

@@ -8303,10 +8302,7 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
                            strlen(typename) - strlen("-" TYPE_ARM_CPU));
     info->q_typename = g_strdup(typename);

-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
-    entry->next = *cpu_list;
-    *cpu_list = entry;
+    QAPI_LIST_ADD(*cpu_list, info);
 }

 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 169d8a64b651..771101656535 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -42,15 +42,6 @@ static GICCapability *gic_cap_new(int version)
     return cap;
 }

-static GICCapabilityList *gic_cap_list_add(GICCapabilityList *head,
-                                           GICCapability *cap)
-{
-    GICCapabilityList *item = g_new0(GICCapabilityList, 1);
-    item->value = cap;
-    item->next = head;
-    return item;
-}
-
 static inline void gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 {
 #ifdef CONFIG_KVM
@@ -84,8 +75,8 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)

     gic_cap_kvm_probe(v2, v3);

-    head = gic_cap_list_add(head, v2);
-    head = gic_cap_list_add(head, v3);
+    QAPI_LIST_ADD(head, v2);
+    QAPI_LIST_ADD(head, v3);

     return head;
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d8606958e9e..9ae6661f97e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4984,7 +4984,6 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     ObjectClass *oc = data;
     X86CPUClass *cc = X86_CPU_CLASS(oc);
     CpuDefinitionInfoList **cpu_list = user_data;
-    CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;

     info = g_malloc0(sizeof(*info));
@@ -5009,10 +5008,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
         info->has_alias_of = !!info->alias_of;
     }

-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
-    entry->next = *cpu_list;
-    *cpu_list = entry;
+    QAPI_LIST_ADD(*cpu_list, info);
 }

 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1990be..036bacc24b22 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1502,7 +1502,6 @@ static void mips_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
     CpuDefinitionInfoList **cpu_list = user_data;
-    CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
     const char *typename;

@@ -1512,10 +1511,7 @@ static void mips_cpu_add_definition(gpointer data, gpointer user_data)
                            strlen(typename) - strlen("-" TYPE_MIPS_CPU));
     info->q_typename = g_strdup(typename);

-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
-    entry->next = *cpu_list;
-    *cpu_list = entry;
+    QAPI_LIST_ADD(*cpu_list, info);
 }

 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 461e0b8f4a8d..a837ac66c9c8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -427,7 +427,6 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
 {
     struct CpuDefinitionInfoListData *cpu_list_data = opaque;
     CpuDefinitionInfoList **cpu_list = &cpu_list_data->list;
-    CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
     char *name = g_strdup(object_class_get_name(klass));
     S390CPUClass *scc = S390_CPU_CLASS(klass);
@@ -454,10 +453,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
         object_unref(obj);
     }

-    entry = g_new0(CpuDefinitionInfoList, 1);
-    entry->value = info;
-    entry->next = *cpu_list;
-    *cpu_list = entry;
+    QAPI_LIST_ADD(*cpu_list, info);
 }

 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
@@ -624,12 +620,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 static void list_add_feat(const char *name, void *opaque)
 {
     strList **last = (strList **) opaque;
-    strList *entry;

-    entry = g_new0(strList, 1);
-    entry->value = g_strdup(name);
-    entry->next = *last;
-    *last = entry;
+    QAPI_LIST_ADD(*last, g_strdup(name));
 }

 CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index 5e1e8b2f5e8a..03788d355130 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -65,16 +65,13 @@ static void test_clone_alternate(void)

 static void test_clone_list_union(void)
 {
-    uint8List *src, *dst;
+    uint8List *src = NULL, *dst;
     uint8List *tmp = NULL;
     int i;

     /* Build list in reverse */
     for (i = 10; i; i--) {
-        src = g_new0(uint8List, 1);
-        src->next = tmp;
-        src->value = i;
-        tmp = src;
+        QAPI_LIST_ADD(src, i);
     }

     dst = QAPI_CLONE(uint8List, src);
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 1c856d9bd20a..95487b139801 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -223,7 +223,8 @@ static void test_visitor_out_list(TestOutputVisitorData *data,
                                   const void *unused)
 {
     const char *value_str = "list value";
-    TestStructList *p, *head = NULL;
+    TestStruct *value;
+    TestStructList *head = NULL;
     const int max_items = 10;
     bool value_bool = true;
     int value_int = 10;
@@ -233,14 +234,12 @@ static void test_visitor_out_list(TestOutputVisitorData *data,

     /* Build the list in reverse order... */
     for (i = 0; i < max_items; i++) {
-        p = g_malloc0(sizeof(*p));
-        p->value = g_malloc0(sizeof(*p->value));
-        p->value->integer = value_int + (max_items - i - 1);
-        p->value->boolean = value_bool;
-        p->value->string = g_strdup(value_str);
+        value = g_malloc0(sizeof(*value));
+        value->integer = value_int + (max_items - i - 1);
+        value->boolean = value_bool;
+        value->string = g_strdup(value_str);

-        p->next = head;
-        head = p;
+        QAPI_LIST_ADD(head, value);
     }

     visit_type_TestStructList(data->ov, NULL, &head, &error_abort);
@@ -270,26 +269,25 @@ static void test_visitor_out_list(TestOutputVisitorData *data,
 static void test_visitor_out_list_qapi_free(TestOutputVisitorData *data,
                                             const void *unused)
 {
-    UserDefTwoList *p, *head = NULL;
+    UserDefTwo *value;
+    UserDefTwoList *head = NULL;
     const char string[] = "foo bar";
     int i, max_count = 1024;

     for (i = 0; i < max_count; i++) {
-        p = g_malloc0(sizeof(*p));
-        p->value = g_malloc0(sizeof(*p->value));
+        value = g_malloc0(sizeof(*value));

-        p->value->string0 = g_strdup(string);
-        p->value->dict1 = g_new0(UserDefTwoDict, 1);
-        p->value->dict1->string1 = g_strdup(string);
-        p->value->dict1->dict2 = g_new0(UserDefTwoDictDict, 1);
-        p->value->dict1->dict2->userdef = g_new0(UserDefOne, 1);
-        p->value->dict1->dict2->userdef->string = g_strdup(string);
-        p->value->dict1->dict2->userdef->integer = 42;
-        p->value->dict1->dict2->string = g_strdup(string);
-        p->value->dict1->has_dict3 = false;
+        value->string0 = g_strdup(string);
+        value->dict1 = g_new0(UserDefTwoDict, 1);
+        value->dict1->string1 = g_strdup(string);
+        value->dict1->dict2 = g_new0(UserDefTwoDictDict, 1);
+        value->dict1->dict2->userdef = g_new0(UserDefOne, 1);
+        value->dict1->dict2->userdef->string = g_strdup(string);
+        value->dict1->dict2->userdef->integer = 42;
+        value->dict1->dict2->string = g_strdup(string);
+        value->dict1->has_dict3 = false;

-        p->next = head;
-        head = p;
+        QAPI_LIST_ADD(head, value);
     }

     qapi_free_UserDefTwoList(head);
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-serialization.c
index 1c5a8b94ea87..efbf744fcf25 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -704,10 +704,7 @@ static void test_nested_struct_list(gconstpointer opaque)
     int i = 0;

     for (i = 0; i < 8; i++) {
-        tmp = g_new0(UserDefTwoList, 1);
-        tmp->value = nested_struct_create();
-        tmp->next = listp;
-        listp = tmp;
+        QAPI_LIST_ADD(listp, nested_struct_create());
     }

     ops->serialize(listp, &serialize_data, visit_nested_struct_list,
diff --git a/trace/qmp.c b/trace/qmp.c
index 38246e1aa692..8755835edabc 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -92,39 +92,37 @@ TraceEventInfoList *qmp_trace_event_get_state(const char *name,
     /* Get states (all errors checked above) */
     trace_event_iter_init(&iter, name);
     while ((ev = trace_event_iter_next(&iter)) != NULL) {
-        TraceEventInfoList *elem;
+        TraceEventInfo *value;
         bool is_vcpu = trace_event_is_vcpu(ev);
         if (has_vcpu && !is_vcpu) {
             continue;
         }

-        elem = g_new(TraceEventInfoList, 1);
-        elem->value = g_new(TraceEventInfo, 1);
-        elem->value->vcpu = is_vcpu;
-        elem->value->name = g_strdup(trace_event_get_name(ev));
+        value = g_new(TraceEventInfo, 1);
+        value->vcpu = is_vcpu;
+        value->name = g_strdup(trace_event_get_name(ev));

         if (!trace_event_get_state_static(ev)) {
-            elem->value->state = TRACE_EVENT_STATE_UNAVAILABLE;
+            value->state = TRACE_EVENT_STATE_UNAVAILABLE;
         } else {
             if (has_vcpu) {
                 if (is_vcpu) {
                     if (trace_event_get_vcpu_state_dynamic(cpu, ev)) {
-                        elem->value->state = TRACE_EVENT_STATE_ENABLED;
+                        value->state = TRACE_EVENT_STATE_ENABLED;
                     } else {
-                        elem->value->state = TRACE_EVENT_STATE_DISABLED;
+                        value->state = TRACE_EVENT_STATE_DISABLED;
                     }
                 }
                 /* else: already skipped above */
             } else {
                 if (trace_event_get_state_dynamic(ev)) {
-                    elem->value->state = TRACE_EVENT_STATE_ENABLED;
+                    value->state = TRACE_EVENT_STATE_ENABLED;
                 } else {
-                    elem->value->state = TRACE_EVENT_STATE_DISABLED;
+                    value->state = TRACE_EVENT_STATE_DISABLED;
                 }
             }
         }
-        elem->next = events;
-        events = elem;
+        QAPI_LIST_ADD(events, value);
     }

     return events;
diff --git a/ui/vnc.c b/ui/vnc.c
index f006aa1afdb2..f39cfc952906 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -365,14 +365,11 @@ static VncDisplay *vnc_display_find(const char *id)

 static VncClientInfoList *qmp_query_client_list(VncDisplay *vd)
 {
-    VncClientInfoList *cinfo, *prev = NULL;
+    VncClientInfoList *prev = NULL;
     VncState *client;

     QTAILQ_FOREACH(client, &vd->clients, next) {
-        cinfo = g_new0(VncClientInfoList, 1);
-        cinfo->value = qmp_query_vnc_client(client);
-        cinfo->next = prev;
-        prev = cinfo;
+        QAPI_LIST_ADD(prev, qmp_query_vnc_client(client));
     }
     return prev;
 }
@@ -453,7 +450,6 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
                                                   int subauth,
                                                   VncServerInfo2List *prev)
 {
-    VncServerInfo2List *list;
     VncServerInfo2 *info;
     Error *err = NULL;
     SocketAddress *addr;
@@ -476,10 +472,8 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
     qmp_query_auth(auth, subauth, &info->auth,
                    &info->vencrypt, &info->has_vencrypt);

-    list = g_new0(VncServerInfo2List, 1);
-    list->value = info;
-    list->next = prev;
-    return list;
+    QAPI_LIST_ADD(prev, info);
+    return prev;
 }

 static void qmp_query_auth(int auth, int subauth,
@@ -554,7 +548,7 @@ static void qmp_query_auth(int auth, int subauth,

 VncInfo2List *qmp_query_vnc_servers(Error **errp)
 {
-    VncInfo2List *item, *prev = NULL;
+    VncInfo2List *prev = NULL;
     VncInfo2 *info;
     VncDisplay *vd;
     DeviceState *dev;
@@ -583,10 +577,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
                 vd->ws_subauth, info->server);
         }

-        item = g_new0(VncInfo2List, 1);
-        item->value = info;
-        item->next = prev;
-        prev = item;
+        QAPI_LIST_ADD(prev, info);
     }
     return prev;
 }
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 660f47b0050f..495ada45f3df 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -55,7 +55,7 @@ QemuOpts *qemu_find_opts_singleton(const char *group)

 static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
 {
-    CommandLineParameterInfoList *param_list = NULL, *entry;
+    CommandLineParameterInfoList *param_list = NULL;
     CommandLineParameterInfo *info;
     int i;

@@ -87,10 +87,7 @@ static CommandLineParameterInfoList *query_option_descs(const QemuOptDesc *desc)
             info->q_default = g_strdup(desc[i].def_value_str);
         }

-        entry = g_malloc0(sizeof(*entry));
-        entry->value = info;
-        entry->next = param_list;
-        param_list = entry;
+        QAPI_LIST_ADD(param_list, info);
     }

     return param_list;
@@ -246,7 +243,7 @@ CommandLineOptionInfoList *qmp_query_command_line_options(bool has_option,
                                                           const char *option,
                                                           Error **errp)
 {
-    CommandLineOptionInfoList *conf_list = NULL, *entry;
+    CommandLineOptionInfoList *conf_list = NULL;
     CommandLineOptionInfo *info;
     int i;

@@ -262,10 +259,7 @@ CommandLineOptionInfoList *qmp_query_command_line_options(bool has_option,
                 info->parameters =
                     query_option_descs(vm_config_groups[i]->desc);
             }
-            entry = g_malloc0(sizeof(*entry));
-            entry->value = info;
-            entry->next = conf_list;
-            conf_list = entry;
+            QAPI_LIST_ADD(conf_list, info);
         }
     }

diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index bb66526280ef..5795d0e5af2c 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10621,7 +10621,6 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     ObjectClass *oc = data;
     CpuDefinitionInfoList **first = user_data;
     const char *typename;
-    CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;

     typename = object_class_get_name(oc);
@@ -10629,10 +10628,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     info->name = g_strndup(typename,
                            strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFFIX));

-    entry = g_malloc0(sizeof(*entry));
-    entry->value = info;
-    entry->next = *first;
-    *first = entry;
+    QAPI_LIST_ADD(*first, info);
 }

 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
@@ -10648,7 +10644,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
         ObjectClass *oc;
-        CpuDefinitionInfoList *entry;
         CpuDefinitionInfo *info;

         oc = ppc_cpu_class_by_name(alias->model);
@@ -10660,10 +10655,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
         info->name = g_strdup(alias->alias);
         info->q_typename = g_strdup(object_class_get_name(oc));

-        entry = g_malloc0(sizeof(*entry));
-        entry->value = info;
-        entry->next = cpu_list;
-        cpu_list = entry;
+        QAPI_LIST_ADD(cpu_list, info);
     }

     return cpu_list;
-- 
2.29.0


