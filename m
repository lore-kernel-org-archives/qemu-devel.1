Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794EFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEC72074D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xau213ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEC72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwkW-0006Bl-8T
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1jJwh8-0001ZC-LF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1jJwh6-0000WG-Fh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1jJwh6-0000WA-Ak
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585821808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyR+Fb8NPCcaSj6z5odo744T7i6AULnc2fVc7wIjzUs=;
 b=Xau213ac/R17bDv8QAsBLguvGE7rbEcAL3YgWg8Tq3HbMTuqZtHgBs3cSuOwQIBt+3Yft+
 v2tqlSQGBG4Ayz7ftJWK9niBVVVZNLiDTjfW20LCLhSdR2j2/lhWUdmIwahAV1OShym9cR
 0EbGCrBiE6N7ejcf+vuONK5CYD7w8R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-RBxLpcNbMdOB2ITkCTsQ7g-1; Thu, 02 Apr 2020 06:03:26 -0400
X-MC-Unique: RBxLpcNbMdOB2ITkCTsQ7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2345B800D5C;
 Thu,  2 Apr 2020 10:03:25 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-198.ams2.redhat.com
 [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3F05DA76;
 Thu,  2 Apr 2020 10:03:22 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 5/5] hmp: add virtio commands
Date: Thu,  2 Apr 2020 12:03:02 +0200
Message-Id: <20200402100302.833267-6-lvivier@redhat.com>
In-Reply-To: <20200402100302.833267-1-lvivier@redhat.com>
References: <20200402100302.833267-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements HMP version of the virtio QMP commands

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 Makefile                |   2 +-
 Makefile.target         |   7 +-
 docs/system/monitor.rst |   2 +
 hmp-commands-virtio.hx  | 148 ++++++++++++++++++++++++++++++++++++++++
 hmp-commands.hx         |  10 +++
 hw/virtio/virtio.c      | 115 +++++++++++++++++++++++++++++++
 include/monitor/hmp.h   |   4 ++
 monitor/misc.c          |  17 +++++
 8 files changed, 302 insertions(+), 3 deletions(-)
 create mode 100644 hmp-commands-virtio.hx

diff --git a/Makefile b/Makefile
index 84ef88160006..5f70ea16a566 100644
--- a/Makefile
+++ b/Makefile
@@ -1100,7 +1100,7 @@ $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-=
deps,interop)
 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
 =09$(call build-manual,specs,html)
=20
-$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system) $(SRC_PAT=
H)/hmp-commands.hx $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/qemu-option=
s.hx
+$(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system) $(SRC_PAT=
H)/hmp-commands.hx $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/qemu-option=
s.hx $(SRC_PATH)/hmp-commands-virtio.hx
 =09$(call build-manual,system,html)
=20
 $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PATH)=
/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
diff --git a/Makefile.target b/Makefile.target
index 8ed1eba95b9c..66d3ff9bc350 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -171,7 +171,7 @@ else
 obj-y +=3D hw/$(TARGET_BASE_ARCH)/
 endif
=20
-generated-files-y +=3D hmp-commands.h hmp-commands-info.h
+generated-files-y +=3D hmp-commands.h hmp-commands-info.h hmp-commands-vir=
tio.h
 generated-files-y +=3D config-devices.h
=20
 endif # CONFIG_SOFTMMU
@@ -220,10 +220,13 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PAT=
H)/scripts/hxtool
 hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/=
hxtool
 =09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","=
$(TARGET_DIR)$@")
=20
+hmp-commands-virtio.h: $(SRC_PATH)/hmp-commands-virtio.hx $(SRC_PATH)/scri=
pts/hxtool
+=09$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","=
$(TARGET_DIR)$@")
+
 clean: clean-target
 =09rm -f *.a *~ $(PROGS)
 =09rm -f $(shell find . -name '*.[od]')
-=09rm -f hmp-commands.h gdbstub-xml.c
+=09rm -f hmp-commands.h hmp-commands-virtio.h gdbstub-xml.c
 =09rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
 ifdef CONFIG_TRACE_SYSTEMTAP
 =09rm -f *.stp
diff --git a/docs/system/monitor.rst b/docs/system/monitor.rst
index 0bcd5da21644..985c3f51ffe7 100644
--- a/docs/system/monitor.rst
+++ b/docs/system/monitor.rst
@@ -21,6 +21,8 @@ The following commands are available:
=20
 .. hxtool-doc:: hmp-commands.hx
=20
+.. hxtool-doc:: hmp-commands-virtio.hx
+
 .. hxtool-doc:: hmp-commands-info.hx
=20
 Integer expressions
diff --git a/hmp-commands-virtio.hx b/hmp-commands-virtio.hx
new file mode 100644
index 000000000000..a8d49f0b2b46
--- /dev/null
+++ b/hmp-commands-virtio.hx
@@ -0,0 +1,148 @@
+HXCOMM Use DEFHEADING() to define headings in both help text and rST.
+HXCOMM Text between SRST and ERST is copied to the rST version and
+HXCOMM discarded from C version.
+HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
+HXCOMM monitor info commands
+HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
+HXCOMM
+HXCOMM In this file, generally SRST fragments should have two extra
+HXCOMM spaces of indent, so that the documentation list item for "virtio c=
md"
+HXCOMM appears inside the documentation list item for the top level
+HXCOMM "virtio" documentation entry. The exception is the first SRST
+HXCOMM fragment that defines that top level entry.
+
+SRST
+``virtio`` *subcommand*
+  Show various information about virtio.
+
+ERST
+
+    {
+        .name       =3D "query",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "List all available virtio devices",
+        .cmd        =3D hmp_virtio_query,
+        .flags      =3D "p",
+    },
+
+SRST
+  ``virtio query``
+    List all available virtio devices
+
+    Example:
+
+    List all available virtio devices in the machine::
+
+      (qemu) virtio query
+      /machine/peripheral-anon/device[3]/virtio-backend [virtio-net]
+      /machine/peripheral-anon/device[1]/virtio-backend [virtio-serial]
+      /machine/peripheral-anon/device[0]/virtio-backend [virtio-blk]
+
+ERST
+
+    {
+        .name       =3D "status",
+        .args_type  =3D "path:s",
+        .params     =3D "path",
+        .help       =3D "Display status of a given virtio device",
+        .cmd        =3D hmp_virtio_status,
+        .flags      =3D "p",
+    },
+
+SRST
+  ``virtio status`` *path*
+    Display status of a given virtio device
+
+    Example:
+
+    Dump the status of the first virtio device::
+
+      (qemu) virtio status /machine/peripheral-anon/device[3]/virtio-backe=
nd
+      /machine/peripheral-anon/device[3]/virtio-backend:
+        Device Id:        1
+        Guest features:   0x0000000130afffa7
+        Host features:    0x0000000179bfffe7
+        Backend features: 0x0000000000000000
+        Endianness:       little
+        VirtQueues:       3
+
+ERST
+
+    {
+        .name       =3D "queue-status",
+        .args_type  =3D "path:s,queue:i",
+        .params     =3D "path queue",
+        .help       =3D "Display status of a given virtio queue",
+        .cmd        =3D hmp_virtio_queue_status,
+        .flags      =3D "p",
+    },
+
+SRST
+  ``virtio queue-status`` *path* *queue*
+    Display status of a given virtio queue
+
+    Example:
+
+    Dump the status of the first queue of the first virtio device::
+
+      (qemu) virtio queue-status /machine/peripheral-anon/device[3]/virtio=
-backend 0
+      /machine/peripheral-anon/device[3]/virtio-backend:
+        index:                0
+        inuse:                0
+        last_avail_idx:       61
+        shadow_avail_idx:     292
+        signalled_used:       61
+        signalled_used_valid: 1
+        VRing:
+          num:         256
+          num_default: 256
+          align:       4096
+          desc:        0x000000006c352000
+          avail:       0x000000006c353000
+          used:        0x000000006c353240
+
+ERST
+
+    {
+        .name       =3D "queue-element",
+        .args_type  =3D "path:s,queue:i,index:i?",
+        .params     =3D "path queue [index]",
+        .help       =3D "Display element of a given virtio queue",
+        .cmd        =3D hmp_virtio_queue_element,
+        .flags      =3D "p",
+    },
+
+SRST
+  ``virtio queue-element`` *path* *queue* [*index*]
+    Display element of a given virtio queue
+
+    Example:
+
+    Dump the information of the head element of the first queue of
+    the first virtio device::
+
+      (qemu) virtio queue-element/machine/peripheral-anon/device[3]/virtio=
-backend 0
+      index:  67
+      ndescs: 1
+      descs:  addr 0x6fe69800 len 1536 (write-only)
+
+      (qemu) xp/128bx 0x6fe69800
+      000000006fe69800: 0x02 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+      000000006fe69808: 0x00 0x00 0x01 0x00 0x52 0x54 0x00 0x12
+      000000006fe69810: 0x34 0x56 0x52 0x54 0x00 0x09 0x51 0xde
+      000000006fe69818: 0x08 0x00 0x45 0x00 0x00 0x4c 0x8f 0x32
+
+    device[3] is a virtio-net device and we can see in the element buffer =
the
+    MAC address of the card::
+
+      [root@localhost ~]# ip link show ens4
+      2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel s=
tate UP m0
+          link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
+
+    and the MAC address of the gateway::
+
+      [root@localhost ~]# arp -a
+      _gateway (192.168.122.1) at 52:54:00:09:51:de [ether] on ens4
+
+ERST
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7f0f3974ad90..14568b406dbc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1804,6 +1804,16 @@ SRST
   Set QOM property *property* of object at location *path* to value *value=
*
 ERST
=20
+    {
+        .name       =3D "virtio",
+        .args_type  =3D "name:S?",
+        .params     =3D "[cmd]",
+        .help       =3D "show various information about virtio",
+        .cmd        =3D hmp_virtio_help,
+        .sub_table  =3D hmp_virtio_cmds,
+        .flags      =3D "p",
+    },
+
     {
         .name       =3D "info",
         .args_type  =3D "item:s?",
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 28848b9e64cf..d52d41169fb4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -29,6 +29,9 @@
 #include "hw/virtio/virtio-access.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/qmp/qdict.h"
=20
 static QTAILQ_HEAD(, VirtIODevice) virtio_list;
=20
@@ -3839,6 +3842,29 @@ VirtioInfoList *qmp_query_virtio(Error **errp)
     return list;
 }
=20
+void hmp_virtio_query(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    VirtioInfoList *l =3D qmp_query_virtio(&err);
+
+    if (err !=3D NULL) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    if (l =3D=3D NULL) {
+        monitor_printf(mon, "No VirtIO devices\n");
+        return;
+    }
+
+    while (l) {
+        monitor_printf(mon, "%s [%s]\n", l->value->path, l->value->type);
+        l =3D l->next;
+    }
+
+    qapi_free_VirtioInfoList(l);
+}
+
 static VirtIODevice *virtio_device_find(const char *path)
 {
     VirtIODevice *vdev;
@@ -3890,6 +3916,36 @@ VirtQueueStatus *qmp_virtio_queue_status(const char =
*path, uint16_t queue,
     return status;
 }
=20
+void hmp_virtio_queue_status(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    const char *path =3D qdict_get_try_str(qdict, "path");
+    int queue =3D qdict_get_int(qdict, "queue");
+    VirtQueueStatus *s =3D qmp_virtio_queue_status(path, queue, &err);
+
+    if (err !=3D NULL) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+    monitor_printf(mon, "%s:\n", path);
+    monitor_printf(mon, "  index:                %d\n", s->queue_index);
+    monitor_printf(mon, "  inuse:                %d\n", s->inuse);
+    monitor_printf(mon, "  last_avail_idx:       %d\n", s->last_avail_idx)=
;
+    monitor_printf(mon, "  shadow_avail_idx:     %d\n", s->shadow_avail_id=
x);
+    monitor_printf(mon, "  signalled_used:       %d\n", s->signalled_used)=
;
+    monitor_printf(mon, "  signalled_used_valid: %d\n",
+                   s->signalled_used_valid);
+    monitor_printf(mon, "  VRing:\n");
+    monitor_printf(mon, "    num:         %"PRId64"\n", s->vring_num);
+    monitor_printf(mon, "    num_default: %"PRId64"\n", s->vring_num_defau=
lt);
+    monitor_printf(mon, "    align:       %"PRId64"\n", s->vring_align);
+    monitor_printf(mon, "    desc:        0x%016"PRIx64"\n", s->vring_desc=
);
+    monitor_printf(mon, "    avail:       0x%016"PRIx64"\n", s->vring_avai=
l);
+    monitor_printf(mon, "    used:        0x%016"PRIx64"\n", s->vring_used=
);
+
+    qapi_free_VirtQueueStatus(s);
+}
+
 VirtioStatus *qmp_virtio_status(const char* path, Error **errp)
 {
     VirtIODevice *vdev;
@@ -3925,6 +3981,31 @@ VirtioStatus *qmp_virtio_status(const char* path, Er=
ror **errp)
     return status;
 }
=20
+void hmp_virtio_status(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    const char *path =3D qdict_get_try_str(qdict, "path");
+    VirtioStatus *s =3D qmp_virtio_status(path, &err);
+
+    if (err !=3D NULL) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    monitor_printf(mon, "%s:\n", path);
+    monitor_printf(mon, "  Device Id:        %"PRId64"\n", s->device_id);
+    monitor_printf(mon, "  Guest features:   0x%016"PRIx64"\n",
+                   s->guest_features);
+    monitor_printf(mon, "  Host features:    0x%016"PRIx64"\n",
+                   s->host_features);
+    monitor_printf(mon, "  Backend features: 0x%016"PRIx64"\n",
+                   s->backend_features);
+    monitor_printf(mon, "  Endianness:       %s\n", s->device_endian);
+    monitor_printf(mon, "  VirtQueues:       %d\n", s->num_vqs);
+
+    qapi_free_VirtioStatus(s);
+}
+
 VirtioQueueElement *qmp_virtio_queue_element(const char* path, uint16_t qu=
eue,
                                              bool has_index, uint16_t inde=
x,
                                              Error **errp)
@@ -4010,6 +4091,40 @@ VirtioQueueElement *qmp_virtio_queue_element(const c=
har* path, uint16_t queue,
     return element;
 }
=20
+void hmp_virtio_queue_element(Monitor *mon, const QDict *qdict)
+{
+    Error *err =3D NULL;
+    const char *path =3D qdict_get_try_str(qdict, "path");
+    int queue =3D qdict_get_int(qdict, "queue");
+    int index =3D qdict_get_try_int(qdict, "index", -1);
+    VirtioQueueElement *element;
+    VirtioRingDescList *list;
+
+    element =3D qmp_virtio_queue_element(path, queue, index !=3D -1, index=
, &err);
+    if (err !=3D NULL) {
+        hmp_handle_error(mon, err);
+        return;
+    }
+
+    monitor_printf(mon, "index:  %d\n", element->index);
+    monitor_printf(mon, "ndescs: %d\n", element->ndescs);
+    monitor_printf(mon, "descs:  ");
+
+    list =3D element->descs;
+    while (list) {
+        monitor_printf(mon, "addr 0x%"PRIx64" len %d %s", list->value->add=
r,
+                       list->value->len, list->value->flags &
+                       VRING_DESC_F_WRITE ? "(write-only)" : "(read-only)"=
);
+        list =3D list->next;
+        if (list) {
+            monitor_printf(mon, ", ");
+        }
+    }
+    monitor_printf(mon, "\n");
+
+    qapi_free_VirtioQueueElement(element);
+}
+
 static const TypeInfo virtio_device_info =3D {
     .name =3D TYPE_VIRTIO_DEVICE,
     .parent =3D TYPE_DEVICE,
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e33ca5a911a5..9f1c118dde31 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -98,6 +98,10 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *=
qdict);
 void hmp_qom_list(Monitor *mon, const QDict *qdict);
 void hmp_qom_set(Monitor *mon, const QDict *qdict);
 void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
+void hmp_virtio_query(Monitor *mon, const QDict *qdict);
+void hmp_virtio_status(Monitor *mon, const QDict *qdict);
+void hmp_virtio_queue_status(Monitor *mon, const QDict *qdict);
+void hmp_virtio_queue_element(Monitor *mon, const QDict *qdict);
 void object_add_completion(ReadLineState *rs, int nb_args, const char *str=
);
 void object_del_completion(ReadLineState *rs, int nb_args, const char *str=
);
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str=
);
diff --git a/monitor/misc.c b/monitor/misc.c
index 6c45fa490ff5..5eacfa7079fc 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "config-devices.h"
 #include "monitor-internal.h"
 #include "cpu.h"
 #include "monitor/qdev.h"
@@ -232,6 +233,15 @@ static void hmp_info_help(Monitor *mon, const QDict *q=
dict)
     help_cmd(mon, "info");
 }
=20
+static void hmp_virtio_help(Monitor *mon, const QDict *qdict)
+{
+#if defined(CONFIG_VIRTIO)
+    help_cmd(mon, "virtio");
+#else
+    monitor_printf(mon, "Virtio is disabled\n");
+#endif
+}
+
 static void monitor_init_qmp_commands(void)
 {
     /*
@@ -1683,6 +1693,13 @@ static HMPCommand hmp_info_cmds[] =3D {
     { NULL, NULL, },
 };
=20
+static HMPCommand hmp_virtio_cmds[] =3D {
+#if defined(CONFIG_VIRTIO)
+#include "hmp-commands-virtio.h"
+#endif
+    { NULL, NULL, },
+};
+
 /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
 HMPCommand hmp_cmds[] =3D {
 #include "hmp-commands.h"
--=20
2.25.1


