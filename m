Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263BBC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30C7206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+IZ15XU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30C7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlYm-00025z-Lz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irkUs-0007Ie-3g
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irkUq-0007a8-Eo
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:22:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irkUq-0007ZY-Ar
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XH6obng3uc1IHe/96IK+6tLvgyF32ZWcPTGsF1JiHrM=;
 b=e+IZ15XUN918JC7ILGJ9QLOtUdI7AQ81/UTsej2pWsFAdE7m2axnAf4XgWBufsS2zZIyUm
 BqX3FoghygKD/CmC6mIdtGli4Nnf6qVlJcoOhXIGBTZS4+L9WbXsub5MY4p9QqlZ6U2Ov4
 fz7ev0Iqh90O2bLLlMuHsT6iCHCTST8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-KsLbGVYiPQS4BCppJZuIvw-1; Wed, 15 Jan 2020 10:22:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FC7B8D80CE;
 Wed, 15 Jan 2020 15:22:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C73265D9C9;
 Wed, 15 Jan 2020 15:22:05 +0000 (UTC)
Date: Wed, 15 Jan 2020 16:22:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v6 7/8] blockdev: Return bs to the proper context on
 snapshot abort
Message-ID: <20200115152203.GE5505@linux.fritz.box>
References: <20200108143138.129909-1-slp@redhat.com>
 <20200108143138.129909-8-slp@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200108143138.129909-8-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: KsLbGVYiPQS4BCppJZuIvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
> external_snapshot_abort() calls to bdrv_set_backing_hd(), which
> returns state->old_bs to the main AioContext, as it's intended to be
> used then the BDS is going to be released. As that's not the case when
> aborting an external snapshot, return it to the AioContext it was
> before the call.
>=20
> This issue can be triggered by issuing a transaction with two actions,
> a proper blockdev-snapshot-sync and a bogus one, so the second will
> trigger a transaction abort. This results in a crash with an stack
> trace like this one:
>=20
>  #0  0x00007fa1048b28df in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps=
/unix/sysv/linux/raise.c:50
>  #1  0x00007fa10489ccf5 in __GI_abort () at abort.c:79
>  #2  0x00007fa10489cbc9 in __assert_fail_base
>      (fmt=3D0x7fa104a03300 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", a=
ssertion=3D0x5572240b44d8 "bdrv_get_aio_context(old_bs) =3D=3D bdrv_get_aio=
_context(new_bs)", file=3D0x557224014d30 "block.c", line=3D2240, function=
=3D<optimized out>) at assert.c:92
>  #3  0x00007fa1048aae96 in __GI___assert_fail
>      (assertion=3Dassertion@entry=3D0x5572240b44d8 "bdrv_get_aio_context(=
old_bs) =3D=3D bdrv_get_aio_context(new_bs)", file=3Dfile@entry=3D0x5572240=
14d30 "block.c", line=3Dline@entry=3D2240, function=3Dfunction@entry=3D0x55=
72240b5d60 <__PRETTY_FUNCTION__.31620> "bdrv_replace_child_noperm") at asse=
rt.c:101
>  #4  0x0000557223e631f8 in bdrv_replace_child_noperm (child=3D0x557225b9c=
980, new_bs=3Dnew_bs@entry=3D0x557225c42e40) at block.c:2240
>  #5  0x0000557223e68be7 in bdrv_replace_node (from=3D0x557226951a60, to=
=3D0x557225c42e40, errp=3D0x5572247d6138 <error_abort>) at block.c:4196
>  #6  0x0000557223d069c4 in external_snapshot_abort (common=3D0x557225d7e1=
70) at blockdev.c:1731
>  #7  0x0000557223d069c4 in external_snapshot_abort (common=3D0x557225d7e1=
70) at blockdev.c:1717
>  #8  0x0000557223d09013 in qmp_transaction (dev_list=3D<optimized out>, h=
as_props=3D<optimized out>, props=3D0x557225cc7d70, errp=3Derrp@entry=3D0x7=
ffe704c0c98) at blockdev.c:2360
>  #9  0x0000557223e32085 in qmp_marshal_transaction (args=3D<optimized out=
>, ret=3D<optimized out>, errp=3D0x7ffe704c0d08) at qapi/qapi-commands-tran=
saction.c:44
>  #10 0x0000557223ee798c in do_qmp_dispatch (errp=3D0x7ffe704c0d00, allow_=
oob=3D<optimized out>, request=3D<optimized out>, cmds=3D0x5572247d3cc0 <qm=
p_commands>) at qapi/qmp-dispatch.c:132
>  #11 0x0000557223ee798c in qmp_dispatch (cmds=3D0x5572247d3cc0 <qmp_comma=
nds>, request=3D<optimized out>, allow_oob=3D<optimized out>) at qapi/qmp-d=
ispatch.c:175
>  #12 0x0000557223e06141 in monitor_qmp_dispatch (mon=3D0x557225c69ff0, re=
q=3D<optimized out>) at monitor/qmp.c:120
>  #13 0x0000557223e0678a in monitor_qmp_bh_dispatcher (data=3D<optimized o=
ut>) at monitor/qmp.c:209
>  #14 0x0000557223f2f366 in aio_bh_call (bh=3D0x557225b9dc60) at util/asyn=
c.c:117
>  #15 0x0000557223f2f366 in aio_bh_poll (ctx=3Dctx@entry=3D0x557225b9c840)=
 at util/async.c:117
>  #16 0x0000557223f32754 in aio_dispatch (ctx=3D0x557225b9c840) at util/ai=
o-posix.c:459
>  #17 0x0000557223f2f242 in aio_ctx_dispatch (source=3D<optimized out>, ca=
llback=3D<optimized out>, user_data=3D<optimized out>) at util/async.c:260
>  #18 0x00007fa10913467d in g_main_dispatch (context=3D0x557225c28e80) at =
gmain.c:3176
>  #19 0x00007fa10913467d in g_main_context_dispatch (context=3Dcontext@ent=
ry=3D0x557225c28e80) at gmain.c:3829
>  #20 0x0000557223f31808 in glib_pollfds_poll () at util/main-loop.c:219
>  #21 0x0000557223f31808 in os_host_main_loop_wait (timeout=3D<optimized o=
ut>) at util/main-loop.c:242
>  #22 0x0000557223f31808 in main_loop_wait (nonblocking=3D<optimized out>)=
 at util/main-loop.c:518
>  #23 0x0000557223d13201 in main_loop () at vl.c:1828
>  #24 0x0000557223bbfb82 in main (argc=3D<optimized out>, argv=3D<optimize=
d out>, envp=3D<optimized out>) at vl.c:4504
>=20
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1779036
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 292961a88d..cfed87f434 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1731,6 +1731,8 @@ static void external_snapshot_abort(BlkActionState =
*common)
>      if (state->new_bs) {
>          if (state->overlay_appended) {
>              AioContext *aio_context;
> +            AioContext *tmp_context;
> +            int ret;
> =20
>              aio_context =3D bdrv_get_aio_context(state->old_bs);
>              aio_context_acquire(aio_context);
> @@ -1738,6 +1740,25 @@ static void external_snapshot_abort(BlkActionState=
 *common)
>              bdrv_ref(state->old_bs);   /* we can't let bdrv_set_backind_=
hd()
>                                            close state->old_bs; we need i=
t */
>              bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
> +
> +            /*
> +             * The call to bdrv_set_backing_hd() above returns state->ol=
d_bs to
> +             * the main AioContext. As we're still going to be using it,=
 return
> +             * it to the AioContext it was before.
> +             */
> +            tmp_context =3D bdrv_get_aio_context(state->old_bs);
> +            if (aio_context !=3D tmp_context) {
> +                aio_context_release(aio_context);
> +                aio_context_acquire(tmp_context);
> +
> +                ret =3D bdrv_try_set_aio_context(state->old_bs,
> +                                               aio_context, NULL);
> +                assert(ret =3D=3D 0);
> +
> +                aio_context_release(tmp_context);
> +                aio_context_acquire(aio_context);
> +            }
> +
>              bdrv_replace_node(state->new_bs, state->old_bs, &error_abort=
);
>              bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old=
_bs */

Arguably, bdrv_replace_node() should share the AioContext-switching
logic with bdrv_root_attach_child() so that the general case is solved.

I guess this patch is simple enough and solves a relevant special case,
so no objection. But it might not be the final fix.

Kevin


