Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13760C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D240D2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOHKAK27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D240D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59729 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jwD-0003mW-45
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8juH-0001iE-Nf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8juG-00004w-Bp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:45 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8juG-0008WL-5W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:10:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id a132so904009wme.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xJIsiMyaBYDsEPr0oOPhQVJ4jQ0cw7Lb9cYeGiAP6Vk=;
 b=VOHKAK27QDAyZxwfLuwHq5WLLAqVi9ZrN6lPzTDSsbD55M2STcoxpyfSHYiwi3BEWB
 a0fO4LS9k5EdruUxOHhu3YmmjXDUT7xy3tZtkPQBRkN8QJsZLWZByy1aUEqirnjhJFO6
 JIETytZUMfep1+/l530ssflaLrvaIMLsbjurKt40ohD9q8T0fA2frqWMJ+gLtRrt9Bkz
 brHalOD9K4aOSB9QAaoWoBI5ziiRILC//lJOtK2KR/ZaT1J2RFtSHLqeOxeGMuPCWBHS
 60Wn1wUdoytXJnuYj4gL0DGL8XgJT+jCXXFYaw6fRrthPaeYingNKdWUI9J3JEgs0fnR
 2GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xJIsiMyaBYDsEPr0oOPhQVJ4jQ0cw7Lb9cYeGiAP6Vk=;
 b=qVD/ERhpSZSPokScwsWdC9WabXWZFDNFsKMn+DdYLHh1rvjtuLrw7ciCoDZ/kCW6RR
 azlnT4w9Ld1umLst57u+KwRnNwEr7UkozcBkk+0hfj+bAt5BC6eYvKbXQScDh2Ap1t9b
 q2d4bUg29Mfv14xpv9yIZa/G/sPDp0n1kbpe7UBMsleszk5e+wzMKsvAHawDLx0VM8Ay
 IMNIpo2yS7TMaN4nfJAAiijkbryILHfPM8tS0iaWBadFS1Z1qR26fH6Aoc38bPA3D3Sp
 t7QyzuFoFTifka8Q3mFFD2jNMh5F8GhsFp8KcDHanP1HZvi85WM94yvZULpatPgLQI4w
 RXPQ==
X-Gm-Message-State: APjAAAV6Eh31F3KgTCyVeXl7krJxnZmUe3ZwjF28m9DZ8/8qHtQMq5+F
 SWENa+O1X7k2U6x+G7rjg5fYiQ==
X-Google-Smtp-Source: APXvYqw8uSTFt0zDW555vFm89LxtgwjK//W4VxRGo+C4NO6J45oE3r5k6NM+/a9GpLw8fQy+cyDdqg==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr19670326wmc.139.1583151043026; 
 Mon, 02 Mar 2020 04:10:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm8344394wme.4.2020.03.02.04.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:10:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 874891FF87;
 Mon,  2 Mar 2020 12:10:41 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-18-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 17/33] docs/system: convert managed startup to rST.
In-reply-to: <20200228153619.9906-18-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:10:41 +0000
Message-ID: <874kv7arem.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Fix one typo in the process and format more option and
> command names as literal text, but make no significant
> changes to the content.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-17-pbonzini@redhat.com

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/index.rst           |  2 +-
>  docs/system/managed-startup.rst | 35 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 docs/system/managed-startup.rst
>
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 5034f903407..d655344fffd 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -13,6 +13,6 @@ Contents:
>=20=20
>  .. toctree::
>     :maxdepth: 2
> -
> +   managed-startup
>     security
>     vfio-ap
> diff --git a/docs/system/managed-startup.rst b/docs/system/managed-startu=
p.rst
> new file mode 100644
> index 00000000000..9bcf98ea790
> --- /dev/null
> +++ b/docs/system/managed-startup.rst
> @@ -0,0 +1,35 @@
> +Managed start up options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In system mode emulation, it's possible to create a VM in a paused
> +state using the ``-S`` command line option. In this state the machine
> +is completely initialized according to command line options and ready
> +to execute VM code but VCPU threads are not executing any code. The VM
> +state in this paused state depends on the way QEMU was started. It
> +could be in:
> +
> +- initial state (after reset/power on state)
> +- with direct kernel loading, the initial state could be amended to exec=
ute
> +  code loaded by QEMU in the VM's RAM and with incoming migration
> +- with incoming migration, initial state will be amended with the migrat=
ed
> +  machine state after migration completes
> +
> +This paused state is typically used by users to query machine state and/=
or
> +additionally configure the machine (by hotplugging devices) in runtime b=
efore
> +allowing VM code to run.
> +
> +However, at the ``-S`` pause point, it's impossible to configure options
> +that affect initial VM creation (like: ``-smp``/``-m``/``-numa`` ...) or
> +cold plug devices. The experimental ``--preconfig`` command line option
> +allows pausing QEMU before the initial VM creation, in a "preconfig" sta=
te,
> +where additional queries and configuration can be performed via QMP
> +before moving on to the resulting configuration startup. In the
> +preconfig state, QEMU only allows a limited set of commands over the
> +QMP monitor, where the commands do not depend on an initialized
> +machine, including but not limited to:
> +
> +- ``qmp_capabilities``
> +- ``query-qmp-schema``
> +- ``query-commands``
> +- ``query-status``
> +- ``x-exit-preconfig``


--=20
Alex Benn=C3=A9e

