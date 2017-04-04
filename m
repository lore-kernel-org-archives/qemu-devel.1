Received: from eggs.gnu.org ([2001:4830:134:3::10]:43490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0u-00022P-56
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0t-00033I-7l
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvV0t-00032q-1S
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:15 -0300
Message-Id: <20170404202429.14643-8-ehabkost@redhat.com>
In-Reply-To: <20170404202429.14643-1-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/21] kvmclock: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

kvmclock should be used by guests only when the appropriate CPUID
feature flags are set on the VCPU, and it is automatically
created by kvmclock_create() when those feature flags are set.
This means creating a kvmclock device using -device is useless.
Remove user_creatable from its device class.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 hw/i386/kvm/clock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 7665bef999..13eca374cd 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -286,11 +286,6 @@ static void kvmclock_class_init(ObjectClass *klass, void *data)
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
     dc->props = kvmclock_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo kvmclock_info = {
-- 
2.11.0.259.g40922b1
