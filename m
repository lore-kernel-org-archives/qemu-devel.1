Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28075C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C0E20857
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+/hCGWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C0E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0nT-0002Ks-3U
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jK0mk-0001pj-PU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jK0mj-0002NN-IW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:25:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jK0mj-0002Mu-Ec
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585837532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tlVD3Yfue3CBeVMEGuDmjDjwzfJJ9SxVsXr3l2ZbA7M=;
 b=R+/hCGWcn1OLw/unNo23YVatQw5LMrbiNPUSELK3Vo6X85COHsh3AYMMLGq72s7MRdnC5K
 SIRPyXftqaF/2zw9iRpzgRonnEZgqHePKUH0RTkLiP33J+OQ6s2enec9Q9v8DpnxgMON4Z
 4qjPfdLYBBy6zv0GcPcZrlHie43N6bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-UN6TstNvM4Kx4Y5C0UrCWw-1; Thu, 02 Apr 2020 10:25:31 -0400
X-MC-Unique: UN6TstNvM4Kx4Y5C0UrCWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BFAF192D787;
 Thu,  2 Apr 2020 14:25:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF6F5D9CD;
 Thu,  2 Apr 2020 14:25:25 +0000 (UTC)
Date: Thu, 2 Apr 2020 16:25:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: bdrv_drained_begin deadlock with io-threads
Message-ID: <20200402142524.GD4006@linux.fritz.box>
References: <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
 <1403939459.52.1585765681569@webmail.proxmox.com>
 <20200401184431.GD27663@linux.fritz.box>
 <903538836.29.1585818619688@webmail.proxmox.com>
 <20200402121403.GB4006@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200402121403.GB4006@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.04.2020 um 14:14 hat Kevin Wolf geschrieben:
> Am 02.04.2020 um 11:10 hat Dietmar Maurer geschrieben:
> > > It seems to fix it, yes. Now I don't get any hangs any more.=20
> >=20
> > I just tested using your configuration, and a recent centos8 image
> > running dd loop inside it:
> >=20
> > # while dd if=3D/dev/urandom of=3Dtestfile.raw bs=3D1M count=3D100; do =
sync; done
> >=20
> > With that, I am unable to trigger the bug.
> >=20
> > Would you mind running the test using a Debian Buster image running "st=
ress-ng -d 5" inside?
> > I (and to other people here) can trigger the bug quite reliable with th=
at.
> >=20
> > On Debian, you can easily install stress-ng using apt:
> >=20
> > # apt update
> > # apt install stress-ng
> >=20
> > Seems stress-ng uses a different write pattern which can trigger the bu=
g=20
> > more reliable.
>=20
> I was going to, just give me some time...

Can you reproduce the problem with my script, but pointing it to your
Debian image and running stress-ng instead of dd? If so, how long does
it take to reproduce for you?

I was just going to write that I can't reproduce in my first attempt
(which is still with the image on tmpfs as in my script, and therefore
without O_DIRECT or Linux AIO) when it finally did hang. However, this
is still while completing a job, not while starting it:

(gdb) bt
#0  0x00007f8b6b4e9526 in ppoll () at /lib64/libc.so.6
#1  0x00005619fc090919 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<opt=
imized out>, __fds=3D<optimized out>) at /usr/include/bits/poll2.h:77
#2  0x00005619fc090919 in qemu_poll_ns (fds=3D<optimized out>, nfds=3D<opti=
mized out>, timeout=3Dtimeout@entry=3D-1) at util/qemu-timer.c:335
#3  0x00005619fc0930f1 in fdmon_poll_wait (ctx=3D0x5619fe79ae00, ready_list=
=3D0x7fff4006cf58, timeout=3D-1) at util/fdmon-poll.c:79
#4  0x00005619fc0926d7 in aio_poll (ctx=3D0x5619fe79ae00, blocking=3Dblocki=
ng@entry=3Dtrue) at util/aio-posix.c:589
#5  0x00005619fbfefd83 in bdrv_do_drained_begin (poll=3D<optimized out>, ig=
nore_bds_parents=3Dfalse, parent=3D0x0, recursive=3Dfalse, bs=3D0x5619fe81e=
490) at block/io.c:429
#6  0x00005619fbfefd83 in bdrv_do_drained_begin (bs=3D0x5619fe81e490, recur=
sive=3D<optimized out>, parent=3D0x0, ignore_bds_parents=3D<optimized out>,=
 poll=3D<optimized out>) at block/io.c:395
#7  0x00005619fbfe0ce7 in blk_drain (blk=3D0x5619ffd35c00) at block/block-b=
ackend.c:1617
#8  0x00005619fbfe18cd in blk_unref (blk=3D0x5619ffd35c00) at block/block-b=
ackend.c:473
#9  0x00005619fbf9b185 in block_job_free (job=3D0x5619ffd0b800) at blockjob=
.c:89
#10 0x00005619fbf9c769 in job_unref (job=3D0x5619ffd0b800) at job.c:378
#11 0x00005619fbf9c769 in job_unref (job=3D0x5619ffd0b800) at job.c:370
#12 0x00005619fbf9d57d in job_exit (opaque=3D0x5619ffd0b800) at job.c:892
#13 0x00005619fc08eea5 in aio_bh_call (bh=3D0x7f8b5406f410) at util/async.c=
:164
#14 0x00005619fc08eea5 in aio_bh_poll (ctx=3Dctx@entry=3D0x5619fe79ae00) at=
 util/async.c:164
#15 0x00005619fc09252e in aio_dispatch (ctx=3D0x5619fe79ae00) at util/aio-p=
osix.c:380
#16 0x00005619fc08ed8e in aio_ctx_dispatch (source=3D<optimized out>, callb=
ack=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:298
#17 0x00007f8b6df5606d in g_main_context_dispatch () at /lib64/libglib-2.0.=
so.0
#18 0x00005619fc091798 in glib_pollfds_poll () at util/main-loop.c:219
#19 0x00005619fc091798 in os_host_main_loop_wait (timeout=3D<optimized out>=
) at util/main-loop.c:242
#20 0x00005619fc091798 in main_loop_wait (nonblocking=3Dnonblocking@entry=
=3D0) at util/main-loop.c:518
#21 0x00005619fbd07559 in qemu_main_loop () at /home/kwolf/source/qemu/soft=
mmu/vl.c:1664
#22 0x00005619fbbf093e in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at /home/kwolf/source/qemu/softmmu/main.c:49

It does looks more like your case because I now have bs.in_flight =3D=3D 0
and the BlockBackend of the scsi-hd device has in_flight =3D=3D 8. Of
course, this still doesn't answer why it happens, and I'm not sure if we
can tell without adding some debug code.

I'm testing on my current block branch with Stefan's fixes on top.

Kevin


