Received: from eggs.gnu.org ([2001:4830:134:3::10]:33649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhV0-0000xl-L5
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhUx-0000Hj-DG
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:38:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYhUx-0000HU-8s
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:38:19 -0400
Date: Fri, 21 Jul 2017 19:38:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721233818.GT10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-9-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170715094243.28371-9-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 08/34] tcg: Add generic translation
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:17 -1000, Richard Henderson wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Message-Id: <150002073981.22386.9870422422367410100.stgit@frigg.lan>
> [rth: Moved max_insns adjustment from tb_start to init_disas_context.
> Removed pc_next return from translate_insn.
> Removed tcg_check_temp_count from generic loop.
> Moved gen_io_end to exactly match gen_io_start.
> Use qemu_log instead of error_report for temporary leaks.
> Moved TB size/icount assignments before disas_log.]
> Signed-off-by: Richard Henderson <rth@twiddle.net>
(snip)
> +void translator_loop_temp_check(DisasContextBase *db)
> +{
> +    if (tcg_check_temp_count()) {
> +        qemu_log("warning: TCG temporary leaks before "
> +                 TARGET_FMT_lx "\n", db->pc_next);
> +    }
> +}

I dislike that we have target code calling tcg_clear_temp_count()
and then calling translator_loop_temp_check().

I suggest we either:
- Add an inline wrapping tcg_clear_temp_count(), calling it something
  like translator_loop_clear_temp_count()
- Just add a comment to this function, e.g.
  '/* pairs with tcg_clear_temp_count() */'

Ignoring that and the update needed to the docs that Lluis mentioned,

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
