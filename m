Received: from eggs.gnu.org ([2001:4830:134:3::10]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csVwW-00040w-Kg
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csVwS-0005jr-Og
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1csVwS-0005jP-J3
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Mar 2017 11:48:13 -0300
Message-Id: <20170327144815.8043-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v2 0/2] i386: Don't override -cpu
 options on -cpu host/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, "Collin L . Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

The existing code for "host" and "max" CPU models overrides every
single feature in the CPU object at realize time, even the ones
that were explicitly enabled or disabled by the user using
"feat=on" or "feat=off", while features set using +feat/-feat are
kept.

This means "-cpu host,+invtsc" works as expected, while
"-cpu host,invtsc=on" doesn't.

This was a known bug, already documented in a comment inside
x86_cpu_expand_features(). What makes this bug worse now is that
libvirt 3.0.0 and newer now use "feat=on|off" instead of
+feat/-feat when it detects a QEMU version that supports it (see
libvirt commit d47db7b16dd5422c7e487c8c8ee5b181a2f9cd66).

This series fixes the bug.

Changes v1 -> v2:
* Split changes in two patches (Igor)
* Don't clear existing bits on env->features (they are already
  supposed to be all zeroes) (Igor)
* Fix typo on comment (Igor)

v1 -> v2 diff:

  diff --git a/target/i386/cpu.c b/target/i386/cpu.c
  index 5f2addbf75..13c0985f11 100644
  --- a/target/i386/cpu.c
  +++ b/target/i386/cpu.c
  @@ -3380,10 +3380,9 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
        */
       if (cpu->max_features) {
           for (w = 0; w < FEATURE_WORDS; w++) {
  -            /* Override only features that weren't not set explicitly
  +            /* Override only features that weren't set explicitly
                * by the user.
                */
  -            env->features[w] &= env->user_features[w];
               env->features[w] |=
                   x86_cpu_get_supported_feature_word(w, cpu->migratable) &
                   ~env->user_features[w];

Eduardo Habkost (2):
  i386: Replace uint32_t* with FeatureWord on feature getter/setter
  i386: Don't override -cpu options on -cpu host/max

 target/i386/cpu.h |  2 ++
 target/i386/cpu.c | 32 ++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.11.0.259.g40922b1
