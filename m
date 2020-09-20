Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B2C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C24C20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccuHY+/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C24C20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJz8r-0003Aw-Vo
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz40-0006Gb-F0
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJz3k-00017p-IL
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600607235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fJhgpTZkKC74oWQ5PdAX3YyljmGTgjW9AAbng+wIMJU=;
 b=ccuHY+/C7YAlMWfWlWwWoJpa9Z08D6gOs5ogJuNmz5focF6S/Cd6lTvWATqC62T8UUAiJG
 DIEBncA/T02ynz7Ia1Lllwmjsabz1lIPccocmn53wF0e6JE3jJmCYO39E6z1Idu8zbiMNW
 +ouNsuz+hwGsYlUSQ1OIn6boT8qR97c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-wG8bjWhENF-ipikuTE0ekw-1; Sun, 20 Sep 2020 09:07:10 -0400
X-MC-Unique: wG8bjWhENF-ipikuTE0ekw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58ACA1074642
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1948360C47
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:07:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/9] Move target configuration to meson
Date: Sun, 20 Sep 2020 09:06:59 -0400
Message-Id: <20200920130708.1156310-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:07:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Next in the "Meson experiments" series, this one moves target
configuration to meson.  Actually only the accelerator part
(supported_target etc.) is moved, the TARGET_* part of config-target.mak
files become static.  This is more maintainable since the files are
small and change very rarely.

The previous default-configs/ files move to default-configs/devices
(matching config-devices.h) while the previous contents of
config-target.mak now reside in default-configs/targets.

RFC because there are other cleanups that might be worth doing at the
same time, such as removing the gdb-xml/ component of TARGET_XML_FILES,
or using TARGET_ARCH=xtensa instead of TARGET_XTENSA=y.  Some might
also prefer to have a single file for e.g. aarch64-linux-user.mak
and aarch64-softmmu.mak (I refrained from doing so because I wasn't
sure if, in the future, bsd-user and linux-user could conflict).
That said, these probably should be done on top of these patches to keep
the initial conversion simple.

Paolo


Paolo Bonzini (9):
  default-configs: move files to default-configs/devices/
  configure: convert accelerator variables to meson options
  configure: rewrite accelerator defaults as tests
  configure: move accelerator logic to meson
  configure: remove dead variable
  configure: move CONFIG_* symbols to meson
  configure: remove target configuration
  default-configs/targets: remove useless lines
  default-configs: remove default-configs/devices for user-mode targets

 configure                                     | 540 ++----------------
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
 .../targets/aarch64-linux-user.mak            |   5 +
 default-configs/targets/aarch64-softmmu.mak   |   4 +
 .../targets/aarch64_be-linux-user.mak         |   6 +
 default-configs/targets/alpha-linux-user.mak  |   6 +
 default-configs/targets/alpha-softmmu.mak     |   4 +
 default-configs/targets/arm-linux-user.mak    |   7 +
 default-configs/targets/arm-softmmu.mak       |   4 +
 default-configs/targets/armeb-linux-user.mak  |   8 +
 default-configs/targets/avr-softmmu.mak       |   3 +
 default-configs/targets/cris-linux-user.mak   |   3 +
 default-configs/targets/cris-softmmu.mak      |   2 +
 default-configs/targets/hppa-linux-user.mak   |   7 +
 default-configs/targets/hppa-softmmu.mak      |   5 +
 default-configs/targets/i386-bsd-user.mak     |   4 +
 default-configs/targets/i386-linux-user.mak   |   6 +
 default-configs/targets/i386-softmmu.mak      |   4 +
 default-configs/targets/lm32-softmmu.mak      |   3 +
 default-configs/targets/m68k-linux-user.mak   |   8 +
 default-configs/targets/m68k-softmmu.mak      |   4 +
 .../targets/microblaze-linux-user.mak         |   7 +
 .../targets/microblaze-softmmu.mak            |   4 +
 .../targets/microblazeel-linux-user.mak       |   6 +
 .../targets/microblazeel-softmmu.mak          |   3 +
 default-configs/targets/mips-linux-user.mak   |   8 +
 default-configs/targets/mips-softmmu.mak      |   6 +
 default-configs/targets/mips64-linux-user.mak |   8 +
 default-configs/targets/mips64-softmmu.mak    |   5 +
 .../targets/mips64el-linux-user.mak           |   7 +
 default-configs/targets/mips64el-softmmu.mak  |   4 +
 default-configs/targets/mipsel-linux-user.mak |   7 +
 default-configs/targets/mipsel-softmmu.mak    |   5 +
 .../targets/mipsn32-linux-user.mak            |   9 +
 .../targets/mipsn32el-linux-user.mak          |   8 +
 default-configs/targets/moxie-softmmu.mak     |   3 +
 default-configs/targets/nios2-linux-user.mak  |   3 +
 default-configs/targets/nios2-softmmu.mak     |   2 +
 default-configs/targets/or1k-linux-user.mak   |   4 +
 default-configs/targets/or1k-softmmu.mak      |   3 +
 default-configs/targets/ppc-linux-user.mak    |   7 +
 default-configs/targets/ppc-softmmu.mak       |   4 +
 default-configs/targets/ppc64-linux-user.mak  |   7 +
 default-configs/targets/ppc64-softmmu.mak     |   5 +
 .../targets/ppc64abi32-linux-user.mak         |   8 +
 .../targets/ppc64le-linux-user.mak            |   6 +
 .../targets/riscv32-linux-user.mak            |   4 +
 default-configs/targets/riscv32-softmmu.mak   |   4 +
 .../targets/riscv64-linux-user.mak            |   4 +
 default-configs/targets/riscv64-softmmu.mak   |   4 +
 default-configs/targets/rx-softmmu.mak        |   3 +
 default-configs/targets/s390x-linux-user.mak  |   7 +
 default-configs/targets/s390x-softmmu.mak     |   5 +
 default-configs/targets/sh4-linux-user.mak    |   7 +
 default-configs/targets/sh4-softmmu.mak       |   3 +
 default-configs/targets/sh4eb-linux-user.mak  |   8 +
 default-configs/targets/sh4eb-softmmu.mak     |   4 +
 default-configs/targets/sparc-bsd-user.mak    |   5 +
 default-configs/targets/sparc-linux-user.mak  |   7 +
 default-configs/targets/sparc-softmmu.mak     |   4 +
 .../targets/sparc32plus-linux-user.mak        |   8 +
 default-configs/targets/sparc64-bsd-user.mak  |   5 +
 .../targets/sparc64-linux-user.mak            |   7 +
 default-configs/targets/sparc64-softmmu.mak   |   4 +
 default-configs/targets/tilegx-linux-user.mak |   3 +
 default-configs/targets/tricore-softmmu.mak   |   2 +
 default-configs/targets/unicore32-softmmu.mak |   2 +
 default-configs/targets/x86_64-bsd-user.mak   |   4 +
 default-configs/targets/x86_64-linux-user.mak |   6 +
 default-configs/targets/x86_64-softmmu.mak    |   4 +
 default-configs/targets/xtensa-linux-user.mak |   7 +
 default-configs/targets/xtensa-softmmu.mak    |   4 +
 .../targets/xtensaeb-linux-user.mak           |   8 +
 default-configs/targets/xtensaeb-softmmu.mak  |   5 +
 default-configs/tilegx-linux-user.mak         |   1 -
 default-configs/x86_64-bsd-user.mak           |   1 -
 default-configs/x86_64-linux-user.mak         |   1 -
 default-configs/xtensa-linux-user.mak         |   1 -
 default-configs/xtensaeb-linux-user.mak       |   1 -
 meson.build                                   | 154 ++++-
 meson_options.txt                             |  15 +
 148 files changed, 582 insertions(+), 536 deletions(-)
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


