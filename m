Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564AFECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F63020815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F63020815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTpT-0006h0-KF
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iFS0O-0001Az-SU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iFS0M-0002Vx-T3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iFS0I-0002Qt-7y; Tue, 01 Oct 2019 19:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A2513058E0A;
 Tue,  1 Oct 2019 23:56:25 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0D0460BE0;
 Tue,  1 Oct 2019 23:56:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 3/8] bootdevice: Add interface to gather LCHS
Date: Tue,  1 Oct 2019 19:55:47 -0400
Message-Id: <20191001235552.17790-4-jsnow@redhat.com>
In-Reply-To: <20191001235552.17790-1-jsnow@redhat.com>
References: <20191001235552.17790-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 01 Oct 2019 23:56:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Add an interface to provide direct logical CHS values for boot devices.
We will use this interface in the next commits.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190925110639.100699-4-sameid@google.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/sysemu/sysemu.h |  3 +++
 bootdevice.c            | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 44f18eb739..5bc5c79cbc 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -103,6 +103,9 @@ void device_add_bootindex_property(Object *obj, int32=
_t *bootindex,
                                    DeviceState *dev, Error **errp);
 void restore_boot_order(void *opaque);
 void validate_bootdevices(const char *devices, Error **errp);
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsec=
s);
+void del_boot_device_lchs(DeviceState *dev, const char *suffix);
=20
 /* handler to set the boot_device order for a specific type of MachineCl=
ass */
 typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
diff --git a/bootdevice.c b/bootdevice.c
index 1d225202f9..bc5e1c2de4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -343,3 +343,58 @@ void device_add_bootindex_property(Object *obj, int3=
2_t *bootindex,
     /* initialize devices' bootindex property to -1 */
     object_property_set_int(obj, -1, name, NULL);
 }
+
+typedef struct FWLCHSEntry FWLCHSEntry;
+
+struct FWLCHSEntry {
+    QTAILQ_ENTRY(FWLCHSEntry) link;
+    DeviceState *dev;
+    char *suffix;
+    uint32_t lcyls;
+    uint32_t lheads;
+    uint32_t lsecs;
+};
+
+static QTAILQ_HEAD(, FWLCHSEntry) fw_lchs =3D
+    QTAILQ_HEAD_INITIALIZER(fw_lchs);
+
+void add_boot_device_lchs(DeviceState *dev, const char *suffix,
+                          uint32_t lcyls, uint32_t lheads, uint32_t lsec=
s)
+{
+    FWLCHSEntry *node;
+
+    if (!lcyls && !lheads && !lsecs) {
+        return;
+    }
+
+    assert(dev !=3D NULL || suffix !=3D NULL);
+
+    node =3D g_malloc0(sizeof(FWLCHSEntry));
+    node->suffix =3D g_strdup(suffix);
+    node->dev =3D dev;
+    node->lcyls =3D lcyls;
+    node->lheads =3D lheads;
+    node->lsecs =3D lsecs;
+
+    QTAILQ_INSERT_TAIL(&fw_lchs, node, link);
+}
+
+void del_boot_device_lchs(DeviceState *dev, const char *suffix)
+{
+    FWLCHSEntry *i;
+
+    if (dev =3D=3D NULL) {
+        return;
+    }
+
+    QTAILQ_FOREACH(i, &fw_lchs, link) {
+        if ((!suffix || !g_strcmp0(i->suffix, suffix)) &&
+             i->dev =3D=3D dev) {
+            QTAILQ_REMOVE(&fw_lchs, i, link);
+            g_free(i->suffix);
+            g_free(i);
+
+            break;
+        }
+    }
+}
--=20
2.21.0


