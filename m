Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE83C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 10:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAC2206DB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 10:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+0ZI0Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAC2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIVSm-0000G8-KK
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 06:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jIVRz-00087w-BZ
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 06:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jIVRx-0001FE-DT
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 06:45:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jIVRx-0001DR-9w
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 06:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585478752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q8DiY1Ds79L+FkRRaCaFfXi3ZMOTrkxpTLYB+il/ThM=;
 b=U+0ZI0CqgtuA5aiafcBXCuQs4D+IC/zPn71+VKKpUGXgZTkp0r/s0axG71EUFq8e2IpydL
 pxipHVkRkXgiEloqJ28TJDATwgdwgkyeTw0rcDi+cGxtoSB/OG7iqejhMdZwbu2WyQ1ZoM
 dAJEVLoe7jRhojooqMGu1JHsJ/Zm5P8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-60QZBFnVMxahXMsUda9DPg-1; Sun, 29 Mar 2020 06:45:47 -0400
X-MC-Unique: 60QZBFnVMxahXMsUda9DPg-1
Received: by mail-wr1-f72.google.com with SMTP id e10so8283503wru.6
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 03:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lHy0uo5maeWsR0IcekV8OOGvM8S9l3Cw9gudIE8KZis=;
 b=SDOGiWOjFWSZU9EgUMJO08F0mLb1QHOiqearpsXDFX6VXWn6X/pbcWvPCxh6rBFrx2
 WJYbjIRhSK0+dOePPQq0O0Bc1BpLySRBe0ucnxNOBIovR6Ij9f1fQjG1pK0YPz40Q419
 0hdLMkDSDhd4GoaVhD2HbD4hCnZ5zJ7jQefvR6rMwWd0oB3IwA+VHQOvY8FMlSpA4Uf1
 5Uk+cN65b9l0P7516e91tukaeaShILZAcTkuA0q4kHJ+CuEBiGJz+Iu75L/nDZ4q5Nug
 ClO2BoFobd3epHvuCu7zbgzbOsPIIKKonzZUqe/XGkxUbJG+jEUxpD3QYEAlxVveURo4
 sGwA==
X-Gm-Message-State: ANhLgQ0X1n7Ll7ioF0HWEWdoY6ic2hc2MCr8GLQuFQJhHk/aNGVJQ5H+
 FlsGKkHUAzcOD8S3TXMBj2cO7tAvrq1yUju6rMmgHPnRDp+/NNKN3hy5p4acCz9QJdIMRxk7SiY
 58Q/yQMMuNYXHJKE=
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr9371234wrh.1.1585478745755;
 Sun, 29 Mar 2020 03:45:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtVSg43ss6UxGMIyyAZTXk51RoGpZs9906AuhcrRp13+kyVZSRE364KFKrP0jsSBCf5Y6wWuA==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr9371197wrh.1.1585478745423;
 Sun, 29 Mar 2020 03:45:45 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net.
 [79.183.139.129])
 by smtp.gmail.com with ESMTPSA id f187sm11477343wme.9.2020.03.29.03.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2020 03:45:44 -0700 (PDT)
Date: Sun, 29 Mar 2020 06:45:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 00/10] ARM virt: Add NVDIMM support
Message-ID: <20200329064435-mutt-send-email-mst@kernel.org>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 shannon.zhaosl@gmail.com, david@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 05:20:04PM +0000, Shameer Kolothum wrote:
> This series adds NVDIMM support to arm/virt platform.


So I'm still confused about whether there's a bugfix here
that we need for 5.0. If yes pls post just that part
with acks included and for-5.0 in the subject.

> The series reuses some of the patches posted by Eric
> in his earlier attempt here[1].
>=20
> This also include few fixes to qemu in general which were
> discovered while adding nvdimm support to arm/virt.
>=20
> Patch #2 addresses the issue[2] that, during migration, the=20
> source and destination might end up with an inconsistency
> in acpi table memory region sizes.
>=20
> Patch #3 is to fix the qemu_ram_resize() callback issue[2].
>=20
> Patch #4 is another fix to the nvdimm aml issue discussed
> here[3].
>=20
> I have done a basic sanity testing of NVDIMM devices
> with Guest booting with ACPI. Further testing is always
> welcome.
>=20
> Please let me know your feedback.
>=20
> Thanks,
> Shameer
>=20
> [1] https://patchwork.kernel.org/cover/10830777/
> [2] https://patchwork.kernel.org/patch/11339591/
> [3] https://patchwork.kernel.org/cover/11174959/
>=20
> v2 --> v3
>  - Added patch #1 and # 2 to fix the inconsistency in acpi
>    table memory region sizes during migration. Thanks to
>    David H.
>  - The fix for qemu_ram_resize() callback was modified to
>    the one in patch #3. Again thanks to David H.
>  - Addressed comments from MST and Eric on tests added.
>  - Addressed comments from Igor/MST on Integer size in patch #4
>  - Added Eric's R-by to patch #7.
>=20
> v1 --> v2
>  -Reworked patch #1 and now fix is inside qemu_ram_resize().
>  -Added patch #2 to fix the nvdim aml issue.
>  -Dropped support to DT cold plug.
>  -Updated test_acpi_virt_tcg_memhp() with pc-dimm and nvdimms(patch #7)
>=20
> David Hildenbrand (1):
>   exec: Fix for qemu_ram_resize() callback
>=20
> Kwangwoo Lee (2):
>   nvdimm: Use configurable ACPI IO base and size
>   hw/arm/virt: Add nvdimm hot-plug infrastructure
>=20
> Shameer Kolothum (7):
>   acpi: Use macro for table-loader file name
>   fw_cfg: Migrate ACPI table mr sizes separately
>   hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output buffer length
>   hw/arm/virt: Add nvdimm hotplug support
>   tests: Update ACPI tables list for upcoming arm/virt test changes
>   tests/bios-tables-test: Update arm/virt memhp test
>   tests/acpi: add expected tables for bios-tables-test
>=20
>  docs/specs/acpi_hw_reduced_hotplug.rst |   1 +
>  exec.c                                 |  14 +++-
>  hw/acpi/generic_event_device.c         |  15 ++++-
>  hw/acpi/nvdimm.c                       |  72 +++++++++++++++++----
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/virt-acpi-build.c               |   8 ++-
>  hw/arm/virt.c                          |  35 ++++++++--
>  hw/core/machine.c                      |   1 +
>  hw/i386/acpi-build.c                   |   8 ++-
>  hw/i386/acpi-build.h                   |   3 +
>  hw/i386/pc_piix.c                      |   2 +
>  hw/i386/pc_q35.c                       |   2 +
>  hw/mem/Kconfig                         |   2 +-
>  hw/nvram/fw_cfg.c                      |  86 ++++++++++++++++++++++++-
>  include/hw/acpi/aml-build.h            |   1 +
>  include/hw/acpi/generic_event_device.h |   1 +
>  include/hw/arm/virt.h                  |   1 +
>  include/hw/mem/nvdimm.h                |   3 +
>  include/hw/nvram/fw_cfg.h              |   6 ++
>  tests/data/acpi/pc/SSDT.dimmpxm        | Bin 685 -> 734 bytes
>  tests/data/acpi/q35/SSDT.dimmpxm       | Bin 685 -> 734 bytes
>  tests/data/acpi/virt/DSDT.memhp        | Bin 6644 -> 6668 bytes
>  tests/data/acpi/virt/NFIT.memhp        | Bin 0 -> 224 bytes
>  tests/data/acpi/virt/SSDT.memhp        | Bin 0 -> 736 bytes
>  tests/qtest/bios-tables-test.c         |   9 ++-
>  25 files changed, 244 insertions(+), 27 deletions(-)
>  create mode 100644 tests/data/acpi/virt/NFIT.memhp
>  create mode 100644 tests/data/acpi/virt/SSDT.memhp
>=20
> --=20
> 2.17.1
>=20


