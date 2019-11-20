Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894802244A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 03:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/GRzHwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894802244A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXGoA-0004zA-LA
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 22:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iXGnD-0004Mp-J9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iXGnB-00052C-Iw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:36:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iXGnA-00050E-Rn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 22:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574220992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSKl4ZjlxedUP+FlAu7TIdnnUEwTf0V/UY+HsjFaX0Y=;
 b=J/GRzHwI0Fgh5t4H3XtX+CrrZzlABSyde2YZTZ72XSv97h66f9eyLM++rpBxzVdVGRpMfI
 ODg9vkql7hcfiSVzKhJGENAZYekUEZIYcPYS81lD8fV7U/ZrLO3dAG8kkg2Hf9B5fhnLCw
 OdW1C4x5qEwWKiVsaOih8AohJ6/e1MA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-XwLi3qtsNmWvZkkgNBlnOw-1; Tue, 19 Nov 2019 22:36:31 -0500
Received: by mail-ot1-f71.google.com with SMTP id w14so13243395otk.21
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 19:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wSKl4ZjlxedUP+FlAu7TIdnnUEwTf0V/UY+HsjFaX0Y=;
 b=sWMuwkGyNbYXecNiUqLUt0WPHVJJd8e9/KlLyrAq3dSKe+ltH4PL9VokvGxPnBp6pk
 7D7KAnmnZpdMKgsnWmWORbJ45per/vpQoO95EoVyqatcQi5JB68UOsHzGykhDJPGNSd2
 +TOU174e7F2kFxRC+Wy/r6czEtePvU6F46QkzbHOyqiFiDWvod9bAFjlrLi55TT6Y37U
 ZHnN/BNE1sT844tPXjw+9Z4Q1mgqxU+LrTynE0v4ZQiLBJ3HhwEI76z+7U8Ukx0GHJwM
 GFxlG8TnNzeGzF7sIbwUe6tbmCSNF/AejvWzcFH1L21p5DiDUqyodOWj03LziU0D4goK
 HWAw==
X-Gm-Message-State: APjAAAXigS88RpSJ9Z+zJVbAs/oZ04X5QjIl/Yhxr+S8wWW5/xRipTkk
 5v9ZUPlberJE5N0jy3+y5KnKu5WR93uN4rqamrSj92j0KeCX1NOTIqswsXRuKRanyyHbbrHvSpj
 peHWapXs23gn4+sWVGb1m4WoZ4SZF9vk=
X-Received: by 2002:a9d:5cc7:: with SMTP id r7mr242481oti.331.1574220990115;
 Tue, 19 Nov 2019 19:36:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqw82NQM/pmr2xgUxYC2sgYieQzIzLuS3ak0Mf9DL9kH75KKaKGHOUN34nR6V/4tQiQcOrRA1+o05VCt77a1pm4=
X-Received: by 2002:a9d:5cc7:: with SMTP id r7mr242448oti.331.1574220989481;
 Tue, 19 Nov 2019 19:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-2-marcandre.lureau@redhat.com>
 <CAFEAcA_k9TqzRJZ4=Q1jQP46SajiaMLEciSHZ83_CicMv__oiA@mail.gmail.com>
In-Reply-To: <CAFEAcA_k9TqzRJZ4=Q1jQP46SajiaMLEciSHZ83_CicMv__oiA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Nov 2019 07:36:18 +0400
Message-ID: <CAMxuvawFVf=6-GLO59T=v+W0vrhYVYuj0w30Oi6c7Zsen7Ri4g@mail.gmail.com>
Subject: Re: [PATCH v3 01/33] qdev: remove unused qdev_prop_int64
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: XwLi3qtsNmWvZkkgNBlnOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 18, 2019 at 6:01 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 23 Oct 2019 at 18:32, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties.c    | 32 --------------------------------
> >  include/hw/qdev-properties.h |  3 ---
> >  2 files changed, 35 deletions(-)
>
> I think I'd rather keep this. It's weird to not have a symmetric
> set of properties for the common integer types, and annoying
> for whoever next runs into a need for an int64 property to
> have to reinstate the deleted code. (Yes, I know we don't
> currently have int8 or int16.)
>

I don't think we should aim at being complete. Whenever we identify
dead code, unused for a long while, we should clean it up.

In this case, it is even worse, this has never been used since its
introduction in commit 07d1d063d3235c02f60dc92ec174d419e6f8a750, in
2017.


