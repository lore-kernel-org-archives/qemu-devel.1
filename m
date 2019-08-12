Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53817C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 06:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23BE32085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 06:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BE32085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx4D3-00080H-BP
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 02:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hx4Bx-0006jy-JL
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hx4Bw-0007bL-Jy
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hx4Bw-0007b5-FH
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B03CB307F5E4;
 Mon, 12 Aug 2019 06:52:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com
 [10.36.116.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50FB010013A1;
 Mon, 12 Aug 2019 06:52:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2234016E32; Mon, 12 Aug 2019 08:52:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <ppandit@redhat.com>
Date: Mon, 12 Aug 2019 08:52:20 +0200
Message-Id: <20190812065221.20907-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 12 Aug 2019 06:52:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/1] display/bochs: fix pcie support (qemu
 security issue)
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just found while investigating
  https://bugzilla.redhat.com/show_bug.cgi?id=1707118

Found PCIe extended config space filled with random crap due to
allocation being too small (conventional pci config space only).

PCI(e) config space is guest writable.  Writes are limited by
write mask (which probably is also filled with random stuff),
so the guest can only flip enabled bits.  But I suspect it
still might be exploitable, so rather serious because it might
be a host escape for the guest.  On the other hand the device
is probably not yet in widespread use.

Migitation: use "-device bochs-display" as conventional pci
device only.

Note: qemu 4.1 release is planned for tomorrow.

Gerd Hoffmann (1):
  display/bochs: fix pcie support

 hw/display/bochs-display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.18.1


