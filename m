Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595AFC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2255420692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHfMpFK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2255420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCPi-0003Ii-R0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ipCNb-000188-U3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ipCNa-00063e-Bu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:32:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ipCNa-00063V-92
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578493933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cRUsUVf/jLm9/Px/HSPyHWXSzAEFUErRxsJJGpixac=;
 b=MHfMpFK2eOYMrG0Gy1xukXRRHWU++iZ12hIg0X90DjUP/PYXPms+UO5QFVfPFPE0AMlAeu
 2X49UsB0XMI+MIn3NIuGEQtHt0a0Qf38lvwEnIWmvBKsSeqjT0cRQjOJ8J2VUDjuT6QUYE
 EyyuV0SSoOSyfQCQfTvi2QSPHHVZv5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-s5qUdgiQO4CaU-CJ1n_ERA-1; Wed, 08 Jan 2020 09:32:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B953C1800D4E;
 Wed,  8 Jan 2020 14:31:57 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD0756FF0F;
 Wed,  8 Jan 2020 14:31:55 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 5/8] block/backup-top: Don't acquire context while dropping
 top
Date: Wed,  8 Jan 2020 15:31:35 +0100
Message-Id: <20200108143138.129909-6-slp@redhat.com>
In-Reply-To: <20200108143138.129909-1-slp@redhat.com>
References: <20200108143138.129909-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: s5qUdgiQO4CaU-CJ1n_ERA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All paths that lead to bdrv_backup_top_drop(), except for the call
from backup_clean(), imply that the BDS AioContext has already been
acquired, so doing it there too can potentially lead to QEMU hanging
on AIO_WAIT_WHILE().

An easy way to trigger this situation is by issuing a two actions
transaction, with a proper and a bogus blockdev-backup, so the second
one will trigger a rollback. This will trigger a hang with an stack
trace like this one:

 #0  0x00007fb680c75016 in __GI_ppoll (fds=3D0x55e74580f7c0, nfds=3D1, time=
out=3D<optimized out>,
     timeout@entry=3D0x0, sigmask=3Dsigmask@entry=3D0x0) at ../sysdeps/unix=
/sysv/linux/ppoll.c:39
 #1  0x000055e743386e09 in ppoll (__ss=3D0x0, __timeout=3D0x0, __nfds=3D<op=
timized out>, __fds=3D<optimized out>)
     at /usr/include/bits/poll2.h:77
 #2  0x000055e743386e09 in qemu_poll_ns
     (fds=3D<optimized out>, nfds=3D<optimized out>, timeout=3D<optimized o=
ut>) at util/qemu-timer.c:336
 #3  0x000055e743388dc4 in aio_poll (ctx=3D0x55e7458925d0, blocking=3Dblock=
ing@entry=3Dtrue)
     at util/aio-posix.c:669
 #4  0x000055e743305dea in bdrv_flush (bs=3Dbs@entry=3D0x55e74593c0d0) at b=
lock/io.c:2878
 #5  0x000055e7432be58e in bdrv_close (bs=3D0x55e74593c0d0) at block.c:4017
 #6  0x000055e7432be58e in bdrv_delete (bs=3D<optimized out>) at block.c:42=
62
 #7  0x000055e7432be58e in bdrv_unref (bs=3Dbs@entry=3D0x55e74593c0d0) at b=
lock.c:5644
 #8  0x000055e743316b9b in bdrv_backup_top_drop (bs=3Dbs@entry=3D0x55e74593=
c0d0) at block/backup-top.c:273
 #9  0x000055e74331461f in backup_job_create
     (job_id=3D0x0, bs=3Dbs@entry=3D0x55e7458d5820, target=3Dtarget@entry=
=3D0x55e74589f640, speed=3D0, sync_mode=3DMIRROR_SYNC_MODE_FULL, sync_bitma=
p=3Dsync_bitmap@entry=3D0x0, bitmap_mode=3DBITMAP_SYNC_MODE_ON_SUCCESS, com=
press=3Dfalse, filter_node_name=3D0x0, on_source_error=3DBLOCKDEV_ON_ERROR_=
REPORT, on_target_error=3DBLOCKDEV_ON_ERROR_REPORT, creation_flags=3D0, cb=
=3D0x0, opaque=3D0x0, txn=3D0x0, errp=3D0x7ffddfd1efb0) at block/backup.c:4=
78
 #10 0x000055e74315bc52 in do_backup_common
     (backup=3Dbackup@entry=3D0x55e746c066d0, bs=3Dbs@entry=3D0x55e7458d582=
0, target_bs=3Dtarget_bs@entry=3D0x55e74589f640, aio_context=3Daio_context@=
entry=3D0x55e7458a91e0, txn=3Dtxn@entry=3D0x0, errp=3Derrp@entry=3D0x7ffddf=
d1efb0)
     at blockdev.c:3580
 #11 0x000055e74315c37c in do_blockdev_backup
     (backup=3Dbackup@entry=3D0x55e746c066d0, txn=3D0x0, errp=3Derrp@entry=
=3D0x7ffddfd1efb0)
     at /usr/src/debug/qemu-kvm-4.2.0-2.module+el8.2.0+5135+ed3b2489.x86_64=
/./qapi/qapi-types-block-core.h:1492
 #12 0x000055e74315c449 in blockdev_backup_prepare (common=3D0x55e746a8de90=
, errp=3D0x7ffddfd1f018)
     at blockdev.c:1885
 #13 0x000055e743160152 in qmp_transaction
     (dev_list=3D<optimized out>, has_props=3D<optimized out>, props=3D0x55=
e7467fe2c0, errp=3Derrp@entry=3D0x7ffddfd1f088) at blockdev.c:2340
 #14 0x000055e743287ff5 in qmp_marshal_transaction
     (args=3D<optimized out>, ret=3D<optimized out>, errp=3D0x7ffddfd1f0f8)
     at qapi/qapi-commands-transaction.c:44
 #15 0x000055e74333de6c in do_qmp_dispatch
     (errp=3D0x7ffddfd1f0f0, allow_oob=3D<optimized out>, request=3D<optimi=
zed out>, cmds=3D0x55e743c28d60 <qmp_commands>) at qapi/qmp-dispatch.c:132
 #16 0x000055e74333de6c in qmp_dispatch
     (cmds=3D0x55e743c28d60 <qmp_commands>, request=3D<optimized out>, allo=
w_oob=3D<optimized out>)
     at qapi/qmp-dispatch.c:175
 #17 0x000055e74325c061 in monitor_qmp_dispatch (mon=3D0x55e745908030, req=
=3D<optimized out>)
     at monitor/qmp.c:145
 #18 0x000055e74325c6fa in monitor_qmp_bh_dispatcher (data=3D<optimized out=
>) at monitor/qmp.c:234
 #19 0x000055e743385866 in aio_bh_call (bh=3D0x55e745807ae0) at util/async.=
c:117
 #20 0x000055e743385866 in aio_bh_poll (ctx=3Dctx@entry=3D0x55e7458067a0) a=
t util/async.c:117
 #21 0x000055e743388c54 in aio_dispatch (ctx=3D0x55e7458067a0) at util/aio-=
posix.c:459
 #22 0x000055e743385742 in aio_ctx_dispatch
     (source=3D<optimized out>, callback=3D<optimized out>, user_data=3D<op=
timized out>) at util/async.c:260
 #23 0x00007fb68543e67d in g_main_dispatch (context=3D0x55e745893a40) at gm=
ain.c:3176
 #24 0x00007fb68543e67d in g_main_context_dispatch (context=3Dcontext@entry=
=3D0x55e745893a40) at gmain.c:3829
 #25 0x000055e743387d08 in glib_pollfds_poll () at util/main-loop.c:219
 #26 0x000055e743387d08 in os_host_main_loop_wait (timeout=3D<optimized out=
>) at util/main-loop.c:242
 #27 0x000055e743387d08 in main_loop_wait (nonblocking=3D<optimized out>) a=
t util/main-loop.c:518
 #28 0x000055e74316a3c1 in main_loop () at vl.c:1828
 #29 0x000055e743016a72 in main (argc=3D<optimized out>, argv=3D<optimized =
out>, envp=3D<optimized out>)
     at vl.c:4504

Fix this by not acquiring the AioContext there, and ensuring all paths
leading to it have it already acquired (backup_clean()).

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1782111
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 block/backup-top.c | 5 -----
 block/backup.c     | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 818d3f26b4..b8d863ff08 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -255,9 +255,6 @@ append_failed:
 void bdrv_backup_top_drop(BlockDriverState *bs)
 {
     BDRVBackupTopState *s =3D bs->opaque;
-    AioContext *aio_context =3D bdrv_get_aio_context(bs);
-
-    aio_context_acquire(aio_context);
=20
     bdrv_drained_begin(bs);
=20
@@ -271,6 +268,4 @@ void bdrv_backup_top_drop(BlockDriverState *bs)
     bdrv_drained_end(bs);
=20
     bdrv_unref(bs);
-
-    aio_context_release(aio_context);
 }
diff --git a/block/backup.c b/block/backup.c
index cf62b1a38c..1383e219f5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -135,8 +135,11 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
+    AioContext *aio_context =3D bdrv_get_aio_context(s->backup_top);
=20
+    aio_context_acquire(aio_context);
     bdrv_backup_top_drop(s->backup_top);
+    aio_context_release(aio_context);
 }
=20
 void backup_do_checkpoint(BlockJob *job, Error **errp)
--=20
2.23.0


