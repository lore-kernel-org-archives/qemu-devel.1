Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB82C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FFC2075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De/8e6Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FFC2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbXf-0007zs-2Q
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRF-0004Ip-68
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35309
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbRD-0007x3-EW
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589553346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pQviqSiJYUFl3pN/xx61ehxSzuEdfkdPrxdoAsWMopU=;
 b=De/8e6ZmZJPH79hNpI90o54rgwqn+h6IL7Dv1jE+K7eF0Xjxu63iH1KM3GGinAAE3ugBpA
 +/+PySi5x/2kOugf3/MRu9MCszhi87Bpx0xqSFQokOYgrwGgM+5oINxUpc6XM1Z4CZeq0z
 sbpHGtU734xczBuyj28RI55AwxclIFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Z6nr4Q8LP3OFtCqEf9HZHA-1; Fri, 15 May 2020 10:35:44 -0400
X-MC-Unique: Z6nr4Q8LP3OFtCqEf9HZHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A591108BD0F
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 14:35:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 033AB60CD3;
 Fri, 15 May 2020 14:35:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BE8B316E16; Fri, 15 May 2020 16:35:28 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] audio: deprecate -soundhw
Date: Fri, 15 May 2020 16:35:15 +0200
Message-Id: <20200515143528.13591-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
 - use g_assert_not_reached() for stubs.
 - add deprecation notice.

Gerd Hoffmann (13):
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
 docs/system/deprecated.rst |  9 +++++++++
 stubs/Makefile.objs        |  2 ++
 15 files changed, 88 insertions(+), 46 deletions(-)
 create mode 100644 stubs/isa-bus.c
 create mode 100644 stubs/pci-bus.c

-- 
2.18.4


