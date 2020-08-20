Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C276BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89281207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zex7zTdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89281207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8oYi-00049M-Pd
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8oXk-0002oZ-NG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:40:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8oXj-0003Av-2Q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597945202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1MSd+bh2opWOT1nEV8Etp4Xck0zoeKQEAMrJEJsf4xo=;
 b=Zex7zTdUJvIuQcaivzbGXHTUz3fcUcl5Tn9ZNiRiZKPLmGE4sb9Dr4lvQHNPhf7CxIGk6f
 H9C6LHqIzBcAUpHgB4huc0zZoEE998ekqtAqMLXRBXJU1xGBKSkdWTS5Go4uUm8DpuZy0m
 WCDnRnzDi8QnK1S8z9Ix0QNzf05mzB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-PrTGCjG7MP69gE1sRTCWcA-1; Thu, 20 Aug 2020 13:40:00 -0400
X-MC-Unique: PrTGCjG7MP69gE1sRTCWcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16BA51DE05;
 Thu, 20 Aug 2020 17:39:59 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4339719D7D;
 Thu, 20 Aug 2020 17:39:57 +0000 (UTC)
Date: Thu, 20 Aug 2020 18:39:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 07/10] migration/dirtyrate: skip sampling ramblock
 with size below MIN_RAMBLOCK_SIZE
Message-ID: <20200820173954.GO2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-8-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1597634433-18809-8-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> In order to sample real RAM, skip ramblock with size below
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>

OK,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>  migration/dirtyrate.h |  5 +++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 3ce25f5..6f30f67 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -186,6 +186,24 @@ alloc_ramblock_dirty_info(int *block_index,
>      return block_dinfo;
>  }
>  
> +static int skip_sample_ramblock(RAMBlock *block)
> +{
> +    int64_t ramblock_size;
> +
> +    /* ramblock size in MB */
> +    ramblock_size = qemu_ram_get_used_length(block) >> 20;
> +
> +    /*
> +     * Consider ramblock with size larger than 128M is what we
> +     * want to sample.
> +     */
> +    if (ramblock_size < MIN_RAMBLOCK_SIZE) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>                                       struct DirtyRateConfig config,
>                                       int *block_index)
> @@ -196,6 +214,9 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>      int index = 0;
>  
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block) < 0) {
> +            continue;
> +        }
>          dinfo = alloc_ramblock_dirty_info(&index, dinfo);
>          if (dinfo == NULL) {
>              return -1;
> @@ -275,6 +296,9 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
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
> index 0812b16..fce2e3b 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -31,6 +31,11 @@
>  
>  #define QCRYPTO_HASH_LEN                          16
>  
> +/*
> + * minimum ramblock size to sampled
> + */
> +#define MIN_RAMBLOCK_SIZE                        128
> +
>  /* Take 1s as default for calculation duration */
>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>  
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


