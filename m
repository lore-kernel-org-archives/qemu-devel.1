Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62022074D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4wtG65F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62022074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHa8U-0007wp-Ug
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHa7P-0006y6-P9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHa7O-0005Kb-C4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:32:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHa7N-0005Jm-9s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:32:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id t25so6988306oij.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4bQJElQtxExdNClri0m5sgcXCnjLo99SHgCzJWX7tCU=;
 b=r4wtG65F0C2G/xy8cnOso46Q1Kq9XK70ovOONPapRMhNsSTuv8jehWPG+LVe/Ur5XM
 WKXO94T1RtNgqdsNJe6O4LV5kApbV90934Vdxwu+tQKu2+PtJJGYHS+Ak+WFEtTaBZ+q
 f0bXdqljRCWtsNrJTyAvVqyqYWKE4cbCK/ODpn2ZDRivd5bWzbuQgNqJWDCpVgfOz5IS
 i0lDaz5iDOjoyMnjN+kRfRpAlFcjCyHpZo6rChP7yq5mnwsq4B4RkMuvTyBO/zYYiQdt
 vvF9U2Gcfcu8z5DKVhxyWCKWyfGiGzxISq013pYrAGpzAOZxGFG0lIZj57dUOIjWgulU
 WjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4bQJElQtxExdNClri0m5sgcXCnjLo99SHgCzJWX7tCU=;
 b=TMgxqCKGzjzDEpXbfBMcSdYAx3FUW2LQ8fWyJ7/ARfEeK1MpWOFyrnooekvEcnVS+y
 AO50reT4V3EJiqN4HHk6R98aWsIg3Tf9SxJyjKfSttu17wgGP8q2tXuKVoQK+dUQuNns
 miGU3+1hBME0gKRIEE3GB72e873CUQU9M7TT9hRzM3X0EJzrZYnRZ+ynli2DuAfs9BfV
 1urDOaqlU5GyYseivFDTHlUo6oOA2HWyF4BCtb2mB82t8wN9F85uWu88SXNs5TKaCh3F
 M9WKHInuiUdfZR1xsNTW1YGejWejwGm5dXjIFLiDRJFMQ5vUOZ11u9EbS8qkYfTOFshr
 kmqg==
X-Gm-Message-State: ANhLgQ1Je4vQ78McMILxGOPx7nv9n15W++3rvjKPYGsZDq7Xoq4rcFJn
 wTOBNvpCSd5iWqgSeGhcZ90mzkuCCjVZMpGbZmfcJg==
X-Google-Smtp-Source: ADFU+vvf9kTUVpIi/Ws1MPcDpRPXqP2YiW6XL3c5jo14iT1qdSeGyaKyAFE+hAaYg+sm1UnThkUV9gbDgfNnMCGGA6w=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr1790415oih.146.1585258368267; 
 Thu, 26 Mar 2020 14:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-2-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:32:36 +0000
Message-ID: <CAFEAcA9qmwCmu-0OmNF-TkXzdd3qrhPxQRO6DS36X=Up2g4QoQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 01/12] scripts/coccinelle: Add script to catch
 missing error_propagate() calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> In some places in we put an error into a local Error*, but forget
> to check for failure and pass it back to the caller.
> Add a Coccinelle patch to catch automatically add the missing code.
>
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

This coccinelle script is impressively deep magic...
My general rule with cocci scripts is that if they serve
the purpose they're written for then that's sufficient
and they're not worth trying to polish further, but just
for my own education I have some questions below about how
this one works.

> +@match exists@
> +typedef Error;
> +Error *err;

I didn't realize you could do this kind of "this thing
must be this type" stuff in the metavariable declaration
section...

> +identifier func, errp;
> +identifier object_property_set_type1 =3D~ "^object_property_set_.*";
> +identifier object_property_set_type2 =3D~ "^object_property_set_.*";

If we relax this so that we just look for "anything that takes
an &err as its final argument" do we hit way too many false
positives ?

> +expression obj;
> +@@
> +void func(..., Error **errp)
> +{
> + <+...
> + object_property_set_type1(obj, ..., &err);
> + ... when !=3D err

This 'when' clause means "match only when the code doesn't
touch 'err' anywhere between the two calls", right?

> + object_property_set_type2(obj, ..., &err);
> + ...+>
> +}
> +
> +@@
> +Error *match.err;
> +identifier match.errp;
> +identifier match.object_property_set_type1;
> +expression match.obj;
> +@@
> + object_property_set_type1(obj, ..., &err);
> ++if (err) {
> ++    error_propagate(errp, err);
> ++    return;
> ++}

Is there a reason we can't do the substitution
in the same rule we were using to find the match,
or was it just easier this way/done this way in
some other example you were following ?

> +
> +@manual depends on never match@
> +Error *err;
> +identifier object_property_set_type1 =3D~ "^object_property_set_.*";
> +identifier object_property_set_type2 =3D~ "^object_property_set_.*";
> +position p;
> +@@
> + object_property_set_type1@p(..., &err);
> + ... when !=3D err
> + object_property_set_type2(..., &err);
> +
> +@script:python@
> +f << manual.object_property_set_type1;
> +p << manual.p;
> +@@
> +print("[[manual check required: "
> +      "error_propagate() might be missing in {}() {}:{}:{}]]".format(
> +            f, p[0].file, p[0].line, p[0].column))

Nice to have an example of how to do a "find these things
and print a diagnostic". This 'manual' match is handling
the cases where we got two consecutive uses of &err but
not in a function that took "Error *errp", yes?

thanks
-- PMM

