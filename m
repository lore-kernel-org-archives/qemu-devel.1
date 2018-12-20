Received: from eggs.gnu.org ([2001:4830:134:3::10]:36114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZrMt-0000dW-8B
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZrMp-0003QR-LS
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:59:35 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZrMp-0003Np-Ay
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:59:31 -0500
Received: by mail-pg1-x544.google.com with SMTP id t13so349598pgr.11
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 21:59:31 -0800 (PST)
References: <cover.1545246859.git.alistair.francis@wdc.com>
	<7c47f00cb4a9a777120456e0704b4076a5d943ab.1545246859.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c5943dd-f23f-ecda-13a5-7e522336b735@linaro.org>
Date: Wed, 19 Dec 2018 21:59:27 -0800
MIME-Version: 1.0
In-Reply-To: <7c47f00cb4a9a777120456e0704b4076a5d943ab.1545246859.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/23] riscv: tcg-target: Add the out op
 decoder
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

On 12/19/18 11:19 AM, Alistair Francis wrote:
> +    case INDEX_op_ext32s_i64:
> +    case INDEX_op_extrl_i64_i32:
> +    case INDEX_op_extrh_i64_i32:
> +    case INDEX_op_ext_i32_i64:
> +        tcg_out_ext32s(s, a0, a1);
> +        break;

This is the last bug that's easy to identify.  It shows up quickly in a
linux-user smoke test [1].  Obviously extrl (extract low) and extrh (extract
high) should not be implemented identically.

Fixed thus.

With this, most of the tests pass, when run in a qemu-riscv chroot.  The ones
that don't primarily never get started.  E.g. the alpha test fails to map
ld.so, for reasons that I have not examined, since it's not a tcg problem.


r~


[1] https://archive.li/o/1YduE/wiki.qemu.org/download/linux-user-test-0.3.tar.gz


---
 tcg/riscv/tcg-target.inc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index f718542d63..6cf8de32b5 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1614,11 +1614,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,

     case INDEX_op_ext32s_i64:
     case INDEX_op_extrl_i64_i32:
-    case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
         tcg_out_ext32s(s, a0, a1);
         break;

+    case INDEX_op_extrh_i64_i32:
+        tcg_out_opc_imm(s, OPC_SRAI, a0, a1, 32);
+        break;
+
     case INDEX_op_mulsh_i32:
     case INDEX_op_mulsh_i64:
         tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
---
