Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F5DC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 11:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F2321734
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 11:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F2321734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLmyr-0001U0-Ca
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 07:00:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLmxG-0000Vi-JA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLmxC-0002lv-Q4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hLmxC-0002gQ-GL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:59:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AF96859FF
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 10:59:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-152.ams2.redhat.com
	[10.36.116.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9CDF7192A;
	Wed,  1 May 2019 10:59:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	crobinso@redhat.com
Date: Wed,  1 May 2019 11:59:04 +0100
Message-Id: <20190501105904.29907-3-dgilbert@redhat.com>
In-Reply-To: <20190501105904.29907-1-dgilbert@redhat.com>
References: <20190501105904.29907-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 01 May 2019 10:59:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] hmp: gva2gpa debug command
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501105904.wGERank1Z1AJ4O7mGAnCbLDqcCis3OE56YBQHhrv0dI@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a gva2gpa command purely for debug which performs
address translation on the gva, the existing gpa2hva
command can then also be used to find it in the qemu
userspace; e.g.

(qemu) info registers
.... RSP=3Dffffffff81c03e98
....
(qemu) gva2gpa 0xffffffff81c03e98
gpa: 0x1c03e98
(qemu) gpa2hva 0x1c03e98
Host virtual address for 0x1c03e98 (pc.ram) is 0x7f0599a03e98
(qemu) x/10x 0xffffffff81c03e98
ffffffff81c03e98: 0x81c03eb8 0xffffffff 0x8101ea3f 0xffffffff
ffffffff81c03ea8: 0x81d27b00 0xffffffff 0x00000000 0x00000000
ffffffff81c03eb8: 0x81c03ec8 0xffffffff

gdb -p ...qemu...
(gdb) x/10x 0x7f0599a03e98
0x7f0599a03e98:	0x81c03eb8	0xffffffff	0x8101ea3f	0xffffffff
0x7f0599a03ea8:	0x81d27b00	0xffffffff	0x00000000	0x00000000
0x7f0599a03eb8:	0x81c03ec8	0xffffffff

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190412152652.827-1-dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx  | 15 +++++++++++++++
 monitor.c        | 22 ++++++++++++++++++++++
 tests/test-hmp.c |  1 +
 3 files changed, 38 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 9b4035965c..a2c3ffc218 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -585,6 +585,21 @@ STEXI
 @findex gpa2hpa
 Print the host physical address at which the guest's physical address @v=
ar{addr}
 is mapped.
+ETEXI
+
+    {
+        .name       =3D "gva2gpa",
+        .args_type  =3D "addr:l",
+        .params     =3D "addr",
+        .help       =3D "print the guest physical address corresponding =
to a guest virtual address",
+        .cmd        =3D hmp_gva2gpa,
+    },
+
+STEXI
+@item gva2gpa @var{addr}
+@findex gva2gpa
+Print the guest physical address at which the guest's virtual address @v=
ar{addr}
+is mapped based on the mapping for the current CPU.
 ETEXI
=20
     {
diff --git a/monitor.c b/monitor.c
index 9b5f10b475..bb48997913 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1673,6 +1673,28 @@ static void hmp_gpa2hva(Monitor *mon, const QDict =
*qdict)
     memory_region_unref(mr);
 }
=20
+static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
+{
+    target_ulong addr =3D qdict_get_int(qdict, "addr");
+    MemTxAttrs attrs;
+    CPUState *cs =3D mon_get_cpu();
+    hwaddr gpa;
+
+    if (!cs) {
+        monitor_printf(mon, "No cpu\n");
+        return;
+    }
+
+    gpa  =3D cpu_get_phys_page_attrs_debug(mon_get_cpu(),
+                                         addr & TARGET_PAGE_MASK, &attrs=
);
+    if (gpa =3D=3D -1) {
+        monitor_printf(mon, "Unmapped\n");
+    } else {
+        monitor_printf(mon, "gpa: %#" HWADDR_PRIx "\n",
+                       gpa + (addr & ~TARGET_PAGE_MASK));
+    }
+}
+
 #ifdef CONFIG_LINUX
 static uint64_t vtop(void *ptr, Error **errp)
 {
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 54a01824dc..e344947f7c 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -39,6 +39,7 @@ static const char *hmp_cmds[] =3D {
     "dump-guest-memory /dev/null 0 4096",
     "dump-guest-memory /dev/null",
     "gdbserver",
+    "gva2gpa 0",
     "hostfwd_add tcp::43210-:43210",
     "hostfwd_remove tcp::43210-:43210",
     "i /w 0",
--=20
2.21.0


