Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45FEC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A803A208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd22tX/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A803A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47Nw-0007US-TB
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j47NC-00072V-Vg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j47NB-0003y0-VS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:13:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j47NA-0003v4-Rh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582049608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KpRWbNcSjJsHQ+gG/O63WZoHuP7pEag/tech2ayuVw=;
 b=fd22tX/uomLqRuRcshu02BsSFN3NJVsBMpC5YnQGxHmCAw+nZB6PQgUG3jsnCM9SoWFJcL
 NZeamsLcRmScg2Nf2J2cm+pu7PUVatTls4fEkNWMnc6Z7PM9/FUG7VTTNrdp34LTlIqD/j
 p+/snT5lYeJ96UE92sA44VouhPjVrJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-Ww0tvzgePVSB6th7v3AtNA-1; Tue, 18 Feb 2020 13:13:26 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so419780wmi.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+KpRWbNcSjJsHQ+gG/O63WZoHuP7pEag/tech2ayuVw=;
 b=huTzyfZ48leMB9fJGsABhZFbxRzO17mIp4ScVJC8aDSHsVRpZHNVFaAFB8isM3zaBh
 xr2WL2+Huv26AUWeTHUV+97FufV/Q6hh/rkkYFvJXrfziB/A5Q9kRBvCXMp85dFMkaSC
 P46kyYo9a9EIZRSChQXByTqntmL6bCWziUyCKmCLU98ZK39HuKhQp0a5wyTMn0p4/zpt
 jp+ZvB+d3/N1ctsLr5zgDlUR/Zrizh/e0m1PRdDa3xY0D4roJgDuPu8riSp/MKCzgc+Q
 eymkndpeSdMkTr0uZqH3hDym3P9dgO4SR3sMrqVYslm3CPp1u6Ltj7++WVvyV7pjdiXt
 KA1g==
X-Gm-Message-State: APjAAAWodvCWeQWQmsu763ov7TzNqgkBDSWS6cLJFQ6Its8BbigiE/iO
 cCsEhba/gGmPnTVL9vOfSnZvmil7cnInsTD/eU5fj17KiAfdWLuYmftinD50bAt2DtYHJEqCOYT
 PkcqimEljZ9tLyrvtqzDua+kYoB2flco=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr4702149wmb.137.1582049605325; 
 Tue, 18 Feb 2020 10:13:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7UNU7x6QZKyAdaoMwxwEJaiZzjnldKkbWzDhA7+BBrbcanJCw4Sp6UuGtCDt76Uz1938/Qi8gyjAcqv89CYo=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr4702139wmb.137.1582049605155; 
 Tue, 18 Feb 2020 10:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20200218132023.22936-1-philmd@redhat.com>
 <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
In-Reply-To: <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Feb 2020 19:13:14 +0100
Message-ID: <CAP+75-W5kdPAz0HZqz+XxRg3RfkosFG4ptcu3o_jYBE26ZhkQw@mail.gmail.com>
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: Stefan Weil <sw@weilnetz.de>
X-MC-Unique: Ww0tvzgePVSB6th7v3AtNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 6:57 PM Stefan Weil <sw@weilnetz.de> wrote:
> Am 18.02.20 um 14:20 schrieb Philippe Mathieu-Daud=C3=A9:
>
> > This commit was produced with the included Coccinelle script
> > scripts/coccinelle/as-rw-const.patch.
> >
> > Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > Based-on: <20200218112457.22712-1-peter.maydell@linaro.org>
> [...]
> > diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> > index a8b6e5aeb8..f5971ccc74 100644
> > --- a/target/i386/hax-all.c
> > +++ b/target/i386/hax-all.c
> > @@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, s=
truct hax_fastmmio *hft)
> >           *  hft->direction =3D=3D 2: gpa =3D=3D> gpa2
> >           */
> >          uint64_t value;
> > -        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size=
, 0);
> > -        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->siz=
e, 1);
> > +        cpu_physical_memory_read(hft->gpa, (uint8_t *)&value, hft->siz=
e);
> > +        cpu_physical_memory_write(hft->gpa2, (uint8_t *)&value, hft->s=
ize);
>
>
> Maybe those type casts could be removed, too. They are no longer needed
> after your modification.

Good catch, thanks Stefan!

>
> Stefan
>
>


