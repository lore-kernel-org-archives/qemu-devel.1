Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FCDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5F720718
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRaHiKTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5F720718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilq0H-00086m-59
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 03:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1ilpzB-0007eh-EY
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1ilpz7-0007iZ-UO
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:01:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1ilpz7-0007gF-DE
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577692860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DFsXrrEcXz9vewV5XFGc65CgWwVQp6gjwXt42kqeX+M=;
 b=LRaHiKTGQEj9HL6y3XRFB9Miay3nhZLZiJrbbmqlkqAJv0HiNBG/otqKkyz6XqYb8zbgF/
 rpLz3pzEuYCA8741OstE+UbQ5qzBbDC1Gag34F9UgcyE5mR635GaJMFdiOPrE3QA6FF0S7
 T5Ag0QBPcwLQdCBX0LupkvZhY4IpHQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-O4Ab7nbbOX-Q8Fb5NhPqFA-1; Mon, 30 Dec 2019 03:00:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 573ED10054E3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 08:00:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7166E10001BD;
 Mon, 30 Dec 2019 08:00:57 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] x86: Check for machine state object class before typecasting
 it
Date: Mon, 30 Dec 2019 09:00:51 +0100
Message-Id: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: O4Ab7nbbOX-Q8Fb5NhPqFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v4.2.0-246-ged9e923c3c the SMM property was moved from PC
machine class to x86 machine class. Makes sense, but the change
was too aggressive: in target/i386/kvm.c:kvm_arch_init() it
altered check which sets SMRAM if given machine has SMM enabled.
The line that detects whether given machine object is class of
PC_MACHINE was removed from the check. This makes qemu try to
enable SMRAM for all machine types, which is not what we want.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 target/i386/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b511906e3..7ee3202634 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2173,6 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
=20
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
         x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
         smram_machine_done.notify =3D register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
--=20
2.24.1


