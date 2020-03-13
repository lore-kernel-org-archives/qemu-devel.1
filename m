Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223D3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEE32074A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyT4JeQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEE32074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmUL-0006Yy-3v
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCmTL-0005ur-C1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCmTK-0002q2-AA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:43:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCmTK-0002nZ-62
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584114217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b27gzChm3WtiTwj+RznBX7lSGyxzdJJmnJONIdFps3I=;
 b=WyT4JeQLpCnh+oUhCXNEX8Hmh0/Qe6G3Nld9X7ct9ZGqn6C7IYJpjx9JKV9vJyK/1ewncJ
 2Bg40wkIGvt2cUA5Z6uzV+3tXGibhchE35/lbRobQwXqwYiO0B7pRCv8JvQPJUdjSqCW5c
 e6VukD/uIZ6X/ENBQW4SQZjvIbnt4Dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-UR8-iqSyOriSbGCXlc-VsQ-1; Fri, 13 Mar 2020 11:43:34 -0400
X-MC-Unique: UR8-iqSyOriSbGCXlc-VsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2DEB100726B;
 Fri, 13 Mar 2020 15:43:33 +0000 (UTC)
Received: from work-vm (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D97292D50;
 Fri, 13 Mar 2020 15:43:32 +0000 (UTC)
Date: Fri, 13 Mar 2020 15:43:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
Message-ID: <20200313154330.GF3581@work-vm>
References: <20200313123014.206828-1-dgilbert@redhat.com>
 <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
 <CAFEAcA9pBMC0W9cHKmq5nttPcA9qpYofSvkZEnmkGuS2g_vPTA@mail.gmail.com>
 <20200313133451.GD3581@work-vm>
 <CAFEAcA-E-pu_SBbZAWE5Sg1qRVm7jT-idbd4CCdk3h=yYNNOQg@mail.gmail.com>
 <20200313135732.GE3581@work-vm>
 <CAFEAcA_FBNB6o-mXMB_GzXtisCrPtYS8YLCLta53swpUA8cshQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FBNB6o-mXMB_GzXtisCrPtYS8YLCLta53swpUA8cshQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, catherine.hecx@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 13 Mar 2020 at 13:57, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > Ah yes, I think you're right, so something like:
> >
> >   if (runstate_check(RUN_STATE_INMIGRATE) && rom->data && rom->isrom) {
>=20
> I think you would see the difference here for images
> loaded into RAM, rather than ROM -- they need to be
> reinstated on reset, because the guest can scribble
> on them. So we retain the data and don't free it.

Hmm, that's true; so I'm failing to skip a copy in the !isrom
case, whch the original patch needed.

So what I think we'll need is:

   if (runstate_check(RUN_STATE_INMIGRATE))
   {
       if (rom->data && rom->isrom) {
           rom_free_data(rom);
       }
       continue;
   }

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


