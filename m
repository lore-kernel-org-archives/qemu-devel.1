Received: from eggs.gnu.org ([209.51.188.92]:47380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk5VY-0001cZ-N9
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk5VY-0008O5-1n
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:06:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gk5VX-0008KD-NP
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:06:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HB5QM1084027
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 06:06:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2qqejaxh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 06:06:45 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 11:06:43 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 12:06:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154772319819.1163472.4313149332350138217.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] spapr: Forbid setting ic-mode for old machine
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Machine types 3.0 and older only know about the legacy XICS backend.
Make it clear by erroring out if the user tries to set ic-mode on
such machines.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

Motivation for this comes from a failing backward migration test, caused
by ic-mode=xics I forgot to drop from the command line :)
---
 hw/ppc/spapr.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0942f35bf87e..6b8dbf5c5a3c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3126,6 +3126,11 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
 
+    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        error_setg(errp, "This machine only uses the legacy XICS backend, don't pass ic-mode");
+        return;
+    }
+
     /* The legacy IRQ backend can not be set */
     if (strcmp(value, "xics") == 0) {
         spapr->irq = &spapr_irq_xics;
