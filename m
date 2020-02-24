Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F9C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF48020732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSMV8lL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF48020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Cai-0006jY-2f
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6CZw-0006I9-Qj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6CZv-0006Mp-6r
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:11:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6CZv-0006Lz-37
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582546274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=329CeTZCgaxLzjpvQ6A8kamQFW5xR58awFEKJ3DIcos=;
 b=LSMV8lL/zWWvyUW5OC0tXBrpmLM2OxGMZ1ipyP88XL67E5xPDqT0NNRfmjRxbdmh4vPbfG
 lnJY4af13nPZMoAnoadQvqJoqjm7Maxd6drImEa731L+T1YEKuxV93HFlgjX96G2vPJSzZ
 KYRqoat8VZycb77hAwKASfyIF4qp/qs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-gLmPvOspP52B9lhMKwAkLw-1; Mon, 24 Feb 2020 07:11:12 -0500
X-MC-Unique: gLmPvOspP52B9lhMKwAkLw-1
Received: by mail-wm1-f71.google.com with SMTP id p2so2303596wma.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=329CeTZCgaxLzjpvQ6A8kamQFW5xR58awFEKJ3DIcos=;
 b=IQgPGQJ5JS6GcVZAJJ9lUyUDOlgfTySfaUfopLsJITzWXjxka+uzLTsVyb3nv0hitw
 NaSyalOzp6i1zjONMXb1okD0D0b2rmH0xsYw8sCKCop3ocoWH6d9e2tckFb/ENWoBj0Z
 CcLHDWGegqBe6OFRVGQ9g58TOHKFFTjPnTrJUxK2xw/JUM2VlL5kOakV9WlVH5yDayd4
 lX+VqzH5SqGR/Om/Q+Ybvga+HP1UfLXSeOq0iZxyiOf4oBuLYTL4PriU/aEsri7nVqDC
 8ubaYw39RABwSzAoKmP+RHNqZb1xyzGNOOjbEoHHlRQbFnPoiwi4c4pkZOodB9PsZgHD
 iOeg==
X-Gm-Message-State: APjAAAVALIBlw7SAm7wvGOsxN/9A3L4csAWYPP8jtz/1zwHiOCLMbbnU
 SdNLxtTkLjEgdTezsHgsVIpN19jMlG9u8QmbZnzcvIkIBZI8A4Zy09qdpV/v/i26Hze5hzhbu/6
 /MHgQzVcpb+sRSaoPT7bRq4tnywehQo4=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr7827412wrv.19.1582546271725; 
 Mon, 24 Feb 2020 04:11:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVh8wqekokWRjNy1lBPKARYSNS2go4o9PsfhrbW57r9zLnYjVFOGScuXhN09OXcoMMoHsNkvQPsM0dqNNgyY8=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr7827379wrv.19.1582546271481; 
 Mon, 24 Feb 2020 04:11:11 -0800 (PST)
MIME-Version: 1.0
References: <1582545058-31609-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582545058-31609-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <e4c57474-090c-6409-a087-b8b0e21a32b0@de.ibm.com>
 <a82ac9bf-2be3-a753-a79b-bfe1894a3f4e@redhat.com>
In-Reply-To: <a82ac9bf-2be3-a753-a79b-bfe1894a3f4e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 24 Feb 2020 13:11:00 +0100
Message-ID: <CAP+75-UByGQ88k9eTJsB0SM9i-CxTeP33=xWvC11E=AGRV3TDw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Reactivate MIPS KVM CPUs
To: Christian Borntraeger <borntraeger@de.ibm.com>, 
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: James Hogan <jhogan@kernel.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 1:09 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 2/24/20 12:55 PM, Christian Borntraeger wrote:
> > On 24.02.20 12:50, Aleksandar Markovic wrote:
> >> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >>
> >> Reactivate MIPS KVM maintainership with a modest goal of keeping
> >> the support alive, checking common KVM code changes against MIPS
> >> functionality, etc. (hence the status "Odd Fixes"), with hope that
> >> this component will be fully maintained at some further, but not
> >> distant point in future.
>
> My only worry here is, do you have hardware to run tests?
>
> >>
> >> CC: James Hogan <jhogan@kernel.org>
> >> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> >> CC: Paolo Bonzini <pbonzini@redhat.com>
> >> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >
> > I talked with Aleksandar several times about maintainership and I
> > think he is the right person for the job stepping up as maintainer.
>
> Agreed.
>
> FWIW:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.co>
> >
> >> ---
> >>   MAINTAINERS | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index b0728c8..9cc55d5 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -365,8 +365,8 @@ S: Maintained
> >>   F: target/arm/kvm.c
> >>
> >>   MIPS KVM CPUs
> >> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>

BTW are you sure you want to remove Aleksandar Rikalo as reviewer?
(There is no description about this change.)

> >> -S: Orphan
> >> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >> +S: Odd Fixes
> >>   F: target/mips/kvm.c
> >>
> >>   PPC KVM CPUs
> >>
> >
> >


