Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19213C10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 18:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA5A2089C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 18:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkeley-edu.20150623.gappssmtp.com header.i=@berkeley-edu.20150623.gappssmtp.com header.b="HC8OIWJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA5A2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=berkeley.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJMEH-0008Pa-Qr
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 14:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dayeol@berkeley.edu>) id 1iJMA5-0006ih-NO
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 14:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dayeol@berkeley.edu>) id 1iJMA3-0007tc-Oq
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 14:30:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dayeol@berkeley.edu>) id 1iJMA3-0007st-4w
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 14:30:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id d22so6018972pll.7
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fRYAxbiEe32jsaPnu2GiEqMfbbHAuX3dHKlMVukGQI4=;
 b=HC8OIWJ2keJCpONnwq7870/TzCuVnFN7s+yT8s5B5dujGc8A59MH2bjgqYdbS7VIsZ
 hFQdEtegN7UQPDt8kY/fcUC/XU3khGN6OLIyLFq4Sz1oIyGwAXj5FMTNAHWap06L8GZP
 AvfJvrOeBOiMmL4fXoUB1nh4wScwFMDwPBNA4xB1jgDNCl5WK5XwVCRCi0G0rGiOB1Oy
 CKfLQ7d5MEy9sWArACTlvk6zTnndvsFBRroHGptIizmmn1u9SJSkOOhNNAw889v1xeF0
 x+Cx61fz/lvV3uJ8GR76cyTfoaflihdzlpVEK8Qi0CUqRX3+kGBqTGqqssjxL9zwOJFY
 XlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fRYAxbiEe32jsaPnu2GiEqMfbbHAuX3dHKlMVukGQI4=;
 b=S+cE6NRvwDXp5ox3CSzWq8knJeLyr/VX1EJ30I3wr8q4TglbNZEfgWkbnpznF7xt3O
 mqmiTmj5ULucu4W6XkU6cFd6Jz022c4EfK9Gdzjy3MgBLjAO25tJlR3luC8P5X07TPul
 Q6qL891ESiJh3UwpuVh2soPu0DsdV9E9O7m8RRfbuTkuk1row3l4AURPGfSWhysqi6YN
 sDL43iarZRIuuI9VrBxJt1MViydAjbK5lBjCVKEgre82xTfQFyRjp9oiS1PaYzNb2RAf
 QRwdB6pS4Kj57ZqZQ+xcvoIqHOj3hsu6CXLkM6RFVEELU7xJe6Mcrit+Gc63JCiENNVl
 q7rQ==
X-Gm-Message-State: APjAAAUwIeIJrYXgott8s1fn+wy5j4Xd1C/tMIwK9uMv/+r9o9CW5JBc
 PYbGpmWLtpX6Xey150OCA7lK6QUYnH7+ybXGUwRH/A==
X-Google-Smtp-Source: APXvYqwIaxPTuDMucudLq0q3QooZHm2geircba0EZNBH1HPhlPh4VsFBWhysHDedNaVahaqgFi0qhbkrxMqhiqcDXdQ=
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr22158594pla.55.1570905037436; 
 Sat, 12 Oct 2019 11:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191011231406.9808-1-dayeol@berkeley.edu>
 <CANnJOVHy8TuitQHBQ=+uh6ZKB=5iEZaE2CsLosti5mHQvRi_KA@mail.gmail.com>
In-Reply-To: <CANnJOVHy8TuitQHBQ=+uh6ZKB=5iEZaE2CsLosti5mHQvRi_KA@mail.gmail.com>
From: Dayeol Lee <dayeol@berkeley.edu>
Date: Sat, 12 Oct 2019 11:30:25 -0700
Message-ID: <CACjxMEsTuKEsL2OPVDGuUX8mCJCcOcLO1d0c3YFwmY1xxqP+Tg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bb93630594bad484"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, diodesign@tuta.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bb93630594bad484
Content-Type: text/plain; charset="UTF-8"

No it doesn't mean that.
But the following code will make the size TARGET_PAGE_SIZE - (page offset)
if the address is not aligned.

pmp_size = -(address | TARGET_PAGE_MASK)


On Fri, Oct 11, 2019, 7:37 PM Jonathan Behrens <fintelia@gmail.com> wrote:

> How do you know that the access won't straddle a page boundary? Is there a
> guarantee somewhere that size=0 means that the access is naturally aligned?
>
> Jonathan
>
>
> On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee <dayeol@berkeley.edu> wrote:
>
>> riscv_cpu_tlb_fill() uses the `size` parameter to check PMP violation
>> using pmp_hart_has_privs().
>> However, if the size is unknown (=0), the ending address will be
>> `addr - 1` as it is `addr + size - 1` in `pmp_hart_has_privs()`.
>> This always causes a false PMP violation on the starting address of the
>> range, as `addr - 1` is not in the range.
>>
>> In order to fix, we just assume that all bytes from addr to the end of
>> the page will be accessed if the size is unknown.
>>
>> Signed-off-by: Dayeol Lee <dayeol@berkeley.edu>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/riscv/cpu_helper.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index e32b6126af..7d9a22b601 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -441,6 +441,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
>> int size,
>>      CPURISCVState *env = &cpu->env;
>>      hwaddr pa = 0;
>>      int prot;
>> +    int pmp_size = 0;
>>      bool pmp_violation = false;
>>      int ret = TRANSLATE_FAIL;
>>      int mode = mmu_idx;
>> @@ -460,9 +461,19 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
>> int size,
>>                    "%s address=%" VADDR_PRIx " ret %d physical "
>> TARGET_FMT_plx
>>                    " prot %d\n", __func__, address, ret, pa, prot);
>>
>> +    /*
>> +     * if size is unknown (0), assume that all bytes
>> +     * from addr to the end of the page will be accessed.
>> +     */
>> +    if (size == 0) {
>> +        pmp_size = -(address | TARGET_PAGE_MASK);
>> +    } else {
>> +        pmp_size = size;
>> +    }
>> +
>>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>>          (ret == TRANSLATE_SUCCESS) &&
>> -        !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
>> +        !pmp_hart_has_privs(env, pa, pmp_size, 1 << access_type, mode)) {
>>          ret = TRANSLATE_PMP_FAIL;
>>      }
>>      if (ret == TRANSLATE_PMP_FAIL) {
>> --
>> 2.20.1
>>
>>
>>

--000000000000bb93630594bad484
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>No it doesn&#39;t mean that.</div><div dir=3D"auto">=
But the following code will make the size TARGET_PAGE_SIZE - (page offset) =
if the address is not aligned.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><span style=3D"font-family:sans-serif">pmp_size =3D -(address | TARG=
ET_PAGE_MASK)</span><br><br><br><div class=3D"gmail_quote" dir=3D"auto"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 11, 2019, 7:37 PM Jonathan B=
ehrens &lt;<a href=3D"mailto:fintelia@gmail.com" target=3D"_blank" rel=3D"n=
oreferrer">fintelia@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr"><div>How do you know that the access won&#39;t s=
traddle a page boundary? Is there a guarantee somewhere that size=3D0 means=
 that the access is naturally aligned?</div><div><br></div><div>Jonathan<br=
></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Oct 11, 2019 at 7:14 PM Dayeol Lee &lt;<a href=3D"mailto=
:dayeol@berkeley.edu" rel=3D"noreferrer noreferrer" target=3D"_blank">dayeo=
l@berkeley.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">riscv_cpu_tlb_fill() uses the `size` parameter to check PMP v=
iolation<br>
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
"noreferrer noreferrer" target=3D"_blank">dayeol@berkeley.edu</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" rel=3D"noreferrer noreferrer" target=3D"_blank">richard.henderson@l=
inaro.org</a>&gt;<br>
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

--000000000000bb93630594bad484--

