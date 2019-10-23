Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0DCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0662084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eL16tyHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0662084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJPD-0006M5-W1
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNJ5S-0003n0-JJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNJ5Q-0007CV-2I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:02:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31274
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNJ5P-00079p-PQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 12:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571846529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wK78qb2x79P8ZRLTgOtErOzRwqRnYT4XtGQB+NRNk4A=;
 b=eL16tyHfb9+n64rlBtvfhrg1UxYBDqwcxfxLLTlKaNUo3Wc1/LrGomGtY3/lGQDcMrGknK
 D2xA54kcrKOF146K/N95PkMt9Md5cNFUv1eQNxQ65DquJwHWHjPaf/KnwQ1JiDGE+Encfm
 an5HWqcgmJY/KIHun84q14d4b6rsbdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Hsoqp1IIPXae17WwIzfdDg-1; Wed, 23 Oct 2019 12:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5367A801E72;
 Wed, 23 Oct 2019 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-192.ams2.redhat.com
 [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96EC35D6D0;
 Wed, 23 Oct 2019 16:02:01 +0000 (UTC)
Date: Wed, 23 Oct 2019 18:02:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] blockdev: modify blockdev-change-medium to change
 non-removable device
Message-ID: <20191023160200.GC6177@localhost.localdomain>
References: <20191018120950.26849-1-dplotnikov@virtuozzo.com>
 <2b6cc2fe-5269-71ab-9f0b-1ab36d4dc050@redhat.com>
 <f5d689f6-4b23-8314-f92a-294ffcb6721b@virtuozzo.com>
 <bd5e9f28-d11b-982d-d2be-53b16186eeaa@redhat.com>
 <f29c8653-1824-eab2-558a-2f00a29924d9@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <f29c8653-1824-eab2-558a-2f00a29924d9@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Hsoqp1IIPXae17WwIzfdDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.10.2019 um 15:56 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 22.10.2019 14:05, Max Reitz wrote:
> > On 21.10.19 08:50, Denis Plotnikov wrote:
> >>
> >> On 18.10.2019 18:02, Max Reitz wrote:
> >>> On 18.10.19 14:09, Denis Plotnikov wrote:
> >>>> The modification is useful to workaround exclusive file access restr=
ictions,
> >>>> e.g. to implement VM migration with shared disk stored on a storage =
with
> >>>> the exclusive file opening model: a destination VM is started waitin=
g for
> >>>> incomming migration with a fake image drive, and later, on the last =
migration
> >>>> phase, the fake image file is replaced with the real one.
> >>>>
> >>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >>> Isn=E2=80=99t this what we would want to use reopen for?
> >>>
> >>> Max
> >>
> >> Could you please explain what is "use reopen"?
> >=20
> > I was thinking of using (x-)blockdev-reopen to change the file that is
> > used by the format node (e.g. from a null-co node to a real file); or t=
o
> > change the filename of the protocol node.
> >=20
> > Kevin has pointed out (on IRC) that this will not allow you to change
> > the node that is directly attached to the device.  While I don=E2=80=99=
t know
> > whether that=E2=80=99s really necessary in this case, if it were indeed
> > necessary, I=E2=80=99d prefer a method to change a guest device=E2=80=
=99s @drive option
> > because that seems more natural to me.
> >=20
> > In contrast, the approach taken in this patch seems not quite right to
> > me, because it overloads the whole blockdev-change-medium command with =
a
> > completely new and different implementation based on whether there=E2=
=80=99s a
> > removable medium or not.  If the implementation is so different (and th=
e
> > interface is, too, because in one path you must give @medium whereas th=
e
> > other doesn=E2=80=99t evaluate it at all), it should be a new command.
> >=20
> > I don=E2=80=99t know whether we need a new command at all, though.  On =
the node
> > level, we have (x-)blockdev-reopen.  So assuming we need something to
> > change the link between the guest device and the block layer, I wonder
> > whether there isn=E2=80=99t something similar; specifically, I=E2=80=99=
d prefer
> > something to simply change the device=E2=80=99s @drive option.
>=20
> Ok, assume we can set @drive option with help of improved qom-set.
> But how to create this new blk? blockdev-add don't have 'id' parameter an=
ymore
> and don't create blk...

We don't need to create a new BlockBackend. You would set the drive qdev
property to a new node name and that would just internally call
blk_remove_bs() and blk_insert_bs() for the existing BlockBackend that
is owned by the device.

Kevin


