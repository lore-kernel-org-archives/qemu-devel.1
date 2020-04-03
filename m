Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0E3C2BA17
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FD32073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Otjps1yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FD32073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIbe-00062B-MH
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jKIae-0004rf-6c
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jKIab-0006yL-56
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jKIaa-0006nd-OH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585905970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MJrInjcqnlYIwv20Jnuxn5ydN1pIWkoxPK9dZZmZFA=;
 b=Otjps1ygH40H9zNLrA0dnH23INzPCbx19yCxPdyxFh129GGsSCgEzT9oU8+Qp9ohdpGPFG
 4woN6NeB4QaVcvyANWz2OlZ4NPSkFKkEcoliwHxKFqPj/TBDR8yHEoN/q5IhQitjruietN
 8xCgrI3W8sNa8/7K4fVoT2Ko2G2XRGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-S4VAPAJrNniS4D74a788Tw-1; Fri, 03 Apr 2020 05:26:05 -0400
X-MC-Unique: S4VAPAJrNniS4D74a788Tw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83EC980257D;
 Fri,  3 Apr 2020 09:26:04 +0000 (UTC)
Received: from localhost (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C17260BF1;
 Fri,  3 Apr 2020 09:26:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.0 1/2] s390x: kvm: Fix number of cpu reports for stsi
 3.2.2
Date: Fri,  3 Apr 2020 11:25:52 +0200
Message-Id: <20200403092553.25803-2-cohuck@redhat.com>
In-Reply-To: <20200403092553.25803-1-cohuck@redhat.com>
References: <20200403092553.25803-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

The cpu number reporting is handled by KVM and QEMU only fills in the
VM name, uuid and other values.

Unfortunately KVM doesn't report reserved cpus and doesn't even know
they exist until the are created via the ioctl.

So let's fix up the cpu values after KVM has written its values to the
3.2.2 sysib. To be consistent, we use the same code to retrieve the cpu
numbers as the STSI TCG code in target/s390x/misc_helper.c:HELPER(stsi).

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200331110123.3774-1-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1d6fd6a27b48..7f7ebab84279 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1768,8 +1768,10 @@ static int handle_tsch(S390CPU *cpu)
=20
 static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
 {
+    const MachineState *ms =3D MACHINE(qdev_get_machine());
+    uint16_t conf_cpus =3D 0, reserved_cpus =3D 0;
     SysIB_322 sysib;
-    int del;
+    int del, i;
=20
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
         return;
@@ -1789,6 +1791,19 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 ad=
dr, uint8_t ar)
         memset(sysib.ext_names[del], 0,
                sizeof(sysib.ext_names[0]) * (sysib.count - del));
     }
+
+    /* count the cpus and split them into configured and reserved ones */
+    for (i =3D 0; i < ms->possible_cpus->len; i++) {
+        if (ms->possible_cpus->cpus[i].cpu) {
+            conf_cpus++;
+        } else {
+            reserved_cpus++;
+        }
+    }
+    sysib.vm[0].total_cpus =3D conf_cpus + reserved_cpus;
+    sysib.vm[0].conf_cpus =3D conf_cpus;
+    sysib.vm[0].reserved_cpus =3D reserved_cpus;
+
     /* Insert short machine name in EBCDIC, padded with blanks */
     if (qemu_name) {
         memset(sysib.vm[0].name, 0x40, sizeof(sysib.vm[0].name));
--=20
2.21.1


