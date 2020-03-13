Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9841C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D3B206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pknLb6Ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D3B206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmo7-0004Jl-NH
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCmly-0001sl-Kk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCmlx-00076y-9S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:02:54 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCmlx-000735-2O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:02:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id 111so10564280oth.13
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QuTb8enCWyqbtJ9yF0dP7kB4AiBpi/cv5FNjg4kPaiM=;
 b=pknLb6Ngz7H5bo+YGJXz4Wu2haHRJh1a8hQeSSnpdebkJ4/g7vQ1Xi8flR0jfuBogc
 RH+kHyK/M8q8FpPtoOFdUhSpWAjXzqIqUHaSqAxH+jmRBKsXfCdg4c26zkID3Ry6HmuZ
 qdWem2wzSIlJA+Sc8W0qSbxzne+7bJPDsyJBrG+0oB36gpFjwyw5FviuLxAcJqeGZqzi
 AuSH/Bz8rT7H74sN1ffQMiGHV4fKGticKhCVmlfs8tJStjSk8UDJ2NePSoSICqeiH20B
 cSbrtw6UEDvpI1FFu0R8/c4KdJJ1Jp0LbzDatkszh1gwRJp9zshDTZNvEvFaY+GF8G7w
 u6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QuTb8enCWyqbtJ9yF0dP7kB4AiBpi/cv5FNjg4kPaiM=;
 b=hcRKnb/sj3VTzp71VBoiVZD/wftf85ae03oSYXFPs0Hz0xVN30pZ+B6KLQi8hKvUUj
 mcMJxLyMY5KTE+gRJvbC67+ewoscxRPQ4noiDTU1xboLNMSSacuWB8XRAanc4Dc/bEFt
 kdiPihUzYEHkrUVwa7QeUQq8Oc900DvdLiJFu6PJW0XDQ2LDNOVkoq0j5mKch2ZD3W+u
 Rkycp30PqhXq3VeOoT3vQF9eVYjUiWZZkulUeIfn6cUcqIPDFEmHjXlAWXzNTWjoCvD4
 lQQSz5Ttwv5S1QdBkodLMPJ1xGMZh74ITitAX9IFzwBkzOsr9vzlAkhGCerh7B/FHxYf
 6J2Q==
X-Gm-Message-State: ANhLgQ2xBdrJkA7mNh3L6QJz4/0pZ+J9G5RtLCQ7bja1cFJegYE4YY22
 0sQsZlqEDSt3e9Op8jJG23uH3qQlGfr2E2kix3hHPQ==
X-Google-Smtp-Source: ADFU+vs+QjAwe70RW1wtif7zISG5vhcJqsiZgf30rBiIOkGwdNn8Q2JBsG5Tt5UDUxQiWuz6w56eOklV6JeNogICA+I=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr11757795otq.232.1584115371834; 
 Fri, 13 Mar 2020 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200313155939.240533-1-dgilbert@redhat.com>
In-Reply-To: <20200313155939.240533-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 16:02:40 +0000
Message-ID: <CAFEAcA9ncKw-F8PdtLyGL6utxfo0YyZi3XmfOB33nu_xddf2tQ@mail.gmail.com>
Subject: Re: [PATCH v2] exec/rom_reset: Free rom data during inmigrate skip
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 15:59, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Commit 355477f8c73e9 skips rom reset when we're an incoming migration
> so as not to overwrite shared ram in the ignore-shared migration
> optimisation.
> However, it's got an unexpected side effect that because it skips
> freeing the ROM data, when rom_reset gets called later on, after
> migration (e.g. during a reboot), the ROM does get reset to the original
> file contents.  Because of seabios/x86's weird reboot process
> this confuses a reboot into hanging after a migration.
>
> Fixes: 355477f8c73e9 ("migration: do not rom_reset() during incoming migration")
> https://bugzilla.redhat.com/show_bug.cgi?id=1809380
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/core/loader.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

