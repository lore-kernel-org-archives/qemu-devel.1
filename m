Received: from eggs.gnu.org ([2001:4830:134:3::10]:39447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1flBRx-0000Hh-UC
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 07:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1flBRw-0001xA-TN
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 07:07:21 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1flBRw-0001wW-OW
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 07:07:20 -0400
Received: by mail-qt0-x22a.google.com with SMTP id m13-v6so1799236qth.1
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 04:07:20 -0700 (PDT)
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 2 Aug 2018 13:07:19 +0200
Message-ID: <CABoDooNnaE6u1WttJxuJq3Ztmb-swSk43TjPuihHqRKgvf7k6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] TCG dup_vec optimization issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello Richard,

the case INDEX_op_dup_vec in optimize.c:tcg_optimize is doing a break
when the input arg is not constant instead of jumping to do_default.

The issue can be reproduced by compiling the following SVE code:

.global main
.section .text

main:
        mov     z2.d, #0
        decp    z1.d, p0
        ret

When run with SVE vector length set to 128-bit, we get this before TCG opt:

 ---- 0000000000400524 0000000000000000 0000000000000000
 dupi_vec v128,e64,tmp2,$0x0
 st_vec v128,e8,tmp2,env,$0xb00

 ---- 0000000000400528 0000000000000000 0000000000000000
 ld_i64 tmp3,env,$0x2900
 movi_i64 tmp4,$0x101
 and_i64 tmp3,tmp3,tmp4
 ctpop_i64 tmp3,tmp3
 dup_vec v128,e64,tmp2,tmp3
 ld_vec v128,e8,tmp5,env,$0xa00
 sub_vec v128,e64,tmp6,tmp5,tmp2
 st_vec v128,e8,tmp6,env,$0xa00

After the optimization pass:

  ---- 0000000000400524 0000000000000000 0000000000000000
 dupi_vec v128,e64,tmp2,$0x0
 st_vec v128,e8,tmp2,env,$0xb00                   dead: 0

 ---- 0000000000400528 0000000000000000 0000000000000000
 ld_vec v128,e8,tmp5,env,$0xa00
 mov_vec v128,e64,tmp6,tmp5                       dead: 1
 st_vec v128,e8,tmp6,env,$0xa00                   dead: 0

The dupi_vec TCG op correctly flags tmp2 as a 0 constant. This is then
wrongly propagated down to the sub_vec TCG op despite tmp2 being
overwritten by a dup_vec TCG op.

Thanks,

Laurent
