Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0FCECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3792084B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com header.i=@berkeley-edu.20150623.gappssmtp.com header.b="YfgWJr7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3792084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQLn-0003Xs-0N
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dayeol@berkeley.edu>) id 1iKQFc-0005aB-VA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dayeol@berkeley.edu>) id 1iKQFa-0001mD-Tb
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:04:48 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1iKQFa-0001hl-Fr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:04:46 -0400
Received: by mail-pg1-x544.google.com with SMTP id i32so12499773pgl.10
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pm7hmCqdx2Rb2Pli7HnqIfRe1BNmvKqa8gvsn9zmfKw=;
 b=YfgWJr7g9eThsdJnh/sPq1ndH6CLneOfw3uoH9TZdRix5f+zGBivFAlbVpUM9Rtmlt
 6T6Sn8rUWZtJ5BMJ+pa6+G7evm5Mtfk8RPN8Qgpj/TTITFFqfshKLIPdNZ+Mr1e9uhH9
 cwsKH7HKlOQDtAE3T3AVreEEanrKYdLjYhKahOjpDqAeNck5UVhDHiM+TbUlDa7oqpMd
 FJMjvAx8UP2FDRCrIXxqboaiZtAQ4UdvO2wHtSewiat7/28TGll0RjX2RE94f1Tum5hg
 ZfSsEpRSWTvw6QRTDDlxFPUrUvHxxnVzHhb+IBjMYfhbFAsuTi15E4k5+/2+LBezCq0g
 zuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pm7hmCqdx2Rb2Pli7HnqIfRe1BNmvKqa8gvsn9zmfKw=;
 b=jVO8n3MkGxZWrDlCHB2GsBbwO+NGA1/0DaJ0vo8fVV5A2C085Jq4bzHADDBPL+3VO9
 ssp2uyHkOSXItPGEXZ3FJ8D8/3CGX3SeZ6sCZzlZlBSP3RKB2Q/bjEq1tSWPWFXL76Mm
 tdDtsEUkkeEHYJMn5iBvix0rxdbVNlJusTOaAEgbGNtmcPJm8ZFp0O61A619eJfOdeRr
 qY4k5A2hyO25AbwCCDOPYLnr7vMKA8ztMElcI5Iz0AnLYi9K3YDVRQn1DBpO6sq1yEiW
 o/1bFp03VOAmDY1emFnsbFspQ/4HfWe4lLCuD/K6PKW0aysZ8HMTp9+EuYyAAgXQcn8m
 ZTJg==
X-Gm-Message-State: APjAAAU3wQijn7wubPPvjen1RRT4Fyragl/66NbtZqEHPdo6fal2KBhh
 MdV2s4SWgXZKekIyXK4rSb2EVVIdzfZdaoaBmBNWkQ==
X-Google-Smtp-Source: APXvYqzJDjYrlRfqss14zJ+JA1uAVz5UOo8j/DnRFHvkQWCv/Tr1Nu3kk5ZGpWc3Fz7r62skOKIjWzdOP6i5HJACOOo=
X-Received: by 2002:a62:3203:: with SMTP id y3mr39427189pfy.91.1571159084770; 
 Tue, 15 Oct 2019 10:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191011231406.9808-1-dayeol@berkeley.edu>
 <CANnJOVHy8TuitQHBQ=+uh6ZKB=5iEZaE2CsLosti5mHQvRi_KA@mail.gmail.com>
 <CACjxMEsTuKEsL2OPVDGuUX8mCJCcOcLO1d0c3YFwmY1xxqP+Tg@mail.gmail.com>
In-Reply-To: <CACjxMEsTuKEsL2OPVDGuUX8mCJCcOcLO1d0c3YFwmY1xxqP+Tg@mail.gmail.com>
From: Dayeol Lee <dayeol@berkeley.edu>
Date: Tue, 15 Oct 2019 10:04:32 -0700
Message-ID: <CACjxMEt-zOt8VktL_Ut-9vA0FdeO5jPf0XVeCzuT2OOnyehMmA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000223aaa0594f5fb2d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Qemu Devel <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Chris Williams <diodesign@tuta.io>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000223aaa0594f5fb2d
Content-Type: text/plain; charset="UTF-8"

Hi,

Could this patch go through?
If not please let me know so that I can fix.
Thank you!

Dayeol


On Sat, Oct 12, 2019, 11:30 AM Dayeol Lee <dayeol@berkeley.edu> wrote:

> No it doesn't mean that.
> But the following code will make the size TARGET_PAGE_SIZE - (page offset)
> if the address is not aligned.
>
> pmp_size = -(address | TARGET_PAGE_MASK)
>
>
> On Fri, Oct 11, 2019, 7:37 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>
>> How do you know that the access won't straddle a page boundary? Is there
>> a guarantee somewhere that size=0 means that the access is naturally
>> aligned?
>>
>> Jonathan
>>
>>
>> On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee <dayeol@berkeley.edu> wrote:
>>
>>> riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
>>> using pmp_hart_has_privs().
>>> However, if the size is unknown (=0), the ending address will be
>>> `addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
>>> This always causes a false PMP violation on the starting address of the
>>> range, as `addr - 1` is not in the range.
>>>
>>> In order to fix, we just assume that all bytes from addr to the end of
>>> the page will be accessed if the size is unknown.
>>>
>>> Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/riscv/cpu_helper.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> index e32b6126af..7d9a22b601 100644
>>> --- a/target/riscv/cpu_helper.c
>>> +++ b/target/riscv/cpu_helper.c
>>> @@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
>>> int size,
>>>      CPURISCVState *env = &cpu->env;
>>>      hwaddr pa = 0;
>>>      int prot;
>>> +    int pmp_size = 0;
>>>      bool pmp_violation = false;
>>>      int ret = TRANSLATE_FAIL;
>>>      int mode = mmu_idx;
>>> @@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr
>>> address, int size,
>>>                    "%s address=%" VADDR_PRIx " ret %d physical "
>>> TARGET_FMT_plx
>>>                    " prot %d\n", __func__, address, ret, pa, prot);
>>>
>>> +    /*
>>> +     * if size is unknown (0), assume that all bytes
>>> +     * from addr to the end of the page will be accessed.
>>> +     */
>>> +    if (size == 0) {
>>> +        pmp_size = -(address | TARGET_PAGE_MASK);
>>> +    } else {
>>> +        pmp_size = size;
>>> +    }
>>> +
>>>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>>>          (ret == TRANSLATE_SUCCESS) &&
>>> -        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
>>> +        !pmp_hart_has_privs(env, pa, pmp_size, 1 << access_type, mode))
>>> {
>>>          ret = TRANSLATE_PMP_FAIL;
>>>      }
>>>      if (ret == TRANSLATE_PMP_FAIL) {
>>> --
>>> 2.20.1
>>>
>>>
>>>

--000000000000223aaa0594f5fb2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hi,=C2=A0</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Could this patch go through?</div><div dir=3D"auto">I=
f not please let me know so that I can fix.</div><div dir=3D"auto">Thank yo=
u!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Dayeol</div><br><br><=
div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr=
">On Sat, Oct 12, 2019, 11:30 AM Dayeol Lee &lt;<a href=3D"mailto:dayeol@be=
rkeley.edu" target=3D"_blank" rel=3D"noreferrer">dayeol@berkeley.edu</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div>No =
it doesn&#39;t mean that.</div><div dir=3D"auto">But the following code wil=
l make the size TARGET_PAGE_SIZE - (page offset) if the address is not alig=
ned.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D"font=
-family:sans-serif">pmp_size =3D -(address | TARGET_PAGE_MASK)</span><br><b=
r><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gma=
il_attr">On Fri, Oct 11, 2019, 7:37 PM Jonathan Behrens &lt;<a href=3D"mail=
to:fintelia@gmail.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_=
blank">fintelia@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr"><div>How do you know that the access won&#39;t strad=
dle a page boundary? Is there a guarantee somewhere that size=3D0 means tha=
t the access is naturally aligned?</div><div><br></div><div>Jonathan<br></d=
iv><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee &lt;<a href=3D"mailto:day=
eol@berkeley.edu" rel=3D"noreferrer noreferrer noreferrer noreferrer" targe=
t=3D"_blank">dayeol@berkeley.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">riscv_cpu_tlb_fill() uses the `size` param=
eter to check PMP violation<br>
using pmp_hart_has_privs().<br>
However, if the size is unknown (=3D0), the ending address will be<br>
`addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.<br>
This always causes a false PMP violation on the starting address of the<br>
range, as `addr - 1` is not in the range.<br>
<br>
In order to fix, we just assume that all bytes from addr to the end of<br>
the page will be accessed if the size is unknown.<br>
<br>
Signed-off-by: Dayeol Lee &lt;<a href=3D"mailto:dayeol@berkeley.edu" rel=3D=
"noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">dayeol@berk=
eley.edu</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" rel=3D"noreferrer noreferrer noreferrer noreferrer" target=3D"_blan=
k">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu_helper.c | 13 ++++++++++++-<br>
=C2=A01 file changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
index e32b6126af..7d9a22b601 100644<br>
--- a/target/riscv/cpu_helper.c<br>
+++ b/target/riscv/cpu_helper.c<br>
@@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,<br>
=C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &amp;cpu-&gt;env;<br>
=C2=A0 =C2=A0 =C2=A0hwaddr pa =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int prot;<br>
+=C2=A0 =C2=A0 int pmp_size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0bool pmp_violation =3D false;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D TRANSLATE_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0int mode =3D mmu_idx;<br>
@@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, i=
nt size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
%s address=3D%&quot; VADDR_PRIx &quot; ret %d physical &quot; TARGET_FMT_pl=
x<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
 prot %d\n&quot;, __func__, address, ret, pa, prot);<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* if size is unknown (0), assume that all bytes<br>
+=C2=A0 =C2=A0 =C2=A0* from addr to the end of the page will be accessed.<b=
r>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (size =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_size =3D -(address | TARGET_PAGE_MASK);<br=
>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmp_size =3D size;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (riscv_feature(env, RISCV_FEATURE_PMP) &amp;&amp;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ret =3D=3D TRANSLATE_SUCCESS) &amp;&amp;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 !pmp_hart_has_privs(env, pa, size, 1 &lt;&lt; =
access_type, mode)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !pmp_hart_has_privs(env, pa, pmp_size, 1 &lt;&=
lt; access_type, mode)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D TRANSLATE_PMP_FAIL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D TRANSLATE_PMP_FAIL) {<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div>
</blockquote></div></div></div>
</blockquote></div>
</div>

--000000000000223aaa0594f5fb2d--

