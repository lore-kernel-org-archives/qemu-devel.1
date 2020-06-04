Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA72C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCACB206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is6XEY4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCACB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgo70-0003wv-2T
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgo6E-0003Rk-IY
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:31:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50378
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgo6C-0001vS-Q5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591270311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFW5bNBRfVs+xWii4yJ4x9JmMGvNqAmyTB9r17LQ7BE=;
 b=is6XEY4xuofnr/Oj/p0I3WFm7rql8+9Hbbmu0LIy8jlL3gtwZ9BEpYI2+vozosE3mUQY9G
 5jcLNgadzMdAIU+YRpmXtTS2LyKC5j3PA+Y7bUYXeZqNH3wm9AYWdNHGmMein+wmNZebcA
 nDX/HojeRdQY4WWIs2oYOBNL7oQomp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-VOV_PTSaM3qnWCSB-ouBIw-1; Thu, 04 Jun 2020 07:31:49 -0400
X-MC-Unique: VOV_PTSaM3qnWCSB-ouBIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC982A0C00;
 Thu,  4 Jun 2020 11:31:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC7D19C71;
 Thu,  4 Jun 2020 11:31:46 +0000 (UTC)
Date: Thu, 4 Jun 2020 13:31:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200604113145.GE4512@linux.fritz.box>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
 <20200604091231.GC4512@linux.fritz.box>
 <20200604091651.GF2995787@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200604091651.GF2995787@angien.pipo.sk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
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

Am 04.06.2020 um 11:16 hat Peter Krempa geschrieben:
> On Thu, Jun 04, 2020 at 11:12:31 +0200, Kevin Wolf wrote:
> > Am 18.05.2020 um 22:49 hat Eric Blake geschrieben:
> > > > +
> > > > +    /* NB: new bitmap is anonymous and enabled */
> > > > +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
> > > > +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
> > > > +    if (!new_bitmap) {
> > > > +        return NULL;
> > > > +    }
> > > 
> > > This means if the guest writes to the disk while the job is ongoing, the
> > > bitmap will be updated to mark that portion of the bitmap as set, even if it
> > > was not allocated at the time the job started.  But then again, the guest
> > > writes are causing allocation, so this seems like the right thing to do.
> > 
> > Is the target bitmap active at the same time, i.e. will it get the
> > correct information only from new_bitmap or are the bits already set in
> > it anyway?
> 
> Yes, libvirt plans to use it with an active non-persistent bitmap which
> will in subsequent steps be merged into others. The bitmap is added in
> the same transaction. The bitmap must be active, because we need to wait
> for the block jobs to finish before it becomes usable and thus can't
> sequence in other operations until later.

A lot of bitmap merging then, because the block job in this series
already creates a temporary internal bitmap that is merged into the
target bitmap on completion. But if the target bitmap is only libvirt's
temporary bitmap to be merged to yet another bitmap, I wonder if this
process shouldn't be simplified.

Kevin


