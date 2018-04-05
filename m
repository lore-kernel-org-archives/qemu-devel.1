Received: from eggs.gnu.org ([2001:4830:134:3::10]:33679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f48X7-0001p6-VK
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f48X4-0008D6-QY
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:18:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f48X4-0008Cg-Iq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:18:42 -0400
Date: Thu, 5 Apr 2018 13:18:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180405171841.GB15681@flamenco>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-5-git-send-email-cota@braap.org>
	<871sg38acw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sg38acw.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 04/16] tcg: move
 tb_ctx.tb_phys_invalidate_count to tcg_ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Thu, Mar 29, 2018 at 11:06:07 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> > index 3a51d49..20ad3fc 100644
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -1072,7 +1072,8 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
> >      /* suppress any remaining jumps to this TB */
> >      tb_jmp_unlink(tb);
> >
> > -    tb_ctx.tb_phys_invalidate_count++;
> > +    atomic_set(&tcg_ctx->tb_phys_invalidate_count,
> > +               tcg_ctx->tb_phys_invalidate_count + 1);
> 
> We do have an atomic_inc helper for this or we need comment that we only
> have atomic_reads() to worry about hence no races.
> 
> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

tcg_ctx is per-thread (or otherwise tb_lock is held here), so
yes we only worry here about concurrent atomic_reads. This
is common enough not to need a comment, me thinks.
[we have quite a few more instances of atomic_set(foo, foo + 1),
for instance when incrementing TCGProfile counts.]

Thanks,

		Emilio
