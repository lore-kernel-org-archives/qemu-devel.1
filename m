Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529CDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A71120659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoxOHX+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8F1-0007qY-D8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jh8EH-0007Ky-M7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:01:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jh8EG-0005c4-SW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591347692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lti2Jw3tNEiBvnCSU5Im8Xme5iP2/KDb3i+EfWxH290=;
 b=XoxOHX+QK6xQcWCop45K+Ow5pqpPVUIKNLySQAlkHcZD/3d8AuKVgcQVneddigA/8AFqDV
 JVRtsdxDzjA2SYU9lTC2YPqpdQBbxOwUW2Sb2TUNlH6+uASEEERx7UAqwB+uIjT+lsOeIk
 jr/yL2g07i82C0L/UJgxsqpy1tXxYN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-ek52b3csPEqorwQ_z1mcOg-1; Fri, 05 Jun 2020 05:01:28 -0400
X-MC-Unique: ek52b3csPEqorwQ_z1mcOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99DEB107ACCD;
 Fri,  5 Jun 2020 09:01:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-112.ams2.redhat.com [10.36.113.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 660B662ABC;
 Fri,  5 Jun 2020 09:01:25 +0000 (UTC)
Date: Fri, 5 Jun 2020 11:01:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200605090123.GD5869@linux.fritz.box>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
 <20200604091231.GC4512@linux.fritz.box>
 <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200604162237.GA22354@angien.pipo.sk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 04.06.2020 um 18:22 hat Peter Krempa geschrieben:
> On Thu, Jun 04, 2020 at 13:31:45 +0200, Kevin Wolf wrote:
> > Am 04.06.2020 um 11:16 hat Peter Krempa geschrieben:
> > > On Thu, Jun 04, 2020 at 11:12:31 +0200, Kevin Wolf wrote:
> > > > Am 18.05.2020 um 22:49 hat Eric Blake geschrieben:
> > > > > > +
> > > > > > +    /* NB: new bitmap is anonymous and enabled */
> > > > > > +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
> > > > > > +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
> > > > > > +    if (!new_bitmap) {
> > > > > > +        return NULL;
> > > > > > +    }
> > > > > 
> > > > > This means if the guest writes to the disk while the job is ongoing, the
> > > > > bitmap will be updated to mark that portion of the bitmap as set, even if it
> > > > > was not allocated at the time the job started.  But then again, the guest
> > > > > writes are causing allocation, so this seems like the right thing to do.
> > > > 
> > > > Is the target bitmap active at the same time, i.e. will it get the
> > > > correct information only from new_bitmap or are the bits already set in
> > > > it anyway?
> > > 
> > > Yes, libvirt plans to use it with an active non-persistent bitmap which
> > > will in subsequent steps be merged into others. The bitmap is added in
> > > the same transaction. The bitmap must be active, because we need to wait
> > > for the block jobs to finish before it becomes usable and thus can't
> > > sequence in other operations until later.
> > 
> > A lot of bitmap merging then, because the block job in this series
> > already creates a temporary internal bitmap that is merged into the
> > target bitmap on completion. But if the target bitmap is only libvirt's
> > temporary bitmap to be merged to yet another bitmap, I wonder if this
> > process shouldn't be simplified.
> 
> Possibly yes, but I'll leave that for later. All of this is done when
> executin very expensive operations anyways so for our first
> implementation it IMO won't matter that much.

I'm not necessarily saying that the change is needed on the libvirt
side. It could also be that the block job should directly work with the
given bitmap instead of having its internal temporary bitmap. Changing
this later would mean changing the semantics of the block job, so it
would be somewhat problematic.

It would be good to have a clear picture of what we want the final
result to look like.

Kevin


