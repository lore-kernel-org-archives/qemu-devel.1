Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FE0C3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17AF2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17AF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GVM-0003AT-SF
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5Fwj-0004Ua-OF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5Fwi-0001UQ-IG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5Fwi-0001U3-DC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B088510C6352;
 Tue,  3 Sep 2019 21:02:35 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 485D11001956;
 Tue,  3 Sep 2019 21:02:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:02:01 -0300
Message-Id: <20190903210201.14627-14-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 03 Sep 2019 21:02:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 13/13] migration: Do not re-read the clock on
 pre_save in case of paused guest
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>

The clock move makes the guest knows about the paused time between the
'stop' and 'migrate' commands. This is an issue in an already-paused
VM because some side effects, like process stalls, could happen
after migration.

So, this patch checks the runstate of guest in the pre_save handler and
do not re-reads the clock in case of paused state (cold migration).

Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
Message-Id: <20190829210711.6570-1-maxiwell@linux.ibm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/kvm/clock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 80c133a724..2c59b6894b 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -41,6 +41,9 @@ typedef struct KVMClockState {
     uint64_t clock;
     bool clock_valid;
=20
+    /* whether the 'clock' value was obtained in the 'paused' state */
+    bool runstate_paused;
+
     /* whether machine type supports reliable KVM_GET_CLOCK */
     bool mach_use_reliable_get_clock;
=20
@@ -202,6 +205,8 @@ static void kvmclock_vm_state_change(void *opaque, in=
t running,
             return;
         }
=20
+        s->runstate_paused =3D runstate_check(RUN_STATE_PAUSED);
+
         kvm_synchronize_all_tsc();
=20
         kvm_update_clock(s);
@@ -260,9 +265,9 @@ static int kvmclock_pre_load(void *opaque)
 }
=20
 /*
- * When migrating, read the clock just before migration,
- * so that the guest clock counts during the events
- * between:
+ * When migrating a running guest, read the clock just
+ * before migration, so that the guest clock counts
+ * during the events between:
  *
  *  * vm_stop()
  *  *
@@ -277,7 +282,9 @@ static int kvmclock_pre_save(void *opaque)
 {
     KVMClockState *s =3D opaque;
=20
-    kvm_update_clock(s);
+    if (!s->runstate_paused) {
+        kvm_update_clock(s);
+    }
=20
     return 0;
 }
--=20
2.21.0


