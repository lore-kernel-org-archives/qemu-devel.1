Received: from eggs.gnu.org ([2001:4830:134:3::10]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIHI9-0006v6-Mc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIHI6-0001R1-Io
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:25:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIHI6-0001QA-6M
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:25:10 -0400
Date: Tue, 6 Jun 2017 12:25:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170606162508.GB6109@flamenco>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-4-git-send-email-cota@braap.org>
	<015d442b-a44e-0ebc-470c-e3289b109ca6@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015d442b-a44e-0ebc-470c-e3289b109ca6@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tcg: allocate TB structs before the
 corresponding translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

On Tue, Jun 06, 2017 at 01:24:11 -0700, Richard Henderson wrote:
> On 06/05/2017 03:49 PM, Emilio G. Cota wrote:
> >+TranslationBlock *tcg_tb_alloc(TCGContext *s)
> >+{
> >+    void *aligned;
> >+
> >+    aligned = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, QEMU_CACHELINE_SIZE);
> >+    if (unlikely(aligned + sizeof(TranslationBlock) > s->code_gen_highwater)) {
> >+        return NULL;
> >+    }
> >+    s->code_gen_ptr += aligned - s->code_gen_ptr + sizeof(TranslationBlock);
> >+    return aligned;
> 
> We don't really need the 2/3 patch.  We don't gain anything by telling the
> compiler that the structure is more aligned than it needs to be.

The compile-time requirement is for the compiler to pad the structs
appropriately; this is critical to avoid false sharing when allocating
arrays of structs like those test programs do.

> We can query the line size at runtime, as suggested by Pranith, and use that
> for the alignment here.  Which means that the binary isn't tied to a
> particular cpu implementation, which is clearly preferable for
> distributions.

For this particular case we can get away without padding the structs if
we're OK with having the end of a TB struct immediately followed
by its translated code, instead of having that code on the following
cache line.

		E.
