Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B2C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD74206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMaMPQtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD74206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTkWP-0006jC-7z
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkUs-0005An-IH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTkTv-0003mh-4E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:03:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTkTu-0003kc-JV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588158141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9dEuFL4uqjQpJmk17jkYiUQm5ji2Ty3LIgcgd4JiAo=;
 b=SMaMPQtrCuWH/0E3EJgAuT2euY9mX5/nz9t7ev4F/mXRlibPQx1fOuMbM5oym9BlkirrqE
 ogw85n13uA2NnGcLhFjDI80yMIhhPV/Ed6/XKZtC3sA2d/HSkis4cuQMpkscSkV9tuYwjQ
 73JhNy9pRfVejPvDF2wenMnQ3ELpWsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-DO3xz7iEOL-vBYNmlKjkNA-1; Wed, 29 Apr 2020 07:02:19 -0400
X-MC-Unique: DO3xz7iEOL-vBYNmlKjkNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F30AE835B46
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:02:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 025AD5C1BE;
 Wed, 29 Apr 2020 11:02:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 031001753B; Wed, 29 Apr 2020 13:02:14 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] audio: deprecate -soundhw
Date: Wed, 29 Apr 2020 13:02:02 +0200
Message-Id: <20200429110214.29037-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Gerd Hoffmann (12):
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
  [RFC] audio: try use onboard audiodev for pcspk

 include/hw/audio/soundhw.h |  2 ++
 hw/audio/ac97.c            |  9 ++-------
 hw/audio/adlib.c           |  8 +-------
 hw/audio/cs4231a.c         |  8 +-------
 hw/audio/es1370.c          |  9 ++-------
 hw/audio/gus.c             |  8 +-------
 hw/audio/intel-hda.c       |  3 +++
 hw/audio/pcspk.c           | 27 ++++++++++++++++++++++++---
 hw/audio/sb16.c            |  9 ++-------
 hw/audio/soundhw.c         | 24 +++++++++++++++++++++++-
 qdev-monitor.c             |  2 ++
 stubs/isa-bus.c            |  7 +++++++
 stubs/pci-bus.c            |  7 +++++++
 stubs/Makefile.objs        |  2 ++
 14 files changed, 79 insertions(+), 46 deletions(-)
 create mode 100644 stubs/isa-bus.c
 create mode 100644 stubs/pci-bus.c

-- 
2.18.2


