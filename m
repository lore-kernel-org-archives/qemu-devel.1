Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB9EC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3620B20675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1lK4tg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3620B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyHM-00039p-AT
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVyB9-0003xR-0M
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:04:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVyB7-0002QC-KM
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588687448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jhk6iRFTvk6LQEuTR+BiAJM2lfUBhL+R9Mg4WLbUY8w=;
 b=K1lK4tg4IJViG+cHW27zLZaaKzvtyfAj3PabAMkVoVhUF5o17X2Ce3CuUNDbSvukdxrXy/
 MmBMjvlbtVOk0KvuGIPFt2URGEZV5vl/GnzOqEaN7xhq1arveE9VL9gZP+NAb8Kmp0RUnD
 Khg8VoAzvMWS+nRMRSa3oCqFm59wSD4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-EVwMyu4YMWaz3eejX5mDdQ-1; Tue, 05 May 2020 10:04:06 -0400
X-MC-Unique: EVwMyu4YMWaz3eejX5mDdQ-1
Received: by mail-wr1-f72.google.com with SMTP id e5so1238481wrs.23
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HrG6smjGsFEVUqMZ3E+Z3Tp3PQnjfn3zh5YyVTA+Lm8=;
 b=lr6s243eCdrUsBgNRkbfD59toDnLkeOGhHc+4Q1Rtn0q8sziZoOo5/APhtx6FhUnPk
 vQbibkyEt+9O642DsMKDUtPYR2CIkqgQa0wfvxBmsexL3hPTx2xFw1Wdf1ONny+p3wsl
 jR5lvsaxapxbLncZG6bNsKxAF6Usj6GZmU15GGzFB0WiZr0I4UOvORQD3Q+gibsSHJCq
 SsYKNzXcQoBKds34LzPLYkFRL9hjTWMs5eJIzbcOqsstVXWdiM62zRWqReP2jzdpqRBW
 NFmzsGO1Cu7envedZviDKyzgCpWQf0zzilcFBoJXemKd0+hqlrU/IZMt46/oSpUe/thw
 QlRg==
X-Gm-Message-State: AGi0PuZV6j0IfFfG9lgGpNSViacVhzJUvmc9ZiCEPqiBLzZD0rfVJjyN
 Em2Ww6GNCvsuMvZm/Itb/Fj/qbYjQ5C2dSRoUtUMkih6LeyXzKa1jWlE0TJp3XEbspfl3CZtWiC
 Jx9Tee0ojGu3v8A0=
X-Received: by 2002:adf:ea05:: with SMTP id q5mr3695899wrm.87.1588687445497;
 Tue, 05 May 2020 07:04:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlGUaosvrDWQ17zUfiVJ5Ij9fXM7+Vo7FgAAqdBHXSA7l+JElKhmMAEOWOcnceT7oyN+R+sA==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr3695864wrm.87.1588687445262;
 Tue, 05 May 2020 07:04:05 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 p7sm3598515wrf.31.2020.05.05.07.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 07:04:04 -0700 (PDT)
Date: Tue, 5 May 2020 10:04:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 00/13] microvm: add acpi support
Message-ID: <20200505100010-mutt-send-email-mst@kernel.org>
References: <20200505134305.22666-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 03:42:52PM +0200, Gerd Hoffmann wrote:
> I know that not supporting ACPI in microvm is intentional.  If you still
> don't want ACPI this is perfectly fine, you can use the usual -no-acpi
> switch to toggle ACPI support.
>=20
> These are the advantages you are going to loose then:
>=20
>   (1) virtio-mmio device discovery without command line hacks (tweaking
>       the command line is a problem when not using direct kernel boot).
>   (2) Better IO-APIC support, we can use IRQ lines 16-23.
>   (3) ACPI power button (aka powerdown request) works.
>   (4) machine poweroff (aka S5 state) works.

Questions

- what's the tradeoff in startup time?
- what should be the default?

Based on above I'd be inclined to say default should stay no acpi and
users should enable acpi with an option.

> Together with seabios patches for virtio-mmio support this allows to
> boot standard fedora images (cloud, coreos, workstation live) with the
> microvm machine type.
>=20
> git branch for testing (including updated seabios):
> =09https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/microvm
>=20
> changes in v2:
>   * some acpi cleanups are an separate patch series now.
>   * switched to hw reduced acpi & generic event device.
>   * misc fixes here and there.
>=20
> cheers,
>   Gerd
>=20
> Gerd Hoffmann (13):
>   acpi: make build_madt() more generic.
>   acpi: create acpi-common.c and move madt code
>   acpi: madt: skip pci override on pci-less systems (microvm)
>   acpi: move acpi_build_facs to acpi-common.c
>   acpi: move acpi_init_common_fadt_data to acpi-common.c
>   acpi: move acpi_align_size to acpi-common.h
>   acpi: fadt: add hw-reduced sleep register support
>   acpi: generic event device for x86
>   microvm: add minimal acpi support
>   microvm: disable virtio-mmio cmdline hack
>   microvm: add acpi_dsdt_add_virtio() for x86
>   microvm: make virtio irq base runtime configurable
>   microvm/acpi: use GSI 16-23 for virtio
>=20
>  hw/i386/acpi-common.h                  |  38 ++++
>  hw/i386/acpi-microvm.h                 |   6 +
>  include/hw/acpi/acpi-defs.h            |   2 +
>  include/hw/acpi/generic_event_device.h |  10 +
>  include/hw/i386/microvm.h              |  10 +-
>  hw/acpi/aml-build.c                    |   4 +-
>  hw/i386/acpi-build.c                   | 198 +-------------------
>  hw/i386/acpi-common.c                  | 206 ++++++++++++++++++++
>  hw/i386/acpi-microvm.c                 | 249 +++++++++++++++++++++++++
>  hw/i386/generic_event_device_x86.c     | 114 +++++++++++
>  hw/i386/microvm.c                      |  36 +++-
>  hw/i386/Kconfig                        |   1 +
>  hw/i386/Makefile.objs                  |   3 +
>  13 files changed, 676 insertions(+), 201 deletions(-)
>  create mode 100644 hw/i386/acpi-common.h
>  create mode 100644 hw/i386/acpi-microvm.h
>  create mode 100644 hw/i386/acpi-common.c
>  create mode 100644 hw/i386/acpi-microvm.c
>  create mode 100644 hw/i386/generic_event_device_x86.c
>=20
> --=20
> 2.18.4


