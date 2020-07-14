Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC933C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1F122510
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaHp6sta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1F122510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLeI-0003I2-T4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvLdY-0002eI-8s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:10:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvLdT-00058Q-AN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594735817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQw0TNnZAKzE6cZlYgAIVBs1pE8CtxL9hMk4xtKC0Qw=;
 b=VaHp6staR/y3QOpZuwbX57+JEekUsrGWB++iiPOF7VKPQGdYFN5Upl9lAXUfTxzHU9Z2Yf
 ulA3isexzJFS/zchm2mgWP31CxMH6+T1ToPn73Hwko+EBP5hn5GnLGJXIY1wfDtuxS3Wu2
 RKk73iepBajZc2kzqAlp6PNbBA7NpX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-4aElnU-kPh2i12NjSyNYMA-1; Tue, 14 Jul 2020 10:09:59 -0400
X-MC-Unique: 4aElnU-kPh2i12NjSyNYMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE77E18C63C2;
 Tue, 14 Jul 2020 14:09:58 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-110.ams2.redhat.com
 [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C35219C4F;
 Tue, 14 Jul 2020 14:09:57 +0000 (UTC)
Subject: Re: [PULL 14/31] target/i386: reimplement f2xm1 using floatx80
 operations
To: Paolo Bonzini <pbonzini@redhat.com>, Joseph Myers <joseph@codesourcery.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
 <20200624105048.375353-14-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a3302e58-c470-9305-b106-a2b6b2c52d39@redhat.com>
Date: Tue, 14 Jul 2020 16:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200624105048.375353-14-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/24/20 12:50, Paolo Bonzini wrote:
> From: Joseph Myers <joseph@codesourcery.com>
>
> The x87 f2xm1 emulation is currently based around conversion to
> double.  This is inherently unsuitable for a good emulation of any
> floatx80 operation, even before considering that it is a particularly
> naive implementation using double (computing with pow and then
> subtracting 1 rather than attempting a better emulation using expm1).
>
> Reimplement using the soft-float operations, including additions and
> multiplications with higher precision where appropriate to limit
> accumulation of errors.  I considered reusing some of the m68k code
> for transcendental operations, but the instructions don't generally
> correspond exactly to x87 operations (for example, m68k has 2^x and
> e^x - 1, but not 2^x - 1); to avoid possible accumulation of errors
> from applying multiple such operations each rounding to floatx80
> precision, I wrote a direct implementation of 2^x - 1 instead.  It
> would be possible in principle to make the implementation more
> efficient by doing the intermediate operations directly with
> significands, signs and exponents and not packing / unpacking floatx80
> format for each operation, but that would make it significantly more
> complicated and it's not clear that's worthwhile; the m68k emulation
> doesn't try to do that.
>
> A test is included with many randomly generated inputs.  The
> assumption of the test is that the result in round-to-nearest mode
> should always be one of the two closest floating-point numbers to the
> mathematical value of 2^x - 1; the implementation aims to do somewhat
> better than that (about 70 correct bits before rounding).  I haven't
> investigated how accurate hardware is.
>
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
>
> Message-Id: <alpine.DEB.2.21.2006112341010.18393@digraph.polyomino.org.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/fpu_helper.c         |  385 +++++++++-
>  tests/tcg/i386/test-i386-f2xm1.c | 1140 ++++++++++++++++++++++++++++++
>  2 files changed, 1522 insertions(+), 3 deletions(-)
>  create mode 100644 tests/tcg/i386/test-i386-f2xm1.c
>
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index 8ef5b463ea..e32a2aa74b 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -25,6 +25,7 @@
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
>  #include "fpu/softfloat.h"
> +#include "fpu/softfloat-macros.h"
>
>  #ifdef CONFIG_SOFTMMU
>  #include "hw/irq.h"
> @@ -836,12 +837,390 @@ void helper_fbst_ST0(CPUX86State *env, target_ulong ptr)
>      merge_exception_flags(env, old_flags);
>  }
>
> +/* 128-bit significand of log(2).  */
> +#define ln2_sig_high 0xb17217f7d1cf79abULL
> +#define ln2_sig_low 0xc9e3b39803f2f6afULL
> +
> +/*
> + * Polynomial coefficients for an approximation to (2^x - 1) / x, on
> + * the interval [-1/64, 1/64].
> + */
> +#define f2xm1_coeff_0 make_floatx80(0x3ffe, 0xb17217f7d1cf79acULL)
> +#define f2xm1_coeff_0_low make_floatx80(0xbfbc, 0xd87edabf495b3762ULL)
> +#define f2xm1_coeff_1 make_floatx80(0x3ffc, 0xf5fdeffc162c7543ULL)
> +#define f2xm1_coeff_2 make_floatx80(0x3ffa, 0xe35846b82505fcc7ULL)
> +#define f2xm1_coeff_3 make_floatx80(0x3ff8, 0x9d955b7dd273b899ULL)
> +#define f2xm1_coeff_4 make_floatx80(0x3ff5, 0xaec3ff3c4ef4ac0cULL)
> +#define f2xm1_coeff_5 make_floatx80(0x3ff2, 0xa184897c3a7f0de9ULL)
> +#define f2xm1_coeff_6 make_floatx80(0x3fee, 0xffe634d0ec30d504ULL)
> +#define f2xm1_coeff_7 make_floatx80(0x3feb, 0xb160111d2db515e4ULL)
> +
> +struct f2xm1_data {
> +    /*
> +     * A value very close to a multiple of 1/32, such that 2^t and 2^t - 1
> +     * are very close to exact floatx80 values.
> +     */
> +    floatx80 t;
> +    /* The value of 2^t.  */
> +    floatx80 exp2;
> +    /* The value of 2^t - 1.  */
> +    floatx80 exp2m1;
> +};
> +
> +static const struct f2xm1_data f2xm1_table[65] = {
> +    { make_floatx80(0xbfff, 0x8000000000000000ULL),

This line (in commit eca30647fc07, "target/i386: reimplement f2xm1 using
floatx80 operations", 2020-06-26) causes a build failure for me, with
gcc-4.8 (on RHEL-7.6):

> target/i386/fpu_helper.c:871:5: error: initializer element is not constant
>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>      ^

The macro is defined as follows:

  #define make_floatx80(exp, mant) ((floatx80) { mant, exp })

with floatx80 being:

  typedef struct {
      uint64_t low;
      uint16_t high;
  } floatx80;

The macro produces a compound literal. While the compound literal occurs
outside of the body of a function, and thus has static storage duration
(per ISO C99 6.5.2.5p6), it is not a constant expression.

The array object "f2xm1_table" has static storage duration, and "All the
expressions in an initializer for an object that has static storage
duration shall be constant expressions or string literals" (ISO C99
6.7.8p4).

Per ISO C99 6.6:

> 7 More latitude is permitted for constant expressions in initializers.
>   Such a constant expression shall be, or evaluate to, one of the
>   following:
>   - an arithmetic constant expression,
>   - a null pointer constant,
>   - an address constant, or
>   - an address constant for an object type plus or minus an integer
>     constant expression.
>
> 8 An arithmetic constant expression shall have arithmetic type and
>   shall only have operands that are integer constants, floating
>   constants, enumeration constants, character constants, and sizeof
>   expressions. Cast operators in an arithmetic constant expression
>   shall only convert arithmetic types to arithmetic types, except as
>   part of an operand to a sizeof operator whose result is an integer
>   constant.
>
> 9 An address constant is a null pointer, a pointer to an lvalue
>   designating an object of static storage duration, or a pointer to a
>   function designator; it shall be created explicitly using the unary
>   & operator or an integer constant cast to pointer type, or
>   implicitly by the use of an expression of array or function type.
>   The array-subscript [] and member-access . and -> operators, the
>   address & and indirection * unary operators, and pointer casts may
>   be used in the creation of an address constant, but the value of an
>   object shall not be accessed by use of these operators.
>
> 10 An implementation may accept other forms of constant expressions.

So at best the code is implementation-dependent.


It shouldn't be hard to fix, by re-dedicating the macro to initializer
context:

  #define make_floatx80(exp, mant) { mant, exp }

and, if desirable, by introducing a new macro for where a compound
literal is really needed:

  #define make_floatx80_lit(exp, mant) ((floatx80) make_floatx80(exp, mant))


This issue has popped up before:

  http://mid.mail-archive.com/1cf6ce88-0dd4-6d40-60bf-8b78f02a2fa0@redhat.com
  (alt link: <https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html>)

Apologies if a patch is already on the list (I couldn't find it, by
searching for subjects with "float".)


... Ugh, wait, we already have:

  #define make_floatx80_init(exp, mant) { .low = mant, .high = exp }

namely from from commit 3bf7e40ab914 ("softfloat: fix for C99",
2012-03-17):

> commit 3bf7e40ab9140e577a6e7e17d3f5711b28aed833
> Author: Avi Kivity <avi@redhat.com>
> Date:   Tue Dec 27 17:11:20 2011 +0200
>
>     softfloat: fix for C99
>
>     C99 appears to consider compound literals as non-constants, and complains
>     when they are used in static initializers.  Switch to ordinary initializer
>     syntax.
>
>     Signed-off-by: Avi Kivity <avi@redhat.com>
>     Acked-by: Andreas Färber <afaerber@suse.de>
>     Reported-by: Andreas Färber <andreas.faerber@web.de>
>     Signed-off-by: Blue Swirl <blauwirbel@gmail.com>

So the issue is indeed in commit eca30647fc07; the initializer elements
for the static array should have been provided with
make_floatx80_init(), not make_floatx80().

The same applies to commit ff57bb7b6326 ("target/i386: reimplement
fpatan using floatx80 operations", 2020-06-26), which introduces
"fpatan_table" with the same problem.


The following lets me build QEMU:

> commit ec4da236aad8d243ea76c8baee6c1737a48f4453
> Author: Laszlo Ersek <lersek@redhat.com>
> Date:   Tue Jul 14 15:43:04 2020 +0200
>
>     fix eca30647fc07 and ff57bb7b63267
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index f1a19df066b7..659218b5c787 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -822,6 +822,7 @@ static inline bool floatx80_invalid_encoding(floatx80 a)
>  }
>
>  #define floatx80_zero make_floatx80(0x0000, 0x0000000000000000LL)
> +#define floatx80_zero_init make_floatx80_init(0x0000, 0x0000000000000000LL)
>  #define floatx80_one make_floatx80(0x3fff, 0x8000000000000000LL)
>  #define floatx80_ln2 make_floatx80(0x3ffe, 0xb17217f7d1cf79acLL)
>  #define floatx80_pi make_floatx80(0x4000, 0xc90fdaa22168c235LL)
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index f5e6c4b88d4e..4ea73874d836 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -868,201 +868,201 @@ struct f2xm1_data {
>  };
>
>  static const struct f2xm1_data f2xm1_table[65] = {
> -    { make_floatx80(0xbfff, 0x8000000000000000ULL),
> -      make_floatx80(0x3ffe, 0x8000000000000000ULL),
> -      make_floatx80(0xbffe, 0x8000000000000000ULL) },
> -    { make_floatx80(0xbffe, 0xf800000000002e7eULL),
> -      make_floatx80(0x3ffe, 0x82cd8698ac2b9160ULL),
> -      make_floatx80(0xbffd, 0xfa64f2cea7a8dd40ULL) },
> -    { make_floatx80(0xbffe, 0xefffffffffffe960ULL),
> -      make_floatx80(0x3ffe, 0x85aac367cc488345ULL),
> -      make_floatx80(0xbffd, 0xf4aa7930676ef976ULL) },
> -    { make_floatx80(0xbffe, 0xe800000000006f10ULL),
> -      make_floatx80(0x3ffe, 0x88980e8092da5c14ULL),
> -      make_floatx80(0xbffd, 0xeecfe2feda4b47d8ULL) },
> -    { make_floatx80(0xbffe, 0xe000000000008a45ULL),
> -      make_floatx80(0x3ffe, 0x8b95c1e3ea8ba2a5ULL),
> -      make_floatx80(0xbffd, 0xe8d47c382ae8bab6ULL) },
> -    { make_floatx80(0xbffe, 0xd7ffffffffff8a9eULL),
> -      make_floatx80(0x3ffe, 0x8ea4398b45cd8116ULL),
> -      make_floatx80(0xbffd, 0xe2b78ce97464fdd4ULL) },
> -    { make_floatx80(0xbffe, 0xd0000000000019a0ULL),
> -      make_floatx80(0x3ffe, 0x91c3d373ab11b919ULL),
> -      make_floatx80(0xbffd, 0xdc785918a9dc8dceULL) },
> -    { make_floatx80(0xbffe, 0xc7ffffffffff14dfULL),
> -      make_floatx80(0x3ffe, 0x94f4efa8fef76836ULL),
> -      make_floatx80(0xbffd, 0xd61620ae02112f94ULL) },
> -    { make_floatx80(0xbffe, 0xc000000000006530ULL),
> -      make_floatx80(0x3ffe, 0x9837f0518db87fbbULL),
> -      make_floatx80(0xbffd, 0xcf901f5ce48f008aULL) },
> -    { make_floatx80(0xbffe, 0xb7ffffffffff1723ULL),
> -      make_floatx80(0x3ffe, 0x9b8d39b9d54eb74cULL),
> -      make_floatx80(0xbffd, 0xc8e58c8c55629168ULL) },
> -    { make_floatx80(0xbffe, 0xb00000000000b5e1ULL),
> -      make_floatx80(0x3ffe, 0x9ef5326091a0c366ULL),
> -      make_floatx80(0xbffd, 0xc2159b3edcbe7934ULL) },
> -    { make_floatx80(0xbffe, 0xa800000000006f8aULL),
> -      make_floatx80(0x3ffe, 0xa27043030c49370aULL),
> -      make_floatx80(0xbffd, 0xbb1f79f9e76d91ecULL) },
> -    { make_floatx80(0xbffe, 0x9fffffffffff816aULL),
> -      make_floatx80(0x3ffe, 0xa5fed6a9b15171cfULL),
> -      make_floatx80(0xbffd, 0xb40252ac9d5d1c62ULL) },
> -    { make_floatx80(0xbffe, 0x97ffffffffffb621ULL),
> -      make_floatx80(0x3ffe, 0xa9a15ab4ea7c30e6ULL),
> -      make_floatx80(0xbffd, 0xacbd4a962b079e34ULL) },
> -    { make_floatx80(0xbffe, 0x8fffffffffff162bULL),
> -      make_floatx80(0x3ffe, 0xad583eea42a1b886ULL),
> -      make_floatx80(0xbffd, 0xa54f822b7abc8ef4ULL) },
> -    { make_floatx80(0xbffe, 0x87ffffffffff4d34ULL),
> -      make_floatx80(0x3ffe, 0xb123f581d2ac7b51ULL),
> -      make_floatx80(0xbffd, 0x9db814fc5aa7095eULL) },
> -    { make_floatx80(0xbffe, 0x800000000000227dULL),
> -      make_floatx80(0x3ffe, 0xb504f333f9de539dULL),
> -      make_floatx80(0xbffd, 0x95f619980c4358c6ULL) },
> -    { make_floatx80(0xbffd, 0xefffffffffff3978ULL),
> -      make_floatx80(0x3ffe, 0xb8fbaf4762fbd0a1ULL),
> -      make_floatx80(0xbffd, 0x8e08a1713a085ebeULL) },
> -    { make_floatx80(0xbffd, 0xe00000000000df81ULL),
> -      make_floatx80(0x3ffe, 0xbd08a39f580bfd8cULL),
> -      make_floatx80(0xbffd, 0x85eeb8c14fe804e8ULL) },
> -    { make_floatx80(0xbffd, 0xd00000000000bccfULL),
> -      make_floatx80(0x3ffe, 0xc12c4cca667062f6ULL),
> -      make_floatx80(0xbffc, 0xfb4eccd6663e7428ULL) },
> -    { make_floatx80(0xbffd, 0xc00000000000eff0ULL),
> -      make_floatx80(0x3ffe, 0xc5672a1155069abeULL),
> -      make_floatx80(0xbffc, 0xea6357baabe59508ULL) },
> -    { make_floatx80(0xbffd, 0xb000000000000fe6ULL),
> -      make_floatx80(0x3ffe, 0xc9b9bd866e2f234bULL),
> -      make_floatx80(0xbffc, 0xd91909e6474372d4ULL) },
> -    { make_floatx80(0xbffd, 0x9fffffffffff2172ULL),
> -      make_floatx80(0x3ffe, 0xce248c151f84bf00ULL),
> -      make_floatx80(0xbffc, 0xc76dcfab81ed0400ULL) },
> -    { make_floatx80(0xbffd, 0x8fffffffffffafffULL),
> -      make_floatx80(0x3ffe, 0xd2a81d91f12afb2bULL),
> -      make_floatx80(0xbffc, 0xb55f89b83b541354ULL) },
> -    { make_floatx80(0xbffc, 0xffffffffffff81a3ULL),
> -      make_floatx80(0x3ffe, 0xd744fccad69d7d5eULL),
> -      make_floatx80(0xbffc, 0xa2ec0cd4a58a0a88ULL) },
> -    { make_floatx80(0xbffc, 0xdfffffffffff1568ULL),
> -      make_floatx80(0x3ffe, 0xdbfbb797daf25a44ULL),
> -      make_floatx80(0xbffc, 0x901121a0943696f0ULL) },
> -    { make_floatx80(0xbffc, 0xbfffffffffff68daULL),
> -      make_floatx80(0x3ffe, 0xe0ccdeec2a94f811ULL),
> -      make_floatx80(0xbffb, 0xf999089eab583f78ULL) },
> -    { make_floatx80(0xbffc, 0x9fffffffffff4690ULL),
> -      make_floatx80(0x3ffe, 0xe5b906e77c83657eULL),
> -      make_floatx80(0xbffb, 0xd237c8c41be4d410ULL) },
> -    { make_floatx80(0xbffb, 0xffffffffffff8aeeULL),
> -      make_floatx80(0x3ffe, 0xeac0c6e7dd24427cULL),
> -      make_floatx80(0xbffb, 0xa9f9c8c116ddec20ULL) },
> -    { make_floatx80(0xbffb, 0xbfffffffffff2d18ULL),
> -      make_floatx80(0x3ffe, 0xefe4b99bdcdb06ebULL),
> -      make_floatx80(0xbffb, 0x80da33211927c8a8ULL) },
> -    { make_floatx80(0xbffa, 0xffffffffffff8ccbULL),
> -      make_floatx80(0x3ffe, 0xf5257d152486d0f4ULL),
> -      make_floatx80(0xbffa, 0xada82eadb792f0c0ULL) },
> -    { make_floatx80(0xbff9, 0xffffffffffff11feULL),
> -      make_floatx80(0x3ffe, 0xfa83b2db722a0846ULL),
> -      make_floatx80(0xbff9, 0xaf89a491babef740ULL) },
> -    { floatx80_zero,
> -      make_floatx80(0x3fff, 0x8000000000000000ULL),
> -      floatx80_zero },
> -    { make_floatx80(0x3ff9, 0xffffffffffff2680ULL),
> -      make_floatx80(0x3fff, 0x82cd8698ac2b9f6fULL),
> -      make_floatx80(0x3ff9, 0xb361a62b0ae7dbc0ULL) },
> -    { make_floatx80(0x3ffb, 0x800000000000b500ULL),
> -      make_floatx80(0x3fff, 0x85aac367cc488345ULL),
> -      make_floatx80(0x3ffa, 0xb5586cf9891068a0ULL) },
> -    { make_floatx80(0x3ffb, 0xbfffffffffff4b67ULL),
> -      make_floatx80(0x3fff, 0x88980e8092da7cceULL),
> -      make_floatx80(0x3ffb, 0x8980e8092da7cce0ULL) },
> -    { make_floatx80(0x3ffb, 0xffffffffffffff57ULL),
> -      make_floatx80(0x3fff, 0x8b95c1e3ea8bd6dfULL),
> -      make_floatx80(0x3ffb, 0xb95c1e3ea8bd6df0ULL) },
> -    { make_floatx80(0x3ffc, 0x9fffffffffff811fULL),
> -      make_floatx80(0x3fff, 0x8ea4398b45cd4780ULL),
> -      make_floatx80(0x3ffb, 0xea4398b45cd47800ULL) },
> -    { make_floatx80(0x3ffc, 0xbfffffffffff9980ULL),
> -      make_floatx80(0x3fff, 0x91c3d373ab11b919ULL),
> -      make_floatx80(0x3ffc, 0x8e1e9b9d588dc8c8ULL) },
> -    { make_floatx80(0x3ffc, 0xdffffffffffff631ULL),
> -      make_floatx80(0x3fff, 0x94f4efa8fef70864ULL),
> -      make_floatx80(0x3ffc, 0xa7a77d47f7b84320ULL) },
> -    { make_floatx80(0x3ffc, 0xffffffffffff2499ULL),
> -      make_floatx80(0x3fff, 0x9837f0518db892d4ULL),
> -      make_floatx80(0x3ffc, 0xc1bf828c6dc496a0ULL) },
> -    { make_floatx80(0x3ffd, 0x8fffffffffff80fbULL),
> -      make_floatx80(0x3fff, 0x9b8d39b9d54e3a79ULL),
> -      make_floatx80(0x3ffc, 0xdc69cdceaa71d3c8ULL) },
> -    { make_floatx80(0x3ffd, 0x9fffffffffffbc23ULL),
> -      make_floatx80(0x3fff, 0x9ef5326091a10313ULL),
> -      make_floatx80(0x3ffc, 0xf7a993048d081898ULL) },
> -    { make_floatx80(0x3ffd, 0xafffffffffff20ecULL),
> -      make_floatx80(0x3fff, 0xa27043030c49370aULL),
> -      make_floatx80(0x3ffd, 0x89c10c0c3124dc28ULL) },
> -    { make_floatx80(0x3ffd, 0xc00000000000fd2cULL),
> -      make_floatx80(0x3fff, 0xa5fed6a9b15171cfULL),
> -      make_floatx80(0x3ffd, 0x97fb5aa6c545c73cULL) },
> -    { make_floatx80(0x3ffd, 0xd0000000000093beULL),
> -      make_floatx80(0x3fff, 0xa9a15ab4ea7c30e6ULL),
> -      make_floatx80(0x3ffd, 0xa6856ad3a9f0c398ULL) },
> -    { make_floatx80(0x3ffd, 0xe00000000000c2aeULL),
> -      make_floatx80(0x3fff, 0xad583eea42a17876ULL),
> -      make_floatx80(0x3ffd, 0xb560fba90a85e1d8ULL) },
> -    { make_floatx80(0x3ffd, 0xefffffffffff1e3fULL),
> -      make_floatx80(0x3fff, 0xb123f581d2abef6cULL),
> -      make_floatx80(0x3ffd, 0xc48fd6074aafbdb0ULL) },
> -    { make_floatx80(0x3ffd, 0xffffffffffff1c23ULL),
> -      make_floatx80(0x3fff, 0xb504f333f9de2cadULL),
> -      make_floatx80(0x3ffd, 0xd413cccfe778b2b4ULL) },
> -    { make_floatx80(0x3ffe, 0x8800000000006344ULL),
> -      make_floatx80(0x3fff, 0xb8fbaf4762fbd0a1ULL),
> -      make_floatx80(0x3ffd, 0xe3eebd1d8bef4284ULL) },
> -    { make_floatx80(0x3ffe, 0x9000000000005d67ULL),
> -      make_floatx80(0x3fff, 0xbd08a39f580c668dULL),
> -      make_floatx80(0x3ffd, 0xf4228e7d60319a34ULL) },
> -    { make_floatx80(0x3ffe, 0x9800000000009127ULL),
> -      make_floatx80(0x3fff, 0xc12c4cca6670e042ULL),
> -      make_floatx80(0x3ffe, 0x82589994cce1c084ULL) },
> -    { make_floatx80(0x3ffe, 0x9fffffffffff06f9ULL),
> -      make_floatx80(0x3fff, 0xc5672a11550655c3ULL),
> -      make_floatx80(0x3ffe, 0x8ace5422aa0cab86ULL) },
> -    { make_floatx80(0x3ffe, 0xa7fffffffffff80dULL),
> -      make_floatx80(0x3fff, 0xc9b9bd866e2f234bULL),
> -      make_floatx80(0x3ffe, 0x93737b0cdc5e4696ULL) },
> -    { make_floatx80(0x3ffe, 0xafffffffffff1470ULL),
> -      make_floatx80(0x3fff, 0xce248c151f83fd69ULL),
> -      make_floatx80(0x3ffe, 0x9c49182a3f07fad2ULL) },
> -    { make_floatx80(0x3ffe, 0xb800000000000e0aULL),
> -      make_floatx80(0x3fff, 0xd2a81d91f12aec5cULL),
> -      make_floatx80(0x3ffe, 0xa5503b23e255d8b8ULL) },
> -    { make_floatx80(0x3ffe, 0xc00000000000b7faULL),
> -      make_floatx80(0x3fff, 0xd744fccad69dd630ULL),
> -      make_floatx80(0x3ffe, 0xae89f995ad3bac60ULL) },
> -    { make_floatx80(0x3ffe, 0xc800000000003aa6ULL),
> -      make_floatx80(0x3fff, 0xdbfbb797daf25a44ULL),
> -      make_floatx80(0x3ffe, 0xb7f76f2fb5e4b488ULL) },
> -    { make_floatx80(0x3ffe, 0xd00000000000a6aeULL),
> -      make_floatx80(0x3fff, 0xe0ccdeec2a954685ULL),
> -      make_floatx80(0x3ffe, 0xc199bdd8552a8d0aULL) },
> -    { make_floatx80(0x3ffe, 0xd800000000004165ULL),
> -      make_floatx80(0x3fff, 0xe5b906e77c837155ULL),
> -      make_floatx80(0x3ffe, 0xcb720dcef906e2aaULL) },
> -    { make_floatx80(0x3ffe, 0xe00000000000582cULL),
> -      make_floatx80(0x3fff, 0xeac0c6e7dd24713aULL),
> -      make_floatx80(0x3ffe, 0xd5818dcfba48e274ULL) },
> -    { make_floatx80(0x3ffe, 0xe800000000001a5dULL),
> -      make_floatx80(0x3fff, 0xefe4b99bdcdb06ebULL),
> -      make_floatx80(0x3ffe, 0xdfc97337b9b60dd6ULL) },
> -    { make_floatx80(0x3ffe, 0xefffffffffffc1efULL),
> -      make_floatx80(0x3fff, 0xf5257d152486a2faULL),
> -      make_floatx80(0x3ffe, 0xea4afa2a490d45f4ULL) },
> -    { make_floatx80(0x3ffe, 0xf800000000001069ULL),
> -      make_floatx80(0x3fff, 0xfa83b2db722a0e5cULL),
> -      make_floatx80(0x3ffe, 0xf50765b6e4541cb8ULL) },
> -    { make_floatx80(0x3fff, 0x8000000000000000ULL),
> -      make_floatx80(0x4000, 0x8000000000000000ULL),
> -      make_floatx80(0x3fff, 0x8000000000000000ULL) },
> +    { make_floatx80_init(0xbfff, 0x8000000000000000ULL),
> +      make_floatx80_init(0x3ffe, 0x8000000000000000ULL),
> +      make_floatx80_init(0xbffe, 0x8000000000000000ULL) },
> +    { make_floatx80_init(0xbffe, 0xf800000000002e7eULL),
> +      make_floatx80_init(0x3ffe, 0x82cd8698ac2b9160ULL),
> +      make_floatx80_init(0xbffd, 0xfa64f2cea7a8dd40ULL) },
> +    { make_floatx80_init(0xbffe, 0xefffffffffffe960ULL),
> +      make_floatx80_init(0x3ffe, 0x85aac367cc488345ULL),
> +      make_floatx80_init(0xbffd, 0xf4aa7930676ef976ULL) },
> +    { make_floatx80_init(0xbffe, 0xe800000000006f10ULL),
> +      make_floatx80_init(0x3ffe, 0x88980e8092da5c14ULL),
> +      make_floatx80_init(0xbffd, 0xeecfe2feda4b47d8ULL) },
> +    { make_floatx80_init(0xbffe, 0xe000000000008a45ULL),
> +      make_floatx80_init(0x3ffe, 0x8b95c1e3ea8ba2a5ULL),
> +      make_floatx80_init(0xbffd, 0xe8d47c382ae8bab6ULL) },
> +    { make_floatx80_init(0xbffe, 0xd7ffffffffff8a9eULL),
> +      make_floatx80_init(0x3ffe, 0x8ea4398b45cd8116ULL),
> +      make_floatx80_init(0xbffd, 0xe2b78ce97464fdd4ULL) },
> +    { make_floatx80_init(0xbffe, 0xd0000000000019a0ULL),
> +      make_floatx80_init(0x3ffe, 0x91c3d373ab11b919ULL),
> +      make_floatx80_init(0xbffd, 0xdc785918a9dc8dceULL) },
> +    { make_floatx80_init(0xbffe, 0xc7ffffffffff14dfULL),
> +      make_floatx80_init(0x3ffe, 0x94f4efa8fef76836ULL),
> +      make_floatx80_init(0xbffd, 0xd61620ae02112f94ULL) },
> +    { make_floatx80_init(0xbffe, 0xc000000000006530ULL),
> +      make_floatx80_init(0x3ffe, 0x9837f0518db87fbbULL),
> +      make_floatx80_init(0xbffd, 0xcf901f5ce48f008aULL) },
> +    { make_floatx80_init(0xbffe, 0xb7ffffffffff1723ULL),
> +      make_floatx80_init(0x3ffe, 0x9b8d39b9d54eb74cULL),
> +      make_floatx80_init(0xbffd, 0xc8e58c8c55629168ULL) },
> +    { make_floatx80_init(0xbffe, 0xb00000000000b5e1ULL),
> +      make_floatx80_init(0x3ffe, 0x9ef5326091a0c366ULL),
> +      make_floatx80_init(0xbffd, 0xc2159b3edcbe7934ULL) },
> +    { make_floatx80_init(0xbffe, 0xa800000000006f8aULL),
> +      make_floatx80_init(0x3ffe, 0xa27043030c49370aULL),
> +      make_floatx80_init(0xbffd, 0xbb1f79f9e76d91ecULL) },
> +    { make_floatx80_init(0xbffe, 0x9fffffffffff816aULL),
> +      make_floatx80_init(0x3ffe, 0xa5fed6a9b15171cfULL),
> +      make_floatx80_init(0xbffd, 0xb40252ac9d5d1c62ULL) },
> +    { make_floatx80_init(0xbffe, 0x97ffffffffffb621ULL),
> +      make_floatx80_init(0x3ffe, 0xa9a15ab4ea7c30e6ULL),
> +      make_floatx80_init(0xbffd, 0xacbd4a962b079e34ULL) },
> +    { make_floatx80_init(0xbffe, 0x8fffffffffff162bULL),
> +      make_floatx80_init(0x3ffe, 0xad583eea42a1b886ULL),
> +      make_floatx80_init(0xbffd, 0xa54f822b7abc8ef4ULL) },
> +    { make_floatx80_init(0xbffe, 0x87ffffffffff4d34ULL),
> +      make_floatx80_init(0x3ffe, 0xb123f581d2ac7b51ULL),
> +      make_floatx80_init(0xbffd, 0x9db814fc5aa7095eULL) },
> +    { make_floatx80_init(0xbffe, 0x800000000000227dULL),
> +      make_floatx80_init(0x3ffe, 0xb504f333f9de539dULL),
> +      make_floatx80_init(0xbffd, 0x95f619980c4358c6ULL) },
> +    { make_floatx80_init(0xbffd, 0xefffffffffff3978ULL),
> +      make_floatx80_init(0x3ffe, 0xb8fbaf4762fbd0a1ULL),
> +      make_floatx80_init(0xbffd, 0x8e08a1713a085ebeULL) },
> +    { make_floatx80_init(0xbffd, 0xe00000000000df81ULL),
> +      make_floatx80_init(0x3ffe, 0xbd08a39f580bfd8cULL),
> +      make_floatx80_init(0xbffd, 0x85eeb8c14fe804e8ULL) },
> +    { make_floatx80_init(0xbffd, 0xd00000000000bccfULL),
> +      make_floatx80_init(0x3ffe, 0xc12c4cca667062f6ULL),
> +      make_floatx80_init(0xbffc, 0xfb4eccd6663e7428ULL) },
> +    { make_floatx80_init(0xbffd, 0xc00000000000eff0ULL),
> +      make_floatx80_init(0x3ffe, 0xc5672a1155069abeULL),
> +      make_floatx80_init(0xbffc, 0xea6357baabe59508ULL) },
> +    { make_floatx80_init(0xbffd, 0xb000000000000fe6ULL),
> +      make_floatx80_init(0x3ffe, 0xc9b9bd866e2f234bULL),
> +      make_floatx80_init(0xbffc, 0xd91909e6474372d4ULL) },
> +    { make_floatx80_init(0xbffd, 0x9fffffffffff2172ULL),
> +      make_floatx80_init(0x3ffe, 0xce248c151f84bf00ULL),
> +      make_floatx80_init(0xbffc, 0xc76dcfab81ed0400ULL) },
> +    { make_floatx80_init(0xbffd, 0x8fffffffffffafffULL),
> +      make_floatx80_init(0x3ffe, 0xd2a81d91f12afb2bULL),
> +      make_floatx80_init(0xbffc, 0xb55f89b83b541354ULL) },
> +    { make_floatx80_init(0xbffc, 0xffffffffffff81a3ULL),
> +      make_floatx80_init(0x3ffe, 0xd744fccad69d7d5eULL),
> +      make_floatx80_init(0xbffc, 0xa2ec0cd4a58a0a88ULL) },
> +    { make_floatx80_init(0xbffc, 0xdfffffffffff1568ULL),
> +      make_floatx80_init(0x3ffe, 0xdbfbb797daf25a44ULL),
> +      make_floatx80_init(0xbffc, 0x901121a0943696f0ULL) },
> +    { make_floatx80_init(0xbffc, 0xbfffffffffff68daULL),
> +      make_floatx80_init(0x3ffe, 0xe0ccdeec2a94f811ULL),
> +      make_floatx80_init(0xbffb, 0xf999089eab583f78ULL) },
> +    { make_floatx80_init(0xbffc, 0x9fffffffffff4690ULL),
> +      make_floatx80_init(0x3ffe, 0xe5b906e77c83657eULL),
> +      make_floatx80_init(0xbffb, 0xd237c8c41be4d410ULL) },
> +    { make_floatx80_init(0xbffb, 0xffffffffffff8aeeULL),
> +      make_floatx80_init(0x3ffe, 0xeac0c6e7dd24427cULL),
> +      make_floatx80_init(0xbffb, 0xa9f9c8c116ddec20ULL) },
> +    { make_floatx80_init(0xbffb, 0xbfffffffffff2d18ULL),
> +      make_floatx80_init(0x3ffe, 0xefe4b99bdcdb06ebULL),
> +      make_floatx80_init(0xbffb, 0x80da33211927c8a8ULL) },
> +    { make_floatx80_init(0xbffa, 0xffffffffffff8ccbULL),
> +      make_floatx80_init(0x3ffe, 0xf5257d152486d0f4ULL),
> +      make_floatx80_init(0xbffa, 0xada82eadb792f0c0ULL) },
> +    { make_floatx80_init(0xbff9, 0xffffffffffff11feULL),
> +      make_floatx80_init(0x3ffe, 0xfa83b2db722a0846ULL),
> +      make_floatx80_init(0xbff9, 0xaf89a491babef740ULL) },
> +    { floatx80_zero_init,
> +      make_floatx80_init(0x3fff, 0x8000000000000000ULL),
> +      floatx80_zero_init },
> +    { make_floatx80_init(0x3ff9, 0xffffffffffff2680ULL),
> +      make_floatx80_init(0x3fff, 0x82cd8698ac2b9f6fULL),
> +      make_floatx80_init(0x3ff9, 0xb361a62b0ae7dbc0ULL) },
> +    { make_floatx80_init(0x3ffb, 0x800000000000b500ULL),
> +      make_floatx80_init(0x3fff, 0x85aac367cc488345ULL),
> +      make_floatx80_init(0x3ffa, 0xb5586cf9891068a0ULL) },
> +    { make_floatx80_init(0x3ffb, 0xbfffffffffff4b67ULL),
> +      make_floatx80_init(0x3fff, 0x88980e8092da7cceULL),
> +      make_floatx80_init(0x3ffb, 0x8980e8092da7cce0ULL) },
> +    { make_floatx80_init(0x3ffb, 0xffffffffffffff57ULL),
> +      make_floatx80_init(0x3fff, 0x8b95c1e3ea8bd6dfULL),
> +      make_floatx80_init(0x3ffb, 0xb95c1e3ea8bd6df0ULL) },
> +    { make_floatx80_init(0x3ffc, 0x9fffffffffff811fULL),
> +      make_floatx80_init(0x3fff, 0x8ea4398b45cd4780ULL),
> +      make_floatx80_init(0x3ffb, 0xea4398b45cd47800ULL) },
> +    { make_floatx80_init(0x3ffc, 0xbfffffffffff9980ULL),
> +      make_floatx80_init(0x3fff, 0x91c3d373ab11b919ULL),
> +      make_floatx80_init(0x3ffc, 0x8e1e9b9d588dc8c8ULL) },
> +    { make_floatx80_init(0x3ffc, 0xdffffffffffff631ULL),
> +      make_floatx80_init(0x3fff, 0x94f4efa8fef70864ULL),
> +      make_floatx80_init(0x3ffc, 0xa7a77d47f7b84320ULL) },
> +    { make_floatx80_init(0x3ffc, 0xffffffffffff2499ULL),
> +      make_floatx80_init(0x3fff, 0x9837f0518db892d4ULL),
> +      make_floatx80_init(0x3ffc, 0xc1bf828c6dc496a0ULL) },
> +    { make_floatx80_init(0x3ffd, 0x8fffffffffff80fbULL),
> +      make_floatx80_init(0x3fff, 0x9b8d39b9d54e3a79ULL),
> +      make_floatx80_init(0x3ffc, 0xdc69cdceaa71d3c8ULL) },
> +    { make_floatx80_init(0x3ffd, 0x9fffffffffffbc23ULL),
> +      make_floatx80_init(0x3fff, 0x9ef5326091a10313ULL),
> +      make_floatx80_init(0x3ffc, 0xf7a993048d081898ULL) },
> +    { make_floatx80_init(0x3ffd, 0xafffffffffff20ecULL),
> +      make_floatx80_init(0x3fff, 0xa27043030c49370aULL),
> +      make_floatx80_init(0x3ffd, 0x89c10c0c3124dc28ULL) },
> +    { make_floatx80_init(0x3ffd, 0xc00000000000fd2cULL),
> +      make_floatx80_init(0x3fff, 0xa5fed6a9b15171cfULL),
> +      make_floatx80_init(0x3ffd, 0x97fb5aa6c545c73cULL) },
> +    { make_floatx80_init(0x3ffd, 0xd0000000000093beULL),
> +      make_floatx80_init(0x3fff, 0xa9a15ab4ea7c30e6ULL),
> +      make_floatx80_init(0x3ffd, 0xa6856ad3a9f0c398ULL) },
> +    { make_floatx80_init(0x3ffd, 0xe00000000000c2aeULL),
> +      make_floatx80_init(0x3fff, 0xad583eea42a17876ULL),
> +      make_floatx80_init(0x3ffd, 0xb560fba90a85e1d8ULL) },
> +    { make_floatx80_init(0x3ffd, 0xefffffffffff1e3fULL),
> +      make_floatx80_init(0x3fff, 0xb123f581d2abef6cULL),
> +      make_floatx80_init(0x3ffd, 0xc48fd6074aafbdb0ULL) },
> +    { make_floatx80_init(0x3ffd, 0xffffffffffff1c23ULL),
> +      make_floatx80_init(0x3fff, 0xb504f333f9de2cadULL),
> +      make_floatx80_init(0x3ffd, 0xd413cccfe778b2b4ULL) },
> +    { make_floatx80_init(0x3ffe, 0x8800000000006344ULL),
> +      make_floatx80_init(0x3fff, 0xb8fbaf4762fbd0a1ULL),
> +      make_floatx80_init(0x3ffd, 0xe3eebd1d8bef4284ULL) },
> +    { make_floatx80_init(0x3ffe, 0x9000000000005d67ULL),
> +      make_floatx80_init(0x3fff, 0xbd08a39f580c668dULL),
> +      make_floatx80_init(0x3ffd, 0xf4228e7d60319a34ULL) },
> +    { make_floatx80_init(0x3ffe, 0x9800000000009127ULL),
> +      make_floatx80_init(0x3fff, 0xc12c4cca6670e042ULL),
> +      make_floatx80_init(0x3ffe, 0x82589994cce1c084ULL) },
> +    { make_floatx80_init(0x3ffe, 0x9fffffffffff06f9ULL),
> +      make_floatx80_init(0x3fff, 0xc5672a11550655c3ULL),
> +      make_floatx80_init(0x3ffe, 0x8ace5422aa0cab86ULL) },
> +    { make_floatx80_init(0x3ffe, 0xa7fffffffffff80dULL),
> +      make_floatx80_init(0x3fff, 0xc9b9bd866e2f234bULL),
> +      make_floatx80_init(0x3ffe, 0x93737b0cdc5e4696ULL) },
> +    { make_floatx80_init(0x3ffe, 0xafffffffffff1470ULL),
> +      make_floatx80_init(0x3fff, 0xce248c151f83fd69ULL),
> +      make_floatx80_init(0x3ffe, 0x9c49182a3f07fad2ULL) },
> +    { make_floatx80_init(0x3ffe, 0xb800000000000e0aULL),
> +      make_floatx80_init(0x3fff, 0xd2a81d91f12aec5cULL),
> +      make_floatx80_init(0x3ffe, 0xa5503b23e255d8b8ULL) },
> +    { make_floatx80_init(0x3ffe, 0xc00000000000b7faULL),
> +      make_floatx80_init(0x3fff, 0xd744fccad69dd630ULL),
> +      make_floatx80_init(0x3ffe, 0xae89f995ad3bac60ULL) },
> +    { make_floatx80_init(0x3ffe, 0xc800000000003aa6ULL),
> +      make_floatx80_init(0x3fff, 0xdbfbb797daf25a44ULL),
> +      make_floatx80_init(0x3ffe, 0xb7f76f2fb5e4b488ULL) },
> +    { make_floatx80_init(0x3ffe, 0xd00000000000a6aeULL),
> +      make_floatx80_init(0x3fff, 0xe0ccdeec2a954685ULL),
> +      make_floatx80_init(0x3ffe, 0xc199bdd8552a8d0aULL) },
> +    { make_floatx80_init(0x3ffe, 0xd800000000004165ULL),
> +      make_floatx80_init(0x3fff, 0xe5b906e77c837155ULL),
> +      make_floatx80_init(0x3ffe, 0xcb720dcef906e2aaULL) },
> +    { make_floatx80_init(0x3ffe, 0xe00000000000582cULL),
> +      make_floatx80_init(0x3fff, 0xeac0c6e7dd24713aULL),
> +      make_floatx80_init(0x3ffe, 0xd5818dcfba48e274ULL) },
> +    { make_floatx80_init(0x3ffe, 0xe800000000001a5dULL),
> +      make_floatx80_init(0x3fff, 0xefe4b99bdcdb06ebULL),
> +      make_floatx80_init(0x3ffe, 0xdfc97337b9b60dd6ULL) },
> +    { make_floatx80_init(0x3ffe, 0xefffffffffffc1efULL),
> +      make_floatx80_init(0x3fff, 0xf5257d152486a2faULL),
> +      make_floatx80_init(0x3ffe, 0xea4afa2a490d45f4ULL) },
> +    { make_floatx80_init(0x3ffe, 0xf800000000001069ULL),
> +      make_floatx80_init(0x3fff, 0xfa83b2db722a0e5cULL),
> +      make_floatx80_init(0x3ffe, 0xf50765b6e4541cb8ULL) },
> +    { make_floatx80_init(0x3fff, 0x8000000000000000ULL),
> +      make_floatx80_init(0x4000, 0x8000000000000000ULL),
> +      make_floatx80_init(0x3fff, 0x8000000000000000ULL) },
>  };
>
>  void helper_f2xm1(CPUX86State *env)
> @@ -1275,24 +1275,24 @@ struct fpatan_data {
>  };
>
>  static const struct fpatan_data fpatan_table[9] = {
> -    { floatx80_zero,
> -      floatx80_zero },
> -    { make_floatx80(0x3ffb, 0xfeadd4d5617b6e33ULL),
> -      make_floatx80(0xbfb9, 0xdda19d8305ddc420ULL) },
> -    { make_floatx80(0x3ffc, 0xfadbafc96406eb15ULL),
> -      make_floatx80(0x3fbb, 0xdb8f3debef442fccULL) },
> -    { make_floatx80(0x3ffd, 0xb7b0ca0f26f78474ULL),
> -      make_floatx80(0xbfbc, 0xeab9bdba460376faULL) },
> -    { make_floatx80(0x3ffd, 0xed63382b0dda7b45ULL),
> -      make_floatx80(0x3fbc, 0xdfc88bd978751a06ULL) },
> -    { make_floatx80(0x3ffe, 0x8f005d5ef7f59f9bULL),
> -      make_floatx80(0x3fbd, 0xb906bc2ccb886e90ULL) },
> -    { make_floatx80(0x3ffe, 0xa4bc7d1934f70924ULL),
> -      make_floatx80(0x3fbb, 0xcd43f9522bed64f8ULL) },
> -    { make_floatx80(0x3ffe, 0xb8053e2bc2319e74ULL),
> -      make_floatx80(0xbfbc, 0xd3496ab7bd6eef0cULL) },
> -    { make_floatx80(0x3ffe, 0xc90fdaa22168c235ULL),
> -      make_floatx80(0xbfbc, 0xece675d1fc8f8cbcULL) },
> +    { floatx80_zero_init,
> +      floatx80_zero_init },
> +    { make_floatx80_init(0x3ffb, 0xfeadd4d5617b6e33ULL),
> +      make_floatx80_init(0xbfb9, 0xdda19d8305ddc420ULL) },
> +    { make_floatx80_init(0x3ffc, 0xfadbafc96406eb15ULL),
> +      make_floatx80_init(0x3fbb, 0xdb8f3debef442fccULL) },
> +    { make_floatx80_init(0x3ffd, 0xb7b0ca0f26f78474ULL),
> +      make_floatx80_init(0xbfbc, 0xeab9bdba460376faULL) },
> +    { make_floatx80_init(0x3ffd, 0xed63382b0dda7b45ULL),
> +      make_floatx80_init(0x3fbc, 0xdfc88bd978751a06ULL) },
> +    { make_floatx80_init(0x3ffe, 0x8f005d5ef7f59f9bULL),
> +      make_floatx80_init(0x3fbd, 0xb906bc2ccb886e90ULL) },
> +    { make_floatx80_init(0x3ffe, 0xa4bc7d1934f70924ULL),
> +      make_floatx80_init(0x3fbb, 0xcd43f9522bed64f8ULL) },
> +    { make_floatx80_init(0x3ffe, 0xb8053e2bc2319e74ULL),
> +      make_floatx80_init(0xbfbc, 0xd3496ab7bd6eef0cULL) },
> +    { make_floatx80_init(0x3ffe, 0xc90fdaa22168c235ULL),
> +      make_floatx80_init(0xbfbc, 0xece675d1fc8f8cbcULL) },
>  };
>
>  void helper_fpatan(CPUX86State *env)

I see that there are test cases under "tests/tcg/i386", but I don't know
how to run them.

Thanks,
Laszlo


