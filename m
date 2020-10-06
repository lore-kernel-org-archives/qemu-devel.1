Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B5C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516AD206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9u2uXtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516AD206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjrm-00035o-Bo
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPjqS-0001ji-Am
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPjqQ-000573-E5
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601978717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrblmXBARzc9SOzmVezVfLhBelLQC35BvSdrmk3nDlA=;
 b=X9u2uXtwquxgsPii6W3DtC8ZTci2+CLrch8ShP7UfMEmYBa6eA7oDB1F/zMBO2X+0Wz5++
 /zXzqxOGylNXrT/0qpAlZL0xcdNBD/idVq8tGwDlZ4vkiTdlv79KMYgrqXrOx/ra4cTdgM
 SwJwZLmP5ZgnE9LWZJs2t4JcGSp4KSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128--OEqxv9qOQ-17xYSyGtzzw-1; Tue, 06 Oct 2020 06:05:13 -0400
X-MC-Unique: -OEqxv9qOQ-17xYSyGtzzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13EF100F7C8;
 Tue,  6 Oct 2020 10:05:09 +0000 (UTC)
Received: from localhost (unknown [10.40.208.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DE3B10001B3;
 Tue,  6 Oct 2020 10:05:07 +0000 (UTC)
Date: Tue, 6 Oct 2020 12:05:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2] hw/arm: Restrict APEI tables generation to the
 'virt' machine
Message-ID: <20201006120506.115c7f9c@redhat.com>
In-Reply-To: <20201001162207.1566127-1-philmd@redhat.com>
References: <20201001162207.1566127-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Dongjiu Geng <gengdongjiu@huawei.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  1 Oct 2020 18:22:07 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> While APEI is a generic ACPI feature (usable by X86 and ARM64), only
> the 'virt' machine uses it, by enabling the RAS Virtualization. See
> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").
>=20
> Restrict the APEI tables generation code to the single user: the virt
> machine. If another machine wants to use it, it simply has to 'select
> ACPI_APEI' in its Kconfig.
>=20
> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardw=
are error fw_cfg blob")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v2: Reworded
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 -
>  hw/arm/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index 9a94ebd0be..08a32123b4 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=3Dy
>  CONFIG_FSL_IMX6UL=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ALLWINNER_H3=3Dy
> -CONFIG_ACPI_APEI=3Dy
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index f303c6bead..7d040827af 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -26,6 +26,7 @@ config ARM_VIRT
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
>      select ACPI_NVDIMM
> +    select ACPI_APEI
> =20
>  config CHEETAH
>      bool


