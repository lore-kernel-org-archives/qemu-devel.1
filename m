Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32487C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0DA2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyinOb/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0DA2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXtq-0006Dd-10
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVXrK-0004Hc-UI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:57:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVXrI-0004rB-Q1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588586275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0xKETUStHR0oHcaZ8b8i0N2V+4c29jyY/QLJMgk8WM=;
 b=VyinOb/k8GNsTJFdhfXBjELFbAUh6rdCMjQ8dP3t2A/meowSLUF2O5TCOtcNhdBQLfeXI2
 sF6xetxJEeOMuwz9Bm5bzcm4VHCV+g8yi3b7rrO4Hn/v+gS5lAAZqczS6lBEAo4XlGbxaN
 yuHoS1VUsKl4DNUcntUsNHXlM+j7l94=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-VTIZdy22MMSBh4V8pdIPoQ-1; Mon, 04 May 2020 05:57:46 -0400
X-MC-Unique: VTIZdy22MMSBh4V8pdIPoQ-1
Received: by mail-wr1-f72.google.com with SMTP id q13so1617948wrn.14
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tLxYcMunStH4/7QnTzXZ2d6AI0SLOIk5asIV7RnMEP4=;
 b=pyZ2ZyyLwSy4gEsmMAzxQts446Cra+o5sfs6Uk4DXWGfLe5qSrYMtGjWvcDBCvJHH6
 o8DdA6E9v3NE0UlbpaAnTa+b5FN2RNTx/1YieJ6moBvHsluVyehgdiLRCTfJ6EzzNDes
 82XlcdtsIase78kkT9hBu/zM5N0+gpDfaieiciUn+Pzov7yrKohKiVi4hLS+mUNyLhpJ
 53wK3bw/7UyFPKxX4SSBrseQrq3j+Dm8Fxum6DiUxgJyqaQSchhcNZ1thbl3fKnW8WR9
 /0h1FxL7L+krmtAQzvavchuYt9FuBiYtkFlgSAl7nkuR2HLvcmw2OH9db1dJzVFVJSfp
 CIlg==
X-Gm-Message-State: AGi0PuaXkFdOQdudAILdbgMQlZjLGXEi4+ZgPWWvymZrzCyBSWrXbixB
 zxErqUCJnsqhKzyYBgrTUr2vFRzdqIU6yElI0mk1AjhaTT97BjAN0q0FY3QPOmXf0LUDZi41G80
 aoci59KVLQOb1ecs=
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr13459218wmh.120.1588586264612; 
 Mon, 04 May 2020 02:57:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcFwrOvtxXwbjs0RCyFyECrzwnf7RPWvFwmwMfTqeYESF/wyLxhokn+dsrwse73ZorAU+znA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr13459185wmh.120.1588586264238; 
 Mon, 04 May 2020 02:57:44 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 a9sm12065008wmm.38.2020.05.04.02.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:57:43 -0700 (PDT)
Date: Mon, 4 May 2020 05:57:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
Message-ID: <20200504055608-mutt-send-email-mst@kernel.org>
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <158748197516.25490.13137194821077838492@39012742ff91>
MIME-Version: 1.0
In-Reply-To: <158748197516.25490.13137194821077838492@39012742ff91>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 shannon.zhaosl@gmail.com, linuxarm@huawei.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, xuwei5@hisilicon.com, prime.zeng@hisilicon.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 08:12:57AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200421125934.14952-1-shameerali.k=
olothum.thodi@huawei.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Subject: [PATCH v4 0/7] ARM virt: Add NVDIMM support
> Message-id: 20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Switched to a new branch 'test'
> c4f3ad1 tests/acpi: add expected tables for bios-tables-test
> 5b55be7 bios-tables-test: test pc-dimm and nvdimm coldplug for arm/virt
> f0c9bb6 tests: Update ACPI tables list for upcoming arm/virt test changes
> c2dd728 hw/arm/virt: Add nvdimm hotplug support
> f7dad84 hw/arm/virt: Add nvdimm hot-plug infrastructure
> 5554e78 nvdimm: Use configurable ACPI IO base and size
> 8058b6f hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output buffer length
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/7 Checking commit 8058b6f6d753 (hw/acpi/nvdimm: Fix for NVDIMM incorrec=
t DSM output buffer length)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/acpi/nvdimm.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/acpi/nvdimm.c found
>=20
> total: 2 errors, 0 warnings, 59 lines checked

OK so this is a false positive in the script. I will fix it.

> Patch 1/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 2/7 Checking commit 5554e78b18ea (nvdimm: Use configurable ACPI IO base a=
nd size)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/acpi/nvdimm.c found

This beats me. Where did we get
tests/qtest/bios-tables-test-allowed-diff.h from?
It's a different patch, isn't it?

> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/acpi/nvdimm.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/acpi-build.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/acpi-build.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/acpi-build.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/acpi-build.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/pc_piix.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/pc_piix.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/pc_q35.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/i386/pc_q35.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/mem/nvdimm.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/mem/nvdimm.h found
>=20
> total: 12 errors, 0 warnings, 158 lines checked
>=20
> Patch 2/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 3/7 Checking commit f7dad84068ce (hw/arm/virt: Add nvdimm hot-plug infras=
tructure)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/Kconfig found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/Kconfig found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/virt-acpi-build.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/virt-acpi-build.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/virt.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/virt.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/mem/Kconfig found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/mem/Kconfig found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/arm/virt.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/arm/virt.h found
>=20
> total: 10 errors, 0 warnings, 80 lines checked
>=20
> Patch 3/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 4/7 Checking commit c2dd7289fec4 (hw/arm/virt: Add nvdimm hotplug support=
)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and docs/specs/acpi_hw_reduced_hotplug.rst found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and docs/specs/acpi_hw_reduced_hotplug.rst found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/acpi/generic_event_device.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/acpi/generic_event_device.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/virt.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and hw/arm/virt.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/acpi/generic_event_device.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/acpi/generic_event_device.h found
>=20
> total: 8 errors, 0 warnings, 103 lines checked
>=20
> Patch 4/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 5/7 Checking commit f0c9bb65828f (tests: Update ACPI tables list for upco=
ming arm/virt test changes)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/NFIT.memhp an=
d include/hw/acpi/generic_event_device.h found
>=20
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #17:=20
> new file mode 100644
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/SSDT.memhp an=
d include/hw/acpi/generic_event_device.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/acpi/generic_event_device.h found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and include/hw/acpi/generic_event_device.h found
>=20
> total: 4 errors, 1 warnings, 6 lines checked
>=20
> Patch 5/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 6/7 Checking commit 5b55be7a85b5 (bios-tables-test: test pc-dimm and nvdi=
mm coldplug for arm/virt)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and tests/qtest/bios-tables-test.c found
>=20
> total: 2 errors, 0 warnings, 19 lines checked
>=20
> Patch 6/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 7/7 Checking commit c4f3ad1b593c (tests/acpi: add expected tables for bio=
s-tables-test)
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/pc/SSDT.dimmpxm an=
d tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/q35/SSDT.dimmpxm a=
nd tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/DSDT.memhp an=
d tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/NFIT.memhp an=
d tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/data/acpi/virt/SSDT.memhp an=
d tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and tests/qtest/bios-tables-test.c found
>=20
> ERROR: Do not add expected files together with tests, follow instructions=
 in tests/qtest/bios-tables-test.c: both tests/qtest/bios-tables-test-allow=
ed-diff.h and tests/qtest/bios-tables-test.c found
>=20
> total: 7 errors, 0 warnings, 1 lines checked
>=20
> Patch 7/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200421125934.14952-1-shameerali.kolothum.thodi@=
huawei.com/testing.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


