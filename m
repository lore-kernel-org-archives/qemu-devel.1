Received: from eggs.gnu.org ([2001:4830:134:3::10]:47989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPW0-0004bO-Jt
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPVx-00077z-Bd
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:38:44 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:35813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWPVw-00075W-SZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:38:41 -0500
Received: by mail-ot1-x336.google.com with SMTP id 81so11241704otj.2
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:38:40 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<989024c7cf2a45f6e4a7d793f7760c90e1b36e45.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b36cd3c2-1094-10bb-670a-fdb09bd9134d@linaro.org>
Date: Mon, 10 Dec 2018 11:38:37 -0600
MIME-Version: 1.0
In-Reply-To: <989024c7cf2a45f6e4a7d793f7760c90e1b36e45.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 17/24] riscv: tcg-target: Add slowpath
 load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 12/7/18 6:48 PM, Alistair Francis wrote:
> +    /* Compare masked address with the TLB entry. */
> +    label_ptr[0] = s->code_ptr;
> +    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
> +    /* TODO: Move this out of line

Until you do move this out of line, you need to add the nop that you use for
normal branches...


> +    /* resolve label address */
> +    reloc_sbimm12(l->label_ptr[0], s->code_ptr);

... and use patch_reloc(..., R_RISCV_BRANCH, ...).
Or split that out to its own function too.

Otherwise this branch is going to be out of range at some point.


r~
