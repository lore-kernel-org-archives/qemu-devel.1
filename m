Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB3DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608862074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb7QsG+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608862074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7Sm-0001Tq-LG
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QI-0006hL-Dg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QF-000280-CX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yqeVee8vsHcrXR3ygfvXtpqFtnUgF1cou0TK5M+nuHA=;
 b=gb7QsG+HKZ8XmfpPZ0yU+Ev78GgYQrj39JIfJuJ91jZsb202ZDcWG72hEfgVK0vFoE0DAp
 AHK7FdcRV++ip1obfdTq40CS2J7WAgoXUupYw2uju8f80TRaTpSnJqZ++nDykpmsRMjacO
 0L2pAzVgY4+NJlFN9DXRMNx2jtpa1VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-aeF3wajaOxGBLaK6hMiw9Q-1; Tue, 16 Jun 2020 04:58:18 -0400
X-MC-Unique: aeF3wajaOxGBLaK6hMiw9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BCBE18585BD;
 Tue, 16 Jun 2020 08:58:17 +0000 (UTC)
Received: from thuth.com (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC8D46ED96;
 Tue, 16 Jun 2020 08:58:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/7] fuzzing and other test-related patches
Date: Tue, 16 Jun 2020 10:58:06 +0200
Message-Id: <20200616085813.29296-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-06-16

for you to fetch changes up to 1ef6bfc23144e0ec7c182301d26b114b3610c8c8:

  configure: Let SLOF be initialized by ./scripts/git-submodule.sh (2020-06-15 18:26:47 +0200)

----------------------------------------------------------------
* Latest fuzzer patches from Alexander
* Fix for the qtest bios-tables-test
* LGPL information cleanup in qtest code
* sh4 acceptance test
* Improved submodule handling for the s390x CI test
----------------------------------------------------------------

Alexander Bulekov (3):
      fuzz: skip QTest serialization
      fuzz: Add support for logging QTest commands
      fuzz: add oss-fuzz build-script

Eric Auger (1):
      bios-tables-test: Fix "-tpmdev: invalid option"

Philippe Mathieu-Daudé (1):
      configure: Let SLOF be initialized by ./scripts/git-submodule.sh

Thomas Huth (2):
      tests/qtest: Fix LGPL information in the file headers
      tests/acceptance: Add boot tests for sh4 QEMU advent calendar image

 .travis.yml                                      |   3 +-
 MAINTAINERS                                      |   1 +
 configure                                        |   5 +
 scripts/oss-fuzz/build.sh                        | 105 ++++++++++
 tests/acceptance/boot_linux_console.py           |  13 +-
 tests/qtest/bios-tables-test.c                   |   4 +
 tests/qtest/e1000e-test.c                        |   2 +-
 tests/qtest/fuzz/Makefile.include                |  21 ++
 tests/qtest/fuzz/fuzz.c                          |  20 +-
 tests/qtest/fuzz/fuzz.h                          |   3 +
 tests/qtest/fuzz/qos_fuzz.c                      |   2 +-
 tests/qtest/fuzz/qtest_wrappers.c                | 252 +++++++++++++++++++++++
 tests/qtest/libqos/aarch64-xlnx-zcu102-machine.c |   2 +-
 tests/qtest/libqos/arm-imx25-pdk-machine.c       |   2 +-
 tests/qtest/libqos/arm-n800-machine.c            |   2 +-
 tests/qtest/libqos/arm-raspi2-machine.c          |   2 +-
 tests/qtest/libqos/arm-sabrelite-machine.c       |   2 +-
 tests/qtest/libqos/arm-smdkc210-machine.c        |   2 +-
 tests/qtest/libqos/arm-virt-machine.c            |   2 +-
 tests/qtest/libqos/arm-xilinx-zynq-a9-machine.c  |   2 +-
 tests/qtest/libqos/e1000e.c                      |   2 +-
 tests/qtest/libqos/e1000e.h                      |   2 +-
 tests/qtest/libqos/ppc64_pseries-machine.c       |   2 +-
 tests/qtest/libqos/qgraph.c                      |   2 +-
 tests/qtest/libqos/qgraph.h                      |   2 +-
 tests/qtest/libqos/qgraph_internal.h             |   2 +-
 tests/qtest/libqos/qos_external.c                |   2 +-
 tests/qtest/libqos/qos_external.h                |   2 +-
 tests/qtest/libqos/sdhci.c                       |   2 +-
 tests/qtest/libqos/sdhci.h                       |   2 +-
 tests/qtest/libqos/virtio-9p.c                   |   2 +-
 tests/qtest/libqos/virtio-9p.h                   |   2 +-
 tests/qtest/libqos/virtio-balloon.c              |   2 +-
 tests/qtest/libqos/virtio-balloon.h              |   2 +-
 tests/qtest/libqos/virtio-blk.c                  |   2 +-
 tests/qtest/libqos/virtio-blk.h                  |   2 +-
 tests/qtest/libqos/virtio-net.c                  |   2 +-
 tests/qtest/libqos/virtio-net.h                  |   2 +-
 tests/qtest/libqos/virtio-rng.c                  |   2 +-
 tests/qtest/libqos/virtio-rng.h                  |   2 +-
 tests/qtest/libqos/virtio-scsi.c                 |   2 +-
 tests/qtest/libqos/virtio-scsi.h                 |   2 +-
 tests/qtest/libqos/virtio-serial.c               |   2 +-
 tests/qtest/libqos/virtio-serial.h               |   2 +-
 tests/qtest/libqos/x86_64_pc-machine.c           |   2 +-
 tests/qtest/qos-test.c                           |   2 +-
 46 files changed, 458 insertions(+), 41 deletions(-)
 create mode 100755 scripts/oss-fuzz/build.sh
 create mode 100644 tests/qtest/fuzz/qtest_wrappers.c


