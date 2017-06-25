Received: from eggs.gnu.org ([2001:4830:134:3::10]:48791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dPFt6-0005oA-24
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 18:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dPFt4-0007bo-QK
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 18:20:12 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:56492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dPFt4-0007VL-K6
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 18:20:10 -0400
Date: Mon, 26 Jun 2017 00:19:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170625221956.rda2cls2ex7icapa@aurel32.net>
References: <20170622231228.1050-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170622231228.1050-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] target-s390x: fix risbg handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com

On 2017-06-23 01:12, David Hildenbrand wrote:
> If we have for example: r3 contains 0x00000000ffffffff
>     ec 33 3f bf 61 55       risbg   %r3,%r3,63,191,97
> 
> We want to rotate 33 to the left and only keep MSB bit 63 of that. So the
> result is then exactly 1 (we're reading the sign of the 32 bit value).
> 
> Current code assumes that we can do that via an extract, which is not
> true (at least not that easy) and produces a 0.

I think the mistake there is that the rotation is done to the left,
while in extract the "shift" is done to the right. The following patch
should be enough:

--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3441,8 +3441,8 @@ static ExitStatus op_risbg(DisasContext *s, DisasOps *o)
     }
 
     /* In some cases we can implement this with extract.  */
-    if (imask == 0 && pos == 0 && len > 0 && rot + len <= 64) {
-        tcg_gen_extract_i64(o->out, o->in2, rot, len);
+    if (imask == 0 && pos == 0 && len > 0 && rot - len >= 0) {
+        tcg_gen_extract_i64(o->out, o->in2, 64 - rot, len);
         return NO_EXIT;


> Let's just get rid of this special handling.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This effectively allows to start a linux kernel, compiled for z10 using
> the qemu model under tcg (with other patches currently on the list):
> 
> qemu-system-s390x ... -cpu qemu,mvcos=on,stfle=on,ldisp=on,ldisphp=on, \
>                            eimm=on,stckf=on,csst=on,csst2=on,ginste=on, \
>                            exrl=on ...
> 
> I found this by compiling the kvm-unit-tests for z10 and noticing
> elementary selftests failing. The kernel would trigger weird
> BUG_ONs very early while starting up, which basically gave not really
> many hints of what was actually going wrong.
> 
>  target/s390x/translate.c | 6 ------
>  1 file changed, 6 deletions(-)

But the patch is also correct.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
