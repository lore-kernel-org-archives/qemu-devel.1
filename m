Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA2C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1AD206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeBX8LiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1AD206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNbw-0003QC-2Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTNZh-0001e0-VY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTNZg-0002d2-M1
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:34:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jTNZg-0002T9-46
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588070086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcXSHJlO6VB+UzxHJHspmsvLtz82Ki+Jm/9V2p6dgto=;
 b=DeBX8LiIKxjC+Y3JNrQ3cOYiUYwBe99Q8uOpIHo9xrbNVlHboPgxjkcYEOXDVvd8miqtM6
 /xpCH5+KYll9zsGC+orkCWPhzL7QFKURaerZ3vw41xVYUKQHizoFgDffD45/vPa2XdnlYR
 qPUf8Qvxqj+nQBY/tULrTvALFEeFZK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-Ch0k9yhxO_qBiGsUqf7KUA-1; Tue, 28 Apr 2020 06:34:44 -0400
X-MC-Unique: Ch0k9yhxO_qBiGsUqf7KUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63DBD80058A;
 Tue, 28 Apr 2020 10:34:43 +0000 (UTC)
Received: from gondolin (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C535E614CC;
 Tue, 28 Apr 2020 10:34:39 +0000 (UTC)
Date: Tue, 28 Apr 2020 12:34:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] tpm: tpm-tis-device: set PPI to false by default
Message-ID: <20200428123436.75432a8e.cohuck@redhat.com>
In-Reply-To: <20200427143145.16251-2-eric.auger@redhat.com>
References: <20200427143145.16251-1-eric.auger@redhat.com>
 <20200427143145.16251-2-eric.auger@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, eric.auger.pro@gmail.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 16:31:44 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> The tpm-tis-device device does not support PPI. Let's
> change the default value for the corresponding property
> instead of tricking this latter in the mach-virt machine.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/tpm/tpm_tis_sysbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 18c02aed67..eced1fc843 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -91,7 +91,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>  static Property tpm_tis_sysbus_properties[] = {
>      DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>      DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> -    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
> +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  

This looks like a better place to do this than in the virt compat
machines, and should get us the same result, leaving compatibility
intact.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


