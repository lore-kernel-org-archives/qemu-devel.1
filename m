Received: from eggs.gnu.org ([2001:4830:134:3::10]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dmnsW-0005Xc-Uj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dmnsS-00007w-42
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:16:56 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dmnsR-00006V-Tt
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:16:52 -0400
Date: Tue, 29 Aug 2017 17:16:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170829211649.GA9108@flamenco>
References: <1500616763-26560-1-git-send-email-cota@braap.org>
	<1500616763-26560-2-git-send-email-cota@braap.org>
	<CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhHMCBpo1-6x9wJWE2oSv1RB=vH-WbA0RjMWYox_dtFfLAURA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/43] tcg: define CF_PARALLEL and use
 it for TB hashing along with CF_COUNT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani+qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Sun, Aug 27, 2017 at 18:15:50 -0400, Pranith Kumar wrote:
> Hi Emilio,
> 
> On Fri, Jul 21, 2017 at 1:59 AM, Emilio G. Cota <cota@braap.org> wrote:
> > This will enable us to decouple code translation from the value
> > of parallel_cpus at any given time. It will also help us minimize
> > TB flushes when generating code via EXCP_ATOMIC.
> >
> > Note that the declaration of parallel_cpus is brought to exec-all.h
> > to be able to define there the "curr_cflags" inline.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> I was testing a winxp image today and I bisected a infinite loop to
> this commit. The loop happens both with and without mttcg, so I think
> it has got to do with something else.

Can you test the below? It lets me boot ubuntu, otherwise it reliably
chokes on a 'rep movsb' *very* early (doesn't even get to grub).

This discusson on v2 might be relevant (I added CF_COUNT_MASK as a
result of it, but it seems I have to revisit that):
  https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06456.html

Anyway let me know if this fixes it for you. Thanks for testing!

		Emilio

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 025fae0..8b2f233 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -326,7 +326,7 @@ struct TranslationBlock {
 #define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
 #define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
-#define CF_HASH_MASK (CF_COUNT_MASK | CF_PARALLEL)
+#define CF_HASH_MASK (CF_PARALLEL)

     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
