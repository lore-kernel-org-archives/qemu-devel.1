Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8521C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCB72137B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbIeOzDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCB72137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIdDl-0003Hf-Q1
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 15:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kId93-00008m-En
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kId91-00017u-4Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 15:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600284666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zj3TMA81I4iWD7nxOaryasIsqrN5Ai7INhWOx+tqX7Y=;
 b=LbIeOzDLTaj+iOTjE33gNx3W5Rl7lYJ5E549zeidV3aEsFbjlf6fIa59nCktrgTDLvOPtE
 45oaNDk5SR+L8mY3tleVHNyr3NKjiAn03V0dXgBLFVW3BIYe0Vf9sUx5e6c/FSTT2q6LhH
 I5XjzP1VUAWDA2+fTJyYYhfSjfgU1BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377--ba-3r1BOoyEKwmU_2OZlQ-1; Wed, 16 Sep 2020 15:31:04 -0400
X-MC-Unique: -ba-3r1BOoyEKwmU_2OZlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68CD010A7AE1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 19:31:03 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25FDC1001281;
 Wed, 16 Sep 2020 19:31:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK
Date: Wed, 16 Sep 2020 15:30:58 -0400
Message-Id: <20200916193101.511600-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series replaces INTERFACE_CHECK with OBJECT_CHECK because=0D
both macros are exactly the same.=0D
=0D
The last patch is a new run of the OBJECT_CHECK ->=0D
DECLARE*_CHECKER* converter script that will convert the former=0D
INTERFACE_CHECK-based macros.=0D
=0D
Eduardo Habkost (3):=0D
  qom: Correct object_class_dynamic_cast_assert() documentation=0D
  qom: Replace INTERFACE_CHECK with OBJECT_CHECK=0D
  [automated] Use DECLARE_*CHECKER* macros=0D
=0D
 include/hw/acpi/acpi_dev_interface.h |  7 +++----=0D
 include/hw/arm/linux-boot-if.h       |  6 +++---=0D
 include/hw/fw-path-provider.h        |  6 +++---=0D
 include/hw/hotplug.h                 |  6 +++---=0D
 include/hw/intc/intc.h               |  7 +++----=0D
 include/hw/ipmi/ipmi.h               |  6 +++---=0D
 include/hw/isa/isa.h                 |  2 +-=0D
 include/hw/mem/memory-device.h       |  6 +++---=0D
 include/hw/nmi.h                     |  6 +++---=0D
 include/hw/ppc/pnv_xscom.h           |  4 ++--=0D
 include/hw/ppc/spapr_irq.h           |  4 ++--=0D
 include/hw/ppc/xics.h                |  4 ++--=0D
 include/hw/ppc/xive.h                | 12 ++++++------=0D
 include/hw/rdma/rdma.h               |  7 +++----=0D
 include/hw/rtc/m48t59.h              |  6 +++---=0D
 include/hw/stream.h                  |  6 +++---=0D
 include/hw/vmstate-if.h              |  6 +++---=0D
 include/qom/object.h                 | 14 +-------------=0D
 include/qom/object_interfaces.h      |  7 +++----=0D
 include/sysemu/tpm.h                 |  6 +++---=0D
 target/arm/idau.h                    |  6 +++---=0D
 tests/check-qom-interface.c          |  6 +++---=0D
 22 files changed, 62 insertions(+), 78 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


