Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED791C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BE9214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoWdhBbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BE9214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWv2-0006Ap-VT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWZ7-0001Jn-7X
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWZ5-0006NJ-Hh
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:30:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwWZ5-0006Mw-Bl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580239822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d72Y5e3qg4iJDZz0PP3RQutpY7e5grjvLeONlXAIftQ=;
 b=DoWdhBbtnVTRR27AghDpeBlX5h925VVQwUI9kfCq/9pbbBuH8CjZFfgnDYTx12X2x8VSXF
 4XOWHn3h9aSA1fOO/zsA3EbIOp6zlU/LCR+iNpsDc+5gqDw/+gB+gYhyJ+IFOoCYU6fh4L
 b3yODhgodBWWlEu15UUa8zzgk1JlVdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-lTC1fW7VNNCyQUqQq99Xjg-1; Tue, 28 Jan 2020 14:30:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7A263ADA;
 Tue, 28 Jan 2020 19:30:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03E2D1073028;
 Tue, 28 Jan 2020 19:30:08 +0000 (UTC)
Message-ID: <90ba08dbccd81b4fc48aacd1ad2a291b70f1c206.camel@redhat.com>
Subject: Re: [PATCH v3 11/13] monitor: Move hmp_drive_add_node to
 block-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Tue, 28 Jan 2020 21:30:07 +0200
In-Reply-To: <20200128190337.GF3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-12-mlevitsk@redhat.com>
 <20200128190337.GF3215@work-vm>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lTC1fW7VNNCyQUqQq99Xjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-28 at 19:03 +0000, Dr. David Alan Gilbert wrote:
> * Maxim Levitsky (mlevitsk@redhat.com) wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Looks OK to me, I'm not clear on the name for 'bdrv_set_monitor_owned'
> I'd want a block person to OK that, but:


The name inspiration came from 'bdrv_next_monitor_owned'. To me it looks
like list of all BlockDriverState which are created by the monitor.
Also comment on 'monitor_list' link chain more or less confirms this.

Thanks for the review!

Best regards,
	Maxim Levitsky


> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> > ---
> >  block/monitor/block-hmp-cmds.c | 30 ++++++++++++++++++++++++
> >  blockdev.c                     | 42 +++++++---------------------------
> >  include/block/block_int.h      |  5 ++--
> >  3 files changed, 41 insertions(+), 36 deletions(-)
> > 
> > diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> > index a4b1604aee..7bbe4e3814 100644
> > --- a/block/monitor/block-hmp-cmds.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -33,6 +33,36 @@
> >  #include "monitor/hmp.h"
> >  #include "qemu-io.h"
> >  
> > +static void hmp_drive_add_node(Monitor *mon, const char *optstr)
> > +{
> > +    QemuOpts *opts;
> > +    QDict *qdict;
> > +    Error *local_err = NULL;
> > +
> > +    opts = qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
> > +    if (!opts) {
> > +        return;
> > +    }
> > +
> > +    qdict = qemu_opts_to_qdict(opts, NULL);
> > +
> > +    if (!qdict_get_try_str(qdict, "node-name")) {
> > +        qobject_unref(qdict);
> > +        error_report("'node-name' needs to be specified");
> > +        goto out;
> > +    }
> > +
> > +    BlockDriverState *bs = bds_tree_init(qdict, &local_err);
> > +    if (!bs) {
> > +        error_report_err(local_err);
> > +        goto out;
> > +    }
> > +
> > +    bdrv_set_monitor_owned(bs);
> > +out:
> > +    qemu_opts_del(opts);
> > +}
> > +
> >  void hmp_drive_add(Monitor *mon, const QDict *qdict)
> >  {
> >      Error *err = NULL;
> > diff --git a/blockdev.c b/blockdev.c
> > index df43e0aaef..63805f34b5 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -64,7 +64,7 @@
> >  #include "qemu/main-loop.h"
> >  #include "qemu/throttle-options.h"
> >  
> > -static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
> > +QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
> >      QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
> >  
> >  static int do_open_tray(const char *blk_name, const char *qdev_id,
> > @@ -75,6 +75,11 @@ static void blockdev_insert_medium(bool has_device, const char *device,
> >                                     bool has_id, const char *id,
> >                                     const char *node_name, Error **errp);
> >  
> > +void bdrv_set_monitor_owned(BlockDriverState *bs)
> > +{
> > +    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
> > +}
> > +
> >  static const char *const if_name[IF_COUNT] = {
> >      [IF_NONE] = "none",
> >      [IF_IDE] = "ide",
> > @@ -652,7 +657,7 @@ err_no_opts:
> >  }
> >  
> >  /* Takes the ownership of bs_opts */
> > -static BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
> > +BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
> >  {
> >      int bdrv_flags = 0;
> >  
> > @@ -4201,37 +4206,6 @@ out:
> >      aio_context_release(aio_context);
> >  }
> >  
> > -void hmp_drive_add_node(Monitor *mon, const char *optstr)
> > -{
> > -    QemuOpts *opts;
> > -    QDict *qdict;
> > -    Error *local_err = NULL;
> > -
> > -    opts = qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
> > -    if (!opts) {
> > -        return;
> > -    }
> > -
> > -    qdict = qemu_opts_to_qdict(opts, NULL);
> > -
> > -    if (!qdict_get_try_str(qdict, "node-name")) {
> > -        qobject_unref(qdict);
> > -        error_report("'node-name' needs to be specified");
> > -        goto out;
> > -    }
> > -
> > -    BlockDriverState *bs = bds_tree_init(qdict, &local_err);
> > -    if (!bs) {
> > -        error_report_err(local_err);
> > -        goto out;
> > -    }
> > -
> > -    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
> > -
> > -out:
> > -    qemu_opts_del(opts);
> > -}
> > -
> >  void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
> >  {
> >      BlockDriverState *bs;
> > @@ -4261,7 +4235,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
> >          goto fail;
> >      }
> >  
> > -    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
> > +    bdrv_set_monitor_owned(bs);
> >  
> >  fail:
> >      visit_free(v);
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index dd033d0b37..10df257a61 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -1217,8 +1217,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
> >                              BlockCompletionFunc *cb, void *opaque,
> >                              JobTxn *txn, Error **errp);
> >  
> > -void hmp_drive_add_node(Monitor *mon, const char *optstr);
> > -
> >  BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
> >                                    const char *child_name,
> >                                    const BdrvChildRole *child_role,
> > @@ -1320,4 +1318,7 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
> >  
> >  int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
> >  
> > +void bdrv_set_monitor_owned(BlockDriverState *bs);
> > +BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp);
> > +
> >  #endif /* BLOCK_INT_H */
> > -- 
> > 2.17.2
> > 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



