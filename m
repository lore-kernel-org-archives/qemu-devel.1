Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC62DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB2A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfnH1kYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB2A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxPg-00055Q-Qy
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHS-0003On-JX
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHQ-0003nM-O4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHQ-0003kq-EA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iK3jlJnz8NlA8NS0Z2nedDU+tQW241PC1gri39nFTGE=;
 b=TfnH1kYEvByqRxZln/t4Z6yYz0oKRB4MzQvoaBKXXU4CJw+dGotEmH2wizhh/UiR98Y/cV
 QSzuo67T2rhKgNBjSV1uwT5n8tbjct9bxYyhhk/ygHFrFUIvmocyi4hTusvqF/t3D1S52V
 CRPQ7uJnOh86+fsRbYBjUa0uICHItiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-9Xnr5G9APWuw-SMByjvGTg-1; Mon, 16 Mar 2020 17:28:09 -0400
X-MC-Unique: 9Xnr5G9APWuw-SMByjvGTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F240800D50;
 Mon, 16 Mar 2020 21:28:08 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8A2E19C4F;
 Mon, 16 Mar 2020 21:28:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/61] i386: Fix GCC warning with snprintf when HAX is enabled
Date: Mon, 16 Mar 2020 22:26:48 +0100
Message-Id: <1584394048-44994-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Julio Faracco <jcfaracco@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julio Faracco <jcfaracco@gmail.com>

When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
snprintf(). Replacing old snprintf() by g_strdup_printf() fixes the
problem with boundary checks of vm_id and vcpu_id and finally the
warnings produced by GCC.

For more details, one example of warning:
  CC      i386-softmmu/target/i386/hax-posix.o
qemu/target/i386/hax-posix.c: In function =E2=80=98hax_host_open_vm=E2=80=
=99:
qemu/target/i386/hax-posix.c:124:56: error: =E2=80=98%02d=E2=80=99 directiv=
e output may be
truncated writing between 2 and 11 bytes into a region of size 3
[-Werror=3Dformat-truncation=3D]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id=
);
      |                                                        ^~~~
qemu/target/i386/hax-posix.c:124:41: note: directive argument in the range
[-2147483648, 64]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id=
);
      |                                         ^~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:867,
                 from qemu/include/qemu/osdep.h:99,
                 from qemu/target/i386/hax-posix.c:14:
/usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output
between 17 and 26 bytes into a destination of size 17
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - =
1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-posix.c   | 33 ++-------------------------------
 target/i386/hax-windows.c | 33 ++-------------------------------
 2 files changed, 4 insertions(+), 62 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6..3bad89f 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -108,41 +108,12 @@ int hax_mod_version(struct hax_state *hax, struct hax=
_module_version *version)
=20
 static char *hax_vm_devfs_string(int vm_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID) {
-        fprintf(stderr, "Too big VM id\n");
-        return NULL;
-    }
-
-#define HAX_VM_DEVFS "/dev/hax_vm/vmxx"
-    name =3D g_strdup(HAX_VM_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
 }
=20
 static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
-        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id=
);
-        return NULL;
-    }
-
-#define HAX_VCPU_DEVFS "/dev/hax_vmxx/vcpuxx"
-    name =3D g_strdup(HAX_VCPU_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
-             vm_id, vcpu_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
 }
=20
 int hax_host_create_vm(struct hax_state *hax, int *vmid)
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
index 5729ad9..0ba488c 100644
--- a/target/i386/hax-windows.c
+++ b/target/i386/hax-windows.c
@@ -185,41 +185,12 @@ int hax_mod_version(struct hax_state *hax, struct hax=
_module_version *version)
=20
 static char *hax_vm_devfs_string(int vm_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID) {
-        fprintf(stderr, "Too big VM id\n");
-        return NULL;
-    }
-
-#define HAX_VM_DEVFS "\\\\.\\hax_vmxx"
-    name =3D g_strdup(HAX_VM_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VM_DEVFS, "\\\\.\\hax_vm%02d", vm_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm/vm%02d", vm_id);
 }
=20
 static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
 {
-    char *name;
-
-    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
-        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id=
);
-        return NULL;
-    }
-
-#define HAX_VCPU_DEVFS "\\\\.\\hax_vmxx_vcpuxx"
-    name =3D g_strdup(HAX_VCPU_DEVFS);
-    if (!name) {
-        return NULL;
-    }
-
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "\\\\.\\hax_vm%02d_vcpu%02d",
-             vm_id, vcpu_id);
-    return name;
+    return g_strdup_printf("/dev/hax_vm%02d/vcpu%02d", vm_id, vcpu_id);
 }
=20
 int hax_host_create_vm(struct hax_state *hax, int *vmid)
--=20
1.8.3.1



