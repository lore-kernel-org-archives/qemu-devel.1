Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4F122527
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjA3MVfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4F122527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9jd-0007Tl-Ox
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iw9hi-00057g-St
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iw9hh-0005BP-FN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iw9hh-0005AU-BJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580151943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfTzcISrNDdX5cIydEAVjOdIJyuiwzC+hcLSAe7MKX8=;
 b=fjA3MVfLRu2pY+Zynj1VpWojo7c1fR3HQTHo/AlhgkeiMAoL2Xv4pzq2j/3+Hg/OSsurz6
 ZnBV7KT0KCa+R4epkS8MOCgCeqRHFGSaM0K9jqJOnB6YQqjrjHio13k7KOTGBPVkw7YoaE
 E8vYmMsN3Txz9xvi6yBYpXE4/BSG22g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-mcVNQFUfO6u9OLlbYvgFTg-1; Mon, 27 Jan 2020 14:05:39 -0500
Received: by mail-wr1-f71.google.com with SMTP id h30so6625007wrh.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yfacjJxgA7QIZz4P2l8Zonwpd6rqGISwKsUj7YHGxtI=;
 b=gmzqmERbJdIkR4MLvV+PfEvX0Z1hnGwD3IeT6XXR3Z/FD737boRCFYeytDjiVZxjQF
 pBPlj/xppSj8UOLUS41r1mFFVe9vCtgSgFq9Z6pFOATgK8DpaRbRQz5btm6Kz0WxKGN3
 UpyEUbWLcmSJPl8ACGom8LkTyEtSP3qa6bMpiwUrrPfWs4FojocI719OVHwh4rGpoyp9
 I5IL/T3TTGrH8hcl+In1fhJDUq0URLDOEyBypIs21WC83geyluG3VYPQJdVoNx62j1uh
 nX5NldQwmrPqF5ewex+rWasoQAvBBUF64bjVeaAM7BG1dhAvPYZwk3Ntfr62ZWa+QZU9
 MiOw==
X-Gm-Message-State: APjAAAXgdzo1bVWJJ+AqdYii0mHK2BWrYxZKHTMOBD9K9fc5AI/2qFES
 91XJT6ZE3PM6xeUQxD7LJe9VpdB6gkGVLcKaHxiR9nbJP+uEV5fhLSlNJC2GuYzVbIYRVujkgve
 TpOxnhuuZODoMSHs=
X-Received: by 2002:adf:e78a:: with SMTP id n10mr23111464wrm.62.1580151938003; 
 Mon, 27 Jan 2020 11:05:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxixwB5i6jtlB6tsJudTF3/PPFO/XbzTf3FBP/NmMP6wc6YzKVJK9GYUZiuVUNn7eD69nlJxA==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr23111432wrm.62.1580151937713; 
 Mon, 27 Jan 2020 11:05:37 -0800 (PST)
Received: from [10.200.153.205] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id b67sm20388348wmc.38.2020.01.27.11.05.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:05:36 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Integrating QOM into QAPI
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <CAFEAcA9xtwNzZQS7biDy=LtZEiLDis3iQztOcP2+2NnCj80c0Q@mail.gmail.com>
Date: Mon, 27 Jan 2020 20:05:36 +0100
Message-Id: <B442E0A6-E0C5-426A-8234-EE6491AE4BB0@redhat.com>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
 <CAFEAcA9xtwNzZQS7biDy=LtZEiLDis3iQztOcP2+2NnCj80c0Q@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: mcVNQFUfO6u9OLlbYvgFTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 26 Jan 2020, at 16:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> On Sun, 26 Jan 2020 at 08:10, Christophe de Dinechin
> <dinechin@redhat.com> wrote:
>> I=E2=80=99m still puzzled as to why anybody would switch to something li=
ke
>> GObject when there is C++.
>=20
> I'm fairly strongly against using C++.

Just to be clear, so am I ;-)

> C++'s language design
> is an "everything including the kitchen sink, lots of "this
> is here for back compat but it's a bear trap", lots of new
> stuff arriving all the time.

Actually, the new stuff is not that bad, overall.

I do agree C++ is an overly complicated language, and that in
practice, there is zero chance of qemu moving to it. But that does
not invalidate my point that creating a class in C++ is easier
than creating a class in any C-based macro-heavy reinvention
of basic OO concepts.

(I write this after having read Paolo=E2=80=99s response, which points
out IMO better reasons for GObject, which I will discuss there).

> It's just too big to keep in
> your head all at once. C has its faults, absolutely, but at
> least it tries to be a reasonably sized vaguely coherent
> language.
>=20
> You'd have more luck persuading me we should move to Rust:
> at least then we'd get some clear benefits (no more buffer
> overrun security bugs) for the upheaval :-)

This is largely a myth as soon as you need to do =E2=80=9Cyour own stuff=E2=
=80=9D.
Example: CVE-2019-18960, https://seclists.org/oss-sec/2019/q4/141.

>=20
> thanks
> -- PMM
>=20


