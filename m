Received: from eggs.gnu.org ([209.51.188.92]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3KK-0000iW-Vc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj3KI-0005jc-W3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj3KH-0005hE-2z
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:34:54 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Jan 2019 12:34:31 -0200
Message-Id: <20190114143432.4771-5-ehabkost@redhat.com>
In-Reply-To: <20190114143432.4771-1-ehabkost@redhat.com>
References: <20190114143432.4771-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] x86: host-phys-bits-limit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

Some downstream distributions of QEMU set host-phys-bits=on by
default.  This worked very well for most use cases, because
phys-bits really didn't have huge consequences. The only
difference was on the CPUID data seen by guests, and on the
handling of reserved bits.

This changed in KVM commit 855feb673640 ("KVM: MMU: Add 5 level
EPT & Shadow page table support").  Now choosing a large
phys-bits value for a VM has bigger impact: it will make KVM use
5-level EPT even when it's not really necessary.  This means
using the host phys-bits value may not be the best choice.

Management software could address this problem by manually
configuring phys-bits depending on the size of the VM and the
amount of MMIO address space required for hotplug.  But this is
not trivial to implement.

However, there's another workaround that would work for most
cases: keep using the host phys-bits value, but only if it's
smaller than 48.  This patch makes this possible by introducing a
new "-cpu" option: "host-phys-bits-limit".  Management software
or users can make sure they will always use 4-level EPT using:
"host-phys-bits=on,host-phys-bits-limit=48".

This behavior is still not enabled by default because QEMU
doesn't enable host-phys-bits=on by default.  But users,
management software, or downstream distributions may choose to
change their defaults using the new option.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181211192527.13254-1-ehabkost@redhat.com>
[ehabkost: removed test code while some issues are addressed]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 3 +++
 target/i386/cpu.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 386094a241..59656a70e6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1461,6 +1461,9 @@ struct X86CPU {
     /* if true override the phys_bits value with a value read from the host */
     bool host_phys_bits;
 
+    /* if set, limit maximum value for phys_bits when host_phys_bits is true */
+    uint8_t host_phys_bits_limit;
+
     /* Stop SMI delivery for migration compatibility with old machines */
     bool kvm_no_smi_migration;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9d4dccf020..3ece83696e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5178,6 +5178,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             if (cpu->host_phys_bits) {
                 /* The user asked for us to use the host physical bits */
                 cpu->phys_bits = host_phys_bits;
+                if (cpu->host_phys_bits_limit &&
+                    cpu->phys_bits > cpu->host_phys_bits_limit) {
+                    cpu->phys_bits = cpu->host_phys_bits_limit;
+                }
             }
 
             /* Print a warning if the user set it to a value that's not the
@@ -5765,6 +5769,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
+    DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
     DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
     DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
     DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
-- 
2.18.0.rc1.1.g3f1ff2140
