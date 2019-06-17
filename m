Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEDFC31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9392084B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0BKu16T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9392084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsWZ-0002hO-5T
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsLz-0005zo-JC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsLy-0002Ok-EG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:11:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsLy-0002OE-71
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:11:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so10145731wrs.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZDQPHFFff8QCBoitbug7jIyoAmDc4XFn2vVla/JG9O4=;
 b=k0BKu16ThsqFWJR9E1O+7pW5MAztwAQVVv+2wM3Gi4OTzQ68hHnSufs4BYiJF22tOd
 RNn96C7IZy/ze+4Nzxz9Nk52cwDoxiR/0SpIlroNQN+SIkmzw/OVlE2G3gEYtlubV1Ir
 pAVFOmuzG9JnOTBnrAOOk6fzeVrYDvkSQroyvfvnSYWQjFlCtXvMyXThDKiZgfzKue0Z
 YYFF9YM4VGozFNUy4UOXd73lgjkZ14E7GSzpmofHks4Q/fEMsSmHEjSDPXCc0Y8fv/Df
 JDkdlahwLh6uzrKN/l/9wab97k3aMnSLutz8GGASHnC5wIFl6eOcRfX2JfAjWX8rxEus
 j/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZDQPHFFff8QCBoitbug7jIyoAmDc4XFn2vVla/JG9O4=;
 b=fNfRW/SZxJcbSFiCRJW9A1q7J+r9voTHzlHC51/VnXUNwOAWwSoHgtbzLrvN2quUgd
 9TJSl4k7t6LgeWIz0nJhJYdeEiLSEuE9F0DDZI1B6l8qBqBxlZc+YykN3dzXH/lFirr5
 OvK3W0duJYMOe59fWRAZTHXy9Q6HtPAXl3e5E6MuYDkgduMXycV6jpGWVf9Dc4xaPYKu
 oDOrMzue62ERvEA0eIUVNB5T/gPBOnukCh2wBRRrkVzQG7t0/FEKDbkB0kcltC2U5jaY
 lPIlSVo0Nt7LRNiR8qcmJD9S4K0kX0GnxqtfbRpjqOrrIRDB8075C6UtHZO0mORUz7GP
 /oBg==
X-Gm-Message-State: APjAAAVCtl9zOCbrly55ECNLqgJiyquJjA1Go7BRrmh5Sxxl2GTDBN7E
 r7RODf6MAD3rU5z8Ec959ISYMA==
X-Google-Smtp-Source: APXvYqwI5hcpJoEAouCVBvvoXkljPTRM9FRPOA6zIb68CDVcOQr/l1oQDmRqQU47LXM3BDcAJuP/kA==
X-Received: by 2002:adf:f544:: with SMTP id j4mr5176091wrp.150.1560780681139; 
 Mon, 17 Jun 2019 07:11:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b203sm17210506wmd.41.2019.06.17.07.11.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:11:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43FA81FF87;
 Mon, 17 Jun 2019 15:11:20 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-14-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-14-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:11:20 +0100
Message-ID: <87o92w9u9j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 13/23] target/arm: Make the
 v7-M Security State routines
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The Security State helpers are now only called within v7m_helper.c.
> Remove them from "internals.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This does seem a little round the houses, but whatever:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  target/arm/internals.h  |  8 --------
>  target/arm/v7m_helper.c | 10 +++++-----
>  2 files changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1d15af3f8b..fe9e4665e2 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1043,12 +1043,4 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t =
address,
>                         int *prot, bool *is_subpage,
>                         ARMMMUFaultInfo *fi, uint32_t *mregion);
>
> -void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> -                                          bool new_spsel,
> -                                          bool secstate);
> -
> -void write_v7m_control_spsel(CPUARMState *env, bool new_spsel);
> -
> -void switch_v7m_security_state(CPUARMState *env, bool new_secstate);
> -
>  #endif
> diff --git a/target/arm/v7m_helper.c b/target/arm/v7m_helper.c
> index b50bb98e06..aa6a08e326 100644
> --- a/target/arm/v7m_helper.c
> +++ b/target/arm/v7m_helper.c
> @@ -94,9 +94,9 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr=
, uint32_t op)
>   * stack pointers if it is done for the CONTROL register for the current
>   * security state.
>   */
> -void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> -                                          bool new_spsel,
> -                                          bool secstate)
> +static void write_v7m_control_spsel_for_secstate(CPUARMState *env,
> +                                                 bool new_spsel,
> +                                                 bool secstate)
>  {
>      bool old_is_psp =3D v7m_using_psp(env);
>
> @@ -121,13 +121,13 @@ void write_v7m_control_spsel_for_secstate(CPUARMSta=
te *env,
>   * Write to v7M CONTROL.SPSEL bit. This may change the current
>   * stack pointer between Main and Process stack pointers.
>   */
> -void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
> +static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
>  {
>      write_v7m_control_spsel_for_secstate(env, new_spsel, env->v7m.secure=
);
>  }
>
>  /* Switch M profile security state between NS and S */
> -void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
> +static void switch_v7m_security_state(CPUARMState *env, bool new_secstat=
e)
>  {
>      uint32_t new_ss_msp, new_ss_psp;


--
Alex Benn=C3=A9e

