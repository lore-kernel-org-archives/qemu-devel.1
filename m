Received: from eggs.gnu.org ([2001:4830:134:3::10]:38804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB2wr-00079Z-2P
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB2wm-0000CG-5o
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:18:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:34032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gB2wl-0000BY-KM
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:18:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id f18-v6so6371366plr.1
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 12:18:03 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-6-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <df9e8893-6880-c982-f154-2293ce421fc5@linaro.org>
Date: Fri, 12 Oct 2018 12:17:58 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-6-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/28] target/riscv: Convert RVXI fence
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
> +%pred   24:4
> +%succ   20:4
...
> +@noargs  ................................
...
> +@fence   .... .... .... .....  ... ..... ....... %pred %succ
...
> +fence    0000 .... ....   00000 000 00000 0001111 @fence
> +fence_i  000000000000     00000 001 00000 0001111 @noargs

@noargs is useless, even as documentation, since by its omission there are no
arguments.

Also, "the unused fields in the FENCE instruction, imm[11:8], rs1, and rd, are
reserved for finer-grain fences in future extensions. For forward
compatibility, base implementations shall ignore these fields, and standard
software shall zero these fields."

Therefore "-" not "0" in the relevant portions.  And for clarity I would simply
fold it all together as

fence	---- pred:4 succ:4 ----- 000 ----- 0001111
fence_i	---- ----   ----   ----- 001 ----- 0001111

Or just use "@i", which is the underlying format and ignore the rs1 and rd
fields in the trans_ expanders, and pull pred+succ out of imm there.


r~
