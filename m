Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17064C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76262064B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9HIG4cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76262064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyywq-0005m5-3m
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyrl-0005Vl-99
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58244
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyri-0005mf-2e
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0pY6l2NcUPjzNdVuu6tmiaYmdIrhCRvNPv3Kqehsxk=;
 b=M9HIG4cwbFMPnPxEDPdNDr2NgZtd8nL4EwO92M4HqZGqYS1EfUpSmvLUGaiv1jZHAKaDKw
 a01eQt1tSNgPOHas+p9SlZYmBZ5iq1jnBf8aV6imxkqB2rbrZ4DJ4wqGuCRIW7BKQHJe0v
 JjCtlKl34Lzk4M3+7Txbs5y8dV2KyZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-b_3H0SpAMGCVxo4_fabGAg-1; Fri, 24 Jul 2020 10:38:22 -0400
X-MC-Unique: b_3H0SpAMGCVxo4_fabGAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82751800597;
 Fri, 24 Jul 2020 14:38:20 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38702710AC;
 Fri, 24 Jul 2020 14:38:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv3 6/9] s390x/diag: subcode to query device memory region
Date: Fri, 24 Jul 2020 16:37:47 +0200
Message-Id: <20200724143750.59836-7-david@redhat.com>
In-Reply-To: <20200724143750.59836-1-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A guest OS that is aware of memory devices (placed into the device
memory region located in guest physical address space) has to know at least
the end address of the device memory region during boot, for example, to
prepare the kernel virtual address space accordingly (e.g., select page
table hierarchy). The device memory region is located above the SCLP
maximum storage increment.

Let's provide a new diag500 subcode to query the location of the device
memory region under QEMU/KVM. This way, esp. Linux who's wants to support
virtio-based memory devices can query the location of this region and
derive the maximum possible PFN.

Let's use a specification exception in case no such memory region
exists (e.g., maxmem wasn't specified, or on old QEMU machines). We'll
unlock this with future patches that prepare and instanciate the device
memory region.

Memory managed by memory devices should never be detected and used
without having proper support for them in the guest (IOW, a driver that
detects and handles the devices). It's not exposed via other HW/firmware
interfaces (e.g., SCLP, diag260). In the near future, the focus is on
supporting virtio-based memory devices like vitio-mem. Other memory devices
are imaginable in the future (e.g., expose DIMMs via a KVM-specific
interface to s390x guests).

Note: We don't want to include the device memory region within the
SCLP-defined maximum storage increment, because especially older
guests will will sense (via tprot) accessible memory within this range.
If an unmodified guest would detect and use device memory, it could end
badly. The memory might have different semantics (e.g., a disk provided
via virtio-pmem a.k.a. DAX) and might require a handshake first (e.g.,
unplugged memory part of virtio-mem in some cases), before memory that
might look accessible can actually be used without surprises.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-hypercall.c | 18 ++++++++++++++++++
 hw/s390x/s390-hypercall.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index 20d4f6e159..ac21f4576e 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "hw/boards.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
@@ -44,6 +45,20 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t queue)
     return 0;
 }
 
+static void handle_device_memory_region(CPUS390XState *env, uintptr_t ra)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+
+    if (!machine->device_memory ||
+        !memory_region_size(&machine->device_memory->mr)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+    env->regs[2] = machine->device_memory->base;
+    env->regs[3] = machine->device_memory->base +
+                   memory_region_size(&machine->device_memory->mr) - 1;
+}
+
 void handle_diag_500(CPUS390XState *env, uintptr_t ra)
 {
      const uint64_t subcode = env->regs[1];
@@ -55,6 +70,9 @@ void handle_diag_500(CPUS390XState *env, uintptr_t ra)
      case DIAG500_VIRTIO_CCW_NOTIFY:
          env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
          break;
+     case DIAG500_DEVICE_MEMORY_REGION:
+        handle_device_memory_region(env, ra);
+        break;
      default:
          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
      }
diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
index e6b958db41..1b179d7d99 100644
--- a/hw/s390x/s390-hypercall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -16,6 +16,7 @@
 #define DIAG500_VIRTIO_RESET           1 /* legacy */
 #define DIAG500_VIRTIO_SET_STATUS      2 /* legacy */
 #define DIAG500_VIRTIO_CCW_NOTIFY      3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
+#define DIAG500_DEVICE_MEMORY_REGION   4
 
 void handle_diag_500(CPUS390XState *env, uintptr_t ra);
 #endif /* HW_S390_HYPERCALL_H */
-- 
2.26.2


