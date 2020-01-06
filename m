Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A3C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3E32072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REgBQpno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3E32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioPD2-0000WW-T2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ioPBY-00084E-4O
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ioPBW-00068x-Hl
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:00:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ioPBW-00068X-DM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578304829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXDseerrTnQAS+optAxJ4Tq6lcEO1k1dhBz3QITb/JM=;
 b=REgBQpnoGGTit8O2kErjwuAO3XukZgjC9EAiKdG/one6+6UoTUIivknbKUZ+mUWdLkK02Z
 rCm6oQzRqqy958ay6AjsLcmsG0FNeHI4xFbT7C5ISA5Y642hA5yI3QkV3QidDz+TnUMrjy
 pMbsqeIvrlinFp4begCMPPwW0KG3Eqk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-8N8o_SHYMBq9AP8MamyykQ-1; Mon, 06 Jan 2020 05:00:24 -0500
Received: by mail-qt1-f197.google.com with SMTP id c8so33948138qte.22
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 02:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kD65xoib/h01wy8kKXXRgOUJBlFyNby9c3l4YcMxoyI=;
 b=NSQBRtjt0qNyV102qLz5q7lIJRydVdWZxEEASSId2EDAt9U0QLpy6AW6BjJ+pi4Q6V
 Xq2UJao98PWybDEf0du9GgllMNTKEQbg6dhSoP/gGRXBaPjDyT2spuol+bV0C2yBuK3/
 mXg2h9KbeZj1ly++1muv7DmyvbEvcCqlLcGDpG9tQ4ZYw54ddR4uG0l8yH4YQ3q2+8I8
 qz8jVvErB4kas7sY2hMpv1NNChuF4cIlcMKlNFd/i5hLeU6q00G/EEN5FKDzS3+AtlMa
 kiP0nBpGzZvWw0sQo0Z5XESN4qY7h0dGmZ6lewCVQZdVNauEfaF242/BMVxdVoGuE3WC
 bu1A==
X-Gm-Message-State: APjAAAWZtY+Je/454IAozHDlJzAFamh/2nMSIAUpk08SUvVPKWDkXLB0
 byfF4LYP5kqxQgVUBFX4Umbova30Qoe7Le1Qox3qz+87ZK0rlmQcBb/8nff37LVRhbgKkcodGI9
 MF4WmMZEeN2TmTu0=
X-Received: by 2002:a0c:eed2:: with SMTP id h18mr78913658qvs.184.1578304824068; 
 Mon, 06 Jan 2020 02:00:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjgKj6bbZQS4uCSrt36jSIbKfIOxrTt9sUSXeCe4R75O/xcjog8vyl3SNy7YSfgpkeckG7yA==
X-Received: by 2002:a0c:eed2:: with SMTP id h18mr78913638qvs.184.1578304823797; 
 Mon, 06 Jan 2020 02:00:23 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id k21sm22803527qtp.92.2020.01.06.02.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 02:00:23 -0800 (PST)
Date: Mon, 6 Jan 2020 05:00:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] hw/i386: Allow building machines without IOMMU
Message-ID: <20200106045952-mutt-send-email-mst@kernel.org>
References: <20191227213931.6286-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191227213931.6286-1-philmd@redhat.com>
X-MC-Unique: 8N8o_SHYMBq9AP8MamyykQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 27, 2019 at 10:39:31PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Commit 6c730e4af9 introduced a stub to build the MicroVM machine
> without Intel IOMMU suppport. However when configure with
> --without-default-devices, the build fails:
>=20
>     LINK    x86_64-softmmu/qemu-system-x86_64
>   /usr/bin/ld: hw/i386/pc.o: in function `pc_machine_done':
>   hw/i386/pc.c:869: undefined reference to `x86_iommu_ir_supported'
>   /usr/bin/ld: hw/i386/acpi-build.o: in function `acpi_build':
>   hw/i386/acpi-build.c:2844: undefined reference to `x86_iommu_get_type'
>   /usr/bin/ld: hw/i386/acpi-build.o: in function `build_dmar_q35':
>   hw/i386/acpi-build.c:2478: undefined reference to `x86_iommu_ir_support=
ed'
>   /usr/bin/ld: hw/i386/acpi-build.o: in function `build_amd_iommu':
>   hw/i386/acpi-build.c:2665: undefined reference to `x86_iommu_ir_support=
ed'
>   /usr/bin/ld: hw/i386/acpi-build.c:2700: undefined reference to `x86_iom=
mu_ir_supported'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>=20
> Since currently all PC machines can not be built without IOMMU,
> select X86_IOMMU in the PC config, and remove the stubs.
>=20
> Fixes: 6c730e4af9
> Reported-by: Travis-CI
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'd rather Paolo applied this in his tree.

> ---
> v2: simplify, remove the stub.
> ---
>  hw/i386/x86-iommu-stub.c | 34 ----------------------------------
>  hw/i386/Kconfig          |  2 +-
>  hw/i386/Makefile.objs    |  1 -
>  3 files changed, 1 insertion(+), 36 deletions(-)
>  delete mode 100644 hw/i386/x86-iommu-stub.c
>=20
> diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
> deleted file mode 100644
> index 03576cdccb..0000000000
> --- a/hw/i386/x86-iommu-stub.c
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * Stubs for X86 IOMMU emulation
> - *
> - * Copyright (C) 2019 Red Hat, Inc.
> - *
> - * Author: Paolo Bonzini <pbonzini@redhat.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> -
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> -
> - * You should have received a copy of the GNU General Public License alo=
ng
> - * with this program; if not, see <http://www.gnu.org/licenses/>.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "hw/i386/x86-iommu.h"
> -
> -void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
> -                                     iec_notify_fn fn, void *data)
> -{
> -}
> -
> -X86IOMMUState *x86_iommu_get_default(void)
> -{
> -    return NULL;
> -}
> -
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 91cf5843b4..e428322a2c 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -35,6 +35,7 @@ config PC
>      select ACPI_PCI
>      select ACPI_VMGENID
>      select VIRTIO_PMEM_SUPPORTED
> +    select X86_IOMMU
> =20
>  config PC_PCI
>      bool
> @@ -105,7 +106,6 @@ config MICROVM
> =20
>  config X86_IOMMU
>      bool
> -    depends on PC
> =20
>  config VTD
>      bool
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 8ce1b26533..6ebb6d0cf0 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -7,7 +7,6 @@ obj-$(CONFIG_Q35) +=3D pc_q35.o
>  obj-$(CONFIG_MICROVM) +=3D microvm.o
>  obj-y +=3D fw_cfg.o
>  obj-$(CONFIG_X86_IOMMU) +=3D x86-iommu.o
> -obj-$(call lnot,$(CONFIG_X86_IOMMU)) +=3D x86-iommu-stub.o
>  obj-$(CONFIG_VTD) +=3D intel_iommu.o
>  obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
>  obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
> --=20
> 2.21.0


