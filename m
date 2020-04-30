Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30372C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E66206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XldceYD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E66206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUACO-0000jq-KA
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:30:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAh-0007HQ-0I
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAg-0001v2-Mc
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUAAg-0001uk-A3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q/AJg6ibMMcF3VjmIi6lCU8ossB/HtUAXR0eOB/naME=;
 b=XldceYD62mPvlTPcKY954gKk6PvstmWNzaeUtwWvElKHpJ7SUBNMmNz9nQ8pWM+fW7ghfC
 7k+up8P8oBHZcXtQHW/LCAnlycvdOo1KPi6nb7CyFyRhsaXcX/+F67KzrmdU4W8xptFbJi
 m2hzOja4Af5Wxa70M6V6Lfr1PX/2XuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-UfzP3R7mNtKFURQeQfypPQ-1; Thu, 30 Apr 2020 10:28:09 -0400
X-MC-Unique: UfzP3R7mNtKFURQeQfypPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08D2045F;
 Thu, 30 Apr 2020 14:28:08 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3644460C87;
 Thu, 30 Apr 2020 14:28:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/4] backup: Make sure that source and target size match
Date: Thu, 30 Apr 2020 16:27:51 +0200
Message-Id: <20200430142755.315494-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- Fixed iotest 283
- Corrected commit message for patch 3 [Vladimir]
- Fixed permissions for the source node, too
- Refactored the test case to avoid some duplication [Vladimir]

Kevin Wolf (4):
  iotests/283: Use consistent size for source and target
  backup: Improve error for bdrv_getlength() failure
  backup: Make sure that source and target size match
  iotests: Backup with different source/target size

 block/backup-top.c         | 14 ++++++++-----
 block/backup.c             | 18 +++++++++++++---
 tests/qemu-iotests/055     | 42 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/055.out |  4 ++--
 tests/qemu-iotests/283     |  6 +++++-
 tests/qemu-iotests/283.out |  2 +-
 6 files changed, 72 insertions(+), 14 deletions(-)

--=20
2.25.3


