Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB31EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B8A2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZzJ9Z5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B8A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhrG-0008Eu-Up
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ifhqX-0007YN-R2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ifhqW-0007vK-5d
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:06:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29525
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ifhqW-0007uW-0Y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576231611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+yePhds5W5El436HaX0VQe6aP/ak04SzsjdNVHrI6w=;
 b=TZzJ9Z5QSu1h/7q/HL2EqSWd83FMhHWFT91iU24YNpSGOUq6f7oiTaPp0gt1/nhHujdSBT
 hyW1ZrUGgdANlYPi1uUQ4LOz4+d60y8SzLJGt6HH6axNDGN0axxLILRocXonNpsBoyxI0P
 Df/vgQBStNWvXJtTblNEKojz/mUaJKY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-HH9_xqMvPY-kzbH_FdfS6g-1; Fri, 13 Dec 2019 05:06:49 -0500
Received: by mail-qk1-f199.google.com with SMTP id f22so1091908qka.10
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 02:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7+rvWHq+6sJJip9wpcs4jEobzGCjplptqObsSyO4/us=;
 b=lMKtv88RUy8OlXXvECgHLWQ8qq/mreY1182cpj3b9cy0yc8e0WAtCTHFwMbqtjKGEE
 hXimFEavHd6i/4nLNDBtTwh0OgZulsFi5i55io58ZbjX6C1IvLn/w6kbf/tSXdufKM4J
 5eL1/dCq1jJJf/+KKRGx9iHsUVe2fGhlSEIIsLbsFt6pNm8+hoyQ0Zz6+6oCMWtckyKP
 imOvIb7QQ/yQS2PvrRYeYyzEmVJqrPuwGGDhHcc43eEfStm1dVW4vzJBS0GcfQ3ziKvw
 V5t/dUkfHFzp6ia95DxWCrS4n9FpuQCBUL3N4zfKRhLgbDp/xhlCQmh/B1gvNWCFONuA
 OS7Q==
X-Gm-Message-State: APjAAAVznIsGQeKAMLRd2MKXnFUDQRfTbmAyUBw8wexxXHCAxnMWQl6F
 NPKL88kE/tHRrZMLFaViZ9pZOz7WRrIRnMurzI2oHY2uw61f/9hGfVID1bbYW6MASc1+KXdBArD
 mw9QisDXxw1RsNXs=
X-Received: by 2002:ac8:1087:: with SMTP id a7mr11775802qtj.274.1576231609110; 
 Fri, 13 Dec 2019 02:06:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyofgxW8ta4kO3mR/Wj4WYaOteB8O03hPXcPr8Bu1pr93mBmzp2o4Rf1tfmXb/0AAY1gJRnng==
X-Received: by 2002:ac8:1087:: with SMTP id a7mr11775775qtj.274.1576231608826; 
 Fri, 13 Dec 2019 02:06:48 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id g9sm2655926qkm.9.2019.12.13.02.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 02:06:48 -0800 (PST)
Date: Fri, 13 Dec 2019 05:06:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH RESEND v20 0/8] Build ACPI Heterogeneous Memory Attribute
 Table (HMAT)
Message-ID: <20191213050619-mutt-send-email-mst@kernel.org>
References: <20191213011929.2520-1-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191213011929.2520-1-tao3.xu@intel.com>
X-MC-Unique: HH9_xqMvPY-kzbH_FdfS6g-1
X-Mimecast-Spam-Score: 0
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
Cc: lvivier@redhat.com, thuth@redhat.com, fan.du@intel.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, jonathan.cameron@huawei.com,
 armbru@redhat.com, mdroth@linux.vnet.ibm.com, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 13, 2019 at 09:19:21AM +0800, Tao Xu wrote:
> This series of patches will build Heterogeneous Memory Attribute Table (H=
MAT)
> according to the command line. The ACPI HMAT describes the memory attribu=
tes,
> such as memory side cache attributes and bandwidth and latency details,
> related to the Memory Proximity Domain.
> The software is expected to use HMAT information as hint for optimization=
.
>=20
> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and repo=
rt
> the platform's HMAT tables.
>=20
> The V19 patches link:
> https://patchwork.kernel.org/cover/11265525/

Looks good to me, I'll queue it for merge after the release. If possible
please ping me after the release to help make sure it didn't get
dropped.



> Changelog:
> v20:
>     - Resend to fix the wrong target in pc_hmat_erange_cfg()
>     - Use g_assert_true and g_assert_false to replace g_assert
>       (Thomas and Markus)
>     - Rename assoc as associativity, update the QAPI description (Markus)
>     - Disable cache level 0 in hmat-cache option (Igor)
>     - Keep base and bitmap unchanged when latency or bandwidth
>       out of range
>     - Fix the broken CI case when user input latency or bandwidth
>       less than required.
> v19:
>     - Add description about the machine property 'hmat' in commit
>       message (Markus)
>     - Update the QAPI comments
>     - Add a check for no memory side cache
>     - Add some fail cases for hmat-cache when level=3D0
> v18:
>     - Defer patches 01/14~06/14 of V17, use qapi type uint64 and
>       only nanosecond for latency (Markus)
>     - Rewrite the lines over 80 characters(Igor)
> v17:
>     - Add check when user input latency or bandwidth 0, the
>       lb_info_provided should also be 0. Because in ACPI 6.3 5.2.27.4,
>       0 means the corresponding latency or bandwidth information is
>       not provided.
>     - Fix the infinite loop when node->latency is 0.
>     - Use NumaHmatCacheOptions to replace HMAT_Cache_Info (Igor)
>     - Add check for unordered cache level input (Igor)
>     - Add some fail test cases (Igor)
> v16:
>     - Add and use qemu_strtold_finite to parse size, support full
>       64bit precision, modify related test cases (Eduardo and Markus)
>     - Simplify struct HMAT_LB_Info and related code, unify latency
>       and bandwidth (Igor)
>     - Add cross check with hmat_lb data (Igor)
>     - Fields in Cache Attributes are promoted to uint32_t before
>       shifting (Igor)
>     - Add case for QMP build HMAT (Igor)
> v15:
>     - Add a new patch to refactor do_strtosz() (Eduardo)
>     - Make tests without breaking CI (Michael)
> v14:
>     - Reuse the codes of do_strtosz to build qemu_strtotime_ns
>       (Eduardo)
>     - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
>     - Drop time unit picosecond (Eric)
>     - Use qemu ctz64 and clz64 instead of builtin function
> v13:
>     - Modify some text description
>     - Drop "initiator_valid" field in struct NodeInfo
>     - Reuse Garray to store the raw bandwidth and bandwidth data
>     - Calculate common base unit using range bitmap
>     - Add a patch to alculate hmat latency and bandwidth entry list
>     - Drop the total_levels option and use readable cache size
>     - Remove the unnecessary head file
>     - Use decimal notation with appropriate suffix for cache size
>=20
> Liu Jingqi (5):
>   numa: Extend CLI to provide memory latency and bandwidth information
>   numa: Extend CLI to provide memory side cache information
>   hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>   hmat acpi: Build System Locality Latency and Bandwidth Information
>     Structure(s)
>   hmat acpi: Build Memory Side Cache Information Structure(s)
>=20
> Tao Xu (3):
>   numa: Extend CLI to provide initiator information for numa nodes
>   tests/numa: Add case for QMP build HMAT
>   tests/bios-tables-test: add test cases for ACPI HMAT
>=20
>  hw/acpi/Kconfig                       |   7 +-
>  hw/acpi/Makefile.objs                 |   1 +
>  hw/acpi/hmat.c                        | 268 +++++++++++++++++++++++
>  hw/acpi/hmat.h                        |  42 ++++
>  hw/core/machine.c                     |  64 ++++++
>  hw/core/numa.c                        | 297 ++++++++++++++++++++++++++
>  hw/i386/acpi-build.c                  |   5 +
>  include/sysemu/numa.h                 |  63 ++++++
>  qapi/machine.json                     | 180 +++++++++++++++-
>  qemu-options.hx                       |  95 +++++++-
>  tests/bios-tables-test-allowed-diff.h |   8 +
>  tests/bios-tables-test.c              |  44 ++++
>  tests/data/acpi/pc/APIC.acpihmat      |   0
>  tests/data/acpi/pc/DSDT.acpihmat      |   0
>  tests/data/acpi/pc/HMAT.acpihmat      |   0
>  tests/data/acpi/pc/SRAT.acpihmat      |   0
>  tests/data/acpi/q35/APIC.acpihmat     |   0
>  tests/data/acpi/q35/DSDT.acpihmat     |   0
>  tests/data/acpi/q35/HMAT.acpihmat     |   0
>  tests/data/acpi/q35/SRAT.acpihmat     |   0
>  tests/numa-test.c                     | 213 ++++++++++++++++++
>  21 files changed, 1276 insertions(+), 11 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h
>  create mode 100644 tests/data/acpi/pc/APIC.acpihmat
>  create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
>  create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
>  create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat
>=20
> --=20
> 2.20.1


