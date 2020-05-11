Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94EA020746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huSvlD/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA020746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7aS-00088o-PN
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7Yz-0007J9-5V
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:29:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY7Yv-0006JD-Uj
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589200176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8L4dH79F/shaoDlU4MtTMVVRmb5egfDfK9KucJ74l8=;
 b=huSvlD/4V8ymdevWIYQxB6GpqBtcZbPNX5LSmWSo3UwqQp/l1xaYAXybWy1J/B3a2w3jft
 sR0UIdPsJzEwSdrFTZqLC2Jr9CDHT57qfIL+pdABTcB7AZqP17IHnR2dpAo9t6/VF4Dkva
 cDK0cRpiOHrU7LbtVRaNlA9tDDbFmAA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-eaHbUZ9WNx6j4E0E5HqSPA-1; Mon, 11 May 2020 08:29:34 -0400
X-MC-Unique: eaHbUZ9WNx6j4E0E5HqSPA-1
Received: by mail-wr1-f71.google.com with SMTP id 30so5165114wrq.15
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L8L4dH79F/shaoDlU4MtTMVVRmb5egfDfK9KucJ74l8=;
 b=in6ya3P3hKBiSKXxDsRhj10KrDS2Caxjnu60BJUgKxMPURwE0TNgQMmxjhyy7XWkBM
 Ge+LV8Cb9sL7XFC7hvqiedG6xKawuDTgA0qWCglov/NJwCZwO7+5EGkgINlpmV6+1ajq
 sK9BwwybYmh7ip24id14qNewRqkstsYI3GzNZdAUrqFrCVcJiqt/YeEUiNtFhryQOU+0
 Dh+0y6mguun4XhKwk1FDH4R2NKdRxqY3nv6P1XgKnk3xFumfo8Um1boXRAOzY9IgRsbq
 7cCYrRHQaeLg6SbdfUscA6OVwKor0S4bpkgeppz4qoo5yhMmDARFcYOrIEkGpem78Jdr
 MtVg==
X-Gm-Message-State: AGi0Pub3m2bmpaY4qrLFagoitV1mGwndxckuTCkqhbqAekXBQrQaqMZP
 sYqLQjCeSvtKHhyXtTa7rSpQoTWL+OPv/STJM+LX9qkl3W8PjUqu6AOiSTu8lUYc5Jgp4ekDlAn
 COof2tYgzjHF38TI=
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr439026wrx.220.1589200173548; 
 Mon, 11 May 2020 05:29:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcKEiOnqfAsZMxICoK31AGYiX38a3/H8tq8UPmIBsMSzRauMwJT4miSZdGi0Vew+lO78Z9xw==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr438995wrx.220.1589200173317; 
 Mon, 11 May 2020 05:29:33 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q17sm9650822wmk.36.2020.05.11.05.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 05:29:32 -0700 (PDT)
Subject: Re: [PATCH v26 01/10] acpi: nvdimm: change NVDIMM_UUID_LE to a common
 macro
To: Dongjiu Geng <gengdongjiu@huawei.com>, imammedo@redhat.com,
 mst@redhat.com, xiaoguangrong.eric@gmail.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, fam@euphon.net,
 rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <20200507134205.7559-1-gengdongjiu@huawei.com>
 <20200507134205.7559-2-gengdongjiu@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f29e19c-cb37-05e6-0ae3-c019370e090b@redhat.com>
Date: Mon, 11 May 2020 14:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200507134205.7559-2-gengdongjiu@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhengxiang9@huawei.com, linuxarm@huawei.com, Jonathan.Cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:41 PM, Dongjiu Geng wrote:
> The little end UUID is used in many places, so make
> NVDIMM_UUID_LE to a common macro to convert the UUID
> to a little end array.
> 
> Reviewed-by: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> Change since v25:
> 1. Address Peter's comments to add a proper doc-comment comment for
>     UUID_LE macros.
> ---
>   hw/acpi/nvdimm.c    | 10 +++-------
>   include/qemu/uuid.h | 26 ++++++++++++++++++++++++++
>   slirp               |  2 +-
>   3 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index fa7bf8b..9316d12 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -27,6 +27,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/uuid.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/aml-build.h"
>   #include "hw/acpi/bios-linker-loader.h"
> @@ -34,18 +35,13 @@
>   #include "hw/mem/nvdimm.h"
>   #include "qemu/nvdimm-utils.h"
>   
> -#define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
> -   { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> -     (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
> -     (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }
> -
>   /*
>    * define Byte Addressable Persistent Memory (PM) Region according to
>    * ACPI 6.0: 5.2.25.1 System Physical Address Range Structure.
>    */
>   static const uint8_t nvdimm_nfit_spa_uuid[] =
> -      NVDIMM_UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
> -                     0x18, 0xb7, 0x8c, 0xdb);
> +      UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
> +              0x18, 0xb7, 0x8c, 0xdb);
>   
>   /*
>    * NVDIMM Firmware Interface Table
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 129c45f..2d17a90 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -34,6 +34,32 @@ typedef struct {
>       };
>   } QemuUUID;
>   
> +/**
> + * @time_low: The low field of the timestamp
> + * @time_mid: The middle field of the timestamp
> + * @time_hi_and_version: The high field of the timestamp
> + *                       multiplexed with the version number
> + * @clock_seq_hi_and_reserved: The high field of the clock
> + *                             sequence multiplexed with the variant
> + * @clock_seq_low: The low field of the clock sequence
> + * @node0: The spatially unique node0 identifier
> + * @node1: The spatially unique node1 identifier
> + * @node2: The spatially unique node2 identifier
> + * @node3: The spatially unique node3 identifier
> + * @node4: The spatially unique node4 identifier
> + * @node5: The spatially unique node5 identifier
> + *
> + * This macro converts the fields of UUID to little-endian array
> + */
> +#define UUID_LE(time_low, time_mid, time_hi_and_version, \
> +  clock_seq_hi_and_reserved, clock_seq_low, node0, node1, node2, \
> +  node3, node4, node5) \
> +  { (time_low) & 0xff, ((time_low) >> 8) & 0xff, ((time_low) >> 16) & 0xff, \
> +    ((time_low) >> 24) & 0xff, (time_mid) & 0xff, ((time_mid) >> 8) & 0xff, \
> +    (time_hi_and_version) & 0xff, ((time_hi_and_version) >> 8) & 0xff, \
> +    (clock_seq_hi_and_reserved), (clock_seq_low), (node0), (node1), (node2),\
> +    (node3), (node4), (node5) }
> +
>   #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
>                    "%02hhx%02hhx-%02hhx%02hhx-" \
>                    "%02hhx%02hhx-" \
> diff --git a/slirp b/slirp
> index 2faae0f..55ab21c 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> +Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba

The SLiRP submodule change is certainly unrelated.


