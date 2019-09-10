Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA527C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56C52168B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEkeGmzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lUS-0008V5-Pt
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7lM8-0000IM-Cl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7lM6-0006MM-TV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:59:12 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7lM6-0006M4-MG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:59:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id y39so20050409ota.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=dHjd4R7/iGOg1mIXFltrPlXk9szHTttqLQ4yu4gKw0A=;
 b=OEkeGmzTl+VIQGLAmJO5jB/MmOuE2z/wGSrEuf94gcwsSD/N5iPtKSbpUy/3EcSm1d
 uVzG3rUSbDi/YCrmAzT4dQwsbJul3uOu0QsIYMgSwFTFkzsg/d5l2TlhePk7bPqdfa8v
 spyF0iSIpxh3EjrX+AwLLOza6ivSZBNqCcQrnjmYeSLtQnpG9ESPeXkGKVMLpQcEiY87
 BBARce4Yroi8o7PnUmXmRYFJKGz/S5s1dARBljip2BJSgutpygQT6Hsu8M0gMr1lo0fn
 aIHzMg2Rn2TTQn6tP6GaBn9a8db/SV+OG7cB/PnxPpYYHyUI5Bq5ulTFe7oq0HIKYzr/
 E8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=dHjd4R7/iGOg1mIXFltrPlXk9szHTttqLQ4yu4gKw0A=;
 b=bghPcSXVvkXfUj8V/+PgwuI8ifYCwRYG8nUooO/qfCa4Oko/qqodxiXgcnbaUn25q3
 aCShEsSS3LGdDCBZ7jKd6g7Irq1HPrk6FgnQYUHnBAiDhFxztGW30JTfKB16pSkgYR0N
 xvQdjbeKLpF7q0woVPgBtyGO2DYx/9jexJEAhfLZKODnQyEnRmvkK1B+D8dw/rAcV+8K
 rj21aGALPhn2qfTBaZliYge5qizRhEqsOqO1yPcfwVb+F8OkwZDeRk6EC+ZvqVG0aPoA
 P4/MBDSABIfu7qAYPSPqhgiCZ/DC0c/WbIoil41u/3hWBkV6COh9SnyHoodiXm2V4bwn
 0T7A==
X-Gm-Message-State: APjAAAWpzr3TOJQvyoMk7VrMKCVeRA2IP8NvoBDmcfT0QLxYLbmCwRkC
 qu7ufiZIhIgrsV/Svt+3kP/zfBJOU5TkrYPP6fc=
X-Google-Smtp-Source: APXvYqzb5icIWTFE6dMQIRfVeXk5gXFzBPMisQUXwbjpCxkUJo/ChqKdUUfvLxylmipRSZFFGBx0wdjwlyjzuPxQJ88=
X-Received: by 2002:a9d:5f09:: with SMTP id f9mr1547685oti.341.1568141949856; 
 Tue, 10 Sep 2019 11:59:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 11:59:09
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 11:59:09
 -0700 (PDT)
In-Reply-To: <2d5e7f28-7fa4-7637-c512-b443848eb61b@vivier.eu>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <2d5e7f28-7fa4-7637-c512-b443848eb61b@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Sep 2019 20:59:09 +0200
Message-ID: <CAL1e-=id9tL4-6eLgkd2SQ2W-5yU6Zp7WgVj0YFJ83wdG1qG6w@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 8/8] linux-user: Add support for
 FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.09.2019. 12.47, "Laurent Vivier" <laurent@vivier.eu> =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Le 04/09/2019 =C3=A0 14:59, Aleksandar Markovic a =C3=A9crit :
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
> > for controlling error reporting of a floppy drive.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  linux-user/ioctls.h        |  2 ++
> >  linux-user/syscall_defs.h  | 19 +++++++++++++++++++
> >  linux-user/syscall_types.h |  7 +++++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > index 622874b..0c75d03 100644
> > --- a/linux-user/ioctls.h
> > +++ b/linux-user/ioctls.h
> > @@ -118,6 +118,8 @@
> >       IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
> >       IOCTL(FDFMTEND, 0, TYPE_NULL)
> >       IOCTL(FDFLUSH, 0, TYPE_NULL)
> > +     IOCTL(FDSETMAXERRS, IOC_W,
MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
> > +     IOCTL(FDGETMAXERRS, IOC_R,
MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>
> where is FDSETEMSGTRESH?
>
> >       IOCTL(FDRESET, 0, TYPE_NULL)
> >       IOCTL(FDRAWCMD, 0, TYPE_NULL)
> >       IOCTL(FDTWADDLE, 0, TYPE_NULL)
> > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> > index 834a085..7c5b614 100644
> > --- a/linux-user/syscall_defs.h
> > +++ b/linux-user/syscall_defs.h
> > @@ -890,12 +890,31 @@ struct target_pollfd {
> >
> >  /* From <linux/fd.h> */
> >
> > +struct target_floppy_max_errors {
> > +    abi_uint        abort;
> > +    abi_uint        read_track;
> > +    abi_uint        reset;
> > +    abi_uint        recal;
> > +    abi_uint        reporting;
> > +};
>
> You don't need this, you can use floppy_max_errors from <linux/fd.h>.
>
> But you can define it if you want because it is used to know the size of
> the target structure (and if alignment or data types differ it can
> mismatch. With "int" it's not the case).
>

Laurent, thanks for the review, I'll correct this in the next version.

Just a follow-up question:

If the structure of related to a (not-yet-supported in QEMU) ioctl was:

struct hd_geometry {
      unsigned char heads;
      unsigned char sectors;
      unsigned short cylinders;
      unsigned long start;
};

... would "target_hd_geometry" be needed, or not?

Regards,

Aleksandar

> > +struct target_format_descr {
> > +    abi_uint        device;
> > +    abi_uint        head;
> > +    abi_uint        track;
> > +};
> > +
>
> This one is for the previous patch. Same comment as above.
>
> Thanks,
> Laurent
>
