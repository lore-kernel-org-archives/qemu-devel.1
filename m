Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2472722D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gO5VTujm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2472722D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bUw-0007ng-PE
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k3bU9-0007JP-6d
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:42:49 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k3bU6-0001Ho-KC
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:42:48 -0400
Received: by mail-io1-xd44.google.com with SMTP id t15so39843308iob.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uQN8a1Zw3Qasd+91FB6BpMqjP2fP3gF46AVcrfNcKes=;
 b=gO5VTujm3SJfkA2bkYXWA3jIhcuSKq5MT5TRnrXXD3xl14RSD4wFgtza8fDpMIcRvj
 sftQNReF/RnH8l5KIrI03yG6IINjWQ8K7GtaO0f/fIeF2RVEx+0UX0WbhGmcYA6TlwQv
 8XrlpDCWYEbWETrYaJ/OKd1NPCzqedrBtpjP0HSAgP1M/M+YfQ4ZhrjBq5+haGQzlZ0u
 Gs2etrg/ZmmlE9ASHRt64F5i1JjLDMZpLl9UXDFzXAMfcdfULuTEq7Csiy4FDUeskDhY
 U7t92+7sn6ZFXYRgVMi/gnZytn3tTZhjix3/Q+ooMTRi3uknG301+TF51AUAOZUs7MZq
 SQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uQN8a1Zw3Qasd+91FB6BpMqjP2fP3gF46AVcrfNcKes=;
 b=tcmlXvNUskpM+vQSy2m+otikvHm7XsrVr//HkI79kPC1BnoTfRudV3B52XJIUOMZet
 tXI5m8P1mX1nXa7WnlYPJ+5y/vhRo7PMte2GgBq64v73EjCED97UrZImOcCrpptWg5IK
 M3GuoQuy2ArutrWWz+CeIlPME/DSmeyytRUa6K7+BLbo/qAFJZO6dfpB1GrmVlcm5rXi
 9EKVCsYccKWU3ja+FpbBLTE6QUwI3vpUVeKZnqgdYJAZ/EAbgTOe5gso7QaTpIBoQKbx
 JzxHoNoMt9C0faUVD5dAfXALpt0Q54ockWbe3A8nYzRx5P8CBD9as+Z5PZ0FKksbkjbo
 JiZw==
X-Gm-Message-State: AOAM5304hpBAcljKyZKYoF7cV5eE22+vRgRc6Hsp1RGcLpD+9Odyc9OA
 sENk3n59TfS/diT9btsrE1q1P1jQ90snZ++eh5y/OQ==
X-Google-Smtp-Source: ABdhPJwwMjQkE6lLoTyDdnbIUvqFzJydHTwpTo5gtKrhKoWamB7q/jMyu8OZDGO510oWeimcxMeLQuloHUOhJ/Uawj4=
X-Received: by 2002:a05:6638:2595:: with SMTP id
 s21mr10098680jat.12.1596703363687; 
 Thu, 06 Aug 2020 01:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-2-richard.henderson@linaro.org>
 <1aa6cb56-2f41-45c1-2d32-ec8b3b10780b@c-sky.com>
 <9e10c17c-7a9e-5f7f-b1e3-c195d4e30b32@linaro.org>
 <ccc72223-d98e-6dd4-6c44-ca30f4e687d5@c-sky.com>
 <CAEiOBXXmz2APpmtwPrvikXUt5j_Q=k5ZqK9g2Fe4bdjeAbg_6g@mail.gmail.com>
 <4183e2c5-9a9b-2416-301d-95e62ac53a6c@c-sky.com>
In-Reply-To: <4183e2c5-9a9b-2416-301d-95e62ac53a6c@c-sky.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 6 Aug 2020 16:42:32 +0800
Message-ID: <CAEiOBXXUDECyBXxduJCgPkFx0=Rmtjgad0yu_irVcjw32aELFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] target/riscv: Generate nanboxed results from fp
 helpers
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: multipart/alternative; boundary="000000000000cdff7505ac317834"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=chihmin.chao@sifive.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cdff7505ac317834
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 6, 2020 at 3:05 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:

>
>
> On 2020/8/6 14:09, Chih-Min Chao wrote:
>
> On Fri, Jul 24, 2020 at 2:06 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>>
>>
>> On 2020/7/24 11:55, Richard Henderson wrote:
>> > On 7/23/20 7:35 PM, LIU Zhiwei wrote:
>> >>
>> >> On 2020/7/24 8:28, Richard Henderson wrote:
>> >>> Make sure that all results from single-precision scalar helpers
>> >>> are properly nan-boxed to 64-bits.
>> >>>
>> >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> >>> ---
>> >>>    target/riscv/internals.h  |  5 +++++
>> >>>    target/riscv/fpu_helper.c | 42
>> +++++++++++++++++++++------------------
>> >>>    2 files changed, 28 insertions(+), 19 deletions(-)
>> >>>
>> >>> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
>> >>> index 37d33820ad..9f4ba7d617 100644
>> >>> --- a/target/riscv/internals.h
>> >>> +++ b/target/riscv/internals.h
>> >>> @@ -38,4 +38,9 @@ target_ulong fclass_d(uint64_t frs1);
>> >>>    #define SEW32 2
>> >>>    #define SEW64 3
>> >>>    +static inline uint64_t nanbox_s(float32 f)
>> >>> +{
>> >>> +    return f | MAKE_64BIT_MASK(32, 32);
>> >>> +}
>> >>> +
>> >> If define it here,  we can also define a more general  function with
>> flen.
>> >>
>> >> +static inline uint64_t nanbox_s(float32 f, uint32_t flen)
>> >> +{
>> >> +    return f | MAKE_64BIT_MASK(flen, 64 - flen);
>> >> +}
>> >> +
>> >>
>> >> So we can reuse it in fp16 or bf16 scalar instruction and in vector
>> instructions.
>> > While we could do that, we will not encounter all possible lengths.  In
>> the
>> > cover letter, I mentioned defining a second function,
>> >
>> > static inline uint64_t nanbox_h(float16 f)
>> > {
>> >     return f | MAKE_64BIT_MASK(16, 48);
>> > }
>> >
>> > Having two separate functions will, I believe, be easier to use in
>> practice.
>> >
>> Get  it. Thanks.
>>
>> Zhiwei
>> >
>> > r~
>>
>>
>>
> That is what has been implemented in spike.  It fills up the Nan-Box when
> value is stored back internal structure and
> unbox the value with difference floating type (half/single/double/quad).
>
> Hi Chih-Min,
>
> Has half-precision been a part of RVV? Or do you know the ISA abbreviation
> of half-precision?
>
> Thanks very much.
>
> Best Regards,
> Zhiwei
>
>
> By the way,  I prefer to keeping the suffix to tell different floating
> type rather than pass arbitrary
> since each floating type belong to each extension.
>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
>
>
Hi  ZhiWei,

It is still under branch https://github.com/riscv/riscv-isa-manual/tree/zfh and
I am not sure about the working group progress.
I have an implementation based on this draft and will send it as RFC patch
next week.

Thanks
Chih-Min

--000000000000cdff7505ac317834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><br></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Aug 6, 2020 at 3:05 PM LIU Zhiwei &lt;<a hr=
ef=3D"mailto:zhiwei_liu@c-sky.com">zhiwei_liu@c-sky.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <br>
    <br>
    <div>On 2020/8/6 14:09, Chih-Min Chao wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">
          <div>
            <div dir=3D"ltr">
              <div dir=3D"ltr">On Fri, Jul 24, 2020 at 2:06 PM LIU Zhiwei
                &lt;<a href=3D"mailto:zhiwei_liu@c-sky.com" target=3D"_blan=
k">zhiwei_liu@c-sky.com</a>&gt;
                wrote:<br>
              </div>
            </div>
          </div>
        </div>
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
            <br>
            On 2020/7/24 11:55, Richard Henderson wrote:<br>
            &gt; On 7/23/20 7:35 PM, LIU Zhiwei wrote:<br>
            &gt;&gt;<br>
            &gt;&gt; On 2020/7/24 8:28, Richard Henderson wrote:<br>
            &gt;&gt;&gt; Make sure that all results from
            single-precision scalar helpers<br>
            &gt;&gt;&gt; are properly nan-boxed to 64-bits.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"ma=
ilto:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@lina=
ro.org</a>&gt;<br>
            &gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;=C2=A0 =C2=A0 target/riscv/internals.h=C2=A0 |=C2=
=A0 5 +++++<br>
            &gt;&gt;&gt;=C2=A0 =C2=A0 target/riscv/fpu_helper.c | 42
            +++++++++++++++++++++------------------<br>
            &gt;&gt;&gt;=C2=A0 =C2=A0 2 files changed, 28 insertions(+), 19
            deletions(-)<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; diff --git a/target/riscv/internals.h
            b/target/riscv/internals.h<br>
            &gt;&gt;&gt; index 37d33820ad..9f4ba7d617 100644<br>
            &gt;&gt;&gt; --- a/target/riscv/internals.h<br>
            &gt;&gt;&gt; +++ b/target/riscv/internals.h<br>
            &gt;&gt;&gt; @@ -38,4 +38,9 @@ target_ulong
            fclass_d(uint64_t frs1);<br>
            &gt;&gt;&gt;=C2=A0 =C2=A0 #define SEW32 2<br>
            &gt;&gt;&gt;=C2=A0 =C2=A0 #define SEW64 3<br>
            &gt;&gt;&gt;=C2=A0 =C2=A0 +static inline uint64_t nanbox_s(floa=
t32 f)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 return f | MAKE_64BIT_MASK(32,=
 32);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt; If define it here,=C2=A0 we can also define a more
            general=C2=A0 function with flen.<br>
            &gt;&gt;<br>
            &gt;&gt; +static inline uint64_t nanbox_s(float32 f,
            uint32_t flen)<br>
            &gt;&gt; +{<br>
            &gt;&gt; +=C2=A0=C2=A0=C2=A0 return f | MAKE_64BIT_MASK(flen, 6=
4 - flen);<br>
            &gt;&gt; +}<br>
            &gt;&gt; +<br>
            &gt;&gt;<br>
            &gt;&gt; So we can reuse it in fp16 or bf16 scalar
            instruction and in vector instructions.<br>
            &gt; While we could do that, we will not encounter all
            possible lengths.=C2=A0 In the<br>
            &gt; cover letter, I mentioned defining a second function,<br>
            &gt;<br>
            &gt; static inline uint64_t nanbox_h(float16 f)<br>
            &gt; {<br>
            &gt;=C2=A0 =C2=A0 =C2=A0return f | MAKE_64BIT_MASK(16, 48);<br>
            &gt; }<br>
            &gt;<br>
            &gt; Having two separate functions will, I believe, be
            easier to use in practice.<br>
            &gt;<br>
            Get=C2=A0 it. Thanks.<br>
            <br>
            Zhiwei<br>
            &gt;<br>
            &gt; r~<br>
            <br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>That is what has been implemented in spike.=C2=A0 It fills u=
p
            the Nan-Box when value is stored back internal structure
            and=C2=A0</div>
          <div>unbox the value with difference floating type
            (half/single/double/quad).<br>
          </div>
        </div>
      </div>
    </blockquote>
    Hi Chih-Min,<br>
    <br>
    Has half-precision been a part of RVV? Or do you know the ISA
    abbreviation of half-precision?<br>
    <br>
    Thanks very much.<br>
    <br>
    Best Regards,<br>
    Zhiwei <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div><br>
          </div>
          <div>By the way,=C2=A0 I prefer to keeping the suffix to tell
            different=C2=A0floating type=C2=A0rather than pass arbitrary=C2=
=A0</div>
          <div>since each floating type belong to each extension.<br>
            <br>
            Reviewed-by: Chih-Min Chao &lt;<a href=3D"mailto:chihmin.chao@s=
ifive.com" target=3D"_blank">chihmin.chao@sifive.com</a>&gt;</div></div></d=
iv></blockquote></div></blockquote><div><br></div><div>Hi=C2=A0 ZhiWei,</di=
v><div><br></div><div>It is still under branch <a href=3D"https://github.co=
m/riscv/riscv-isa-manual/tree/zfh">https://github.com/riscv/riscv-isa-manua=
l/tree/zfh</a>=C2=A0and I am not=C2=A0sure about=C2=A0the=C2=A0working grou=
p progress.</div><div>I have an implementation based on this draft and will=
 send it as RFC patch next week.<br><br>Thanks</div><div>Chih-Min</div></di=
v></div>

--000000000000cdff7505ac317834--

