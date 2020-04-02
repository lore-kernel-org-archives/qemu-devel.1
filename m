Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917D5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603D82054F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNOs9HMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603D82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwhn-0002Qv-Gv
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jJwgw-0001Hw-OK
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1jJwgv-0000LZ-8f
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37406
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1jJwgv-0000LP-4y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585821796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvgfezloZrAjX420POU658d+F1XbXKjiVs06aMGcRJM=;
 b=VNOs9HMszEGPpJLOrKyQ2ZPGss5C816qDxg84vi7ylbLogqLR+04mlUfauIxYjLBpY1B+G
 RVnx8hMJ4I8Sw9X3H37Oyjn+pvfdvWknowh4deLDQxDyx4B/4wQvxM0QPAlkDB3p7ICL38
 IpP2o+Q6tsrozhX2Z0QVSKybtXt45UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-ooLDMRAuPS2XatEYKVdjIg-1; Thu, 02 Apr 2020 06:03:15 -0400
X-MC-Unique: ooLDMRAuPS2XatEYKVdjIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E1AB1084424;
 Thu,  2 Apr 2020 10:03:14 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-198.ams2.redhat.com
 [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 072755D9CD;
 Thu,  2 Apr 2020 10:03:08 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 1/5] qmp: add QMP command query-virtio
Date: Thu,  2 Apr 2020 12:02:58 +0200
Message-Id: <20200402100302.833267-2-lvivier@redhat.com>
In-Reply-To: <20200402100302.833267-1-lvivier@redhat.com>
References: <20200402100302.833267-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new command lists all the instances of VirtIODevice with
their path and virtio type

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/Makefile.objs    |  2 ++
 hw/virtio/virtio-stub.c    | 14 ++++++++++
 hw/virtio/virtio.c         | 27 +++++++++++++++++++
 include/hw/virtio/virtio.h |  1 +
 qapi/Makefile.objs         |  2 +-
 qapi/qapi-schema.json      |  1 +
 qapi/virtio.json           | 54 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/qmp-cmd-test.c |  1 +
 8 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 hw/virtio/virtio-stub.c
 create mode 100644 qapi/virtio.json

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 4e4d39a0a48f..0b649f120044 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -38,6 +38,8 @@ obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-serial-pci.o
 endif
 else
 common-obj-y +=3D vhost-stub.o
+common-obj-y +=3D virtio-stub.o
 endif
=20
 common-obj-$(CONFIG_ALL) +=3D vhost-stub.o
+common-obj-$(CONFIG_ALL) +=3D virtio-stub.o
diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
new file mode 100644
index 000000000000..d9e4a815ecf1
--- /dev/null
+++ b/hw/virtio/virtio-stub.c
@@ -0,0 +1,14 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-virtio.h"
+
+static void *qmp_virtio_unsupported(Error **errp)
+{
+    error_setg(errp, "Virtio is disabled");
+    return NULL;
+}
+
+VirtioInfoList *qmp_query_virtio(Error **errp)
+{
+    return qmp_virtio_unsupported(errp);
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b6c8ef5bc025..3cebc3d169c8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -13,6 +13,8 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-virtio.h"
+#include "qapi/qapi-visit-virtio.h"
 #include "cpu.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
@@ -28,6 +30,8 @@
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
=20
+static QTAILQ_HEAD(, VirtIODevice) virtio_list;
+
 /*
  * The alignment to use between consumer and producer parts of vring.
  * x86 pagesize again. This is the default, used by transports like PCI
@@ -3628,6 +3632,7 @@ static void virtio_device_realize(DeviceState *dev, E=
rror **errp)
=20
     vdev->listener.commit =3D virtio_memory_listener_commit;
     memory_listener_register(&vdev->listener, vdev->dma_as);
+    QTAILQ_INSERT_TAIL(&virtio_list, vdev, next);
 }
=20
 static void virtio_device_unrealize(DeviceState *dev, Error **errp)
@@ -3646,6 +3651,7 @@ static void virtio_device_unrealize(DeviceState *dev,=
 Error **errp)
         }
     }
=20
+    QTAILQ_REMOVE(&virtio_list, vdev, next);
     g_free(vdev->bus_name);
     vdev->bus_name =3D NULL;
 }
@@ -3802,6 +3808,8 @@ static void virtio_device_class_init(ObjectClass *kla=
ss, void *data)
     vdc->stop_ioeventfd =3D virtio_device_stop_ioeventfd_impl;
=20
     vdc->legacy_features |=3D VIRTIO_LEGACY_FEATURES;
+
+    QTAILQ_INIT(&virtio_list);
 }
=20
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
@@ -3812,6 +3820,25 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *v=
dev)
     return virtio_bus_ioeventfd_enabled(vbus);
 }
=20
+VirtioInfoList *qmp_query_virtio(Error **errp)
+{
+    VirtioInfoList *list =3D NULL;
+    VirtioInfoList *node;
+    VirtIODevice *vdev;
+
+    QTAILQ_FOREACH(vdev, &virtio_list, next) {
+        DeviceState *dev =3D DEVICE(vdev);
+        node =3D g_new0(VirtioInfoList, 1);
+        node->value =3D g_new(VirtioInfo, 1);
+        node->value->type =3D g_strdup(vdev->name);
+        node->value->path =3D g_strdup(dev->canonical_path);
+        node->next =3D list;
+        list =3D node;
+    }
+
+    return list;
+}
+
 static const TypeInfo virtio_device_info =3D {
     .name =3D TYPE_VIRTIO_DEVICE,
     .parent =3D TYPE_DEVICE,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b69d51749635..65adce680188 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -111,6 +111,7 @@ struct VirtIODevice
     bool use_guest_notifier_mask;
     AddressSpace *dma_as;
     QLIST_HEAD(, VirtQueue) *vector_queues;
+    QTAILQ_ENTRY(VirtIODevice) next;
 };
=20
 typedef struct VirtioDeviceClass {
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490df..4fae2e37cfc9 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -8,7 +8,7 @@ util-obj-y +=3D qapi-util.o
 QAPI_COMMON_MODULES =3D audio authz block-core block char common control c=
rypto
 QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
 QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state sockets=
 tpm
-QAPI_COMMON_MODULES +=3D trace transaction ui
+QAPI_COMMON_MODULES +=3D trace transaction ui virtio
 QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 43b0ba0dea22..189f5a0a7383 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -84,3 +84,4 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
+{ 'include': 'virtio.json' }
diff --git a/qapi/virtio.json b/qapi/virtio.json
new file mode 100644
index 000000000000..2a95d08a8b9e
--- /dev/null
+++ b/qapi/virtio.json
@@ -0,0 +1,54 @@
+##
+# =3D Virtio devices
+##
+
+##
+# @VirtioInfo:
+#
+# Information about a given VirtIODevice
+#
+# @type: VirtIO device type.
+#
+# @path: VirtIO device canonical path.
+#
+# Since: 5.1
+#
+##
+{ 'struct': 'VirtioInfo',
+  'data': {
+    'path': 'str',
+    'type': 'str'
+  }
+}
+
+##
+# @query-virtio:
+#
+# Return the list of all VirtIO devices
+#
+# Returns: list of @VirtioInfo
+#
+# Since: 5.1
+#
+# Example:
+#
+# -> { "execute": "query-virtio" }
+# <- { "return": [
+#        {
+#            "path": "/machine/peripheral-anon/device[3]/virtio-backend",
+#            "type": "virtio-net"
+#        },
+#        {
+#            "path": "/machine/peripheral-anon/device[1]/virtio-backend",
+#            "type": "virtio-serial"
+#        },
+#        {
+#            "path": "/machine/peripheral-anon/device[0]/virtio-backend",
+#            "type": "virtio-blk"
+#        }
+#      ]
+#    }
+#
+##
+
+{ 'command': 'query-virtio', 'returns': ['VirtioInfo'] }
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 9f5228cd9951..c0342c3a3075 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -92,6 +92,7 @@ static bool query_is_blacklisted(const char *cmd)
         "query-gic-capabilities", /* arm */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
+        "query-virtio",           /* CONFIG_VIRTIO */
         /* Success depends on launching SEV guest */
         "query-sev-launch-measure",
         /* Success depends on Host or Hypervisor SEV support */
--=20
2.25.1


