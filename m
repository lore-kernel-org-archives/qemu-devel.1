Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB108C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB44B2076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaqaH3pu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB44B2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKgZ-0007cn-RB
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jGKfz-00079k-7e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jGKfx-0007jT-QA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:51:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jGKfx-0007iN-Il
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584960680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnnh7Nl/GvPwf8+NKEFEy7XwBd3j9+eQ1WC8Hc/peN4=;
 b=GaqaH3puDgDincwvKrIbbESFWoUQXtkyXSUBn8VILPp45mgZ9KquRsT7PZJjIWeLD22SCx
 n9YMd90CcXvMaYzx5nE0D66IMlFYmtLxywWa4yGDlo06d7Fl5Hrm0S7BBHPrpZksxMLA0X
 OF9OIUwGlhQCHdHkX2kfGEQtGpHaYng=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-GunU-RlTMyqwj-94diVYdQ-1; Mon, 23 Mar 2020 06:51:19 -0400
X-MC-Unique: GunU-RlTMyqwj-94diVYdQ-1
Received: by mail-qk1-f200.google.com with SMTP id w124so12117324qkd.19
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EsEPKYziFgJTjbQHlse6J8/6laAWtAGKpAS2GypZYvU=;
 b=HVpeY1bOJ0nB5tJujRBHLmvbnVimyCZMmF6Qlf30TBXf2bj6lfZB0bDS0D6VIu3mXM
 18j2OZ9Hjyc6yfAZI/3Ckvk/tlnXut8CPzA7UWnvgBLTdEL9Ed04C/1ZEM4IOgW98wlh
 CdtSCNjX5dcleCilP8KubMRCmDFoCmvwUZOY4eRzfTCX1dspmQQjOk1b87stgN96Q2/R
 m8uoFYf81OR1KKWiOAwfS4eGr2QDKwZQGRKkhE7IUyln6K6HCij6Q+ItuHLDI8nWzKj9
 v04LZbjZLwSq/Ze48CVuBNMeRVRQqUxH6sy/yrum3x/T4+VIbaTCSt5KXuCioRoGDiVY
 gGRg==
X-Gm-Message-State: ANhLgQ0hKPNQJ/VcIQ9eDoJ/mXn/3pE9xMGqLIsPjfpny5BQuk5EZSTQ
 pDVSR8iesi5t+AJqKY3aTwXnmTvUtHh9qXAzs8QE7qF6geKH17lG3CvKXRQxr+TnFzsJLQNl0En
 r5XCogwHlGXChGzU=
X-Received: by 2002:ac8:6a0e:: with SMTP id t14mr20972689qtr.340.1584960677241; 
 Mon, 23 Mar 2020 03:51:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuZZThBTXOMbfXaNBa0B4GtPUY+S7CDd+udT6AD+/bhWExtYRK5ea3UCOLBt1CIAdM+Zopg8w==
X-Received: by 2002:ac8:6a0e:: with SMTP id t14mr20972665qtr.340.1584960676956; 
 Mon, 23 Mar 2020 03:51:16 -0700 (PDT)
Received: from redhat.com (bzq-109-65-52-82.red.bezeqint.net. [109.65.52.82])
 by smtp.gmail.com with ESMTPSA id
 h11sm8701478qtr.38.2020.03.23.03.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 03:51:15 -0700 (PDT)
Date: Mon, 23 Mar 2020 06:51:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200323065050-mutt-send-email-mst@kernel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 09:01:04AM +0100, Gerd Hoffmann wrote:
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

What is the cost though? How do boot times compare?

> Together with seabios patches for virtio-mmio support this allows to
> boot standard fedora images (cloud, coreos, workstation live) with the
> microvm machine type.
>=20
> cheers,
>   Gerd
>=20
> Gerd Hoffmann (13):
>   acpi: make build_madt() more generic.
>   acpi: factor out acpi_dsdt_add_fw_cfg()
>   microvm: add isa-acpi device
>   microvm: add minimal acpi support.
>   microvm: add acpi_dsdt_add_virtio() for x86
>   microvm: disable virtio-mmio cmdline hack
>   [testing] seabios: update submodule to experimental microvm branch
>   [testing] seabios: update config & build rules
>   [testing] seabios: update binaries to experimental microvm branch
>   microvm/acpi: add rtc
>   microvm/acpi: add serial
>   microvm: make virtio irq base runtime configurable
>   microvm/acpi: use GSI 16-23 for virtio
>=20
>  include/hw/i386/microvm.h   |   8 +-
>  hw/acpi/isa-acpi.c          | 114 +++++++++++++++
>  hw/i386/acpi-build.c        | 278 +++++++++++++++++++++++++++++-------
>  hw/i386/microvm.c           |  32 +++--
>  hw/acpi/Makefile.objs       |   1 +
>  pc-bios/bios-256k.bin       | Bin 262144 -> 262144 bytes
>  pc-bios/bios-microvm.bin    | Bin 65536 -> 131072 bytes
>  pc-bios/bios.bin            | Bin 131072 -> 131072 bytes
>  roms/Makefile               |   5 +-
>  roms/config.seabios-128k    |   2 +
>  roms/config.seabios-microvm |  25 ++++
>  roms/seabios                |   2 +-
>  12 files changed, 403 insertions(+), 64 deletions(-)
>  create mode 100644 hw/acpi/isa-acpi.c
>  create mode 100644 roms/config.seabios-microvm
>=20
> --=20
> 2.18.2


