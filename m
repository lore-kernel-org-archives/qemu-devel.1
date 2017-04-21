Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RIq-0005F0-QV
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1RIm-0004RY-LK
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d1RIm-0004R5-FD
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 01:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B6DD8DA28
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 05:40:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Apr 2017 07:40:11 +0200
Message-Id: <1492753213-26516-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1492753213-26516-1-git-send-email-armbru@redhat.com>
References: <1492753213-26516-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] ppc: remove
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

This removes the assert(kvm_enabled()) from kvmppc_host_cpu_initfn()

This assert can never be triggered as the function is only registered
when KVM is available (see also 4c315c2
"qdev: Protect device-list-properties against broken devices").

So we can remove the cannot_destroy_with_object_finalize_yet from
kvmppc_host_cpu_class_init() without fear and beyond reproach.
(as it has already be done for i386 with 771a13e "i386: Unset
cannot_destroy_with_object_finalize_yet on "host" model" and
e435601 "target-i386: Remove assert(kvm_enabled()) from
host_x86_cpu_initfn()")

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170414083717.13641-3-lvivier@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/ppc/kvm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f1f132..64017ac 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2245,14 +2245,8 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
     }
 }
 
-static void kvmppc_host_cpu_initfn(Object *obj)
-{
-    assert(kvm_enabled());
-}
-
 static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(oc);
     PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
     uint32_t vmx = kvmppc_get_vmx();
     uint32_t dfp = kvmppc_get_dfp();
@@ -2279,9 +2273,6 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
     if (icache_size != -1) {
         pcc->l1_icache_size = icache_size;
     }
-
-    /* Reason: kvmppc_host_cpu_initfn() dies when !kvm_enabled() */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 bool kvmppc_has_cap_epr(void)
@@ -2333,7 +2324,6 @@ static int kvm_ppc_register_host_cpu_type(void)
 {
     TypeInfo type_info = {
         .name = TYPE_HOST_POWERPC_CPU,
-        .instance_init = kvmppc_host_cpu_initfn,
         .class_init = kvmppc_host_cpu_class_init,
     };
     PowerPCCPUClass *pvr_pcc;
-- 
2.7.4
