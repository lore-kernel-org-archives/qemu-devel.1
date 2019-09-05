Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8732CC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0204A206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l33OkEEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0204A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tsy-0002od-Gl
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i5tsH-0002K3-Nr
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1i5tsG-0005Rn-Bn
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:40:41 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:33331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1i5tsD-0005Pe-E4; Thu, 05 Sep 2019 11:40:37 -0400
Received: by mail-io1-xd44.google.com with SMTP id m11so5913985ioo.0;
 Thu, 05 Sep 2019 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZKkt/SOiKtFSstWvWKFbJtcesPFRXF7UnM8PUDvHq6E=;
 b=l33OkEEXX8e5yr0ySsd0fHjq8QrkZl60mdi74dmHRIL2Yf3USK82XGpaS1tgA3UMUt
 L4CYV3K5XfkcmSboRBLnQAKn9xiZje6ylEN86R5ZjseV0tJJv5or6CkEkyZOzKcTfAFl
 GNr0Yo+phLpCzLtbUxt9PYIUatkKrznozZRoGeihTzCzOfafdOGVFLiXTNpvPLqhzQsj
 AMo4cmKoGrynZKZ3ILHhH9tLpPjtiQqtCfish0VMoEAETsYGuUqAazTCqnLLyfHBPaCT
 QlfdAMJDqTR3lyUYR8Sy2pu5YbaSiqJr4zFOry8Z5GggF08b4NcLZC29CYnTDXA75CF0
 L+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZKkt/SOiKtFSstWvWKFbJtcesPFRXF7UnM8PUDvHq6E=;
 b=JAE/OpcL16tS++lOD7iSn8R/HTIi5oKaF5/f780G6Bwh7IMF/aEE549rceYgtSSAzF
 T14oVYVu+c7sCT5DIQD/EP4MPcvLvTW49GqdQ/BmwY+pHmFTVo5cqc8/uxl6L2EChgB8
 vQdwHEsr3T2P+RiQD3wbaglAmKt0+QIymxp+qgdCRMpbFZ6Vc2wKZXf+guyXzu7I2ufd
 5RDoQJ9erkK5hHXd8j4HdVxjuOXLNn0xl3XGkpYJSIkIJwXMWYyhhpaP8mQj8fIOaXN5
 75+JMx5WeukvhgnUeWELe2e8KfOvMEKLTAXTepqPfQMP8rZz0W2VG/LkcZhaKuNZsMkS
 9CrA==
X-Gm-Message-State: APjAAAWKHwmr+Kwkk2Gq7GZqGhdcLuWWgYlclyL20a89mMTS3emLH/VZ
 hmqbebvawWv7WtyLC//oBgRYMguwyM47cYlCk7k=
X-Google-Smtp-Source: APXvYqz4Payq1m8Y6bnhBpex/XOtc9a+Gb9PE3vcfDxlr0N5tIGNglOHITyINaMzXgOaC0Ppbul3sFHpN2Jsm/rmPlo=
X-Received: by 2002:a5e:8e0c:: with SMTP id a12mr4867148ion.22.1567698035385; 
 Thu, 05 Sep 2019 08:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-18-richard.henderson@linaro.org>
 <877e6m937n.fsf@linaro.org>
In-Reply-To: <877e6m937n.fsf@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 5 Sep 2019 17:40:21 +0200
Message-ID: <CABoDooPis6VR-3zw6EcCerwmTfZ_c2gqbCtVDSnpB30q-Oh01A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 17/17] target/arm: Rely on
 hflags correct in cpu_get_tb_cpu_state
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 5, 2019 at 5:24 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > This is the payoff.
> >
> > From perf record -g data of ubuntu 18 boot and shutdown:
> >
> > BEFORE:
> >
> > -   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
> >    - 20.22% helper_lookup_tb_ptr
> >       + 10.05% tb_htable_lookup
> >       - 9.13% cpu_get_tb_cpu_state
> >            3.20% aa64_va_parameters_both
> >            0.55% fp_exception_el
> >
> > -   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
> >    - 6.96% cpu_get_tb_cpu_state
> >         3.63% aa64_va_parameters_both
> >         0.60% fp_exception_el
> >         0.53% sve_exception_el
> >
> > AFTER:
> >
> > -   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
> >    - 13.03% helper_lookup_tb_ptr
> >       + 11.19% tb_htable_lookup
> >         0.55% cpu_get_tb_cpu_state
> >
> >      0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state
> >
> >      0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64
> >
> > Before, helper_lookup_tb_ptr is the second hottest function in the
> > application, consuming almost a quarter of the runtime.  Within the
> > entire execution, cpu_get_tb_cpu_state consumes about 12%.
> >
> > After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
> > with consumption dropping to a sixth of the runtime.  Within the
> > entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
> > supporting function to rebuild hflags also consumes about 1%.
> >
> > Assertions are retained for --enable-debug-tcg.
> >
> > Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Hmm something must have been missed for M-profile because:
>
>   make run-tcg-tests-arm-softmmu V=3D1
>
> Leads to:
>
>   timeout 15  /home/alex/lsrc/qemu.git/builds/all.debug/arm-softmmu/qemu-=
system-arm -monitor none -display none -chardev file,path=3Dtest-armv6m-und=
ef.out,id=3Doutput -semihosting -M microbit -kernel test-armv6m-undef
>   qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1=
)
>
>   R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
>   R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
>   R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
>   R12=3D00000000 R13=3D20003fe0 R14=3Dfffffff9 R15=3D000000c0
>   XPSR=3D41000003 -Z-- T handler
>   FPSCR: 00000000
>   timeout: the monitored command dumped core
>
> But annoyingly not shown up by the debug-tcg verification. The commit
> before works fine.

There's a typo in the patch:  that should not be CONFIG_TCG_DEBUG but
CONFIG_DEBUG_TCG.  With this you should see the assert fire.

I let Richard know that there's an issue with the handling of CPSR E
flag (BE_DATA in hflags).  I don't know if that applies to your test.

Thanks,

Laurent

> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > v2: Retain asserts for future debugging.
> > ---
> >  target/arm/helper.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index d1bf71a260..5e4f996882 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -11211,12 +11211,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *=
env, int el)
> >  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
> >                            target_ulong *cs_base, uint32_t *pflags)
> >  {
> > -    uint32_t flags, pstate_for_ss;
> > +    uint32_t flags =3D env->hflags;
> > +    uint32_t pstate_for_ss;
> >
> >      *cs_base =3D 0;
> > -    flags =3D rebuild_hflags_internal(env);
> > +#ifdef CONFIG_TCG_DEBUG
> > +    assert(flags =3D=3D rebuild_hflags_internal(env));
> > +#endif
> >
> > -    if (is_a64(env)) {
> > +    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
> >          *pc =3D env->pc;
> >          if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
> >              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype)=
;
>
>
> --
> Alex Benn=C3=A9e
>

