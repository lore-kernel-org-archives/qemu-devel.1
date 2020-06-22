Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9085BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C893206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8e3xmlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C893206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnN8F-0005X1-KR
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jnN5w-0001Nf-5c
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:06:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jnN5t-0001LL-H5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kb4b2u2D+hDVjMK3AtOKfyuntg0TCQsTrXWQeVXOQDs=;
 b=S8e3xmlXL/ylILDhcoQa8qkDx+UWNENe1kVYgw+aaT5XOvjX8PUEn/kSyvz4ruVHO4GV6z
 sS2TbRbGjyqBjGfg2sF9/iXkRq94q+2Z81IErcGv9jhR8VI7MtoM6vTOK4rFRUq5iQ3RM7
 BjEefyEHZ0dqT5YgIcAc6hgsK4kDjfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-ljpBv7fKOGq170MQPSkLAQ-1; Mon, 22 Jun 2020 10:06:36 -0400
X-MC-Unique: ljpBv7fKOGq170MQPSkLAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B4F107ACCD;
 Mon, 22 Jun 2020 14:06:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98F2D27CC9;
 Mon, 22 Jun 2020 14:06:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, imammedo@redhat.com
Subject: [PATCH v7 0/3] vTPM/aarch64 ACPI support
Date: Mon, 22 Jun 2020 16:06:17 +0200
Message-Id: <20200622140620.17229-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, lersek@redhat.com, drjones@redhat.com,
 shannon.zhaosl@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Those patches bring MMIO TPM TIS ACPI support in machvirt.

On ARM, the TPM2 table is added when the TPM TIS sysbus
device is dynamically instantiated in machvirt.

Also the TPM2 device object is described in the DSDT.

Many thanks to Ard for his support.

Tested with LUKS partition automatic decryption. Also
tested with new bios-tables-test dedicated tests,
sent separately.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.0-tpm-acpi-v7

History:

v6 -> v7:
- Collected Stefan and Igor's R-bs
- Eventually removed Acpi20TPM2 struct
- Updated the reference to the spec v1.2 rev8

v5 -> v6:
- added reference to the spec
- add some comments about LAML and LASA fields which are
  strangely undocumented in the spec for TPM2.0. So I kept
  the decision to keep the Acpi20TPM2 struct for documentation
  purpose.

v4 -> v5:
- Move of build_tpm2() in the generic acpi code was upstreamed
  but this does not correspond to latest proposed version.
- Rebase on top of edfcb1f21a

v3 -> v4:
- some rework in build_tpm2() as suggested by Igor
- Restored tpm presence check in acpi_dsdt_add_tpm()
- add the doc related patch

v2 -> v3:
- Rebase on top of Stefan's
  "acpi: tpm: Do not build TCPA table for TPM 2"
- brings conversion to build_append

v1 -> v2:
- move build_tpm2() in the generic code (Michael)
- collect Stefan's R-b on 3/3

Eric Auger (3):
  acpi: Some build_tpm2() code reshape
  arm/acpi: Add the TPM2.0 device under the DSDT
  docs/specs/tpm: ACPI boot now supported for TPM/ARM

 docs/specs/tpm.rst          |  2 --
 include/hw/acpi/acpi-defs.h | 18 -------------
 hw/acpi/aml-build.c         | 51 +++++++++++++++++++++++--------------
 hw/arm/virt-acpi-build.c    | 34 +++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 39 deletions(-)

-- 
2.20.1


