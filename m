Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F34C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941F221BE5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6416Yu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941F221BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlotK-00074u-OH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlosS-00061V-Hb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:22:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42196
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlosQ-0006Co-Ut
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592464942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRrLoZeTzpvHoxIG/+cyC3AY4Bxqd7WMOjP839zfUMA=;
 b=F6416Yu1+HEGmNqHuegJRa9qrrivyNm4HpFT7bC85V/idA+mwwaQ+qYIuClcEuDfeL7TBp
 JHQBIvnrrMBquLuaSQmy5ZwYborAobPdcrG6HzLVzo7dapGf/jKeOKpeYCXpITzpboNNIa
 +WhVGZdvhqQDCMD7MBj11MZR4c0hmLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-MyD_QcCYMjGbi1z6JVAiIw-1; Thu, 18 Jun 2020 03:22:20 -0400
X-MC-Unique: MyD_QcCYMjGbi1z6JVAiIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A76C0801504;
 Thu, 18 Jun 2020 07:22:18 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C38B5D9D3;
 Thu, 18 Jun 2020 07:22:14 +0000 (UTC)
Subject: Re: [PATCH v4 7/8] tpm: Guard irq related ops in case interrupts are
 disabled
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200617142305.1198672-8-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d9c4ae07-7093-e346-03c3-086efd225c4d@redhat.com>
Date: Thu, 18 Jun 2020 09:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200617142305.1198672-8-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 philmd@redhat.com, mkedzier@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/17/20 4:23 PM, Stefan Berger wrote:
> Check for irq_num having the value of TPM_IRQ_DISABLED before calling any
> IRQ related functions or allowing the user to try to enable interrupts.
> Explicitly allow the value of TPM_IRQ_DISABLED in irq_num.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Message-id: 20200616205721.1191408-8-stefanb@linux.vnet.ibm.com
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/tpm/tpm_tis_common.c | 12 +++++++++++-
>  hw/tpm/tpm_tis_isa.c    |  6 ++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 0f42696f1f..13b233309e 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -359,7 +359,11 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
>          val = s->loc[locty].inte;
>          break;
>      case TPM_TIS_REG_INT_VECTOR:
> -        val = s->irq_num;
> +        if (s->irq_num != TPM_IRQ_DISABLED) {
> +            val = s->irq_num;
> +        } else {
> +            val = 0;
> +        }
>          break;
>      case TPM_TIS_REG_INT_STATUS:
>          val = s->loc[locty].ints;
> @@ -591,6 +595,9 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>          if (s->active_locty != locty) {
>              break;
>          }
> +        if (s->irq_num == TPM_IRQ_DISABLED) {
> +            val &= ~TPM_TIS_INT_ENABLED;
> +        }
>  
>          s->loc[locty].inte &= mask;
>          s->loc[locty].inte |= (val & (TPM_TIS_INT_ENABLED |
> @@ -601,6 +608,9 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>          /* hard wired -- ignore */
>          break;
>      case TPM_TIS_REG_INT_STATUS:
> +        if (s->irq_num == TPM_IRQ_DISABLED) {
> +            break;
> +        }
>          /* clearing of interrupt flags */
>          if (((val & TPM_TIS_INTERRUPTS_SUPPORTED)) &&
>              (s->loc[locty].ints & TPM_TIS_INTERRUPTS_SUPPORTED)) {
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 27222a9a49..d72f733ead 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -127,13 +127,15 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
>          error_setg(errp, "'tpmdev' property is required");
>          return;
>      }
> -    if (s->irq_num > 15) {
> +    if (s->irq_num > 15 && s->irq_num != TPM_IRQ_DISABLED) {
>          error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
>                     s->irq_num);
>          return;
>      }
>  
> -    isa_init_irq(ISA_DEVICE(dev), &s->irq, s->irq_num);
> +    if (s->irq_num != TPM_IRQ_DISABLED) {
> +        isa_init_irq(ISA_DEVICE(dev), &s->irq, s->irq_num);
> +    }
>  
>      memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                  TPM_TIS_ADDR_BASE, &s->mmio);
> 


