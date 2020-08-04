Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B23C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE9A206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvQ5eY2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE9A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30oi-0000Eg-F2
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k30kX-0004T9-Rj
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:29:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k30kU-0000oe-Na
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596562152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFPpICNGVx8dbab8d5O3ZgwE0BjqidNtZYPOXhxwdVM=;
 b=LvQ5eY2O5rUuQIHc7r4BUJEG+qflM9zq1Pl/ai7522l4XYlrRcFiIdxHqsbpktaMjU+e9H
 yoOj4KuxaNwT8fz5tkoLUOlfcuNqFHIYex4kyL0CVpNa2KeWjbOUX4sRnyf0Ns0kmqjQbH
 X1k18Y7JzsespAgz4VMk5qThjvAHMlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-nGCUxkQsPkuS_DpAjD63ZQ-1; Tue, 04 Aug 2020 13:29:07 -0400
X-MC-Unique: nGCUxkQsPkuS_DpAjD63ZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBEF591277;
 Tue,  4 Aug 2020 17:29:05 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0723510013D0;
 Tue,  4 Aug 2020 17:29:03 +0000 (UTC)
Date: Tue, 4 Aug 2020 18:29:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [RFC PATCH 5/8] migration/dirtyrate: Compare hash results for
 recorded ramblock
Message-ID: <20200804172901.GH2659@work-vm>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-6-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1595646669-109310-6-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> From: Zheng Chuan <zhengchuan@huawei.com>
> 
> Compare hash results for recorded ramblock.
> 
> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
> ---
>  migration/dirtyrate.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 45cfc91..7badc53 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -202,6 +202,83 @@ static int record_block_hash_info(struct dirtyrate_config config,
>      return 0;
>  }
>  
> +static int cal_block_dirty_rate(struct block_dirty_info *info)
> +{
> +    uint8_t *md = NULL;
> +    size_t hash_len;
> +    int i;
> +    int ret = 0;
> +
> +    hash_len = qcrypto_hash_digest_len(QCRYPTO_HASH_ALG_MD5);
> +    md = g_new0(uint8_t, hash_len);

Is 'hash_len' actually constant for a given algorithm, like MD5 ?
i.e. can we just have a nice fixed size array?

> +    for (i = 0; i < info->sample_pages_count; i++) {
> +        ret = get_block_vfn_hash(info, info->sample_page_vfn[i], &md, &hash_len);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +
> +        if (memcmp(md, info->hash_result + i * hash_len, hash_len) != 0) {
> +            info->sample_dirty_count++;

When the page doesn't match, do we have to update info->hash_result with
the new hash?   If the page is only modified once, and we catch it on
this cycle, we wouldn't want to catch it next time around.

> +        }
> +    }
> +
> +out:
> +    g_free(md);
> +    return ret;
> +}
> +
> +static bool find_block_matched(RAMBlock *block, struct block_dirty_info *infos,
> +                               int count, struct block_dirty_info **matched)
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
> +    if (infos[i].block_addr != qemu_ram_get_host_addr(block) ||
> +        infos[i].block_pages !=
> +            (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SIZE_SHIFT)) {

How does this happen?

> +        return false;
> +    }
> +
> +    *matched = &infos[i];
> +    return true;
> +}
> +
> +static int compare_block_hash_info(struct block_dirty_info *info, int block_index)
> +{
> +    struct block_dirty_info *block_dinfo = NULL;
> +    RAMBlock *block = NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (ram_block_skip(block) < 0) {
> +            continue;
> +        }
> +        block_dinfo = NULL;
> +        if (!find_block_matched(block, info, block_index + 1, &block_dinfo)) {
> +            continue;
> +        }
> +        if (cal_block_dirty_rate(block_dinfo) < 0) {
> +            return -1;
> +        }
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +    if (!dirty_stat.total_sample_count) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +
>  static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
>  {
>      /* todo */
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


