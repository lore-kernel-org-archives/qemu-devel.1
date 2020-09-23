Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A341C4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E88321D91
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyzVd681"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E88321D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0vS-00033J-MW
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oU-0001Br-RH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oL-0002Mi-TP
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kIbe5Su/KTYRW2P7wBbbQhrV7maafrxD4QnO7h3dG0E=;
 b=IyzVd681bfhFvgMxNS41TtHLBWNpyz8VrEuMMJJ5k+nlO9QABSvx4o6unBno8l3lPbDi55
 g91i8LnYKirV8LQafgfce01Q0pyu03jGn0iImfneBWPVMG0fGqqC55avl+6aJi2wVdab0L
 cMY+PS8jNBGvLenNrFz+OS2WScePpSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-CSfTxgdfNvmSwxinmBzyTQ-1; Wed, 23 Sep 2020 05:11:33 -0400
X-MC-Unique: CSfTxgdfNvmSwxinmBzyTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67A9D802B68;
 Wed, 23 Sep 2020 09:11:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBEE55D9CC;
 Wed, 23 Sep 2020 09:11:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] Move target configuration to Meson
Date: Wed, 23 Sep 2020 05:11:19 -0400
Message-Id: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With configure+make, the creation of the config-target.h files was
detached from the build and had to be shared with config-host.h.
With meson, using separate configure_files to format config-host.h
and config-target.h comes for free; therefore we can craft the
configure_file input independent of what the .mak configuration looks
like.

The other part of config-target.mak is accelerators, where the
detection code is easily moved to meson.

This lets us simplify the .mak configuration to the point that we
can just keep it in default-configs/ and drop the code that generates
it.

Compared to the RFC this mostly fixes a bunch of small issues found
by Richard, and completes the simplification of configuration files:
it introduces a TARGET_ARCH key and removes TARGET_BASE_ARCH and
TARGET_ABI_DIR if they concide with TARGET_ARCH.

Paolo Bonzini (12):
  default-configs: move files to default-configs/devices/
  configure: convert accelerator variables to meson options
  configure: rewrite accelerator defaults as tests
  configure: move accelerator logic to meson
  configure: remove dead variable
  configure: move CONFIG_* symbols to meson
  configure: remove useless config-target.mak symbols
  configure: remove target configuration
  default-configs: remove default-configs/devices for user-mode targets
  configure: move OpenBSD W^X test to meson
  default-configs: use TARGET_ARCH key
  default-configs: remove redundant keys

 configure                                     | 586 ++----------------
 default-configs/aarch64-linux-user.mak        |   1 -
 default-configs/aarch64_be-linux-user.mak     |   1 -
 default-configs/alpha-linux-user.mak          |   1 -
 default-configs/arm-linux-user.mak            |   1 -
 default-configs/armeb-linux-user.mak          |   1 -
 default-configs/cris-linux-user.mak           |   1 -
 .../{ => devices}/aarch64-softmmu.mak         |   0
 .../{ => devices}/alpha-softmmu.mak           |   0
 default-configs/{ => devices}/arm-softmmu.mak |   0
 default-configs/{ => devices}/avr-softmmu.mak |   0
 .../{ => devices}/cris-softmmu.mak            |   0
 .../{ => devices}/hppa-softmmu.mak            |   0
 .../{ => devices}/i386-softmmu.mak            |   0
 .../{ => devices}/lm32-softmmu.mak            |   0
 .../{ => devices}/m68k-softmmu.mak            |   0
 .../{ => devices}/microblaze-softmmu.mak      |   0
 .../{ => devices}/microblazeel-softmmu.mak    |   0
 .../{ => devices}/mips-softmmu-common.mak     |   0
 .../{ => devices}/mips-softmmu.mak            |   0
 .../{ => devices}/mips64-softmmu.mak          |   0
 .../{ => devices}/mips64el-softmmu.mak        |   0
 .../{ => devices}/mipsel-softmmu.mak          |   0
 .../{ => devices}/moxie-softmmu.mak           |   0
 .../{ => devices}/nios2-softmmu.mak           |   0
 .../{ => devices}/or1k-softmmu.mak            |   0
 default-configs/{ => devices}/ppc-softmmu.mak |   0
 .../{ => devices}/ppc64-softmmu.mak           |   0
 .../{ => devices}/riscv32-softmmu.mak         |   0
 .../{ => devices}/riscv64-softmmu.mak         |   0
 default-configs/{ => devices}/rx-softmmu.mak  |   0
 .../{ => devices}/s390x-softmmu.mak           |   0
 default-configs/{ => devices}/sh4-softmmu.mak |   0
 .../{ => devices}/sh4eb-softmmu.mak           |   0
 .../{ => devices}/sparc-softmmu.mak           |   0
 .../{ => devices}/sparc64-softmmu.mak         |   0
 .../{ => devices}/tricore-softmmu.mak         |   0
 .../{ => devices}/unicore32-softmmu.mak       |   0
 .../{ => devices}/x86_64-softmmu.mak          |   0
 .../{ => devices}/xtensa-softmmu.mak          |   0
 .../{ => devices}/xtensaeb-softmmu.mak        |   0
 default-configs/hppa-linux-user.mak           |   1 -
 default-configs/i386-bsd-user.mak             |   1 -
 default-configs/i386-linux-user.mak           |   1 -
 default-configs/m68k-linux-user.mak           |   1 -
 default-configs/microblaze-linux-user.mak     |   1 -
 default-configs/microblazeel-linux-user.mak   |   1 -
 default-configs/mips-linux-user.mak           |   1 -
 default-configs/mips64-linux-user.mak         |   1 -
 default-configs/mips64el-linux-user.mak       |   1 -
 default-configs/mipsel-linux-user.mak         |   1 -
 default-configs/mipsn32-linux-user.mak        |   1 -
 default-configs/mipsn32el-linux-user.mak      |   1 -
 default-configs/nios2-linux-user.mak          |   1 -
 default-configs/or1k-linux-user.mak           |   1 -
 default-configs/ppc-linux-user.mak            |   1 -
 default-configs/ppc64-linux-user.mak          |   1 -
 default-configs/ppc64abi32-linux-user.mak     |   1 -
 default-configs/ppc64le-linux-user.mak        |   1 -
 default-configs/riscv32-linux-user.mak        |   1 -
 default-configs/riscv64-linux-user.mak        |   1 -
 default-configs/s390x-linux-user.mak          |   1 -
 default-configs/sh4-linux-user.mak            |   1 -
 default-configs/sh4eb-linux-user.mak          |   1 -
 default-configs/sparc-bsd-user.mak            |   1 -
 default-configs/sparc-linux-user.mak          |   1 -
 default-configs/sparc32plus-linux-user.mak    |   1 -
 default-configs/sparc64-bsd-user.mak          |   1 -
 default-configs/sparc64-linux-user.mak        |   1 -
 .../targets/aarch64-linux-user.mak            |   4 +
 default-configs/targets/aarch64-softmmu.mak   |   4 +
 .../targets/aarch64_be-linux-user.mak         |   5 +
 default-configs/targets/alpha-linux-user.mak  |   4 +
 default-configs/targets/alpha-softmmu.mak     |   3 +
 default-configs/targets/arm-linux-user.mak    |   5 +
 default-configs/targets/arm-softmmu.mak       |   3 +
 default-configs/targets/armeb-linux-user.mak  |   6 +
 default-configs/targets/avr-softmmu.mak       |   2 +
 default-configs/targets/cris-linux-user.mak   |   1 +
 default-configs/targets/cris-softmmu.mak      |   1 +
 default-configs/targets/hppa-linux-user.mak   |   5 +
 default-configs/targets/hppa-softmmu.mak      |   4 +
 default-configs/targets/i386-bsd-user.mak     |   2 +
 default-configs/targets/i386-linux-user.mak   |   4 +
 default-configs/targets/i386-softmmu.mak      |   3 +
 default-configs/targets/lm32-softmmu.mak      |   2 +
 default-configs/targets/m68k-linux-user.mak   |   6 +
 default-configs/targets/m68k-softmmu.mak      |   3 +
 .../targets/microblaze-linux-user.mak         |   5 +
 .../targets/microblaze-softmmu.mak            |   3 +
 .../targets/microblazeel-linux-user.mak       |   4 +
 .../targets/microblazeel-softmmu.mak          |   2 +
 default-configs/targets/mips-linux-user.mak   |   6 +
 default-configs/targets/mips-softmmu.mak      |   4 +
 default-configs/targets/mips64-linux-user.mak |   7 +
 default-configs/targets/mips64-softmmu.mak    |   4 +
 .../targets/mips64el-linux-user.mak           |   6 +
 default-configs/targets/mips64el-softmmu.mak  |   3 +
 default-configs/targets/mipsel-linux-user.mak |   5 +
 default-configs/targets/mipsel-softmmu.mak    |   3 +
 .../targets/mipsn32-linux-user.mak            |   8 +
 .../targets/mipsn32el-linux-user.mak          |   7 +
 default-configs/targets/moxie-softmmu.mak     |   2 +
 default-configs/targets/nios2-linux-user.mak  |   1 +
 default-configs/targets/nios2-softmmu.mak     |   1 +
 default-configs/targets/or1k-linux-user.mak   |   2 +
 default-configs/targets/or1k-softmmu.mak      |   2 +
 default-configs/targets/ppc-linux-user.mak    |   5 +
 default-configs/targets/ppc-softmmu.mak       |   3 +
 default-configs/targets/ppc64-linux-user.mak  |   7 +
 default-configs/targets/ppc64-softmmu.mak     |   5 +
 .../targets/ppc64abi32-linux-user.mak         |   8 +
 .../targets/ppc64le-linux-user.mak            |   6 +
 .../targets/riscv32-linux-user.mak            |   4 +
 default-configs/targets/riscv32-softmmu.mak   |   4 +
 .../targets/riscv64-linux-user.mak            |   4 +
 default-configs/targets/riscv64-softmmu.mak   |   4 +
 default-configs/targets/rx-softmmu.mak        |   2 +
 default-configs/targets/s390x-linux-user.mak  |   5 +
 default-configs/targets/s390x-softmmu.mak     |   4 +
 default-configs/targets/sh4-linux-user.mak    |   5 +
 default-configs/targets/sh4-softmmu.mak       |   2 +
 default-configs/targets/sh4eb-linux-user.mak  |   6 +
 default-configs/targets/sh4eb-softmmu.mak     |   3 +
 default-configs/targets/sparc-bsd-user.mak    |   3 +
 default-configs/targets/sparc-linux-user.mak  |   5 +
 default-configs/targets/sparc-softmmu.mak     |   3 +
 .../targets/sparc32plus-linux-user.mak        |   8 +
 default-configs/targets/sparc64-bsd-user.mak  |   4 +
 .../targets/sparc64-linux-user.mak            |   6 +
 default-configs/targets/sparc64-softmmu.mak   |   4 +
 default-configs/targets/tilegx-linux-user.mak |   1 +
 default-configs/targets/tricore-softmmu.mak   |   1 +
 default-configs/targets/unicore32-softmmu.mak |   1 +
 default-configs/targets/x86_64-bsd-user.mak   |   3 +
 default-configs/targets/x86_64-linux-user.mak |   5 +
 default-configs/targets/x86_64-softmmu.mak    |   4 +
 default-configs/targets/xtensa-linux-user.mak |   5 +
 default-configs/targets/xtensa-softmmu.mak    |   3 +
 .../targets/xtensaeb-linux-user.mak           |   6 +
 default-configs/targets/xtensaeb-softmmu.mak  |   4 +
 default-configs/tilegx-linux-user.mak         |   1 -
 default-configs/x86_64-bsd-user.mak           |   1 -
 default-configs/x86_64-linux-user.mak         |   1 -
 default-configs/xtensa-linux-user.mak         |   1 -
 default-configs/xtensaeb-linux-user.mak       |   1 -
 meson.build                                   | 181 +++++-
 meson_options.txt                             |  15 +
 148 files changed, 522 insertions(+), 584 deletions(-)
 delete mode 100644 default-configs/aarch64-linux-user.mak
 delete mode 100644 default-configs/aarch64_be-linux-user.mak
 delete mode 100644 default-configs/alpha-linux-user.mak
 delete mode 100644 default-configs/arm-linux-user.mak
 delete mode 100644 default-configs/armeb-linux-user.mak
 delete mode 100644 default-configs/cris-linux-user.mak
 rename default-configs/{ => devices}/aarch64-softmmu.mak (100%)
 rename default-configs/{ => devices}/alpha-softmmu.mak (100%)
 rename default-configs/{ => devices}/arm-softmmu.mak (100%)
 rename default-configs/{ => devices}/avr-softmmu.mak (100%)
 rename default-configs/{ => devices}/cris-softmmu.mak (100%)
 rename default-configs/{ => devices}/hppa-softmmu.mak (100%)
 rename default-configs/{ => devices}/i386-softmmu.mak (100%)
 rename default-configs/{ => devices}/lm32-softmmu.mak (100%)
 rename default-configs/{ => devices}/m68k-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblaze-softmmu.mak (100%)
 rename default-configs/{ => devices}/microblazeel-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu-common.mak (100%)
 rename default-configs/{ => devices}/mips-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64-softmmu.mak (100%)
 rename default-configs/{ => devices}/mips64el-softmmu.mak (100%)
 rename default-configs/{ => devices}/mipsel-softmmu.mak (100%)
 rename default-configs/{ => devices}/moxie-softmmu.mak (100%)
 rename default-configs/{ => devices}/nios2-softmmu.mak (100%)
 rename default-configs/{ => devices}/or1k-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc-softmmu.mak (100%)
 rename default-configs/{ => devices}/ppc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/riscv32-softmmu.mak (100%)
 rename default-configs/{ => devices}/riscv64-softmmu.mak (100%)
 rename default-configs/{ => devices}/rx-softmmu.mak (100%)
 rename default-configs/{ => devices}/s390x-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4-softmmu.mak (100%)
 rename default-configs/{ => devices}/sh4eb-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc-softmmu.mak (100%)
 rename default-configs/{ => devices}/sparc64-softmmu.mak (100%)
 rename default-configs/{ => devices}/tricore-softmmu.mak (100%)
 rename default-configs/{ => devices}/unicore32-softmmu.mak (100%)
 rename default-configs/{ => devices}/x86_64-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensa-softmmu.mak (100%)
 rename default-configs/{ => devices}/xtensaeb-softmmu.mak (100%)
 delete mode 100644 default-configs/hppa-linux-user.mak
 delete mode 100644 default-configs/i386-bsd-user.mak
 delete mode 100644 default-configs/i386-linux-user.mak
 delete mode 100644 default-configs/m68k-linux-user.mak
 delete mode 100644 default-configs/microblaze-linux-user.mak
 delete mode 100644 default-configs/microblazeel-linux-user.mak
 delete mode 100644 default-configs/mips-linux-user.mak
 delete mode 100644 default-configs/mips64-linux-user.mak
 delete mode 100644 default-configs/mips64el-linux-user.mak
 delete mode 100644 default-configs/mipsel-linux-user.mak
 delete mode 100644 default-configs/mipsn32-linux-user.mak
 delete mode 100644 default-configs/mipsn32el-linux-user.mak
 delete mode 100644 default-configs/nios2-linux-user.mak
 delete mode 100644 default-configs/or1k-linux-user.mak
 delete mode 100644 default-configs/ppc-linux-user.mak
 delete mode 100644 default-configs/ppc64-linux-user.mak
 delete mode 100644 default-configs/ppc64abi32-linux-user.mak
 delete mode 100644 default-configs/ppc64le-linux-user.mak
 delete mode 100644 default-configs/riscv32-linux-user.mak
 delete mode 100644 default-configs/riscv64-linux-user.mak
 delete mode 100644 default-configs/s390x-linux-user.mak
 delete mode 100644 default-configs/sh4-linux-user.mak
 delete mode 100644 default-configs/sh4eb-linux-user.mak
 delete mode 100644 default-configs/sparc-bsd-user.mak
 delete mode 100644 default-configs/sparc-linux-user.mak
 delete mode 100644 default-configs/sparc32plus-linux-user.mak
 delete mode 100644 default-configs/sparc64-bsd-user.mak
 delete mode 100644 default-configs/sparc64-linux-user.mak
 create mode 100644 default-configs/targets/aarch64-linux-user.mak
 create mode 100644 default-configs/targets/aarch64-softmmu.mak
 create mode 100644 default-configs/targets/aarch64_be-linux-user.mak
 create mode 100644 default-configs/targets/alpha-linux-user.mak
 create mode 100644 default-configs/targets/alpha-softmmu.mak
 create mode 100644 default-configs/targets/arm-linux-user.mak
 create mode 100644 default-configs/targets/arm-softmmu.mak
 create mode 100644 default-configs/targets/armeb-linux-user.mak
 create mode 100644 default-configs/targets/avr-softmmu.mak
 create mode 100644 default-configs/targets/cris-linux-user.mak
 create mode 100644 default-configs/targets/cris-softmmu.mak
 create mode 100644 default-configs/targets/hppa-linux-user.mak
 create mode 100644 default-configs/targets/hppa-softmmu.mak
 create mode 100644 default-configs/targets/i386-bsd-user.mak
 create mode 100644 default-configs/targets/i386-linux-user.mak
 create mode 100644 default-configs/targets/i386-softmmu.mak
 create mode 100644 default-configs/targets/lm32-softmmu.mak
 create mode 100644 default-configs/targets/m68k-linux-user.mak
 create mode 100644 default-configs/targets/m68k-softmmu.mak
 create mode 100644 default-configs/targets/microblaze-linux-user.mak
 create mode 100644 default-configs/targets/microblaze-softmmu.mak
 create mode 100644 default-configs/targets/microblazeel-linux-user.mak
 create mode 100644 default-configs/targets/microblazeel-softmmu.mak
 create mode 100644 default-configs/targets/mips-linux-user.mak
 create mode 100644 default-configs/targets/mips-softmmu.mak
 create mode 100644 default-configs/targets/mips64-linux-user.mak
 create mode 100644 default-configs/targets/mips64-softmmu.mak
 create mode 100644 default-configs/targets/mips64el-linux-user.mak
 create mode 100644 default-configs/targets/mips64el-softmmu.mak
 create mode 100644 default-configs/targets/mipsel-linux-user.mak
 create mode 100644 default-configs/targets/mipsel-softmmu.mak
 create mode 100644 default-configs/targets/mipsn32-linux-user.mak
 create mode 100644 default-configs/targets/mipsn32el-linux-user.mak
 create mode 100644 default-configs/targets/moxie-softmmu.mak
 create mode 100644 default-configs/targets/nios2-linux-user.mak
 create mode 100644 default-configs/targets/nios2-softmmu.mak
 create mode 100644 default-configs/targets/or1k-linux-user.mak
 create mode 100644 default-configs/targets/or1k-softmmu.mak
 create mode 100644 default-configs/targets/ppc-linux-user.mak
 create mode 100644 default-configs/targets/ppc-softmmu.mak
 create mode 100644 default-configs/targets/ppc64-linux-user.mak
 create mode 100644 default-configs/targets/ppc64-softmmu.mak
 create mode 100644 default-configs/targets/ppc64abi32-linux-user.mak
 create mode 100644 default-configs/targets/ppc64le-linux-user.mak
 create mode 100644 default-configs/targets/riscv32-linux-user.mak
 create mode 100644 default-configs/targets/riscv32-softmmu.mak
 create mode 100644 default-configs/targets/riscv64-linux-user.mak
 create mode 100644 default-configs/targets/riscv64-softmmu.mak
 create mode 100644 default-configs/targets/rx-softmmu.mak
 create mode 100644 default-configs/targets/s390x-linux-user.mak
 create mode 100644 default-configs/targets/s390x-softmmu.mak
 create mode 100644 default-configs/targets/sh4-linux-user.mak
 create mode 100644 default-configs/targets/sh4-softmmu.mak
 create mode 100644 default-configs/targets/sh4eb-linux-user.mak
 create mode 100644 default-configs/targets/sh4eb-softmmu.mak
 create mode 100644 default-configs/targets/sparc-bsd-user.mak
 create mode 100644 default-configs/targets/sparc-linux-user.mak
 create mode 100644 default-configs/targets/sparc-softmmu.mak
 create mode 100644 default-configs/targets/sparc32plus-linux-user.mak
 create mode 100644 default-configs/targets/sparc64-bsd-user.mak
 create mode 100644 default-configs/targets/sparc64-linux-user.mak
 create mode 100644 default-configs/targets/sparc64-softmmu.mak
 create mode 100644 default-configs/targets/tilegx-linux-user.mak
 create mode 100644 default-configs/targets/tricore-softmmu.mak
 create mode 100644 default-configs/targets/unicore32-softmmu.mak
 create mode 100644 default-configs/targets/x86_64-bsd-user.mak
 create mode 100644 default-configs/targets/x86_64-linux-user.mak
 create mode 100644 default-configs/targets/x86_64-softmmu.mak
 create mode 100644 default-configs/targets/xtensa-linux-user.mak
 create mode 100644 default-configs/targets/xtensa-softmmu.mak
 create mode 100644 default-configs/targets/xtensaeb-linux-user.mak
 create mode 100644 default-configs/targets/xtensaeb-softmmu.mak
 delete mode 100644 default-configs/tilegx-linux-user.mak
 delete mode 100644 default-configs/x86_64-bsd-user.mak
 delete mode 100644 default-configs/x86_64-linux-user.mak
 delete mode 100644 default-configs/xtensa-linux-user.mak
 delete mode 100644 default-configs/xtensaeb-linux-user.mak

-- 
2.26.2


