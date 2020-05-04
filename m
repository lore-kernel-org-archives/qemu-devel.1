Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F544C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3212A206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezqhAGvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3212A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaZc-0000Tn-5P
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVaWs-0003dy-Pm
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:49:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVaWr-0005rM-5p
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588596540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNCcgsUqdoBbkH/9E7L512gBEdJFmdI8fYr7nO7wf4E=;
 b=ezqhAGvS+eCwqt4BM6FUpRpdZkRSYZskzTNRlaqrtlgxaDtc7TPiIQbCCoapXUCbqmipvy
 7ybcjT59zY6u87h6oyiuvNrw0kOp4gol3jlMhwIQURz+p2i14nKgqQ+JSbN/xNX1z75xTl
 +pmVtTcOuzhTxzmlZyuEjZK4yNlxZOo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-5rtI-2BbOZWtbG_IyOkiDw-1; Mon, 04 May 2020 08:48:56 -0400
X-MC-Unique: 5rtI-2BbOZWtbG_IyOkiDw-1
Received: by mail-wr1-f72.google.com with SMTP id f2so10718645wrm.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lPbDNj3GNGvOBf3cj42BFEg+o6Kld8r0YZtJdPLPuR0=;
 b=tknIl18m1psYQYJ1qcR4/eMDgZCWn348zPJdacl1PN+TVWCfi+OtOI8SEavxzbkNZ7
 spv3NGuStySKBz+Z39fwcRwIWQLsekceRNqomL2Tb/KFjMHNXqxdNTeZ1j45R3YVqYFf
 /BFoH5s9ujK5Dmy4uXmyXsjFWd1xYKv+tJtBedOt72ZBXny9IbcMoS+wNFMFKdcjIiWe
 hHFML87a+5oQXAnzPf4lqrJC/qQbwsLo4jNAvPHipHp3cRO5RmZQBwbuteBFhpFhAnYp
 A9SJEmC6fp5RTbn6qLNKHXlVX6dME9TCkN/XZXzhaK+QVNnTL/YmUK2qJ+Zpc1bvv+w3
 3Ggg==
X-Gm-Message-State: AGi0PubIM7PmOyv5p3+CcrekG8gfDJijpSZ7f5VMBkYT/UCjtd2awM05
 OVh2kds2KMBwGwCJqcub6SC0vJ1BYXbrNsMVUPejm8T+KJB6Na/8sdSZBGjVa/ugG2tEkRQapxD
 9vqerU/JqSYTe3O0=
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr15572363wml.55.1588596535459; 
 Mon, 04 May 2020 05:48:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcSIOHlZRCsHxG85tyJBXUG0c/CcWtPmJP3E5efyWKFu7rgvJzBWlLRG6ny6dD1oawKLuc1w==
X-Received: by 2002:a7b:ca47:: with SMTP id m7mr15572347wml.55.1588596535291; 
 Mon, 04 May 2020 05:48:55 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 n131sm13526188wmf.35.2020.05.04.05.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:48:54 -0700 (PDT)
Date: Mon, 4 May 2020 08:48:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 00/15] acpi: i386 tweaks
Message-ID: <20200504084831-mutt-send-email-mst@kernel.org>
References: <20200429140003.7336-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 03:59:48PM +0200, Gerd Hoffmann wrote:
> First batch of microvm patches, some generic acpi stuff.
> Split the acpi-build.c monster, specifically split the
> pc and q35 and pci bits into a separate file which we
> can skip building at some point in the future.

OK I applied 1st part of this that got acks.

> v2 changes: leave acpi-build.c largely as-is, move useful
> bits to other places to allow them being reused, specifically:
>=20
>  * move isa device generator functions to individual isa devices.
>  * move fw_cfg generator function to fw_cfg.c
>=20
> v3 changes: fix rtc, support multiple lpt devices.
>=20
> take care,
>   Gerd
>=20
> Gerd Hoffmann (15):
>   move 'typedef Aml' to qemu/types.h
>   acpi: add aml builder stubs
>   qtest: allow DSDT acpi table changes
>   acpi: drop pointless _STA method
>   acpi: add ISADeviceClass->build_aml()
>   rtc: add RTC_ISA_BASE
>   acpi: move aml builder code for rtc device
>   acpi: serial: don't use _STA method
>   acpi: move aml builder code for serial device
>   acpi: parallel: don't use _STA method
>   acpi: move aml builder code for parallel device
>   acpi: move aml builder code for floppy device
>   acpi: move aml builder code for i8042 (kbd+mouse) device
>   acpi: factor out fw_cfg_add_acpi_dsdt()
>   acpi: simplify build_isa_devices_aml()
>=20
>  hw/i386/fw_cfg.h                            |   1 +
>  include/hw/acpi/aml-build.h                 |   1 -
>  include/hw/isa/isa.h                        |   2 +
>  include/hw/rtc/mc146818rtc.h                |   1 +
>  include/qemu/typedefs.h                     |   1 +
>  tests/qtest/bios-tables-test-allowed-diff.h |  17 ++
>  hw/acpi/aml-build-stub.c                    |  79 ++++++
>  hw/block/fdc.c                              |  83 ++++++
>  hw/char/parallel.c                          |  32 +++
>  hw/char/serial-isa.c                        |  32 +++
>  hw/i386/acpi-build.c                        | 271 +-------------------
>  hw/i386/fw_cfg.c                            |  28 ++
>  hw/input/pckbd.c                            |  31 +++
>  hw/isa/isa-bus.c                            |  15 ++
>  hw/rtc/mc146818rtc.c                        |  25 +-
>  stubs/cmos.c                                |   7 +
>  hw/acpi/Makefile.objs                       |   4 +-
>  stubs/Makefile.objs                         |   1 +
>  18 files changed, 361 insertions(+), 270 deletions(-)
>  create mode 100644 hw/acpi/aml-build-stub.c
>  create mode 100644 stubs/cmos.c
>=20
> --=20
> 2.18.2


