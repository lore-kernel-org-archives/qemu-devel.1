Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gPK8R-0002uR-HU
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 23:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gPK8O-0008C3-EA
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 23:29:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gPK8O-0008B8-9K
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 23:29:04 -0500
From: Bandan Das <bsd@redhat.com>
References: <7280.1542702495@dschgrazlin2.units.it>
Date: Tue, 20 Nov 2018 23:28:59 -0500
Message-ID: <jpgd0qz3vg4.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balducci@units.it, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>, Cole Robinson <crobinso@redhat.com>

balducci@units.it writes:

> hello
>
>> incomplete because it can return 0 for data. Can you try this:
>>
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index f524e7d929..4878ffb90b 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -2002,14 +2002,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>>  #endif
>>  
>>      /* If host supports feature MSR, write down. */
>> -    if (kvm_feature_msrs) {
>> -        int i;
>> -        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
>> -            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) 
>> {
>> -                kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>> +    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAPABILI
>> TIES)) {
>> +        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
>>                                env->features[FEAT_ARCH_CAPABILITIES]);
>> -                break;
>> -            }
>>      }
>>  
>>      /*
>
Sorry Gabriele, Eduardo and Paolo pointed out that the patch was incomplete.
I am not sure however how you are getting non zero data with the rdmsr on an AMD.
Can you please try this instead ?

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f524e7d929..cfec559aa3 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -95,6 +95,7 @@ static bool has_msr_xss;
 static bool has_msr_spec_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
+static bool has_msr_arch_capabs;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -1481,6 +1482,9 @@ static int kvm_get_supported_msrs(KVMState *s)
                 case MSR_VIRT_SSBD:
                     has_msr_virt_ssbd = true;
                     break;
+                case MSR_IA32_ARCH_CAPABILITIES:
+                    has_msr_arch_capabs = true;
+                    break;
                 }
             }
         }
@@ -2002,14 +2006,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
 #endif
 
     /* If host supports feature MSR, write down. */
-    if (kvm_feature_msrs) {
-        int i;
-        for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
-            if (kvm_feature_msrs->indices[i] == MSR_IA32_ARCH_CAPABILITIES) {
+    if (kvm_arch_get_supported_msr_feature(kvm_state, MSR_IA32_ARCH_CAPABILITIES)
+        && has_msr_arch_capabs) {
                 kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
                               env->features[FEAT_ARCH_CAPABILITIES]);
-                break;
-            }
     }
 
     /*
