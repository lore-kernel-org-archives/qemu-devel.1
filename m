Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B3C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733242087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sandia.gov header.i=@sandia.gov header.b="diwqPy8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733242087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6ph-0003lB-DT
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shanson@sandia.gov>) id 1iS6IS-0005uU-Ao
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shanson@sandia.gov>) id 1iS6IQ-0001Sv-Hn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:23:28 -0500
Received: from smtp01asnl.sandia.gov ([198.102.153.114]:45985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shanson@sandia.gov>) id 1iS6IQ-0001Sd-3J
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=sandia.gov; i=@sandia.gov; q=dns/txt; s=snl;
 t=1572989006; x=1604525006;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FdT8n+WkB7qcGwJmQ7+3JKchGv/V+2VRzsOCafTLfzM=;
 b=diwqPy8Gra3TG4g6nlVdTyJWPIakta37yEyecYShymVnkXYM/B6w/ff6
 qbF+V4BYVDRmSodryPtNSDT5Fbi0FOSYPGY5aXa/wVv/cUh06Qe8fQAiX
 dXCaSGJ3l2X63PGb/CuzWpX4TU62RTC+1NBMiwhNa1t3bwp4Pg8dri/GJ
 iEUb4WZUIILiN+/NgjJWO+t8QarjYTrXFBiz2nAfvntgwrCtj2EcoM9KH
 Zyk94yUHxAGPf05uyh1te/Ez/EqsMS/pTEM2EKch9dKl6GQeAw+s8plVh
 QmTTjA94r98uCMhLC9N4RliN123ZLMKqRVnF5c1x9TXCmH2cdTxgfkowF A==;
IronPort-SDR: yzAIs2rTJznKe1lB+shAFP0XxeMdVGREhVjvHs324xYxtOk9W4Sfoyd4/lP2SAREa/zCv2J/bb
 97T35iqLKcRw==
X-IronPort-MID: 203362341
X-IronPort-AV: E=McAfee;i="6000,8403,9432"; a="203362341"
X-IronPort-AV: E=Sophos;i="5.68,271,1569304800"; d="scan'208";a="203362341"
Received: from dp12snllx.sandia.gov (HELO Sandia_DLP) ([134.253.181.224])
 by smtp01asnl.sandia.gov with ESMTP; 05 Nov 2019 14:23:24 -0700
Received: from dp12snllx.sandia.gov (dp12snllx.sandia.gov [127.0.0.1])
 by dp12snllx.sandia.gov (Service) with ESMTP id 4DDAE20DFFC7;
 Tue,  5 Nov 2019 14:23:24 -0700 (MST)
Received: from mail.sandia.gov (unknown [134.253.103.168])
 by dp12snllx.sandia.gov (Service) with ESMTPS id 3AF1320DFFC5;
 Tue,  5 Nov 2019 14:23:24 -0700 (MST)
X-CrossPremisesHeadersFilteredBySendConnector: ES03AMSNLNT.srn.sandia.gov
Received: from ES05AMSNLNT.srn.sandia.gov (134.253.103.165) by
 ES03AMSNLNT.srn.sandia.gov (134.253.103.163) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Tue, 5 Nov 2019 14:23:23 -0700
Received: from ES05AMSNLNT.srn.sandia.gov ([134.253.103.181]) by
 ES05AMSNLNT.srn.sandia.gov ([134.253.103.181]) with mapi id 15.00.1473.003;
 Tue, 5 Nov 2019 14:23:23 -0700
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi
 <stefanha@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL] Re: Adding New, Unsupported ISA to Qemu
Thread-Topic: [EXTERNAL] Re: Adding New, Unsupported ISA to Qemu
Thread-Index: AQHVk2i3OPPbMPM+DECJVEyRS/Wa9qd9PqqAgABGiYD//42bsg==
Date: Tue, 5 Nov 2019 21:23:23 +0000
Message-ID: <1572988990478.74192@sandia.gov>
References: <1572911399018.17766@sandia.gov>
 <20191105164253.GJ166646@stefanha-x1.localdomain>,
 <CAFEAcA_5ZS=4gHW8yph_o7Z4XrO5r2YMbGTB0oNtQKriv-qS=A@mail.gmail.com>
In-Reply-To: <CAFEAcA_5ZS=4gHW8yph_o7Z4XrO5r2YMbGTB0oNtQKriv-qS=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.253.113.229]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OrganizationHeadersPreserved: ES03AMSNLNT.srn.sandia.gov
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 198.102.153.114
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: "Hanson, Seth" <shanson@sandia.gov>
From: "Hanson, Seth" via <qemu-devel@nongnu.org>

=0A=
=0A=
Gentlemen,=0A=
=0A=
Thank you for your input. =0A=
=0A=
=0A=
Peter,=0A=
=0A=
I completely understand your concern. Rest assured, this project is entirel=
y internal and requires no code contribution, unit testing, etc. from QEMU =
devs. We simply want to garner as much documentation as possible to ensure =
optimal conversion/compatibility. My team and I have already completed a ma=
jority of our instruction set mapping into TCG. Lately however, we've encou=
ntered issues with floating point operations. =0A=
=0A=
I noticed in the TCG Readme that floating point operations are no longer of=
ficially supported but were previously (per the last paragraph in 4.1).=0A=
=0A=
Can you please provide documentation for implementing the latter?=0A=
=0A=
=0A=
Regards,=0A=
Seth=0A=
=0A=
=0A=
________________________________________=0A=
From: Peter Maydell <peter.maydell@linaro.org>=0A=
Sent: Tuesday, November 5, 2019 1:55 PM=0A=
To: Stefan Hajnoczi=0A=
Cc: Hanson, Seth; qemu-devel@nongnu.org=0A=
Subject: [EXTERNAL] Re: Adding New, Unsupported ISA to Qemu=0A=
=0A=
On Tue, 5 Nov 2019 at 16:44, Stefan Hajnoczi <stefanha@gmail.com> wrote=0A=
> The general advice I've seen is:=0A=
>=0A=
> 1. Look at existing TCG targets to learn how to implement aspects of=0A=
>    your ISA.=0A=
=0A=
...and *don't* look at older/less maintained targets (including=0A=
x86), as they have a lot of bad habits you don't want to copy.=0A=
Using 'decodetree' is probably a good idea.=0A=
=0A=
> 2. If you are unfamiliar with emulation, CPU ISA, or just-in-time=0A=
>    compiler concepts, try to read up on them and then look back at the=0A=
>    QEMU code.  Things will be clearer.=0A=
=0A=
I would also add=0A=
3.  Don't expect getting this implemented and upstream to be easy.=0A=
=0A=
(Apologies if the following sounds pessimistic and off-putting;=0A=
but I would prefer people to have a clear understanding of=0A=
what they're getting into and not assume the chances of=0A=
success are higher than they might actually be.)=0A=
=0A=
"New TCG target" is an unlucky combination of:=0A=
 (1) it's quite a lot of work in pure amount-of-code terms=0A=
 (2) because it is a big feature it is not a good choice as a "first=0A=
   contribution to the project", but new targets often are proposed=0A=
   and written by people who don't have any previous history of=0A=
   writing QEMU code=0A=
 (3) we already have targets for the common CPU ISAs, so=0A=
   anything new is likely to be obscure and not have many people=0A=
   who care about it either in our userbase or in our dev community.=0A=
   (riscv is the obvious recent exception here, as it is clearly relevant=
=0A=
   as a new architecture and has attracted multiple people to work=0A=
   on it and contribute both code and reviews)=0A=
=0A=
1 and 2 mean that code review of a new TCG target is a lot=0A=
of work, and 3 means it's not clear how much return the project=0A=
gets for that investment :-(=0A=
=0A=
There is not a large community of upstream developers who are=0A=
interested in maintaining a lot of obscure guest architectures:=0A=
we essentially rely on the goodwill and not-entirely-work-time=0A=
of just a few people when it comes to reviewing new TCG targets.=0A=
That means that patchsets often hang around on list for a long=0A=
time without getting attention.=0A=
=0A=
Our past historical experience has often been that when people=0A=
contribute TCG targets, we do a lot of work on our end with=0A=
code review and helping to get the code into upstream QEMU, and=0A=
then these people more or less disappear, leaving us with the=0A=
burden of something we have to support and no help doing it.=0A=
If in general people submitting new TCG targets were all=0A=
*helping each other*, passing on what they learned to the=0A=
next person along, contributing code review, updating older=0A=
code as QEMU APIs improve/churn, etc, then I think I'd feel=0A=
differently about this. But to be honest mostly I find myself=0A=
thinking "oh dear, not another one".=0A=
=0A=
We already have two new TCG ports with patches on list=0A=
which are kind of stalled due to not having enough existing=0A=
upstream QEMU devs who can/will code review them (and=0A=
another which hasn't had patches posted but might do soon).=0A=
The odds for your new port having a happier future don't seem=0A=
too great to me :-(=0A=
=0A=
thanks=0A=
-- PMM=0A=

