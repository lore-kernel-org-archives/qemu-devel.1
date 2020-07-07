Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76917C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B45B206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBLQnQHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B45B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jske2-0001GR-H1
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jskdE-0000aA-5a
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:15:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jskdC-0001tt-H9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594116917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ntxF86zyCTgxTRPWczFnChpYattYIeVXv6cHyagvD4I=;
 b=WBLQnQHnxeFyriloGOu675dvYg1DpFLxQjUef21vBhFww8gTJm1FmdiAiBJSXlIr8uSapB
 YbMKritmG4uPlOn+NeXOd/klhfZDAoCy20acscVlzFBlS9/MTap3xS4CVP9PP7WfbiBXls
 9uw0tp8pn+2w0cPt0QVVFQG3wXAlbIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-5fsI_buAPda24pMu0_XhSw-1; Tue, 07 Jul 2020 06:15:00 -0400
X-MC-Unique: 5fsI_buAPda24pMu0_XhSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C748005B0;
 Tue,  7 Jul 2020 10:14:59 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4756F19C58;
 Tue,  7 Jul 2020 10:14:53 +0000 (UTC)
Date: Tue, 7 Jul 2020 12:14:51 +0200
From: Andrew Jones <drjones@redhat.com>
To: Heyi Guo <guoheyi@linux.alibaba.com>
Subject: Re: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
Message-ID: <20200707101451.usrho4qbn55ffaq5@kamzik.brq.redhat.com>
References: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, yitian.ly@alibaba-inc.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 05:43:29PM +0800, Heyi Guo wrote:
> vms->psci_conduit being disabled only means PSCI is not implemented by
> qemu; it doesn't mean PSCI is not supported on this virtual machine.
> Actually vms->psci_conduit is set to disabled when vms->secure and
> firmware_loaded are both set, which means we will run ARM trusted
> firmware, which will definitely provide PSCI.
> 
> The issue can be reproduced when running qemu in TCG mode with secure
> enabled, while using ARM trusted firmware + qemu virt UEFI as firmware
> binaries, and we can see secondary cores will not be waken up.
> 
> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
> 
> ---
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/arm/virt-acpi-build.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1384a2c..7622b97 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -728,13 +728,16 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
>      };
>  
>      switch (vms->psci_conduit) {
> -    case QEMU_PSCI_CONDUIT_DISABLED:
> -        fadt.arm_boot_arch = 0;
> -        break;
>      case QEMU_PSCI_CONDUIT_HVC:
>          fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT |
>                               ACPI_FADT_ARM_PSCI_USE_HVC;
>          break;
> +    /*
> +     * QEMU_PSCI_CONDUIT_DISABLED only means PSCI is not implemented by qemu,
> +     * but typically it will still be provided by secure firmware, and it should
> +     * use SMC as PSCI conduit.
> +     */

How about elaborating on this in the comment like below?

 QEMU_PSCI_CONDUIT_DISABLED means PSCI is not implemented by QEMU. In
 this case we must have an EL3 firmware, which will most likely provide
 PSCI to the guest with the SMC conduit. If this assumption is wrong,
 then it is no worse than assuming PSCI is not available to the guest
 when it should be. The only way a user can be sure that the ACPI tables
 match what the firmware supports is if the firmware provides the ACPI
 tables itself.

> +     * but typically it will still be provided by secure firmware, and it should
> +     * use SMC as PSCI conduit.


> +    case QEMU_PSCI_CONDUIT_DISABLED:
>      case QEMU_PSCI_CONDUIT_SMC:
>          fadt.arm_boot_arch = ACPI_FADT_ARM_PSCI_COMPLIANT;
>          break;
> -- 
> 2.7.4
> 
>

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>


