Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8211C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387732225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="PxQDgR9v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="QHMmRsLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387732225F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWCZS-0000NZ-3C
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 01:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kWCXh-0007Oy-Os; Sat, 24 Oct 2020 01:56:41 -0400
Received: from home.keithp.com ([63.227.221.253]:43576 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kWCXe-0008AJ-W7; Sat, 24 Oct 2020 01:56:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id CFA423F2DD1A;
 Fri, 23 Oct 2020 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603518994; bh=odGSmqp2ghZEK5ZFFkDKegBnKIYotPgjDCacNA7OVrs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PxQDgR9vqaMJr9zhjBwK+/jDc/GAkUExK5IUpTq6DW/w5B4BKGj/kZsWHRN+4kmvU
 xRKwL3c5pLNvQybaIueqTObItwTeR1s+xsTDXXsSDMDb2jrgLIcg0GeQxJjJS1xrFF
 bmWpVS5K3eUyiulO7xAxgAx3y4IwtIT5DfGqE27PwYgvVi27/0thz/4qX0GajWMKtY
 lRNF5DG4fXqL7eZVZMWCWp0E9OO6VEW3Xf5F6Q8tW6EY1GjxsK42UBgnQaqYlpfsW7
 moYQf5gPJXA9OOVQgeo/KX9oCmOhGX0vsmwM/btJFVe4wJwcapbrR747dLlaC+aQuo
 o6+vsIiNUIKow==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id i09BShfMcetq; Fri, 23 Oct 2020 22:56:33 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 3D1FF3F2DD12;
 Fri, 23 Oct 2020 22:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603518993; bh=odGSmqp2ghZEK5ZFFkDKegBnKIYotPgjDCacNA7OVrs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QHMmRsLP0X/OWrZ6+OieiVMDgE2ry4cBqzeimh/Cz5Z15DQ00nPSeaLYOuu0Ptt9P
 3YbZwPdqCGjmBa1/26pyiDjVy825ViEwl0QXHdqBzC422F1YPg32KpLOlTbtNZkuju
 Hcyfkw+Hm9LM0tLuafDCOchKPZ7H8JfzB/u66KXSEMoFgk46sIqShD+/VFeY0mAZus
 4cf6AyDGoVufSbPc5quyXTlpIvZD+aUdrt0v9Ry/C/wH1EmV4rokHEfVdgGM/2W8IH
 Sjl0dsk06+8oWPx9C4FH0LNHwEBfDMUUdrCn437e/L+vMblRXYmlo1kNYVEe7ZmBIu
 iR7JbnHkvHAQQ==
Received: by keithp.com (Postfix, from userid 1000)
 id 1595F15821A3; Fri, 23 Oct 2020 22:56:33 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel\@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list\:RISC-V" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH] riscv: Add semihosting support [v8]
In-Reply-To: <CAKmqyKMzHARF7C9Lo8SYFBbPNa_=ibbWBNnedwFbe8AY=DdXVA@mail.gmail.com>
References: <20201023214940.917885-1-keithp@keithp.com>
 <CAKmqyKMzHARF7C9Lo8SYFBbPNa_=ibbWBNnedwFbe8AY=DdXVA@mail.gmail.com>
Date: Fri, 23 Oct 2020 22:56:32 -0700
Message-ID: <8736246ub3.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:56:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: "Keith Packard" <keithp@keithp.com>
From: "Keith Packard" via <qemu-devel@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alistair Francis <alistair23@gmail.com> writes:

Thanks much for taking time to review this patch in detail. I've left
the indicated changes in a new version of my riscv-semihost branch here:

        https://github.com/keith-packard/qemu/tree/riscv-semihost

I'll post a new version once we've wound up discussion on the remaining
issues.

>> +M: Keith Packard <keithp@keithp.com>
>
> I don't think you should be a maintainer just yet. In general people
> have to be actively reviewing patches to be listed as a maintainer.

Cool, I'm glad to not be listed. checkpatch.pl suggested that I might
need to add something here, so I went ahead and included it in case it
was necessary. (I probably should do some patch review though; SiFive is
rather dependent on QEMU continuing to be a great RISC-V emulator)

>> +#include "exec/cpu-all.h"
>
> This isn't used in the header so it shouldn't be here.

Worse than that -- it's already included in this file. I suspect
this is left over from a previous version and have removed it.

>> +#define RISCV_EXCP_SEMIHOST                      0x10
>
> I don't see this in the RISC-V spec, it seems to just be reserved, not
> for semihosting.

Hrm. It's entirely an internal implementation detail in QEMU and matches
how semihosting works in the ARM implementation -- the presence of the
semihosting breakpoint raises this exception which is then handled in
the usual exception processing path.

If there is ever a real exception that uses this number, we can
re-define this to something else. Or if you have a favorite number you'd
like to use instead, that'd be great.

>> + *  ARM Semihosting is documented in:
>> + *     Semihosting for AArch32 and AArch64 Release 2.0
>> + *     https://static.docs.arm.com/100863/0200/semihosting.pdf
>
> Maybe just point to the RISC-V doc instead.

Good suggestion. Fixed.

> Could we split all of the shared code out somewhere?

Yes, that seems like a reasonable suggestion. I haven't done so because
that brings a lot of additional obligations on the patch to not impact
the ARM implementation, and means that future changes to either the
RISC-V or ARM specifications would need to be careful to not impact the
other architecture as the code is modified.

Benjamin Herrenschmidt started a thread back in January about creating a
common semihosting implementation to be shared across ARM, RISC-V and
PPC. I'm not sure he ever published the resulting code, but we can
probably get whatever he's done and see if we want to go that way. I
suspect the biggest impact will be to the ARM maintainers who will end
up on the hook for reviewing the code to make sure it doesn't break
anything for them.

I can expand the semihost testing which picolibc currently performs
under QEMU on ARM, AARCH64 and RISC-V; that might help catch regressions
caused by this rework.

>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -63,6 +63,7 @@ typedef struct DisasContext {
>>      uint16_t vlen;
>>      uint16_t mlen;
>>      bool vl_eq_vlmax;
>> +    CPUState *cs;
>
> I'm not sure we should do this.

Yeah, the RISC-V semihosting requirement that three instructions be
compared to determine a valid 'sequence' is the least pleasing part of
the specification. This is the second version of this particular piece
of code.

We also changed the semihosting specification to require that all three
instructions lie on the same page to make sure they are all available if
any are available. In the application implementation, all that was
required to meet that was to put the sequence in a function and align
that to a 16-byte boundary as the function consists of four 32-bit
instructions:

        .global sys_semihost
        .balign 16
        .option push
        .option norvc
sys_semihost:
        slli zero, zero, 0x1f
        ebreak
        srai zero, zero, 0x7
        ret
        .option pop

>> +static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>> +{
>> +    DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>> +    CPUState *cpu =3D ctx->cs;
>> +    CPURISCVState *env =3D cpu->env_ptr;
>> +
>> +    return cpu_ldl_code(env, pc);
>
> @Richard Henderson is this ok?

Let me know if you've got a better plan, or even some suggestions on how
it might be improved as it seems like it a layering violation to me.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+TwhAACgkQ2yIaaQAA
ABGtMxAAsjM1k3GaDnygFOl+zUcS3wyJaCxdJJeroTzqE00IQhs54yKVStspzKyD
30smcWbb4KO9vSIEATCKfYV1vyJaas0vXnYYcrI77Eqki9YZrKG4nzQmLe8JWcyJ
/28a8jq+ZZt3LUIDoL66byZ38bwWeySb2CEqMZ2ToHvqBdnTYl1bCiP3mNsfvflQ
owA5W9EbTglV7kpvyC1DMANRMI/mOZDqW47eQXwCCf00z7sarfelt1Pw/+Vg0rpi
NeUp6p4VdxWy6KaW/tcBG1dux2jwt9al40udyxv/pgbSJp71AsbfjbOb1TAJnsKY
RKn83FeeGNtSik/TDWc/tdv9Lug8wPLQVn9y4GSABU2rcfc0pIBbewiwKCqz2KMT
7LmqFIccVMFI46ZWdAxkXw4k1DQwNC9Ojpd43eRORo0n5MLDEbPN5099/yoCFWcS
B+u/HIQg8U7kxw+v36OBnd1/+6Zg4PiCh+ZV/6IWkxTeFVCej7Nl/W13Yju5F4Ky
/2g5I14HTvUkiyJziQf9GvnwDa4R9wSaZk5/eZCM1sAxOAepkISc9/ZAKPkLhd3y
4NZ5lffhBfjg4aDbLzCRWQOY46viynttAT7MVVDj/+Ojzu5/OVbPeseGIEszIukf
fHjpL5zJf/GwWnvIxRLc/ywY/eVfYmIADJ5QG0BKC5yXrEXwSWo=
=uX4S
-----END PGP SIGNATURE-----
--=-=-=--

