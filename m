Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB2C3B1BD
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3541222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl/jetBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3541222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fr0-0002zU-Ud
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j2fqA-0001Jg-9s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j2fq9-0003ml-3e
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:37:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j2fq9-0003mE-0h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581705443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J8JFyNcBKEVf0+ZfUlZ1bPoepMkEMuoMLY4zs3mp+P0=;
 b=Cl/jetBI/m+YU2mu1bSLPsEAbnA/CanZySYS8K16hwORuj/7HVB6FTKz4avbkI1dyOm6cS
 QSCEu12kLuxHDp9xwjdHPmLVQa0VArgN+3TwkgGuMPQ4ST13/0DKHWi/iUpCrt0A37L/lC
 oa9NJEvqoceIgD98hUtWgP3qk+KPkN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-OKhxejXZM3GP_vUPq_wMJw-1; Fri, 14 Feb 2020 13:37:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF5951005510;
 Fri, 14 Feb 2020 18:37:18 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86AA65DA7D;
 Fri, 14 Feb 2020 18:37:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [RFC v2 0/6] vTPM for aarch64
Date: Fri, 14 Feb 2020 19:36:58 +0100
Message-Id: <20200214183704.14389-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: OKhxejXZM3GP_vUPq_wMJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds the capability to instantiate an MMIO TPM TIS
in ARM virt.

The existing TPM TIS code is reshuffled into a generic part,
the ISA device and the sysbus device. The last patch allows
the instantiation of the TPM TIS sysbus device in ARM virt.

The series was tested with the swtpm/libtpms emulator.
Automatic guest LUKS volume unlocking (tpm2) was successful.
EDK2 support is under development [3]. Thanks to Ard
for supporting me when setting up the test environment.

Best Regards

Eric

Testing:

mkdir /tmp/tpm
swtpm socket \
--tpm2 \
-t -d \
--tpmstate dir=3D/tmp/tpm \
--ctrl type=3Dunixio,path=3D/tmp/swtpm-sock

qemu command line must be augmented with the following options:

-chardev socket,id=3Dchrtpm,path=3D/tmp/swtpm-sock \
-tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-device tpm-tis-device,tpmdev=3Dtpm0 \

References:
[1] libtpms: https://github.com/stefanberger/libtpms/wiki
[2] swtpm: https://github.com/stefanberger/swtpm/wiki
[3] [PATCH 0/4] ArmVirtPkg: implement measured boot for ArmVirtQemu

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2.0-tpm-rfc-v2

History:

RFC v1 -> RFC v2:
- restructure the existing code with common, ISA and sysbus part.
- both ARM and x86 integration were tested.
- acknowledgement: migration has not been tested

Eric Auger (6):
  tpm: rename TPM_TIS into TPM_TIS_ISA
  tpm: Use TPMState as a common struct
  tpm: Separate tpm_tis common functions from isa code
  tpm: Separate TPM_TIS and TPM_TIS_ISA configs
  tpm: Add the SysBus TPM TIS device
  hw/arm/virt: vTPM support

 default-configs/i386-softmmu.mak       |   2 +-
 hw/arm/Kconfig                         |   1 +
 hw/arm/sysbus-fdt.c                    |  36 +++++
 hw/arm/virt.c                          |   7 +
 hw/i386/Kconfig                        |   2 +-
 hw/i386/acpi-build.c                   |   6 +-
 hw/tpm/Kconfig                         |  12 +-
 hw/tpm/Makefile.objs                   |   4 +-
 hw/tpm/tpm_tis.h                       |  91 +++++++++++++
 hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c} | 181 ++-----------------------
 hw/tpm/tpm_tis_isa.c                   | 170 +++++++++++++++++++++++
 hw/tpm/tpm_tis_sysbus.c                | 159 ++++++++++++++++++++++
 include/sysemu/tpm.h                   |   7 +-
 tests/qtest/Makefile.include           |   4 +-
 14 files changed, 502 insertions(+), 180 deletions(-)
 create mode 100644 hw/tpm/tpm_tis.h
 rename hw/tpm/{tpm_tis.c =3D> tpm_tis_common.c} (85%)
 create mode 100644 hw/tpm/tpm_tis_isa.c
 create mode 100644 hw/tpm/tpm_tis_sysbus.c

--=20
2.20.1


