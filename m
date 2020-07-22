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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB832065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT4o6dUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB832065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyEcY-0005PI-VJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyEbk-0004gv-Tl
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:16:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyEbi-0007sz-Bu
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595423784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlEAg3SJ++QZhnYTOLRaDpuzktWX3hIhrQ9En2XLx9k=;
 b=bT4o6dUd1KEmwoJsy9dEpl856++3S+wjN3ZqRP7yU72RydYb4GOUHLcscrz+8gRwdKpVD+
 o785tjcjYcRBDBnbiG9cG52LWT7X57NcjIFrgqCt8BlLZw6Glc7wXhcWSSKjmwA7zCigOw
 F9762KpQzBg1C5Tdt1RkTSTBTUjMcJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-8wvn4lsjNl2TZwJcgjQMKA-1; Wed, 22 Jul 2020 09:16:22 -0400
X-MC-Unique: 8wvn4lsjNl2TZwJcgjQMKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B380A1005510;
 Wed, 22 Jul 2020 13:16:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-129.ams2.redhat.com
 [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D67572B5BE;
 Wed, 22 Jul 2020 13:16:20 +0000 (UTC)
Subject: Re: [PATCH 2/6] x86: cphp: prevent guest crash on CPU hotplug when
 broadcast SMI is in use
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200720141610.574308-1-imammedo@redhat.com>
 <20200720141610.574308-3-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <68fb60b1-d22e-efad-8a8b-6b1f94c6e85f@redhat.com>
Date: Wed, 22 Jul 2020 15:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200720141610.574308-3-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: boris.ostrovsky@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/20/20 16:16, Igor Mammedov wrote:
> There were reports of guest crash on CPU hotplug, when using q35 machine
> type and OVMF with SMM, due to hotplugged CPU trying to process SMI at
> default SMI handler location without it being relocated by firmware first.
> 
> Fix it by refusing hotplug if firmware hasn't negotiated CPU hotplug with
> SMI support while SMI broadcast is in use.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v1:
>    fix typos an use suggested wording in commit and error msg
>    s/secure boot/smm/; s/hotplug SMI/hotplug with SMI/
>       (Laszlo Ersek <lersek@redhat.com>)
> ---
>  hw/acpi/ich9.c | 12 +++++++++++-
>  hw/i386/pc.c   | 11 +++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 6a19070cec..0acc9a3107 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -408,10 +408,20 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> -        !lpc->pm.acpi_memory_hotplug.is_enabled)
> +        !lpc->pm.acpi_memory_hotplug.is_enabled) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: %s.memory-hotplug-support "
>                     "is not set", object_get_typename(OBJECT(lpc)));
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +        uint64_t negotiated = lpc->smi_negotiated_features;
> +
> +        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
> +            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
> +            error_setg(errp, "cpu hotplug with SMI wasn't enabled by firmware");
> +            error_append_hint(errp, "update machine type to newer than 5.1 "
> +                "and firmware that suppors CPU hotplug with SMM");
> +        }
> +    }
>  }
>  
>  void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 57d50fad6b..3f4b7e3d9a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1497,6 +1497,17 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    if (pcms->acpi_dev) {
> +        Error *local_err = NULL;
> +
> +        hotplug_handler_pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> +                                 &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      init_topo_info(&topo_info, x86ms);
>  
>      env->nr_dies = x86ms->smp_dies;
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>


