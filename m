Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3101BC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF9D2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0bi8aRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF9D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2S2-0003Al-63
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz2RG-0001wS-Ul
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz2RF-0008EM-Dw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:56:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz2RF-0008As-9g
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580839000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmcGq+SeBYRzWEd2gMUMrRdVDVrFurJLZf8w4rkubU0=;
 b=Y0bi8aRx5KHWXt4dRM/385JcBl9FgsSzTKZCLE6yn5pl6pXgZTv6ahWf3Bl9hqWH18DpoS
 PvlAu7qU2CeDNrjCRrQO/nFjgOv/ueLjUiTkEPaqJlzx2Uaunlhpu+3a64h88lUrOvNMW5
 YXF6nR4fVELH2WCUjAGDLL7vpgCcbbE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-8-fDHgEePOKJQqm94tO5WA-1; Tue, 04 Feb 2020 12:56:38 -0500
Received: by mail-wr1-f72.google.com with SMTP id 50so9825448wrc.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 09:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FWLAeBJJDvy7HDRJabaYjJ8UaikqOpX3lQqItgxvTDE=;
 b=QegpQF9V/yjPZTpZ0ni8kpKlqY9YNnWPWQYhXr5B/YZUqe2iFqv6KaLivWbcWpZ45l
 /5uGjlTb7VhrJa3WkfhxvPskXKfjZnR8PfDOiOLOuxNccdEI3HJn3hSn5D63bOS2QomU
 6WPCvinzzJf5u8735kVtT4tuJGGddrKz6kYmJ7Fmi34DlhBVsnuMrkRa/iCQzGscoVT1
 Q6xh4BOj6eUGOGJgSZA8LlEHo4pCoGsZURhPA3dGInsig9+dKqOyX9kiDmSOYaH4izX2
 qXyGpnBc5aXgka9OU30sn1sUi+NBlmQE8P+kU2jaxA3c592CphJMcCfZlSdJEs9Kz0UH
 YdLA==
X-Gm-Message-State: APjAAAWVrUjr8rNndwCCVFgV1mdSeSCVtY5gvdRMUYuOOy6vHt6H0yIh
 JPnY6e24vm8Alg453jKO+SpVIyIgT2Z1Kc2JOmvamAJwVyLMl4h0xFN6uDZn5SPUTrU10JHLBmH
 rNmUj6/acMNbhhKU=
X-Received: by 2002:a7b:c759:: with SMTP id w25mr192226wmk.15.1580838997647;
 Tue, 04 Feb 2020 09:56:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4l1GgCdBzqxTi4PFPPjH/6FeuobEF1VpavtS8wV8KqveJ0bhk1HKJDaAzFtkr1O5Ff/DZJQ==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr192206wmk.15.1580838997386;
 Tue, 04 Feb 2020 09:56:37 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id x17sm30466930wrt.74.2020.02.04.09.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 09:56:36 -0800 (PST)
Subject: Re: [PATCH v2 2/4] linux-user: cleanup signal.c
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-3-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6079dfe8-754b-632b-4f0c-42fb0cd11380@redhat.com>
Date: Tue, 4 Feb 2020 18:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204171053.1718013-3-laurent@vivier.eu>
Content-Language: en-US
X-MC-Unique: 8-fDHgEePOKJQqm94tO5WA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 6:10 PM, Laurent Vivier wrote:
> No functional changes. Prepare the field for future fixes.
>=20
> Remove memset(.., 0, ...) that is useless on a static array
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>=20
> Notes:
>      v2: replace i, j by target_sig, host_sig
>=20
>   linux-user/signal.c | 48 ++++++++++++++++++++++++++-------------------
>   1 file changed, 28 insertions(+), 20 deletions(-)
>=20
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 5ca6d62b15d3..246315571c09 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -66,12 +66,6 @@ static uint8_t host_to_target_signal_table[_NSIG] =3D =
{
>       [SIGPWR] =3D TARGET_SIGPWR,
>       [SIGSYS] =3D TARGET_SIGSYS,
>       /* next signals stay the same */
> -    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> -       host libpthread signals.  This assumes no one actually uses SIGRT=
MAX :-/
> -       To fix this properly we need to do manual signal delivery multipl=
exed
> -       over a single host signal.  */
> -    [__SIGRTMIN] =3D __SIGRTMAX,
> -    [__SIGRTMAX] =3D __SIGRTMIN,
>   };
>   static uint8_t target_to_host_signal_table[_NSIG];
>  =20
> @@ -480,31 +474,45 @@ static int core_dump_signal(int sig)
>       }
>   }
>  =20
> +static void signal_table_init(void)
> +{
> +    int host_sig, target_sig;
> +
> +    /*
> +     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> +     * host libpthread signals.  This assumes no one actually uses SIGRT=
MAX :-/
> +     * To fix this properly we need to do manual signal delivery multipl=
exed
> +     * over a single host signal.
> +     */
> +    host_to_target_signal_table[__SIGRTMIN] =3D __SIGRTMAX;
> +    host_to_target_signal_table[__SIGRTMAX] =3D __SIGRTMIN;
> +
> +    /* generate signal conversion tables */
> +    for (host_sig =3D 1; host_sig < _NSIG; host_sig++) {
> +        if (host_to_target_signal_table[host_sig] =3D=3D 0) {
> +            host_to_target_signal_table[host_sig] =3D host_sig;
> +        }
> +    }
> +    for (host_sig =3D 1; host_sig < _NSIG; host_sig++) {
> +        target_sig =3D host_to_target_signal_table[host_sig];
> +        target_to_host_signal_table[target_sig] =3D host_sig;
> +    }
> +}
> +
>   void signal_init(void)
>   {
>       TaskState *ts =3D (TaskState *)thread_cpu->opaque;
>       struct sigaction act;
>       struct sigaction oact;
> -    int i, j;
> +    int i;
>       int host_sig;
>  =20
> -    /* generate signal conversion tables */
> -    for(i =3D 1; i < _NSIG; i++) {
> -        if (host_to_target_signal_table[i] =3D=3D 0)
> -            host_to_target_signal_table[i] =3D i;
> -    }
> -    for(i =3D 1; i < _NSIG; i++) {
> -        j =3D host_to_target_signal_table[i];
> -        target_to_host_signal_table[j] =3D i;
> -    }
> +    /* initialize signal conversion tables */
> +    signal_table_init();
>  =20
>       /* Set the signal mask from the host mask. */
>       sigprocmask(0, 0, &ts->signal_mask);
>  =20
> -    /* set all host signal handlers. ALL signals are blocked during
> -       the handlers to serialize them. */
> -    memset(sigact_table, 0, sizeof(sigact_table));
> -
>       sigfillset(&act.sa_mask);
>       act.sa_flags =3D SA_SIGINFO;
>       act.sa_sigaction =3D host_signal_handler;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


