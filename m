Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5137C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F9724651
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqJ+Eu1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F9724651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icsCH-0001Fh-9g
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ics9f-0007oP-9o
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ics9c-0007ON-1q
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:30:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ics9a-0007MK-4n
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575556247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJ/Nu7F6ll5lhUdUoqhO2c/XAkKqK1+YVnlCPMQkJH4=;
 b=dqJ+Eu1TKLMYuc7yV43dh0Q0+EEQCLcK4WWd1ISdD0TFMGBonwahCEoxEd9TPQghk63gce
 Z4HUDPgUMlwILE2i8xU1yplfkog1/Pp/LS3lye8l2+b1dAWzYkpjGsluW3VdI8eYuZ3QVs
 9J2ge+URXpfx6C14RiKUa/NOoFrek1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-WiqZCBqxPrKmN1Azv4XitQ-1; Thu, 05 Dec 2019 09:30:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01BF810509B4;
 Thu,  5 Dec 2019 14:30:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABEEC165DA;
 Thu,  5 Dec 2019 14:30:39 +0000 (UTC)
Date: Thu, 5 Dec 2019 14:30:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migration: Rate limit inside host pages
Message-ID: <20191205143037.GI2824@work-vm>
References: <20191205102918.63294-1-dgilbert@redhat.com>
 <87o8wmkhd4.fsf@trasno.org>
MIME-Version: 1.0
In-Reply-To: <87o8wmkhd4.fsf@trasno.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WiqZCBqxPrKmN1Azv4XitQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, LMa@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > When using hugepages, rate limiting is necessary within each huge
> > page, since a 1G huge page can take a significant time to send, so
> > you end up with bursty behaviour.
> >
> > Fixes: 4c011c37ecb3 ("postcopy: Send whole huge pages")
> > Reported-by: Lin Ma <LMa@suse.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
> I can agree that rate limit needs to be done for huge pages.
>=20
> > diff --git a/migration/ram.c b/migration/ram.c
> > index a4ae3b3120..a9177c6a24 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2616,6 +2616,8 @@ static int ram_save_host_page(RAMState *rs, PageS=
earchStatus *pss,
> > =20
> >          pages +=3D tmppages;
> >          pss->page++;
> > +        /* Allow rate limiting to happen in the middle of huge pages *=
/
> > +        migration_rate_limit();
> >      } while ((pss->page & (pagesize_bits - 1)) &&
> >               offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_B=
ITS));
> > =20
>=20
> But is doing the rate limit for each page, no?  Even when not using huge
> pages.

Right.

> Not that it should be a big issue (performance wise).
> Have you done any meassuremnet?

I've just given it a quick run; it still seems to be hitting ~9.5Gbps on
my 10Gbps interface; so it doesn't seem to be the limit on that.

Dave

>=20
>=20
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


