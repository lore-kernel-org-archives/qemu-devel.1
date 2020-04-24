Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8931C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5E320728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVooOm2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5E320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvQd-0006Xt-LH
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1jRvPP-0005K9-8o
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1jRvPO-0002ui-8z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:18:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jRvPN-0002pR-Q3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587723488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rznJBOfrlrqpVcng19AgWctaUnc7W7FJkI/M3AA8RJY=;
 b=TVooOm2WJS+lPBp+gRX/VA4rHscMY7oKMwhQyb2rKBXNJnH1qLaFUb1VyTCia07esZSs2N
 aml0EHfXZ7q4yitxrASj6qefSzIdkObD1jxX8+chX0jljQxxtGMstUVh+Y1IhSbrpo1AsC
 lIpFchFq20Er1oWsIGDkhf0oOPePmOs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-YgEEaq4rPK-uM1P2P_H-XQ-1; Fri, 24 Apr 2020 06:18:06 -0400
X-MC-Unique: YgEEaq4rPK-uM1P2P_H-XQ-1
Received: by mail-io1-f72.google.com with SMTP id c26so9524074ioa.4
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 03:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rznJBOfrlrqpVcng19AgWctaUnc7W7FJkI/M3AA8RJY=;
 b=oh4P9gJ4ESs4QHkyuU0GddUOeNddwKdus4ZvCwdZ+2GrXO7c7mqYQJTMrDpEAlEGJ0
 AfhFOcIQ0ZvAnXEa4NWW+VgmnS5SzCCHIvlSltWCc+uNd6lmWi/GZ2RGAUZNJwpOEfTd
 X55B/8kJtT1Fv8jHxT2gAvhAJ3ne0gD5JJ2ijCfEonYv/7tdX/SR1+uwlgN16SQwuNo+
 qKlOYJ/6QSBKjaDEu8y0fCMZitqvtRLefEAhtjX+jAmFar1gbjzNXUYF3p0cwq+kpToM
 eZtXBE8ad0lP43FdOXjUhV7ag4nsv7odD2u2A8rU0TVNkN84H4gECWupfWPSjGKIZwvy
 T34A==
X-Gm-Message-State: AGi0PuYlDkAL3CGXcdVEkrb17SAKEO1KkPEfMO5gpUYOvrUN4CMDZ35v
 jxF2vbJQatkPtwSstnJ6AKfYLywQFEsK1DI5L1hCg6UA5E65pFqhYjdz0pQVaChWG7AghCtg5vk
 uI/iqLMdYZRUi8CcpQcsBaI9NskgYrhQ=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr7262565jam.36.1587723485451; 
 Fri, 24 Apr 2020 03:18:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGQp3PEQjewzurJ+JMYOVEkYZ0/+1SRFG59g+EJXstzKccgZVl8TcGj2b+pql+ytnjcOsEgDygV/mBl6HMyJY=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr7262546jam.36.1587723485149; 
 Fri, 24 Apr 2020 03:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <52a4ae2d18ee0d810355d84ab83623a2e9ffa405.1587667007.git.dimastep@yandex-team.ru>
 <20200422160206.GA30919@localhost.localdomain>
In-Reply-To: <20200422160206.GA30919@localhost.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 24 Apr 2020 12:17:54 +0200
Message-ID: <CAMxuvaxaOTO3gmCfNjFRDk-MXfcK20d2aaN+zUHUhtRFN=pPsw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] contrib/vhost-user-blk: add option to simulate
 disconnect on init
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:11:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Apr 24, 2020 at 4:32 AM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> I=E2=80=99m not opposed to adding this kind of debugging functionality to=
 the
> vhost-user-blk sample. It could be helpful to easily test these cases
> in the future.
>
> That said, I'm not sure how others will feel about adding these kind
> of debugging capabilities to libvhost-user. Marc-Andre, thoughts?

Maybe we should only enable this code if LIBVHOST_USER_DEBUG is set?

And to make logging silent by default, we shouldn't print them unless
VHOST_USER_DEBUG env is set?

>
> If we go this route I would prefer to add the debugging options to the
> vhost-user-blk sample in a separate patch.
>
> On Thu, Apr 23, 2020 at 09:39:32PM +0300, Dima Stepanov wrote:
> >
> > Add "--simulate-disconnect-stage" option for the testing purposes.
> > This option can be used to test the vhost-user reconnect functionality:
> >   ./vhost-user-blk ... --simulate-disconnect-stage=3D<CASENUM>
> > In this case the daemon will "crash" in the middle of the VHOST comands
> > communication. Case nums are as follows:
> >   1 - make assert in the handler of the SET_VRING_CALL command
> >   2 - make assert in the handler of the SET_VRING_NUM command
> > Main purpose is to test QEMU reconnect functionality. Such fail
> > injection should not lead to QEMU crash and should be handled
> > successfully.
> > Also update the "GOptionEntry entries" definition with the final NULL
> > item according to API.
> >
> > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > ---
> >  contrib/libvhost-user/libvhost-user.c   | 30 +++++++++++++++++++++++++=
+++++
> >  contrib/libvhost-user/libvhost-user.h   | 13 +++++++++++++
> >  contrib/vhost-user-blk/vhost-user-blk.c | 14 +++++++++++++-
> >  3 files changed, 56 insertions(+), 1 deletion(-)
>


