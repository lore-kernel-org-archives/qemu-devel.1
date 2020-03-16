Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F68C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C902051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW7bgQZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C902051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpZO-0004Zl-Vb
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jDoTq-0005iq-BQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jDoTl-0008HF-11
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:04:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jDoTk-00081t-Kd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZsEF+klwgXwx/JnMbgBQY4xCOiD9ofkvp8O8cuiWk4=;
 b=iW7bgQZljV1JRt4Gdl2gdAE78ef4IxjXT8QDnGhSm5IaRntwa5KLoFS4to7Y7KTMDu6WyT
 436P9PPIDhRQ7FIHgmh6kK5ikW0Ic44AO3pB5rO4u6S/GvbE09bIo1gNPMcTRgYK2M5Pl/
 CW4Hr9wf5Y5ij5r7s8Iap/EO26ZnNtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-srJwxdbEPry1RUlYcHWeaw-1; Mon, 16 Mar 2020 08:04:16 -0400
X-MC-Unique: srJwxdbEPry1RUlYcHWeaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C1E100DFC0;
 Mon, 16 Mar 2020 12:04:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B91290809;
 Mon, 16 Mar 2020 12:04:15 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id CCDA686FE7;
 Mon, 16 Mar 2020 12:04:13 +0000 (UTC)
Date: Mon, 16 Mar 2020 08:04:13 -0400 (EDT)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
MIME-Version: 1.0
X-Originating-IP: [10.10.127.103, 10.4.195.10]
Thread-Topic: QEMU Gating CI
Thread-Index: 4/QZ168YbudYJLlSNuzV+JP+oNS+Mw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
> Sent: Monday, March 16, 2020 7:57:33 AM
> Subject: Re: [PATCH 0/5] QEMU Gating CI
>=20
> On Thu, 12 Mar 2020 at 22:16, Cleber Rosa <crosa@redhat.com> wrote:
> > The quick answer is:
> >
> >  $ git push git@gitlab.com:qemu-project/qemu.git my-branch:staging
>=20
> So I did this bit...
>=20
> > Once that push happens, you could use:
> >
> >  $ contrib/ci/scripts/gitlab-pipeline-status --verbose --wait
>=20
> ...but this script just says:
>=20
> $ ./contrib/ci/scripts/gitlab-pipeline-status --verbose --wait
> ERROR: No pipeline found
> failure
>=20

Hi Peter,

A few possible reasons come to my mind:

1) It usually takes a few seconds after the push for the pipeline to

2) If you've pushed to a repo different than gitlab.com/qemu-project/qemu,
   you'd have to tweak the project ID (-p|--project-id).

3) The local branch is not called "staging", so the script can not find the
   commit ID, in that case you can use -c|--commit.

> thanks
> -- PMM
>=20
>=20

Please let me know if any of these points helps.

Cheers,
- Cleber.


