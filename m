Received: from eggs.gnu.org ([2001:4830:134:3::10]:46537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ffigM-0007tf-Cl
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ffigH-000871-Ff
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:23:38 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 18 Jul 2018 11:23:30 +0200
Message-Id: <20180718092330.19465-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2] s390x/cpumodel: fix segmentation fault when
 baselining models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, David Hildenbrand <david@redhat.com>

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
2.17.1
