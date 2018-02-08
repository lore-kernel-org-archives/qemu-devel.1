Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejoV6-0006tq-7C
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejoV3-0004L4-42
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:52:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33246
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ejoV2-0004Kh-Tf
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:52:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18FpeVp166438
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 10:52:34 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g0sc8gmu6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 10:52:33 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 15:52:32 -0000
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208090904.5a9c88df@redhat.com>
	<20180208162126.3426623b.cohuck@redhat.com>
	<20180208103024.35d962c9@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 16:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180208103024.35d962c9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <2b9e79d9-9c13-3edc-38f4-80062824e0b6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 08.02.2018 16:30, Luiz Capitulino wrote:
> On Thu, 8 Feb 2018 16:21:26 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Thu, 8 Feb 2018 09:09:04 -0500
>> Luiz Capitulino <lcapitulino@redhat.com> wrote:
>>
>>> On Thu,  8 Feb 2018 10:48:08 +0100
>>> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
>>>   
>>>> Presently s390x is the only architecture not exposing specific
>>>> CPU information via QMP query-cpus. Upstream discussion has shown
>>>> that it could make sense to report the architecture specific CPU
>>>> state, e.g. to detect that a CPU has been stopped.    
>>>
>>> I'd very strongly advise against extending query-cpus. Note that the
>>> latency problems with query-cpus exists in all archs, it's just a
>>> matter of time for it to pop up for s390 use-cases too.
>>>
>>> I think there's three options for this change:
>>>
>>>  1. If this doesn't require interrupting vCPU threads, then you
>>>     could rebase this on top of query-cpus-fast  
>>
>> From my perspective, rebasing on top of query-cpus-fast looks like a
>> good idea. This would imply that we need architecture-specific fields
>> for the new interface as well, though.
> 
> That's not a problem. I mean, to be honest I think I'd slightly prefer
> to keep things separate and add a new command for each arch that needs
> its specific information, but that's just personal preference. The only
> strong requirement for query-cpus-fast is that it doesn't interrupt
> vCPU threads.
> 
While it's a reasonable idea to deprecate query-cpus it will not go away
in a while, if ever. Reason is that there's a significant number of
libvirt release out there using it to probe the VCPUs of a domain.
It would be more than strange if the fast-but-slim version of query-cpus
would report a superset of the slow-but-thorough version.
Therefore, while query-cpus is available, it has to have all the
cpu info.

I'm going to spin a new version of the patch with the changes suggested
by Eric. Additionaly, see the patch below, which can be applied on top
Luiz' and my patch to provide the s390 cpu state with both query types.


[PATCH] S390: Add architecture specific cpu data for query-cpus-fast

The s390 CPU state can be retrieved without interrupting the
VM execution. Extendend the CpuInfo2 with optional architecture
specific data and an implementation for s390.

Return data looks like this:
 [
   {"thread-id":64301,"props":{"core-id":0},
    "archdata":{"arch":"s390","cpu_state":"operating"},
    "qom-path":"/machine/unattached/device[0]","cpu-index":0},
   {"thread-id":64302,"props":{"core-id":1},
    "archdata":{"arch":"s390","cpu_state":"operating"},
    "qom-path":"/machine/unattached/device[1]","cpu-index":1}
]

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 cpus.c           | 13 +++++++++++++
 hmp.c            | 11 +++++++++++
 qapi-schema.json | 22 +++++++++++++++++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index cb04b2c..a972378 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2099,6 +2099,10 @@ CpuInfo2List *qmp_query_cpus_fast(Error **errp)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfo2List *head = NULL, *cur_item = NULL;
     CPUState *cpu;
+#if defined(TARGET_S390X)
+    S390CPU *s390_cpu;
+    CPUS390XState *env;
+#endif
 
     CPU_FOREACH(cpu) {
         CpuInfo2List *info = g_malloc0(sizeof(*info));
@@ -2122,6 +2126,15 @@ CpuInfo2List *qmp_query_cpus_fast(Error **errp)
             info->value->halted = cpu->halted;
         }
 
+        /* add architecture specific data if available */
+#if defined(TARGET_S390X)
+        s390_cpu = S390_CPU(cpu);
+        env = &s390_cpu->env;
+        info->value->has_archdata = true;
+        info->value->archdata = g_malloc0(sizeof(*info->value->archdata));
+        info->value->archdata->arch = CPU_INFO_ARCH_S390;
+        info->value->archdata->u.s390.cpu_state = env->cpu_state;
+#endif
         if (!cur_item) {
             head = cur_item = info;
         } else {
diff --git a/hmp.c b/hmp.c
index 0c36864..bfd1038 100644
--- a/hmp.c
+++ b/hmp.c
@@ -427,6 +427,17 @@ void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
         }
         monitor_printf(mon, " qom-path=%s\n", cpu->value->qom_path);
         monitor_printf(mon, "\n");
+        if (cpu->value->has_archdata) {
+            switch (cpu->value->archdata->arch) {
+            case CPU_INFO_ARCH_S390:
+                monitor_printf(mon, " state=%s\n",
+                               CpuInfoS390State_str(cpu->value->archdata->
+                                                    u.s390.cpu_state));
+                break;
+            default:
+                break;
+            }
+        }
     }
 
     qapi_free_CpuInfo2List(head);
diff --git a/qapi-schema.json b/qapi-schema.json
index 12c7dc8..0b36860 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -607,7 +607,27 @@
 ##
 { 'struct': 'CpuInfo2',
   'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
-           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
+           'thread-id': 'int', '*props': 'CpuInstanceProperties',
+           '*archdata': 'CpuInfoArchData' } }
+
+##
+# @CpuInfoArchData:
+#
+# Architecure specific information about a virtual CPU
+#
+# Since: 2.12
+#
+##
+{ 'union': 'CpuInfoArchData',
+  'base': { 'arch': 'CpuInfoArch' },
+  'discriminator': 'arch',
+  'data': { 'x86': 'CpuInfoOther',
+            'sparc': 'CpuInfoOther',
+            'ppc': 'CpuInfoOther',
+            'mips': 'CpuInfoOther',
+            'tricore': 'CpuInfoOther',
+            's390': 'CpuInfoS390',
+            'other': 'CpuInfoOther' } }
 
 ##
 # @query-cpus-fast:
-- 
1.9.1
