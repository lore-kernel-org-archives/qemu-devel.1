Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E0C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DF320715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhGkTiNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DF320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j18w8-0005As-Ny
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j18um-0003yw-8N
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j18ul-0007GI-3k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:15:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j18ul-0007Fp-0I
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581340550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kkmR7J2AZfEsKH/WXUpt/QP++fn+DThlOT8ntA1PKCo=;
 b=UhGkTiNlt6JN9tkUGayfPz46TNH5gC4LS5+9yWTZJtkjHQd6rY9Wcjw3LMFVC5Ztvh3ZaC
 Lj9dtByoapXvUB996P3W2VhM2knpSNI2C3umicYYeIyjA2fgp9WvAobp7fXShevQ2H6u0Q
 DDzX0DXlWIwJ+wb9iG1+e9dD3rdt+hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-zivFn7thOryor5xsi0Rl3g-1; Mon, 10 Feb 2020 08:15:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 570FD107ACC5;
 Mon, 10 Feb 2020 13:15:47 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0F29387;
 Mon, 10 Feb 2020 13:15:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [RFC 0/2] vTPM for aarch64
Date: Mon, 10 Feb 2020 14:15:21 +0100
Message-Id: <20200210131523.27540-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zivFn7thOryor5xsi0Rl3g-1
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
-device tpm-tis,tpmdev=3Dtpm0 \

References:
[1] libtpms: https://github.com/stefanberger/libtpms/wiki
[2] swtpm: https://github.com/stefanberger/swtpm/wiki
[3] [PATCH 0/4] ArmVirtPkg: implement measured boot for ArmVirtQemu

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2.0-tpm-rfc

Eric Auger (2):
  tpm: Let the TPM TIS device be usable on ARM
  hw/arm/virt: vTPM support

 hw/arm/Kconfig      |  1 +
 hw/arm/sysbus-fdt.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c       |  7 +++++++
 hw/tpm/Kconfig      |  2 +-
 hw/tpm/tpm_tis.c    | 16 ++++++++++++++++
 5 files changed, 61 insertions(+), 1 deletion(-)

--=20
2.20.1


