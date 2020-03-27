Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED9C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285C42082D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPY6d8PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285C42082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHonu-0001Pg-AJ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 09:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHonH-0000wS-10
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHonF-0008Jz-65
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:13:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHonE-0008AE-Mq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585314779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hju6u1lM4o9eBzEJhVYtFqejAbdbhbln9vDlnLFg23k=;
 b=VPY6d8PDELi0GsDEbHGfVwk3L69KbdEbZwLV58iTnO26NjVHw9OuxkP2maWZL1rXTGSwSz
 JoniHQSekb0U4m8pzLCvEo4VBYxfJhbLkPtIyz/aECANOdMbr0jLqN6WD+4bHZKusRv2eJ
 dkHEqBmmGIwD66SAEnwevRJV47Uj5Js=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ZhkE8jj3NlmX2LVj2fnxPg-1; Fri, 27 Mar 2020 09:12:58 -0400
X-MC-Unique: ZhkE8jj3NlmX2LVj2fnxPg-1
Received: by mail-wm1-f71.google.com with SMTP id z123so1035685wme.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 06:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WjDd1wZ8yp59fbmpwTyglh/JFIsLryCdLeDRGUbkpo4=;
 b=grwNJ85LNkRygSwVqqvcoPigRTs6PdFiEc3vXzuhL7i19NYLxAxfHZO/Xys+1BqDCg
 cPvdhjX239EFs0C154JHzYR6XOSCFuKdUprKru5UE9LOCHgMDO+gY08N5myMg/FARLVx
 vR3YLdB9urayMCr2L4wPQkAJ/S2odZZB84u8Xw0R9Owyaq3bFh3JrZV6/iSuU5ZdUXFD
 4XIWGMh+Uqj3cODShsuq9r0n4F5vBkynKVMeFR92Pa3lHUrZ6Pg1xqz3BvFKoy5lDTqk
 ybng/iiTuJBvhZG9qnhc5Y5I0JzLy+TWgtoO1Al7rqIwvV+78jGnIzDsMtyHRQHIqYUV
 encg==
X-Gm-Message-State: ANhLgQ2eyvq0wYls3xir65Txbz9axby2VMBX0Z6xgKDIWkEWotSFqbtB
 tfXeBMrzJ0WXu+QrC8LoTzszbAVgScS3Wi/SWz17iSqep549H7onoXlzbm93pZZ8pffVm/sdyKk
 /rIuh/dvILS2sJrk=
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr15133707wro.68.1585314776637; 
 Fri, 27 Mar 2020 06:12:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vto1Sdda+sVQaxqbGdTsmc5Ifw6ZYRYvwv7C6ezaksdE67sySXhk9lRvTrUdptNz38f4QhRcQ==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr15133677wro.68.1585314776312; 
 Fri, 27 Mar 2020 06:12:56 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id v186sm1672910wme.24.2020.03.27.06.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 06:12:55 -0700 (PDT)
Date: Fri, 27 Mar 2020 14:12:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] monitor/hmp-cmds: add units for mirate_parameters.
Message-ID: <20200327131253.3axcri54an4pmuzf@steredhat>
References: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
 <20200327092951.bu4ju7rh53ig5t3l@steredhat>
 <20200327112814.GD2786@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200327112814.GD2786@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 11:28:14AM +0000, Dr. David Alan Gilbert wrote:
> * Stefano Garzarella (sgarzare@redhat.com) wrote:
> > Hi Mao,
> >=20
> > On Fri, Mar 27, 2020 at 03:32:10PM +0800, Mao Zhongyi wrote:
> > > When running:
> > > (qemu) info migrate_parameters
> > > announce-initial: 50 ms
> > > announce-max: 550 ms
> > > announce-step: 100 ms
> > > compress-wait-thread: on
> > > ...
> > > max-bandwidth: 33554432 bytes/second
> > > downtime-limit: 300 milliseconds
> > > x-checkpoint-delay: 20000
> > > ...
> > > xbzrle-cache-size: 67108864
> > >=20
> > > add units for the parameters 'x-checkpoint-delay' and
> > > 'xbzrle-cache-size', it's easier to read.
> > >=20
> > > Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> > > ---
> > >  monitor/hmp-cmds.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > > index 2a900a528a..8d22f96e57 100644
> > > --- a/monitor/hmp-cmds.c
> > > +++ b/monitor/hmp-cmds.c
> > > @@ -440,7 +440,7 @@ void hmp_info_migrate_parameters(Monitor *mon, co=
nst QDict *qdict)
> > >              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMI=
T),
> > >              params->downtime_limit);
> > >          assert(params->has_x_checkpoint_delay);
> > > -        monitor_printf(mon, "%s: %u\n",
> > > +        monitor_printf(mon, "%s: %u" " milliseconds\n",
> >                                        ^
> > here we can remove the space and use a single string "%s: %u millisecon=
ds\n"
>=20
> Yes.
>=20
> > I've noticed that we use both ms or milliseconds, if you want to clean =
up in a
> > separate patch, maybe we could use one of these everywhere. (I vote for=
 'ms')
>=20
> I do prefer 'ms', however we do seem to just use milliseconds in
> info migrate

IIUC, currently with 'info migrate_parameters' we have:
- announce-initial, announce-max, and announce-step with 'ms'
- downtime-limit with 'milliseconds'

Stefano


