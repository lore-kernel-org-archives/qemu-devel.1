Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8pW-0007Dd-Fp
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ga8pT-0000JT-4j
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:38:18 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:37919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ga8pS-0000Gr-TI
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 19:38:15 -0500
Received: from player687.ha.ovh.net (unknown [10.109.146.175])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id A6CEB14B541
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 01:38:13 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 01:37:57 +0100
Message-ID: <154535267737.862554.5615504074002076384.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 10/15] spapr_events: add support for phb
 hotplug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Extend the existing EPOW event format we use for PCI
devices to emit PHB plug/unplug events.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_events.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 32719a1b72d0..baf30c55710a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
         hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_CPU;
         break;
+    case SPAPR_DR_CONNECTOR_TYPE_PHB:
+        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
+        break;
     default:
         /* we shouldn't be signaling hotplug events for resources
          * that don't support them
