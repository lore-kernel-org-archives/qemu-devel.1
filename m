Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7098C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7484E2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpKxgLId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7484E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyhl-0000hP-PM
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAyh4-0000E0-2o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:54:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAyh1-0002tp-23
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598460873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7oTdfLx27jQhJZo2wtzB6hySjgfYYw+iH+MPL30OmC8=;
 b=dpKxgLIdxRoyVT/tyKSJ5joJKas1a53c1O0CRhwfsx8KESp8DAk1/HqD1XSrtzNHHT6zU5
 86gI6WdZnuozczrfa1tZQhPO9T8jEKiZbznu3WTHsS+M1EXsXMYx0VuJ5R3D8Xt2FdRA+1
 hS3w64fbCaTDTQP8n4uCwSrzOSOBC5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-DvrZI4sPO1OM6fCmK8BHTQ-1; Wed, 26 Aug 2020 12:54:31 -0400
X-MC-Unique: DvrZI4sPO1OM6fCmK8BHTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0EF80F059;
 Wed, 26 Aug 2020 16:54:30 +0000 (UTC)
Received: from work-vm (ovpn-112-133.ams2.redhat.com [10.36.112.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C511E19C78;
 Wed, 26 Aug 2020 16:54:27 +0000 (UTC)
Date: Wed, 26 Aug 2020 17:54:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v5 08/12] migration/dirtyrate: skip sampling ramblock
 with size below MIN_RAMBLOCK_SIZE
Message-ID: <20200826165425.GD3932@work-vm>
References: <1598319650-36762-1-git-send-email-zhengchuan@huawei.com>
 <1598319650-36762-9-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1598319650-36762-9-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: berrange@redhat.com, zhang.zhanghailiang@huawei.com, quintela@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> In order to sample real RAM, skip ramblock with size below MIN_RAMBLOCK_SIZE
> which is set as 128M.
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> ---
>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>  migration/dirtyrate.h | 10 ++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 050270d..bd398b7 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -173,6 +173,24 @@ alloc_ramblock_dirty_info(int *block_index,
>      return block_dinfo;
>  }
>  
> +static int skip_sample_ramblock(RAMBlock *block)
> +{
> +    int64_t ramblock_size;
> +
> +    /* ramblock size in MB */
> +    ramblock_size = qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SHIFT_MB;
> +
> +    /*
> +     * Consider ramblock with size larger than 128M is what we
> +     * want to sample.
> +     */
> +    if (ramblock_size < MIN_RAMBLOCK_SIZE) {
> +        return -1;
> +    }

This seems way too complicated for:

  if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
      return -1;
  }

  return 0;

(even easier if it just returned bool from the comparison)

Dave

> +    return 0;
> +}
> +
>  static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>                                       struct DirtyRateConfig config,
>                                       int *block_index)
> @@ -183,6 +201,9 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      int index = 0;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block) < 0) {
> +            continue;
> +        }
>          dinfo = alloc_ramblock_dirty_info(&index, dinfo);
>          if (dinfo == NULL) {
>              return -1;
> @@ -249,6 +270,9 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>      RAMBlock *block = NULL;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block) < 0) {
> +            continue;
> +        }
>          block_dinfo = NULL;
>          if (!find_page_matched(block, info, block_index + 1, &block_dinfo)) {
>              continue;
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index e3adead..600bceb 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -35,10 +35,20 @@
>  #define DIRTYRATE_PAGE_SHIFT_KB                   12
>  
>  /*
> + * Sample page size MB shift
> + */
> +#define DIRTYRATE_PAGE_SHIFT_MB                   20
> +
> +/*
>   * Sample page size 1G shift
>   */
>  #define DIRTYRATE_PAGE_SHIFT_GB                   30
>  
> +/*
> + * minimum ramblock size to sampled
> + */
> +#define MIN_RAMBLOCK_SIZE                         128
> +
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>  
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


