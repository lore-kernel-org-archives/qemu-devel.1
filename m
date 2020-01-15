Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E438C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BD6207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVKcMr1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BD6207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irj0G-0000ZJ-CA
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irizQ-0007lO-Ma
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irizK-0002ty-V4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:45:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irizK-0002tH-QW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579095938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdeDGK1WtrEDkDCLPKchn4UL8Z5SR0HOQ+Pic6RYhD8=;
 b=VVKcMr1MwskeTsur6qKVwMO737k2PZT23gCp2TkddKVaK2U+c3pH5bdDyPyuU4+Qp8LJvh
 FpzQ6cn71o1WbLhA02jZ+jUwg8o88shVqFVOyethJkc7DcvR6qKLpjrYJFHk714z4fYNtd
 Od1HHj1PJ3nOiMvrt6Q9n+WlJvZ7lnM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-WgVJ8PChP-Sd1yZWOrZ_QA-1; Wed, 15 Jan 2020 08:45:37 -0500
Received: by mail-qv1-f71.google.com with SMTP id v3so11003511qvm.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 05:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PcReYp4zxkAbXp+X5NjqQMHmkALm3lLNrSlLPrVtOIM=;
 b=WSQ70GI/G9FdXWjWDYlfx3jNs6Gaxb64ZSXime4DFfvd0+J5cDBLOh4f8eH7rYyKx0
 82C3tZOt9V4Zf1bdlxzuxKBpW2jO1Nbkp2Z4PV449/lBxTEfelVuexOacxpsIAtKa5OF
 Xaa588eCS3pEW6JqZL386LejZyRaflRteJ0vR2wRclcvT6IL3xwiwT9F6zG829+3aFzp
 FKEKEhVxV6DCWFySxeL9Jn8QwDwVIMAzvfr3s3vSpMfNBFdufkj1/Xx8s710ZMuH4Oms
 6hYkACPxawQtrhpOFBkAnFDyQlU2UiRA6MaqiLkJ6s+jANhNlfNGJG5dTVV14T97M0lZ
 AYyQ==
X-Gm-Message-State: APjAAAUVLPF9uHBcWUkjLXart9i+U3ZwTLHAQSoqBwfNTqgBq5Njb3qY
 0mSUu0dbL6xLy7D6pUhrZx54e8g2zd810eFDQfGk/C5VfQfOS6N2aVujK5F32hh9uZ8SnG/Y1T9
 3xfx49bNEAGlA1fw=
X-Received: by 2002:a0c:e80e:: with SMTP id y14mr22334714qvn.139.1579095936576; 
 Wed, 15 Jan 2020 05:45:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhAVElqE7FPAoNVhhGFEUZ0CF5NM/V9DyJRaCnXDzxjTZvf12vw/jNggZlZ0iWpl4AaU4rRw==
X-Received: by 2002:a0c:e80e:: with SMTP id y14mr22334687qvn.139.1579095936249; 
 Wed, 15 Jan 2020 05:45:36 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 124sm8540733qkn.58.2020.01.15.05.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 05:45:35 -0800 (PST)
Date: Wed, 15 Jan 2020 08:45:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH] tests: acpi: update path in rebuild-expected-aml
Message-ID: <20200115064454-mutt-send-email-mst@kernel.org>
References: <20200114165138.15716-1-shameerali.kolothum.thodi@huawei.com>
 <cc70ac3c-199a-5bb4-fe34-51c1f6a26461@redhat.com>
 <68b1e32176c145e293dfee93419072e6@huawei.com>
MIME-Version: 1.0
In-Reply-To: <68b1e32176c145e293dfee93419072e6@huawei.com>
X-MC-Unique: WgVJ8PChP-Sd1yZWOrZ_QA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 11:01:44AM +0000, Shameerali Kolothum Thodi wrote:
>=20
>=20
> > -----Original Message-----
> > From: Thomas Huth [mailto:thuth@redhat.com]
> > Sent: 14 January 2020 17:08
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > qemu-devel@nongnu.org; imammedo@redhat.com; mst@redhat.com
> > Cc: xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>
> > Subject: Re: [PATCH] tests: acpi: update path in rebuild-expected-aml
> >=20
> > On 14/01/2020 17.51, Shameer Kolothum wrote:
> > > Since commit 1e8a1fae7464("test: Move qtests to a separate
> > > directory") qtests are now placed in a separate folder and
> > > this breaks the script used to rebuild the expected ACPI
> > > tables for bios-tables-test. Update the script with correct
> > > path.
> > >
> > > Fixes: 1e8a1fae7464("test: Move qtests to a separate directory")
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com=
>
> > > ---
> > >  tests/data/acpi/rebuild-expected-aml.sh | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tests/data/acpi/rebuild-expected-aml.sh
> > b/tests/data/acpi/rebuild-expected-aml.sh
> > > index f89d4624bc..d44e511533 100755
> > > --- a/tests/data/acpi/rebuild-expected-aml.sh
> > > +++ b/tests/data/acpi/rebuild-expected-aml.sh
> > > @@ -14,7 +14,7 @@
> > >
> > >  qemu_bins=3D"x86_64-softmmu/qemu-system-x86_64
> > aarch64-softmmu/qemu-system-aarch64"
> > >
> > > -if [ ! -e "tests/bios-tables-test" ]; then
> > > +if [ ! -e "tests/qtest/bios-tables-test" ]; then
> > >      echo "Test: bios-tables-test is required! Run make check before =
this
> > script."
> > >      echo "Run this script from the build directory."
> > >      exit 1;
> > > @@ -26,11 +26,11 @@ for qemu in $qemu_bins; do
> > >          echo "Also, run this script from the build directory."
> > >          exit 1;
> > >      fi
> > > -    TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu
> > tests/bios-tables-test
> > > +    TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu
> > tests/qtest/bios-tables-test
> > >  done
> > >
> > >  eval `grep SRC_PATH=3D config-host.mak`
> > >
> > > -echo '/* List of comma-separated changed AML files to ignore */' >
> > ${SRC_PATH}/tests/bios-tables-test-allowed-diff.h
> > > +echo '/* List of comma-separated changed AML files to ignore */' >
> > ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
> > >
> > >  echo "The files were rebuilt and can be added to git."
> >=20
> > Oh, sorry for missing that in my patch series ... is there maybe a way
> > that we could test this script in one of our CI pipelines so that it is
> > not so easy to miss?
>=20
> Right. That will be a useful one.
>=20
> I am also seeing another error when I run "make check-qtest" on x86_64.
> This doesn=E2=80=99t seems to be related to the recent changes. I have go=
ne back
> to 4.1.0 and it is still there.
>=20
>   TEST    check-qtest-x86_64: tests/boot-order-test
>   TEST    check-qtest-x86_64: tests/bios-tables-test
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> acpi-test: Warning! FACP binary file mismatch. Actual [aml:/tmp/aml-2Q9EE=
0], Expected [aml:tests/data/acpi/pc/FACP.bridge].
> acpi-test: Warning! FACP mismatch. Actual [asl:/tmp/asl-CQ9EE0.dsl, aml:/=
tmp/aml-2Q9EE0], Expected [asl:/tmp/asl-N18EE0.dsl, aml:tests/data/acpi/pc/=
FACP.bridge].
> **
> ERROR:tests/bios-tables-test.c:447:test_acpi_asl: assertion failed: (all_=
tables_match)
> ERROR - Bail out! ERROR:tests/bios-tables-test.c:447:test_acpi_asl: asser=
tion failed: (all_tables_match)
> Aborted (core dumped)
> /home/shameer/qemu/tests/Makefile.include:899: recipe for target 'check-q=
test-x86_64' failed
> make: *** [check-qtest-x86_64] Error 1

Well make check seems to pass for me ... What's different for you?

> FACP seems to have changed and it looks like need to run the script to ge=
nerate
> a new one.
>=20
> ~/qemu$ diff -u /tmp/asl-CQ9EE0.dsl /tmp/asl-N18EE0.dsl
> --- /tmp/asl-CQ9EE0.dsl 2020-01-15 10:52:03.018448627 +0000
> +++ /tmp/asl-N18EE0.dsl 2020-01-15 10:52:03.022448627 +0000
> @@ -3,7 +3,7 @@
>   * AML/ASL+ Disassembler version 20180105 (64-bit version)
>   * Copyright (c) 2000 - 2018 Intel Corporation
>   *
> - * Disassembly of /tmp/aml-2Q9EE0, Wed Jan 15 10:52:03 2020
> + * Disassembly of tests/data/acpi/pc/FACP.bridge, Wed Jan 15 10:52:03=20
> + 2020
>   *
>   * ACPI Data Table [FACP]
>   *
> @@ -13,7 +13,7 @@
>  [000h 0000   4]                    Signature : "FACP"    [Fixed ACPI
> Description Table (FADT)]
>  [004h 0004   4]                 Table Length : 00000074
>  [008h 0008   1]                     Revision : 01
> -[009h 0009   1]                     Checksum : A1
> +[009h 0009   1]                     Checksum : D3
>  [00Ah 0010   6]                       Oem ID : "BOCHS "
>  [010h 0016   8]                 Oem Table ID : "BXPCFACP"
>  [018h 0024   4]                 Oem Revision : 00000001
> @@ -54,7 +54,7 @@
>  [069h 0105   1]             Duty Cycle Width : 00
>  [06Ah 0106   1]          RTC Day Alarm Index : 00
>  [06Bh 0107   1]        RTC Month Alarm Index : 00
> -[06Ch 0108   1]            RTC Century Index : 32
> +[06Ch 0108   1]            RTC Century Index : 00
>  [06Dh 0109   2]   Boot Flags (decoded below) : 0000
>                 Legacy Devices Supported (V2) : 0
>              8042 Present on ports 60/64 (V2) : 0 @@ -89,11 +89,11 @@
>=20
>=20
> Not sure this is an already reported one or I am missing something.
> Please let me know.
>=20
> Thanks,
> Shameer
>=20
> > Anyway, for this patch:
> >=20
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20


