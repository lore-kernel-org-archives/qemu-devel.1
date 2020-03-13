Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F59AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20CB206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ow3w9gt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20CB206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkHd-0007cG-1j
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkH2-0007Bu-5o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkH0-0006uQ-Oi
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:22:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCkH0-0006to-KL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:22:46 -0400
Received: by mail-oi1-x243.google.com with SMTP id y71so9281606oia.7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tIhT9RkNi26F0uPQlkj3e3uT3165a4NlVSG8CphaLgA=;
 b=ow3w9gt5xf72XgWeJus6Eau+zDF5iSi1jRgpIyQjulggBEeyjNcomrHCAVAjonm/Fg
 aWej3qyff93MUWGVVdTdz6CQ80Req4JEAV3Cacn+1JVCUPUEYQ5rn0Doy7o7NWyJI2XM
 GTk8lU9yqE3+/K9ht2dQXKg1+1B+bNwVXN0Zu2u/436vSQe1LoDqu+Dv3jpQhIFVzcsG
 u80DViZsfmZLpmrtQ9oKDJr0sP+jggzSplcmwx3jIKDUmOEEAhftJruTJqHh/LtXJzTZ
 uVeNzlKQFlZ6Je0CrRkxWsSMVKq0dSn+MCdjdeRGFBL/iIWdkV4pMZmZ6/u/3AoTaXTq
 6fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tIhT9RkNi26F0uPQlkj3e3uT3165a4NlVSG8CphaLgA=;
 b=K8DyVIhwwsp54VQBnwLV5egqZcVlQysdwteUNfSY+VOfdNvghK/0+qyQGsuKUxY2Jc
 6SIFw3AWO01WjE98u5DCIlCNTaxGwUQQbXfGXtcqD7hnzVMbX2d1MB6xtNEbKWydumyL
 epR3Fl1gXP1L8pujliqNS48HnXTRPpWx3PWHZdldAcfhNwtqzTtIfVl8jbaGA+7VYOx3
 DbQsGyvfCcLIYwotiWxG/a4/ElxM67YFfNdC8SUnG7qfTBSET6B2NwAXA9ChVQV4cEZX
 NHBxIEIbwu0jlaQrcQ5zfEw38cv0RXBnMnsVR1kbAOPz53MjhHEuCwJih6PPAJstx68k
 KX4Q==
X-Gm-Message-State: ANhLgQ0VSw4abbTiEDA1rzsbakFOvFSLluMgHz4IBdEHvcQriP2Azz/T
 qFIKotkAY8sGAj3kxwqTB+PP3iqYngLxrizI021fMA==
X-Google-Smtp-Source: ADFU+vuw757g5uqBXv/760hR8doaaC43Sen6T0X9qYCHY8cB2Rle2Gjw+Fn48zqZGTl49JkGS2a/NkeeR1MotmQJjMA=
X-Received: by 2002:aca:c695:: with SMTP id w143mr7018079oif.98.1584105765809; 
 Fri, 13 Mar 2020 06:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200313123014.206828-1-dgilbert@redhat.com>
 <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 13:22:34 +0000
Message-ID: <CAFEAcA9pBMC0W9cHKmq5nttPcA9qpYofSvkZEnmkGuS2g_vPTA@mail.gmail.com>
Subject: Re: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 13 Mar 2020 at 13:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 13 Mar 2020 at 12:31, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Commit 355477f8c73e9 skips rom reset when we're an incoming migration
> > so as not to overwrite shared ram in the ignore-shared migration
> > optimisation.
> > However, it's got an unexpected side effect that because it skips
> > freeing the ROM data, when rom_reset gets called later on, after
> > migration (e.g. during a reboot), the ROM does get reset to the original
> > file contents.  Because of seabios/x86's weird reboot process
> > this confuses a reboot into hanging after a migration.
> >
> > Fixes: 355477f8c73e9 ("migration: do not rom_reset() during incoming migration")
> > https://bugzilla.redhat.com/show_bug.cgi?id=1809380
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/core/loader.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
>
> >      QTAILQ_FOREACH(rom, &roms, next) {
> >          if (rom->fw_file) {
> >              continue;
> >          }
> > +        /*
> > +         * We don't need to fill in the RAM with ROM data because we'll fill
> > +         * the data in during the next incoming migration in all cases.  Note
> > +         * that some of those RAMs can actually be modified by the guest on ARM
> > +         * so this is probably the only right thing to do here.
> > +         */
> > +        if (runstate_check(RUN_STATE_INMIGRATE) && rom->data) {
> > +            /*
> > +             * Free it so that a rom_reset after migration doesn't overwrite a
> > +             * potentially modified 'rom'.
> > +             */
> > +            rom_free_data(rom);
>
> Shouldn't this condition match the condition in rom_reset()
> for when we call rom_free_data()? You want the behaviour
> on a subsequent reset to match the behaviour you'd get
> if you did a reset on the source end without the migration.

Wait, this *is* rom_reset(). Now I'm really confused.

thanks
-- PMM

