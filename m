Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C43C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E406C2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSZbEvwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E406C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0ug-0000dU-15
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw0ty-0008KJ-LL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:14:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw0tw-0004Fh-Nu
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:14:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so6445174wrv.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=D4I53mGkb52p5ZlpElp/j3tHvyKcUTwgk7mxhkqrMUo=;
 b=YSZbEvwCnPPVEAkS6BatqLnsG2HyHYhZqpzH0OdjhxmLXauXcG3eRLSrm6cFn155bY
 /PkPaEUvalsYfwEYrsgsoHvbGPK4Bn1gLAdkIrDrbZ8sVcEY7WNEqfIoGMJEHNF1kHyr
 Ml7zOOHqzMUB79e/qWAFEK7bBbJ6bOkOx39TBBDXCjpWHdQebtbIYbwtkT9IqEHaJqiw
 tay4+5lk1X82Xh8FWivBpMVo2ajZmEaCFuDucxRDg3Twl1K/4Q2QbSTs+OAuVMoWos8g
 5Y+QzdFAxTtBWsNuZNU2He8nM5TpSqC2vHIgt71QrLAtt6UkcRQ5PH6T3mAe1Ssze6oo
 +wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=D4I53mGkb52p5ZlpElp/j3tHvyKcUTwgk7mxhkqrMUo=;
 b=ffzravGeFuG/WBNam8zJ5JXvC1GmsiGs1pgexG2NQY/HNSI8/IchvlieymZR57sbMw
 l2QLTZMGGvav5sgbnrVQxmxOJNHROttaSKVX+mDwKjX2HCii4AuB0+EIOerTe2l0j4e3
 EZONHYstkDXz2hACfrQbl+N784yfdUwpoU4LSQ4TigyLLbEIndfqro+eRmYsK76dz3P1
 yDXdyFbydHAsVs/pk6aChB1NkFi3SMzytI9S3LiBOgJSJixqhHJMP14SIzS7P0FRW/Vl
 XjDecg3RgswDF8+qHFkWpJLBIaEsCVR9sf8K7RbjM4wdqJ67lfQTzPfxeMjOzcqf2mr/
 ldyQ==
X-Gm-Message-State: AOAM5336aY2QV8AH+9lQlKuie2VWaWGwmGe9EpEublerSr7bILc23hvv
 ewR5UjcrWpRd1i3SitEjcDL4bg==
X-Google-Smtp-Source: ABdhPJy3YKTAYm4IGtHPp41ltRdKaBbWLy0u+Ff936WW3oSeQj+CwDNaF8hVaugGuaPwCCdiZtTykA==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr4686138wrm.103.1594894442759; 
 Thu, 16 Jul 2020 03:14:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm8036217wmf.3.2020.07.16.03.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 03:14:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AFAAB1FF7E;
 Thu, 16 Jul 2020 11:14:00 +0100 (BST)
References: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
 <87tuzbyseo.fsf@linaro.org>
 <d8e0a351-7136-4630-f65d-2d7b9603eb8d@adacore.com>
 <0e1a1c94-7b90-177a-4283-5247ef675497@adacore.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fred Konrad <konrad@adacore.com>
Subject: Re: [PATCH v1 1/2] semihosting: defer connect_chardevs a little
 more to use serialx
In-reply-to: <0e1a1c94-7b90-177a-4283-5247ef675497@adacore.com>
Date: Thu, 16 Jul 2020 11:14:00 +0100
Message-ID: <87h7u7wyvr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Fred Konrad <konrad@adacore.com> writes:

> Le 6/26/20 =C3=A0 12:06 PM, Fred Konrad a =C3=A9crit :
>>=20
>>=20
>> Le 6/16/20 =C3=A0 4:52 PM, Alex Benn=C3=A9e a =C3=A9crit :
>>>
>>> konrad@adacore.com writes:
>>>
>>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>>
>>>> With that we can just use chardev=3Dserial0.
>>>
>>> I don't quite follow what this means.
>>>
>>> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev=
=3Dserial0=20
>>> -M virt -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/=
memory
>>> qemu-system-aarch64: -chardev=3Dserial0: invalid option
>>>
>>> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -monitor none -chardev=20
>>> id=3Dserial0 -M virt -display none -semihosting -kernel=20
>>> ./tests/tcg/aarch64-softmmu/memory
>>> qemu-system-aarch64: -chardev id=3Dserial0: chardev: "serial0" missing =
backend
>>>
>>> The run:
>>>
>>> ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M vir=
t=20
>>> -display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory
>>>
>>> works fine without this patch.
>>=20
>> Hi Alex, and sorry for the delay,
>>=20
>> I meant `-semihosting-config chardev=3Dserial0`.  I suspect your last co=
mmand-line
>> will print any string sent to semihosting to stderr by default.
>
> Does that make sense?  BTW the second patch fixes a bug, it might be inte=
resting
> to have it in 5.1.

Right - can confirm the difference between:

  ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M virt =
-display none -semihosting -kernel ./tests/tcg/aarch64-softmmu/memory

and

  ./aarch64-softmmu/qemu-system-aarch64 -cpu max -serial mon:stdio -M virt =
-display none -semihosting-config chardev=3Dserial0 -kernel ./tests/tcg/aar=
ch64-softmmu/memory

is where the data ends up. I've slightly amended the commit message for
the 1/1 to make it clearer.

Queued to for-5.1/fixes-for-rc1, thanks.

>
> Cheers,
> Fred
>
>>=20
>>>
>>>>
>>>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>>>> ---
>>>>   softmmu/vl.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>>>> index f669c06..9b8b48a 100644
>>>> --- a/softmmu/vl.c
>>>> +++ b/softmmu/vl.c
>>>> @@ -4123,8 +4123,6 @@ void qemu_init(int argc, char **argv, char **env=
p)
>>>>       qemu_opts_foreach(qemu_find_opts("chardev"),
>>>>                         chardev_init_func, NULL, &error_fatal);
>>>> -    /* now chardevs have been created we may have semihosting to conn=
ect */
>>>> -    qemu_semihosting_connect_chardevs();
>>>>   #ifdef CONFIG_VIRTFS
>>>>       qemu_opts_foreach(qemu_find_opts("fsdev"),
>>>> @@ -4271,6 +4269,9 @@ void qemu_init(int argc, char **argv, char **env=
p)
>>>>       if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>>>>           exit(1);
>>>> +    /* now chardevs have been created we may have semihosting to conn=
ect */
>>>> +    qemu_semihosting_connect_chardevs();
>>>> +
>>>>       /* If no default VGA is requested, the default is "none".  */
>>>>       if (default_vga) {
>>>>           vga_model =3D get_default_vga_model(machine_class);
>>>
>>>


--=20
Alex Benn=C3=A9e

