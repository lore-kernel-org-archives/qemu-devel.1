Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55632C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA0820870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1q1rIJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA0820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1Kw-0007qE-4u
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX1KL-0007N7-Tm
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:38:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX1KK-0006uK-A3
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588937878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86MJC+7FFIpAiM5vqBPgxOZCKdjA6pScZG0VyLoQ/fk=;
 b=P1q1rIJl7B12DOvMWGDsThL25LSoLcVo6eXMjGMH9YFExy6/0hnBL7TTaD7al+hphu+k1E
 9nNXRMNZUdJF7xo2WVG+ynAX/QiSLNW/IowNVXMta7qLsg35j3mjmZwNyb+vs2NKkppOzB
 CN9PJFCG2e3JwKCxPQrr8p/IuWUqfX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-mJpSD0AqMnO00o-djjP1iQ-1; Fri, 08 May 2020 07:37:57 -0400
X-MC-Unique: mJpSD0AqMnO00o-djjP1iQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 509991895A2A;
 Fri,  8 May 2020 11:37:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-190.ams2.redhat.com [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 124FC2E056;
 Fri,  8 May 2020 11:37:54 +0000 (UTC)
Date: Fri, 8 May 2020 13:37:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 2/6] blockdev: Split off basic bitmap operations for
 qemu-img
Message-ID: <20200508113753.GC4970@linux.fritz.box>
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-3-eblake@redhat.com>
 <6ce69bac-9bbc-05fd-e658-89a2ad63a322@redhat.com>
 <a16c3c4d-272b-6c5f-9d67-2a222c8f1f88@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a16c3c4d-272b-6c5f-9d67-2a222c8f1f88@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 16:50 hat Eric Blake geschrieben:
> On 4/30/20 8:59 AM, Max Reitz wrote:
> > On 21.04.20 23:20, Eric Blake wrote:
> > > Upcoming patches want to add some basic bitmap manipulation abilities
> > > to qemu-img.  But blockdev.o is too heavyweight to link into qemu-img
> > > (among other things, it would drag in block jobs and transaction
> > > support - qemu-img does offline manipulation, where atomicity is less
> > > important because there are no concurrent modifications to compete
> > > with), so it's time to split off the bare bones of what we will need
> > > into a new file blockbitmaps.o.
> > >=20
> > > In addition to exposing 6 QMP commands for use by qemu-img (add,
> > > remove, clear, enable, disable, merge), this also has to export three
> > > previously-static functions for use by blockdev.c transactions.
> > >=20
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >   Makefile.objs             |   2 +-
> > >   include/sysemu/blockdev.h |  14 ++
> > >   blockbitmaps.c            | 324 +++++++++++++++++++++++++++++++++++=
+++
> >=20
> > Hm.  Can we get a better name?  blockdev-bitmaps.c, for example?
>=20
> Sure, I'm open to bike-shed suggestions.  I'd also _really_ love to make =
the
> new file NOT live in the top-level, but that's a harder task that I'm not
> sure how to do (it's easy to tweak Makefile.objs for another file in the
> same directory, but harder to see through the magic to figure out how to
> relocate things).

Yes, please move it somewhere else. I'd suggest something like
block/monitor/bitmap-qmp-cmds.c for the QMP command handlers, and if
there are functions that are more generally useful, block/bitmaps.c.

Instead of modifying the top-level Makefile.objs, you would just edit
block/monitor/Makefile.objs instead and add the filename there. I don't
think you need to understand any magic apart from knowing that is exists
and does what you would expect.

Kevin


