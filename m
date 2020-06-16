Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C9CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0FE20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr44rEW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0FE20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Zd-0004Bt-KS
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jl8Ms-0002La-IY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:58:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38995
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jl8Mq-0004Pd-BS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592301534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DZkRS2YKIYjTQ3m1364+zVUZcS7Kch3h1oiLa89smbI=;
 b=Gr44rEW3IwT/Z3XvZU00d6ODcyuGQ8oHa8htAurpPWL8J/6tBb3Ql3BKcnLJDPVv2Tj4Wk
 n1FHrV6AJAS4e97djCOe34HKjni2YWR5bXeF6FTp7RZj3ukb+xPGQMGi+xSh3TCIuy+zT9
 UMlnvveR877t4/Ck+Lhxe8TDfh/KoKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-PspdvweGNHatQN315_VJ-g-1; Tue, 16 Jun 2020 05:58:53 -0400
X-MC-Unique: PspdvweGNHatQN315_VJ-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21C5873426;
 Tue, 16 Jun 2020 09:58:51 +0000 (UTC)
Received: from work-vm (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3087BA14;
 Tue, 16 Jun 2020 09:58:49 +0000 (UTC)
Date: Tue, 16 Jun 2020 10:58:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: zhukeqian <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2] migration: Count new_dirty instead of real_dirty
Message-ID: <20200616095846.GA2788@work-vm>
References: <20200616021059.25984-1-zhukeqian1@huawei.com>
 <20200616093551.GA2790@work-vm>
 <3a45d5a0-3acf-336d-520f-523bf588b551@huawei.com>
MIME-Version: 1.0
In-Reply-To: <3a45d5a0-3acf-336d-520f-523bf588b551@huawei.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: zhang.zhanghailiang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jianjay.zhou@huawei.com,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* zhukeqian (zhukeqian1@huawei.com) wrote:
> Hi Dave,
> 
> On 2020/6/16 17:35, Dr. David Alan Gilbert wrote:
> > * Keqian Zhu (zhukeqian1@huawei.com) wrote:
> >> real_dirty_pages becomes equal to total ram size after dirty log sync
> >> in ram_init_bitmaps, the reason is that the bitmap of ramblock is
> >> initialized to be all set, so old path counts them as "real dirty" at
> >> beginning.
> >>
> >> This causes wrong dirty rate and false positive throttling at the end
> >> of first ram save iteration.
> >>
> >> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > 
> > Since this function already returns num_dirty, why not just change the
> > caller to increment a counter based off the return value?
> Yes, that would be better :-) .
> 
> > 
> > Can you point to the code which is using this value that triggers the
> > throttle?
> > 
> In migration_trigger_throttle(), rs->num_dirty_pages_period is used.
> And it corresponds to real_dirty_pages here.

OK; so is the problem not the same as the check that's in there for
blk_mig_bulk_activate - don't we need to do the same trick for ram bulk
migration (i.e. the first pass).

Dave

> Thanks,
> Keqian
> 
> > Dave
> > 
> > 
> [...]
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > .
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


