Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E7BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492822072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxdtSifU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492822072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCiSt-0006Tq-FW
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 07:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCiSA-0005xN-5i
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCiS8-0004D8-U5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:26:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCiS8-00047u-OL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:26:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id s15so9670759otq.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LEggssMrNWfgVXP5KOHtpbYiHSEuQvKakj/NOBYQm+Y=;
 b=KxdtSifUuM+kpkjK0R4tgQypAEMlmBEh3lj52KdCqneFD6/O57tx6IsFHuaReDxaQA
 svfQBxzu4MjxY6VEC1PNcT4tjQ2rB9iL3fDAGahviouPqZPzVxzMZy6dT+8k7VP5qf5f
 /ovzpihLXiopypNIMaomkWnsb6HBsJX7T3dRlmzeugz6Uks8+jrrvK/DQaJ+5l7eY/La
 4URMlo3L9hGWaFNuLYmEGMCNrrVLIv2jJJeJS7r7t8yu3EGP3rslB6875+dNmD/1W1qO
 HexdKf13knrLX+T+4N4hxgwTbgxoGOVPS4gzDw+UEmvzXUrcUOLE5hB56TgVaNrGdVro
 /FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LEggssMrNWfgVXP5KOHtpbYiHSEuQvKakj/NOBYQm+Y=;
 b=Ub6P8w2dVfqY3tpp9QGFhCWrUDou+ZVTvI+xGTvQvEH7qfq/tejJHYJo7zMfU008oR
 YLDOo2JXYTnsOFhdzOhG9kROMlFaB7YIFsjeUx67RcfbFhQlGZYcMChZNtbmNdZI+SnO
 aWvDbefq3q2zMkgccjwUIC/KMaGVwzlBPz3yK+E8pspiVeQoTYLedhM8qRY+q7ZRj0Eg
 j2HJxpkiuDJLk6dOjJLCOJ02aV7eKlqm5rT9G7DG1emWsGElbKvD2aA6zdV2bLpXKIqu
 dHKdMFEm01CiNr6ORor13H8Gnjn7ZDRRH/kyVzTbhhr2A4jyRVSAdIGWDtTN3++8o0Sn
 DqSQ==
X-Gm-Message-State: ANhLgQ3aKgFpEjNH9OM314ZKUlJicAiqPZ45PSwNWhHWc5k94Ncae6Ad
 J3W11xVl7WFXaYs2JiCuEky4q5fZcRT1RFWkPLDnRw==
X-Google-Smtp-Source: ADFU+vtGrowFYBvaVC2tS+nKrWMNW8E6BIx07EeafDlw8ECX9OoVQ2XLWPItwNdcMbmS7Qbj2/54pyjbXlG9mz6f41g=
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr9946162ott.97.1584098767568; 
 Fri, 13 Mar 2020 04:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200313014551.12554-1-linux@roeck-us.net>
In-Reply-To: <20200313014551.12554-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 11:25:56 +0000
Message-ID: <CAFEAcA8boUtXByYcgpo-gUnf1SEe2XiVNBbwLvjjijwj1jNxeg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Wire up USB controllers in i.MX6 emulations
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 01:45, Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch series wires up the USB controllers on fsl-imx6 and fsl-imx6ul
> emulations.
>
> The first patch provides a basic implementation of the USB PHY controller
> used in i.MX28 and later chips. Only reset bit handling in the control
> register is actually implemented. Basic USB PHY support is needed to make
> the USB ports operational in Linux.
>
> The second patch fixes USB and USB PHY interrupt numbers for i.MX6UL.
>
> The third patch instantiates unimplemented pwm and can devices. This patch
> is necessary to avoid crashes in Linux when it tries to access those
> devices. The crashes are observed when trying to boot Linux v4.21 or later.
>
> The final two patches instantiate the USB controllers for i.mMX6 and
> i.MX6UL.
>
> v3:
> - Minor cleanup in patch 1/5 (see details in patch)
> - Added patch to fix USB and USB PHY interrupt numbers for fsl-imx6ul.
> - Added patch to instantiate unimplemented pwm and CAN devices.
> - Instantiate USB and USB PHY separately. They are logically different,
>   and the number of instances is not always the same.
>
> v2:
> - Implement and instantiate basic USB PHY implementation
>   instead of emulating a single USB PHY register



Applied to target-arm.next, thanks.

-- PMM

