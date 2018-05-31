Received: from eggs.gnu.org ([2001:4830:134:3::10]:36182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fOCNH-0007iT-T2
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fOCNG-0007GF-S4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:27:31 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180531011321.3119-1-richard.henderson@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0fb6ee09-59a9-a416-ae36-8193f3d7962e@twiddle.net>
Date: Wed, 30 May 2018 18:27:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180531011321.3119-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Pass tb and index to tcg_gen_exit_tb
 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Anthony Green <green@moxielogic.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On 05/30/2018 06:13 PM, Richard Henderson wrote:
> +void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx)
> +{
> +    uintptr_t val = (uintptr_t)tb + idx;
> +
> +    if (tb == NULL) {
> +        tcg_debug_assert(idx == 0);
> +    } else if (idx <= 1) {
> +        /* This is an exit following a goto_tb.  Verify that we have
> +           seen this numbered exit before, via tcg_gen_goto_tb.  */
> +        tcg_debug_assert(tcg_ctx->goto_tb_issue_mask & (1 << idx));

Ho hum -- #ifdef needed around this statement.
For some reason goto_tb_issue_mask is itself #ifdef'ed.


r~
