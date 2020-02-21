Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA65C11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B65208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VGx7KG7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B65208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zBX-00080B-Q2
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7p-0001wh-Nb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7o-00087F-G4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:13 -0500
Received: from ozlabs.org ([203.11.71.1]:57973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7o-0007xP-3w; Thu, 20 Feb 2020 22:37:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwC4r2xz9sRs; Fri, 21 Feb 2020 14:36:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256219;
 bh=glsWacbQzsnQT3+iIZDewPKdOZbmjTYn71tJzXu43KU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VGx7KG7pTlRLBaQC0d8e7WW/r/lvZOdOrQXlCwhyXKyZtUSg1HsdpIXfh38y3+MSs
 JFlfIVxk7NpQSTWOdHhxBUk7cbckVy5Tq8tQmE/FKJ0FYaByLqV9fMY0sK7q78Fg2E
 lpXURm4kuc8+8v3Q8yLP5JDP7HDBPwB36rB5zhzU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 06/20] nvdimm: add uuid property to nvdimm
Date: Fri, 21 Feb 2020 14:36:36 +1100
Message-Id: <20200221033650.444386-7-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

For ppc64, PAPR requires the nvdimm device to have UUID property
set in the device tree. Add an option to get it from the user.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <158131056931.2897.14057087440721445976.stgit@lep8c.aus.stgla=
bs.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/mem/nvdimm.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h |  7 +++++++
 2 files changed, 47 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 39f1426d1f..8e426d24bb 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -69,11 +69,51 @@ out:
     error_propagate(errp, local_err);
 }
=20
+static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
+    char *value =3D NULL;
+
+    value =3D qemu_uuid_unparse_strdup(&nvdimm->uuid);
+
+    visit_type_str(v, name, &value, errp);
+    g_free(value);
+}
+
+
+static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
+    Error *local_err =3D NULL;
+    char *value;
+
+    visit_type_str(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (qemu_uuid_parse(value, &nvdimm->uuid) !=3D 0) {
+        error_setg(errp, "Property '%s.%s' has invalid value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    g_free(value);
+
+out:
+    error_propagate(errp, local_err);
+}
+
+
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NU=
LL,
                         NULL, NULL);
+
+    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uu=
id,
+                        nvdimm_set_uuid, NULL, NULL, NULL);
 }
=20
 static void nvdimm_finalize(Object *obj)
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..4807ca615b 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
=20
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "qemu/uuid.h"
=20
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -49,6 +50,7 @@
                                                TYPE_NVDIMM)
=20
 #define NVDIMM_LABEL_SIZE_PROP "label-size"
+#define NVDIMM_UUID_PROP       "uuid"
 #define NVDIMM_UNARMED_PROP    "unarmed"
=20
 struct NVDIMMDevice {
@@ -83,6 +85,11 @@ struct NVDIMMDevice {
      * the guest write persistence.
      */
     bool unarmed;
+
+    /*
+     * The PPC64 - spapr requires each nvdimm device have a uuid.
+     */
+    QemuUUID uuid;
 };
 typedef struct NVDIMMDevice NVDIMMDevice;
=20
--=20
2.24.1


