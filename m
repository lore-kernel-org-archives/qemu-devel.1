Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7155FC5518E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2C720781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NClnH6ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2C720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCEJ-0003or-E4
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRCD3-0002O9-Nr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jRCD2-0004Qa-RZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:02:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jRCD2-0004FH-CV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587549741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZPI/kpbw0SuDSmjh3Z1786Q+w0y2K7Co1J7wLXi4kSo=;
 b=NClnH6chNksAry9yv9BmH2/yx6INU/sVyN6hAkEaPT6c/C0k3+kOIFhsUjBi29M+FzQ7Ik
 aFvJp/TYs+cAnB8lXNc81qzWeDATOF1OtmjbsTZMq4x5r96lsK2tGLRBlF0VUsTeGvS2kN
 5KKrX1GX6dhAq2qPQ3QIqVpx4ccZsMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-ksFo-PiKO6iPmiztXRNYLA-1; Wed, 22 Apr 2020 06:02:19 -0400
X-MC-Unique: ksFo-PiKO6iPmiztXRNYLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DBF0800685;
 Wed, 22 Apr 2020 10:02:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7594385;
 Wed, 22 Apr 2020 10:02:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C25F617532; Wed, 22 Apr 2020 12:02:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] ramfb: a bunch of reverts and fixes
Date: Wed, 22 Apr 2020 12:02:06 +0200
Message-Id: <20200422100211.30614-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:04:42
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
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 hqm03ster@gmail.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even though these are bugfixes this is probably 5.1 material
at this point ...

Gerd Hoffmann (5):
  Revert "hw/display/ramfb: initialize fw-config space with xres/ yres"
  Revert "hw/display/ramfb: lock guest resolution after it's set"
  ramfb: don't update RAMFBState on errors
  ramfb: add sanity checks to ramfb_create_display_surface
  ramfb: drop leftover debug message

 include/hw/display/ramfb.h    |  2 +-
 hw/display/ramfb-standalone.c | 12 +------
 hw/display/ramfb.c            | 59 +++++++++++------------------------
 hw/vfio/display.c             |  4 +--
 stubs/ramfb.c                 |  2 +-
 5 files changed, 24 insertions(+), 55 deletions(-)

-- 
2.18.2


