Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E57EC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C64214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is0YlXKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C64214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlGl-0003iv-VG
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irkS6-0002zX-BN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irkS4-0003zp-SQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:19:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irkS4-0003y7-OU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8M3x154gZS4h9ERmUGr0bT0MkWCU8d0g3BjJP8cMpM=;
 b=is0YlXKJuaN/EcuhunY2qvoPjAt1qOyiYKilEmO9MHugUu5BIzrSLr8d9WoTz9fg0qoodh
 uL9KZu6ZmUH2pDREJ1JF7UD5XV5lvVwC8hcRraNXmg2F73IaonIRP+OigDNyYdJVGRO8yl
 JHmLwUtI3RsiENMKqjVTVb/+EBExRt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-d09gOn4qO22zMvydk1AgmQ-1; Wed, 15 Jan 2020 10:19:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00952193902D;
 Wed, 15 Jan 2020 15:19:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CABA1CB;
 Wed, 15 Jan 2020 15:19:13 +0000 (UTC)
Date: Wed, 15 Jan 2020 16:19:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v6 6/8] blockdev: Acquire AioContext on dirty bitmap
 functions
Message-ID: <20200115151912.GD5505@linux.fritz.box>
References: <20200108143138.129909-1-slp@redhat.com>
 <20200108143138.129909-7-slp@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200108143138.129909-7-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: d09gOn4qO22zMvydk1AgmQ-1
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.01.2020 um 15:31 hat Sergio Lopez geschrieben:
> Dirty map addition and removal functions are not acquiring to BDS
> AioContext, while they may call to code that expects it to be
> acquired.
>=20
> This may trigger a crash with a stack trace like this one:
>=20
>  #0  0x00007f0ef146370f in __GI_raise (sig=3Dsig@entry=3D6)
>      at ../sysdeps/unix/sysv/linux/raise.c:50
>  #1  0x00007f0ef144db25 in __GI_abort () at abort.c:79
>  #2  0x0000565022294dce in error_exit
>      (err=3D<optimized out>, msg=3Dmsg@entry=3D0x56502243a730 <__func__.1=
6350> "qemu_mutex_unlock_impl") at util/qemu-thread-posix.c:36
>  #3  0x00005650222950ba in qemu_mutex_unlock_impl
>      (mutex=3Dmutex@entry=3D0x5650244b0240, file=3Dfile@entry=3D0x5650224=
39adf "util/async.c", line=3Dline@entry=3D526) at util/qemu-thread-posix.c:=
108
>  #4  0x0000565022290029 in aio_context_release
>      (ctx=3Dctx@entry=3D0x5650244b01e0) at util/async.c:526
>  #5  0x000056502221cd08 in bdrv_can_store_new_dirty_bitmap
>      (bs=3Dbs@entry=3D0x5650244dc820, name=3Dname@entry=3D0x56502481d360 =
"bitmap1", granularity=3Dgranularity@entry=3D65536, errp=3Derrp@entry=3D0x7=
fff22831718)
>      at block/dirty-bitmap.c:542
>  #6  0x000056502206ae53 in qmp_block_dirty_bitmap_add
>      (errp=3D0x7fff22831718, disabled=3Dfalse, has_disabled=3D<optimized =
out>, persistent=3D<optimized out>, has_persistent=3Dtrue, granularity=3D65=
536, has_granularity=3D<optimized out>, name=3D0x56502481d360 "bitmap1", no=
de=3D<optimized out>) at blockdev.c:2894
>  #7  0x000056502206ae53 in qmp_block_dirty_bitmap_add
>      (node=3D<optimized out>, name=3D0x56502481d360 "bitmap1", has_granul=
arity=3D<optimized out>, granularity=3D<optimized out>, has_persistent=3Dtr=
ue, persistent=3D<optimized out>, has_disabled=3Dfalse, disabled=3Dfalse, e=
rrp=3D0x7fff22831718) at blockdev.c:2856
>  #8  0x00005650221847a3 in qmp_marshal_block_dirty_bitmap_add
>      (args=3D<optimized out>, ret=3D<optimized out>, errp=3D0x7fff2283179=
8)
>      at qapi/qapi-commands-block-core.c:651
>  #9  0x0000565022247e6c in do_qmp_dispatch
>      (errp=3D0x7fff22831790, allow_oob=3D<optimized out>, request=3D<opti=
mized out>, cmds=3D0x565022b32d60 <qmp_commands>) at qapi/qmp-dispatch.c:13=
2
>  #10 0x0000565022247e6c in qmp_dispatch
>      (cmds=3D0x565022b32d60 <qmp_commands>, request=3D<optimized out>, al=
low_oob=3D<optimized out>) at qapi/qmp-dispatch.c:175
>  #11 0x0000565022166061 in monitor_qmp_dispatch
>      (mon=3D0x56502450faa0, req=3D<optimized out>) at monitor/qmp.c:145
>  #12 0x00005650221666fa in monitor_qmp_bh_dispatcher
>      (data=3D<optimized out>) at monitor/qmp.c:234
>  #13 0x000056502228f866 in aio_bh_call (bh=3D0x56502440eae0)
>      at util/async.c:117
>  #14 0x000056502228f866 in aio_bh_poll (ctx=3Dctx@entry=3D0x56502440d7a0)
>      at util/async.c:117
>  #15 0x0000565022292c54 in aio_dispatch (ctx=3D0x56502440d7a0)
>      at util/aio-posix.c:459
>  #16 0x000056502228f742 in aio_ctx_dispatch
>      (source=3D<optimized out>, callback=3D<optimized out>, user_data=3D<=
optimized out>) at util/async.c:260
>  #17 0x00007f0ef5ce667d in g_main_dispatch (context=3D0x56502449aa40)
>      at gmain.c:3176
>  #18 0x00007f0ef5ce667d in g_main_context_dispatch
>      (context=3Dcontext@entry=3D0x56502449aa40) at gmain.c:3829
>  #19 0x0000565022291d08 in glib_pollfds_poll () at util/main-loop.c:219
>  #20 0x0000565022291d08 in os_host_main_loop_wait
>      (timeout=3D<optimized out>) at util/main-loop.c:242
>  #21 0x0000565022291d08 in main_loop_wait (nonblocking=3D<optimized out>)
>      at util/main-loop.c:518
>  #22 0x00005650220743c1 in main_loop () at vl.c:1828
>  #23 0x0000565021f20a72 in main
>      (argc=3D<optimized out>, argv=3D<optimized out>, envp=3D<optimized o=
ut>)
>      at vl.c:4504
>=20
> Fix this by acquiring the AioContext at qmp_block_dirty_bitmap_add()
> and qmp_block_dirty_bitmap_add().
>=20
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1782175
> Signed-off-by: Sergio Lopez <slp@redhat.com>

> @@ -3038,20 +3045,26 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_rem=
ove(
>  {
>      BlockDriverState *bs;
>      BdrvDirtyBitmap *bitmap;
> +    AioContext *aio_context;
> =20
>      bitmap =3D block_dirty_bitmap_lookup(node, name, &bs, errp);
>      if (!bitmap || !bs) {
>          return NULL;
>      }
> =20
> +    aio_context =3D bdrv_get_aio_context(bs);
> +    aio_context_acquire(aio_context);
> +
>      if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_BUSY | BDRV_BITMAP_R=
O,
>                                  errp)) {
> +        aio_context_release(aio_context);
>          return NULL;
>      }
> =20
>      if (bdrv_dirty_bitmap_get_persistence(bitmap) &&
>          bdrv_remove_persistent_dirty_bitmap(bs, name, errp) < 0)
>      {
> +            aio_context_release(aio_context);
>              return NULL;
>      }

Indentation is off here. It was already off before this patch, but
rather than adding another incorrectly indented line, I think we should
just fix it. I can do that while applying.

Kevin


