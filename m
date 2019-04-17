Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83528C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A82205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A82205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqfG-0001vG-HT
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:56:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdJ-0000Xv-Mt
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqdI-0006zz-T0
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:54:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hGqdG-0006xY-RA; Wed, 17 Apr 2019 15:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 978045F73A;
	Wed, 17 Apr 2019 19:54:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C598E5D6A6;
	Wed, 17 Apr 2019 19:54:04 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 17 Apr 2019 22:53:50 +0300
Message-Id: <20190417195355.16123-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 17 Apr 2019 19:54:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/5] Few fixes for userspace NVME driver
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
Message-ID: <20190417195350.-lCGwgqqgyM11ZYjVSUclDR0Tu_-0fcHCyhsfnKVjPA@z>

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

 block/nvme.c         | 193 +++++++++++++++++++++++++++++++++++++++++--
 block/trace-events   |   3 +
 include/block/nvme.h |  19 ++++-
 3 files changed, 205 insertions(+), 10 deletions(-)

-- 
2.17.2


