Received: from eggs.gnu.org ([2001:4830:134:3::10]:43108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2vfo-0007ul-EX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2vfk-0002Vl-Iu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:18:12 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2vfk-0002Vf-Bm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:18:08 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l9so2047012wre.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 01:18:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BD9E8ECB-EB56-45A9-89A4-C1506319A7BD@gmail.com>
References: <BD9E8ECB-EB56-45A9-89A4-C1506319A7BD@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 09:17:46 +0100
Message-ID: <CAFEAcA_PUdFS-gPncf9S6ZGyKGdotang=sM1EkE42M7OKTW16w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/9] Add risu_reginfo_ppc.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 25 April 2017 at 04:19, G 3 <programmingkidx@gmail.com> wrote:
> Add the risu_reginfo_ppc.c file. It handles operations involving the reginfo
> structure.

> +    /* check each floating point register */
> +    for (i = 0; i < NUMBER_OF_FPR; i++) {
> +        if (r1->fpr[i] != r2->fpr[i]) {
> +            if (!(isnan(r1->fpr[i]) && isnan(r2->fpr[i]))) {
> +                if ( fabs(r1->fpr[i] - r2->fpr[i]) < 0.000001) {
> +                    debug_print("float point register %d mismatch
> detected\n", i);
> +                    return 0;
> +                }

This is definitely wrong. Risu is supposed to check for exact
binary correctness, so you simply want to compare the binary
values of the FP regs, not check whether they're vaguely
close to the right answer.

> +/*
> + * Shows the classification of a floating point value.
> + * Input: floating point value
> + * Output: string description
> + */
> +const char *show_classification(double x) {
> +    switch(fpclassify(x)) {
> +        case FP_INFINITE:  return "Inf";
> +        case FP_NAN:       return "NaN";
> +        case FP_NORMAL:    return "normal";
> +        case FP_SUBNORMAL: return "subnormal";
> +        case FP_ZERO:      return "zero";
> +        default:           return "unknown";
> +    }
> +}

None of the other backends do this. If we want to do it
(and I'm not convinced it's worth the effort) we should
do it consistently everywhere.

thanks
-- PMM
