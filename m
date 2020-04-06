Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0936CC2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC702206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 08:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e92iy9cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC702206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLNBu-0008WO-Uw
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 04:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLNAi-0007GJ-BR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLNAh-0004uD-46
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:31:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLNAg-0004tn-WE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 04:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586161914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJqhg3/iBZ+0IYmzowYbvYsPB8T8/ZlVQv0apa2GJOI=;
 b=e92iy9cnECnBClTjWfrxetRvOez0Cq3CGXi9iKZbWRn6qVILDnTdmgvAOBx1DXaXMFIh0q
 m05rgQVcSFfEujxpLOPBSD3gdSwLdSJFzyRyWcxBAMuvdo0tGXDIeG07y3Dwny+LzarcF9
 RDeUnf7O84aYtyhLQ0TrlZCGjBSQ/XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-jKcij4WpN56oxXo6hJKSGg-1; Mon, 06 Apr 2020 04:31:50 -0400
X-MC-Unique: jKcij4WpN56oxXo6hJKSGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E287107ACC4;
 Mon,  6 Apr 2020 08:31:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-74.ams2.redhat.com [10.36.113.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD324100164D;
 Mon,  6 Apr 2020 08:31:45 +0000 (UTC)
Date: Mon, 6 Apr 2020 10:31:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200406083143.GA6263@linux.fritz.box>
References: <20200401184431.GD27663@linux.fritz.box>
 <903538836.29.1585818619688@webmail.proxmox.com>
 <20200402121403.GB4006@linux.fritz.box>
 <20200402142524.GD4006@linux.fritz.box>
 <1043934808.59.1585842050330@webmail.proxmox.com>
 <20200402164744.GE4006@linux.fritz.box>
 <20200402171007.GF4006@linux.fritz.box>
 <2091214547.43.1585902379938@webmail.proxmox.com>
 <20200403084729.GB5336@linux.fritz.box>
 <1466731307.175.1585931495885@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1466731307.175.1585931495885@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.04.2020 um 18:31 hat Dietmar Maurer geschrieben:
>=20
> > On April 3, 2020 10:47 AM Kevin Wolf <kwolf@redhat.com> wrote:
> >=20
> > =20
> > Am 03.04.2020 um 10:26 hat Dietmar Maurer geschrieben:
> > > > With the following patch, it seems to survive for now. I'll give it=
 some
> > > > more testing tomorrow (also qemu-iotests to check that I didn't
> > > > accidentally break something else.)
> > >=20
> > > Wow, that was fast! Seems your patch fixes the bug!
> > >=20
> > > I wonder what commit introduced that problem, maybe:
> > >=20
> > > https://github.com/qemu/qemu/commit/cf3129323f900ef5ddbccbe86e4fa801e=
88c566e#diff-7cb66df56045598b75a219eebc27efb6
> > >=20
> > > If so, version 4.1.X in not affected by this bug, but 4.2.0 and later=
?
> >=20
> > Yes, I'm pretty sure that's the one.
>=20
> I also wonder if we can loose an aio_wait_kick() by directly accessing bl=
k->in_flight.
> I thought this should use atomic_mb_read()?
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 8b8f2a80a0..48f3721505 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2275,7 +2275,7 @@ static bool blk_root_drained_poll(BdrvChild *child)
>  {
>      BlockBackend *blk =3D child->opaque;
>      assert(blk->quiesce_counter);
> -    return !!blk->in_flight;
> +    return !!atomic_mb_read(&blk->in_flight);
>  }

I'm not sure if it actually makes a difference (and especially what the
barrier is supposed to achieve here), but it would be more consistent
with other users of the variable, so I think I agree.

Kevin


