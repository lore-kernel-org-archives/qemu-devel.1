Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634EF2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPsXnqBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634EF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyR5-00035h-G0
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAyQC-0002FY-FN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAyQ9-0000ck-Et
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598459826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bIvarswiLzburCwQkHiIvhWTPJb4I884O0BCvxKOY8=;
 b=PPsXnqByKheQfYryopmTu16IWo6aiAgew/g/dfhio5cb8nkwwd5+bsNKL3/GmrJaMtXn9l
 Kyrs2izdSvIqDD2mIOk4dcuEck0wcjyRj0TVGCYAXtLpFfo8bIYndExZ3/I213vt4q5zwJ
 8IGsKQiIsLsnwg4O47a4LZelc8+zYgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-2ccPpJgTPwCh7UtCP8KqwA-1; Wed, 26 Aug 2020 12:37:01 -0400
X-MC-Unique: 2ccPpJgTPwCh7UtCP8KqwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81A3E778;
 Wed, 26 Aug 2020 16:36:59 +0000 (UTC)
Received: from work-vm (ovpn-112-133.ams2.redhat.com [10.36.112.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 225585D9CD;
 Wed, 26 Aug 2020 16:36:56 +0000 (UTC)
Date: Wed, 26 Aug 2020 17:36:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>, dme@dme.org
Subject: Re: [PATCH v5 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
Message-ID: <20200826163654.GC3932@work-vm>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-8-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1598319650-36762-8-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Compare page hash results for recorded sampled page.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>

So I think this is OK, with the minor clean up suggestions of David E.

> ---
>  migration/dirtyrate.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 66de426..050270d 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -202,6 +202,70 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      return 0;
>  }
>  
> +static int calc_page_dirty_rate(struct RamblockDirtyInfo *info)
> +{
> +    uint32_t crc;
> +    int i;
> +
> +    for (i = 0; i < info->sample_pages_count; i++) {
> +        crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
> +        if (crc != info->hash_result[i]) {
> +            info->sample_dirty_count++;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static bool find_page_matched(RAMBlock *block, struct RamblockDirtyInfo *infos,
> +                              int count, struct RamblockDirtyInfo **matched)
> +{
> +    int i;
> +
> +    for (i = 0; i < count; i++) {
> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> +            break;
> +        }
> +    }
> +
> +    if (i == count) {
> +        return false;
> +    }
> +
> +    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
> +        infos[i].ramblock_pages !=
> +            (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SHIFT_KB)) {
> +        return false;
> +    }
> +
> +    *matched = &infos[i];
> +    return true;
> +}
> +
> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_index)
> +{
> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> +    RAMBlock *block = NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo = NULL;
> +        if (!find_page_matched(block, info, block_index + 1, &block_dinfo)) {
> +            continue;
> +        }
> +        if (calc_page_dirty_rate(block_dinfo) < 0) {
> +            return -1;
> +        }
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (!DirtyStat.total_sample_count) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


