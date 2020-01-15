Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F9FC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2A82077B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2A82077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irmnU-00082U-C5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1irmmm-0007We-Sd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1irmml-00055b-8i
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:48:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1irmml-0004w4-1Y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:48:55 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00FHlNfa005826
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 12:48:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xfaw1fe6c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 12:48:45 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 15 Jan 2020 17:48:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 15 Jan 2020 17:48:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00FHmdit24576252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2020 17:48:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AF44A4062;
 Wed, 15 Jan 2020 17:48:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E2B9A4054;
 Wed, 15 Jan 2020 17:48:38 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.1.176])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jan 2020 17:48:38 +0000 (GMT)
Subject: [PATCH] spapr: Migrate CAS reboot flag
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 15 Jan 2020 18:48:37 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
x-cbid: 20011517-0008-0000-0000-00000349A8EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011517-0009-0000-0000-00004A69FFDE
Message-Id: <157911051688.345768.16136592081655557565.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-15_02:2020-01-15,
 2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150136
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id 00FHlNfa005826
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>,
 qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Migration can potentially race with CAS reboot. If the migration thread
completes migration after CAS has set spapr->cas_reboot but before the
mainloop could pick up the reset request and reset the machine, the
guest is migrated unrebooted and the destination doesn't reboot it
either because it isn't aware a CAS reboot was needed (eg, because a
device was added before CAS). This likely result in a broken or hung
guest.

Even if it is small, the window between CAS and CAS reboot is enough to
re-qualify spapr->cas_reboot as state that we should migrate. Add a new
subsection for that and always send it when a CAS reboot is pending.
This may cause migration to older QEMUs to fail but it is still better
than end up with a broken guest.

The destination cannot honour the CAS reboot request from a post load
handler because this must be done after the guest is fully restored.
It is thus done from a VM change state handler.

Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This patch is supposed to fix the interrupt controller mode inconsistency
between QEMU and the guest reported in this BZ:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1781315 (requires auth)

Even if interrupt controller selection doesn't involve CAS reboot anymore=
,
we still have other conditions that require CAS reboot.
---
 hw/ppc/spapr.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30a5fbd3bea6..bf2763aa16e5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1959,6 +1959,31 @@ static const VMStateDescription vmstate_spapr_dtb =
=3D {
     },
 };
=20
+static bool spapr_cas_reboot_needed(void *opaque)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(opaque);
+
+    /*
+     * This causes the "spapr_cas_reboot" subsection to always be
+     * sent if migration raced with CAS. This causes older QEMUs
+     * that don't know about the subsection to fail migration but
+     * it is still better than end up with a broken guest on the
+     * destination.
+     */
+    return spapr->cas_reboot;
+}
+
+static const VMStateDescription vmstate_spapr_cas_reboot =3D {
+    .name =3D "spapr_cas_reboot",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D spapr_cas_reboot_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BOOL(cas_reboot, SpaprMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr =3D {
     .name =3D "spapr",
     .version_id =3D 3,
@@ -1992,6 +2017,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
+        &vmstate_spapr_cas_reboot,
         NULL
     }
 };
@@ -2577,6 +2603,21 @@ static PCIHostState *spapr_create_default_phb(void=
)
     return PCI_HOST_BRIDGE(dev);
 }
=20
+static void spapr_change_state_handler(void *opaque, int running,
+                                       RunState state)
+{
+    SpaprMachineState *spapr =3D opaque;
+
+    if (running && spapr->cas_reboot) {
+        /*
+         * This happens when resuming from migration if the source
+         * processed a CAS but didn't have time to trigger the CAS
+         * reboot. Do it now.
+         */
+        qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
+    }
+}
+
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
@@ -2970,6 +3011,8 @@ static void spapr_machine_init(MachineState *machin=
e)
=20
         kvmppc_spapr_enable_inkernel_multitce();
     }
+
+    qemu_add_vm_change_state_handler(spapr_change_state_handler, spapr);
 }
=20
 static int spapr_kvm_type(MachineState *machine, const char *vm_type)


