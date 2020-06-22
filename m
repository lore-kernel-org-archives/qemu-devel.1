Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7241C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969AC20708
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFeZKm4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969AC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKfa-0005LN-Pr
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnKdp-0002xx-4t
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:29:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnKdm-0008Rj-Ha
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592825369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DqXaTpubEmM0GbYt+uvFQ4I1A2dp8sI0Q3aU5VbLob4=;
 b=BFeZKm4lEmIikjIYdOv5FYs5WFeGDXsbe63AEwJXfqnOs0zmZWDGoSkoqEvzJA8gvJqJTS
 uL5CZFASTs3RmouOSE/14aLLCqwPDnyZkU7zeZsBIQOsT1GNqLUvxo2zK9z0ncf3pAMH2J
 MRkxRowEIblzEg84z5gYj4QRMcDNIJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-aHuUYsrUNd20M-YRejAE8w-1; Mon, 22 Jun 2020 07:29:26 -0400
X-MC-Unique: aHuUYsrUNd20M-YRejAE8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E54AEC1AA;
 Mon, 22 Jun 2020 11:29:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E73A5D9D5;
 Mon, 22 Jun 2020 11:29:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0C0C917477; Mon, 22 Jun 2020 13:29:14 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/19] audio: deprecate -soundhw
Date: Mon, 22 Jun 2020 13:28:55 +0200
Message-Id: <20200622112914.30454-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
 - use g_assert_not_reached() for stubs.
 - add deprecation notice.

v3:
 - rebase to latest master.
 - adapt to armbru's device initialization changes.

Gerd Hoffmann (19):
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
  audio: deprecate -soundhw pcspk
  audio: add soundhw deprecation notice
  pc_basic_device_init: pass PCMachineState
  pc_basic_device_init: drop has_pit arg
  pc_basic_device_init: drop no_vmport arg
  softmmu: initialize spice and audio earlier
  audio: rework pcspk_init()
  audio: create pcspk device early, add audiodev alias.
  audio: set default value for pcspk.iobase property

 include/hw/audio/pcspk.h   | 12 ++----------
 include/hw/audio/soundhw.h |  2 ++
 include/hw/i386/pc.h       |  6 +++---
 hw/audio/ac97.c            |  9 ++-------
 hw/audio/adlib.c           |  8 +-------
 hw/audio/cs4231a.c         |  8 +-------
 hw/audio/es1370.c          |  9 ++-------
 hw/audio/gus.c             |  8 +-------
 hw/audio/intel-hda.c       |  3 +++
 hw/audio/pcspk.c           | 26 ++++++++++++++++++++++----
 hw/audio/sb16.c            |  9 ++-------
 hw/audio/soundhw.c         | 24 +++++++++++++++++++++++-
 hw/i386/pc.c               | 14 ++++++++------
 hw/i386/pc_piix.c          |  3 +--
 hw/i386/pc_q35.c           |  3 +--
 hw/isa/i82378.c            |  2 +-
 qdev-monitor.c             |  2 ++
 softmmu/vl.c               | 14 ++++++++------
 stubs/isa-bus.c            |  7 +++++++
 stubs/pci-bus.c            |  7 +++++++
 docs/system/deprecated.rst |  9 +++++++++
 stubs/Makefile.objs        |  2 ++
 22 files changed, 110 insertions(+), 77 deletions(-)
 create mode 100644 stubs/isa-bus.c
 create mode 100644 stubs/pci-bus.c

-- 
2.18.4


