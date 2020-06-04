Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8042065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfioIc/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8042065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglw4-0001Ef-8t
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jglvV-0000Z2-IR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:12:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jglvU-0006Jh-UL
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591261960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExSsndOUj/BG2jD1BAlbGc6g2A9On/JvFj0Cg5WppYE=;
 b=CfioIc/+VBgdWknVsTT5bOg8dizCsX0W4v3gSgjHWA1VjWKKYMTI5eWgols4RCeVXsxP7C
 eT3i81NJ/Axv71aYhWtXFUhMBI972aAg4lB4datMPCe3ojkgqmnAM0PET8wc9kOb159bCX
 /YEJRXtCk9so3W5eENzOlhxY7UsMUoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-iXxKy8UhMriY6YDmbvw2-A-1; Thu, 04 Jun 2020 05:12:36 -0400
X-MC-Unique: iXxKy8UhMriY6YDmbvw2-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45FD2464;
 Thu,  4 Jun 2020 09:12:35 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B2617CCC7;
 Thu,  4 Jun 2020 09:12:33 +0000 (UTC)
Date: Thu, 4 Jun 2020 11:12:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200604091231.GC4512@linux.fritz.box>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
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
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.05.2020 um 22:49 hat Eric Blake geschrieben:
> > +
> > +    /* NB: new bitmap is anonymous and enabled */
> > +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
> > +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
> > +    if (!new_bitmap) {
> > +        return NULL;
> > +    }
> 
> This means if the guest writes to the disk while the job is ongoing, the
> bitmap will be updated to mark that portion of the bitmap as set, even if it
> was not allocated at the time the job started.  But then again, the guest
> writes are causing allocation, so this seems like the right thing to do.

Is the target bitmap active at the same time, i.e. will it get the
correct information only from new_bitmap or are the bits already set in
it anyway?

If it relies on new_bitmap, I think this deserves a comment here.

In the documentation of BitmapPattern and specifically @allocation-top,
we should probably also be more explicit what this means for requests
that the guest makes while the job is running.

> Do we need to worry about the converse case where the job started with
> something allocated but runs in parallel with the guest trimming, such that
> our bitmap marks something as set even though at the conclusion of our job
> it is no longer allocated?

Discard shouldn't make the backing file visible (didn't we fix this for
qcow2 v2 only recently?), so in the sense of bdrv_is_allocated(), they
will still be allocated, even though they are probably zero clusters
now.

Kevin


