Received: from eggs.gnu.org ([2001:4830:134:3::10]:56926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caliborn@SDF.ORG>) id 1cW8qz-00020j-75
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caliborn@SDF.ORG>) id 1cW8qu-0007T8-4F
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:42:13 -0500
Received: from ol.sdf.org ([205.166.94.20]:64720 helo=mx.sdf.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <caliborn@SDF.ORG>) id 1cW8qb-0007Ql-ML
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:42:07 -0500
Date: Tue, 24 Jan 2017 21:41:34 +0000 (UTC)
From: Valentin Plotkin <caliborn@SDF.ORG>
In-Reply-To: <4b93a2b8-097e-a502-875e-21ea394c617a@redhat.com>
Message-ID: <Pine.NEB.4.64.1701242127070.28647@sdf.lonestar.org>
References: <Pine.NEB.4.64.1701241855380.2138@sdf.lonestar.org>
	<4b93a2b8-097e-a502-875e-21ea394c617a@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] PPC: MMU compatibility check.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Tue, 24 Jan 2017, Thomas Huth wrote:

> Date: Tue, 24 Jan 2017 21:32:44 +0100
> From: Thomas Huth <thuth@redhat.com>
> To: Valentin Plotkin <caliborn@SDF.ORG>, qemu-trivial@nongnu.org
> Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
> Subject: Re: [Qemu-ppc] [PATCH] PPC: MMU compatibility check.
> 
> On 24.01.2017 19:56, Valentin Plotkin wrote:
>>
>> Hi everyone,
>>
>> I looked at the "qemu-system-ppc -nographic -cpu G2leGP3 -M ppce500" on
>> the BiteSizedTasks page. The segfault was caused by machine
>> initialization code which expected a certain MMU model, checked, so
>> unused SPR were read, returning zeros. bamboo and virtex machines are
>> affected as well, but it doesn't always cause segfault, usually running
>> into unmapped memory and failing somewhat more nicely.
>>
>> I added the checks. It would be possible to add support for other MMU
>> models, but I'm not sure if there is any point (would any guest OS
>> support mutually exclusive CPU and machine)?
>
> Hi,
>
> great to have a fix for this crash! I don't think it make much sense to
> add support for other MMU models here, so the simple checks should be
> good enough.
> However, your new code obviously does not follow the QEMU coding style.
> Could you please run your patch through scripts/checkpatch.pl and fix
> all issues that it reports? And when you resubmit, please make sure to
> copy the maintainers on CC: as well (scripts/get_maintainers.pl is your
> friend here).
>
> Thanks,
>  Thomas
>
>

Here is fengshuised version (at least I hope so). Thanks for guiding me.

Signed-off-by: Valentin Plotkin <caliborn@sdf.org>
---
  hw/ppc/e500.c          | 6 ++++++
  hw/ppc/ppc440_bamboo.c | 6 ++++++
  hw/ppc/virtex_ml507.c  | 6 ++++++
  3 files changed, 18 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index cf8b122..683d9a9 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -631,6 +631,12 @@ static uint64_t mmubooke_initial_mapsize(CPUPPCState 
*env)

  static void mmubooke_create_initial_mapping(CPUPPCState *env)
  {
+    if (env->mmu_model != POWERPC_MMU_BOOKE206) {
+        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+            env->mmu_model);
+        exit(-1);
+    }
+
      ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 0);
      hwaddr size;
      int ps;
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 5c535b1..793b758 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -124,6 +124,12 @@ static void 
mmubooke_create_initial_mapping(CPUPPCState *env,
                                       target_ulong va,
                                       hwaddr pa)
  {
+    if (env->mmu_model != POWERPC_MMU_BOOKE) {
+        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+            env->mmu_model);
+        exit(-1);
+    }
+
      ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];

      tlb->attr = 0;
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index b97d966..c01415c 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -69,6 +69,12 @@ static void mmubooke_create_initial_mapping(CPUPPCState 
*env,
                                       target_ulong va,
                                       hwaddr pa)
  {
+    if (env->mmu_model != POWERPC_MMU_BOOKE) {
+        fprintf(stderr, "MMU model %i not supported by this machine.\n",
+            env->mmu_model);
+        exit(-1);
+    }
+
      ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];

      tlb->attr = 0;
-- 
2.5.5

caliborn@sdf.org
SDF Public Access UNIX System - http://sdf.org
