Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5DC4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DCC20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlM00l1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DCC20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haS5M-0004jR-AX
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 17:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34988)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1haS30-0002tH-Rj
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1haS2z-00018k-Hq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:41:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1haS2z-00017o-9B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:41:45 -0400
Received: by mail-ot1-x342.google.com with SMTP id r21so9808349otq.6
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xnoKZEGB81OF4PyAUGnsUuuLgt1J2NT0rdvxKDH6KRE=;
 b=JlM00l1fJphZmBA7BGYK4bdBDMUJG4vVqHREVAJDQKoB/IGoFtNJ0yA6MTBpFMjltg
 yzsq1bn4Olc9powwdq49SqW3KvFM1nbbsnvsNEjTG6mFLb8V6clflnYROCoeiV2toIED
 xY61zNxM7fJgqHVOTnB2jBWdqKxVhfKX7dsmem4oe3QbHQ21dv53+gltoAMQLDHqTJ7A
 AFo/usn4RiukNKzWrZ2DlK+luwautp4JdageSPwm9HwJo+BThxa760t8WXwuVoHgql5u
 CjEOJt4/ySWuwsI6fK72h3/3SiPidrQhvbWho1b8xpuD1v2smxqr14AoTcd7wG4ZOSJh
 kT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xnoKZEGB81OF4PyAUGnsUuuLgt1J2NT0rdvxKDH6KRE=;
 b=JKniPA6mqnMYcs8cHFdpIZvDmmqv8/cMVhw1kkFbnsaaBLK6SkVkmxWCjK3fQUcRxF
 d5OFbqpAxQ6cpTv2W+NPGl45ARB5N5a5znHMHRlv2OnyiDA/Os4c8sEXV9SRD8pGJM6g
 qFDpfXjEmJ4T2ctXlUT74z2+aNSdZO/wNN+ShDv68LYuLiwj29gJtyi/9dHJQUVAfXxF
 +n7vGVoPtCAozgrCzPxtZBkLZy2nrVtjeX6WCvj7CqKho5788oDBbiNGlnDxSiXAqlG4
 kfRCWvuPZm1k9z0tZfwUeFwOwBjvcN9yVK+sezVk7TEZ4LMiVcNl48X95OzjL585WVpe
 9ixQ==
X-Gm-Message-State: APjAAAXZQJWN0JerLzZ/GnzQOzDy8UXkBk1mBJAzoaUKTWgXazLUNOuN
 v+zEh5dKduTytxjWMm/Af4TlH0pFLcHDachW+ieOhcwz
X-Google-Smtp-Source: APXvYqzbxgSSlJPcQ8ODymsZ9iqmh0Bjhht+5wG1xow1bNkhLT/9b6C4ra9vW8R8wHO5PjKdGpAP1N0745G/Z9BcIl8=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr13840230otr.295.1560202904439; 
 Mon, 10 Jun 2019 14:41:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 10 Jun 2019 14:41:43
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 10 Jun 2019 14:41:43
 -0700 (PDT)
In-Reply-To: <20190610152444.20859-2-peter.maydell@linaro.org>
References: <20190610152444.20859-1-peter.maydell@linaro.org>
 <20190610152444.20859-2-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 10 Jun 2019 23:41:43 +0200
Message-ID: <CAL1e-=hSY4uWQ9QmebdzkkV4WTZ82JFSW2fRafHBtvdJv1tm5A@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs/index.rst: Fix minor syntax
 issues
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 10, 2019 5:25 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> The docs/specs/index.rst has a couple of minor issues which
> we didn't notice because we weren't building the manual:
>  * the ToC entry for the new PPC XIVE docs points to
>    a nonexistent file
>  * the initial comment needs to be marked by '..', not '.',
>    or it will appear in the output
>  * the title doesn't match the capitialization used by
>    the existing interop or devel manuals, and uses
>    'full-system emulation' rather than the 'system emulation'
>    that the interop manual title uses
>
> Fix these minor issues before we start trying to build the manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  docs/specs/index.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 2e927519c2e..40adb97c5eb 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -1,8 +1,8 @@
> -. This is the top level page for the 'specs' manual
> +.. This is the top level page for the 'specs' manual
>
>
> -QEMU full-system emulation guest hardware specifications
> -========================================================
> +QEMU System Emulation Guest Hardware Specifications
> +===================================================
>
>
>  Contents:
> @@ -10,4 +10,5 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>
> -   xive
> +   ppc-xive
> +   ppc-spapr-xive
> --
> 2.20.1
>
>
