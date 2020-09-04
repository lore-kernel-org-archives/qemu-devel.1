Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990DC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18790206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EluCZBcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18790206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE3S8-0006uW-8m
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kE3RG-00068F-EN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 00:35:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kE3RC-00021g-Ci
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 00:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599194097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tX42JeuT11tVwYg7ef2XUqO8sjNN+gdBUPZysbX08E=;
 b=EluCZBcyCpq81RrBHJ0esz6MM1VjAUwFOYBDfKuyigVdvNeGaoGfib+o3Q6SO07Nmss242
 siW7WEn+t/4aizYbndOvvQIeI6qAIOZVhceI+ndC4o669a/wdbPPHu1nb3V2Vvd4tCHEpD
 p5sv+IqpveR8JXQwoNkZZ8/Atjp1ahk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-E-lusR5jPTSbN6k5sU1Lgg-1; Fri, 04 Sep 2020 00:34:55 -0400
X-MC-Unique: E-lusR5jPTSbN6k5sU1Lgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31A5818B9F84;
 Fri,  4 Sep 2020 04:34:53 +0000 (UTC)
Received: from [10.72.13.157] (ovpn-13-157.pek2.redhat.com [10.72.13.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8F6B1002D57;
 Fri,  4 Sep 2020 04:34:34 +0000 (UTC)
Subject: Re: [PATCH 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB_UNMAP type
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200903161446.29615-1-eperezma@redhat.com>
 <20200903161446.29615-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d3e2098d-e150-7f99-a1ee-4a997daf4a5c@redhat.com>
Date: Fri, 4 Sep 2020 12:34:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903161446.29615-6-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 22:51:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/4 上午12:14, Eugenio Pérez wrote:
> Device IOTLB invalidations can unmap arbitrary ranges, eiter outside of
> the memory region or even [0, ~0ULL] for all the space. The assertion
> could be hit by a guest, and rhel7 guest effectively hit it.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   softmmu/memory.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 8694fc7cf7..e723fcbaa1 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>   {
>       IOMMUTLBEntry *entry = &event->entry;
>       hwaddr entry_end = entry->iova + entry->addr_mask;
> +    IOMMUTLBEntry tmp = *entry;
>   
>       if (event->type == IOMMU_NOTIFIER_UNMAP) {
>           assert(entry->perm == IOMMU_NONE);
> @@ -1908,10 +1909,18 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>           return;
>       }
>   
> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
> +        /* Crop (iova, addr_mask) to range */
> +        tmp.iova = MAX(tmp.iova, notifier->start);
> +        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> +        /* Confirm no underflow */
> +        assert(MIN(entry_end, notifier->end) >= tmp.iova);


It's still not clear to me why we need such assert. Consider 
notifier->end is the possible IOVA range but not possible device IOTLB 
invalidation range (e.g it allows [0, ULLONG_MAX]).

Thanks


> +    } else {
> +        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    }
>   
>       if (event->type & notifier->notifier_flags) {
> -        notifier->notify(notifier, entry);
> +        notifier->notify(notifier, &tmp);
>       }
>   }
>   


