Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EEBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FD320721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKa2a8kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FD320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLaR-00033T-JM
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jKLZh-0002Us-9X
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jKLZf-00037m-Lu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:37:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jKLZf-00037S-Da
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585917446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dd1gkcBsl4njgioJ3kCx8Bc/7yuYJ5E+utr3qgh6SW4=;
 b=CKa2a8kJJMxmuh47t2tFfYaLuZdhczYmLqNkoQYXtb6RfUDCP+Lhd52OT/8t+dUHyC2S3O
 cixUNboLZj2nQ/8gvGLefIPW5smM9iEfTkq+uW96FSsNO4PujB/Y2w3oAvOFO2m3Qlqv01
 LgUyD/BIpUQmPBBUWVXXIDg/z0yUyao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-e-4DvIHONW-D6hg_bTnzSQ-1; Fri, 03 Apr 2020 08:37:19 -0400
X-MC-Unique: e-4DvIHONW-D6hg_bTnzSQ-1
Received: by mail-wm1-f71.google.com with SMTP id z24so1987966wml.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1OMInO7xK8SDssDQloHnMaMaMNNBWAVLV22fE4/2ta4=;
 b=fQUoFnh5/bMBvtABAmjcZ6WHJAD8IjZjEJGgp/4vLW8IHm2iW7ffgnv82I95LDoV7U
 Rj97yYElIVV7cBCawCgVYatBxZlGCILhByFwDkBWGd3+BsZm6gtVLEMAJOgTr5gN/mfW
 1v89Xr2fG8R0vEWRSsfHbcNNGoEdN648XmpZ5Vc5eSTaNxtSXcTRd3KMBolAjrEts7vX
 gE1J38oI8HhIZ6ZI3IuHaSy1i4/suliyjdJSpEznP38GOqkNZd2eaB9otiTWrz6Vw9qg
 4w7tQvG9MJrxTGqMPTf/0tPpWyJJzcj7Pr1I0XCGmQMaJtPsil4zOJ0gUQ/r1IBXtjgw
 FlmA==
X-Gm-Message-State: AGi0Pua4zmhNxaO3LQM51zGTyzvdxmYKlRv3GxAlwhzVDD7beAus29mS
 AOVaHz9p8Acl4srDvybQxUW1EUrn3S1DDEGQ7pCVr/H5N4lLJu0FKxmC2IzhGDJM8TZNsKeFzsX
 vrk099X0D4PXeJvg=
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr8452791wme.88.1585917438565; 
 Fri, 03 Apr 2020 05:37:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypK5BgjNHY68i/NMHonlX9o7WtUdpXblyviYKgKFA2uaokzcToIH7QJqMXjzAc3Z6Kz2C/hwNA==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr8452762wme.88.1585917438336; 
 Fri, 03 Apr 2020 05:37:18 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id i1sm11592848wrq.89.2020.04.03.05.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 05:37:17 -0700 (PDT)
Date: Fri, 3 Apr 2020 08:37:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH for-5.0 v2 0/3] acpi: Fixes for inconsistency in ACPI MR
 size during migration
Message-ID: <20200403083639-mutt-send-email-mst@kernel.org>
References: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, david@redhat.com, linuxarm@huawei.com,
 qemu-devel@nongnu.org, xuwei5@hisilicon.com, dgilbert@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 03, 2020 at 11:18:24AM +0100, Shameer Kolothum wrote:
> This is to fix few issues discovered while adding NVDIMM hot-add
> support to arm/virt. These were previously part of [1] and since
> the fixes are generic in nature and might be an issue in x86 as
> well, they are being treated separately now.

OK I'll queue this unless someone has any objections.

> 1. https://patchwork.kernel.org/patch/11432371/
>=20
> v1 --> V2
>  - patch #2, Addressed comments from Dave and MST
>=20
> Updates from [1]:
>  -Added R-by and A-by tags.
>  -Edited commit log for patch#2
>  -Updated patch#3 as per David's comment
>=20
> David Hildenbrand (1):
>   exec: Fix for qemu_ram_resize() callback
>=20
> Shameer Kolothum (2):
>   acpi: Use macro for table-loader file name
>   fw_cfg: Migrate ACPI table mr sizes separately
>=20
>  exec.c                      | 16 ++++++-
>  hw/arm/virt-acpi-build.c    |  2 +-
>  hw/core/machine.c           |  1 +
>  hw/i386/acpi-build.c        |  2 +-
>  hw/nvram/fw_cfg.c           | 91 ++++++++++++++++++++++++++++++++++++-
>  include/hw/acpi/aml-build.h |  1 +
>  include/hw/nvram/fw_cfg.h   |  6 +++
>  7 files changed, 114 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.17.1
>=20


