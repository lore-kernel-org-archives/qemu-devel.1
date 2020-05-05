Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5052C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AAA206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnpPapm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AAA206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVypW-00075O-MI
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jVyoM-0005KF-Gg
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:44:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jVyoJ-0004XW-Ao
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588689877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MyKZTDKe7F8KBX8ZbYvm6ePCPzPrhuWDkxUqqUlOxPM=;
 b=LnpPapm0M6FTF2lrnhPgxJRKbkRjGqRF006EHD/gohxL9z8WzqW50zwfcNyLYso+eyD4lR
 iMkhgxijVIEDelt28Pvx62M9e4snOPcN+BPfnG0KsXZ87rYVz9uCRUvnhtQA7KpJkhYT6w
 fon4G8EpwlpfZSfBPAr7gqi6AlCDs20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-Jew1JYCqMGOJ4gctq8vBIw-1; Tue, 05 May 2020 10:44:34 -0400
X-MC-Unique: Jew1JYCqMGOJ4gctq8vBIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D03561005510;
 Tue,  5 May 2020 14:44:32 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B16B66079;
 Tue,  5 May 2020 14:44:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com
Subject: [PATCH v2 0/3] vTPM/aarch64 ACPI support
Date: Tue,  5 May 2020 16:44:16 +0200
Message-Id: <20200505144419.29174-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, gshan@redhat.com,
 lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Those patches bring MMIO TPM TIS ACPI support in machvirt.
The first patch moves the TPM2 ACPI table generation code
in the generic code. Then the table is added if the TPM2
sysbus device is dynamically instantiated in machvirt.
Also the TPM2 device object is described in the DSDT.

Many thanks to Ard for his support.

Tested with LUKS partition automatic decryption.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.0-tpm-acpi-v2

History:
v1 -> v2:
- move build_tpm2() in the generic code (Michael)
- collect Stefan's R-b on 3/3

Eric Auger (3):
  acpi: Move build_tpm2() in the generic part
  arm/acpi: TPM2 ACPI table support
  arm/acpi: Add the TPM2.0 device under the DSDT

 include/hw/acpi/aml-build.h |  2 ++
 include/sysemu/tpm.h        |  2 ++
 hw/acpi/aml-build.c         | 31 ++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    | 47 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 30 -----------------------
 5 files changed, 82 insertions(+), 30 deletions(-)

--=20
2.20.1


