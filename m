Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B06C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B842072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToP8zVcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B842072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopHm-0004eF-GL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1ioorX-0004d1-7K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1ioorT-0002PM-NA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34341
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ioorT-0002Ob-Fs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578403529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5iODGXm9YBO0JBkqFwGH5xxKJzdGnXkAv9u7IOcH2s=;
 b=ToP8zVcNAXoRxkM6mgnp+7yAYrkjLERtaYVuzA1uw9Pqkhs8VXLMxz5QkLdG63atSzuUY1
 JT0AiVygk7E6vnWjYk3t2fA4Ii1c/e6BHpb1FXVpBvUM9FyqRRX31w4DkHEk+KXtrUtyJ0
 /ASsVhvSQKzV2t3hG0Jb6KL5y55oIw4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Vmc-UkzzNMKtbwaI9M3Wtg-1; Tue, 07 Jan 2020 08:25:28 -0500
Received: by mail-ot1-f69.google.com with SMTP id d16so18143208otq.19
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B5iODGXm9YBO0JBkqFwGH5xxKJzdGnXkAv9u7IOcH2s=;
 b=nN8Lzv176MEb+44ocIlLHgzGrD2NDuoDlCfwaiZe6eAE+07CX+JEz4vQm/KnSBuNNA
 y2rlV+Afh43FprT+Lnoe5nOMOorG5oLqHav69A3ui7hfMl/CKAFgd8ojl8LP3Gfb5wcl
 eZkI9Y0YK0KpYBPalUbQ/a6YaGChrgAjUdad3Mj7Cosm5Pr15ulLio9f6meT3WS00WbX
 4g8m9f3q4mOKBLOBJf4AVm5e/5AWzCGf9QZwbx0jZI0zyTI7Qo11IAElF1V1gdDE5Pe8
 55jdIm88HipKgmeH26zcdKV1uAqzcPswhLfX7+wYTZhM0G4c/jvLUCUZRyM+zGoVKzS+
 kRIg==
X-Gm-Message-State: APjAAAXlWKbn9jokrTLBntn7QIkjh9CyFQPtyq+H1ZhM7SizKsSmcPbc
 xATS1nELeP6oM0zZtxCRa1ZswKZuUdslWth8UNhWanEdWal23ricbkpaKdSW2O7UGo5h348Hmy9
 osIsUNjIezAOdNyQCkN5wUujsSiAtTRg=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr99574519otk.166.1578403527133; 
 Tue, 07 Jan 2020 05:25:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6iKTAxPb1Vc7dO+DIoWHUiI/xwL//ARmZTdeeZw0oOs9ymxcXnBgDYk1FYkKcuKnsxHASzDX/neQqsL7w+gk=
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr99574496otk.166.1578403526898; 
 Tue, 07 Jan 2020 05:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-13-marcandre.lureau@redhat.com>
 <CAFEAcA99ajBCrmG=E6wPru2d3VYFzbvopfno8F62xvO8o3NikQ@mail.gmail.com>
In-Reply-To: <CAFEAcA99ajBCrmG=E6wPru2d3VYFzbvopfno8F62xvO8o3NikQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Jan 2020 17:25:15 +0400
Message-ID: <CAMxuvawqnkmcsQ8=+SPSRaSYELnBFJB-7SvwfSOQyYzueKhgeQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/37] serial: start making SerialMM a sysbus device
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: Vmc-UkzzNMKtbwaI9M3Wtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 7, 2020 at 4:55 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Fri, 20 Dec 2019 at 13:47, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Memory mapped serial device is in fact a sysbus device. The following
> > patches will make use of sysbus facilities for resource and
> > registration. In particular, "serial-mm: use sysbus facilities" will
> > move internal serial realization to serial_mm_realize callback to
> > follow qdev best practices.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > @@ -1068,30 +1080,56 @@ static const MemoryRegionOps serial_mm_ops[3] =
=3D {
> >      },
> >  };
> >
> > -SerialState *serial_mm_init(MemoryRegion *address_space,
> > +SerialMM *serial_mm_init(MemoryRegion *address_space,
> >                              hwaddr base, int it_shift,
> >                              qemu_irq irq, int baudbase,
> >                              Chardev *chr, enum device_endian end)
> >  {
>
> You might want to fix the indent on the other lines of
> arguments here, but either way
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

done, thanks!


