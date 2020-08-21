Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D15C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA522078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhYIjgCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA522078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95qo-0004lM-5y
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k95qG-0004Jl-09
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k95qD-0006MB-CN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598011695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HyvW85sB+8IDDdNqBaIjFqWQqwDZ22FyC141G5DygQ0=;
 b=QhYIjgCPLNo6EWhmkrtUzOpEyV/j5jShEbydRwks71IoVtBoxBlfPYinSKvzvhIuOFDF/G
 URWaH38+nvHJNCmKGwy5ZIsVfKrPzJoPnWv7BTdCmGTz8b+aS35D3ET3NxGN3tQy+aBlKj
 D1U90PAxAK7bcVXp6mQ+qs+4UOE4SWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-eD4Or0JdPvW3SWCFjenVSg-1; Fri, 21 Aug 2020 08:08:11 -0400
X-MC-Unique: eD4Or0JdPvW3SWCFjenVSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EDFC1885D87;
 Fri, 21 Aug 2020 12:08:10 +0000 (UTC)
Received: from work-vm (ovpn-113-246.ams2.redhat.com [10.36.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 990AD7E30E;
 Fri, 21 Aug 2020 12:08:08 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:08:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 02/10] migration/dirtyrate: Add RamlockDirtyInfo to
 store sampled page info
Message-ID: <20200821120806.GA2655@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-3-git-send-email-zhengchuan@huawei.com>
 <20200820162047.GJ2664@work-vm>
 <3f5ad1f2-59ab-6efd-c18e-2123dc771af8@huawei.com>
MIME-Version: 1.0
In-Reply-To: <3f5ad1f2-59ab-6efd-c18e-2123dc771af8@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zheng Chuan (zhengchuan@huawei.com) wrote:
> 
> 
> On 2020/8/21 0:20, Dr. David Alan Gilbert wrote:
> > * Chuan Zheng (zhengchuan@huawei.com) wrote:
> >> Add RamlockDirtyInfo to store sampled page info of each ramblock.
> >>
> >> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> >> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> >> ---
> >>  migration/dirtyrate.h | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> >> index 914c363..9650566 100644
> >> --- a/migration/dirtyrate.h
> >> +++ b/migration/dirtyrate.h
> >> @@ -19,6 +19,11 @@
> >>   */
> >>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            256
> >>  
> >> +/*
> >> + * Record ramblock idstr
> >> + */
> >> +#define RAMBLOCK_INFO_MAX_LEN                     256
> >> +
> >>  /* Take 1s as default for calculation duration */
> >>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
> >>  
> >> @@ -39,6 +44,19 @@ typedef enum {
> >>      CAL_DIRTY_RATE_END,
> >>  } CalculatingDirtyRateState;
> >>  
> >> +/*
> >> + * Store dirtypage info for each ramblock.
> >> + */
> >> +struct RamblockDirtyInfo {
> >> +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
> >> Can you remind me; why not just use RAMBlock* here of the block you're
> > interested in, rather than storing the name?
> >
> idstr is used to store which ramblock is sampled page in, we test it in
> find_page_matched().
> so you mean we just RAMBlock*, and take idstr out of RAMBlock* when it need to
> find matched page?

I meant just use RAMBlock*, but I think I see why you don't;
because you only hold the RCU around each part separately, the RAMBlock
could disappear between the initial hash, and the later compare;  so
using the name makes it safe.

Dave

> >> +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
> >> +    size_t ramblock_pages; /* sum of dividation by 4K pages for ramblock */
> > 
> > 'dividation' is the wrong word, and 'sum' is only needed where you're
> > adding things together.  I think this is 'ramblock size in TARGET_PAGEs'
> > 
> >> +    size_t *sample_page_vfn; /* relative offset address for sampled page */
> >> +    unsigned int sample_pages_count; /* sum of sampled pages */
> >> +    unsigned int sample_dirty_count; /* sum of dirty pages we measure */
> > 
> > These are both 'count' rather than 'sum'
> > 
> OK, will be fixed in V4:)
> 
> >> +    uint8_t *hash_result; /* array of hash result for sampled pages */
> >> +};
> >> +
> >>  void *get_dirtyrate_thread(void *arg);
> >>  #endif
> >>  
> >> -- 
> >> 1.8.3.1
> >>
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


