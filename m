Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E694C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106C2206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDzhipq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106C2206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFlY-0004Zf-Rg
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kOFkC-00041N-CS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kOFkA-0004gD-BC
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601624680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhNG1lwKb9aJUlPmfadzErQUZnjytMcR3uJSisWbXaA=;
 b=RDzhipq5QaifRAv1hgIn+88DRDAXPTgo8UUpQphiTGPl8xgTG3c1nN/EE6VH8TA9ut9jXg
 QP7mkuFXvQffY581P4aPHpyU9FNlA3IsSIuRi12NEgTuhYWTIEs1BYiV6JmDpHQsl3rCij
 IoRczXZcZVszBd147LIGW522nZn8cxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-EIbsXZV9OIapX1eE8YTnIQ-1; Fri, 02 Oct 2020 03:44:38 -0400
X-MC-Unique: EIbsXZV9OIapX1eE8YTnIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE823188C142;
 Fri,  2 Oct 2020 07:44:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-188.ams2.redhat.com
 [10.36.113.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA51A619B5;
 Fri,  2 Oct 2020 07:44:27 +0000 (UTC)
Subject: Re: [PATCH v2] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201001162207.1566127-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ffeb8263-5c7a-8472-62c8-ebaeb410f429@redhat.com>
Date: Fri, 2 Oct 2020 09:44:27 +0200
MIME-Version: 1.0
In-Reply-To: <20201001162207.1566127-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/20 18:22, Philippe Mathieu-Daudé wrote:
> While APEI is a generic ACPI feature (usable by X86 and ARM64), only
> the 'virt' machine uses it, by enabling the RAS Virtualization. See
> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").
> 
> Restrict the APEI tables generation code to the single user: the virt
> machine. If another machine wants to use it, it simply has to 'select
> ACPI_APEI' in its Kconfig.
> 
> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Reworded
> 
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 -
>  hw/arm/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 9a94ebd0be..08a32123b4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
>  CONFIG_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
> -CONFIG_ACPI_APEI=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f303c6bead..7d040827af 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -26,6 +26,7 @@ config ARM_VIRT
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
>      select ACPI_NVDIMM
> +    select ACPI_APEI
>  
>  config CHEETAH
>      bool
> 

Acked-by: Laszlo Ersek <lersek@redhat.com>


