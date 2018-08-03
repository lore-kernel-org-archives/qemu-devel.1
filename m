Received: from eggs.gnu.org ([2001:4830:134:3::10]:52971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flgh9-0000wb-5H
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 16:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flgh6-0001Zm-3z
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 16:29:07 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1flgh5-0001Ze-Q2
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 16:29:04 -0400
Received: by mail-pf1-x444.google.com with SMTP id u24-v6so3799807pfn.13
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 13:29:03 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-46-git-send-email-aleksandar.markovic@rt-rk.com>
	<599465e2-9620-61a4-9a73-a8464c06cbab@linaro.org>
	<BN7PR08MB48688BC84CBE8C74D095A46AC62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<ec7bec8f-800b-6840-a6e7-c07e4d667f34@linaro.org>
	<BN7PR08MB48680C56DDDD8ED505E9DB97C62C0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<MWHPR08MB2493BC740B73E4F833D31524D2230@MWHPR08MB2493.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f5d46c5-7754-fed5-9dde-d5a6793c2bb1@linaro.org>
Date: Fri, 3 Aug 2018 13:28:59 -0700
MIME-Version: 1.0
In-Reply-To: <MWHPR08MB2493BC740B73E4F833D31524D2230@MWHPR08MB2493.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 45/76] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 08/03/2018 03:48 AM, Aleksandar Rikalo wrote:
>> > However, it looks there is a bigger problem now in SCWP. QEMU crashes with this message:
>> >
>> > /qemu/tcg/tcg.c:2862: tcg fatal error

I said remove all of the tcg_temp_local_new that were not necessary.
You removed one that was necessary.  This value is live across a branch.


r~


diff --git a/target/mips/translate.c b/target/mips/translate.c
index 8306986c86..b1525adff3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2473,7 +2473,7 @@ static void gen_st_cond
 static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
                     uint32_t reg1, uint32_t reg2)
 {
-    TCGv taddr = tcg_temp_new();
+    TCGv taddr = tcg_temp_local_new();
     TCGv lladdr = tcg_temp_new();
     TCGv_i64 tval = tcg_temp_new_i64();
     TCGv_i64 llval = tcg_temp_new_i64();
