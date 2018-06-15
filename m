Received: from eggs.gnu.org ([2001:4830:134:3::10]:53261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fTpHo-00071n-I8
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fTpHl-0007gu-Du
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:01:08 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fTpHl-0007fw-69
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:01:05 -0400
Date: Fri, 15 Jun 2018 10:01:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180615140103.GB9752@flamenco>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
	<CAFEAcA-n9U90h8j_-cu0Y+vxnM0mJra0Ldw880t33G122jdCiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-n9U90h8j_-cu0Y+vxnM0mJra0Ldw880t33G122jdCiQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/18] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jun 15, 2018 at 11:41:28 +0100, Peter Maydell wrote:
> Hi; I get compile failures with clang I'm afraid
> (seen on x86-64 Linux, OSX and FreeBSD):
> 
> /home/petmay01/linaro/qemu-for-merges/accel/tcg/translate-all.c:1800:44:
> error: incompatible integer to pointer conversion passing 'uintptr_t'
> (aka 'unsigned long') to parameter of type 'void *'
> [-Werror,-Wint-conversion]
>         atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);

Fixed with:

--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1797,7 +1797,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
 
         orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
-        atomic_set(&tcg_ctx->code_gen_ptr, orig_aligned);
+        atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
         return existing_tb;
     }
     tcg_tb_insert(tb);

This applies to patch 14/18 ("translate-all: discard TB when
tb_link_page returns an existing matching TB") of the pull request.

The rest compiles OK for me on clang 7.0.0.

Richard: can you fold this fixup into patch 14?

Thanks,

		Emilio
