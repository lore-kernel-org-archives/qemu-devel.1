Received: from eggs.gnu.org ([2001:4830:134:3::10]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5L-0005kf-Qu
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5H-0007Gq-4w
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:07 -0400
Received: from mail-eopbgr30138.outbound.protection.outlook.com
	([40.107.3.138]:64275
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5G-0007Ep-QH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:03 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:31 +0300
Message-Id: <20170606181948.16238-7-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/23] hyperv: helper to find vcpu by VP index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Locate the vcpu by its VP index (equal to QEMU cpu_index).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h | 1 +
 target/i386/hyperv.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 35da0b1..c5843c9 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -40,5 +40,6 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
 uint32_t hyperv_vp_index(X86CPU *cpu);
+X86CPU *hyperv_find_vcpu(uint32_t vcpu_id);
 
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 27de5bc..480bdfe 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -21,6 +21,11 @@ uint32_t hyperv_vp_index(X86CPU *cpu)
     return CPU(cpu)->cpu_index;
 }
 
+X86CPU *hyperv_find_vcpu(uint32_t vp_index)
+{
+    return X86_CPU(qemu_get_cpu(vp_index));
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
-- 
2.9.4
