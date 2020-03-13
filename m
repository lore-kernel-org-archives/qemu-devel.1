Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAF5206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1NisOOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAF5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkps-0001Hu-U7
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jCkop-0004kU-JM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jCkon-0004nJ-KN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:57:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jCkon-0004lW-Fv
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584107861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAlmTJ7tPRbz8s4X0m3WQos73YY1d7yUlWG86efoHIs=;
 b=T1NisOOs6So1jRb8kWanyD5a0izUDxffG/0YxmDHfNPgeiogwuhTaYgpLgsImA6ZNCQbQf
 DKMUfPheO4qeL4EJtZK9nDrfuSbWOLz5SeWonxciyS2RioBLZSRlqZ+DeHFQRtUFmENlYX
 Bk6/DrU+cDS6e444Ygg1RVLxcciuuPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-s8cucU7OMGC8Odv7-lNR2A-1; Fri, 13 Mar 2020 09:57:37 -0400
X-MC-Unique: s8cucU7OMGC8Odv7-lNR2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6E5F18C8C01;
 Fri, 13 Mar 2020 13:57:36 +0000 (UTC)
Received: from work-vm (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B7F8FBED;
 Fri, 13 Mar 2020 13:57:34 +0000 (UTC)
Date: Fri, 13 Mar 2020 13:57:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
Message-ID: <20200313135732.GE3581@work-vm>
References: <20200313123014.206828-1-dgilbert@redhat.com>
 <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
 <CAFEAcA9pBMC0W9cHKmq5nttPcA9qpYofSvkZEnmkGuS2g_vPTA@mail.gmail.com>
 <20200313133451.GD3581@work-vm>
 <CAFEAcA-E-pu_SBbZAWE5Sg1qRVm7jT-idbd4CCdk3h=yYNNOQg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-E-pu_SBbZAWE5Sg1qRVm7jT-idbd4CCdk3h=yYNNOQg@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 13 Mar 2020 at 13:34, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > On Fri, 13 Mar 2020 at 13:21, Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > >
> > > > On Fri, 13 Mar 2020 at 12:31, Dr. David Alan Gilbert (git)
> > > > <dgilbert@redhat.com> wrote:
> > > > >
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > >
> > > > > Commit 355477f8c73e9 skips rom reset when we're an incoming migra=
tion
> > > > > so as not to overwrite shared ram in the ignore-shared migration
> > > > > optimisation.
> > > > > However, it's got an unexpected side effect that because it skips
> > > > > freeing the ROM data, when rom_reset gets called later on, after
> > > > > migration (e.g. during a reboot), the ROM does get reset to the o=
riginal
> > > > > file contents.  Because of seabios/x86's weird reboot process
> > > > > this confuses a reboot into hanging after a migration.
> > > > >
> > > > > Fixes: 355477f8c73e9 ("migration: do not rom_reset() during incom=
ing migration")
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1809380
> > > > >
> > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > ---
> > > > >  hw/core/loader.c | 23 ++++++++++++++---------
> > > > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > > >
> > > >
> > > > >      QTAILQ_FOREACH(rom, &roms, next) {
> > > > >          if (rom->fw_file) {
> > > > >              continue;
> > > > >          }
> > > > > +        /*
> > > > > +         * We don't need to fill in the RAM with ROM data becaus=
e we'll fill
> > > > > +         * the data in during the next incoming migration in all=
 cases.  Note
> > > > > +         * that some of those RAMs can actually be modified by t=
he guest on ARM
> > > > > +         * so this is probably the only right thing to do here.
> > > > > +         */
> > > > > +        if (runstate_check(RUN_STATE_INMIGRATE) && rom->data) {
> > > > > +            /*
> > > > > +             * Free it so that a rom_reset after migration doesn=
't overwrite a
> > > > > +             * potentially modified 'rom'.
> > > > > +             */
> > > > > +            rom_free_data(rom);
> > > >
> > > > Shouldn't this condition match the condition in rom_reset()
> > > > for when we call rom_free_data()? You want the behaviour
> > > > on a subsequent reset to match the behaviour you'd get
> > > > if you did a reset on the source end without the migration.
> > >
> > > Wait, this *is* rom_reset(). Now I'm really confused.
> >
> > The exsiting rom_reset gets called multiple times:
> >   a) During init
> >       This actually copies the ROMs and then calls rom_free_data
> >
> >   b) During a subsequent reboot
> >       This is mostly skipped because rom->data is now free because
> >       of the prior call to rom_free_data during (a)
> >
> > During an inbound migrate, (a) happens before the migration, and
> > (b) happens during a reboot after the migration.
> >
> > The problem is that 355477f8c73e9 caused (a) to be skipped
> > then when (b) happens it actually overwrites the ROM because
> > the rom_free_data had been skipped.  What I'm doing here is
> > doing the rom_free_data(..) which causes it to then skip this
> > iteration during (a) AND causes it to skip it during (b).
>=20
> OK, but why is your condition for when to call rom_free_data()
> in this special case not the same as the condition that we
> use in the normal no-migration-involved case? I would expect
> those to match up.

Ah yes, I think you're right, so something like:

  if (runstate_check(RUN_STATE_INMIGRATE) && rom->data && rom->isrom) {

I'll try that after lunch.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


