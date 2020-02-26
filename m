Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97DCC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B6020801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJzuxAPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B6020801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6u1C-0007Wg-GH
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6tts-0005JV-N0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6ttp-0004UY-1L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6tto-0004R2-Qs
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582712799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNCHVVuco+PBY1XG3cdwNfMQtkAiw6D57iodH3NqKZA=;
 b=UJzuxAPqLboB2XQTbZI3dHER7IdnR+PW6l+2Im/+591G5xAB5qD/Wk6bVcTivT5AjYnKav
 5WDHb5jqfEEBGOEu6ZSbnqfzR/w5j241UrauimeMbvbN1pZ6ttDKRFCXki3m6HM0r4QCwf
 FzFEdBs89GTBFHiuCYEXBmLkF52+J4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-PbXWlfVdMKW3j0Q5U0DXdQ-1; Wed, 26 Feb 2020 05:26:37 -0500
X-MC-Unique: PbXWlfVdMKW3j0Q5U0DXdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EDF7800D54;
 Wed, 26 Feb 2020 10:26:36 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 515F560BE1;
 Wed, 26 Feb 2020 10:26:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v3 09/10] test: tpm-tis: Get prepared to share tests between
 ISA and sysbus devices
Date: Wed, 26 Feb 2020 11:25:48 +0100
Message-Id: <20200226102549.12158-10-eric.auger@redhat.com>
In-Reply-To: <20200226102549.12158-1-eric.auger@redhat.com>
References: <20200226102549.12158-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ISA and sysbus TPM-TIS devices will share their tests. Only
the main() will change (instantiation option is different).
Also the base address of the TPM-TIS device is going to be
different. on x86 it is located at 0xFED40000 while on ARM
it can be located at any location, discovered through the
device tree description.

So we put shared test functions in a new object module.
Each test needs to set tpm_tis_base_addr global variable.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/Makefile.include     |   2 +-
 tests/qtest/tpm-crb-swtpm-test.c |   3 +
 tests/qtest/tpm-crb-test.c       |   2 +
 tests/qtest/tpm-tis-swtpm-test.c |   3 +
 tests/qtest/tpm-tis-test.c       | 414 +----------------------------
 tests/qtest/tpm-tis-util.c       | 433 +++++++++++++++++++++++++++++++
 tests/qtest/tpm-tis-util.h       |  23 ++
 tests/qtest/tpm-util.c           |   3 -
 tests/qtest/tpm-util.h           |   5 +
 9 files changed, 473 insertions(+), 415 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-util.c
 create mode 100644 tests/qtest/tpm-tis-util.h

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 028af5b782..44aac68b25 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -302,7 +302,7 @@ tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tp=
m-crb-swtpm-test.o tests/
 tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
 tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o =
tests/qtest/tpm-emu.o \
 =09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
+tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/=
tpm-tis-util.o tests/qtest/tpm-emu.o $(test-io-obj-y)
=20
 # QTest rules
=20
diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-t=
est.c
index 5228cb7af4..ac92f08bee 100644
--- a/tests/qtest/tpm-crb-swtpm-test.c
+++ b/tests/qtest/tpm-crb-swtpm-test.c
@@ -18,6 +18,9 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
+#include "hw/acpi/tpm.h"
+
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
=20
 typedef struct TestState {
     char *src_tpm_path;
diff --git a/tests/qtest/tpm-crb-test.c b/tests/qtest/tpm-crb-test.c
index 632fb7fbd8..cdd09e5396 100644
--- a/tests/qtest/tpm-crb-test.c
+++ b/tests/qtest/tpm-crb-test.c
@@ -19,6 +19,8 @@
 #include "qemu/module.h"
 #include "tpm-emu.h"
=20
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
+
 #define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
=20
 static void tpm_crb_test(const void *data)
diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-t=
est.c
index 9470f15751..90131cb3c4 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -18,6 +18,9 @@
 #include "libqtest.h"
 #include "qemu/module.h"
 #include "tpm-tests.h"
+#include "hw/acpi/tpm.h"
+
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
=20
 typedef struct TestState {
     char *src_tpm_path;
diff --git a/tests/qtest/tpm-tis-test.c b/tests/qtest/tpm-tis-test.c
index dcf30e05b7..79ffbc943e 100644
--- a/tests/qtest/tpm-tis-test.c
+++ b/tests/qtest/tpm-tis-test.c
@@ -1,5 +1,5 @@
 /*
- * QTest testcase for TPM TIS
+ * QTest testcase for ISA TPM TIS
  *
  * Copyright (c) 2018 Red Hat, Inc.
  * Copyright (c) 2018 IBM Corporation
@@ -20,417 +20,9 @@
 #include "libqtest-single.h"
 #include "qemu/module.h"
 #include "tpm-emu.h"
+#include "tpm-tis-util.h"
=20
-#define TIS_REG(LOCTY, REG) \
-    (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
-
-#define DEBUG_TIS_TEST 0
-
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_TIS_TEST) { \
-        printf(fmt, ## __VA_ARGS__); \
-    } \
-} while (0)
-
-#define DPRINTF_ACCESS \
-    DPRINTF("%s: %d: locty=3D%d l=3D%d access=3D0x%02x pending_request_fla=
g=3D0x%x\n", \
-            __func__, __LINE__, locty, l, access, pending_request_flag)
-
-#define DPRINTF_STS \
-    DPRINTF("%s: %d: sts =3D 0x%08x\n", __func__, __LINE__, sts)
-
-static const uint8_t TPM_CMD[12] =3D
-    "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
-
-static void tpm_tis_test_check_localities(const void *data)
-{
-    uint8_t locty;
-    uint8_t access;
-    uint32_t ifaceid;
-    uint32_t capability;
-    uint32_t didvid;
-    uint32_t rid;
-
-    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES; locty++) {
-        access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        capability =3D readl(TIS_REG(locty, TPM_TIS_REG_INTF_CAPABILITY));
-        g_assert_cmpint(capability, =3D=3D, TPM_TIS_CAPABILITIES_SUPPORTED=
2_0);
-
-        ifaceid =3D readl(TIS_REG(locty, TPM_TIS_REG_INTERFACE_ID));
-        g_assert_cmpint(ifaceid, =3D=3D, TPM_TIS_IFACE_ID_SUPPORTED_FLAGS2=
_0);
-
-        didvid =3D readl(TIS_REG(locty, TPM_TIS_REG_DID_VID));
-        g_assert_cmpint(didvid, !=3D, 0);
-        g_assert_cmpint(didvid, !=3D, 0xffffffff);
-
-        rid =3D readl(TIS_REG(locty, TPM_TIS_REG_RID));
-        g_assert_cmpint(rid, !=3D, 0);
-        g_assert_cmpint(rid, !=3D, 0xffffffff);
-    }
-}
-
-static void tpm_tis_test_check_access_reg(const void *data)
-{
-    uint8_t locty;
-    uint8_t access;
-
-    /* do not test locality 4 (hw only) */
-    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of locality */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
-
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* release access */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
-               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-    }
-}
-
-/*
- * Test case for seizing access by a higher number locality
- */
-static void tpm_tis_test_check_access_reg_seize(const void *data)
-{
-    int locty, l;
-    uint8_t access;
-    uint8_t pending_request_flag;
-
-    /* do not test locality 4 (hw only) */
-    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
-        pending_request_flag =3D 0;
-
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of locality */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* lower localities cannot seize access */
-        for (l =3D 0; l < locty; l++) {
-            /* lower locality is not active */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* try to request use from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
-
-            /* requesting use from 'l' was not possible;
-               we must see REQUEST_USE and possibly PENDING_REQUEST */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* locality 'locty' must be unchanged;
-               we must see PENDING_REQUEST */
-            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        TPM_TIS_ACCESS_PENDING_REQUEST |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* try to seize from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE);
-            /* seize from 'l' was not possible */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* locality 'locty' must be unchanged */
-            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        TPM_TIS_ACCESS_PENDING_REQUEST |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* on the next loop we will have a PENDING_REQUEST flag
-               set for locality 'l' */
-            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
-        }
-
-        /* higher localities can 'seize' access but not 'request use';
-           note: this will activate first l+1, then l+2 etc. */
-        for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            /* try to 'request use' from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
-
-            /* requesting use from 'l' was not possible; we should see
-               REQUEST_USE and may see PENDING_REQUEST */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* locality 'l-1' must be unchanged; we should always
-               see PENDING_REQUEST from 'l' requesting access */
-            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        TPM_TIS_ACCESS_PENDING_REQUEST |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* try to seize from 'l' */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE);
-
-            /* seize from 'l' was possible */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* l - 1 should show that it has BEEN_SEIZED */
-            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_BEEN_SEIZED |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* clear the BEEN_SEIZED flag and make sure it's gone */
-            writeb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS),
-                   TPM_TIS_ACCESS_BEEN_SEIZED);
-
-            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-        }
-
-        /* PENDING_REQUEST will not be set if locty =3D 0 since all locali=
ties
-           were active; in case of locty =3D 1, locality 0 will be active
-           but no PENDING_REQUEST anywhere */
-        if (locty <=3D 1) {
-            pending_request_flag =3D 0;
-        }
-
-        /* release access from l - 1; this activates locty - 1 */
-        l--;
-
-        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-        DPRINTF_ACCESS;
-
-        DPRINTF("%s: %d: relinquishing control on l =3D %d\n",
-                __func__, __LINE__, l);
-        writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
-               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-
-        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-        DPRINTF_ACCESS;
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    pending_request_flag |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        for (l =3D locty - 1; l >=3D 0; l--) {
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-            /* release this locality */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
-                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-
-            if (l =3D=3D 1) {
-                pending_request_flag =3D 0;
-            }
-        }
-
-        /* no locality may be active now */
-        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-        }
-    }
-}
-
-/*
- * Test case for getting access when higher number locality relinquishes a=
ccess
- */
-static void tpm_tis_test_check_access_reg_release(const void *data)
-{
-    int locty, l;
-    uint8_t access;
-    uint8_t pending_request_flag;
-
-    /* do not test locality 4 (hw only) */
-    for (locty =3D TPM_TIS_NUM_LOCALITIES - 2; locty >=3D 0; locty--) {
-        pending_request_flag =3D 0;
-
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of locality */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
-        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
-        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-        /* request use of all other localities */
-        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
-            if (l =3D=3D locty) {
-                continue;
-            }
-            /* request use of locality 'l' -- we MUST see REQUEST USE and
-               may see PENDING_REQUEST */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_REQUEST_USE |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
-        }
-        /* release locality 'locty' */
-        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
-               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-        /* highest locality should now be active; release it and make sure=
 the
-           next higest locality is active afterwards */
-        for (l =3D TPM_TIS_NUM_LOCALITIES - 2; l >=3D 0; l--) {
-            if (l =3D=3D locty) {
-                continue;
-            }
-            /* 'l' should be active now */
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-            /* 'l' relinquishes access */
-            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
-                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
-            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
-            DPRINTF_ACCESS;
-            if (l =3D=3D 1 || (locty <=3D 1 && l =3D=3D 2)) {
-                pending_request_flag =3D 0;
-            }
-            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
-                                        pending_request_flag |
-                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-        }
-    }
-}
-
-/*
- * Test case for transmitting packets
- */
-static void tpm_tis_test_check_transmit(const void *data)
-{
-    const TestState *s =3D data;
-    uint8_t access;
-    uint32_t sts;
-    uint16_t bcount;
-    size_t i;
-
-    /* request use of locality 0 */
-    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_USE);
-    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
-    g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
-                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
-                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
-
-    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-    DPRINTF_STS;
-
-    g_assert_cmpint(sts & 0xff, =3D=3D, 0);
-    g_assert_cmpint(sts & TPM_TIS_STS_TPM_FAMILY_MASK, =3D=3D,
-                    TPM_TIS_STS_TPM_FAMILY2_0);
-
-    bcount =3D (sts >> 8) & 0xffff;
-    g_assert_cmpint(bcount, >=3D, 128);
-
-    writel(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_COMMAND_READY);
-    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-    DPRINTF_STS;
-    g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_COMMAND_READY);
-
-    /* transmit command */
-    for (i =3D 0; i < sizeof(TPM_CMD); i++) {
-        writeb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO), TPM_CMD[i]);
-        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-        DPRINTF_STS;
-        if (i < sizeof(TPM_CMD) - 1) {
-            g_assert_cmpint(sts & 0xff, =3D=3D,
-                            TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
-        } else {
-            g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_VALID);
-        }
-        g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
-    }
-    /* start processing */
-    writeb(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_TPM_GO);
-
-    uint64_t end_time =3D g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND=
;
-    do {
-        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) !=3D 0) {
-            break;
-        }
-    } while (g_get_monotonic_time() < end_time);
-
-    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-    DPRINTF_STS;
-    g_assert_cmpint(sts & 0xff, =3D=3D ,
-                    TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
-    bcount =3D (sts >> 8) & 0xffff;
-
-    /* read response */
-    uint8_t tpm_msg[sizeof(struct tpm_hdr)];
-    g_assert_cmpint(sizeof(tpm_msg), =3D=3D, bcount);
-
-    for (i =3D 0; i < sizeof(tpm_msg); i++) {
-        tpm_msg[i] =3D readb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
-        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
-        DPRINTF_STS;
-        if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
-            g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
-        }
-    }
-    g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_m=
sg));
-
-    /* relinquish use of locality 0 */
-    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_ACTIVE_LOCALITY)=
;
-    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
-}
+uint64_t tpm_tis_base_addr =3D TPM_TIS_ADDR_BASE;
=20
 int main(int argc, char **argv)
 {
diff --git a/tests/qtest/tpm-tis-util.c b/tests/qtest/tpm-tis-util.c
new file mode 100644
index 0000000000..8d3e5f1cc3
--- /dev/null
+++ b/tests/qtest/tpm-tis-util.c
@@ -0,0 +1,433 @@
+/*
+ * QTest testcase for TPM TIS: common test functions used for both
+ * the ISA and SYSBUS devices
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "hw/acpi/tpm.h"
+#include "io/channel-socket.h"
+#include "libqtest-single.h"
+#include "qemu/module.h"
+#include "tpm-emu.h"
+#include "tpm-util.h"
+#include "tpm-tis-util.h"
+
+#define DEBUG_TIS_TEST 0
+
+#define DPRINTF(fmt, ...) do { \
+    if (DEBUG_TIS_TEST) { \
+        printf(fmt, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define DPRINTF_ACCESS \
+    DPRINTF("%s: %d: locty=3D%d l=3D%d access=3D0x%02x pending_request_fla=
g=3D0x%x\n", \
+            __func__, __LINE__, locty, l, access, pending_request_flag)
+
+#define DPRINTF_STS \
+    DPRINTF("%s: %d: sts =3D 0x%08x\n", __func__, __LINE__, sts)
+
+static const uint8_t TPM_CMD[12] =3D
+    "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
+
+void tpm_tis_test_check_localities(const void *data)
+{
+    uint8_t locty;
+    uint8_t access;
+    uint32_t ifaceid;
+    uint32_t capability;
+    uint32_t didvid;
+    uint32_t rid;
+
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES; locty++) {
+        access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        capability =3D readl(TIS_REG(locty, TPM_TIS_REG_INTF_CAPABILITY));
+        g_assert_cmpint(capability, =3D=3D, TPM_TIS_CAPABILITIES_SUPPORTED=
2_0);
+
+        ifaceid =3D readl(TIS_REG(locty, TPM_TIS_REG_INTERFACE_ID));
+        g_assert_cmpint(ifaceid, =3D=3D, TPM_TIS_IFACE_ID_SUPPORTED_FLAGS2=
_0);
+
+        didvid =3D readl(TIS_REG(locty, TPM_TIS_REG_DID_VID));
+        g_assert_cmpint(didvid, !=3D, 0);
+        g_assert_cmpint(didvid, !=3D, 0xffffffff);
+
+        rid =3D readl(TIS_REG(locty, TPM_TIS_REG_RID));
+        g_assert_cmpint(rid, !=3D, 0);
+        g_assert_cmpint(rid, !=3D, 0xffffffff);
+    }
+}
+
+void tpm_tis_test_check_access_reg(const void *data)
+{
+    uint8_t locty;
+    uint8_t access;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* release access */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+    }
+}
+
+/*
+ * Test case for seizing access by a higher number locality
+ */
+void tpm_tis_test_check_access_reg_seize(const void *data)
+{
+    int locty, l;
+    uint8_t access;
+    uint8_t pending_request_flag;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
+        pending_request_flag =3D 0;
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* lower localities cannot seize access */
+        for (l =3D 0; l < locty; l++) {
+            /* lower locality is not active */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* try to request use from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
+
+            /* requesting use from 'l' was not possible;
+               we must see REQUEST_USE and possibly PENDING_REQUEST */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* locality 'locty' must be unchanged;
+               we must see PENDING_REQUEST */
+            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* try to seize from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE);
+            /* seize from 'l' was not possible */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* locality 'locty' must be unchanged */
+            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* on the next loop we will have a PENDING_REQUEST flag
+               set for locality 'l' */
+            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
+        }
+
+        /* higher localities can 'seize' access but not 'request use';
+           note: this will activate first l+1, then l+2 etc. */
+        for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            /* try to 'request use' from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
+
+            /* requesting use from 'l' was not possible; we should see
+               REQUEST_USE and may see PENDING_REQUEST */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* locality 'l-1' must be unchanged; we should always
+               see PENDING_REQUEST from 'l' requesting access */
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* try to seize from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE);
+
+            /* seize from 'l' was possible */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* l - 1 should show that it has BEEN_SEIZED */
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_BEEN_SEIZED |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* clear the BEEN_SEIZED flag and make sure it's gone */
+            writeb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_BEEN_SEIZED);
+
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+        }
+
+        /* PENDING_REQUEST will not be set if locty =3D 0 since all locali=
ties
+           were active; in case of locty =3D 1, locality 0 will be active
+           but no PENDING_REQUEST anywhere */
+        if (locty <=3D 1) {
+            pending_request_flag =3D 0;
+        }
+
+        /* release access from l - 1; this activates locty - 1 */
+        l--;
+
+        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+        DPRINTF_ACCESS;
+
+        DPRINTF("%s: %d: relinquishing control on l =3D %d\n",
+                __func__, __LINE__, l);
+        writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+
+        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+        DPRINTF_ACCESS;
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    pending_request_flag |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        for (l =3D locty - 1; l >=3D 0; l--) {
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+            /* release this locality */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+
+            if (l =3D=3D 1) {
+                pending_request_flag =3D 0;
+            }
+        }
+
+        /* no locality may be active now */
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+        }
+    }
+}
+
+/*
+ * Test case for getting access when higher number locality relinquishes a=
ccess
+ */
+void tpm_tis_test_check_access_reg_release(const void *data)
+{
+    int locty, l;
+    uint8_t access;
+    uint8_t pending_request_flag;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D TPM_TIS_NUM_LOCALITIES - 2; locty >=3D 0; locty--) {
+        pending_request_flag =3D 0;
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of all other localities */
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            if (l =3D=3D locty) {
+                continue;
+            }
+            /* request use of locality 'l' -- we MUST see REQUEST USE and
+               may see PENDING_REQUEST */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_=
USE);
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
+        }
+        /* release locality 'locty' */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+        /* highest locality should now be active; release it and make sure=
 the
+           next higest locality is active afterwards */
+        for (l =3D TPM_TIS_NUM_LOCALITIES - 2; l >=3D 0; l--) {
+            if (l =3D=3D locty) {
+                continue;
+            }
+            /* 'l' should be active now */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+            /* 'l' relinquishes access */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            if (l =3D=3D 1 || (locty <=3D 1 && l =3D=3D 2)) {
+                pending_request_flag =3D 0;
+            }
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_S=
TS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+        }
+    }
+}
+
+/*
+ * Test case for transmitting packets
+ */
+void tpm_tis_test_check_transmit(const void *data)
+{
+    const TestState *s =3D data;
+    uint8_t access;
+    uint32_t sts;
+    uint16_t bcount;
+    size_t i;
+
+    /* request use of locality 0 */
+    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_USE);
+    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+    g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+
+    g_assert_cmpint(sts & 0xff, =3D=3D, 0);
+    g_assert_cmpint(sts & TPM_TIS_STS_TPM_FAMILY_MASK, =3D=3D,
+                    TPM_TIS_STS_TPM_FAMILY2_0);
+
+    bcount =3D (sts >> 8) & 0xffff;
+    g_assert_cmpint(bcount, >=3D, 128);
+
+    writel(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_COMMAND_READY);
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+    g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_COMMAND_READY);
+
+    /* transmit command */
+    for (i =3D 0; i < sizeof(TPM_CMD); i++) {
+        writeb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO), TPM_CMD[i]);
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        DPRINTF_STS;
+        if (i < sizeof(TPM_CMD) - 1) {
+            g_assert_cmpint(sts & 0xff, =3D=3D,
+                            TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
+        } else {
+            g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_VALID);
+        }
+        g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
+    }
+    /* start processing */
+    writeb(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_TPM_GO);
+
+    uint64_t end_time =3D g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND=
;
+    do {
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) !=3D 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+    g_assert_cmpint(sts & 0xff, =3D=3D ,
+                    TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
+    bcount =3D (sts >> 8) & 0xffff;
+
+    /* read response */
+    uint8_t tpm_msg[sizeof(struct tpm_hdr)];
+    g_assert_cmpint(sizeof(tpm_msg), =3D=3D, bcount);
+
+    for (i =3D 0; i < sizeof(tpm_msg); i++) {
+        tpm_msg[i] =3D readb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        DPRINTF_STS;
+        if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
+            g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
+        }
+    }
+    g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_m=
sg));
+
+    /* relinquish use of locality 0 */
+    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_ACTIVE_LOCALITY)=
;
+    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+}
diff --git a/tests/qtest/tpm-tis-util.h b/tests/qtest/tpm-tis-util.h
new file mode 100644
index 0000000000..d10efe86ae
--- /dev/null
+++ b/tests/qtest/tpm-tis-util.h
@@ -0,0 +1,23 @@
+/*
+ * QTest TPM TIS: Common test functions used for both the
+ * ISA and SYSBUS devices
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TESTS_TPM_TIS_UTIL_H
+#define TESTS_TPM_TIS_UTIL_H
+
+void tpm_tis_test_check_localities(const void *data);
+void tpm_tis_test_check_access_reg(const void *data);
+void tpm_tis_test_check_access_reg_seize(const void *data);
+void tpm_tis_test_check_access_reg_release(const void *data);
+void tpm_tis_test_check_transmit(const void *data);
+
+#endif /* TESTS_TPM_TIS_UTIL_H */
diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
index 7ecdae2fc6..34efae8f18 100644
--- a/tests/qtest/tpm-util.c
+++ b/tests/qtest/tpm-util.c
@@ -19,9 +19,6 @@
 #include "tpm-util.h"
 #include "qapi/qmp/qdict.h"
=20
-#define TIS_REG(LOCTY, REG) \
-    (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
-
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size)
diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
index 15e3924942..3f5fa6eee9 100644
--- a/tests/qtest/tpm-util.h
+++ b/tests/qtest/tpm-util.h
@@ -15,6 +15,11 @@
=20
 #include "io/channel-socket.h"
=20
+#define TIS_REG(LOCTY, REG) \
+    (tpm_tis_base_addr + ((LOCTY) << 12) + REG)
+
+extern uint64_t tpm_tis_base_addr;
+
 typedef void (tx_func)(QTestState *s,
                        const unsigned char *req, size_t req_size,
                        unsigned char *rsp, size_t rsp_size);
--=20
2.20.1


