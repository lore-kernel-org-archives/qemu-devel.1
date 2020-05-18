Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85020C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F69D20657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3VIeVxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F69D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadLJ-0002rL-BY
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jadKZ-0002H7-9U
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:49:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jadKV-0007j0-CG
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589798946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+sdqVXMMttdQw7eZpjLmZp4nCDObSxSEiPCpGfz2p0=;
 b=a3VIeVxiWhXpPPFhFOcGxt16tEb5hA38YbZ4Gdpxk1uZiX/pcFu5TLKo3vAoHFOH0bsjiG
 q0T+ye6On/J/trIWxqboBRjUiJhPvBvRIwN1eVKa95GJaoLThds7U0pOuxXGZatRRvhQX1
 3iwiQADmxu93lHPBTc5XG9K2MhpCc5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-2Rgz64lJNHinXtvu_B3BoQ-1; Mon, 18 May 2020 06:49:04 -0400
X-MC-Unique: 2Rgz64lJNHinXtvu_B3BoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527DC464;
 Mon, 18 May 2020 10:49:03 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBCB9CA0;
 Mon, 18 May 2020 10:49:01 +0000 (UTC)
Message-ID: <fcba957843fb56f84c9a2c7bf71b184ad68ed1aa.camel@redhat.com>
Subject: Re: [PATCH v6 11/14] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 18 May 2020 13:48:59 +0300
In-Reply-To: <97dcdce3-bbbf-ab11-2b54-56e7d6ecaeba@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-12-mlevitsk@redhat.com>
 <97dcdce3-bbbf-ab11-2b54-56e7d6ecaeba@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-05-14 at 17:47 +0200, Max Reitz wrote:
> On 10.05.20 15:40, Maxim Levitsky wrote:
> > blockdev-amend will be used similiar to blockdev-create
> > to allow on the fly changes of the structure of the format based block devices.
> > 
> > Current plan is to first support encryption keyslot management for luks
> > based formats (raw and embedded in qcow2)
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  block/Makefile.objs       |   2 +-
> >  block/amend.c             | 108 ++++++++++++++++++++++++++++++++++++++
> >  include/block/block_int.h |  21 +++++---
> >  qapi/block-core.json      |  42 +++++++++++++++
> >  qapi/job.json             |   4 +-
> >  5 files changed, 169 insertions(+), 8 deletions(-)
> >  create mode 100644 block/amend.c
> 
> [...]
> 
> > diff --git a/block/amend.c b/block/amend.c
> > new file mode 100644
> > index 0000000000..4840c0ffef
> > --- /dev/null
> > +++ b/block/amend.c
> 
> [...]
> 
> > +void qmp_x_blockdev_amend(const char *job_id,
> > +                          const char *node_name,
> > +                          BlockdevAmendOptions *options,
> > +                          bool has_force,
> > +                          bool force,
> > +                          Error **errp)
> > +{
> > +    BlockdevAmendJob *s;
> > +    const char *fmt = BlockdevDriver_str(options->driver);
> > +    BlockDriver *drv = bdrv_find_format(fmt);
> > +    BlockDriverState *bs = bdrv_find_node(node_name);
> > +
> > +    /*
> > +     * If the driver is in the schema, we know that it exists.
> 
> I wonder why create.c then still checks whether drv == NULL.
It because I copy&pasta'ed that code when this fix wasn't there.
I'll copy it to amend.c, since this check doesn't hurt anyway.

I do wonder if we should make a common function for that 
can check that!= NULL and whitelist? Thoughts?


> 
> I wouldn’t count on the schema.  For example, with modularized block
> driver I could imagine that a driver appears in the schema, but loading
> the module fails, so that drv still ends up NULL.
> 
> >         But it may not
> > +     * be whitelisted.
> > +     */
> > +    assert(drv);
> > +    if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
> > +        error_setg(errp, "Driver is not whitelisted");
> > +        return;
> > +    }
> 
> [...]
> 
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 0a71357b50..fdb0cdbcdd 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -133,12 +133,27 @@ struct BlockDriver {
> >      int (*bdrv_file_open)(BlockDriverState *bs, QDict *options, int flags,
> >                            Error **errp);
> >      void (*bdrv_close)(BlockDriverState *bs);
> > +
> > +
> >      int coroutine_fn (*bdrv_co_create)(BlockdevCreateOptions *opts,
> >                                         Error **errp);
> >      int coroutine_fn (*bdrv_co_create_opts)(BlockDriver *drv,
> >                                              const char *filename,
> >                                              QemuOpts *opts,
> >                                              Error **errp);
> > +
> > +    int coroutine_fn (*bdrv_co_amend)(BlockDriverState *bs,
> > +                                      BlockdevAmendOptions *opts,
> > +                                      bool force,
> > +                                      Error **errp);
> > +
> > +    int (*bdrv_amend_options)(BlockDriverState *bs,
> > +                              QemuOpts *opts,
> > +                              BlockDriverAmendStatusCB *status_cb,
> > +                              void *cb_opaque,
> > +                              bool force,
> > +                              Error **errp);
> > +
> >      int (*bdrv_make_empty)(BlockDriverState *bs);
> >  
> >      /*
> > @@ -433,12 +448,6 @@ struct BlockDriver {
> >                                        BdrvCheckResult *result,
> >                                        BdrvCheckMode fix);
> >  
> > -    int (*bdrv_amend_options)(BlockDriverState *bs, QemuOpts *opts,
> > -                              BlockDriverAmendStatusCB *status_cb,
> > -                              void *cb_opaque,
> > -                              bool force,
> > -                              Error **errp);
> > -
> 
> No harm done, but why not just leave it where it was?
I wanted to have both legacy and qmp amend interfaces appear close
in the header file.

> 
> >      void (*bdrv_debug_event)(BlockDriverState *bs, BlkdebugEvent event);
> >  
> >      /* TODO Better pass a option string/QDict/QemuOpts to add any rule? */
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 943df1926a..74db515414 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4649,6 +4649,48 @@
> >    'data': { 'job-id': 'str',
> >              'options': 'BlockdevCreateOptions' } }
> >  
> > +##
> > +# @BlockdevAmendOptions:
> > +#
> > +# Options for amending an image format
> > +#
> > +# @driver           block driver that is suitable for the image
> 
> Missing colon after @driver.  Also, what does “suitable” mean?
> Shouldn’t it be exactly the node’s driver?  (i.e. “Block driver of the
> node to amend”)
Fixed!

> 
> Max
> 

Best regards,
	Maxim Levitsky



