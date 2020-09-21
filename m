Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F359C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77AE239EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgTzmbYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77AE239EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU30-0000u3-1D
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1M-0007ru-K3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1K-0001Se-L6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YsMyHTQRvScBlOh/7wxs2x+kjYCIoMPoTFGZlMn7hzA=;
 b=ZgTzmbYpwQgDsVVrmW7KzW820G0Eh7pChjLKt8ED6+zCvINRCmjw3cDs94Ups9PW3H0elC
 qm7f2goXlmu/nbrvxnzF4Hdoo1vROIt17u1Pg3B1zdzgzs74uaEiErKS6/Z6PBP6ParsoC
 fHrk5zp8gNZ1UbWuqBxaF4sNOk9oq8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-EPtcM3roPhKFfdYlhjmKWA-1; Mon, 21 Sep 2020 18:10:47 -0400
X-MC-Unique: EPtcM3roPhKFfdYlhjmKWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBEF21074650
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 22:10:46 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E9D716E20;
 Mon, 21 Sep 2020 22:10:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/24] qom: Convert some properties to class properties
Date: Mon, 21 Sep 2020 18:10:21 -0400
Message-Id: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as it
doesn't require an object to be instantiated.  This series
converts a few existing object_property_add*() calls to register
class properties instead.

Eduardo Habkost (24):
  cryptodev-vhost-user: Register "chardev" as class property
  cryptodev-backend: Register "chardev" as class property
  rng-egd: Register "chardev" as class property
  rng-random: register "filename" as class property
  vhost-user: Register "chardev" as class property
  vexpress: Register "secure" as class property
  rng: Register "opened" as class property
  vexpress-a15: Register "virtualization" as class property
  input-linux: Register properties as class properties
  input-barrier: Register properties as class properties
  tmp421: Register properties as class properties
  s390x: Register all CPU properties as class properties
  i386: Register most CPU properties as class properties
  i386: Register feature bit properties as class properties
  arm/virt: Register most properties as class properties
  virt: Register "its" as class property
  cpu/core: Register core-id and nr-threads as class properties
  arm/cpu64: Register "aarch64" as class property
  xlnx-zcu102: Register properties as class properties
  machine: Register "memory-backend" as class property
  vga-pci: Register "big-endian-framebuffer" as class property
  i440fx: Register i440FX-pcihost properties as class properties
  sifive_e: Register "revb" as class property
  sifive_u: Register "start-in-flash" as class property

 target/s390x/internal.h         |  1 -
 backends/cryptodev-vhost-user.c | 13 ++---
 backends/cryptodev.c            |  8 +--
 backends/rng-egd.c              |  9 +--
 backends/rng-random.c           |  8 +--
 backends/rng.c                  |  8 +--
 backends/vhost-user.c           |  6 +-
 hw/arm/vexpress.c               | 25 +++++----
 hw/arm/virt.c                   | 88 ++++++++++++++++-------------
 hw/arm/xlnx-zcu102.c            | 25 +++++----
 hw/core/machine.c               | 12 ++--
 hw/cpu/core.c                   |  8 +--
 hw/display/vga-pci.c            | 12 ++--
 hw/misc/tmp421.c                | 30 +++++-----
 hw/pci-host/i440fx.c            | 32 +++++------
 hw/riscv/sifive_e.c             | 11 ++--
 hw/riscv/sifive_u.c             | 16 +++---
 target/arm/cpu64.c              | 16 ++----
 target/i386/cpu.c               | 99 +++++++++++++++++----------------
 target/s390x/cpu.c              |  1 -
 target/s390x/cpu_models.c       | 35 ++++++------
 ui/input-barrier.c              | 44 +++++++--------
 ui/input-linux.c                | 27 ++++-----
 23 files changed, 262 insertions(+), 272 deletions(-)

-- 
2.26.2


