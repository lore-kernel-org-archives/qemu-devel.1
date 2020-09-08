Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196DDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2CD208C7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aqw4C6s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2CD208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbFe-0003Hb-Q0
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbEt-0002eb-Uj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbEs-0003o3-Ep
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599562357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mQrCMpTrpm2Ph1NxZysYlWZwHihjh/8Y/i1cDZu2xgo=;
 b=Aqw4C6s9QK3VEXcC8LEGs1B4ohYQ/rZLK6W3IYoKTipMkXDU0yfjafl+S7zZOs/GgRWN+t
 ZUsb5YRxoRRIdRDTcm3SQLKUmrx1FQLEWcD+Ar0rMbvW2f3vPRsJMMPBbvi8GgA0dHZboX
 UMN+kEWS/0NYf8Yjp3xySNDc3BeS2dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-C7H542CsPuyyuuZNfxfdeQ-1; Tue, 08 Sep 2020 06:52:36 -0400
X-MC-Unique: C7H542CsPuyyuuZNfxfdeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F92F8797E1;
 Tue,  8 Sep 2020 10:52:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91DF25C1BB;
 Tue,  8 Sep 2020 10:52:33 +0000 (UTC)
Date: Tue, 8 Sep 2020 12:52:30 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 04/12] target/arm: spe: Only enable SPE from 5.2
 compat machines.
Message-ID: <20200908105230.4c4ddlvspfjknftr@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <7ed8b1ff7a61132c6520f87213c61784ab0c331b.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <7ed8b1ff7a61132c6520f87213c61784ab0c331b.1599549462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
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
Cc: philmd@redhat.com, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 08:13:22AM +0000, Haibo Xu wrote:
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  hw/arm/virt.c         | 7 +++++++
>  include/hw/arm/virt.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index acf9bfbece..3f6d26c531 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1830,6 +1830,10 @@ static void machvirt_init(MachineState *machine)
>              object_property_set_bool(cpuobj, "pmu", false, NULL);
>          }
>  
> +        if (vmc->no_spe && object_property_find(cpuobj, "spe", NULL)) {
> +            object_property_set_bool(cpuobj, "spe", false, NULL);
> +        }
> +
>          if (object_property_find(cpuobj, "reset-cbar", NULL)) {
>              object_property_set_int(cpuobj, "reset-cbar",
>                                      vms->memmap[VIRT_CPUPERIPHS].base,
> @@ -2553,8 +2557,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
>  
>  static void virt_machine_5_1_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_5_2_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
> +    vmc->no_spe = true;
>  }
>  DEFINE_VIRT_MACHINE(5, 1)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index dff67e1bef..72c269aaa5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -126,6 +126,7 @@ typedef struct {
>      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
>      bool kvm_no_adjvtime;
>      bool acpi_expose_flash;
> +    bool no_spe;
>  } VirtMachineClass;
>  
>  typedef struct {
> -- 
> 2.17.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 


