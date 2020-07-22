Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B711C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD4C205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+qI7gWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD4C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAMp-0000DX-5H
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyAKc-0005p4-CF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:42:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyAKa-0000b2-7J
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595407347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OxgyKRwLz8oreoGlChZW1hq/fXGW/KCKYsT+aR2gD5o=;
 b=I+qI7gWn0e0nheDK8lFLpW7fjrHw8M/TpzD5YtOZGMWgioDgFG2IHjsAozWxsESCw0ORoz
 zJSFc7rBuQErozlHV7V/2eSULbSJhqD7xgKJa9uffFMZzy0YtKOChkxEmuMLySd8Hjv5fj
 XS3UGJhO9ilEo3l7yHUrW9J9QZxYoW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-imMzTlRbN4GVK1349irKgw-1; Wed, 22 Jul 2020 04:42:25 -0400
X-MC-Unique: imMzTlRbN4GVK1349irKgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C325C107BEF5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:42:24 +0000 (UTC)
Received: from [10.36.113.254] (ovpn-113-254.ams2.redhat.com [10.36.113.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6CF67854B;
 Wed, 22 Jul 2020 08:42:20 +0000 (UTC)
Subject: Re: [PATCH 4/4] error: Use error_fatal to simplify obvious fatal
 errors (again)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200722084048.1726105-1-armbru@redhat.com>
 <20200722084048.1726105-5-armbru@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <b883fbed-262d-6bb0-2668-6ca44db828e8@redhat.com>
Date: Wed, 22 Jul 2020 10:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200722084048.1726105-5-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
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
Cc: Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.07.20 10:40, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>     $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
> 	     --macro-file scripts/cocci-macro-file.h --use-gitgrep .
> 
> Variables now unused dropped manually.
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  exec.c                     | 11 +++--------
>  hw/s390x/s390-virtio-ccw.c |  6 +-----
>  hw/virtio/vhost.c          | 10 +++-------
>  3 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 6f381f98e2..61b46a62f8 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -627,8 +627,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
>       */
>      MemoryRegion *mr = MEMORY_REGION(iommu_mr);
>      TCGIOMMUNotifier *notifier;
> -    Error *err = NULL;
> -    int i, ret;
> +    int i;
>  
>      for (i = 0; i < cpu->iommu_notifiers->len; i++) {
>          notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
> @@ -657,12 +656,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
>                              0,
>                              HWADDR_MAX,
>                              iommu_idx);
> -        ret = memory_region_register_iommu_notifier(notifier->mr, &notifier->n,
> -                                                    &err);
> -        if (ret) {
> -            error_report_err(err);
> -            exit(1);
> -        }
> +        memory_region_register_iommu_notifier(notifier->mr, &notifier->n,
> +                                              &error_fatal);
>      }
>  
>      if (!notifier->active) {
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8cc2f25d8a..4fc92559fb 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -170,11 +170,7 @@ static void s390_memory_init(MemoryRegion *ram)
>       * Configure the maximum page size. As no memory devices were created
>       * yet, this is the page size of initial memory only.
>       */
> -    s390_set_max_pagesize(qemu_maxrampagesize(), &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        exit(EXIT_FAILURE);
> -    }
> +    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
>      /* Initialize storage key device */
>      s390_skeys_init();
>      /* Initialize storage attributes device */
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e7a6..cc8c1f89d5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -712,9 +712,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
>                                           iommu_listener);
>      struct vhost_iommu *iommu;
>      Int128 end;
> -    int iommu_idx, ret;
> +    int iommu_idx;
>      IOMMUMemoryRegion *iommu_mr;
> -    Error *err = NULL;
>  
>      if (!memory_region_is_iommu(section->mr)) {
>          return;
> @@ -737,11 +736,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
>      iommu->iommu_offset = section->offset_within_address_space -
>                            section->offset_within_region;
>      iommu->hdev = dev;
> -    ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, &err);
> -    if (ret) {
> -        error_report_err(err);
> -        exit(1);
> -    }
> +    memory_region_register_iommu_notifier(section->mr, &iommu->n,
> +                                          &error_fatal);
>      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
>      /* TODO: can replay help performance here? */
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


