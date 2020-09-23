Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A77C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987A920BED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKysp6F0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987A920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLA5f-0007BT-Ii
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLA3m-0006Lo-H2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLA3k-00052z-Kq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 15:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600887847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpT5E4+rm0dqySQWk8wyO1XOXb4wc6ba4Lx4g7p/Wgw=;
 b=QKysp6F08Du0qKZyEOSSJyUimxyVbW7Nxb1dPZMfl5kNef60C/W1uYqECgA62pytdguOV8
 uC9r32jWEeyMWrHvTeGOQVA13bBwvL8nfKLFMfao8V3TRqRapLrR0DCNezMpaWUQSBPbAE
 7pmK11N26ZlRE6TI03K8KzIjiefzdvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-fztrYvs_NtKD_KYWqT-Irg-1; Wed, 23 Sep 2020 15:04:02 -0400
X-MC-Unique: fztrYvs_NtKD_KYWqT-Irg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2F8DEA337;
 Wed, 23 Sep 2020 19:04:00 +0000 (UTC)
Received: from work-vm (ovpn-113-46.ams2.redhat.com [10.36.113.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37BE13782;
 Wed, 23 Sep 2020 19:03:58 +0000 (UTC)
Date: Wed, 23 Sep 2020 20:03:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v10 11/12] migration/dirtyrate: Implement
 qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
Message-ID: <20200923190355.GD2780@work-vm>
References: <1600237327-33618-1-git-send-email-zhengchuan@huawei.com>
 <1600237327-33618-12-git-send-email-zhengchuan@huawei.com>
 <1c8647f5-62d4-bda6-df12-a60c6d0fc4db@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1c8647f5-62d4-bda6-df12-a60c6d0fc4db@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: alex.chen@huawei.com, berrange@redhat.com, zhang.zhanghailiang@huawei.com,
 quintela@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, Chuan Zheng <zhengchuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 9/16/20 1:22 AM, Chuan Zheng wrote:
> > Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function which could be called
> > 
> > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> > ---
> 
> > +++ b/qapi/migration.json
> > @@ -1737,3 +1737,53 @@
> >   ##
> >   { 'enum': 'DirtyRateStatus',
> >     'data': [ 'unstarted', 'measuring', 'measured'] }
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
> 
> Grammar:
> 
> it means querying has not yet started or completed.
> 
> Should this field instead be optional, and omitted for those cases?  In
> which case, I'd suggest:
> 
> ...in units of MB/s, present only when querying the rate has completed.

I've already got it queued; I'll fix up the grammar; if someone wants to
send a change to make it optional before this version freezes that's OK.

Dave

> 
> > +#
> > +# @status: status containing dirtyrate query status includes
> > +#          'unstarted' or 'measuring' or 'measured'
> > +#
> > +# @start-time: start time in units of second for calculation
> > +#
> > +# @calc-time: time in units of second for sample dirty pages
> > +#
> > +# Since: 5.2
> > +#
> > +##
> > +{ 'struct': 'DirtyRateInfo',
> > +  'data': {'dirty-rate': 'int64',
> > +           'status': 'DirtyRateStatus',
> > +           'start-time': 'int64',
> > +           'calc-time': 'int64'} }
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
> > +#   {"command": "calc-dirty-rate", "data": {"calc-time": 1} }
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


