Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE7EC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF5D20866
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBDBCsq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF5D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEi5-0004t6-VM
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEUI-0006yD-Ht
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEUF-0003nm-UY
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:58:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEUF-0003hY-JV
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DU+v1+qSXxMwHczsoakDiicLnkfOmtj3Euf4AZRmwFY=;
 b=EBDBCsq+k3aa1gdI4dc6bM05PFuNLkd/pFnjyigdnItQ068ofa3/1DdfFhtGi6E5GRj+HJ
 LLjUYZlQLSpEBkMpjRJHjw2pQenxUsV3grDWvKoggXDucYEudPnleoMPjdO1mmeMUAuDz5
 ByAXH3tWn0TRcV+pOmayRn6LU3vqQR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-9iIaSgdkNYWGuH4yNdMIvw-1; Sat, 14 Dec 2019 10:56:33 -0500
X-MC-Unique: 9iIaSgdkNYWGuH4yNdMIvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B08321005502;
 Sat, 14 Dec 2019 15:56:31 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 234905D6A7;
 Sat, 14 Dec 2019 15:56:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] Simplify memory_region_add_subregion_overlap(...,
 priority=0)
Date: Sat, 14 Dec 2019 16:56:06 +0100
Message-Id: <20191214155614.19004-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

In this series we use coccinelle to replace:
- memory_region_add_subregion_overlap(..., priority=3D0)
+ memory_region_add_subregion(...)

Rationale is the code is easier to read, and reviewers don't
have to worry about overlapping because it isn't used.

Last patch is a minor cleanup in variable names.

I expect each subsystem maintainer to take the subsystem patches.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (8):
  hw/arm/nrf51_soc: Use memory_region_add_subregion() when priority is 0
  hw/arm/raspi: Use memory_region_add_subregion() when priority is 0
  hw/arm/xlnx-versal: Use memory_region_add_subregion() when priority is
    0
  hw/i386/intel_iommu: Use memory_region_add_subregion when priority is
    0
  hw/mips/boston: Use memory_region_add_subregion() when priority is 0
  hw/vfio/pci: Use memory_region_add_subregion() when priority is 0
  target/i386: Use memory_region_add_subregion() when priority is 0
  target/i386/cpu: Use 'mr' for MemoryRegion variables

 target/i386/cpu.h            |  2 +-
 hw/arm/bcm2835_peripherals.c |  4 ++--
 hw/arm/nrf51_soc.c           | 14 +++++++-------
 hw/arm/raspi.c               |  2 +-
 hw/arm/xlnx-versal-virt.c    |  3 +--
 hw/arm/xlnx-versal.c         |  4 ++--
 hw/i386/intel_iommu.c        | 11 ++++-------
 hw/mips/boston.c             | 14 +++++++-------
 hw/vfio/pci.c                |  3 +--
 target/i386/cpu.c            | 18 +++++++++---------
 target/i386/kvm.c            |  2 +-
 11 files changed, 36 insertions(+), 41 deletions(-)

--=20
2.21.0


