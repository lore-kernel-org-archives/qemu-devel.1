Received: from eggs.gnu.org ([2001:4830:134:3::10]:58435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fHvrm-00024l-9i
	for qemu-devel@nongnu.org; Sun, 13 May 2018 14:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fHvrk-0000EJ-LI
	for qemu-devel@nongnu.org; Sun, 13 May 2018 14:37:06 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fHvrk-0000EF-Go
	for qemu-devel@nongnu.org; Sun, 13 May 2018 14:37:04 -0400
Received: by mail-yw0-x244.google.com with SMTP id m8-v6so2988179ywd.2
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 11:37:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512175724.5923-5-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
	<20180512175724.5923-5-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 May 2018 11:37:03 -0700
Message-ID: <CAMo8BfJ8ukftXp3bb9Cx9d2ESPX_xtCzF0T7N5pS6LaXXoa-iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] target/xtensa: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sat, May 12, 2018 at 10:57 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 229 ++++++++++++++++++++------------------
>  1 file changed, 122 insertions(+), 107 deletions(-)

[...]

> -    } while (dc->base.is_jmp == DISAS_NEXT &&
> -             insn_count < max_insns &&
> -             dc->pc - page_start < TARGET_PAGE_SIZE &&
> -             dc->pc - page_start + xtensa_insn_len(env, dc) <= TARGET_PAGE_SIZE
> -             && !tcg_op_buf_full());
> -done:

[...]

> +    /* End the TB if the next insn will cross into the next page.  */
> +    page_start = dc->base.pc_first & TARGET_PAGE_MASK;
> +    if (dc->base.is_jmp == DISAS_NEXT &&
> +        dc->pc - page_start < TARGET_PAGE_SIZE &&
> +        dc->pc - page_start + xtensa_insn_len(env, dc) <= TARGET_PAGE_SIZE) {

Originally it was the condition to continue translation.
To end the TB when the next instruction will cross into the next page the
condition must be changed to something like

    if (dc->base.is_jmp == DISAS_NEXT &&
        (dc->pc - page_start >= TARGET_PAGE_SIZE ||
         dc->pc - page_start + xtensa_insn_len(env, dc) > TARGET_PAGE_SIZE)) {

With that change all tests in tests/tcg/xtensa are passing.
I'll play with it some more...

-- 
Thanks.
-- Max
