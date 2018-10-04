Received: from eggs.gnu.org ([2001:4830:134:3::10]:36757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8Awq-0004Tw-Ql
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 17:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8Awi-0007jW-Qb
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 17:14:15 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8AwQ-0007a4-41
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 17:14:08 -0400
Received: by mail-oi1-x236.google.com with SMTP id k64-v6so8689964oia.13
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 14:13:49 -0700 (PDT)
References: <20181004010505.26184-1-jcmvbkbc@gmail.com>
	<CAMo8BfJ==eV4g7L3nSuYa=o2RNw98nUg_0VJeBD6V8Q54m0wkg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39db072a-4ed9-834e-a77f-bb06df42a9f1@linaro.org>
Date: Thu, 4 Oct 2018 16:13:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJ==eV4g7L3nSuYa=o2RNw98nUg_0VJeBD6V8Q54m0wkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 10/4/18 3:14 PM, Max Filippov wrote:
> I thought about it some more and it looks like this is not going to work
> in general case in the presence of TB linking: a block with a big (and thus
> not precise) LEND distance may be linked to a block with a small (and
> thus precise) LEND distance. Then LEND may change so that next time
> it still goes to the first TB. In that case it shouldn't go from the first TB
> to the second, but with this scheme it will.

Indeed.  Perhaps think of ways in which LBEG and LEND can be represented
relative to each other and PC and store than in the 32-bits you have available
in the CS_BASE field.

Think first about how, if PC >= LEND or LEND - PC > PAGE_SIZE, that all of the
loop stuff is irrelevant because we won't hit LEND within this TB.

Think second about how to represent the common case -- how LOOP sets LBEG and
LEND together.  That is, LEND - LBEG <= 256.  So, usually, we can also have an
exact representation of LBEG and have a direct link rather than an indirect
link.  But I presume that one can play games with special registers to create
ranges that LOOP won't.  So we need some setting that will indicate that.

Consider CS_BASE fields:

  [12: 0]  EDIF = LEND - PC, if PC < LEND && LEND - PC < 2*PAGE_SIZE, or 0.
  [20:13]  BDIF = LEND - LBEG, if LEND - LBEG < 256, or 0.

So you can tell if advancing PC within a TB will exactly match LEND.  You can
tell what LBEG should be, except if BDIF == 0.  In that, presumably rare case,
you load LBEG at runtime as you did in this patch.

Note that if CS_BASE == 0, and thus EDIF == 0, looping is disabled for the TB.

I'll note that this also makes XTENSA_TBFLAG_EXCM redundant.  Simply skip
setting CS_BASE to a non-zero value instead.


r~
