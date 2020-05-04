Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A930C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 05:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BA120735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 05:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIB6cKrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BA120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVTRU-0007tu-5i
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 01:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVTQY-00071a-Ll
 for qemu-devel@nongnu.org; Mon, 04 May 2020 01:14:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVTQX-0008Ns-Sn
 for qemu-devel@nongnu.org; Mon, 04 May 2020 01:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588569240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7WTJ5RKuUhGf6Q3b2DcGRPpfKLM81fW7ZqFfBymxmo=;
 b=JIB6cKrGpw46PQqeQgg8XK+at+ioUUM2G8yhr18m6rzj8DPZDi4gIFqSXxh+SpA45pVAs9
 7Ppl6CcQDoH9cVz1688j35tcvqET8aGq6q87TlEpK6OSO75j3KOd4Qzaes+9PJVbVs+9m4
 21lfjbhzklUQYfNN6gDdDvCQZhN7KOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-ar4qn99cOrCI5eQcfCtepg-1; Mon, 04 May 2020 01:13:50 -0400
X-MC-Unique: ar4qn99cOrCI5eQcfCtepg-1
Received: by mail-wr1-f72.google.com with SMTP id o6so2767489wrn.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 22:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GgWpv3lJzZ6vzSp1N9aF4A77CBI5ISRWAJFVtv0cZms=;
 b=gbGFJBoaQld3JZ2Geb0i1W5u5OY/ZXxJtE9BIU+95YV8V7YkUPpQvJ/M5MSe6uia/o
 RKXSxzrYWOXLwWr77gCXFAM0+6frnLmcCAP06Lat6/YjNLEIR9/NbqaEM5A1cnj14PI2
 sNxTJMllXFdXKhuwe7MmZwknE7DyoNwXT6WDDqMbYraq1D/LnbVaCadEgLIfbomZpxI0
 aHxfWkmknQY3ctd22rbGlJmuxjp29qlvyxN48BGm1XRRm/tvAH5Iox8O0KgrllN5YNth
 hmMWPrEuYJ3w9+1bCLhkcJ8dPfTobGCHy9vMrI8NTjAIeHcGUNU+Y49SJox+npWFbBNu
 rg+Q==
X-Gm-Message-State: AGi0Pub30j++9oOZCLbDv9PlsUxN+FyUy5xJUNSanZ0A5+NL8+e15EwD
 m4ymQTgJpjG+GLC2vJ3gcoPNi1Vs0BZX48mwo3WrH9Z14LfYc66IatI1mIzcgbfZHgjGjyFVLhH
 7orXAjBES0c9Z1Vo=
X-Received: by 2002:a1c:9852:: with SMTP id a79mr12328517wme.27.1588569229505; 
 Sun, 03 May 2020 22:13:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVmuEK7xs8e2ijj5Nq1DPAkArNMGe/n6/5czXEvC3jRBdOVex5eygr/3c7G4VP8Gq21RSVeA==
X-Received: by 2002:a1c:9852:: with SMTP id a79mr12328491wme.27.1588569229259; 
 Sun, 03 May 2020 22:13:49 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 w10sm18236963wrg.52.2020.05.03.22.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2020 22:13:48 -0700 (PDT)
Date: Mon, 4 May 2020 01:13:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
Message-ID: <20200504011252-mutt-send-email-mst@kernel.org>
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:14:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 prime.zeng@hisilicon.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 01:59:27PM +0100, Shameer Kolothum wrote:
> This series adds NVDIMM support to arm/virt platform.
> The series reuses some of the patches posted by Eric
> in his earlier attempt here[1].
>=20
> This series previously had few fixes to qemu in general
> which were discovered while adding nvdimm support to arm/virt.
> Those were sent out seperately[2] and are now part of Qemu.


Mostly ACPI stuff so I can merge it if I get an ack for ARM side.

Alternatively, for ACPI things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> Patch #1 is another fix to the nvdimm aml issue discussed
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
> [2] https://patchwork.kernel.org/cover/11472501/
> [3] https://patchwork.kernel.org/cover/11174959/#23020961
>=20
> v3 --> v4
>  -Removed patches #1 to #3 from v3 as they are now part of Qemu.
>  -Addressed comments from Igor(#6) and Shannon(#4).
>  -Added R-by from Igor(#1,#2,#3).
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
> Kwangwoo Lee (2):
>   nvdimm: Use configurable ACPI IO base and size
>   hw/arm/virt: Add nvdimm hot-plug infrastructure
>=20
> Shameer Kolothum (5):
>   hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output buffer length
>   hw/arm/virt: Add nvdimm hotplug support
>   tests: Update ACPI tables list for upcoming arm/virt test changes
>   bios-tables-test: test pc-dimm and nvdimm coldplug for arm/virt
>   tests/acpi: add expected tables for bios-tables-test
>=20
>  docs/specs/acpi_hw_reduced_hotplug.rst |   3 +-
>  hw/acpi/generic_event_device.c         |  15 +++++-
>  hw/acpi/nvdimm.c                       |  72 ++++++++++++++++++++-----
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/virt-acpi-build.c               |   6 +++
>  hw/arm/virt.c                          |  35 ++++++++++--
>  hw/i386/acpi-build.c                   |   6 +++
>  hw/i386/acpi-build.h                   |   3 ++
>  hw/i386/pc_piix.c                      |   2 +
>  hw/i386/pc_q35.c                       |   2 +
>  hw/mem/Kconfig                         |   2 +-
>  include/hw/acpi/generic_event_device.h |   1 +
>  include/hw/arm/virt.h                  |   1 +
>  include/hw/mem/nvdimm.h                |   3 ++
>  tests/data/acpi/pc/SSDT.dimmpxm        | Bin 685 -> 734 bytes
>  tests/data/acpi/q35/SSDT.dimmpxm       | Bin 685 -> 734 bytes
>  tests/data/acpi/virt/DSDT.memhp        | Bin 6644 -> 6668 bytes
>  tests/data/acpi/virt/NFIT.memhp        | Bin 0 -> 224 bytes
>  tests/data/acpi/virt/SSDT.memhp        | Bin 0 -> 736 bytes
>  tests/qtest/bios-tables-test.c         |   9 +++-
>  20 files changed, 138 insertions(+), 23 deletions(-)
>  create mode 100644 tests/data/acpi/virt/NFIT.memhp
>  create mode 100644 tests/data/acpi/virt/SSDT.memhp
>=20
> --=20
> 2.17.1
>=20


