Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76376C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8DA23A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8DA23A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcGz-0005MS-II
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@cn.fujitsu.com>)
 id 1kKcFY-0003sm-9z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:58:04 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21916
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lizhijian@cn.fujitsu.com>) id 1kKcFW-00045O-D3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:58:03 -0400
X-IronPort-AV: E=Sophos;i="5.77,289,1596470400"; d="scan'208";a="99495446"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 22 Sep 2020 14:57:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id 2C05548990D3;
 Tue, 22 Sep 2020 14:57:57 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 22 Sep 2020 14:57:55 +0800
Subject: Re: [PATCH 2/3] Reduce the time of checkpoint for COLO
To: leirao <lei.rao@intel.com>, <chen.zhang@intel.com>, <jasowang@redhat.com>, 
 <quintela@redhat.com>, <dgilbert@redhat.com>, <pbonzini@redhat.com>
References: <1600485023-263643-1-git-send-email-lei.rao@intel.com>
 <1600485023-263643-3-git-send-email-lei.rao@intel.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <81e419c4-e844-aa01-c762-175ea547e93e@cn.fujitsu.com>
Date: Tue, 22 Sep 2020 14:57:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600485023-263643-3-git-send-email-lei.rao@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 2C05548990D3.ABB45
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Received-SPF: none client-ip=183.91.158.132;
 envelope-from=lizhijian@cn.fujitsu.com; helo=heian.cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:14:59
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/19/20 11:10 AM, leirao wrote:
> we should set ram_bulk_stage to false after ram_state_init,
> otherwise the bitmap will be unused in migration_bitmap_find_dirty.
> all pages in ram cache will be flushed to the ram of secondary guest
> for each checkpoint.
>
> Signed-off-by: leirao <lei.rao@intel.com>
> ---
>   migration/ram.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee..6a2b6c1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3019,6 +3019,17 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
>   }
>   
>   /*
> + * we must set ram_bulk_stage to fasle, otherwise in
> + * migation_bitmap_find_dirty the bitmap will be unused and
> + * all the pages in ram cache wil be flushed to the ram of
> + * secondary VM.
> + */
> +static void colo_set_ram_state(RAMState *rsp)
this function name is too general, how about

colo_init_ram_state(ram_state)
{
     ram_state_init(&ram_state);
     ram_state->ram_bulk_stage = false;
}

Thanks
Zhijian

> +{
> +    rsp->ram_bulk_stage = false;
> +}
> +
> +/*
>    * colo cache: this is for secondary VM, we cache the whole
>    * memory of the secondary VM, it is need to hold the global lock
>    * to call this helper.
> @@ -3062,6 +3073,7 @@ int colo_init_ram_cache(void)
>       }
>   
>       ram_state_init(&ram_state);
> +    colo_set_ram_state(ram_state);
>       return 0;
>   }
>   




