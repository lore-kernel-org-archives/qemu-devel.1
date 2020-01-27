Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BC4C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AD020CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COq0WTvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AD020CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw8gy-0000qH-2h
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iw8cb-0002LG-4V
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iw8cY-0002uQ-R3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iw8cY-0002rd-GI
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 12:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580147780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hBx84FkRgattWyuzqryLHMgYVI8/+4cZhdK/scUWLIw=;
 b=COq0WTvc4klFQ6d0359hAzysg4VHRFv0ZPDlW12PbzZLIhXDHValWuK29vclzzaAr+1JtX
 2NXi2mGD342AdfgtKvtHPpt5arIWkc9JMJHE+f7oC46kUTadFzIFOYN6l6w/phEyCi4rNU
 iKDSMdSqqIr2POHZZiBM6a2pLo2vhOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-A2dtTsbUN0uXyvK3y7d6sw-1; Mon, 27 Jan 2020 12:56:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BEA91007269;
 Mon, 27 Jan 2020 17:56:17 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 121D0811FA;
 Mon, 27 Jan 2020 17:56:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/13] blockdev: Return bs to the proper context on snapshot
 abort
Date: Mon, 27 Jan 2020 18:55:55 +0100
Message-Id: <20200127175559.18173-10-kwolf@redhat.com>
In-Reply-To: <20200127175559.18173-1-kwolf@redhat.com>
References: <20200127175559.18173-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: A2dtTsbUN0uXyvK3y7d6sw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

external_snapshot_abort() calls to bdrv_set_backing_hd(), which
returns state->old_bs to the main AioContext, as it's intended to be
used then the BDS is going to be released. As that's not the case when
aborting an external snapshot, return it to the AioContext it was
before the call.

This issue can be triggered by issuing a transaction with two actions,
a proper blockdev-snapshot-sync and a bogus one, so the second will
trigger a transaction abort. This results in a crash with an stack
trace like this one:

 #0  0x00007fa1048b28df in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/u=
nix/sysv/linux/raise.c:50
 #1  0x00007fa10489ccf5 in __GI_abort () at abort.c:79
 #2  0x00007fa10489cbc9 in __assert_fail_base
     (fmt=3D0x7fa104a03300 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", ass=
ertion=3D0x5572240b44d8 "bdrv_get_aio_context(old_bs) =3D=3D bdrv_get_aio_c=
ontext(new_bs)", file=3D0x557224014d30 "block.c", line=3D2240, function=3D<=
optimized out>) at assert.c:92
 #3  0x00007fa1048aae96 in __GI___assert_fail
     (assertion=3Dassertion@entry=3D0x5572240b44d8 "bdrv_get_aio_context(ol=
d_bs) =3D=3D bdrv_get_aio_context(new_bs)", file=3Dfile@entry=3D0x557224014=
d30 "block.c", line=3Dline@entry=3D2240, function=3Dfunction@entry=3D0x5572=
240b5d60 <__PRETTY_FUNCTION__.31620> "bdrv_replace_child_noperm") at assert=
.c:101
 #4  0x0000557223e631f8 in bdrv_replace_child_noperm (child=3D0x557225b9c98=
0, new_bs=3Dnew_bs@entry=3D0x557225c42e40) at block.c:2240
 #5  0x0000557223e68be7 in bdrv_replace_node (from=3D0x557226951a60, to=3D0=
x557225c42e40, errp=3D0x5572247d6138 <error_abort>) at block.c:4196
 #6  0x0000557223d069c4 in external_snapshot_abort (common=3D0x557225d7e170=
) at blockdev.c:1731
 #7  0x0000557223d069c4 in external_snapshot_abort (common=3D0x557225d7e170=
) at blockdev.c:1717
 #8  0x0000557223d09013 in qmp_transaction (dev_list=3D<optimized out>, has=
_props=3D<optimized out>, props=3D0x557225cc7d70, errp=3Derrp@entry=3D0x7ff=
e704c0c98) at blockdev.c:2360
 #9  0x0000557223e32085 in qmp_marshal_transaction (args=3D<optimized out>,=
 ret=3D<optimized out>, errp=3D0x7ffe704c0d08) at qapi/qapi-commands-transa=
ction.c:44
 #10 0x0000557223ee798c in do_qmp_dispatch (errp=3D0x7ffe704c0d00, allow_oo=
b=3D<optimized out>, request=3D<optimized out>, cmds=3D0x5572247d3cc0 <qmp_=
commands>) at qapi/qmp-dispatch.c:132
 #11 0x0000557223ee798c in qmp_dispatch (cmds=3D0x5572247d3cc0 <qmp_command=
s>, request=3D<optimized out>, allow_oob=3D<optimized out>) at qapi/qmp-dis=
patch.c:175
 #12 0x0000557223e06141 in monitor_qmp_dispatch (mon=3D0x557225c69ff0, req=
=3D<optimized out>) at monitor/qmp.c:120
 #13 0x0000557223e0678a in monitor_qmp_bh_dispatcher (data=3D<optimized out=
>) at monitor/qmp.c:209
 #14 0x0000557223f2f366 in aio_bh_call (bh=3D0x557225b9dc60) at util/async.=
c:117
 #15 0x0000557223f2f366 in aio_bh_poll (ctx=3Dctx@entry=3D0x557225b9c840) a=
t util/async.c:117
 #16 0x0000557223f32754 in aio_dispatch (ctx=3D0x557225b9c840) at util/aio-=
posix.c:459
 #17 0x0000557223f2f242 in aio_ctx_dispatch (source=3D<optimized out>, call=
back=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:260
 #18 0x00007fa10913467d in g_main_dispatch (context=3D0x557225c28e80) at gm=
ain.c:3176
 #19 0x00007fa10913467d in g_main_context_dispatch (context=3Dcontext@entry=
=3D0x557225c28e80) at gmain.c:3829
 #20 0x0000557223f31808 in glib_pollfds_poll () at util/main-loop.c:219
 #21 0x0000557223f31808 in os_host_main_loop_wait (timeout=3D<optimized out=
>) at util/main-loop.c:242
 #22 0x0000557223f31808 in main_loop_wait (nonblocking=3D<optimized out>) a=
t util/main-loop.c:518
 #23 0x0000557223d13201 in main_loop () at vl.c:1828
 #24 0x0000557223bbfb82 in main (argc=3D<optimized out>, argv=3D<optimized =
out>, envp=3D<optimized out>) at vl.c:4504

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779036
Signed-off-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index d4ef6cd452..4cd9a58d36 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1731,6 +1731,8 @@ static void external_snapshot_abort(BlkActionState *c=
ommon)
     if (state->new_bs) {
         if (state->overlay_appended) {
             AioContext *aio_context;
+            AioContext *tmp_context;
+            int ret;
=20
             aio_context =3D bdrv_get_aio_context(state->old_bs);
             aio_context_acquire(aio_context);
@@ -1738,6 +1740,25 @@ static void external_snapshot_abort(BlkActionState *=
common)
             bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_hd=
()
                                           close state->old_bs; we need it =
*/
             bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
+
+            /*
+             * The call to bdrv_set_backing_hd() above returns state->old_=
bs to
+             * the main AioContext. As we're still going to be using it, r=
eturn
+             * it to the AioContext it was before.
+             */
+            tmp_context =3D bdrv_get_aio_context(state->old_bs);
+            if (aio_context !=3D tmp_context) {
+                aio_context_release(aio_context);
+                aio_context_acquire(tmp_context);
+
+                ret =3D bdrv_try_set_aio_context(state->old_bs,
+                                               aio_context, NULL);
+                assert(ret =3D=3D 0);
+
+                aio_context_release(tmp_context);
+                aio_context_acquire(aio_context);
+            }
+
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_b=
s */
=20
--=20
2.20.1


