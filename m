Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C104C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E992521D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abtkQcFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E992521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8Pa-0005OX-Eh
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kL8OB-0004QE-Jj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kL8O9-0008QH-1S
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600881423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjCF9ptWD0W1xEXfZ/jrTxxAL1nv94hRaxICd3hLf+k=;
 b=abtkQcFoe5w3ZVzd1fVMQTrjw1pq1VycW8GFvS4quaGiM6ArtnlblspqoBzTG5y7K76Ipo
 sWDDIScIHjyFviqrE33XDcXyiD3aZ5H0rq91S4iRd4LWzFxWbzmYRWVE9y19vHtaO+3fuc
 pTxaGdpcagNyx4wPHAHlLOWvA4Q79RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-7EEiUxnXN9iiz11lxdJhXg-1; Wed, 23 Sep 2020 13:17:01 -0400
X-MC-Unique: 7EEiUxnXN9iiz11lxdJhXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1384107464E;
 Wed, 23 Sep 2020 17:16:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-233.ams2.redhat.com
 [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9F0219728;
 Wed, 23 Sep 2020 17:16:55 +0000 (UTC)
Subject: Re: [PATCH v6 02/11] x86: cpuhp: prevent guest crash on CPU hotplug
 when broadcast SMI is in use
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200923094650.1301166-1-imammedo@redhat.com>
 <20200923094650.1301166-3-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <14908b1b-48bb-3f8e-8b8f-1c6c1611ab8b@redhat.com>
Date: Wed, 23 Sep 2020 19:16:54 +0200
MIME-Version: 1.0
In-Reply-To: <20200923094650.1301166-3-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: ankur.a.arora@oracle.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/23/20 11:46, Igor Mammedov wrote:
> There were reports of guest crash on CPU hotplug, when using q35 machine
> type and OVMF with SMM, due to hotplugged CPU trying to process SMI at
> default SMI handler location without it being relocated by firmware first.
> 
> Fix it by refusing hotplug if firmware hasn't negotiated CPU hotplug with
> SMI support while SMI broadcast is in use.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v6:
>   - rebase on top of current master, due to non trivial conflicts
>     caused by microvm series, which moved/renamed pc_cpu_pre_plug()
>     (Ankur Arora <ankur.a.arora@oracle.com>)

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> v1:
>    fix typos an use suggested wording in commit and error msg
>    s/secure boot/smm/; s/hotplug SMI/hotplug with SMI/
>       (Laszlo Ersek <lersek@redhat.com>)
> ---
>  hw/acpi/ich9.c | 12 +++++++++++-
>  hw/i386/x86.c  | 11 +++++++++++
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
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index c2ea989579..403c2b1dad 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -279,6 +279,17 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> +    if (x86ms->acpi_dev) {
> +        Error *local_err = NULL;
> +
> +        hotplug_handler_pre_plug(HOTPLUG_HANDLER(x86ms->acpi_dev), dev,
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


