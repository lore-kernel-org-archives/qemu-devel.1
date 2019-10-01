Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DEFC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846C520842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846C520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50689 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUD4-0005jp-L7
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iFS0g-0001HI-TB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iFS0f-0002l6-Ky
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:56:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iFS0b-0002fX-H3; Tue, 01 Oct 2019 19:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 552F2308FFB1;
 Tue,  1 Oct 2019 23:56:44 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2AC60BE0;
 Tue,  1 Oct 2019 23:56:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 6/8] bootdevice: Refactor get_boot_devices_list
Date: Tue,  1 Oct 2019 19:55:50 -0400
Message-Id: <20191001235552.17790-7-jsnow@redhat.com>
In-Reply-To: <20191001235552.17790-1-jsnow@redhat.com>
References: <20191001235552.17790-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 01 Oct 2019 23:56:44 +0000 (UTC)
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

Move device name construction to a separate function.

We will reuse this function in the following commit to pass logical CHS
parameters through fw_cfg much like we currently pass bootindex.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-id: 20190925110639.100699-7-sameid@google.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 bootdevice.c | 61 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index bc5e1c2de4..2b12fb85a4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
     return res;
 }
=20
+static char *get_boot_device_path(DeviceState *dev, bool ignore_suffixes=
,
+                                  char *suffix)
+{
+    char *devpath =3D NULL, *s =3D NULL, *d, *bootpath;
+
+    if (dev) {
+        devpath =3D qdev_get_fw_dev_path(dev);
+        assert(devpath);
+    }
+
+    if (!ignore_suffixes) {
+        if (dev) {
+            d =3D qdev_get_own_fw_dev_path_from_handler(dev->parent_bus,=
 dev);
+            if (d) {
+                assert(!suffix);
+                s =3D d;
+            } else {
+                s =3D g_strdup(suffix);
+            }
+        } else {
+            s =3D g_strdup(suffix);
+        }
+    }
+
+    bootpath =3D g_strdup_printf("%s%s",
+                               devpath ? devpath : "",
+                               s ? s : "");
+    g_free(devpath);
+    g_free(s);
+
+    return bootpath;
+}
+
 /*
  * This function returns null terminated string that consist of new line
  * separated device paths.
@@ -218,36 +251,10 @@ char *get_boot_devices_list(size_t *size)
     bool ignore_suffixes =3D mc->ignore_boot_device_suffixes;
=20
     QTAILQ_FOREACH(i, &fw_boot_order, link) {
-        char *devpath =3D NULL,  *suffix =3D NULL;
         char *bootpath;
-        char *d;
         size_t len;
=20
-        if (i->dev) {
-            devpath =3D qdev_get_fw_dev_path(i->dev);
-            assert(devpath);
-        }
-
-        if (!ignore_suffixes) {
-            if (i->dev) {
-                d =3D qdev_get_own_fw_dev_path_from_handler(i->dev->pare=
nt_bus,
-                                                          i->dev);
-                if (d) {
-                    assert(!i->suffix);
-                    suffix =3D d;
-                } else {
-                    suffix =3D g_strdup(i->suffix);
-                }
-            } else {
-                suffix =3D g_strdup(i->suffix);
-            }
-        }
-
-        bootpath =3D g_strdup_printf("%s%s",
-                                   devpath ? devpath : "",
-                                   suffix ? suffix : "");
-        g_free(devpath);
-        g_free(suffix);
+        bootpath =3D get_boot_device_path(i->dev, ignore_suffixes, i->su=
ffix);
=20
         if (total) {
             list[total-1] =3D '\n';
--=20
2.21.0


