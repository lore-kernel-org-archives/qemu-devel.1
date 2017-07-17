Received: from eggs.gnu.org ([2001:4830:134:3::10]:37510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFeJ-0001Pc-Gi
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFeF-0003BU-Jx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:41:59 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:32955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFeF-0003BB-Fh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:41:55 -0400
Received: by mail-qt0-x231.google.com with SMTP id n42so3834280qtn.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:41:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-14-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <de06e94c-4887-2b1b-4834-66b68e29c8b0@twiddle.net>
Date: Mon, 17 Jul 2017 13:41:49 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-14-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/45] tcg: consolidate TB lookups in
 tb_lookup__cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> +    if (likely(tb &&
> +               tb->pc == *pc &&
> +               tb->cs_base == *cs_base &&
> +               tb->flags == *flags &&
> +               tb->trace_vcpu_dstate == *cpu->trace_dstate)) {

I'll just mention something I noticed while looking at perf data for Alpha. 
It's a tiny thing, however: we should order these by likelyhood of mismatch.

Almost no targets really use cs_base.  X86 won't use it when in a 32-bit or 
64-bit flat address space.  Sparc stuffs NPC into cs_base, but you really have 
to explore the limits of branch delay slots in order to see NPC != PC + 4, so 
NPC very rarely differs when PC is equal.  Similarly for HPPA.

Which suggests checking flags before cs_base.

That said, I've also considered rewriting this without short-circuit ands 
(after verifying TB != NULL) so that the compiler is free to perform all of the 
subsequent loads early.

That said, this is correct as-is.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
