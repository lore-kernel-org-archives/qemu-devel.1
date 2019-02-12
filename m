Received: from eggs.gnu.org ([209.51.188.92]:39204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtckr-0002GV-4b
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtckn-00057z-Hk
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:26:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55906
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtckn-0004sb-B9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:25:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJYJ9100820
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:25:42 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qm14teu6q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:25:42 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:25:40 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:25:32 +0100
In-Reply-To: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154999593208.690774.9057564435432736364.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v4 15/15] spapr: enable PHB hotplug for default
 pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

The 'dr_phb_enabled' field of that class can be set as part of
machine-specific init code. It will be used to conditionally
enable creation of DRC objects and device-tree description to
facilitate hotplug of PHBs.

Since we can't migrate this state to older machine types,
default the option to true and disable it for older machine
types.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 06ce0babcb54..4a6b2f7f3f62 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4166,6 +4166,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_xics;
+    smc->dr_phb_enabled = true;
 }
 
 static const TypeInfo spapr_machine_info = {
@@ -4231,6 +4232,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled = false;
+    smc->dr_phb_enabled = false;
 }
 
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
