Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC103C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B6C205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B6C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAw3I-0008Oz-CE
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAvsL-0006Le-L9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAvmU-0002GF-F2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 08:43:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAvmU-0002FT-7L; Thu, 19 Sep 2019 08:43:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 859CC20EB;
 Thu, 19 Sep 2019 12:43:29 +0000 (UTC)
Received: from localhost (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3234B5D6B0;
 Thu, 19 Sep 2019 12:43:29 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 14:41:14 +0200
Message-Id: <20190919124115.11510-34-cohuck@redhat.com>
In-Reply-To: <20190919124115.11510-1-cohuck@redhat.com>
References: <20190919124115.11510-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 19 Sep 2019 12:43:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 33/34] s390x/kvm: Officially require at least
 kernel 3.15
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Since QEMU v2.10, the KVM acceleration does not work on older kernels
anymore since the code accidentally requires the KVM_CAP_DEVICE_CTRL
capability now - it should have been optional instead.
Instead of fixing the bug, we asked in the ChangeLog of QEMU 2.11 - 3.0
that people should speak up if they still need support of QEMU running
with KVM on older kernels, but seems like nobody really complained.
Thus let's make this official now and turn it into a proper error
message, telling the users to use at least kernel 3.15 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190913091443.27565-1-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/s390_flic_kvm.c | 6 ------
 hw/intc/trace-events    | 1 -
 target/s390x/kvm.c      | 7 +++++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 819aa5e198b7..cedccba8a9c7 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -589,12 +589,6 @@ static void kvm_s390_flic_realize(DeviceState *dev, =
Error **errp)
         goto fail;
     }
     flic_state->fd =3D -1;
-    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
-        error_setg_errno(&errp_local, errno, "KVM is missing capability"
-                         " KVM_CAP_DEVICE_CTRL");
-        trace_flic_no_device_api(errno);
-        goto fail;
-    }
=20
     cd.type =3D KVM_DEV_TYPE_FLIC;
     ret =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 90c9d07c1a66..719f46b51628 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -75,7 +75,6 @@ xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
=20
 # s390_flic_kvm.c
 flic_create_device(int err) "flic: create device failed %d"
-flic_no_device_api(int err) "flic: no Device Contral API support %d"
 flic_reset_failed(int err) "flic: reset failed %d"
=20
 # s390_flic.c
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index cea71ac7c3dd..97a662ad0ebf 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -316,6 +316,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
=20
     mc->default_cpu_type =3D S390_CPU_TYPE_NAME("host");
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
+        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
+                     "please use kernel 3.15 or newer");
+        return -1;
+    }
+
     cap_sync_regs =3D kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf =3D kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op =3D kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
--=20
2.20.1


