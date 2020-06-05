Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05021C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F90206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4G9qc8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F90206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhA4h-0007pw-4b
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jhA49-0007Ik-09
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:59:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jhA48-0005Lu-6i
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591354751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1VCURD1gh84usLMAdrhnMf+3Giw2U4uuiloJ+QO5fE=;
 b=d4G9qc8kde5Ghhncqn/dymuOPeUavGcd6DVLqS+JquUGbSg406ojRnkzOwrWF5N47gi0om
 ePwjZClsZPTn3KZcloj+l8OcDZwqjbU1qS3LjgG/OtOLfvq1+BmU+7EH6d1apLwt82TC22
 bc2aRS7+d2LIJpK9InBQYBvgT0FTed4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-iJF4GIR7ORmH9rwvO4xIYg-1; Fri, 05 Jun 2020 06:59:08 -0400
X-MC-Unique: iJF4GIR7ORmH9rwvO4xIYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E81FEC1A2;
 Fri,  5 Jun 2020 10:59:07 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E482A60C05;
 Fri,  5 Jun 2020 10:59:04 +0000 (UTC)
Date: Fri, 5 Jun 2020 12:59:02 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200605105902.GD22354@angien.pipo.sk>
References: <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
 <20200604091231.GC4512@linux.fritz.box>
 <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200605100747.GH5869@linux.fritz.box>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: vsementsov@virtuozzo.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 05, 2020 at 12:07:47 +0200, Kevin Wolf wrote:
> Am 05.06.2020 um 11:58 hat Peter Krempa geschrieben:
> > On Fri, Jun 05, 2020 at 11:44:07 +0200, Kevin Wolf wrote:

[...]

> > The above was actually inspired by a very recent problem I have in my
> > attempt to use the dirty bitmap populate job to refactor how libvirt
> > handles bitmaps. I've just figured out that I need to shuffle around
> > some stuff as I can't run the dirty-bitmap-populate job while an active
> > layer commit is in synchronised phase and I wanted to do the merging at
> > that point. That reminded me of a possible gotcha in having to sequence
> > the blockjobs which certainly would be more painful.
> 
> It would probably be good to have not only an iotests case that tests
> the low-level functionality of the block job, but also one that
> resembles the way libvirt would actually use it in combination with
> other jobs.

I certainly can document the way we'll use it but that in turn depends
on how the job behaves.

With the current state of the job I plan to use it in two scenarios:

Preface: I'm currently changing libvirt to use one active bitmap per
checkpoint (checkpoint is name for the point in time we want to take
backup from). This means that a layer of the backing chain can have
multiple active bitmaps depending on how many checkpoints were created
in the current top layer. (previously we've tried to optimize things by
having just one bitmap active, but the semantics were getting too crazy
to be maintainable long-term)

Bitmaps are no longer propagated over to upper layers when creating
snapshots as we can use block-dirty-bitmap-populate instead.

1) backup

Prior to doing the backup I'm figuring out the final backup bitmap, this
involves creating a temporary bitmap populated by the job for every
layer of the backing chain above of the one which contains the bitmap we
want to take a backup from and then merge all of them together as a base
for the backup.

2) blockjobs

Note: This is currently an outline how the things should be as I've hit
the snag with attempting to run the population jobs during 'ready' state
of a active-layer block-commit/blockdev-mirror job only an hour ago and
I need to change a few things.

2.1) active layer block-commit/blockdev-mirror

When the job reaches 'ready' state I'll create bitmaps in the
destination/base image of the job for every bitmap in the images
dropped/merged (we use blockdev-mirror in full-sync mode) by the
blockjob. This will capture the writes that happen after 'job-complete'.

The job will then be completed and the 2.2. will be executed as well.

2.2) non-active commit and also continuation of active layer block-commit/blockdev-mirror

After the job is completed succesfully I'll create temporary
non-persistent bitmaps for/in the images removed by the blockjob and
merge them into the destination image's bitmaps depending on their
original location in the backing chain so that the bitmap state still
properly describes which blocks have changed.

After that the original images willbe blockdev-del-eted. The above is
partialy in use today and since the job is already completed also
requires blockdev-reopen to successfuly write to the bitmaps.

----

While writing the above down I've actually realized that controling the
destination of the bitmap might not be as useful as I've thought
originally as in 2.2. step I might need the allocation bitmap merged
into multiple bitmaps, so I'd either need a temporary bitmap anyways or
would have to re-run the job multiple times which seems wasteful. I'm no
longer fully persuaded that adding the 'merge' step to the dirty
populate blockjob will be the best thing since sliced bread.


