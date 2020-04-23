Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B2C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4919D2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzUnXeBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4919D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfHz-0008UX-DN
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jRfGv-0007ni-2f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jRfGt-0003oK-HV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:04:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jRfGt-0003jF-0f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587661456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNfHwH1+Ntuses6bMhYLuFNVchgVKHdXMKnAo9rwcDk=;
 b=EzUnXeBg/RKkgSS+DyL/uvD9klFam3wmPa6IEVBEo+pGdUf4kLmh5P1r8XPxgwHDWMK9mT
 nrmIrZvgmBqQpXkeAykCamwIsdFdegG4mBmT1WqtxOnLNoa/KzIv1LZtIEWW8zz61idgkb
 AEenQ8Fu+vyrr3LAZnssty7BoqkXnL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-lWmj-__kOHOFEpmDk6xBgg-1; Thu, 23 Apr 2020 13:04:14 -0400
X-MC-Unique: lWmj-__kOHOFEpmDk6xBgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 969EE87308E;
 Thu, 23 Apr 2020 17:04:13 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A8BB5C1D2;
 Thu, 23 Apr 2020 17:04:13 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 513791809541;
 Thu, 23 Apr 2020 17:04:13 +0000 (UTC)
Date: Thu, 23 Apr 2020 13:04:13 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
MIME-Version: 1.0
X-Originating-IP: [10.10.112.178, 10.4.195.26]
Thread-Topic: QEMU Gating CI
Thread-Index: DgfSa9udgyRTKA+gpMmc7tBfgATwNw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Markus Armbruster" <armbru@redhat.com>
> Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Bera=
ldo Leal" <bleal@redhat.com>, "Erik
> Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro.o=
rg>, "Wainer Moschetta" <wmoschet@redhat.com>,
> "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Moschetta" =
<wainersm@redhat.com>, "Willian Rampazzo"
> <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Philippe Mathie=
u-Daud=C3=A9" <philmd@redhat.com>, "Eduardo
> Habkost" <ehabkost@redhat.com>
> Sent: Tuesday, April 21, 2020 8:53:49 AM
> Subject: Re: [PATCH 0/5] QEMU Gating CI
>=20
> On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com> wrote=
:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > I think we should start by getting the gitlab setup working
> > > for the basic "x86 configs" first. Then we can try adding
> > > a runner for s390 (that one's logistically easiest because
> > > it is a project machine, not one owned by me personally or
> > > by Linaro) once the basic framework is working, and expand
> > > from there.
> >
> > Makes sense to me.
> >
> > Next steps to get this off the ground:
> >
> > * Red Hat provides runner(s) for x86 stuff we care about.
> >
> > * If that doesn't cover 'basic "x86 configs" in your judgement, we
> >   fill the gaps as described below under "Expand from there".
> >
> > * Add an s390 runner using the project machine you mentioned.
> >
> > * Expand from there: identify the remaining gaps, map them to people /
> >   organizations interested in them, and solicit contributions from thes=
e
> >   guys.
> >
> > A note on contributions: we need both hardware and people.  By people I
> > mean maintainers for the infrastructure, the tools and all the runners.
> > Cleber & team are willing to serve for the infrastructure, the tools an=
d
> > the Red Hat runners.
>=20
> So, with 5.0 nearly out the door it seems like a good time to check
> in on this thread again to ask where we are progress-wise with this.
> My impression is that this patchset provides most of the scripting
> and config side of the first step, so what we need is for RH to provide
> an x86 runner machine and tell the gitlab CI it exists. I appreciate
> that the whole coronavirus and working-from-home situation will have
> upended everybody's plans, especially when actual hardware might
> be involved, but how's it going ?
>=20

Hi Peter,

You hit the nail in the head here.  We were affected indeed with our abilit=
y
to move some machines from one lab to another (across the country), but we'=
re
actively working on it.

From now on, I'll give you an update every time a significant event occurs =
on
our side.

> thanks
> -- PMM
>=20
>=20

Thanks for checking in!
- Cleber.


