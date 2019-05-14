Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C02C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4E62166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4E62166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49795 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZFh-0001OE-1u
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:22:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQZDb-0000ON-RO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQZDa-0001DT-Rx
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQZDa-0001Cs-KZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:19:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D953301EA8F;
	Tue, 14 May 2019 15:19:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E4A75100203C;
	Tue, 14 May 2019 15:19:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 83B3211385E4; Tue, 14 May 2019 17:19:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
References: <20190514075602.7674-1-lvivier@redhat.com>
Date: Tue, 14 May 2019 17:19:42 +0200
In-Reply-To: <20190514075602.7674-1-lvivier@redhat.com> (Laurent Vivier's
	message of "Tue, 14 May 2019 09:55:59 +0200")
Message-ID: <8736lhdpwx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 14 May 2019 15:19:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3.5/4] virtio-rng: Keep the default backend out
 of VirtIORNGConf
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default backend is only used within virtio_rng_device_realize().
Replace VirtIORNGConf member default_backend by a local variable.
Adjust its type to reduce conversions.

While there, pass &error_abort instead of NULL when failure would be a
programming error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/virtio/virtio-rng.c         | 20 +++++++++-----------
 include/hw/virtio/virtio-rng.h |  2 --
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 30493a2586..73ffb476e0 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -16,6 +16,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
+#include "sysemu/rng-random.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
@@ -189,27 +190,24 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (vrng->conf.rng == NULL) {
-        vrng->conf.default_backend = RNG_RANDOM(object_new(TYPE_RNG_RANDOM));
+        Object *default_backend = object_new(TYPE_RNG_RANDOM);
 
-        user_creatable_complete(USER_CREATABLE(vrng->conf.default_backend),
+        user_creatable_complete(USER_CREATABLE(default_backend),
                                 &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            object_unref(OBJECT(vrng->conf.default_backend));
+            object_unref(default_backend);
             return;
         }
 
-        object_property_add_child(OBJECT(dev),
-                                  "default-backend",
-                                  OBJECT(vrng->conf.default_backend),
-                                  NULL);
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend, &error_abort);
 
         /* The child property took a reference, we can safely drop ours now */
-        object_unref(OBJECT(vrng->conf.default_backend));
+        object_unref(default_backend);
 
-        object_property_set_link(OBJECT(dev),
-                                 OBJECT(vrng->conf.default_backend),
-                                 "rng", NULL);
+        object_property_set_link(OBJECT(dev), default_backend,
+                                 "rng", &error_abort);
     }
 
     vrng->rng = vrng->conf.rng;
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
index 922dce7cac..28ff752c40 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -13,7 +13,6 @@
 #define QEMU_VIRTIO_RNG_H
 
 #include "sysemu/rng.h"
-#include "sysemu/rng-random.h"
 #include "standard-headers/linux/virtio_rng.h"
 
 #define TYPE_VIRTIO_RNG "virtio-rng-device"
@@ -26,7 +25,6 @@ struct VirtIORNGConf {
     RngBackend *rng;
     uint64_t max_bytes;
     uint32_t period_ms;
-    RngRandom *default_backend;
 };
 
 typedef struct VirtIORNG {
-- 
2.17.2


