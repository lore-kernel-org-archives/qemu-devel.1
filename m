Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4AAC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2444322200
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3B6W+5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2444322200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvI2V-0005fo-FP
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvI1l-0004s1-Ry
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:19:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jvI1k-0007Vw-5R
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594721947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LvpYWxjVdPU0d2niPqharpcsXWtHlRqwcQS2eJqHEsQ=;
 b=g3B6W+5PHHOahyAw9IYwo7IWrn+0LPfXe+kI5JbLi8DfuJp2xoTTIKsLK+PrO3NvGyP9/Y
 7YEp+c7tmtjVHieGkm06FAesjnX14ZiOCCbiaW5bjVoPm8f6lSSuXrSu56P0Jz1jehn5aV
 J63uelDFCKdbzagtdRccIRcFmgrx17c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-4MzLeKn9MeOIje9vrXbF0g-1; Tue, 14 Jul 2020 06:19:05 -0400
X-MC-Unique: 4MzLeKn9MeOIje9vrXbF0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5236E1B2C984;
 Tue, 14 Jul 2020 10:19:04 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-110.ams2.redhat.com
 [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F09F2DE80;
 Tue, 14 Jul 2020 10:19:02 +0000 (UTC)
Subject: Re: [RFC 1/3] x86: lpc9: let firmware negotiate CPU hotplug SMI
 feature
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-2-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <470ed90d-6d2d-83b6-b9ce-c23e427ff2ba@redhat.com>
Date: Tue, 14 Jul 2020 12:19:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710161704.309824-2-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/20 18:17, Igor Mammedov wrote:
> It will allow firmware to notify QEMU that firmware requires SMI
> being triggered on CPU hotplug, so that it would be able to account
> for hotplugged CPU and relocate it to new SMM base.
>
> Using the negotiated feature, follow up patches will insert SMI upcall
> into AML code, to make sure that firmware processes hotplug before
> guest OS would attempt to use new CPU.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/i386/ich9.h | 1 +
>  hw/i386/pc.c           | 4 +++-
>  hw/isa/lpc_ich9.c      | 7 +++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index a98d10b252..422891a152 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -247,5 +247,6 @@ typedef struct ICH9LPCState {
>
>  /* bit positions used in fw_cfg SMI feature negotiation */
>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
> +#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
>
>  #endif /* HW_ICH9_H */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d7f27bc16b..6fe80c84d7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -97,7 +97,9 @@
>  #include "fw_cfg.h"
>  #include "trace.h"
>
> -GlobalProperty pc_compat_5_0[] = {};
> +GlobalProperty pc_compat_5_0[] = {
> +    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
> +};
>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
>
>  GlobalProperty pc_compat_4_2[] = {
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index cd6e169d47..83da7346ab 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -373,6 +373,11 @@ static void smi_features_ok_callback(void *opaque)
>          /* guest requests invalid features, leave @features_ok at zero */
>          return;
>      }
> +    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
> +        guest_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT)) {
> +        /* cpu hotplug SMI requires SMI broadcast, leave @features_ok at zero */
> +        return;
> +    }
>
>      /* valid feature subset requested, lock it down, report success */
>      lpc->smi_negotiated_features = guest_features;
> @@ -747,6 +752,8 @@ static Property ich9_lpc_properties[] = {
>      DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
>      DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
>                        ICH9_LPC_SMI_F_BROADCAST_BIT, true),
> +    DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
> +                      ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>

This patch looks good to me:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

However I'd suggest that we introduce ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT
at once (bit position 2). We don't have to handle it for real, but we
should catch it in patch#2, and reject it gracefully.

For that, the property would be called "x-smi-cpu-hot-unplug", and the
error check in smi_features_ok_callback() would go like:

    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
        guest_features & (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
                          BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
        /* either one of the "CPU hotplug with SMI" and "CPU hot-unplug
         * with SMI" features requires SMI broadcast; leave @features_ok
         * at zero
         */
        return;
    }

The reason I'm suggesting catching LPC_SMI_F_CPU_HOT_UNPLUG_BIT at once
is that people will inevitably try to un-plug, when they see plug
succeed. The firmware itself does catch the (as yet unimplemented)
un-plug attempt, but the way the firmware fails is not -- cannot be --
graceful. It hangs, intentionally.

Failing the device_del QMP command is more graceful.

(For this series, I'll provide test results once I've read the patches.)

Thanks!
Laszlo


