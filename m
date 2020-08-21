Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22302C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99EF2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoPGc3l+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99EF2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95v9-0007SL-54
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k95uF-0006kq-84
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:12:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20945
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k95uD-00079z-2U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598011943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gItEHllVSoEA5IN0VNQLB6mUfRBhyvyiTu60qote0o0=;
 b=eoPGc3l+C4TIS+g9eVwznxZXEJnK98ObVAhUMzyk0dmYE4EISoVV6Sl6QSvWLEGUC1n5Lv
 kBO8KEHpWsqAGKGsjgqdG0IXrh92dWAiX/cHotuAW9zQEsY7U9zwHGqHzk5+wsSB+XFuN2
 hrpE9KPN/2rDm8Mx6aIIw64VHF8tnp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-48hjk_7LPua-CgINHIx0Pw-1; Fri, 21 Aug 2020 08:12:22 -0400
X-MC-Unique: 48hjk_7LPua-CgINHIx0Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0DDB8030A9;
 Fri, 21 Aug 2020 12:12:20 +0000 (UTC)
Received: from work-vm (ovpn-113-246.ams2.redhat.com [10.36.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0A6614F1;
 Fri, 21 Aug 2020 12:12:18 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:12:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 06/10] migration/dirtyrate: Compare page hash results
 for recorded sampled page
Message-ID: <20200821121216.GB2655@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-7-git-send-email-zhengchuan@huawei.com>
 <20200820173640.GN2664@work-vm>
 <44c84de1-8d85-957e-0195-fb72e0cf375d@huawei.com>
MIME-Version: 1.0
In-Reply-To: <44c84de1-8d85-957e-0195-fb72e0cf375d@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
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
> On 2020/8/21 1:36, Dr. David Alan Gilbert wrote:
> > * Chuan Zheng (zhengchuan@huawei.com) wrote:
> >> Compare page hash results for recorded sampled page.
> >>
> >> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> >> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> >> ---
> >>  migration/dirtyrate.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 76 insertions(+)
> >>
> >> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> index 62b6f69..3ce25f5 100644
> >> --- a/migration/dirtyrate.c
> >> +++ b/migration/dirtyrate.c
> >> @@ -215,6 +215,82 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
> >>      return 0;
> >>  }
> >>  
> >> +static int calc_page_dirty_rate(struct RamblockDirtyInfo *info)
> >> +{
> >> +    uint8_t *md = NULL;
> >> +    int i;
> >> +    int ret = 0;
> >> +
> >> +    md = g_try_new0(uint8_t, qcrypto_hash_len);
> >> +    if (!md) {
> >> +        return -1;
> >> +    }
> > 
> > As previously asked; isn't this a nice small simple fixed length - no
> > need to allocate it?
> > 
> Yes, it could use QCRYPTO_HASH_LEN to define an array.
> >> +
> >> +    for (i = 0; i < info->sample_pages_count; i++) {
> >> +        ret = get_ramblock_vfn_hash(info, info->sample_page_vfn[i], &md);
> >> +        if (ret < 0) {
> >> +            goto out;
> >> +        }
> >> +
> >> +        if (memcmp(md, info->hash_result + i * qcrypto_hash_len,
> >> +                   qcrypto_hash_len) != 0) {
> >> +            info->sample_dirty_count++;
> >> +        }
> >> +    }
> >> +
> >> +out:
> >> +    g_free(md);
> >> +    return ret;
> >> +}
> >> +
> >> +static bool find_page_matched(RAMBlock *block, struct RamblockDirtyInfo *infos,
> >> +                              int count, struct RamblockDirtyInfo **matched)
> >> +{
> >> +    int i;
> >> +
> >> +    for (i = 0; i < count; i++) {
> >> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> >> +            break;
> >> +        }
> >> +    }
> >> +
> >> +    if (i == count) {
> >> +        return false;
> >> +    }
> >> +
> >> +    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
> >> +        infos[i].ramblock_pages !=
> >> +            (qemu_ram_get_used_length(block) >> 12)) {
> >> +        return false;
> > 
> > I previously asked how this happens.
> > Also this was DIRTYRATE_PAGE_SIZE_SHIFT
> > 
> Here, we want to find same ramblock we sampled before.
> We just ignore the ramblock if its hva address or size changed due to memory hot-plug during the measurement.

OK, just try and make the code consistent between '12',
'DIRTYRATE_PAGE_SIZE_SHIFT'
or TARGET_PAGE_SIZE/SHIFT.

Dave

> >> +    }
> >> +
> >> +    *matched = &infos[i];
> >> +    return true;
> >> +}
> >> +
> >> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
> >> +                                  int block_index)
> >> +{
> >> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> >> +    RAMBlock *block = NULL;
> >> +
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> +        block_dinfo = NULL;
> > 
> > So you've removed the selction of only some RAMBlocks now?
> > 
> In next patch:), i add functions to skip sampling ramblock.
> 
> >> +        if (!find_page_matched(block, info, block_index + 1, &block_dinfo)) {
> >> +            continue;
> >> +        }
> >> +        if (calc_page_dirty_rate(block_dinfo) < 0) {
> >> +            return -1;
> >> +        }
> >> +        update_dirtyrate_stat(block_dinfo);
> >> +    }
> >> +    if (!dirty_stat.total_sample_count) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  static void calculate_dirtyrate(struct DirtyRateConfig config)
> >>  {
> >>      /* todo */
> >> -- 
> >> 1.8.3.1
> >>
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


