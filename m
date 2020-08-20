Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4A920758
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEXntaTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4A920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8osZ-00044X-8Y
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8orn-0003W9-U7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:00:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29698
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8orj-0006JP-Eg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 14:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597946442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mVxrYNgd91tKatTsURrrq66rRuEmz+i4zeKFTzuuaM=;
 b=XEXntaTai8QuRvITawUz2x/0CZ/Y+Rfw/MI1HF8VJ7OYtfz5k+cW+8nqAR1c8NJjdMf35r
 NKqqRBoa8q0Hc/RZgIAvJu9TOSTpF6csGWOOLXznjK8EYmsObMwXRebmCp1h+sXUOMG4Y0
 FZtDJE7WJk1Bbr6SsF93Tk6g+pbS97o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-ByBtxYltOVWLbRBL5Q1nZA-1; Thu, 20 Aug 2020 14:00:38 -0400
X-MC-Unique: ByBtxYltOVWLbRBL5Q1nZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10356107464D;
 Thu, 20 Aug 2020 18:00:37 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38CF5619B5;
 Thu, 20 Aug 2020 18:00:35 +0000 (UTC)
Date: Thu, 20 Aug 2020 19:00:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 10/10] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Message-ID: <20200820180032.GS2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-11-git-send-email-zhengchuan@huawei.com>
 <81958147-04dc-5edf-7bd4-97c3ebc3a037@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81958147-04dc-5edf-7bd4-97c3ebc3a037@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.chen@huawei.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 linyilu@huawei.com, qemu-devel@nongnu.org, Chuan Zheng <zhengchuan@huawei.com>,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 8/16/20 10:20 PM, Chuan Zheng wrote:
> > Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
> > 
> > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> > ---
> 
> > +++ b/qapi/migration.json
> > @@ -1621,3 +1621,45 @@
> >   ##
> >   { 'event': 'UNPLUG_PRIMARY',
> >     'data': { 'device-id': 'str' } }
> > +
> > +##
> > +# @DirtyRateInfo:
> > +#
> > +# Information about current dirty page rate of vm.
> > +#
> > +# @dirty-rate: @dirtyrate describing the dirty page rate of vm
> > +#          in units of MB/s.
> > +#          If this field return '-1', it means querying is not
> > +#          start or not complete.
> > +#
> > +# @status: @status containing dirtyrate query status includes
> > +#       status with 'not start measuring' or
> > +#       'Still measuring' or 'measured'(since 5.2)
> 
> Missing space before (
> 
> > +##
> > +{ 'struct': 'DirtyRateInfo',
> > +  'data': {'dirty-rate': 'int64',
> > +           'status': 'str'} }
> 
> Based on your description, this should be an enum type rather than an
> open-coded string.  Something like:
> 
> { 'enum': 'DirtyRateStatus', 'data': [ 'unstarted', 'measuring', 'measured'
> ] }
> { 'struct': 'DirtyRateInfo', 'data': { 'dirty-rate': 'int64', 'status':
> 'DirtyRateStatus' } }

Yes, and if you do that I think you'll find qmp would automatically
define a C enum type for you, so you don't need to define the
CalculatingDirtyRateStage yourself;   see how MigrationStatus works.

Dave


> 
> > +
> > +##
> > +# @calc-dirty-rate:
> > +#
> > +# start calculating dirty page rate for vm
> > +#
> > +# @calc-time: time in units of second for sample dirty pages
> > +#
> > +# Since: 5.2
> > +#
> > +# Example:
> > +#   {"command": "cal-dirty-rate", "data": {"calc-time": 1} }
> > +#
> > +##
> > +{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64'} }
> > +
> > +##
> > +# @query-dirty-rate:
> > +#
> > +# query dirty page rate in units of MB/s for vm
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


