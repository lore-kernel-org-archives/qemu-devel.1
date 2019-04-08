Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49148C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0BC20883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0BC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54779 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW5I-0005gP-Dx
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:21:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW17-0002n7-52
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW11-0001Mx-Dy
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:57 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:43190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW0x-0000tN-RL; Mon, 08 Apr 2019 11:16:53 -0400
X-IronPort-AV: E=Sophos;i="5.60,325,1549929600"; d="scan'208";a="83016879"
From: Paul Durrant <paul.durrant@citrix.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
	<xen-devel@lists.xenproject.org>
Date: Mon, 8 Apr 2019 16:16:14 +0100
Message-ID: <20190408151617.13025-1-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: [Qemu-devel] [PATCH 0/3] Support IOThread polling for PV shared
 rings
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
	Max Reitz <mreitz@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Anthony Perard <anthony.perard@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408151614.GI6GpQ8s8eAFsVDfLBlqq2RGx-GgZhmXmk8uNtzJjTI@z>

Currently xen-block uses an IOThread to handle AIO but the event channels
are dealt with on QEMU's main thread. This series allows them to be
dealt with in the same context.

Paul Durrant (3):
  xen-bus: use a separate fd for each event channel
  xen-bus: allow AioContext to be specified for each event channel
  xen-bus / xen-block: add support for event channel polling

 hw/block/dataplane/xen-block.c | 19 +++----
 hw/xen/xen-bus.c               | 92 +++++++++++++++++++---------------
 include/hw/xen/xen-bus.h       |  9 ++--
 3 files changed, 66 insertions(+), 54 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
--
2.20.1.2.gb21ebb6


