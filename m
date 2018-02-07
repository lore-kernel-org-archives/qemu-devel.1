Received: from eggs.gnu.org ([2001:4830:134:3::10]:35451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejYTN-0000oW-6Q
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejYTL-0006tw-Tq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:45:49 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:40919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ejYTL-0006tT-MR
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:45:47 -0500
Received: by mail-ot0-x234.google.com with SMTP id s4so2393390oth.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 14:45:47 -0800 (PST)
MIME-Version: 1.0
From: Michael Clark <mjc@sifive.com>
Date: Thu, 8 Feb 2018 11:45:46 +1300
Message-ID: <CAHNT7NvmANaTCbwb7xP9i1TBZ9-2Syf00hxM_vaWh3zk57oj7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU support for IEEE 754-201x
 minimumNumber/maximumNumber
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Jim Wilson <jimw@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

Hi Folks,

I'm currently going through riscv-tests failures in riscv-qemu and we have
an issue with fmin/fmax.

In particular, this test case is failing:

- https://github.com/riscv/riscv-tests/blob/master/isa/rv64uf/fmin.S#L35-L35

The RISC-V port is currently using the solftfloat floatXX_minnum/maxnum
methods which implement IEEE 754-2008 minNum/maxNum.

RISC-V depends on the IEEE 754-201x definition of
minimumNumber/maximumNumber which returns x for fminmax(sNaN, x) whereas
QEMU implements IEEE 754-2008 minNum/maxNum and will return x, for
fminmax(qNaN, x) but will return NaN for fminmax(sNaN, x)

minNum(x, y) is defined as
- min(x, y) if neither is NaN
- if one of x and y is a number and one is qNaN, return the number
- if both are qNaN, or either is sNaN, return NaN

minimumNumber(x, y) is defined as
- min(x, y) if neither is NaN
- if one of x and y is a number and one is qNaN or sNaN, return the number
- if both are NaN, return the number

My question. Should we add support for minimumNumber/maximumNumber in
fpu/softfloat.c or just implement private versions of these intrinsics in
target/riscv/fpu_helper.c

If we were to change core code, we'd have to think about the interface to
the common min/max macro. i.e. instead of having the ieee flag, have
ieee2008 and ieee201x flags.

The least risk approach would be to define a macro
in target/riscv/fpu_support.c, and then later consider moving it to core
code.

Does the fpu/softfloat.c code have good test coverage in make check?

Michael.
