Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34108C73C42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0896021537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 12:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0896021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkpOG-0005vI-6P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 08:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hkpKs-0003ud-DC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hkpKp-0005no-JW
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 08:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hkpKl-0005ip-Iz; Tue, 09 Jul 2019 08:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 942B281F25;
 Tue,  9 Jul 2019 12:26:00 +0000 (UTC)
Received: from localhost (unknown [10.40.205.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23CDA831C3;
 Tue,  9 Jul 2019 12:25:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Jul 2019 14:25:44 +0200
Message-Id: <20190709122546.12373-3-cohuck@redhat.com>
In-Reply-To: <20190709122546.12373-1-cohuck@redhat.com>
References: <20190709122546.12373-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 09 Jul 2019 12:26:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 2/4] s390x/cpumodel: Set up CPU model
 for AQIC interception
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pierre Morel <pmorel@linux.ibm.com>

Let's add support for the AP-Queue interruption facility to the CPU
model.

The S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, CPU facility indicates
whether the PQAP instruction with the AQIC command is available
to the guest.
This feature will be enabled only if the AP instructions are
available on the linux host and AQIC facility is installed on
the host.

This feature must be turned on from userspace to intercept AP
instructions on the KVM guest. The QEMU command line to turn
this feature on looks something like this:

    qemu-system-s390x ... -cpu xxx,apqi=3Don ...
or
    ... -cpu host

Right now AP pass-through devices do not support migration,
which means that we do not have to take care of migrating
the interrupt data:
virsh migrate apguest --live qemu+ssh://root@target.lan/system
error: Requested operation is not valid: domain has assigned non-USB host=
 devices

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[rebase to newest qemu and fixup description]
Message-Id: <20190705153249.12525-1-borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features_def.inc.h | 1 +
 target/s390x/cpu_models.c           | 1 +
 target/s390x/gen-features.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
index c20c780f2ea7..ef190e2fc783 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -77,6 +77,7 @@ DEF_FEAT(SEMAPHORE_ASSIST, "sema", STFL, 59, "Semaphore=
-assist facility")
 DEF_FEAT(TIME_SLICE_INSTRUMENTATION, "tsi", STFL, 60, "Time-slice Instru=
mentation facility")
 DEF_FEAT(MISC_INSTRUCTION_EXT3, "minste3", STFL, 61, "Miscellaneous-Inst=
ruction-Extensions Facility 3")
 DEF_FEAT(RUNTIME_INSTRUMENTATION, "ri", STFL, 64, "CPU runtime-instrumen=
tation facility")
+DEF_FEAT(AP_QUEUE_INTERRUPT_CONTROL, "apqi", STFL, 65, "AP-Queue interru=
ption facility")
 DEF_FEAT(ZPCI, "zpci", STFL, 69, "z/PCI facility")
 DEF_FEAT(ADAPTER_EVENT_NOTIFICATION, "aen", STFL, 71, "General-purpose-a=
dapter-event-notification facility")
 DEF_FEAT(ADAPTER_INT_SUPPRESSION, "ais", STFL, 72, "General-purpose-adap=
ter-interruption-suppression facility")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2cb09c078055..1d16d7d5e794 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -818,6 +818,7 @@ static void check_consistency(const S390CPUModel *mod=
el)
         { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
+        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
     };
     int i;
=20
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index af06be3e3b98..9f216219ff53 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -519,6 +519,7 @@ static uint16_t full_GEN12_GA1[] =3D {
     S390_FEAT_EDAT_2,
     S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
     S390_FEAT_AP_QUERY_CONFIG_INFO,
+    S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
 };
--=20
2.20.1


