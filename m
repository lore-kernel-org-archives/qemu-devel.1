Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162EC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF6F206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJse7ZYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF6F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icYG1-0003sY-Of
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1icY66-0005BJ-7D
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1icY61-0002jP-Vq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1icY61-00027u-MN
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575479148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WUXxYGML3C/oVg+Kd1O7+q0KRs0akopSnbM8VefImNY=;
 b=PJse7ZYEyOwHmfmef8Hsv+ri3i30qH4QUWeygmCuNqQXCSVdXtq6IjHwV1Ng3V5KRZNNmh
 B+B/gXzunw6Yk9YjSNhhjKZ3ich3Ib3M4qM3DsbAlpq+hXQI3yr3eOTRw13H+Thn6/be0i
 0zv5oHThty46D2j7RnSytfxhTFy04Q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-ecLez1WYMDKof9_Yg7ibiQ-1; Wed, 04 Dec 2019 12:05:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5028E100551A
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 17:05:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E7635D6BE;
 Wed,  4 Dec 2019 17:05:37 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 0/8] q35: CPU hotplug with secure boot, part 1+2
Date: Wed,  4 Dec 2019 18:05:39 +0100
Message-Id: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ecLez1WYMDKof9_Yg7ibiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Series consists of 2 parts: 1st is lockable SMRAM at SMBASE
and the 2nd adds means to enumerate APIC IDs for possible CPUs.

1st part [1-2/8]:
 In order to support CPU hotplug in secure boot mode,
 UEFI firmware needs to relocate SMI handler of hotplugged CPU,
 in a way that won't allow ring 0 user to break in priveleged
 SMM mode that firmware maintains during runtime.
 Used approach allows to hide RAM at default SMBASE to make it
 accessible only to SMM mode, which lets us to make sure that
 SMI handler installed by firmware can not be hijacked by
 unpriveleged user (similar to TSEG behavior).=20

2nd part:
 mostly fixes and extra documentation on how to detect and use
 modern CPU hotplug interface (MMIO block).
 So firmware could reuse it for enumerating possible CPUs and
 detecting hotplugged CPU(s). It also adds support for
 CPHP_GET_CPU_ID_CMD command [7/8], which should allow firmware
 to fetch APIC IDs for possible CPUs which is necessary for
 initializing internal structures for possible CPUs on boot.
=20

CC: mst@redhat.com
CC: pbonzini@redhat.com
CC: lersek@redhat.com
CC: philmd@redhat.com

Igor Mammedov (8):
  q35: implement 128K SMRAM at default SMBASE address
  tests: q35: MCH: add default SMBASE SMRAM lock test
  acpi: cpuhp: spec: clarify 'CPU selector' register usage and
    endianness
  acpi: cpuhp: spec: fix 'Command data' description
  acpi: cpuhp: spec: clarify store into 'Command data' when 'Command
    field' =3D=3D 0
  acpi: cpuhp: spec: add typical usecases
  acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
  acpi: cpuhp: spec: document procedure for enabling modern CPU hotplug

 include/hw/pci-host/q35.h       |  10 ++++
 docs/specs/acpi_cpu_hotplug.txt |  91 +++++++++++++++++++++++++++-------
 hw/acpi/cpu.c                   |  15 ++++++
 hw/acpi/trace-events            |   1 +
 hw/i386/pc.c                    |   4 +-
 hw/pci-host/q35.c               |  80 +++++++++++++++++++++++++++---
 tests/q35-test.c                | 105 ++++++++++++++++++++++++++++++++++++=
++++
 7 files changed, 281 insertions(+), 25 deletions(-)

--=20
2.7.4


