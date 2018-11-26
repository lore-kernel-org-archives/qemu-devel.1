Received: from eggs.gnu.org ([2001:4830:134:3::10]:41278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRPnz-00054h-4E
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gRPnp-0004U3-J5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gRPnp-0004Te-E5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:56:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 583A0308AA13
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 22:56:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 26 Nov 2018 20:56:20 -0200
Message-Id: <20181126225620.5301-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] apic: Make APIC ID limit error message clearer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Remove the "apic initialization failed" prefix (it conveys no
useful information), replace "invalid" with "too large", and add
an error hint with two possible solutions for the problem.

Before:

  $ qemu-system-x86_64 -machine q35 -smp 256
  qemu-system-x86_64: apic initialization failed. APIC ID 255 is invalid

After:

  $ qemu-system-x86_64 -machine q35 -smp 256 -display none
  qemu-system-x86_64: APIC ID 255 is too large
  Possible solutions:
  * Lowering the number of VCPUs on the -smp option
  * Using accel=kvm,kernel-irqchip=on or accel=kvm,kernel-irqchip=split

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
I'm not sure this is the best way to provide usage hints to the
user.  Any suggestions?
---
 hw/intc/apic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 97ffdd820f..f08006334d 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -886,8 +886,11 @@ static void apic_realize(DeviceState *dev, Error **errp)
     APICCommonState *s = APIC(dev);
 
     if (s->id >= MAX_APICS) {
-        error_setg(errp, "%s initialization failed. APIC ID %d is invalid",
-                   object_get_typename(OBJECT(dev)), s->id);
+        error_setg(errp, "APIC ID %d is too large", s->id);
+        error_append_hint(errp,
+            "Possible solutions:\n"
+            "* Lowering the number of VCPUs on the -smp option\n"
+            "* Using accel=kvm,kernel-irqchip=on or accel=kvm,kernel-irqchip=split\n");
         return;
     }
 
-- 
2.18.0.rc1.1.g3f1ff2140
