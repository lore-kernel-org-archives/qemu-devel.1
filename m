Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D1C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92A820663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOpxnuSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92A820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEESl-00077M-Km
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEEMe-0006Wq-Vi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEEMd-0000Ox-56
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:42:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEEMd-0000LT-0X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584459761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5htWkFQVjV3nq6eFNrhXATuVCH+zX0fM0so4PnzsAI=;
 b=aOpxnuSEQQRY76QzC1nG7c81w5mb4FU5fA87xD6IOJoluBUXjGizELhNTTrfmpXx/cK1Nc
 1hnn7XxG4ZEerjfTmAWOdwus/HHIcXpPsVpSr3y44n4JXDaSdO2CbQfxh/CCRXQ/vO7hxs
 lrb7UqMCvUoh0QWZtPJBGfruhUtSa90=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-BLlW7I9qMAiZnRjYG-cneA-1; Tue, 17 Mar 2020 11:42:37 -0400
X-MC-Unique: BLlW7I9qMAiZnRjYG-cneA-1
Received: by mail-wm1-f70.google.com with SMTP id r23so7328321wmn.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mjTNLk+7Sz2D68z11aig8/LbtItNOkQ/Wsvikf+nsD8=;
 b=LoCqADe5Mq9Um6j9A5WkcQcS6aLvXeopBSUKSpEiUQP4xk/ZHoY/SyIcLXfG25GM3Y
 oqvA7Rf/rJhk2XluRAX23jKWYL2tN8Z25rwclhUTD7N9XOLcFBhROhTAq1Fng00hwDRq
 K33PhhhIT9Su8uOSsRIsg47d8/xd+siGr36FqrdIvQEO+w5rmvjalo45gns9zNK/fIR3
 CFE4Raj2DeYJdql8Aa9VJkBdBt1txD+OGPwAqiSzIWIuXIBEdWb2pBL+uEdnqkErTPKm
 AWs2k5QOoMJtkaFvEuDETyYW8PoYxgxtqL/uobaDFvxy6/7QigUat8cYln3zXu1wXGVE
 9ReA==
X-Gm-Message-State: ANhLgQ1mkoo+DYYmI5vbQe6AARM2PHBAyLHHEZAESCRMQ2Dhdl9rlJDG
 YDSJb3vXoM21BBD8ETOOSRrrO+OR5IRlbXjbPcamCiGa++oIE9TfTaE+b4U+k3Zx3GONHWkPIsF
 rqv7YS+gWouEESAQ=
X-Received: by 2002:adf:b307:: with SMTP id j7mr6690630wrd.128.1584459756489; 
 Tue, 17 Mar 2020 08:42:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuP3EfB9QJh2FzLtgnFze3lYq7H9udGgTiP04d2znq1ptIHNURCySy7fpIRqeodgMtxmnk/4g==
X-Received: by 2002:adf:b307:: with SMTP id j7mr6690611wrd.128.1584459756223; 
 Tue, 17 Mar 2020 08:42:36 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id x24sm4187910wmc.36.2020.03.17.08.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 08:42:35 -0700 (PDT)
Subject: Re: [PULL v2 00/61] Misc patches for soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-W=7LQyKvy-Pxv7eUh-tLoYu5jLiObTST0-Ee0wrCX7g@mail.gmail.com>
 <da99ee7c-49fb-057e-a6bb-b2c89de86ffa@redhat.com>
 <20200317142635.GB517094@stefanha-x1.localdomain>
 <4685b090-c480-0061-6cae-f29cc8cbd717@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8f1f0486-2ad6-0d16-b423-bc09110b31a0@redhat.com>
Date: Tue, 17 Mar 2020 16:42:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4685b090-c480-0061-6cae-f29cc8cbd717@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 3:47 PM, Paolo Bonzini wrote:
> On 17/03/20 15:26, Stefan Hajnoczi wrote:
>> Yes, looks like the compiler can't figure out the control flow on
>> NetBSD.
>>
>> We could drop the WITH_QEMU_LOCK_GUARD() macro and use this idiom
>> instead:
>>
>>    {
>>        QEMU_LOCK_GUARD(&mutex);
>>        ...
>>    }
>>
>> But it's unusual for C code to create scopes without a statement (for,
>> if, while).
>=20
> After staring at compiler dumps for a while I have just concluded that
> this could actually be considered a bug in WITH_QEMU_LOCK_GUARD.
>=20
> QEMU_MAKE_LOCKABLE returns NULL if passed a NULL argument.  This is the
> root cause of the NetBSD failure, as the compiler doesn't figure out
> that &timer_list->active_timers_lock is non-NULL and therefore doesn't
> simplify the qemu_make_lockable function.
>=20
> But why does that cause an uninitialized variable warning?  Because if
> WITH_QEMU_LOCK_GUARD were passed NULL, it would not execute its body!
>=20
> So I'm going to squash the following in the series, mostly through a new
> patch "lockable: introduce QEMU_MAKE_LOCKABLE_NONNULL":
>=20
> diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
> index 44b3f4b..1aeb2cb 100644
> --- a/include/qemu/lockable.h
> +++ b/include/qemu/lockable.h
> @@ -67,7 +67,7 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
>    * In C++ it would be different, but then C++ wouldn't need QemuLockabl=
e
>    * either...
>    */
> -#define QEMU_MAKE_LOCKABLE_(x) qemu_make_lockable((x), &(QemuLockable) {=
    \
> +#define QEMU_MAKE_LOCKABLE_(x) (&(QemuLockable) {    \
>           .object =3D (x),                               \
>           .lock =3D QEMU_LOCK_FUNC(x),                   \
>           .unlock =3D QEMU_UNLOCK_FUNC(x),               \
> @@ -75,14 +75,27 @@ qemu_make_lockable(void *x, QemuLockable *lockable)
>  =20
>   /* QEMU_MAKE_LOCKABLE - Make a polymorphic QemuLockable
>    *
> - * @x: a lock object (currently one of QemuMutex, CoMutex, QemuSpin).
> + * @x: a lock object (currently one of QemuMutex, QemuRecMutex, CoMutex,=
 QemuSpin).
>    *
>    * Returns a QemuLockable object that can be passed around
> - * to a function that can operate with locks of any kind.
> + * to a function that can operate with locks of any kind, or
> + * NULL if @x is %NULL.
>    */
>   #define QEMU_MAKE_LOCKABLE(x)                        \
>       QEMU_GENERIC(x,                                  \
>                    (QemuLockable *, (x)),              \
> +                 qemu_make_lockable((x), QEMU_MAKE_LOCKABLE_(x)))
> +
> +/* QEMU_MAKE_LOCKABLE_NONNULL - Make a polymorphic QemuLockable
> + *
> + * @x: a lock object (currently one of QemuMutex, QemuRecMutex, CoMutex,=
 QemuSpin).
> + *
> + * Returns a QemuLockable object that can be passed around
> + * to a function that can operate with locks of any kind.
> + */
> +#define QEMU_MAKE_LOCKABLE_NONNULL(x)                \
> +    QEMU_GENERIC(x,                                  \
> +                 (QemuLockable *, (x)),              \
>                    QEMU_MAKE_LOCKABLE_(x))
>  =20
>   static inline void qemu_lockable_lock(QemuLockable *x)
> @@ -112,7 +125,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lock=
able_auto_unlock)
>  =20
>   #define WITH_QEMU_LOCK_GUARD_(x, var) \
>       for (g_autoptr(QemuLockable) var =3D \
> -                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x))); \
> +                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x)))=
; \
>            var; \
>            qemu_lockable_auto_unlock(var), var =3D NULL)
>  =20
>=20
> So thank you NetBSD compiler, I guess. :P

Yep, new patch looks good.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Paolo
>=20


