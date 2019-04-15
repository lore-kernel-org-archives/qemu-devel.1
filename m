Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C769DC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972332087C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972332087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG2BG-000811-Um
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:01:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27U-000562-FG
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hG27T-0007xv-Jr
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hG27P-0007sQ-99; Mon, 15 Apr 2019 09:57:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C97213087946;
	Mon, 15 Apr 2019 13:57:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A2F31001E85;
	Mon, 15 Apr 2019 13:57:48 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 16:57:41 +0300
Message-Id: <20190415135746.7571-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 15 Apr 2019 13:57:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] Few fixes for userspace NVME driver
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415135741.uNmekKlafC5yJ5jo73Kp_JWHjUu7lWz4YbmFnOzhe7Q@z>

CC: Fam Zheng <fam@euphon.net>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: qemu-devel@nongnu.org


Hi!
These are few assorted fixes and features for the userspace
nvme driver.

Tested that on my laptop with my Samsung X5 thunderbolt drive, which
happens to have 4K sectors, support for discard and write zeros.

Also bunch of fixes sitting in my queue from the period when I developed
the nvme-mdev driver.

Best regards,
	Maxim Levitsky

Maxim Levitsky (5):
  block/nvme: don't flip CQ phase bits
  block/nvme: fix doorbell stride
  block/nvme: support larger that 512 bytes sector devices
  block/nvme: add support for write zeros
  block/nvme: add support for discard

 block/nvme.c         | 194 +++++++++++++++++++++++++++++++++++++++++--
 block/trace-events   |   3 +
 include/block/nvme.h |  17 +++-
 3 files changed, 204 insertions(+), 10 deletions(-)

-- 
2.17.2


