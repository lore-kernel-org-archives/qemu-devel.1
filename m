Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B4CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0E0205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfDAtoS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0E0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCNA-0000Np-B7
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNC0t-0003cM-Rk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNC0r-00073L-EZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:29:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNC0p-00070e-Ak
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsKKx048Mm8iT+6HGuXTCVbp9cbMwhDB3tKh4z/w+RQ=;
 b=bfDAtoS5enLLOkbewOsnTsEwmi0Efqy6kF5vMyMoTXvKbL7nCGevpoHn/0PDfy0pmPNtNN
 WSpsXXvuVxHgTVucxOPd2Fa/mRNO53IF109RRsDnB2WEsZU/DX8SQtncLrWvb80Y5BfC8y
 NwgdZiAdx6DyPhTYa1/DuBxmDCdG7Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-juPC8h5rNNKT6pbnI_T-mA-1; Wed, 23 Oct 2019 04:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185C1800D49;
 Wed, 23 Oct 2019 08:28:52 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26DBE6CE5F;
 Wed, 23 Oct 2019 08:28:44 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/11] net/virtio: add failover support
Date: Wed, 23 Oct 2019 10:27:10 +0200
Message-Id: <20191023082711.16694-11-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-1-jfreimann@redhat.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: juPC8h5rNNKT6pbnI_T-mA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds support to handle failover device pairs of a virtio-net
device and a vfio-pci device, where the virtio-net acts as the standby
device and the vfio-pci device as the primary.

The general idea is that we have a pair of devices, a vfio-pci and a
emulated (virtio-net) device. Before migration the vfio device is
unplugged and data flows to the emulated device, on the target side
another vfio-pci device is plugged in to take over the data-path. In the
guest the net_failover module will pair net devices with the same MAC
address.

To achieve this we need:

1. Provide a callback function for the should_be_hidden DeviceListener.
   It is called when the primary device is plugged in. Evaluate the QOpt
   passed in to check if it is the matching primary device. It returns
   two values:
     - one to signal if the device to be added is the matching
       primary device
     - another one to signal to qdev if it should actually
       continue with adding the device or skip it.

   In the latter case it stores the device options in the VirtioNet
   struct and the device is added once the VIRTIO_NET_F_STANDBY feature is
   negotiated during virtio feature negotiation.

   If the virtio-net devices are not realized at the time the vfio-pci
   devices are realized, we need to connect the devices later. This way
   we make sure primary and standby devices can be specified in any
   order.

2. Register a callback for migration status notifier. When called it
   will unplug its primary device before the migration happens.

3. Register a callback for the migration code that checks if a device
   needs to be unplugged from the guest.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/net/virtio-net.c            | 302 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  12 ++
 include/hw/virtio/virtio.h     |   1 +
 3 files changed, 315 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f11422337..cccaf77bde 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -21,6 +22,10 @@
 #include "net/tap.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qemu/option.h"
+#include "qemu/option_int.h"
+#include "qemu/config-file.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "net/announce.h"
@@ -28,11 +33,15 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-net.h"
 #include "hw/qdev-properties.h"
+#include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "monitor/qdev.h"
+#include "hw/pci/pci.h"
=20
 #define VIRTIO_NET_VM_VERSION    11
=20
@@ -746,9 +755,99 @@ static inline uint64_t virtio_net_supported_guest_offl=
oads(VirtIONet *n)
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
 }
=20
+static void failover_add_primary(VirtIONet *n, Error **errp)
+{
+    Error *err =3D NULL;
+
+    n->primary_device_opts =3D qemu_opts_find(qemu_find_opts("device"),
+            n->primary_device_id);
+    if (n->primary_device_opts) {
+        n->primary_dev =3D qdev_device_add(n->primary_device_opts, &err);
+        if (err) {
+            qemu_opts_del(n->primary_device_opts);
+        }
+        if (n->primary_dev) {
+            n->primary_bus =3D n->primary_dev->parent_bus;
+            if (err) {
+                qdev_unplug(n->primary_dev, &err);
+                qdev_set_id(n->primary_dev, "");
+
+            }
+        }
+    } else {
+        error_setg(errp, "Primary device not found");
+        error_append_hint(errp, "Virtio-net failover will not work. Make "
+            "sure primary device has parameter"
+            " net_failover_pair_id=3D<virtio-net-id>\n");
+}
+    if (err) {
+        error_propagate(errp, err);
+    }
+}
+
+static int is_my_primary(void *opaque, QemuOpts *opts, Error **errp)
+{
+    VirtIONet *n =3D opaque;
+    int ret =3D 0;
+
+    const char *standby_id =3D qemu_opt_get(opts, "net_failover_pair_id");
+
+    if (standby_id !=3D NULL && (g_strcmp0(standby_id, n->netclient_name) =
=3D=3D 0)) {
+        n->primary_device_id =3D g_strdup(opts->id);
+        ret =3D 1;
+    }
+
+    return ret;
+}
+
+static DeviceState *virtio_net_find_primary(VirtIONet *n, Error **errp)
+{
+    DeviceState *dev =3D NULL;
+    Error *err =3D NULL;
+
+    if (qemu_opts_foreach(qemu_find_opts("device"),
+                         is_my_primary, n, &err)) {
+        if (err) {
+            error_propagate(errp, err);
+            return NULL;
+        }
+        if (n->primary_device_id) {
+            dev =3D qdev_find_recursive(sysbus_get_default(),
+                    n->primary_device_id);
+        } else {
+            error_setg(errp, "Primary device id not found");
+            return NULL;
+        }
+    }
+    return dev;
+}
+
+
+
+static DeviceState *virtio_connect_failover_devices(VirtIONet *n,
+                                                    DeviceState *dev,
+                                                    Error **errp)
+{
+    DeviceState *prim_dev =3D NULL;
+    Error *err =3D NULL;
+
+    prim_dev =3D virtio_net_find_primary(n, &err);
+    if (prim_dev) {
+        n->primary_device_id =3D g_strdup(prim_dev->id);
+        n->primary_device_opts =3D prim_dev->opts;
+    } else {
+        if (err) {
+            error_propagate(errp, err);
+        }
+    }
+
+    return prim_dev;
+}
+
 static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n =3D VIRTIO_NET(vdev);
+    Error *err =3D NULL;
     int i;
=20
     if (n->mtu_bypass_backend &&
@@ -790,6 +889,27 @@ static void virtio_net_set_features(VirtIODevice *vdev=
, uint64_t features)
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
+
+    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+        atomic_set(&n->primary_should_be_hidden, false);
+        failover_add_primary(n, &err);
+        if (err) {
+            n->primary_dev =3D virtio_connect_failover_devices(n, n->qdev,=
 &err);
+            if (err) {
+                goto out_err;
+            }
+            failover_add_primary(n, &err);
+            if (err) {
+                goto out_err;
+            }
+        }
+    }
+    return;
+
+out_err:
+    if (err) {
+        warn_report_err(err);
+    }
 }
=20
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -2630,6 +2750,151 @@ void virtio_net_set_netclient_name(VirtIONet *n, co=
nst char *name,
     n->netclient_type =3D g_strdup(type);
 }
=20
+static bool failover_unplug_primary(VirtIONet *n)
+{
+    HotplugHandler *hotplug_ctrl;
+    PCIDevice *pci_dev;
+    Error *err =3D NULL;
+
+    hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
+    if (hotplug_ctrl) {
+        pci_dev =3D PCI_DEVICE(n->primary_dev);
+        pci_dev->partially_hotplugged =3D true;
+        hotplug_handler_unplug_request(hotplug_ctrl, n->primary_dev, &err)=
;
+        if (err) {
+            error_report_err(err);
+            return false;
+        }
+    } else {
+        return false;
+    }
+    return true;
+}
+
+static bool failover_replug_primary(VirtIONet *n, Error **errp)
+{
+    HotplugHandler *hotplug_ctrl;
+    PCIDevice *pdev =3D PCI_DEVICE(n->primary_dev);
+
+    if (!pdev->partially_hotplugged) {
+        return true;
+    }
+    if (!n->primary_device_opts) {
+        n->primary_device_opts =3D qemu_opts_from_qdict(
+                qemu_find_opts("device"),
+                n->primary_device_dict, errp);
+    }
+    if (n->primary_device_opts) {
+        if (n->primary_dev) {
+            n->primary_bus =3D n->primary_dev->parent_bus;
+        }
+        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
+        n->primary_should_be_hidden =3D false;
+        qemu_opt_set_bool(n->primary_device_opts,
+                "partially_hotplugged", true, errp);
+        hotplug_ctrl =3D qdev_get_hotplug_handler(n->primary_dev);
+        if (hotplug_ctrl) {
+            hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
+            hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
+        }
+        if (!n->primary_dev) {
+            error_setg(errp, "virtio_net: couldn't find primary device");
+        }
+    }
+    return *errp !=3D NULL;
+}
+
+static void virtio_net_handle_migration_primary(VirtIONet *n,
+                                                MigrationState *s)
+{
+    bool should_be_hidden;
+    Error *err =3D NULL;
+
+    should_be_hidden =3D atomic_read(&n->primary_should_be_hidden);
+
+    if (!n->primary_dev) {
+        n->primary_dev =3D virtio_connect_failover_devices(n, n->qdev, &er=
r);
+        if (!n->primary_dev) {
+            return;
+        }
+    }
+
+    if (migration_in_setup(s) && !should_be_hidden &&
+        n->primary_dev) {
+        if (failover_unplug_primary(n)) {
+            vmstate_unregister(n->primary_dev, qdev_get_vmsd(n->primary_de=
v),
+                    n->primary_dev);
+            qapi_event_send_unplug_primary(n->primary_device_id);
+            atomic_set(&n->primary_should_be_hidden, true);
+        } else {
+            warn_report("couldn't unplug primary device");
+        }
+    } else if (migration_has_failed(s)) {
+        /* We already unplugged the device let's plugged it back */
+        if (!failover_replug_primary(n, &err)) {
+            if (err) {
+                error_report_err(err);
+            }
+        }
+    }
+}
+
+static void virtio_net_migration_state_notifier(Notifier *notifier, void *=
data)
+{
+    MigrationState *s =3D data;
+    VirtIONet *n =3D container_of(notifier, VirtIONet, migration_state);
+    virtio_net_handle_migration_primary(n, s);
+}
+
+static int virtio_net_primary_should_be_hidden(DeviceListener *listener,
+            QemuOpts *device_opts)
+{
+    VirtIONet *n =3D container_of(listener, VirtIONet, primary_listener);
+    bool match_found;
+    bool hide;
+
+    n->primary_device_dict =3D qemu_opts_to_qdict(device_opts,
+            n->primary_device_dict);
+    if (n->primary_device_dict) {
+        g_free(n->standby_id);
+        n->standby_id =3D g_strdup(qdict_get_try_str(n->primary_device_dic=
t,
+                    "net_failover_pair_id"));
+    }
+    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) =3D=3D =
0) {
+        match_found =3D true;
+    } else {
+        match_found =3D false;
+        hide =3D false;
+        g_free(n->standby_id);
+        n->primary_device_dict =3D NULL;
+        warn_report("primary_device_id not found in device options");
+        goto out;
+    }
+
+    n->primary_device_opts =3D device_opts;
+
+    /* primary_should_be_hidden is set during feature negotiation */
+    hide =3D atomic_read(&n->primary_should_be_hidden);
+
+    if (n->primary_device_dict) {
+        g_free(n->primary_device_id);
+        n->primary_device_id =3D g_strdup(qdict_get_try_str(
+                    n->primary_device_dict, "id"));
+        if (!n->primary_device_id) {
+            warn_report("primary_device_id not set");
+        }
+    }
+
+out:
+    if (match_found && hide) {
+        return 1;
+    } else if (match_found && !hide) {
+        return 0;
+    } else {
+        return -1;
+    }
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -2660,6 +2925,16 @@ static void virtio_net_device_realize(DeviceState *d=
ev, Error **errp)
         n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }
=20
+    if (n->failover) {
+        n->primary_listener.should_be_hidden =3D
+            virtio_net_primary_should_be_hidden;
+        atomic_set(&n->primary_should_be_hidden, true);
+        device_listener_register(&n->primary_listener);
+        n->migration_state.notify =3D virtio_net_migration_state_notifier;
+        add_migration_state_change_notifier(&n->migration_state);
+        n->host_features |=3D (1ULL << VIRTIO_NET_F_STANDBY);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
=20
@@ -2782,6 +3057,13 @@ static void virtio_net_device_unrealize(DeviceState =
*dev, Error **errp)
     g_free(n->mac_table.macs);
     g_free(n->vlans);
=20
+    if (n->failover) {
+        g_free(n->primary_device_id);
+        g_free(n->standby_id);
+        qobject_unref(n->primary_device_dict);
+        n->primary_device_dict =3D NULL;
+    }
+
     max_queues =3D n->multiqueue ? n->max_queues : 1;
     for (i =3D 0; i < max_queues; i++) {
         virtio_net_del_queue(n, i);
@@ -2819,6 +3101,23 @@ static int virtio_net_pre_save(void *opaque)
     return 0;
 }
=20
+static bool primary_unplug_pending(void *opaque)
+{
+    DeviceState *dev =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIONet *n =3D VIRTIO_NET(vdev);
+
+    return n->primary_dev ? n->primary_dev->pending_deleted_event : false;
+}
+
+static bool dev_unplug_pending(void *opaque)
+{
+    DeviceState *dev =3D opaque;
+    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(dev);
+
+    return vdc->primary_unplug_pending(dev);
+}
+
 static const VMStateDescription vmstate_virtio_net =3D {
     .name =3D "virtio-net",
     .minimum_version_id =3D VIRTIO_NET_VM_VERSION,
@@ -2828,6 +3127,7 @@ static const VMStateDescription vmstate_virtio_net =
=3D {
         VMSTATE_END_OF_LIST()
     },
     .pre_save =3D virtio_net_pre_save,
+    .dev_unplug_pending =3D dev_unplug_pending,
 };
=20
 static Property virtio_net_properties[] =3D {
@@ -2889,6 +3189,7 @@ static Property virtio_net_properties[] =3D {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -2913,6 +3214,7 @@ static void virtio_net_class_init(ObjectClass *klass,=
 void *data)
     vdc->guest_notifier_pending =3D virtio_net_guest_notifier_pending;
     vdc->legacy_features |=3D (0x1 << VIRTIO_NET_F_GSO);
     vdc->vmsd =3D &vmstate_virtio_net_device;
+    vdc->primary_unplug_pending =3D primary_unplug_pending;
 }
=20
 static const TypeInfo virtio_net_info =3D {
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.=
h
index b96f0c643f..3da4ca382a 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -18,6 +18,7 @@
 #include "standard-headers/linux/virtio_net.h"
 #include "hw/virtio/virtio.h"
 #include "net/announce.h"
+#include "qemu/option_int.h"
=20
 #define TYPE_VIRTIO_NET "virtio-net-device"
 #define VIRTIO_NET(obj) \
@@ -43,6 +44,7 @@ typedef struct virtio_net_conf
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
+    char *primary_id_str;
 } virtio_net_conf;
=20
 /* Coalesced packets type & status */
@@ -185,6 +187,16 @@ struct VirtIONet {
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    QemuOpts *primary_device_opts;
+    QDict *primary_device_dict;
+    DeviceState *primary_dev;
+    BusState *primary_bus;
+    char *primary_device_id;
+    char *standby_id;
+    bool primary_should_be_hidden;
+    bool failover;
+    DeviceListener primary_listener;
+    Notifier migration_state;
 };
=20
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..0c857ecf1a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -159,6 +159,7 @@ typedef struct VirtioDeviceClass {
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
     const VMStateDescription *vmsd;
+    bool (*primary_unplug_pending)(void *opaque);
 } VirtioDeviceClass;
=20
 void virtio_instance_init_common(Object *proxy_obj, void *data,
--=20
2.21.0


