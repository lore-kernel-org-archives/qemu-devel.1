Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A589C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0BA2070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqOoflYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0BA2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iom8j-00039B-H3
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iolpw-000686-Q2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iolpv-0006PJ-AL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:11:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iolpv-0006P4-6Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0TXAl5VK0XtxKnjVC2WBxqzcROwrzO+VjHDWbm971E=;
 b=bqOoflYD7LJAQjsPJME1IHH0/GQgvGnQDHRuuZTt2T8qf6UofpM6YgeejIvb6JtFt71EV2
 pwrO9UelqeOgOFZV+BnpmxH6A09+2+gKpynFRB1trTgQMG+AP7Zc2wEspY/QWGZoqlCsmy
 wADVliKinagreP8uj+5VgUBlEKmQ1C4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-2VqBR4AfP5CEMk3jLiN3Gg-1; Tue, 07 Jan 2020 05:11:39 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so24517399wrp.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ksyuCtEFeMPGgh6ufgqQgZF5qP+qyUkEQPPgXWQIVmM=;
 b=KG6b5WvdwxV6PlIueZ3lTsqiwPQAkgq/h6ecART9xnWALQ84U88UWl4mv23Tg4+07A
 ZyMzd5UwRm7sBihk2fxZJlwKSQLQ3RpOAsivcxwhehZo4zeDMOD1vlCBjzCpMcy06tsZ
 UZVPxK+eNFxIXfV5runKUvbGPvAPp5qgZTgccoXM1D1oR/iPlgigDhikEar5eTY2OC8W
 WrYQK5srZEGOoYNYQYEkB4gYjQ6kaiO1D0gT8tjOQbJEiXXasFgTjUjmWol3ywpMRSjs
 JtA0F9on/KaYHcRdiwXGzT7+AP3w/JzxcMEDIN1aIvHjgcYMT4QNHVF+YbF5Mso1xLMb
 IJAg==
X-Gm-Message-State: APjAAAVinQZ9ChmamBG4yAjLskbAUHqCjvXnXktYaE15XjxHbU4ialU0
 Z+GPfuIlJYOpBv0LBuoddvooleoaWuEgaTk5gkh7z2k3ZYtGVSx/iZr2anlekNoNOVw8DVPdedw
 1pp6ZWJWEZlTGalw=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr38083895wmf.133.1578391897918; 
 Tue, 07 Jan 2020 02:11:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzG3AZszER2cj5ejqeqSdaKW471cdzDVV3v1zriQ3vgYKgOsLjNYZoRiLK+GDRwZAWRnTqNg==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr38083857wmf.133.1578391897672; 
 Tue, 07 Jan 2020 02:11:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id z124sm27366885wmc.20.2020.01.07.02.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:11:36 -0800 (PST)
Subject: Re: [PATCH 00/14] hw: Fix various --without-default-devices issues
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <16b49cef-d801-98fc-c487-88239f237dfe@redhat.com>
Date: Tue, 7 Jan 2020 11:11:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: 2VqBR4AfP5CEMk3jLiN3Gg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/12/19 19:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Various fixes when configured with --without-default-devices
> and building each machine individually.
> Adding the corresponding CI tests is out of the scope of this
> series.
>=20
> This series is pushed on top of "hw/i386: Allow building
> machines without IOMMU" [*] here:
> https://gitlab.com/philmd/qemu/commits/kconfig_misc_fixes
>=20
> Happy new year!
>=20
> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05230.html

Queued these:

 hw/intc/i8259: Fix Kconfig dependency on ISA bus
 hw/i386/Kconfig: Let the MicroVM machine select the SERIAL_ISA config
 hw/ppc/Kconfig: Restrict the MPC I2C controller to e500-based platforms
 hw/ppc/Kconfig: Let the Sam460ex board use the PowerPC 405 devices
 hw/ppc/Kconfig: Let the Xilinx Virtex5 ML507 use the PPC-440 devices
 hw/ppc/Makefile: Simplify the sPAPR PCI objects rule
 hw/ppc/Kconfig: Only select fw_cfg with machines using OpenBIOS
 hw/ppc/Kconfig: Only select FDT helper for machines using it
 hw/nvram/Kconfig: Add an entry for the NMC93xx EEPROM
 hw/nvram/Kconfig: Restrict CHRP NVRAM to machines using OpenBIOS or SLOF

Thanks David for the acks.

Paolo

> Philippe Mathieu-Daud=C3=A9 (14):
>   hw/usb/redirect: Do not link 'usb-redir' device when USB not enabled
>   hw/intc/i8259: Fix Kconfig dependency on ISA bus
>   hw/i386/Kconfig: Let the MicroVM machine select the SERIAL_ISA config
>   hw/i386: Restrict fw_cfg to the PC machines
>   hw/i2c/Kconfig: Add an entry for the SMBus
>   hw/ppc/Kconfig: Restrict the MPC I2C controller to e500-based
>     platforms
>   hw/ppc/Kconfig: Let the Sam460ex board use the PowerPC 405 devices
>   hw/ppc/Kconfig: Let the Xilinx Virtex5 ML507 use the PPC-440 devices
>   hw/ppc/Makefile: Simplify the sPAPR PCI objects rule
>   hw/ppc/Kconfig: Only select fw_cfg with machines using OpenBIOS
>   hw/ppc/Kconfig: Only select FDT helper for machines using it
>   hw/nvram/Kconfig: Add an entry for the NMC93xx EEPROM
>   hw/nvram/Kconfig: Restrict CHRP NVRAM to machines using OpenBIOS or
>     SLOF
>   hw/intc/Kconfig: Let APIC select IOAPIC
>=20
>  default-configs/mips-softmmu-common.mak |  1 +
>  default-configs/ppc-softmmu.mak         |  1 -
>  hw/i2c/Kconfig                          |  8 ++++++--
>  hw/i2c/Makefile.objs                    |  3 ++-
>  hw/i386/Kconfig                         |  2 +-
>  hw/i386/Makefile.objs                   |  2 +-
>  hw/intc/Kconfig                         |  2 ++
>  hw/net/Kconfig                          |  2 ++
>  hw/nvram/Kconfig                        |  8 ++++++++
>  hw/nvram/Makefile.objs                  |  4 ++--
>  hw/ppc/Kconfig                          | 20 ++++++++++++++++++++
>  hw/ppc/Makefile.objs                    |  9 ++++-----
>  hw/scsi/Kconfig                         |  1 +
>  hw/sparc/Kconfig                        |  1 +
>  hw/sparc64/Kconfig                      |  1 +
>  hw/usb/Makefile.objs                    |  2 ++
>  16 files changed, 54 insertions(+), 13 deletions(-)
>=20


