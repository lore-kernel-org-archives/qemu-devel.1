Received: from eggs.gnu.org ([2001:4830:134:3::10]:37602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZCI-0008I5-KM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZCD-0006VW-NO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:50:22 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTZCD-0006UD-Fj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:50:17 -0400
Received: by mail-pl0-x242.google.com with SMTP id w17-v6so4174341pll.9
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:50:17 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5306a800-705e-e184-8e30-623dfb29f689@linaro.org>
Date: Thu, 14 Jun 2018 10:50:12 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 22/22] risu_reginfo_aarch64: handle
 variable VQ
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

On 06/13/2018 02:56 AM, Alex Bennée wrote:
> @@ -147,12 +179,12 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>          }
>  
>          /* Finally the FFR */
> -        memcpy(&ri->sve.ffr,(void *)sve + SVE_SIG_FFR_OFFSET(vq),
> +        memcpy(&ri->sve.ffr, (void *)sve + SVE_SIG_FFR_OFFSET(vq),
>                 SVE_SIG_FFR_SIZE(vq));
>  
>          return;
>      }
> -#endif
> +#endif /* SVE_MAGIC */

It appears that most of the rest of this patch should be folded back earlier in
the patch set.


r~

>  
>      for (i = 0; i < 32; i++) {
>          ri->simd.vregs[i] = fp->vregs[i];
> @@ -166,32 +198,49 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
>  }
>  
>  #ifdef SVE_MAGIC
> -static int sve_zreg_is_eq(struct reginfo *r1, struct reginfo *r2, int z)
> +static int sve_zreg_is_eq(int vq, const void *z1, const void *z2)
>  {
> -    return memcmp(r1->sve.zregs[z], r2->sve.zregs[z], sizeof(*r1->sve.zregs[z])) == 0;
> +    return memcmp(z1, z2, vq * 16) == 0;
>  }
>  
> -static int sve_preg_is_eq(uint16_t const (*p1)[SVE_VQ_MAX],
> -                          uint16_t const (*p2)[SVE_VQ_MAX])
> +static int sve_preg_is_eq(int vq, const void *p1, const void *p2)
>  {
> -    return memcmp(p1, p2, sizeof *p1) == 0;
> +    return memcmp(p1, p2, vq * 2) == 0;
>  }
>  
> -static void sve_dump_preg_diff(FILE *f, int vq,
> -                               uint16_t const (*p1)[SVE_VQ_MAX],
> -                               uint16_t const (*p2)[SVE_VQ_MAX])
> +static void sve_dump_preg(FILE *f, int vq, const uint16_t *p)
>  {
>      int q;
> -
> -    for (q = 0; q < vq; q++) {
> -       fprintf(f, "%#04x", *p1[q]);
> +    for (q = vq - 1; q >= 0; q--) {
> +        fprintf(f, "%04x", p[q]);
>      }
> +}
> +
> +static void sve_dump_preg_diff(FILE *f, int vq, const uint16_t *p1,
> +                               const uint16_t *p2)
> +{
> +    sve_dump_preg(f, vq, p1);
>      fprintf(f, " vs ");
> -    for (q = 0; q < vq; q++) {
> -       fprintf(f, "%#04x", *p2[q]);
> -    }
> +    sve_dump_preg(f, vq, p2);
>      fprintf(f, "\n");
>  }
> +
> +static void sve_dump_zreg_diff(FILE *f, int vq, const __uint128_t *z1,
> +                               const __uint128_t *z2)
> +{
> +    const char *pad = "";
> +    int q;
> +
> +    for (q = 0; q < vq; ++q) {
> +        if (z1[q] != z2[q]) {
> +            fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64
> +                    " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
> +                    (uint64_t)(z1[q] >> 64), (uint64_t)z1[q],
> +                    (uint64_t)(z2[q] >> 64), (uint64_t)z2[q]);
> +            pad = "          ";
> +        }
> +    }
> +}
>  #endif
>  
>  /* reginfo_dump: print state to a stream, returns nonzero on success */
> @@ -210,6 +259,36 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
>      fprintf(f, "  fpsr  : %08x\n", ri->fpsr);
>      fprintf(f, "  fpcr  : %08x\n", ri->fpcr);
>  
> +#ifdef SVE_MAGIC
> +    if (test_sve) {
> +        int q, vq = test_sve;
> +
> +        fprintf(f, "  vl    : %d\n", ri->sve.vl);
> +
> +        for (i = 0; i < 32; i++) {
> +            fprintf(f, "  Z%-2d q%-2d: %016" PRIx64 "%016" PRIx64 "\n", i, 0,
> +                    (uint64_t)(ri->sve.zregs[i][0] >> 64),
> +                    (uint64_t)ri->sve.zregs[i][0]);
> +            for (q = 1; q < vq; ++q) {
> +                fprintf(f, "      q%-2d: %016" PRIx64 "%016" PRIx64 "\n", q,
> +                        (uint64_t)(ri->sve.zregs[i][q] >> 64),
> +                        (uint64_t)ri->sve.zregs[i][q]);
> +            }
> +        }
> +
> +        for (i = 0; i < 16; i++) {
> +            fprintf(f, "  P%-2d    : ", i);
> +            sve_dump_preg(f, vq, &ri->sve.pregs[i][0]);
> +            fprintf(f, "\n");
> +        }
> +        fprintf(f, "  FFR    : ");
> +        sve_dump_preg(f, vq, &ri->sve.ffr[0]);
> +        fprintf(f, "\n");
> +
> +        return !ferror(f);
> +    }
> +#endif
> +
>      for (i = 0; i < 32; i++) {
>          fprintf(f, "  V%-2d   : %016" PRIx64 "%016" PRIx64 "\n", i,
>                  (uint64_t) (ri->simd.vregs[i] >> 64),
> @@ -259,42 +338,29 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
>  
>  #ifdef SVE_MAGIC
>      if (test_sve) {
> -        struct sve_reginfo *ms = &m->sve;
> -        struct sve_reginfo *as = &a->sve;
> +        int vq = sve_vq_from_vl(m->sve.vl);
>  
> -        if (ms->vl != as->vl) {
> -            fprintf(f, "  SVE VL  : %d vs %d\n", ms->vl, as->vl);
> +        if (m->sve.vl != a->sve.vl) {
> +            fprintf(f, "  vl    : %d vs %d\n", m->sve.vl, a->sve.vl);
>          }
>  
> -        if (!sve_preg_is_eq(&ms->ffr, &as->ffr)) {
> -           fprintf(f, "  FFR   : ");
> -           sve_dump_preg_diff(f, sve_vq_from_vl(ms->vl),
> -                              &ms->pregs[i], &as->pregs[i]);
> +        for (i = 0; i < SVE_NUM_ZREGS; i++) {
> +            if (!sve_zreg_is_eq(vq, &m->sve.zregs[i], &a->sve.zregs[i])) {
> +                fprintf(f, "  Z%-2d   : ", i);
> +                sve_dump_zreg_diff(f, vq, &m->sve.zregs[i][0],
> +                                   &a->sve.zregs[i][0]);
> +            }
>          }
>          for (i = 0; i < SVE_NUM_PREGS; i++) {
> -           if (!sve_preg_is_eq(&ms->pregs[i], &as->pregs[i])) {
> -              fprintf(f, "  P%2d   : ", i);
> -              sve_dump_preg_diff(f, sve_vq_from_vl(ms->vl),
> -                                 &ms->pregs[i], &as->pregs[i]);
> -           }
> +            if (!sve_preg_is_eq(vq, &m->sve.pregs[i], &a->sve.pregs[i])) {
> +                fprintf(f, "  P%-2d   : ", i);
> +                sve_dump_preg_diff(f, vq, &m->sve.pregs[i][0],
> +                                   &a->sve.pregs[i][0]);
> +            }
>          }
> -        for (i = 0; i < SVE_NUM_ZREGS; i++) {
> -           if (!sve_zreg_is_eq(m, a, i)) {
> -              int q;
> -              char *pad="";
> -              fprintf(f, "  Z%2d   : ", i);
> -              for (q = 0; q < sve_vq_from_vl(ms->vl); q++) {
> -                 if (ms->zregs[i][q] != as->zregs[i][q]) {
> -                    fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64
> -                            " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
> -                            (uint64_t) (ms->zregs[i][q] >> 64),
> -                            (uint64_t) ms->zregs[i][q],
> -                            (uint64_t) (as->zregs[i][q] >> 64),
> -                            (uint64_t) as->zregs[i][q]);
> -                    pad = "          ";
> -                 }
> -              }
> -           }
> +        if (!sve_preg_is_eq(vq, &m->sve.ffr, &a->sve.ffr)) {
> +            fprintf(f, "  FFR   : ");
> +            sve_dump_preg_diff(f, vq, &m->sve.pregs[i][0], &a->sve.pregs[i][0]);
>          }
>  
>          return !ferror(f);
> 
