Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fntGk-0002PG-FT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fntGh-0000Qj-Qd
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fntGh-0000Om-K7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:18:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  9 Aug 2018 19:18:52 -0300
Message-Id: <20180809221852.15285-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: Disable TOPOEXT by default on "-cpu host"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Richard W.M. Jones" <rjones@redhat.com>, Babu Moger <babu.moger@amd.com>, Eduardo Habkost <ehabkost@redhat.com>

Enabling TOPOEXT is always allowed, but it can't be enabled
blindly by "-cpu host" because it may make guests crash if the
rest of the cache topology information isn't provided or isn't
consistent.

This addresses the bug reported at:
https://bugzilla.redhat.com/show_bug.cgi?id=1613277

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 723e02221e..3ac627978f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -849,6 +849,12 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid_eax = 0x80000001, .cpuid_reg = R_ECX,
         .tcg_features = TCG_EXT3_FEATURES,
+        /*
+         * TOPOEXT is always allowed but can't be enabled blindly by
+         * "-cpu host", as it requires consistent cache topology info
+         * to be provided so it doesn't confuse guests.
+         */
+        .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
     [FEAT_C000_0001_EDX] = {
         .feat_names = {
-- 
2.18.0.rc1.1.g3f1ff2140
