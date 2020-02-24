Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E16C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B50520661
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 06:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B50520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j67MO-00059W-6X
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 01:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j67Lp-0004hY-1d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j67Ln-0003n7-P2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 01:36:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2726 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j67Ln-0003fO-Cu; Mon, 24 Feb 2020 01:36:19 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id DF75691D35F7E514D6B0;
 Mon, 24 Feb 2020 14:36:12 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 14:36:03 +0800
From: <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH] target/i386/hax-posix: fix two 'format-truncation' compile
 warnings
Date: Mon, 24 Feb 2020 14:51:39 +0800
Message-ID: <20200224065139.19567-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: qemu-trivial@nongnu.org, euler.robot@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Fix compile warnings:
/mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:124:56: error: =E2=
=80=98%02d=E2=80=99 directive output may be truncated writing between 2 a=
nd 11 bytes into a region of size 3 [-Werror=3Dformat-truncation=3D]
     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
                                                        ^~~~
/mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:124:41: note: di=
rective argument in the range [-2147483648, 64]
     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
                                         ^~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:873,
                 from /mnt/sdb/qemu-new/qemu_test/qemu/include/qemu/osdep=
.h:99,
                 from /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-po=
six.c:14:
/usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 17 and 26 bytes into a destination of size 17
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c: In function =E2=
=80=98hax_vcpu_devfs_string=E2=80=99:
/mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:143:55: error: =E2=
=80=98%02d=E2=80=99 directive output may be truncated writing between 2 a=
nd 11 bytes into a region of size 10 [-Werror=3Dformat-truncation=3D]
     snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
                                                       ^~~~
/mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:143:43: note: di=
rective argument in the range [-2147483648, 64]
     snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-posix.c:143:43: note: di=
rective argument in the range [-2147483648, 64]
In file included from /usr/include/stdio.h:873,
                 from /mnt/sdb/qemu-new/qemu_test/qemu/include/qemu/osdep=
.h:99,
                 from /mnt/sdb/qemu-new/qemu_test/qemu/target/i386/hax-po=
six.c:14:
/usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 21 and 39 bytes into a destination of size 21
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());

We know that we have checked the vm_id and vcpu_id in the first(less than=
 0x40), it will never be truncated in snprintf().
Thus, this patch add an assertion to clear this false-positive warning.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 target/i386/hax-posix.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6dac..197d5bc0f9 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -121,7 +121,8 @@ static char *hax_vm_devfs_string(int vm_id)
         return NULL;
     }
=20
-    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
+    int len =3D snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d"=
, vm_id);
+    assert(len < sizeof HAX_VM_DEVFS);
     return name;
 }
=20
@@ -140,8 +141,9 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcp=
u_id)
         return NULL;
     }
=20
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
-             vm_id, vcpu_id);
+    int len =3D snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/v=
cpu%02d",
+                       vm_id, vcpu_id);
+    assert(len < sizeof HAX_VCPU_DEVFS);
     return name;
 }
=20
--=20
2.18.2


