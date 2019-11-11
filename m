Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899DDC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5252721872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 12:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQIyMtv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5252721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU8Oh-0003gZ-DJ
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 07:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iU8N2-00039V-Ll
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iU8N0-0007aN-E1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:00:36 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iU8My-0007Y8-EK
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 07:00:34 -0500
Received: by mail-oi1-x244.google.com with SMTP id i185so11222093oif.9
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 04:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OSzGLRangEZPGAnw9V7uvbuDUzSKpX80al0NptIJ0AA=;
 b=iQIyMtv6Cyq0b+URUefzs22v0Y/wfHvdCc1wZIsLByyCkyFQLHQe1vi0/56BEDsDrt
 tjt2F03vGxbGiZEZVlJtCbt8aH6uy0wcIY/jKnU6eZpCRf9/5AQ5p+fDNHzJ/dGgBjCg
 AK4prWADWDCIMx2NCfNeZ4WdgYtUru0/4c6AULZXrSowEwWe6Ghy1h8PThW0lbOAsO79
 hErd8P4XjT/8lFPI3yRKcbO2IuJJOBqofBy0JWR/7AK743AE/3Wxj/Mgftj0gY+oFtN7
 rppPZKRwjQkpLFzEIMrc0EIXyrauVHcJkGKpBi/OiD2anorMSopv0eGcgcjDCmU0la3x
 q+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OSzGLRangEZPGAnw9V7uvbuDUzSKpX80al0NptIJ0AA=;
 b=bYW/8xznmTd/VhxLMVxAV8hkO9DGHyZvYIXN5x6pq1oC0OyJcKWBjQDyb4/FzltKMk
 4nJo85qzaVVtMGOn0scqVc81zqJgfj0IxNOUD53KmhDDq7jcrUaEqXK8yWdWTYGaaICD
 +sz0MHK5MoeOU8Sjq1rFmcabouRPkqPnryRwGVToYDKjgnNdGTB74Z7Xc2+QGVddPUBM
 Y9BahBsJ51esq5yT8sqhZuXjRKU6zorwYW1NIax4JDVxKhkyjkv9DeLjIb7x1Lm6il22
 xK+zcnNJfp+upDbmwMZ6tFCfM1882yfsJeej0naQqNMn6gZ7kqNq04yZA9eg84n+A8ON
 7ZFg==
X-Gm-Message-State: APjAAAV+d54mt92XcXBBsZCbap7F1FBhnZXOIKG7SOCmyEfCRYFn0nbw
 z7M1mqzAm6Fg3UOzuaB1+18SbafuEqx5uTA6bgwnfQ==
X-Google-Smtp-Source: APXvYqzw/t4lx48G7OU081BzxAT5RH8/nblzl+gjvO2E1gIYTypJQlojeI+tyhxKj98kHAnfZjmJ57Hgy9NY+i/L1/8=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr22501245oig.48.1573473630375; 
 Mon, 11 Nov 2019 04:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20191111113501.10211-1-alex.bennee@linaro.org>
In-Reply-To: <20191111113501.10211-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 12:00:19 +0000
Message-ID: <CAFEAcA8VG8pyTbQ3NUZBZbRdp7uyceB_FyzWp32-X=LFz-Fx2A@mail.gmail.com>
Subject: Re: [PATCH v2] tcg plugins: expose an API version concept
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 at 11:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is a very simple versioning API which allows the plugin
> infrastructure to check the API a plugin was built against. We also
> expose a min/cur API version to the plugin via the info block in case
> it wants to avoid using old deprecated APIs in the future.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> ---
> v2
>   - error out on missing plugin version symbol
>   - fix missing symbol on hotblocks.so
>   - more verbose error text, avoid bad grammar
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

