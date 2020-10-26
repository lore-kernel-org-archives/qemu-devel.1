Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C96CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C766B223B0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0c2lnoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C766B223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5rA-0003rF-Qd
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX5pQ-0001nf-Sl
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX5pP-0005XJ-7G
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avlSF6aMWyCKKrcdJzKBRDQHzUtJDsbwDFSzQ30TCIc=;
 b=A0c2lnoGlUojc/6JaWqDpvsNyI0Gr9Z61nUa3Mv6BkaLj7ucX1uhHd+exoh9YWwuHL3211
 73zWgqbERwL/Nwk+QoKKnbe3tjS0OqyfgGUfdDPmgQYtGvDVuVkeoOfeorxoHOaZb3VXp7
 SGeE/wYYDAGJyRJKfQqJI88ovA42hsM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NesjWvATORSIQn-I1Kgu1g-1; Mon, 26 Oct 2020 12:58:36 -0400
X-MC-Unique: NesjWvATORSIQn-I1Kgu1g-1
Received: by mail-wr1-f71.google.com with SMTP id h8so8931041wrt.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 09:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=avlSF6aMWyCKKrcdJzKBRDQHzUtJDsbwDFSzQ30TCIc=;
 b=DI52o34rEhuLFQWRMifUWlcJMN8j68kAu8aLkKKP1QsbBy/WoXtRy7WfTlou4TuduL
 DmT1f/BrJLUjObe23F0Zcz3BRk1csykh5Vwo3OJgAL+EvsYnb2fZx3FNuxsM5K3zRcfQ
 ppYdV7I8J95rvZ1lT6R6pjgenwaNivMhCCjO1GMyY9BQPRmvUPhqR5i/r6tUWWPevTwl
 i2HfDV9Q3QmL9cr4Vc0D284NC7A0uLYBH3eNWrr/g1MVOuzsY0BbkJDiDS8iPvpRZYUr
 5bL5Eo2aVNMe9TIwTtzbVlF/pKVTirsebZQ7UmT0PYC5gCNU2ssD8876aCJLssNGmRVx
 Ea5w==
X-Gm-Message-State: AOAM533cgnYr9YTexE+VJM7JYm7aXHcEq7UkhawnTDVM1PLXFI7It+Eg
 E/Wnp2uWY9GUKNzbPAVkf570KsICt6R9NJzuBWNhwiW/ScG0Qm/cyZCQQAh+8StAktynw/CR0Zm
 w5RKcA1C+uxCPz/g=
X-Received: by 2002:a1c:e045:: with SMTP id x66mr17112057wmg.104.1603731515080; 
 Mon, 26 Oct 2020 09:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTw9uS9TYD7OXKbuw0a4Qf0LAxclDaBv5kYgkDepFeSd1cxgNtjBWNfVrTHifbUIQdGnciEw==
X-Received: by 2002:a1c:e045:: with SMTP id x66mr17111994wmg.104.1603731514505; 
 Mon, 26 Oct 2020 09:58:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id x3sm20438030wmi.45.2020.10.26.09.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 09:58:29 -0700 (PDT)
Subject: Re: [PATCH v29 10/17] memory: Set DIRTY_MEMORY_MIGRATION when IOMMU
 is enabled
To: Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
 <1603704987-20977-11-git-send-email-kwankhede@nvidia.com>
 <20201026104748.589b207d@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80e2181b-80ca-01d4-31ac-3839972393bb@redhat.com>
Date: Mon, 26 Oct 2020 17:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026104748.589b207d@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 17:47, Alex Williamson wrote:
> Paolo,
> 
> Any objection to this change?  Thanks,

Not at all.  Sorry I missed this change.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Alex
> 
> On Mon, 26 Oct 2020 15:06:20 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> mr->ram_block is NULL when mr->is_iommu is true, then fr.dirty_log_mask
>> wasn't set correctly due to which memory listener's log_sync doesn't
>> get called.
>> This patch returns log_mask with DIRTY_MEMORY_MIGRATION set when
>> IOMMU is enabled.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
>> ---
>>  softmmu/memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index 403ff3abc99b..94f606e9d9d9 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -1792,7 +1792,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr)
>>  uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>>  {
>>      uint8_t mask = mr->dirty_log_mask;
>> -    if (global_dirty_log && mr->ram_block) {
>> +    if (global_dirty_log && (mr->ram_block || memory_region_is_iommu(mr))) {
>>          mask |= (1 << DIRTY_MEMORY_MIGRATION);
>>      }
>>      return mask;
> 


