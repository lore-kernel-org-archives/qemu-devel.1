Received: from eggs.gnu.org ([2001:4830:134:3::10]:33016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZ57-0005bb-Qa
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZ52-0000j7-Qh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:42:57 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTZ52-0000ig-Iv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:42:52 -0400
Received: by mail-pl0-x241.google.com with SMTP id w8-v6so2652198ply.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:42:52 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4bf792a8-d946-4f8c-fb54-4440587ed50d@linaro.org>
Date: Thu, 14 Jun 2018 10:42:46 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 20/22] risu_reginfo_aarch64: add
 SVE support to reginfo_dump_mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> +static void sve_dump_preg_diff(FILE *f, int vq,
> +                               uint16_t const (*p1)[SVE_VQ_MAX],
> +                               uint16_t const (*p2)[SVE_VQ_MAX])
> +{
> +    int q;
> +
> +    for (q = 0; q < vq; q++) {
> +       fprintf(f, "%#04x", *p1[q]);
> +    }
> +    fprintf(f, " vs ");
> +    for (q = 0; q < vq; q++) {
> +       fprintf(f, "%#04x", *p2[q]);

%# adds 0x into every 16-bit unit, so for vq=2 we get

  0xffff0xffff

Emit the 0x separately to start?

> +        for (i = 0; i < SVE_NUM_ZREGS; i++) {
> +           if (!sve_zreg_is_eq(m, a, i)) {
> +              int q;
> +              char *pad="";
> +              fprintf(f, "  Z%2d   : ", i);

%-2d?  %02d?

> +              for (q = 0; q < sve_vq_from_vl(ms->vl); q++) {
> +                 if (ms->zregs[i][q] != as->zregs[i][q]) {
> +                    fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64
> +                            " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,

Actually, another thing that has annoyed me in the past,
but apparently not quite enough to actually fix, is the
fact that reginfo_dump and reginfo_dump_mismatch have a
slightly different format for Zregs.

It's probably worth splitting those bits out to helper
functions so that they must match.


r~
