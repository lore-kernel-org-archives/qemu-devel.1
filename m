Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEADC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA39021548
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGWhpRWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39021548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jloyX-0001YS-0n
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jloxY-00014e-I0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:27:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jloxW-00071U-Vh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592465258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKl0PlTej8CjPv4/fq4wgtE9bm9X0gX1aHE1GWShMlw=;
 b=RGWhpRWO+Nm208Fs7Kv4iBExo8FlT6w2bAqmybQiHbn0upkMbha3dSoHoKNyU6C6+iPInJ
 3BjJponhSxmXWR2pBgAt/XcyR9rjshczu6JlZA6pYcCWjLS2EyevVKTZ27EZibYYJi8Iq3
 FVWAJsVYbKlgrWYUj0GoZRrfj5x+PDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-jucyi6jXNmSxpKKCxWgJVA-1; Thu, 18 Jun 2020 03:27:34 -0400
X-MC-Unique: jucyi6jXNmSxpKKCxWgJVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34781464;
 Thu, 18 Jun 2020 07:27:33 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED56760BF3;
 Thu, 18 Jun 2020 07:27:28 +0000 (UTC)
Subject: Re: [PATCH v4 0/8] tpm: Enable usage of TPM TIS with interrupts
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c6824bc7-209b-f264-a5b0-2dbc6119773c@redhat.com>
Date: Thu, 18 Jun 2020 09:27:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, philmd@redhat.com, mkedzier@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/17/20 4:22 PM, Stefan Berger wrote:
> This series of patches enables the usage of the TPM TIS with interrupts.
> We use the unused IRQ 13, which is the only one accepted by Windows.
> 
>     Stefan
> 
> v3->v4:
>  - Changed TPM_IRQ_DISABLED from -1 to ~0
> 
> v2->v3:
>  - Extended series to disable IRQ for TIS on sysbus
> 
> v1->v2:
>  - Added updated DSDT
> 
> Stefan Berger (8):
>   tpm_tis: Allow lowering of IRQ also when locality is not active
>   tpm: Extend TPMIfClass with get_irqnum() function
>   tests: Temporarily ignore DSDT table differences
>   tpm: Split TPM_TIS_IRQ into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS_IRQ
>   acpi: Enable TPM IRQ
>   tests: Add updated DSDT
>   tpm: Guard irq related ops in case interrupts are disabled
>   tpm: Disable interrupt support for TIS on sysbus
> 
>  hw/i386/acpi-build.c         |  11 +++++------
>  hw/tpm/tpm_tis_common.c      |  12 +++++++++---
>  hw/tpm/tpm_tis_isa.c         |  17 ++++++++++++++---
>  hw/tpm/tpm_tis_sysbus.c      |  12 +++++++++++-
>  include/hw/acpi/tpm.h        |   3 ++-
>  include/sysemu/tpm.h         |  12 ++++++++++++
>  tests/data/acpi/q35/DSDT.tis | Bin 8357 -> 8360 bytes
>  7 files changed, 53 insertions(+), 14 deletions(-)
> 
I checked this series does not bring any regression on ARM TPM-TIS
device. So if useful/relevant, feel free to add my T-b from the ARM pov.

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


