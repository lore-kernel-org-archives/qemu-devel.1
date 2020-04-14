Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DD52072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So29Imer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DD52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHyP-0005Qv-E3
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOHxn-00050B-7k
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOHxk-0005O0-Vc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:34:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOHxk-0005NS-NY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586856875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FI2T/qGlYcPrd68r7M1DRhLUy9Ug3ZwO4A8giVzIXk=;
 b=So29ImerN40d/J77lTgKDeIFBJDiWc6Q44BXpSFPJ5ZMzJbErAOElMMCXVoDQWl+dHaOXl
 TxbernScOiptWetWZ6v1WIz0wxxUVXAC+PqKzPXBsgB8Tr3c56uhk+IiGUZsMmJc67lPw3
 rr01/EVHWNuIFaY/EOZr+iywkGcL9kw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-cj7Z0m6vNsivVbF-iBhtrA-1; Tue, 14 Apr 2020 05:34:33 -0400
X-MC-Unique: cj7Z0m6vNsivVbF-iBhtrA-1
Received: by mail-wm1-f69.google.com with SMTP id q5so2095958wmc.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 02:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9FI2T/qGlYcPrd68r7M1DRhLUy9Ug3ZwO4A8giVzIXk=;
 b=pe/wy3XlvJZeVX44RV2t8U9kNo+f+wznMrnSM6d56cr1j0OyfDh8KYXG8yblFj15dM
 NfzfH3If5j5lt3PxOWaylzspaRsxDWdu+0KM6gtHJaHqqbKP6FEU7eNan4cA9kd8B8dk
 Pqa9l766za5uL8PSs6EOzMWzSJi1cu8TDzO3UATB3idz+OAb4raj5Kei6bCMYnZssxDN
 45iWIRT8Wpo9aUOXcJD8lheQOeYd/VxwIGi7Bc//r0wmNz1vQvvxhdEPe9E7wIN2vF+D
 iwelL/uElecGowy28JVlxjqstZLiR30kW407yt+Rzru6GVOvfMrKb7QG0zM/f0h5gAQR
 4Z4Q==
X-Gm-Message-State: AGi0Pub26s21TtQLssjgq+rBg8zqjoPWqbEdxyVRyDYi+TVVIcCFOJFL
 EhX4UEoIR4OqPROl69S8kpi/KTim2VSC4FAEjXvpeOvSSSnUSJ8mJKUCuDpVyIZHLiEkz+SJv6z
 0r9na7wQzCvd7iyc=
X-Received: by 2002:adf:9e01:: with SMTP id u1mr21975507wre.37.1586856872284; 
 Tue, 14 Apr 2020 02:34:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypLhtXiZI6ZrtOpw5Jlw4qWDkX95AEETOJwuuceSMo4A2O3NSA7IQPGIBa6nGyIomA+SX2ERfA==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr21975492wre.37.1586856872085; 
 Tue, 14 Apr 2020 02:34:32 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 36sm2554324wrc.35.2020.04.14.02.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 02:34:31 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] hw/vfio: drop guest writes to ro regions
To: Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
 <20200413063737.84706-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cfa324b-65a3-be61-58b8-f51d6a0ea91d@redhat.com>
Date: Tue, 14 Apr 2020 11:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413063737.84706-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, alex.williamson@redhat.com,
 Xin Zeng <xin.zeng@intel.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yan,

On 4/13/20 8:37 AM, Yan Zhao wrote:
> for vfio regions that are without write permission,
> drop guest writes to those regions.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   hw/vfio/common.c     | 8 +++++++-
>   hw/vfio/trace-events | 2 +-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0..fd6ee1fe3e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -190,6 +190,11 @@ void vfio_region_write(void *opaque, hwaddr addr,
>           uint64_t qword;
>       } buf;
>   

I'd move the trace here (trace always):

        trace_vfio_region_write(vbasedev->name, region->nr, addr, data, 
size);

> +    if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> +        trace_vfio_region_write(vbasedev->name, region->nr,
> +                                   addr, data, size, true);

And use qemu_log_mask(LOG_GUEST_ERROR, ...) here instead.

> +        return;
> +    }
>       switch (size) {
>       case 1:
>           buf.byte = data;
> @@ -215,7 +220,8 @@ void vfio_region_write(void *opaque, hwaddr addr,
>                        addr, data, size);
>       }
>   
> -    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
> +    trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size,
> +                            false);
>   
>       /*
>        * A read or write to a BAR always signals an INTx EOI.  This will
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index b1ef55a33f..fb9ff604e6 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -91,7 +91,7 @@ vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint64_t siz
>   vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_speed) "%s link_speed=0x%x"
>   
>   # common.c
> -vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
> +vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size, bool readonly) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)" " is_readonly_region=%d."
>   vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>   vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
>   vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
> 


