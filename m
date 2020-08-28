Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D3E207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT4UHRnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D3E207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcFE-0002Z0-0z
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcEX-0001d7-NW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:07:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcEV-0000NK-7q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+WGJ9vUMr0j8FvZHWjtFOeajR576tFt25ckBZ1qJg2k=;
 b=RT4UHRnvK09Wzw+Q1OPif4l2fX47ElkDboRRkrefS3Fw08LoSPzd0RPwfoChv4oKOl4Ml/
 3yRAeXbrdSQeX7kPj4ds09NvwXUaB5PoaV4l1wO40P5ndfhZlNR06zyPlJYCgrKu4ZkgkB
 Fk1m+jbuzEuXLrWemSWrwnaepSOYAA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-lwYpoTnGPQyIz6gXT8uXJA-1; Fri, 28 Aug 2020 07:07:41 -0400
X-MC-Unique: lwYpoTnGPQyIz6gXT8uXJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3261007474
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:07:40 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3941960FC2;
 Fri, 28 Aug 2020 11:07:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] meson: convert unit tests in tests/Makefile.include
Date: Fri, 28 Aug 2020 15:07:18 +0400
Message-Id: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 07:07:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>=0D

Hi,=0D
=0D
This series convert the unit tests from tests/Makefile.include to meson.=0D
=0D
Based-on: <20200823111757.72002-2-thuth@redhat.com>=0D
=0D
Marc-Andr=C3=A9 Lureau (16):=0D
  meson: build qapi tests library=0D
  meson: declare tasn1 dependency=0D
  meson: declare keyutils dependency=0D
  meson: convert qht-bench=0D
  tests: qga has virtio-serial by default when host has it=0D
  meson: convert the unit tests=0D
  meson: move keyutils dependency check=0D
  meson: remove old socket_scm_helper rule=0D
  meson: convert vhost-user-bridge=0D
  meson: convert atomic*-bench=0D
  tests/Makefile.include: update check-build=0D
  tests: do not print benchmark output to stdout=0D
  meson: convert the speed tests=0D
  tests/migration/stress: remove unused exit_success=0D
  meson: fix migration/stress compilation with glib>=3D2.30=0D
  meson: convert migration/initrd-stress=0D
=0D
 Makefile                         |   2 +-=0D
 configure                        |  25 ---=0D
 meson.build                      |  10 +=0D
 scripts/mtest2make.py            |   3 +-=0D
 tests/Makefile.include           | 368 +------------------------------=0D
 tests/benchmark-crypto-cipher.c  |   8 +-=0D
 tests/benchmark-crypto-hash.c    |   2 +-=0D
 tests/benchmark-crypto-hmac.c    |   8 +-=0D
 tests/include/meson.build        |  13 ++=0D
 tests/meson.build                | 253 +++++++++++++++++++++=0D
 tests/migration/initrd-stress.sh |  10 +=0D
 tests/migration/meson.build      |  14 ++=0D
 tests/migration/stress.c         |  15 +-=0D
 tests/test-crypto-secret.c       |  10 +-=0D
 tests/test-qga.c                 |   4 +-=0D
 15 files changed, 325 insertions(+), 420 deletions(-)=0D
 create mode 100644 tests/include/meson.build=0D
 create mode 100755 tests/migration/initrd-stress.sh=0D
 create mode 100644 tests/migration/meson.build=0D
=0D
--=20=0D
2.26.2=0D
=0D


