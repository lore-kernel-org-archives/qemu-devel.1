Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE09C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8769208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIY9a2rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8769208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVmn-0003yw-Ur
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlVlT-0003H5-W7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:57:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlVlR-0004Sq-M7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592391472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNa2JH8ef605r5S7G7D4W/ZfWLwP2HlC1SUHRNqqgqM=;
 b=iIY9a2rc1YmOOqVmjoEXdWmowMkGcAPwp5ZtCXdXk5Q87drlCCZiSrDJZ1F5fCKtFnwSRv
 qBI82A0wNnXvMg9PXeef90heBJ4MA48tusltN0UXxm+FIaE4TlIO+dcJIkqRLEF579dHXT
 M6ZCAvt5KQ6a2Abxo6iihnFbKiGGSYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-RP48gaGgNniAtlI9nrpVDg-1; Wed, 17 Jun 2020 06:57:50 -0400
X-MC-Unique: RP48gaGgNniAtlI9nrpVDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC307803328;
 Wed, 17 Jun 2020 10:57:49 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6A2D10013D6;
 Wed, 17 Jun 2020 10:57:47 +0000 (UTC)
Date: Wed, 17 Jun 2020 12:57:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200617105746.GB5166@linux.fritz.box>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <20200604090140.GB4512@linux.fritz.box>
 <bb9a31cf-99e0-ef35-3739-bb3ff270735d@redhat.com>
 <aef43939-63eb-8e48-e3ad-dfc12d1f3d21@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aef43939-63eb-8e48-e3ad-dfc12d1f3d21@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.06.2020 um 22:02 hat Eric Blake geschrieben:
> On 6/16/20 2:46 PM, Eric Blake wrote:
> 
> > > > +BlockJob *bitpop_job_create(
> > 
> > > > +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
> > > > +        return NULL;
> > > > +    }
> > > 
> > > What does this protect? And why does BACKUP_SOURCE describe acccurately
> > > what this job does?
> > 
> > I'm less certain what the BLOCK_OP_TYPE_* constants are supposed to
> > block, or if this is just copy/paste from backup.c. Does BlockOpType in
> > block.h need a new entry?
> 
> As it is, our code base has slowly moved away from op_blockers.

Yes, this is true. We're now trying to express conflicts with the
permission system instead.

> We no longer have any explicit bdrv_op_block() except when blocking
> everything, then immediately followed up with unblocking a mere subset
> of all of the defined op types:

I believe we never had any other pattern because nobody ever could be
bothered to think about specific conflicts. If we had one example of
conflicting uses, we just blocked everything and only unblocked cases
when we needed them (usually not really knowing whether they were really
always safe). So op blocker are almost always overblocking, but
sometimes too permissive, too.

This is why I was asking what we actually protect against here.

> 
> block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_COMMIT_TARGET,
> block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_STREAM,
> block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_SOURCE,
> block.c:    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
> block/replication.c:        bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE,
> s->blocker);
> blockjob.c:    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
> 
> Are we at the point where we can ditch op_blockers altogether in favor of
> the block permissions system?

I actually started some patches to remove op blockers the other day. The
tricky part is proving that each type is really unnecessary now. I only
did this for RESIZE and DATAPLANE, which seemed relatively easy to
prove, though I guess I could send at least these patches.

Kevin


