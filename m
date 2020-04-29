Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E43C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEBB2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFeniQHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEBB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlHe-0007Ur-3d
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGj-0005sW-8T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGi-0001zf-1s
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTlGh-0001ye-H5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oopok3//dpVkWYs+u0Y33XWOG7SrwRFB0vPYL2PWlzU=;
 b=gFeniQHx+8mlgasLv/LeXM++e68nopQ43QJiNHnAXugL0n4QOTwqare1/9FleuMhQChnPU
 s9qyhLHD6du+kcB8ACmknY+rbjFh0toz9IwDu5Tu3atay+Rpjo5E8fCCH3BqCJ74L8vHgz
 9wfq51dyjWVUoxEq3HYnPNHUy1J5UUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-b4sQ9WP_MaW7rHZwH1YpHA-1; Wed, 29 Apr 2020 07:52:44 -0400
X-MC-Unique: b4sQ9WP_MaW7rHZwH1YpHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD04E80058A;
 Wed, 29 Apr 2020 11:52:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9775605DE;
 Wed, 29 Apr 2020 11:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E5E591753B; Wed, 29 Apr 2020 13:52:36 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] ramfb: a bunch of reverts and fixes
Date: Wed, 29 Apr 2020 13:52:30 +0200
Message-Id: <20200429115236.28709-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even though these are bugfixes this is probably 5.1 material
at this point ...

v2: reorder patches, add patch #6, pick up acks & reviews.

Gerd Hoffmann (6):
  Revert "hw/display/ramfb: initialize fw-config space with xres/ yres"
  Revert "hw/display/ramfb: lock guest resolution after it's set"
  ramfb: drop leftover debug message
  ramfb: don't update RAMFBState on errors
  ramfb: add sanity checks to ramfb_create_display_surface
  ramfb: fix size calculation

 include/hw/display/ramfb.h    |  2 +-
 hw/display/ramfb-standalone.c | 12 +-----
 hw/display/ramfb.c            | 78 +++++++++++++----------------------
 hw/vfio/display.c             |  4 +-
 stubs/ramfb.c                 |  2 +-
 5 files changed, 34 insertions(+), 64 deletions(-)

-- 
2.18.2


