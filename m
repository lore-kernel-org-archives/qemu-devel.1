Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7853C2BA16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7778B20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj9NnzU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7778B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5LT-0000nv-Me
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B3-0002Ym-H1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0000TF-Bl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0000Rj-7j
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zv8TTUduTZlk08NL96V82mVLPiq6S4mbqrii21algvw=;
 b=dj9NnzU39+hZ5v00hwh4BPPefloXoeHtkxdDp3yJpPOjEfJHrnZomKvpQcBGtaxKgGE2r2
 71FgOXHgIIWiLcVFpNCT1t2FbcRz7lOtt3+JHpUnSzQ10NDCNMNmVmhRUZ+klHgFghJY6e
 DkJVkhS3vVNqsUGAf5HBAbnPXiEjfD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-mL_1fTygOniWNvDSlg7XWQ-1; Thu, 02 Apr 2020 15:06:53 -0400
X-MC-Unique: mL_1fTygOniWNvDSlg7XWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2DF410509A0
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9890D50BEE;
 Thu,  2 Apr 2020 19:06:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] xen: fixup RAM memory region initialization
Date: Thu,  2 Apr 2020 15:06:40 -0400
Message-Id: <20200402190640.1693-16-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <20200402145418.5139-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.18.2


