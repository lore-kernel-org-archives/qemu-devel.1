Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F30C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBA0207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebMP053K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBA0207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqxJ-0006ux-9k
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbqlI-00052f-OC
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:21:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbqlH-0001hU-9u
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590088905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0dWrQHzMO2bvioYZy9HWQ2OEjk9nhqZm/Ulwpu5bLpI=;
 b=ebMP053KPDcSWGE2YyMWyBC5jII3GCTJFjSztXQFxH+XZK9FZUE9ULbJuduLTHlSXxiULJ
 FqQ0Nk2w/AnYWtIAKntuV7uVOIJWxsNS6JaBsu0Qx/zZgSLmwpeleg10QL9CkrSQRQIDPF
 Hyq9KYEKJzGVMcbkM06Jd0C+7tUF8gY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-C0JgTjrZPnijNhmOUxm9Uw-1; Thu, 21 May 2020 15:21:39 -0400
X-MC-Unique: C0JgTjrZPnijNhmOUxm9Uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5056E8005AA;
 Thu, 21 May 2020 19:21:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92CC660C05;
 Thu, 21 May 2020 19:21:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/5] qemu-img: Add convert --bitmaps
Date: Thu, 21 May 2020 14:21:32 -0500
Message-Id: <20200521192137.1120211-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 14:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05958.html
original cover letter here:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03464.html

Hopefully this version is close enough to do a pull request Monday.

Since then:
- patch 2: drop 'measure --bitmaps' sugar on top of QMP [Nir]
- patch 3: add function comment
- patch 4: fallout from patch 2

001/5:[----] [--] 'iotests: Fix test 178'
002/5:[0073] [FC] 'qcow2: Expose bitmaps' size during measure'
003/5:[0001] [FC] 'qemu-img: Factor out code for merging bitmaps'
004/5:[0001] [FC] 'qemu-img: Add convert --bitmaps option'
005/5:[----] [--] 'iotests: Add test 291 to for qemu-img bitmap coverage'

Series can also be downloaded at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v6

Eric Blake (5):
  iotests: Fix test 178
  qcow2: Expose bitmaps' size during measure
  qemu-img: Factor out code for merging bitmaps
  qemu-img: Add convert --bitmaps option
  iotests: Add test 291 to for qemu-img bitmap coverage

 docs/tools/qemu-img.rst          |  13 +++-
 qapi/block-core.json             |  16 +++--
 block/qcow2.h                    |   2 +
 block/crypto.c                   |   2 +-
 block/qcow2-bitmap.c             |  36 ++++++++++
 block/qcow2.c                    |  14 +++-
 block/raw-format.c               |   2 +-
 qemu-img.c                       | 115 ++++++++++++++++++++++++++-----
 qemu-img-cmds.hx                 |   4 +-
 tests/qemu-iotests/178.out.qcow2 |  18 ++++-
 tests/qemu-iotests/178.out.raw   |   2 +-
 tests/qemu-iotests/190           |  45 +++++++++++-
 tests/qemu-iotests/190.out       |  27 +++++++-
 tests/qemu-iotests/291           | 112 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/291.out       |  80 +++++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 16 files changed, 455 insertions(+), 34 deletions(-)
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

-- 
2.26.2


