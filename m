Received: from eggs.gnu.org ([2001:4830:134:3::10]:53287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dBHJ2-0000yq-Tp
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dBHIy-0000tp-8q
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:01:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dBHIx-0000t7-V7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:01:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4I90PaC142928
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 05:01:05 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agxkbebnx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 05:01:04 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 May 2017 05:01:03 -0400
References: <1495035337-13337-1-git-send-email-thuth@redhat.com>
	<0721f18a-fc66-0be3-7462-76eb60de7f55@redhat.com>
	<394772e4-949a-b92f-6879-7b9e343e10d3@redhat.com>
	<0cb4c90d-cfcc-3d12-44b5-c979f20ec7b9@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 May 2017 11:00:58 +0200
MIME-Version: 1.0
In-Reply-To: <0cb4c90d-cfcc-3d12-44b5-c979f20ec7b9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <d352caf1-90c5-558c-1d25-cfd91d4e24fc@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH] target/s390x/cpu_models: Set some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: mmarek@suse.com, mbenes@suse.cz, Aurelien Jarno <aurelien@aurel32.net>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

On 05/18/2017 10:48 AM, David Hildenbrand wrote:
> On 18.05.2017 03:55, Thomas Huth wrote:
>> On 17.05.2017 18:49, David Hildenbrand wrote:
>>> On 17.05.2017 17:35, Thomas Huth wrote:
>>>> Currently we only present the plain z900 feature bits to the guest,
>>>> but QEMU already emulates some additional features (but not all of
>>>> the next CPU generation, so we can not use the next CPU level as
>>>> default yet). Since newer Linux kernels are checking the feature bits
>>>> and refuse to work if a required feature is missing, we should present
>>>> as much of the supported features as possible when we are running
>>>> with the default "qemu" CPU.
>>>> This patch now adds the "stfle", "extended immediate" and "stckf"
>>>> facility bits to the "qemu" CPU, which are already supported facilities.
>>>> It is unfortunately still not enough to run e.g. recent Fedora kernels,
>>>> but at least it's a first step into the right direction.
>>>>
>>>
>>> Three things:
>>>
>>> 1. Should we care about backwards compatibility? I think so. This should
>>> be fixed up using compat machine properties. (qemu model is a
>>> migration-safe model and could e.g. be used in KVM setups, too).
>>
>> Theoretically, I agree, but do we really care about backwards
>> compatibility at this point in time? All major distro kernels (except
>> Debian, I think) currently do not work in QEMU, so there is currently
>> not that much that can be migrated...
>> And currently, the "qemu" CPU is the very same as the "z900" CPU, so you
>> might also get along with simply using "-cpu z900" on the destination
>> instead, I guess.
> 
> If possible, I would like to avoid changing migration safe CPU model.
> And I guess it shouldn't be too hard for now (unless we really change
> the base model to e.g. a z9, then some more work might have to be done)
> 
> I think for now, setting "stfle=off" on "s390-cpu-qemu" for compat
> machines should do the trick.
> 
>>
>>> 2. I would recommend to not enable STFLE for now. Why?
>>>
>>> It is/was an indication that the system is running on a z9 (and
>>> implicitly has the basic features). This was not only done because
>>> people were lazy, but because this bit was implicitly connected to other
>>> machine properties.
>>
>> Uh, that's ugly!
>>
>>> One popular example is the "DAT-enhancement facility 2". It introduced
>>> the "LOAD PAGE TABLE ENTRY ADDRESS" instruction, but no facility bit was
>>> introduced. SO there is no way to check if the instruction is available
>>> and actually working.
>>
>> Does the Linux kernel use this instruction at all? I just grep'ed
>> through the kernel sources and did not find it. If the Linux kernel does
>> not use it, I think we should ignore this interdependency and just
>> provide the STFLE feature bit to the guest - since recent Linux kernels
>> depend on it.
> 
> Yes, current linux doesn't use it, I don't remember if previous versions
> did. Most likely not. The question is if they relied on the stfle==z9
> assumption. The STFLE facility really is special in that sense.
> 
>>
>>> Please note that we added a feature representation for this facility,
>>> because this would allow us later on to at least model removal of such a
>>> facility (if HW actually would drop it) on a CPU model level.
>>
>> What about STFLE bit 78, according to my version of the POP, it says:
>>
>> "The enhanced-DAT facility 2 is installed in the
>>  z/Architecture architectural mode."
>>
>> ?
> 
> As Aurelien already mentioned, there seemed to be different ways to
> enhance DAT :) enhanced-DAT facility 2 is 2GB page support.
> 
>>
>>> 3. This introduces some inconsistency. s390x/cpu_models.c:set_feature()
>>> explicitly tests for such inconsistencies.
>>>
>>> So your QEMU CPU model would have a feature, but you would not be able
>>> to run that model using QEMU when manually specifying it on the command
>>> line. Especially, expanding the "qemu" model and feeding it back to QEMU
>>> will fail.
>>
>> I've checked that I can also successfully disable the features again at
>> the command line, using "-cpu qemu,eimm=false" for example, so not sure
>> what exactly you're talking about here. Could you please elaborate?
> 
> Assume libvirt/the user expands the CPU model name "qemu" via
> "qmp-expand-cpu-model "qemu", you will get something like
> 
> "z900-base,.....,stfle=on"
> 
> If you feed that to QEMU using "-cpu z900-base,...,stfle=on", QEMU will
> detect the inconsistency when setting the property and abort. However,
> "-cpu qemu" will succeed. Please note that these checks actually make
> sense for KVM:
> 

Jason (now on cc) has a patch prepared for other reasons that disabled features
for given machines. I kept the ESOP example in that patch.
That would allow us to disable STFLE for old machines but enable it for 2.10

copy/pasted and hand edited to get rid of the unrelated changes:


diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3c12735..26b0ac9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -30,6 +30,7 @@
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/css-bridge.h"
+#include "cpu_models.h"

 static const char *const reset_dev_types[] = {
     TYPE_VIRTUAL_CSS_BRIDGE,
@@ -481,6 +482,7 @@ DEFINE_CCW_MACHINE(2_10, "2.10", true);
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
     ccw_machine_2_10_instance_options(machine);
+    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ESOP);
 }

 static void ccw_machine_2_9_class_options(MachineClass *mc)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 71ddb6c..5f295a5 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -78,6 +78,32 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
 };

+void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
+{
+    const S390CPUDef *def;
+
+    def = s390_find_cpu_def(0, gen, ec_ga, NULL);
+    clear_bit(feat, (unsigned long *)&def->default_feat);
+}
+
+void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
+        const S390CPUDef *def = &s390_cpu_defs[i];
+
+        if (def->gen < gen) {
+            continue;
+        }
+        if (def->gen == gen && def->ec_ga < ec_ga) {
+            continue;
+        }
+
+        clear_bit(feat, (unsigned long *)&def->default_feat);
+    }
+}
+
 uint32_t s390_get_hmfai(void)
 {
     static S390CPU *cpu;
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 136a602..881eb65 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -69,6 +69,8 @@ typedef struct S390CPUModel {
 #define ibc_gen(x)        (x == 0 ? 0 : ((x >> 4) + S390_GEN_Z10))
 #define ibc_ec_ga(x)      (x & 0xf)

+void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat);
+void s390_cpudef_featoff_greater(uint8_t gen, uint8_t ec_ga, S390Feat feat);
 uint32_t s390_get_hmfai(void);
 uint8_t s390_get_mha_pow(void);
 uint32_t s390_get_ibc_val(void);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 3efd5dd..105e5f5 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -515,6 +515,7 @@ static uint16_t default_GEN12_GA1[] = {
     S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
     S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_EDAT_2,
+    S390_FEAT_ESOP,
 };


Maybe we should split that out and merge such a patch sooner than the
(yet in development) other changes?



> If you're on a z13 and configure a zEC12, you might be tempted to add
> e.g. "vx=on". However, IBC (Instruction Blocking Control) in the machine
> will block any attempt to execute a vx instruction. So these checks make
> sure that only facilities really supported for a machine generation can
> be enabled.
> 
> If we really want that, we might decide to drop such checks for models <
> e.g. z9, because nobody will most likely care.
> 
>>
>>> So I am not sure if we should introduce such inconsistencies at that
>>> point. Rather fix up the basics and then move the CPU model to a
>>> consistent model.
>>
>> I think we're very far away from being able to use the next official CPU
>> model generation in QEMU TCG, so having at least something that let's us
>> run other recent distro kernels apart from the Debian ones would be very
>> helpful. I also understand the "qemu" CPU this way: "Simply give me the
>> best CPU features that TCG currently can provide". If you want to have a
>> "consistent" CPU state, you can simply use an official model like "z900"
>> instead.
> 
> "qemu" is just like what "host" is for kvm. A consistent model, because
> it is the default.
> 
> However, KVM folks also have the requirement to allow
> "unfiltered"/"inconsistent" models, e.g. for development purposes.
> 
> There was the idea to introduce a CPU model "-cpu off", that would act
> as before, without any CPU model support: Blindly enable anything we can.
> 
> This model would of course not be static, not migration-safe, and one
> would not be able to modify features. This would map to an "unfiltered
> qemu" model under TCG. We could blindly enable anything there.
> 
>>
>>  Thomas
>>
> 
> 
