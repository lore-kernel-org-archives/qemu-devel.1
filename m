Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1833C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6171920753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP6EK2y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6171920753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFoZ-0000KX-Iz
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnO-00077z-9W
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnM-0002YG-MW
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnM-0002VH-Fv
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dc7FWNLlDobsDlH9JeStUvjewI5OlAbbrPKxq/N0uc=;
 b=RP6EK2y3dnjOdkLsQ8unVVWFtK9v9tptsoOUWs3iZ1aWOV7Gd+1wZkdoKEwzC5aPaqcgwQ
 bbPnKbQtWwNqhswalFUONUKGedbsxCmbzxnqEraaYnSXQomwkv/37bYfJDYKtTU3WTzvlw
 vlybmSWHx0uED8qcpUlzlJ1N0HNoOwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-YzhUEgbcPAG5pi1I8ryN6w-1; Sat, 11 Apr 2020 09:03:33 -0400
X-MC-Unique: YzhUEgbcPAG5pi1I8ryN6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2E268018A2;
 Sat, 11 Apr 2020 13:03:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FB909E0EC;
 Sat, 11 Apr 2020 13:03:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] piix: fix xenfv regression, add compat machine xenfv-4.2
Date: Sat, 11 Apr 2020 09:03:23 -0400
Message-Id: <20200411130330.1993-2-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Olaf Hering <olaf@aepfle.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Olaf Hering <olaf@aepfle.de>

With QEMU 4.0 an incompatible change was added to pc_piix, which makes it
practical impossible to migrate domUs started with qemu2 or qemu3 to
newer qemu versions. Commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea
added and enabled a new member "smbus_no_migration_support". In commit
4ab2f2a8aabfea95cc53c64e13b3f67960b27fdf the vmstate_acpi got new
elements, which are conditionally filled. As a result, an incoming
migration expected smbus related data unless smbus migration was
disabled for a given MachineClass. Since first commit forgot to handle
'xenfv', domUs started with QEMU 4.x are incompatible with their QEMU
siblings.

Using other existing machine types, such as 'pc-i440fx-3.1', is not
possible because 'xenfv' creates the 'xen-platform' PCI device at
00:02.0, while all other variants to run a domU would create it at
00:04.0.

To cover both the existing and the broken case of 'xenfv' in a single
qemu binary, a new compatibility variant of 'xenfv-4.2' must be added
which targets domUs started with qemu 4.2. The existing 'xenfv' restores
compatibility of QEMU 5.x with qemu 3.1.

Host admins who started domUs with QEMU 4.x (preferrable QEMU 4.2)
have to use a wrapper script which appends '-machine xenfv-4.2' to
the device-model command line.  This is only required if there is no
maintenance window which allows to temporary shutdown the domU and
restart it with a fixed device-model.

The wrapper script is as simple as this:
  #!/bin/sh
  exec /usr/bin/qemu-system-i386 "$@" -machine xenfv-4.2

With xl this script will be enabled with device_model_override=3D, see
xl.cfg(5). To live migrate a domU, adjust the existing domU.cfg and pass
it to xl migrate or xl save/restore:
  xl migrate -C new-domU.cfg domU remote-host
  xl save domU CheckpointFile new-domU.cfg
  xl restore new-domU.cfg CheckpointFile

With libvirt this script will be enabled with the <emulator> element in
domU.xml. Use 'virsh edit' prior 'virsh migrate' to replace the existing
<emulator> element to point it to the wrapper script.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Message-Id: <20200327151841.13877-1-olaf@aepfle.de>
[Adjust tests for blacklisted machine types, simplifying the one in
 qom-test. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c                    | 19 +++++++++++--
 tests/qtest/device-introspect-test.c |  2 +-
 tests/qtest/qom-test.c               | 42 ++++++----------------------
 tests/qtest/test-hmp.c               |  2 +-
 4 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9cceae3e2c..22dee0e76c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -948,13 +948,26 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
=20
=20
 #ifdef CONFIG_XEN
-static void xenfv_machine_options(MachineClass *m)
+static void xenfv_4_2_machine_options(MachineClass *m)
 {
+    pc_i440fx_4_2_machine_options(m);
+    m->desc =3D "Xen Fully-virtualized PC";
+    m->max_cpus =3D HVM_MAX_VCPUS;
+    m->default_machine_opts =3D "accel=3Dxen";
+}
+
+DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
+                  xenfv_4_2_machine_options);
+
+static void xenfv_3_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_3_1_machine_options(m);
     m->desc =3D "Xen Fully-virtualized PC";
+    m->alias =3D "xenfv";
     m->max_cpus =3D HVM_MAX_VCPUS;
     m->default_machine_opts =3D "accel=3Dxen";
 }
=20
-DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
-                  xenfv_machine_options);
+DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
+                  xenfv_3_1_machine_options);
 #endif
diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-intr=
ospect-test.c
index 04f22903b0..f2c1576cae 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -288,7 +288,7 @@ static void add_machine_test_case(const char *mname)
     char *path, *args;
=20
     /* Ignore blacklisted machines */
-    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
+    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
         return;
     }
=20
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 4f94cc678c..e338a41194 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -15,35 +15,6 @@
 #include "qemu/cutils.h"
 #include "libqtest.h"
=20
-static const char *blacklist_x86[] =3D {
-    "xenfv", "xenpv", NULL
-};
-
-static const struct {
-    const char *arch;
-    const char **machine;
-} blacklists[] =3D {
-    { "i386", blacklist_x86 },
-    { "x86_64", blacklist_x86 },
-};
-
-static bool is_blacklisted(const char *arch, const char *mach)
-{
-    int i;
-    const char **p;
-
-    for (i =3D 0; i < ARRAY_SIZE(blacklists); i++) {
-        if (!strcmp(blacklists[i].arch, arch)) {
-            for (p =3D blacklists[i].machine; *p; p++) {
-                if (!strcmp(*p, mach)) {
-                    return true;
-                }
-            }
-        }
-    }
-    return false;
-}
-
 static void test_properties(QTestState *qts, const char *path, bool recurs=
e)
 {
     char *child_path;
@@ -108,13 +79,16 @@ static void test_machine(gconstpointer data)
=20
 static void add_machine_test_case(const char *mname)
 {
-    const char *arch =3D qtest_get_arch();
+    char *path;
=20
-    if (!is_blacklisted(arch, mname)) {
-        char *path =3D g_strdup_printf("qom/%s", mname);
-        qtest_add_data_func(path, g_strdup(mname), test_machine);
-        g_free(path);
+    /* Ignore blacklisted machines that have known problems */
+    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
+        return;
     }
+
+    path =3D g_strdup_printf("qom/%s", mname);
+    qtest_add_data_func(path, g_strdup(mname), test_machine);
+    g_free(path);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index 5029c4d2c9..f8aa5f92c5 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -143,7 +143,7 @@ static void add_machine_test_case(const char *mname)
     char *path;
=20
     /* Ignore blacklisted machines that have known problems */
-    if (!strcmp("xenfv", mname) || !strcmp("xenpv", mname)) {
+    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
         return;
     }
=20
--=20
2.18.2



