Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58AD20CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IR3s3zoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58AD20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlX9H-00010q-81
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlX8b-0000SS-3Y
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:25:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlX8Z-0001ym-0u
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592396750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7CjHe45M+edR1aB4YeYI+v1mCeTUCfi0qJ6AI9pdVq4=;
 b=IR3s3zoFODi173W32Dm3NhRDeAYXqHA4OZwnH6wygyyItCZntwwAjQg/s0GBXYVdAh3CIk
 IfmnxmAIoyt8ONrAx3KxpaQgVHa8i778GenpKzx+fJivDntd0J88CrQ7HSEM8VuEHeMHHJ
 5JF9TvObHjSJvn/uv9CVdzcuxNSnD3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Hs7T_mUCOKyfRAUWCMPmVA-1; Wed, 17 Jun 2020 08:25:46 -0400
X-MC-Unique: Hs7T_mUCOKyfRAUWCMPmVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01BB184B8A5;
 Wed, 17 Jun 2020 12:25:45 +0000 (UTC)
Received: from work-vm (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F8965F65;
 Wed, 17 Jun 2020 12:25:43 +0000 (UTC)
Date: Wed, 17 Jun 2020 13:25:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Message-ID: <20200617122541.GD2776@work-vm>
References: <20200607194611.24763-1-chen.zhang@intel.com>
 <d1b031b8c9f241d4af843392d8091a18@intel.com>
MIME-Version: 1.0
In-Reply-To: <d1b031b8c9f241d4af843392d8091a18@intel.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zhang, Chen (chen.zhang@intel.com) wrote:
> Hi Dave,
> 

I think it's OK; I guess Zhanghailiang is going to do a pull for it?
One thought about the change of use of MIGRATION_STATUS_ACTIVE; I think
it's OK at the moment - but the migration states and the way they change
becomes part of the API - changing which states we use can confuse
management applications; since there's no libvirt support, I'll leave
it to Zhanghailiang to know if that's OK.

Dave


> 
> Thanks
> Zhang Chen
> 
> > -----Original Message-----
> > From: Zhang, Chen <chen.zhang@intel.com>
> > Sent: Monday, June 8, 2020 3:46 AM
> > To: Dr . David Alan Gilbert <dgilbert@redhat.com>; qemu-dev <qemu-
> > devel@nongnu.org>
> > Cc: Zhang Chen <zhangckid@gmail.com>; Zhanghailiang
> > <zhang.zhanghailiang@huawei.com>; Zhang, Chen <chen.zhang@intel.com>
> > Subject: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
> > 
> > From: Zhang Chen <chen.zhang@intel.com>
> > 
> > This series optimize some code of COLO, please review.
> > 
> > Zhang Chen (3):
> >   migration/colo: Optimize COLO boot code path
> >   migration/colo: Update checkpoint time lately
> >   migration/migration.c: Remove MIGRATION_STATUS_ACTIVE in
> >     migration_iteration_finish
> > 
> >  migration/colo.c      |  7 ++-----
> >  migration/migration.c | 12 +++++-------
> >  2 files changed, 7 insertions(+), 12 deletions(-)
> > 
> > --
> > 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


