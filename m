Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE83C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DE120672
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OerXaH1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DE120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzGn-0001vB-21
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqzDi-0004k1-6S
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:25:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqzDf-000753-2s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8F61MPUWIuL+UDRPW5HRplfZ3s+DQv6nxjq2UI+t/9o=;
 b=OerXaH1MHNCoZFVVkT23phkOPdt73JEraP8C2cEex8BmYTanMuB4Kbcg1ASKOWKgPQbOLi
 P9Sz8CWor1aDX0GupZiSClfwEsLntwVlnLPU7suCkkD8kSXPX03rC8P7RS7L2s5VHzFhIM
 T87wt98xSOrQROZsdekLfNmkx+E+2x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Ppz7FedQPjyx6D7WlNO9pQ-1; Thu, 02 Jul 2020 09:25:36 -0400
X-MC-Unique: Ppz7FedQPjyx6D7WlNO9pQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C37A4800C60;
 Thu,  2 Jul 2020 13:25:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1605DD61;
 Thu,  2 Jul 2020 13:25:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 128DC31E85; Thu,  2 Jul 2020 15:25:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/20] audio: deprecate -soundhw
Date: Thu,  2 Jul 2020 15:25:05 +0200
Message-Id: <20200702132525.6849-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
 - use g_assert_not_reached() for stubs.
 - add deprecation notice.

v3:
 - rebase to latest master.
 - adapt to armbru's device initialization changes.

v4:
 - reorder patches, drop temporary -global setup,
   go straight to -machine pcspk-audiodev= instead.
 - update error messages and documentation accordingly.

v5:
 - spell fixes (Eric).
 - fix mips build error.

Gerd Hoffmann (20):
  stubs: add isa_create_simple
  stubs: add pci_create_simple
  audio: add deprecated_register_soundhw
  audio: deprecate -soundhw ac97
  audio: deprecate -soundhw es1370
  audio: deprecate -soundhw adlib
  audio: deprecate -soundhw cs4231a
  audio: deprecate -soundhw gus
  audio: deprecate -soundhw sb16
  audio: deprecate -soundhw hda
  pc_basic_device_init: pass PCMachineState
  pc_basic_device_init: drop has_pit arg
  pc_basic_device_init: drop no_vmport arg
  softmmu: initialize spice and audio earlier
  audio: rework pcspk_init()
  audio: create pcspk device early
  audio: deprecate -soundhw pcspk
  audio: add soundhw deprecation notice
  pcspk: update docs/system/target-i386-desc.rst.inc
  audio: set default value for pcspk.iobase property

 include/hw/audio/pcspk.h             | 12 ++----------
 include/hw/audio/soundhw.h           |  2 ++
 include/hw/i386/pc.h                 |  6 +++---
 hw/audio/ac97.c                      |  9 ++-------
 hw/audio/adlib.c                     |  8 +-------
 hw/audio/cs4231a.c                   |  8 +-------
 hw/audio/es1370.c                    |  9 ++-------
 hw/audio/gus.c                       |  8 +-------
 hw/audio/intel-hda.c                 |  3 +++
 hw/audio/pcspk.c                     | 26 ++++++++++++++++++++++----
 hw/audio/sb16.c                      |  9 ++-------
 hw/audio/soundhw.c                   | 24 +++++++++++++++++++++++-
 hw/i386/pc.c                         | 14 ++++++++------
 hw/i386/pc_piix.c                    |  3 +--
 hw/i386/pc_q35.c                     |  3 +--
 hw/isa/i82378.c                      |  2 +-
 hw/mips/jazz.c                       |  2 +-
 qdev-monitor.c                       |  2 ++
 softmmu/vl.c                         | 12 ++++++------
 stubs/isa-bus.c                      |  7 +++++++
 stubs/pci-bus.c                      |  7 +++++++
 docs/system/deprecated.rst           |  9 +++++++++
 docs/system/target-i386-desc.rst.inc | 13 ++++++++++++-
 stubs/Makefile.objs                  |  2 ++
 24 files changed, 121 insertions(+), 79 deletions(-)
 create mode 100644 stubs/isa-bus.c
 create mode 100644 stubs/pci-bus.c

-- 
2.18.4


