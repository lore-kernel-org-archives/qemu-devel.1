Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8836E23119
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnF3WODO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8836E23119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3jEk-0006HS-BK
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 12:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3jDq-0004zz-Ep
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:58:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48998
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3jDn-0007Ha-HR
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 12:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596733106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJEGpt/XFsQ5fCnZXRPplmTss6R05W5+6SFCaCxFgto=;
 b=dnF3WODOAHBksZikdjOFRqsZx3H6296AstXAGYymKqkJHjca8yZAzyl/Y26dHw4miX1WSj
 Pg00DFlhQX+a0G4y44lIQLFLtG4YTmYssCmyv9KThm6nZtVhKuRURGvgkBbwiFS/Sv3Pe9
 3UCwEFQsxaXOT+Tj2SsJnnU3v+fLoC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-0B6wmFyRN9SMAArfvy_zQg-1; Thu, 06 Aug 2020 12:58:24 -0400
X-MC-Unique: 0B6wmFyRN9SMAArfvy_zQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E55388017FB;
 Thu,  6 Aug 2020 16:58:15 +0000 (UTC)
Received: from work-vm (ovpn-114-105.ams2.redhat.com [10.36.114.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 078E37B904;
 Thu,  6 Aug 2020 16:58:13 +0000 (UTC)
Date: Thu, 6 Aug 2020 17:58:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 0/8] *** A Method for evaluating dirty page rate ***
Message-ID: <20200806165811.GI2711@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <20200804161902.GC2659@work-vm>
 <fdb4afcb-8c99-1a97-a211-5eaa0573398d@huawei.com>
MIME-Version: 1.0
In-Reply-To: <fdb4afcb-8c99-1a97-a211-5eaa0573398d@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zheng Chuan (zhengchuan@huawei.com) wrote:
> 
> 
> On 2020/8/5 0:19, Dr. David Alan Gilbert wrote:
> > * Chuan Zheng (zhengchuan@huawei.com) wrote:
> >> From: Zheng Chuan <zhengchuan@huawei.com>
> > 
> > Hi,
> > 
> >> Sometimes it is neccessary to evaluate dirty page rate before migration.
> >> Users could decide whether to proceed migration based on the evaluation
> >> in case of vm performance loss due to heavy workload.
> >> Unlikey simulating dirtylog sync which could do harm on runnning vm,
> >> we provide a sample-hash method to compare hash results for samping page.
> >> In this way, it would have hardly no impact on vm performance.
> >>
> >> We evaluate the dirtypage rate on running vm.
> >> The VM specifications for migration are as follows:
> >> - VM use 4-K page;
> >> - the number of VCPU is 32;
> >> - the total memory is 32Gigabit;
> >> - use 'mempress' tool to pressurize VM(mempress 4096 1024);
> >>
> >> ++++++++++++++++++++++++++++++++++++++++++
> >> |                      |    dirtyrate    |
> >> ++++++++++++++++++++++++++++++++++++++++++
> >> | no mempress          |     4MB/s       |
> >> ------------------------------------------
> >> | mempress 4096 1024   |    1204MB/s     |
> >> ++++++++++++++++++++++++++++++++++++++++++
> >> | mempress 4096 4096   |    4000Mb/s     |
> >> ++++++++++++++++++++++++++++++++++++++++++
> > 
> > This is quite neat; I know we've got other people who have asked
> > for a similar feature!
> > Have you tried to validate these numbers against a real migration - e.g.
> > try setting mempress to dirty just under 1GByte/s and see if you can
> > migrate it over a 10Gbps link?
> > 
> > Dave
> > 
> Hi, Dave.
> Thank you for your review.
> 
> Note that, the original intention is evaluating dirty rate before migration.

Right, but the reason you want to evaluate the dirty rate is, I guess,
to figure out whether a migration is likely to coverge?

> However, I test dirty rate against a real migration over a bandwidth of 10Gps with various mempress, which shows as below:
> ++++++++++++++++++++++++++++++++++++++++++
> |                      |    dirtyrate    |
> ++++++++++++++++++++++++++++++++++++++++++
> | no mempress          |     8MB/s       |
> ------------------------------------------
> | mempress 4096 1024   |    1188MB/s     |
> ++++++++++++++++++++++++++++++++++++++++++
> 
> It looks still close to actual dirty rate:)

I don't quite understand that comparison you just gave.
But what I was expecting was that a mempress that
just fits teh ~1100MB/s is just the limit of what you can get down
a 10Gbps link.

Dave

> Test results against a real migration will be posted in V2.
> 
> >> Test dirtyrate by qmp command like this:
> >> 1.  virsh qemu-monitor-command [vmname] '{"execute":"cal_dirty_rate", "arguments": {"value": [sampletime]}}'
> >> 2.  virsh qemu-monitor-command [vmname] '{"execute":"get_dirty_rate"}'
> >>
> >> Further test dirtyrate by libvirt api like this:
> >> virsh getdirtyrate [vmname] [sampletime]
> >>
> >> Zheng Chuan (8):
> >>   migration/dirtyrate: Add get_dirtyrate_thread() function
> >>   migration/dirtyrate: Add block_dirty_info to store dirtypage info
> >>   migration/dirtyrate: Add dirtyrate statistics series functions
> >>   migration/dirtyrate: Record hash results for each ramblock
> >>   migration/dirtyrate: Compare hash results for recorded ramblock
> >>   migration/dirtyrate: Implement get_sample_gap_period() and
> >>     block_sample_gap_period()
> >>   migration/dirtyrate: Implement calculate_dirtyrate() function
> >>   migration/dirtyrate: Implement
> >>     qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
> >>
> >>  migration/Makefile.objs |   1 +
> >>  migration/dirtyrate.c   | 424 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  migration/dirtyrate.h   |  67 ++++++++
> >>  qapi/migration.json     |  24 +++
> >>  qapi/pragma.json        |   3 +-
> >>  5 files changed, 518 insertions(+), 1 deletion(-)
> >>  create mode 100644 migration/dirtyrate.c
> >>  create mode 100644 migration/dirtyrate.h
> >>
> >> -- 
> >> 1.8.3.1
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > 
> > .
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


