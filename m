Received: from eggs.gnu.org ([2001:4830:134:3::10]:44811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dOBHE-00034E-8Q
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 19:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dOBHA-0001Cl-1n
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 19:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dOBH9-0001CW-Rh
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 19:12:35 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 23 Jun 2017 01:12:28 +0200
Message-Id: <20170622231228.1050-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] target-s390x: fix risbg handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

If we have for example: r3 contains 0x00000000ffffffff
    ec 33 3f bf 61 55       risbg   %r3,%r3,63,191,97

We want to rotate 33 to the left and only keep MSB bit 63 of that. So the
result is then exactly 1 (we're reading the sign of the 32 bit value).

Current code assumes that we can do that via an extract, which is not
true (at least not that easy) and produces a 0.

Let's just get rid of this special handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---

This effectively allows to start a linux kernel, compiled for z10 using
the qemu model under tcg (with other patches currently on the list):

qemu-system-s390x ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on, \
                           eimm=on,stckf=on,csst=on,csst2=on,ginste=on, \
                           exrl=on ...

I found this by compiling the kvm-unit-tests for z10 and noticing
elementary selftests failing. The kernel would trigger weird
BUG_ONs very early while starting up, which basically gave not really
many hints of what was actually going wrong.

 target/s390x/translate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 188ab8b..81419dd 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3450,12 +3450,6 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
         pos += 32;
     }
 
-    /* In some cases we can implement this with extract.  */
-    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
-        tcg_gen_extract_i64(o->out, o->in2, rot, len);
-        return NO_EXIT;
-    }
-
     /* In some cases we can implement this with deposit.  */
     if (len > 0 && (imask == 0 || ~mask == imask)) {
         /* Note that we rotate the bits to be inserted to the lsb, not to
-- 
2.9.4
