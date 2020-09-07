Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF19C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA08521481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FonrDBLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA08521481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGbB-0005vP-Qp
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFGab-0005Fk-J3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:49:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFGaZ-0003l1-PO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599482978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0yfhYaiR6Of4IgSK3qc5KTD7ABCfgXkmEWL5Vrf02c=;
 b=FonrDBLUlGmjSR+Mi+f8/5C7Ldm/vq32RI/XqsL7/3cF7pZvtM4oNDGVyQuUKBQPukKFjm
 AfCCCVsJ2Pf1K+3z7kYLIz/8usW1K0t0qZ5bTXI30lCIaF4A84woVwP+eBptK0PLPAz+dU
 QcFVTHkAPTBD7aGUO6oy95J3+sAFu/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-2GmFwyTqOvaeF1abSCzZVw-1; Mon, 07 Sep 2020 08:49:36 -0400
X-MC-Unique: 2GmFwyTqOvaeF1abSCzZVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D5641007461;
 Mon,  7 Sep 2020 12:49:35 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-115-56.ams2.redhat.com
 [10.36.115.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65AFA10027AB;
 Mon,  7 Sep 2020 12:49:33 +0000 (UTC)
Subject: Re: [PATCH v5 06/10] x86: ich9: expose "smi_negotiated_features" as a
 QOM property
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200907112348.530921-1-imammedo@redhat.com>
 <20200907112348.530921-7-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6638eb8e-d064-c87c-c744-c440bfa2d124@redhat.com>
Date: Mon, 7 Sep 2020 14:49:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200907112348.530921-7-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: boris.ostrovsky@oracle.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 13:23, Igor Mammedov wrote:
> Expose the "smi_negotiated_features" field of ICH9LPCState as
> a QOM property.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  include/hw/i386/ich9.h | 2 ++
>  hw/isa/lpc_ich9.c      | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index d1bb3f7bf0..0f43ef2481 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -245,6 +245,8 @@ typedef struct ICH9LPCState {
>  #define ICH9_SMB_HST_D1                         0x06
>  #define ICH9_SMB_HOST_BLOCK_DB                  0x07
>  
> +#define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
> +
>  /* bit positions used in fw_cfg SMI feature negotiation */
>  #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>  #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 19f32bed3e..8124d20338 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -647,6 +647,9 @@ static void ich9_lpc_initfn(Object *obj)
>                                    &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
>      object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
>                                    &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
> +    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
> +                                   &lpc->smi_negotiated_features,
> +                                   OBJ_PROP_FLAG_READ);
>  
>      ich9_pm_add_properties(obj, &lpc->pm);
>  }
> 

Tested-by: Laszlo Ersek <lersek@redhat.com>


