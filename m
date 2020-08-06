Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2236C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC6020786
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3B2nFU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC6020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3jGf-0007l4-RK
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 13:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3jFp-0007Kr-OJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:00:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k3jFo-0007SQ-6F
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596733231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa2IBHIg+V4BEzf8CxZjWoAfZhwr+Zd9/tRNm8F3Y88=;
 b=P3B2nFU9qC7GLZFZtxPRDLMIVUZEF4C6GScsmyonR62MAW8ic2Uu7XIYWTl1KTvgbgzofy
 7OeiCiiy8MkBTvM+0KjWC9tMPBLlWEbPNoZB5QqPVgUxm75TSxUaVgAPo5mbetq6qs6qaw
 1HlE1CKXzCUOYdk+fpATtn8a2+/8JgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-iuw2cOsaNMOgoWHuLtYdJg-1; Thu, 06 Aug 2020 12:59:09 -0400
X-MC-Unique: iuw2cOsaNMOgoWHuLtYdJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFC30800688;
 Thu,  6 Aug 2020 16:59:06 +0000 (UTC)
Received: from work-vm (ovpn-114-105.ams2.redhat.com [10.36.114.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 231DD65C91;
 Thu,  6 Aug 2020 16:59:04 +0000 (UTC)
Date: Thu, 6 Aug 2020 17:59:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 2/8] migration/dirtyrate: Add block_dirty_info to
 store dirtypage info
Message-ID: <20200806165902.GJ2711@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-3-git-send-email-zhengchuan@huawei.com>
 <20200804162829.GE2659@work-vm>
 <8ac6e996-b01d-9b7c-3f7a-aeb2b376cfa1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <8ac6e996-b01d-9b7c-3f7a-aeb2b376cfa1@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zheng Chuan (zhengchuan@huawei.com) wrote:
> 
> 
> On 2020/8/5 0:28, Dr. David Alan Gilbert wrote:
> > * Chuan Zheng (zhengchuan@huawei.com) wrote:
> >> From: Zheng Chuan <zhengchuan@huawei.com>
> >>
> >> Add block_dirty_info to store dirtypage info for each ramblock
> >>
> >> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> >> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> >> ---
> >>  migration/dirtyrate.h | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> >> index 9a5c228..342b89f 100644
> >> --- a/migration/dirtyrate.h
> >> +++ b/migration/dirtyrate.h
> >> @@ -33,6 +33,19 @@ typedef enum {
> >>      CAL_DIRTY_RATE_END   = 2,
> >>  } CalculatingDirtyRateStage;
> >>  
> >> +/* 
> >> + * Store dirtypage info for each block.
> >> + */
> >> +struct block_dirty_info {
> > 
> > Please call this ramblock_dirty_info; we use 'block' a lot to mean
> > disk block and it gets confusing.
> > 
> Sure, ramblock_dirty_info is better.
> 
> >> +    char idstr[BLOCK_INFO_MAX_LEN];
> > 
> > Is there a reason you don't just use a RAMBlock *  here?
> > 
> >> +    uint8_t *block_addr;
> >> +    unsigned long block_pages;
> >> +    unsigned long *sample_page_vfn;
> > 
> > Please comment these; if I understand correctly, that's an array
> > of page indexes into the block generated from the random numbers
> > 
> >> +    unsigned int sample_pages_count;
> >> +    unsigned int sample_dirty_count;
> >> +    uint8_t *hash_result;
> > 
> > If I understand, this is an array of hashes end-to-end for
> > all the pages in this RAMBlock?
> > 
> > Dave
> > 
> Actually, we do not go through all pages of the RAMBlock but sample
> some pages （for example, 256 pages per Gigabit）to make it faster.
> Obviously it will sacrifice accuracy, but it still looks good enough
> under practical test.

Right yes; but that 'hash_result' is an array of hash values, one
for each of the pages that you did measure?

Dave

> >> +};
> >> +
> >>  void *get_dirtyrate_thread(void *arg);
> >>  #endif
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


