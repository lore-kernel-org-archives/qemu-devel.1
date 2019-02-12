Received: from eggs.gnu.org ([209.51.188.92]:38265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcjR-0000qA-JD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtcjM-0003Fg-SN
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51500
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtcjC-000362-RQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:24:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CIJcCU095165
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:16 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm0rsyw6g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:24:16 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 12 Feb 2019 18:24:14 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Feb 2019 19:24:06 +0100
In-Reply-To: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <154999584656.690774.18352404495120358613.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/15] xive: Only set source type for LSIs
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

MSI is the default and LSI specific code is guarded by the
xive_source_irq_is_lsi() helper. The xive_source_irq_set()
helper is a nop for MSIs.

Simplify the code by turning xive_source_irq_set() into
xive_source_irq_set_lsi() and only call it for LSIs. The
call to xive_source_irq_set(false) in spapr_xive_irq_free()
is also a nop. Just drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c  |    7 +++----
 include/hw/ppc/xive.h |    7 ++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a0f5ff929447..290a290e43a5 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -489,20 +489,19 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t=
 lisn, bool lsi)
     }
=20
     xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID);
-    xive_source_irq_set(xsrc, lisn, lsi);
+    if (lsi) {
+        xive_source_irq_set_lsi(xsrc, lisn);
+    }
     return true;
 }
=20
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn)
 {
-    XiveSource *xsrc =3D &xive->source;
-
     if (lisn >=3D xive->nr_irqs) {
         return false;
     }
=20
     xive->eat[lisn].w &=3D cpu_to_be64(~EAS_VALID);
-    xive_source_irq_set(xsrc, lisn, false);
     return true;
 }
=20
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ec3bb2aae45a..13a487527b11 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -283,13 +283,10 @@ static inline bool xive_source_irq_is_lsi(XiveSourc=
e *xsrc, uint32_t srcno)
     return test_bit(srcno, xsrc->lsi_map);
 }
=20
-static inline void xive_source_irq_set(XiveSource *xsrc, uint32_t srcno,
-                                       bool lsi)
+static inline void xive_source_irq_set_lsi(XiveSource *xsrc, uint32_t sr=
cno)
 {
     assert(srcno < xsrc->nr_irqs);
-    if (lsi) {
-        bitmap_set(xsrc->lsi_map, srcno, 1);
-    }
+    bitmap_set(xsrc->lsi_map, srcno, 1);
 }
=20
 void xive_source_set_irq(void *opaque, int srcno, int val);
