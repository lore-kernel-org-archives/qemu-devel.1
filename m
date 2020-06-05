Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60636C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AFC20659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRUYgLZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AFC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDwE-0002uo-Dm
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlu-0003zM-ST
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlo-0007TP-Iz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591368991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBDV8kCAH2Cg6X+4+4UIcOzTx7aTxCARjiIJBHVEauY=;
 b=aRUYgLZtNX7PZ+S9XJpq5Cv9/3tcfoyqum2EXTeTVfhwJIrGwtukcfhUC/qRN8/D0TEwpx
 TCk6ryZkZsn7xNB1GCOeyMfpm0LM9H30p7BwcAOW6VbmLV/wHz2NvDeaP3EusTt1DRgwNt
 J5ldBCqJ3GKvteyfoItGmz22rYIJ5JY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-0TfuautKNxWqs6Hh1WRW7Q-1; Fri, 05 Jun 2020 10:56:30 -0400
X-MC-Unique: 0TfuautKNxWqs6Hh1WRW7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39159EC1AD;
 Fri,  5 Jun 2020 14:56:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D39125C583;
 Fri,  5 Jun 2020 14:56:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCA291138461; Fri,  5 Jun 2020 16:56:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] qdev: Improve netdev property override error a bit
Date: Fri,  5 Jun 2020 16:56:19 +0200
Message-Id: <20200605145625.2920920-11-armbru@redhat.com>
In-Reply-To: <20200605145625.2920920-1-armbru@redhat.com>
References: <20200605145625.2920920-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qdev_prop_set_netdev() fails when the property already has a non-null
value.  Seems to go back to commit 30c367ed44
"qdev-properties-system.c: Allow vlan or netdev for -device, not
both", v1.7.0.  Board code doesn't expect failure, and crashes:

    $ qemu-system-x86_64 --nodefaults -nic user -netdev user,id=nic0 -global e1000.netdev=nic0
    Unexpected error in error_set_from_qdev_prop_error() at /work/armbru/qemu/hw/core/qdev-properties.c:1101:
    qemu-system-x86_64: Property 'e1000.netdev' doesn't take value '__org.qemu.nic0
    '
    Aborted (core dumped)

-device and device_add handle the failure:

    $ qemu-system-x86_64 -nodefaults -netdev user,id=net0 -netdev user,id=net1 -device e1000,netdev=net0,netdev=net1
    qemu-system-x86_64: -device e1000,netdev=net0,netdev=net1: Property 'e1000.netdev' doesn't take value 'net1'
    $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -netdev user,id=net0 -netdev user,id=net1 -global e1000.netdev=net0
    QEMU 5.0.50 monitor - type 'help' for more information
    (qemu) qemu-system-x86_64: warning: netdev net0 has no peer
    qemu-system-x86_64: warning: netdev net1 has no peer
    device_add e1000,netdev=net1
    Error: Property 'e1000.netdev' doesn't take value 'net1'

Perhaps netdev property override could be made to work.  Perhaps it
should.  I'm not the right guy to figure this out.  What I can do is
improve the error message a bit:

    (qemu) device_add e1000,netdev=net1
    Error: -global e1000.netdev=... conflicts with netdev=net1

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-properties.h     |  2 ++
 hw/core/qdev-properties-system.c | 30 +++++++++++++++++++++++++++---
 hw/core/qdev-properties.c        | 17 +++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..566419f379 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -248,6 +248,8 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 
 void qdev_prop_register_global(GlobalProperty *prop);
+const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
+                                            const char *name);
 int qdev_prop_check_globals(void);
 void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 9aa80495ee..20fd58e8f9 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -25,6 +25,28 @@
 #include "sysemu/iothread.h"
 #include "sysemu/tpm_backend.h"
 
+static bool check_non_null(DeviceState *dev, const char *name,
+                           const void *old_val, const char *new_val,
+                           Error **errp)
+{
+    const GlobalProperty *prop = qdev_find_global_prop(dev, name);
+
+    if (!old_val) {
+        return true;
+    }
+
+    if (prop) {
+        error_setg(errp, "-global %s.%s=... conflicts with %s=%s",
+                   prop->driver, prop->property, name, new_val);
+    } else {
+        /* Error message is vague, but a better one would be hard */
+        error_setg(errp, "%s=%s conflicts, and override is not implemented",
+                   name, new_val);
+    }
+    return false;
+}
+
+
 /* --- drive --- */
 
 static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
@@ -299,14 +321,16 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     }
 
     for (i = 0; i < queues; i++) {
-
         if (peers[i]->peer) {
             err = -EEXIST;
             goto out;
         }
 
-        if (ncs[i]) {
-            err = -EINVAL;
+        /*
+         * TODO Should this really be an error?  If no, the old value
+         * needs to be released before we store the new one.
+         */
+        if (!check_non_null(dev, name, ncs[i], str, errp)) {
             goto out;
         }
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index cc924815da..8c8beb56b2 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1181,6 +1181,23 @@ void qdev_prop_register_global(GlobalProperty *prop)
     g_ptr_array_add(global_props(), prop);
 }
 
+const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
+                                            const char *name)
+{
+    GPtrArray *props = global_props();
+    const GlobalProperty *p;
+    int i;
+
+    for (i = 0; i < props->len; i++) {
+        p = g_ptr_array_index(props, i);
+        if (object_dynamic_cast(OBJECT(dev), p->driver)
+            && !strcmp(p->property, name)) {
+            return p;
+        }
+    }
+    return NULL;
+}
+
 int qdev_prop_check_globals(void)
 {
     int i, ret = 0;
-- 
2.26.2


