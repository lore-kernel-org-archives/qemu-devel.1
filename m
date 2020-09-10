Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B9CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E7F21D40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbQXl8GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E7F21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPiF-0006UK-DO
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGPhW-00060d-Sc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:45:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50040
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGPhT-0002oq-NQ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599756330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9gs+opao99TJzrb0g7tu3gstiCZ7V9bS0hbGSCa3a+o=;
 b=AbQXl8GFglxmDMinbHnxJ9+to2sOaa1LMsiF5NFclphqk9JtcMU4DfjPoy+CVw0QyfXuK0
 c4jJLzCk153ZK6FUp4SR/rm8Z5VCqkrk7sv09WHZxT2k47ymokLUPfisDp5PV1lfEO3jDN
 i+DE9QOSxHjXJl9LY8VuEnhfTPG189U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-30z_9nzTOAeZn8EbeeYRsQ-1; Thu, 10 Sep 2020 12:45:28 -0400
X-MC-Unique: 30z_9nzTOAeZn8EbeeYRsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1758C1019624;
 Thu, 10 Sep 2020 16:45:26 +0000 (UTC)
Received: from work-vm (ovpn-114-164.phx2.redhat.com [10.3.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CEEA9CBA;
 Thu, 10 Sep 2020 16:45:22 +0000 (UTC)
Date: Thu, 10 Sep 2020 17:45:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v7 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
Message-ID: <20200910164519.GJ2814@work-vm>
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-8-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1599661096-127913-8-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, dme@dme.org,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> Compare page hash results for recorded sampled page.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bc87269..f5987d8 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -193,6 +193,69 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      return 0;
>  }
>  
> +static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
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
> +}
> +
> +static struct RamblockDirtyInfo *
> +find_page_matched(RAMBlock *block, int count,
> +                  struct RamblockDirtyInfo *infos)
> +{
> +    int i;
> +    struct RamblockDirtyInfo *matched;
> +
> +    for (i = 0; i < count; i++) {
> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> +            break;
> +        }
> +    }
> +
> +    if (i == count) {
> +        return NULL;
> +    }
> +
> +    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
> +        infos[i].ramblock_pages !=
> +            (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
> +        return NULL;
> +    }
> +
> +    matched = &infos[i];
> +
> +    return matched;
> +}
> +
> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_index)
> +{
> +    struct RamblockDirtyInfo *block_dinfo = NULL;
> +    RAMBlock *block = NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo = find_page_matched(block, block_index + 1, info);
> +        if (block_dinfo == NULL) {
> +            continue;
> +        }
> +        calc_page_dirty_rate(block_dinfo);
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (DirtyStat.total_sample_count == 0) {
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


