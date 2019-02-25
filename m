Received: from eggs.gnu.org ([209.51.188.92]:57136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gyD9c-0008Qr-Ab
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gyD9W-0007vD-MM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:06:29 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1gyD9R-0007sW-O8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:06:21 -0500
Received: by mail-io1-xd43.google.com with SMTP id x3so7011041ior.6
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 02:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20190223012206.30498-1-richard.henderson@linaro.org>
In-Reply-To: <20190223012206.30498-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 25 Feb 2019 11:06:08 +0100
Message-ID: <CABoDooPYMDsznWyP=Tt9e9JwgTgUx_R=GebNFn7Cfr387shwOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: Implement ARMv8.5-FRINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi Richard,

On Sat, Feb 23, 2019 at 2:23 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: the ARMv8.2-FHM patch set, although I don't know that
> this is an actual dependency; it's just the tree I started with.
>
> There is not yet support for this extension within FVP, so I've
> self-tested it against my own understanding of what is supposed
> to go on with the file below.

I ran some tests and found no issue.  Your understanding looks correct :-)

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent


>
> r~
>
>
> Richard Henderson (2):
>   target/arm: Restructure handle_fp_1src_{single,double}
>   target/arm: Implement ARMv8.5-FRINT
>
>  target/arm/cpu.h           |   5 ++
>  target/arm/helper.h        |   5 ++
>  target/arm/cpu64.c         |   1 +
>  target/arm/translate-a64.c | 161 ++++++++++++++++++++++++++-----------
>  target/arm/vfp_helper.c    |  96 ++++++++++++++++++++++
>  5 files changed, 222 insertions(+), 46 deletions(-)
>
> --
>
> #include <stdio.h>
> #include <limits.h>
>
> asm(".arch armv8.5-a");
>
> static const float f32_i32_z[][2] = {
>     { 0, 0 },
>     { -0.0, -0.0 },
>     { 0.9, 0.0 },
>     { 1.0, 1.0 },
>     { 1.1, 1.0 },
>     { 1.9, 1.0 },
>     { 0x1.fffffep30, 0x1.fffffep30 },           /* 2^31 - epsilon */
>     { -0x1p31, -0x1.0p31 },                     /* -2^31 = INT32_MIN */
>     { 0x1.0p31, -0x1.0p31 },                    /* overflow */
>     { 0x1.0p32, -0x1.0p31 },                    /* overflow */
>     { -0x1.0p32, -0x1.0p31 },                   /* overflow */
>     { __builtin_inf(), -0x1.0p31 },             /* overflow */
> };
>
> static const double f64_i32_z[][2] = {
>     { 0, 0 },
>     { -0.0, -0.0 },
>     { 0.9, 0.0 },
>     { 1.0, 1.0 },
>     { 1.1, 1.0 },
>     { 1.9, 1.0 },
>     { 2147483647, 2147483647 },                 /* 2^31 - 1 = INT32_MAX */
>     { -0x1p31, -0x1.0p31 },                     /* -2^31 = INT32_MIN */
>     { 0x1.0p31, -0x1.0p31 },                    /* overflow */
>     { 0x1.0p32, -0x1.0p31 },                    /* overflow */
>     { -0x1.0p32, -0x1.0p31 },                   /* overflow */
>     { __builtin_inf(), -0x1.0p31 },             /* overflow */
> };
>
> static const float f32_i64_z[][2] = {
>     { 0, 0 },
>     { -0.0, -0.0 },
>     { 0.9, 0.0 },
>     { 1.0, 1.0 },
>     { 1.1, 1.0 },
>     { 1.9, 1.0 },
>     { 0x1.fffffep30, 0x1.fffffep30 },           /* 2^31 - epsilon */
>     { -0x1p31, -0x1.0p31 },                     /* -2^31 = INT32_MIN */
>     { 0x1.0p31, 0x1.0p31 },
>     { 0x1.0p32, 0x1.0p32 },
>     { -0x1.0p32, -0x1.0p32 },
>     { 0x1.0p62, 0x1.0p62 },
>     { 0x1.fffffep62, 0x1.fffffep62 },           /* 2^63 - epsilon */
>     { -0x1.0p63, -0x1.0p63 },                   /* -2^63 = INT64_MIN */
>     { 0x1.0p63, -0x1.0p63 },                    /* overflow */
>     { 0x1.0p64, -0x1.0p63 },                    /* overflow */
>     { -0x1.0p64, -0x1.0p63 },                   /* overflow */
>     { __builtin_inf(), -0x1.0p63 },             /* overflow */
> };
>
> static const double f64_i64_z[][2] = {
>     { 0, 0 },
>     { -0.0, -0.0 },
>     { 0.9, 0.0 },
>     { 1.0, 1.0 },
>     { 1.1, 1.0 },
>     { 1.9, 1.0 },
>     { 2147483647, 2147483647 },                 /* 2^31 - 1 = INT32_MAX */
>     { -0x1p31, -0x1.0p31 },                     /* -2^31 = INT32_MIN */
>     { 0x1.0p31, 0x1.0p31 },
>     { 0x1.0p32, 0x1.0p32 },
>     { -0x1.0p32, -0x1.0p32 },
>     { 0x1.0p62, 0x1.0p62 },
>     { 0x1.fffffffffffffp62, 0x1.fffffffffffffp62 }, /* 2^63 - epsilon */
>     { -0x1.0p63, -0x1.0p63 },                   /* -2^63 = INT64_MIN */
>     { 0x1.0p63, -0x1.0p63 },                    /* overflow */
>     { 0x1.0p64, -0x1.0p63 },                    /* overflow */
>     { -0x1.0p64, -0x1.0p63 },                   /* overflow */
>     { __builtin_inf(), -0x1.0p63 },             /* overflow */
> };
>
> int main()
> {
>     int i;
>
>     for (i = 0; i < sizeof(f32_i32_z)/sizeof(f32_i32_z[0]); i++) {
>         float x;
>         asm("frint32z %s0,%s1" : "=w"(x) : "w"(f32_i32_z[i][0]));
>         if (x != f32_i32_z[i][1]) {
>             printf("%-2d: frint(%a) -> %a != %a\n",
>                    i, f32_i32_z[i][0], x, f32_i32_z[i][1]);
>         }
>     }
>
>     for (i = 0; i < sizeof(f32_i64_z)/sizeof(f32_i64_z[0]); i++) {
>         float x;
>         asm("frint64z %s0,%s1" : "=w"(x) : "w"(f32_i64_z[i][0]));
>         if (x != f32_i64_z[i][1]) {
>             printf("%-2d: frint(%a) -> %a != %a\n",
>                    i, f32_i64_z[i][0], x, f32_i64_z[i][1]);
>         }
>     }
>
>     for (i = 0; i < sizeof(f64_i32_z)/sizeof(f64_i32_z[0]); i++) {
>         double x;
>         asm("frint32z %d0,%d1" : "=w"(x) : "w"(f64_i32_z[i][0]));
>         if (x != f64_i32_z[i][1]) {
>             printf("%-2d: frint(%a) -> %a != %a\n",
>                    i, f64_i32_z[i][0], x, f64_i32_z[i][1]);
>         }
>     }
>
>     for (i = 0; i < sizeof(f64_i64_z)/sizeof(f64_i64_z[0]); i++) {
>         double x;
>         asm("frint64z %d0,%d1" : "=w"(x) : "w"(f64_i64_z[i][0]));
>         if (x != f64_i64_z[i][1]) {
>             printf("%-2d: frint(%a) -> %a != %a\n",
>                    i, f64_i64_z[i][0], x, f64_i64_z[i][1]);
>         }
>     }
>
>     return 0;
> }
>
