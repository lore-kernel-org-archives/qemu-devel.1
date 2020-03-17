Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B23AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5003520658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlVvcOxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5003520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9ju-0002kt-Gx
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jE9Ui-0005kZ-Cy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jE9Ud-0006xw-CL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jE9Ud-0006pZ-6h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFt2XjbaAxmulZldccnC7l+hYfRsI9OcAcsMmqt/8Dg=;
 b=QlVvcOxyoiNtXJmMJPdyz27AUuATP16EdMEh0YgEXNupE4YL/hoxAgcR1zbbyGHXclfz/v
 lYeniY55wEMxAjpj1OvnC4Akz9jjyAX3RlBz+W8GWjZpUFk5mfJ/ZYbq1d4UvNkK+HAJr5
 buXoaalHLArvtq6Lg9Uj7Qo2nJVjcBU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-_kH8_EQ3MqmfFctrsIwh6Q-1; Tue, 17 Mar 2020 06:30:34 -0400
X-MC-Unique: _kH8_EQ3MqmfFctrsIwh6Q-1
Received: by mail-wr1-f72.google.com with SMTP id u12so8030891wrw.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8zVvfzVCjt09CdRclhB8kLqw5DEd6aVswzNwrRgHhug=;
 b=A+JNR5Ov2ZvZjeNKVHkYm12qf2ZjTjKT1djnqn5FHmRyLwNMizLhYUHKLoJYlzI9oL
 SwQzABanvv65T1b2jUMQLmYL6/r/I5JxwALJoOHSoGeHP+YiuefVOYCURVDyGAZAcweH
 t3U0qCZV35VOPpoS8UnXQ7N2Kz71TmH1tN23tJhsrHhBqQMY8nBDaLLb/SvswUrbfdgD
 lPKp4gVUtuieKd3EqrZ6XO/YVq+zIWtOHcDgntPUsgg3Ns5Gu6pqF+UVjqBuWO35+C/W
 dZaLq5YzjlPm6zgveb3tMgANpn5tW1jU+xRe0UDuKzb+dAbVDjNTB6YLX5v/B5v6M8i+
 KGQw==
X-Gm-Message-State: ANhLgQ3HkJNxe4Nz7xI5oOYTSMlcduFdjzOHmzihQdFVC7i3sfcOvU6i
 J4f/3yD5ljVA0vKI34dUr5dBiSYqxqxtScbFtQAuYVxF/JqyJ40SnF6z4yuJy8MF/YZqPRUHgPr
 wjOiaVuOZ0aIlwkc=
X-Received: by 2002:adf:e78e:: with SMTP id n14mr5629001wrm.363.1584441033569; 
 Tue, 17 Mar 2020 03:30:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vur7pxKNq/AEf9RSJK3NcM9wUBEx/dXnxfJJgUHAxdXFoOKJKZ9Jhe8o85VTNe6h8sQg0pBoA==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr5628971wrm.363.1584441033292; 
 Tue, 17 Mar 2020 03:30:33 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
 by smtp.gmail.com with ESMTPSA id a7sm28189662wmb.0.2020.03.17.03.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:30:32 -0700 (PDT)
Subject: Re: [PULL 00/45] ppc-for-5.0 queue 20200317
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc2dc429-0c54-2a36-b901-97b14d4c9ce7@redhat.com>
Date: Tue, 17 Mar 2020 11:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, aik@ozlabs.ru, groug@kaod.org,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/03/20 11:03, David Gibson wrote:
>       pseries: Update SLOF firmware image
>       ppc/spapr: Move GPRs setup to one place
>       pseries: Update SLOF firmware image
>       spapr/rtas: Reserve space for RTAS blob and log
>       pseries: Update SLOF firmware image

Oh, no fake-OF patches?

Paolo

> C=C3=A9dric Le Goater (1):
>       spapr/xive: use SPAPR_IRQ_IPI to define IPI ranges exposed to the g=
uest
>=20
> David Gibson (19):
>       ppc: Remove stub support for 32-bit hypervisor mode
>       ppc: Remove stub of PPC970 HID4 implementation
>       target/ppc: Correct handling of real mode accesses with vhyp on has=
h MMU
>       target/ppc: Introduce ppc_hash64_use_vrma() helper
>       spapr, ppc: Remove VPM0/RMLS hacks for POWER9
>       target/ppc: Remove RMOR register from POWER9 & POWER10
>       target/ppc: Use class fields to simplify LPCR masking
>       target/ppc: Streamline calculation of RMA limit from LPCR[RMLS]
>       target/ppc: Correct RMLS table
>       target/ppc: Only calculate RMLS derived RMA limit on demand
>       target/ppc: Don't store VRMA SLBE persistently
>       spapr: Don't use weird units for MIN_RMA_SLOF
>       spapr,ppc: Simplify signature of kvmppc_rma_size()
>       spapr: Don't attempt to clamp RMA to VRMA constraint
>       spapr: Don't clamp RMA to 16GiB on new machine types
>       spapr: Clean up RMA size calculation
>       spapr: Move creation of ibm,dynamic-reconfiguration-memory dt node
>       spapr: Move creation of ibm,architecture-vec-5 property
>       spapr: Rename DT functions to newer naming convention
>=20
> Greg Kurz (2):
>       spapr: Handle pending hot plug/unplug requests at CAS
>       ppc: Officially deprecate the CPU "compat" property
>=20
> Nicholas Piggin (8):
>       ppc/spapr: Fix FWNMI machine check failure handling
>       ppc/spapr: Change FWNMI names
>       ppc/spapr: Add FWNMI System Reset state
>       ppc/spapr: Fix FWNMI machine check interrupt delivery
>       ppc/spapr: Allow FWNMI on TCG
>       target/ppc: allow ppc_cpu_do_system_reset to take an alternate vect=
or
>       ppc/spapr: Implement FWNMI System Reset delivery
>       ppc/spapr: Ignore common "ibm,nmi-interlock" Linux bug
>=20
> Philippe Mathieu-Daud=C3=A9 (8):
>       hw/ppc/pnv: Fix typo in comment
>       hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
>       hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible =
array
>       hw/scsi/spapr_vscsi: Simplify a bit
>       hw/scsi/spapr_vscsi: Introduce req_iu() helper
>       hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
>       hw/scsi/spapr_vscsi: Prevent buffer overflow
>       hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event
>=20
> Shivaprasad G Bhat (1):
>       spapr: Fix Coverity warning while validating nvdimm options
>=20
> Vitaly Chikunov (1):
>       target/ppc: Fix rlwinm on ppc64
>=20
>  docs/system/deprecated.rst        |   7 +
>  hw/intc/spapr_xive.c              |   4 +-
>  hw/ppc/pnv_lpc.c                  |   2 +-
>  hw/ppc/spapr.c                    | 980 ++++++++++++++++++++------------=
------
>  hw/ppc/spapr_caps.c               |  19 +-
>  hw/ppc/spapr_cpu_core.c           |  16 +-
>  hw/ppc/spapr_events.c             |  51 +-
>  hw/ppc/spapr_hcall.c              |  15 +-
>  hw/ppc/spapr_nvdimm.c             |   7 +-
>  hw/ppc/spapr_ovec.c               |   4 +-
>  hw/ppc/spapr_rtas.c               |  45 +-
>  hw/scsi/spapr_vscsi.c             |  72 +--
>  hw/scsi/trace-events              |   1 +
>  hw/scsi/viosrp.h                  |   3 +-
>  include/hw/ppc/spapr.h            |  34 +-
>  include/hw/ppc/spapr_cpu_core.h   |   4 +-
>  include/hw/ppc/spapr_ovec.h       |   4 +-
>  pc-bios/README                    |   2 +-
>  pc-bios/slof.bin                  | Bin 931032 -> 965008 bytes
>  roms/SLOF                         |   2 +-
>  target/ppc/cpu-qom.h              |   1 +
>  target/ppc/cpu.h                  |  28 +-
>  target/ppc/excp_helper.c          |  79 ++-
>  target/ppc/kvm.c                  |   5 +-
>  target/ppc/kvm_ppc.h              |   7 +-
>  target/ppc/mmu-hash64.c           | 319 +++++--------
>  target/ppc/translate.c            |  20 +-
>  target/ppc/translate_init.inc.c   | 116 ++---
>  tests/qtest/libqos/libqos-spapr.h |   3 +-
>  29 files changed, 930 insertions(+), 920 deletions(-)
>=20


