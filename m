Received: from eggs.gnu.org ([2001:4830:134:3::10]:59620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHez-0003gV-9Q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHev-0005Am-6b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:53 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHev-0005AS-0T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:49 -0400
Received: by mail-wr0-x241.google.com with SMTP id g50so2140839wra.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:53 +0200
Message-Id: <1505824179-21541-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/50] target/i386: fix pcmpxstrx substring
 search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joseph Myers <joseph@codesourcery.com>

From: Joseph Myers <joseph@codesourcery.com>

One of the cases of the SSE4.2 pcmpestri / pcmpestrm / pcmpistri /
pcmpistrm instructions does a substring search.  The implementation of
this case in the pcmpxstrx helper is incorrect.  The operation in this
case is a search for a string (argument d to the helper) in another
string (argument s to the helper); if a copy of d at a particular
position would run off the end of s, the resulting output bit should
be 0 whether or not the strings match in the region where they
overlap, but the QEMU implementation was wrongly comparing only up to
the point where s ends and counting it as a match if an initial
segment of d matched a terminal segment of s.  Here, "run off the end
of s" means that some byte of d would overlap some byte outside of s;
thus, if d has zero length, it is considered to match everywhere,
including after the end of s.  This patch fixes the implementation to
correspond with the proper instruction semantics.  This fixes four gcc
test failures in my GCC 6-based testing.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Message-Id: <alpine.DEB.2.20.1708102139310.8101@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 05b1701..9f1b351 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2040,10 +2040,14 @@ static inline unsigned pcmpxstrx(CPUX86State *env, Reg *d, Reg *s,
         }
         break;
     case 3:
-        for (j = valids; j >= 0; j--) {
+        if (validd == -1) {
+            res = (2 << upper) - 1;
+            break;
+        }
+        for (j = valids - validd; j >= 0; j--) {
             res <<= 1;
             v = 1;
-            for (i = MIN(valids - j, validd); i >= 0; i--) {
+            for (i = validd; i >= 0; i--) {
                 v &= (pcmp_val(s, ctrl, i + j) == pcmp_val(d, ctrl, i));
             }
             res |= v;
-- 
1.8.3.1
