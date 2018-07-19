Received: from eggs.gnu.org ([2001:4830:134:3::10]:52539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7K3-0001t8-Sk
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg7Jz-0002Xf-DK
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:42:15 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 19 Jul 2018 13:42:04 +0200
Message-Id: <20180719114204.13036-2-cohuck@redhat.com>
In-Reply-To: <20180719114204.13036-1-cohuck@redhat.com>
References: <20180719114204.13036-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 1/1] s390x/cpumodel: fix segmentation
 fault when baselining models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Usually, when baselining two CPU models, whereby one of them has base
CPU features disabled (e.g. z14-base,msa=off), we fallback to an older
model that did not have these features in the base model. We always try to
create a "sane" CPU model (as far as possible), and one part of it is that
removing base features is no good and to be avoided.

Now, if we disable base features that were part of a z900, we're out of
luck. We won't find a CPU model and QEMU will segfault. This is a
scenario that should never happen in real life, but it can be used to
crash QEMU.

So let's properly report an error if we baseline e.g.:

{ "execute": "query-cpu-model-baseline",
  "arguments" : { "modela": { "name": "z14-base", "props": {"esan3" : false}},
                  "modelb": { "name": "z14"}} }

Instead of segfaulting.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180718092330.19465-1-david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index cfdbccf46d..604898a882 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -716,6 +716,14 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
 
     model.def = s390_find_cpu_def(cpu_type, max_gen, max_gen_ga,
                                   model.features);
+
+    /* models without early base features (esan3) are bad */
+    if (!model.def) {
+        error_setg(errp, "No compatible CPU model could be created as"
+                   " important base features are disabled");
+        return NULL;
+    }
+
     /* strip off features not part of the max model */
     bitmap_and(model.features, model.features, model.def->full_feat,
                S390_FEAT_MAX);
-- 
2.14.4
