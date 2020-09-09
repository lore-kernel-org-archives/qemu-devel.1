Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723DC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C3F2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 02:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS4osHjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C3F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFpf9-0000GB-Ac
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 22:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpeW-0008Ge-SI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:16:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpeU-0007BV-2m
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 22:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599617760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcfnQNAFb2xZfe+sWJZ4UUuZk5ZKII0Iz42v6KWil40=;
 b=gS4osHjEQceJzV0zWo/7QsrHtPMoZWQoSf9pPSrGnyz/Pz/PbyusGaaHR1ZD/HJv/QwsGw
 VrgN4Qv705AZCj04tLk5IeLE2RMLBHG3eVynP9xBgnNZJE2qau3CnoUupcantREU92VWVN
 xQGvrhCmeebZErlQewb+9ofjqGmRSNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-AmJLs1tVNJuK9jnojNVmUA-1; Tue, 08 Sep 2020 22:15:59 -0400
X-MC-Unique: AmJLs1tVNJuK9jnojNVmUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2B1280EDA4;
 Wed,  9 Sep 2020 02:15:57 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 039877E8C1;
 Wed,  9 Sep 2020 02:15:49 +0000 (UTC)
Subject: Re: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
To: Li Qiang <liq3ea@163.com>, dmitry.fleytman@gmail.com, kraxel@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 alxndr@bu.edu, peter.maydell@linaro.org, f4bug@amsat.org
References: <20200908164157.47108-1-liq3ea@163.com>
 <20200908164157.47108-2-liq3ea@163.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48a99ece-d808-f860-2551-0fec05ec5b01@redhat.com>
Date: Wed, 9 Sep 2020 10:15:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908164157.47108-2-liq3ea@163.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 22:16:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/9 上午12:41, Li Qiang wrote:
> Currently the MR is not explicitly connecting with its device instead of
> a opaque. In most situation this opaque is the deivce but it is not an
> enforcement. This patch adds a DeviceState member of to MemoryRegion
> we will use it in later patch.


I don't have a deep investigation. But I wonder whether we could make 
sure of owner instead of adding a new field here.

Thanks


>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   include/exec/memory.h |  9 +++++++++
>   softmmu/memory.c      | 15 +++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 0cfe987ab4..620fb12d9b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -404,6 +404,7 @@ struct MemoryRegion {
>       const char *name;
>       unsigned ioeventfd_nb;
>       MemoryRegionIoeventfd *ioeventfds;
> +    DeviceState *dev;
>   };
>   
>   struct IOMMUMemoryRegion {
> @@ -794,6 +795,14 @@ void memory_region_init_io(MemoryRegion *mr,
>                              const char *name,
>                              uint64_t size);
>   
> +void memory_region_init_io_with_dev(MemoryRegion *mr,
> +                           struct Object *owner,
> +                           const MemoryRegionOps *ops,
> +                           void *opaque,
> +                           const char *name,
> +                           uint64_t size,
> +                           DeviceState *dev);
> +
>   /**
>    * memory_region_init_ram_nomigrate:  Initialize RAM memory region.  Accesses
>    *                                    into the region will modify memory
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 70b93104e8..2628c9d2d9 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1490,6 +1490,21 @@ void memory_region_init_io(MemoryRegion *mr,
>       mr->terminates = true;
>   }
>   
> +void memory_region_init_io_with_dev(MemoryRegion *mr,
> +                           Object *owner,
> +                           const MemoryRegionOps *ops,
> +                           void *opaque,
> +                           const char *name,
> +                           uint64_t size,
> +                           DeviceState *dev)
> +{
> +    memory_region_init(mr, owner, name, size);
> +    mr->ops = ops ? ops : &unassigned_mem_ops;
> +    mr->opaque = opaque;
> +    mr->terminates = true;
> +    mr->dev = dev;
> +}
> +
>   void memory_region_init_ram_nomigrate(MemoryRegion *mr,
>                                         Object *owner,
>                                         const char *name,


