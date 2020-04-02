Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803ACC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F38420737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6RE2yx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F38420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK322-0007Sf-Bc
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 12:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jK30X-0006Rj-BT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jK30W-0007Lw-7z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:47:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47132
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jK30W-0007Kf-3x
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585846074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzavvN38StXFpLYsuLqj1ni7xJGO4Fu6kYvwoNBCMTo=;
 b=c6RE2yx9FUG66MVmFm99azOucpJJbNTG00bKudhA5HmMXuT+wAcaI/jkmmhpEcl2dZQmuv
 kXm3Xy+bgg/hmi/bLKaNxuDKDAWj7m+LferlTeTZGSBhJkQiKOzjP89SHOZI2mbsXrTeb+
 2uzJ23ksf9ZZVB55QB8eaHSyjnv6EGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-5cKmGcxNPBWiPnwZDy3FHw-1; Thu, 02 Apr 2020 12:47:52 -0400
X-MC-Unique: 5cKmGcxNPBWiPnwZDy3FHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DF3800D5C;
 Thu,  2 Apr 2020 16:47:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71BC248;
 Thu,  2 Apr 2020 16:47:46 +0000 (UTC)
Date: Thu, 2 Apr 2020 18:47:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200402164744.GE4006@linux.fritz.box>
References: <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
 <1403939459.52.1585765681569@webmail.proxmox.com>
 <20200401184431.GD27663@linux.fritz.box>
 <903538836.29.1585818619688@webmail.proxmox.com>
 <20200402121403.GB4006@linux.fritz.box>
 <20200402142524.GD4006@linux.fritz.box>
 <1043934808.59.1585842050330@webmail.proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1043934808.59.1585842050330@webmail.proxmox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.04.2020 um 17:40 hat Dietmar Maurer geschrieben:
> > Can you reproduce the problem with my script, but pointing it to your
> > Debian image and running stress-ng instead of dd?=20
>=20
> yes
>=20
> > If so, how long does
> > it take to reproduce for you?
>=20
> I sometimes need up to 130 iterations ...
>=20
> Worse, I thought several times the bug is gone, but then it triggered aga=
in (sigh).
>=20
> But most times below 30 iteration (if you run "stress-ng -d 5").
>=20
> Also note that it can happen at different places, but always inside a dra=
ined section ...

I got a stracktrace of a hanging coroutine:

(gdb) qemu coroutine 0x7fd8c00132c0
#0  0x00005630e16e9840 in qemu_coroutine_switch (from_=3Dfrom_@entry=3D0x7f=
d8c00132c0, to_=3Dto_@entry=3D0x7fd8cda865b8, action=3Daction@entry=3DCOROU=
TINE_YIELD) at util/coroutine-ucontext.c:218
#1  0x00005630e16e8521 in qemu_coroutine_yield () at util/qemu-coroutine.c:=
193
#2  0x00005630e16e8ba5 in qemu_co_queue_wait_impl (queue=3Dqueue@entry=3D0x=
5630e48ab580, lock=3Dlock@entry=3D0x0) at util/qemu-coroutine-lock.c:56
#3  0x00005630e161f1ae in blk_wait_while_drained (blk=3Dblk@entry=3D0x5630e=
48ab260) at /home/kwolf/source/qemu/include/qemu/lockable.h:46
#4  0x00005630e1620600 in blk_wait_while_drained (blk=3D0x5630e48ab260) at =
block/block-backend.c:1189
#5  0x00005630e1620600 in blk_co_pwritev_part (blk=3D0x5630e48ab260, offset=
=3D2922381312, bytes=3D856064, qiov=3Dqiov@entry=3D0x7fd8c002cd70, qiov_off=
set=3Dqiov_offset@entry=3D0, flags=3D0)
    at block/block-backend.c:1189
#6  0x00005630e16207ce in blk_co_pwritev (flags=3D<optimized out>, qiov=3D0=
x7fd8c002cd70, bytes=3D<optimized out>, offset=3D<optimized out>, blk=3D<op=
timized out>) at block/block-backend.c:1429
#7  0x00005630e16207ce in blk_aio_write_entry (opaque=3D0x7fd8c002cdc0) at =
block/block-backend.c:1429
#8  0x00005630e16e98bb in coroutine_trampoline (i0=3D<optimized out>, i1=3D=
<optimized out>) at util/coroutine-ucontext.c:115

So I think this is the bug: Calling blk_wait_while_drained() from
anywhere between blk_inc_in_flight() and blk_dec_in_flight() is wrong
because it will deadlock the drain operation.

blk_aio_read/write_entry() take care of this and drop their reference
around blk_wait_while_drained(). But if we hit the race condition that
drain hasn't yet started there, but it has when we get to
blk_co_preadv() or blk_co_pwritev_part(), then we're in a buggy code
path.

Kevin


