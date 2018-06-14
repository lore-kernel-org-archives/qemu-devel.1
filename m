Received: from eggs.gnu.org ([2001:4830:134:3::10]:47680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8i-0007Pj-1e
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8d-0002EU-9e
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:44 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:44585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTa8d-0002DK-2t
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:39 -0400
Received: from player718.ha.ovh.net (unknown [10.109.108.77])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 785EE164232
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:50:37 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Jun 2018 23:50:27 +0200
Message-ID: <152901302718.252222.18367624313137740494.stgit@bahia.lan>
In-Reply-To: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/5] spapr_cpu_core: fix potential leak in
 spapr_cpu_core_realize()
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

Commit 94ad93bd97684 (QEMU 2.12) switched to instantiate CPUs separately
but it missed to adapt the error path accordingly. If something fails in
the CPU creation loop, then the CPU object that was just created is leaked.

The error paths in this function are a bit obfuscated, and adding
yet another label to free this CPU object makes it worse. We should
move the block of the loop to a separate function, with a proper
rollback path, but this is a bigger cleanup.

For now, let's just fix the bug by adding the missing calls to
object_unref(). This will allow easier backport to older QEMU
versions.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 27602245fd55..003c4c5a79d2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -201,6 +201,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         cs->cpu_index = cc->core_id + i;
         spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
         if (local_err) {
+            object_unref(obj);
             goto err;
         }
 
@@ -212,6 +213,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
         g_free(id);
         if (local_err) {
+            object_unref(obj);
             goto err;
         }
         object_unref(obj);
