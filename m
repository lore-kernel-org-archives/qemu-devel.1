Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E6CC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 20:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFCC208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 20:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFCC208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42583 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVj33-0002PG-If
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 16:50:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVj1d-0001i5-0H
	for qemu-devel@nongnu.org; Tue, 28 May 2019 16:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVj1b-0008ER-UF
	for qemu-devel@nongnu.org; Tue, 28 May 2019 16:48:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVj1b-0008CQ-MB
	for qemu-devel@nongnu.org; Tue, 28 May 2019 16:48:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A14513E2B9;
	Tue, 28 May 2019 20:48:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65EF560C47;
	Tue, 28 May 2019 20:48:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3E5AF16E1A; Tue, 28 May 2019 22:48:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 22:48:38 +0200
Message-Id: <20190528204838.21568-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 28 May 2019 20:48:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] q35: split memory at 2G
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Original q35 behavior was to split memory 2.75 GB, leaving space for the
mmconfig bar at 0xb000000 and pci I/O window starting at 0xc0000000.

Note: Those machine types have been removed from the qemu codebase
meanwhile because they could not be live-migrated so there was little
value in keeping them around.

With the effort to allow for gigabyte-alignment of guest memory that
behavior was changed:  The split was moved to 2G, but only in case the
memory didn't fit below 2.75 GB.

So today the address space between 2G and 2,75G is not used for guest
memory in typical use cases, where the guest memory sized at a power of
two or a gigabyte number.  But if you configure your guest with some odd
amout of memory (such as 2.5G) the address space is used.

This patch removes that oddity for 4.1+ machine types.  The memory is
splitted at 2G no matter what.

Cc: L=C3=A1szl=C3=B3 =C3=89rsek <lersek@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 1 +
 hw/i386/pc_q35.c     | 7 ++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 43df7230a22b..d88179a3b21e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -120,6 +120,7 @@ typedef struct PCMachineClass {
=20
     /* RAM / address space compat: */
     bool gigabyte_align;
+    bool gigabyte_split;
     bool has_reserved_memory;
     bool enforce_aligned_dimm;
     bool broken_reserved_end;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2632b73f800b..828eeb36e398 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2719,6 +2719,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     pcmc->smbios_defaults =3D true;
     pcmc->smbios_uuid_encoded =3D true;
     pcmc->gigabyte_align =3D true;
+    pcmc->gigabyte_split =3D true;
     pcmc->has_reserved_memory =3D true;
     pcmc->kvmclock_enabled =3D true;
     pcmc->enforce_aligned_dimm =3D true;
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37dd350511a9..266671a9d544 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -143,8 +143,10 @@ static void pc_q35_init(MachineState *machine)
      * If it doesn't, we need to split it in chunks below and above 4G.
      * In any case, try to make sure that guest addresses aligned at
      * 1G boundaries get mapped to host addresses aligned at 1G boundari=
es.
+     *
+     * qemu 4.1+ machines: split at 2G unconditionally (gigabyte_split =3D=
 true)
      */
-    if (machine->ram_size >=3D 0xb0000000) {
+    if (machine->ram_size >=3D 0xb0000000 || pcmc->gigabyte_split) {
         lowmem =3D 0x80000000;
     } else {
         lowmem =3D 0xb0000000;
@@ -376,8 +378,11 @@ DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
=20
 static void pc_q35_4_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
+
     pc_q35_4_1_machine_options(m);
     m->alias =3D NULL;
+    pcmc->gigabyte_split =3D false;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
--=20
2.18.1


