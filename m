Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A806C5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1417C206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjuyw94m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1417C206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT3Ez-0003lA-6r
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3Dx-0003CS-Rz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT3Dx-0008NJ-E1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:51:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT3Dx-0008Hl-1m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:51:01 -0400
Received: by mail-ot1-x343.google.com with SMTP id z25so25824861otq.13
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v+r2yLU2ralP0WMkIwFibE7Ylz22PJh/HgQU/b0MghI=;
 b=bjuyw94mO+O4p8zA/P5JryBr2te/rfPxztvpg1raZSVc8UITSLjUhnpx679ED027f3
 9WtiIRez59e0KvZVsF0LerwMfvZGva15pGEGgxXRMjHCKBV+7/jL21J0MwFBEK6WEAho
 4gJ9tYsMe1/YSlykl9/JBhUC77huwjqNIH96CFhTUHr1ecR0kDLlIDZcVREWKowJgN90
 8fD66xIgTx23NXQR25cyqykl1q1Ww0UivE2ANCuhNR4J9PhjeFJ1Gt/SuKxhCuFlfCJy
 XOOLF4P3hFDIn8zURVPYkoiCn8nGDiO3mylTWxCf8Jh3On9bDn8tvqimWvqt0U1PcTsr
 TWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v+r2yLU2ralP0WMkIwFibE7Ylz22PJh/HgQU/b0MghI=;
 b=cjSzqKADEioMm5o5Fhv6YficHApa9LSNgxdlEkP22MpKqXisKMuYMYwbSE6NUBojk4
 QTPFnpYZyxmI7rKuKGjIRMWxAUsiQppgA5zm1dSjFM0E0b6aoqjnnhw/iCDwOGts9Rr0
 nZ1QjcKDZCLjmeaB9F/MJswmUs5O0I6iiJid3tdwmWU6LSP3JN02rZlCyvQrp8DKcaLb
 PR7JHBEo+InoqTAWdaOmOItTPahvljMpnUwE3pXbA4aPjN7u9kwXRiP7o8v64a1y+hSx
 QE00TqkOjYM9njZ8fWF2JceZuCrf8gLS6pPEULCwiQ+S/o7RHQ2dRU1ikjACwsKZz4HO
 Qozw==
X-Gm-Message-State: AGi0PuZqix5B5xbJ/Ee+BOKVPEgMdkeivG9FOjalojWjWJcyJFois2gB
 n4VOpaKNGpEDfwmHI7iNKO3Yr3FrihjSwMApwQt9ew==
X-Google-Smtp-Source: APiQypLDkFC0TNTE8eqKy9qi+N5rBgc7Su3hg83gbLzgwglq5lGcvtssoLSwTviWLf3OiwTmL14IsqLbC4Q2+rlESkA=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr18553439otb.135.1587991859838; 
 Mon, 27 Apr 2020 05:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172351.26583-1-pbonzini@redhat.com>
 <20200422172351.26583-8-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-8-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 13:50:48 +0100
Message-ID: <CAFEAcA_s3H=-WMMY8CL7EEMejjoUQgqJVLGs9-hG0=D0bhG9Tw@mail.gmail.com>
Subject: Re: [PATCH 7/8] run-coverity-scan: download tools outside the
 container
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Apr 2020 at 18:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This lets us look at coverity_tool.md5 across executions of run-coverity-scan
> and skip the download.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

