Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51C7C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D10720679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1Y+8KzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D10720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrRB-000062-1H
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jDopa-0005w5-IZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jDopW-00089l-W3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:26:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jDopW-00082Z-QI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584361610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00/FzbXRzM8EaNVB0xDrOpxIDmqJp0r3Ane5foPtI1Y=;
 b=Q1Y+8KzOPTlqThYNuPCd7NeHtWQNMnDoYNLSd3qTmNh2j+cbpCUWOz2rJRA270kIqlXqC2
 ti3IKXV4/kd/wOHN8lTnM8UiylHgn4vYrEJ6ZeQI4nSqaFfjTxKVWNwCdQxDy5Agd0nWKL
 8YPez/58VhwbhAETM2E6x/dtNQFV6Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-N7qnVuyIO8ST7ZjEn_Ed9Q-1; Mon, 16 Mar 2020 08:26:48 -0400
X-MC-Unique: N7qnVuyIO8ST7ZjEn_Ed9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4EEF1137859;
 Mon, 16 Mar 2020 12:26:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A8E69128E;
 Mon, 16 Mar 2020 12:26:47 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4814618089C8;
 Mon, 16 Mar 2020 12:26:47 +0000 (UTC)
Date: Mon, 16 Mar 2020 08:26:46 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
MIME-Version: 1.0
X-Originating-IP: [10.10.127.103, 10.4.195.17]
Thread-Topic: QEMU Gating CI
Thread-Index: I30Y2ItVG2dbtw/y/ob42UizpWRYmg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Cleber Rosa" <crosa@redhat.com>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>, "QEMU Developers" <qemu-=
devel@nongnu.org>, "Fam Zheng" <fam@euphon.net>,
> "Eduardo Habkost" <ehabkost@redhat.com>, "Beraldo Leal" <bleal@redhat.com=
>, "Philippe Mathieu-Daud=C3=A9"
> <philmd@redhat.com>, "Thomas Huth" <thuth@redhat.com>, "Wainer dos Santos=
 Moschetta" <wainersm@redhat.com>, "Erik
> Skultety" <eskultet@redhat.com>, "Willian Rampazzo" <wrampazz@redhat.com>=
, "Wainer Moschetta" <wmoschet@redhat.com>
> Sent: Monday, March 16, 2020 8:12:16 AM
> Subject: Re: [PATCH 0/5] QEMU Gating CI
>=20
> On Mon, 16 Mar 2020 at 12:04, Cleber Rosa <crosa@redhat.com> wrote:
> > A few possible reasons come to my mind:
> >
> > 1) It usually takes a few seconds after the push for the pipeline to
> >
> > 2) If you've pushed to a repo different than gitlab.com/qemu-project/qe=
mu,
> >    you'd have to tweak the project ID (-p|--project-id).
> >
> > 3) The local branch is not called "staging", so the script can not find=
 the
> >    commit ID, in that case you can use -c|--commit.
>=20
> Yes, the local branch is something else for the purposes of
> testing this series. But using --commit doesn't work either:
>=20
> $ ./contrib/ci/scripts/gitlab-pipeline-status --verbose --commit
> 81beaaab0851fe8c4db971 --wait
> ERROR: No pipeline found
> failure
>=20

This may be a bug in the script because I was not expecting two
pipelines for the same commit. Checking...

> On the web UI:
> https://gitlab.com/qemu-project/qemu/pipelines
> the pipelines are marked "stuck" (I don't know why there
> are two of them for the same commit); drilling down,
> the build part has completed but all the test parts are
> pending with "=EF=BB=BFThis job is stuck because you don't have
> any active runners online with any of these tags assigned
> to them" type messages.
> =EF=BB=BF=EF=BB=BF=EF=BB=BF

I had also not come across the duplicate pipelines, so I'm trying
to understand what's that about.

About the runners and the fact that the job is stuck without them,
the message seems straightforward enough, but I can't get to the
project configuration to look at the registered runners with my
current permissions (set as "developer").

> thanks
> -- PMM
>=20
>=20

Thanks,
- Cleber.


