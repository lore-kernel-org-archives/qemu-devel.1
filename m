Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65243C47409
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC3A2468B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChgZD444"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC3A2468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuD3C-00024P-Rf
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuD2D-0001Fz-A7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuD2C-0001v4-63
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:14:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuD2C-0001uh-2Z
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579688091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZmX2jPilf71MNC5Ou1D5wX6NdOjL6s/916TdAgY+aR0=;
 b=ChgZD444lkk2eDAszgTapsholAOAFOtUqFvbhYponDl4nuJqgLSWvG/k8ztRfkaCdNaopD
 HjEzcE/x9kM5HGYBwFwwduq2GtPALeXN60GHBbKsllYHbj5vH5M/Oxp6vwt4yPzNINv6NA
 OQKeYBezF0PCpJeyS4RBwVopSVp9gs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-tN15L0DQPIOr4X905MzNZQ-1; Wed, 22 Jan 2020 05:14:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64711882CC0;
 Wed, 22 Jan 2020 10:14:46 +0000 (UTC)
Received: from thuth.com (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D95A45D9E2;
 Wed, 22 Jan 2020 10:14:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5] target/s390x/kvm: Enable adapter interruption suppression
 again
Date: Wed, 22 Jan 2020 11:14:37 +0100
Message-Id: <20200122101437.5069-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: tN15L0DQPIOr4X905MzNZQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AIS feature has been disabled late in the v2.10 development cycle since
there were some issues with migration (see commit 3f2d07b3b01ea61126b -
"s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
to enable it again for newer machine types, but apparently we forgot to do
this so far. Let's do it now for the machines that support proper CPU model=
s.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1756946
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v5: Use cpu_model_allowed() as suggested by David. Seems to work as far
     as I can test it without PCI cards, but ping-pong migration with
     "-cpu host" from/to an older version of QEMU is now not working
     anymore - but I think that's kind of expected since "-cpu host"
     is not migration-safe anyway.

 target/s390x/kvm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15260aeb9a..30112e529c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /*
      * The migration interface for ais was introduced with kernel 4.13
      * but the capability itself had been active since 4.12. As migration
-     * support is considered necessary let's disable ais in the 2.10
-     * machine.
+     * support is considered necessary, we only try to enable this for
+     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
      */
-    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
+    if (cpu_model_allowed() && kvm_kernel_irqchip_allowed() &&
+        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
+        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+    }
=20
     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
     return 0;
--=20
2.18.1


