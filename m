Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BAFC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0207A20801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmG7ZK4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0207A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tzf-0005cA-7N
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6tti-0004v3-Ir
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6tth-000495-F0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6tth-00046X-9Q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582712792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwQmZv0xaQVkdsJzKqedRVySFq+XxBho2HOp8v1kkcI=;
 b=WmG7ZK4kLnFSdivqZYmcoLNMR/bJi1uHgenRgyrQXmz6I0SQPwPizwaSCrW6i0Nzmeulra
 HPmaoaTq8mmtVzb75YIq76DMUgPOHfZFtzfNPHhCtc7dJGYBbPzQyqBhdYsZSPz8KPcySM
 mCV3/d+Jmc5bG28g8bWHLL0lUjz+jdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-CqJTAGU5PJOICpJIJRwGBw-1; Wed, 26 Feb 2020 05:26:31 -0500
X-MC-Unique: CqJTAGU5PJOICpJIJRwGBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A98D800D54;
 Wed, 26 Feb 2020 10:26:30 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C05F860C18;
 Wed, 26 Feb 2020 10:26:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v3 07/10] docs/specs/tpm: Document TPM_TIS sysbus device for
 ARM
Date: Wed, 26 Feb 2020 11:25:46 +0100
Message-Id: <20200226102549.12158-8-eric.auger@redhat.com>
In-Reply-To: <20200226102549.12158-1-eric.auger@redhat.com>
References: <20200226102549.12158-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Update the documentation with recent changes related to the
sysbus TPM_TIS device addition and add the command line
to be used with arm VIRT.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 docs/specs/tpm.rst | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 2bdf637f55..932cb57049 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -18,9 +18,15 @@ The TIS interface makes a memory mapped IO region in the=
 area
 0xfed40000-0xfed44fff available to the guest operating system.
=20
 QEMU files related to TPM TIS interface:
- - ``hw/tpm/tpm_tis.c``
+ - ``hw/tpm/tpm_tis_common.c``
+ - ``hw/tpm/tpm_tis_isa.c``
+ - ``hw/tpm/tpm_tis_sysbus.c``
  - ``hw/tpm/tpm_tis.h``
=20
+Both an ISA device and a sysbus device are available. The former is
+used with pc/q35 machine while the later can be instantiated in the
+ARM virt machine.
+
 CRB interface
 -------------
=20
@@ -325,6 +331,23 @@ In case a pSeries machine is emulated, use the followi=
ng command line:
     -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0 \
     -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
=20
+In case an ARM virt machine is emulated, use the following command line:
+
+.. code-block:: console
+
+  qemu-system-aarch64 -machine virt,gic-version=3D3,accel=3Dkvm \
+    -cpu host -m 4G \
+    -nographic -no-acpi \
+    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
+    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
+    -device tpm-tis-device,tpmdev=3Dtpm0 \
+    -device virtio-blk-pci,drive=3Ddrv0 \
+    -drive format=3Dqcow2,file=3Dhda.qcow2,if=3Dnone,id=3Ddrv0 \
+    -drive if=3Dpflash,format=3Draw,file=3Dflash0.img,readonly \
+    -drive if=3Dpflash,format=3Draw,file=3Dflash1.img
+
+  On ARM, ACPI boot with TPM is not yet supported.
+
 In case SeaBIOS is used as firmware, it should show the TPM menu item
 after entering the menu with 'ESC'.
=20
--=20
2.20.1


