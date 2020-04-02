Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD7C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E884206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+WeZ85u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E884206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1MU-0000Wz-4T
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jK1El-0004qu-G6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jK1Ek-0001Sf-EG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:54:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jK1Ek-0001ST-AM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585839270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pAWLrBkCg471xZMC4vYlRsSQX3KPz345VQNtx7UC/ns=;
 b=H+WeZ85uNQW6AKdpNSAMBmbJABA9XDtQfw6CdMrCStTWHE/MJua0vAX04mYTGctKXPHT22
 BEgDo+l6SwYeAcyQ18l3ltene5gBZXaiK7K6FBHHoC/a6pfzKVmnaQAtQs+vxr0BIBruOT
 NE1NdHWAO06NbCdEvJ4YDq97nUTWexM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-H4YGWISwPP2iFwxJrcAaNg-1; Thu, 02 Apr 2020 10:54:28 -0400
X-MC-Unique: H4YGWISwPP2iFwxJrcAaNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 475A6101FC72;
 Thu,  2 Apr 2020 14:54:26 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7F2E5C290;
 Thu,  2 Apr 2020 14:54:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2] xen: fixup RAM memory region initialization
Date: Thu,  2 Apr 2020 10:54:18 -0400
Message-Id: <20200402145418.5139-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 anthony.perard@citrix.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since bd457782b3b0 ("x86/pc: use memdev for RAM") Xen
machine fails to start with:
   qemu-system-i386: xen: failed to populate ram at 0

The reason is that xen_ram_alloc() which is called by
memory_region_init_ram(), compares memory region with
statically allocated 'global' ram_memory memory region
that it uses for RAM, and does nothing in case it matches.

While it's possible feed machine->ram to xen_ram_alloc()
in the same manner to keep that hack working, I'd prefer
not to keep that circular dependency and try to untangle that.

However it doesn't look trivial to fix, so as temporary
fixup opt out Xen machine from memdev based RAM allocation,
and let xen_ram_alloc() do its trick for now.

Reported-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * make it work with -M pc,accel=3Dxen
---
 hw/xen/xen-common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 15650d7f6a..a15070f7f6 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -19,6 +19,7 @@
 #include "sysemu/runstate.h"
 #include "migration/misc.h"
 #include "migration/global_state.h"
+#include "hw/boards.h"
=20
 //#define DEBUG_XEN
=20
@@ -151,6 +152,8 @@ static void xen_setup_post(MachineState *ms, AccelState=
 *accel)
=20
 static int xen_init(MachineState *ms)
 {
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+
     xen_xc =3D xc_interface_open(0, 0, 0);
     if (xen_xc =3D=3D NULL) {
         xen_pv_printf(NULL, 0, "can't open xen interface\n");
@@ -170,6 +173,10 @@ static int xen_init(MachineState *ms)
         return -1;
     }
     qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
+    /*
+     * opt out of system RAM being allocated by generic code
+     */
+    mc->default_ram_id =3D NULL;
     return 0;
 }
=20
--=20
2.18.1


