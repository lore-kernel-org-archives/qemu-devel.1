Received: from eggs.gnu.org ([209.51.188.92]:57056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxM16-0008IY-NO
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 20:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxM15-0000SN-OW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 20:22:12 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxM15-0000MT-8e
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 20:22:11 -0500
Received: by mail-pg1-x544.google.com with SMTP id h11so1894643pgl.0
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 17:22:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 17:22:04 -0800
Message-Id: <20190223012206.30498-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Implement ARMv8.5-FRINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Based-on: the ARMv8.2-FHM patch set, although I don't know that
this is an actual dependency; it's just the tree I started with.

There is not yet support for this extension within FVP, so I've
self-tested it against my own understanding of what is supposed
to go on with the file below.


r~


Richard Henderson (2):
  target/arm: Restructure handle_fp_1src_{single,double}
  target/arm: Implement ARMv8.5-FRINT

 target/arm/cpu.h           |   5 ++
 target/arm/helper.h        |   5 ++
 target/arm/cpu64.c         |   1 +
 target/arm/translate-a64.c | 161 ++++++++++++++++++++++++++-----------
 target/arm/vfp_helper.c    |  96 ++++++++++++++++++++++
 5 files changed, 222 insertions(+), 46 deletions(-)

-- 

#include <stdio.h>
#include <limits.h>

asm(".arch armv8.5-a");

static const float f32_i32_z[][2] = {
    { 0, 0 },
    { -0.0, -0.0 },
    { 0.9, 0.0 },
    { 1.0, 1.0 },
    { 1.1, 1.0 },
    { 1.9, 1.0 },
    { 0x1.fffffep30, 0x1.fffffep30 },		/* 2^31 - epsilon */
    { -0x1p31, -0x1.0p31 },			/* -2^31 = INT32_MIN */
    { 0x1.0p31, -0x1.0p31 },			/* overflow */
    { 0x1.0p32, -0x1.0p31 },			/* overflow */
    { -0x1.0p32, -0x1.0p31 },			/* overflow */
    { __builtin_inf(), -0x1.0p31 },		/* overflow */
};

static const double f64_i32_z[][2] = {
    { 0, 0 },
    { -0.0, -0.0 },
    { 0.9, 0.0 },
    { 1.0, 1.0 },
    { 1.1, 1.0 },
    { 1.9, 1.0 },
    { 2147483647, 2147483647 },			/* 2^31 - 1 = INT32_MAX */
    { -0x1p31, -0x1.0p31 },			/* -2^31 = INT32_MIN */
    { 0x1.0p31, -0x1.0p31 },			/* overflow */
    { 0x1.0p32, -0x1.0p31 },			/* overflow */
    { -0x1.0p32, -0x1.0p31 },			/* overflow */
    { __builtin_inf(), -0x1.0p31 },		/* overflow */
};

static const float f32_i64_z[][2] = {
    { 0, 0 },
    { -0.0, -0.0 },
    { 0.9, 0.0 },
    { 1.0, 1.0 },
    { 1.1, 1.0 },
    { 1.9, 1.0 },
    { 0x1.fffffep30, 0x1.fffffep30 },		/* 2^31 - epsilon */
    { -0x1p31, -0x1.0p31 },			/* -2^31 = INT32_MIN */
    { 0x1.0p31, 0x1.0p31 },
    { 0x1.0p32, 0x1.0p32 },
    { -0x1.0p32, -0x1.0p32 },
    { 0x1.0p62, 0x1.0p62 },
    { 0x1.fffffep62, 0x1.fffffep62 },		/* 2^63 - epsilon */
    { -0x1.0p63, -0x1.0p63 },			/* -2^63 = INT64_MIN */
    { 0x1.0p63, -0x1.0p63 },			/* overflow */
    { 0x1.0p64, -0x1.0p63 },			/* overflow */
    { -0x1.0p64, -0x1.0p63 },			/* overflow */
    { __builtin_inf(), -0x1.0p63 },		/* overflow */
};

static const double f64_i64_z[][2] = {
    { 0, 0 },
    { -0.0, -0.0 },
    { 0.9, 0.0 },
    { 1.0, 1.0 },
    { 1.1, 1.0 },
    { 1.9, 1.0 },
    { 2147483647, 2147483647 },			/* 2^31 - 1 = INT32_MAX */
    { -0x1p31, -0x1.0p31 },			/* -2^31 = INT32_MIN */
    { 0x1.0p31, 0x1.0p31 },
    { 0x1.0p32, 0x1.0p32 },
    { -0x1.0p32, -0x1.0p32 },
    { 0x1.0p62, 0x1.0p62 },
    { 0x1.fffffffffffffp62, 0x1.fffffffffffffp62 }, /* 2^63 - epsilon */
    { -0x1.0p63, -0x1.0p63 },			/* -2^63 = INT64_MIN */
    { 0x1.0p63, -0x1.0p63 },			/* overflow */
    { 0x1.0p64, -0x1.0p63 },			/* overflow */
    { -0x1.0p64, -0x1.0p63 },			/* overflow */
    { __builtin_inf(), -0x1.0p63 },		/* overflow */
};

int main()
{
    int i;

    for (i = 0; i < sizeof(f32_i32_z)/sizeof(f32_i32_z[0]); i++) {
        float x;
        asm("frint32z %s0,%s1" : "=w"(x) : "w"(f32_i32_z[i][0]));
        if (x != f32_i32_z[i][1]) {
            printf("%-2d: frint(%a) -> %a != %a\n",
                   i, f32_i32_z[i][0], x, f32_i32_z[i][1]);
        }
    }

    for (i = 0; i < sizeof(f32_i64_z)/sizeof(f32_i64_z[0]); i++) {
        float x;
        asm("frint64z %s0,%s1" : "=w"(x) : "w"(f32_i64_z[i][0]));
        if (x != f32_i64_z[i][1]) {
            printf("%-2d: frint(%a) -> %a != %a\n",
                   i, f32_i64_z[i][0], x, f32_i64_z[i][1]);
        }
    }

    for (i = 0; i < sizeof(f64_i32_z)/sizeof(f64_i32_z[0]); i++) {
        double x;
        asm("frint32z %d0,%d1" : "=w"(x) : "w"(f64_i32_z[i][0]));
        if (x != f64_i32_z[i][1]) {
            printf("%-2d: frint(%a) -> %a != %a\n",
                   i, f64_i32_z[i][0], x, f64_i32_z[i][1]);
        }
    }

    for (i = 0; i < sizeof(f64_i64_z)/sizeof(f64_i64_z[0]); i++) {
        double x;
        asm("frint64z %d0,%d1" : "=w"(x) : "w"(f64_i64_z[i][0]));
        if (x != f64_i64_z[i][1]) {
            printf("%-2d: frint(%a) -> %a != %a\n",
                   i, f64_i64_z[i][0], x, f64_i64_z[i][1]);
        }
    }

    return 0;
}
