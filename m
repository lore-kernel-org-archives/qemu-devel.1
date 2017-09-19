Received: from eggs.gnu.org ([2001:4830:134:3::10]:56552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duMcd-0003M6-Qj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duMcZ-00062l-9O
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:47:47 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:49109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duMcZ-00061y-2l
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:47:43 -0400
Received: by mail-io0-x22f.google.com with SMTP id n69so945168ioi.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:47:42 -0700 (PDT)
References: <20170919142654.16369-1-david@redhat.com>
	<20170919142654.16369-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <452a304a-70e4-c3ab-2e76-a67823922e90@linaro.org>
Date: Tue, 19 Sep 2017 12:47:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170919142654.16369-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/tcg: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 09/19/2017 09:26 AM, David Hildenbrand wrote:
> +    const uint8_t fc = env->regs[0] & 0x7fULL;

Don't mask here...

> +    if (fc >= 128 || !test_be_bit(fc, subfunc)) {
> +        cpu_restore_state(cs, ra);
> +        program_interrupt(env, PGM_SPECIFICATION, 4);
> +        return 0;
> +    }

... because you are indeed supposed to test bit 56.  But you've already ensured
that won't be set above.

Do you in fact need to set bit 63 in subfunc, since that itself is query?
Certainly you won't get past this test, regardless...


> +static ExitStatus op_msa(DisasContext *s, DisasOps *o)
> +{
> +    int r1 = have_field(s->fields, r1) ? get_field(s->fields, r1) : 0;
> +    int r2 = have_field(s->fields, r2) ? get_field(s->fields, r2) : 0;
> +    int r3 = have_field(s->fields, r3) ? get_field(s->fields, r3) : 0;
> +    TCGv_i32 t_r1, t_r2, t_r3, type;
> +
> +    switch (s->insn->data) {
> +    case S390_FEAT_TYPE_KMCTR:
> +        if (r3 & 1 || !r3) {
> +            gen_program_exception(s, PGM_SPECIFICATION);
> +            return EXIT_NORETURN;
> +        }
> +        /* FALL THROUGH */
> +    case S390_FEAT_TYPE_PPNO:
> +    case S390_FEAT_TYPE_KMF:
> +    case S390_FEAT_TYPE_KMC:
> +    case S390_FEAT_TYPE_KMO:
> +    case S390_FEAT_TYPE_KM:
> +        if (r1 & 1 || !r1) {
> +            gen_program_exception(s, PGM_SPECIFICATION);
> +            return EXIT_NORETURN;
> +        }
> +        /* FALL THROUGH */
> +    case S390_FEAT_TYPE_KMAC:
> +    case S390_FEAT_TYPE_KIMD:
> +    case S390_FEAT_TYPE_KLMD:
> +        if (r2 & 1 || !r2) {
> +            gen_program_exception(s, PGM_SPECIFICATION);
> +            return EXIT_NORETURN;
> +        }

Even though it would be silly to do so, considering that r0+r1 are implicit
arguments to these insns, I see nothing that insists that r[123] are not 0,
only that they are even.


r~
