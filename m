Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1100BC31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 20:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BD421852
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 20:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BD421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcEwS-0002Xt-Rd
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 16:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hcEvW-000261-UE
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 16:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hcEvW-0007eA-2g
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 16:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hcEvV-0007Eb-Ty
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 16:05:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 13E7981129;
 Sat, 15 Jun 2019 20:05:11 +0000 (UTC)
Received: from localhost (ovpn-116-100.phx2.redhat.com [10.3.116.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9002B7FD19;
 Sat, 15 Jun 2019 20:05:07 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:05:05 -0300
Message-Id: <20190615200505.31348-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sat, 15 Jun 2019 20:05:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] i386: Fix signedness of
 hyperv_spinlock_attempts
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current default value for hv-spinlocks is 0xFFFFFFFF (meaning
"never retry").  However, the value is stored as a signed
integer, making the getter of the hv-spinlocks QOM property
return -1 instead of 0xFFFFFFFF.

Fix this by changing the type of X86CPU::hyperv_spinlock_attempts
to uint32_t.  This has no visible effect to guest operating
systems, affecting just the behavior of the QOM getter.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0732e059ec..8158d0de73 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1372,7 +1372,7 @@ struct X86CPU {
 
     bool hyperv_vapic;
     bool hyperv_relaxed_timing;
-    int hyperv_spinlock_attempts;
+    uint32_t hyperv_spinlock_attempts;
     char *hyperv_vendor_id;
     bool hyperv_time;
     bool hyperv_crash;
-- 
2.18.0.rc1.1.g3f1ff2140


