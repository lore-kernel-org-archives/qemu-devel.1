Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59590C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D1C206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCJLPIp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D1C206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBzA-0001Oj-Dv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBuF-0003c9-SR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:46:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBuE-0008Uk-2g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593506777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ew3lSuk/v2cwImdISsboXjwXuoSXBWLLOv47s1zH0mo=;
 b=fCJLPIp411y0WaSuaazk7Czzyob9NTczExbGpyFEJ3S7+bl0CxWOmZl+M3oXH6XeErCGKW
 X8iKwJcGIy8uf4QlErEenzFLyw9mogK5vCPAkw6cSh3r/MEb2aauNtH9iagfWzQLaIhS5z
 tlhJYN+aEN9YBgMfleRw/Lr0bebgzpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-fiMxKYndNWK_ZON5iSjlKw-1; Tue, 30 Jun 2020 04:45:56 -0400
X-MC-Unique: fiMxKYndNWK_ZON5iSjlKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 098A6107ACCA;
 Tue, 30 Jun 2020 08:45:55 +0000 (UTC)
Received: from localhost (ovpn-113-102.ams2.redhat.com [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E5CB741A9;
 Tue, 30 Jun 2020 08:45:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/4] migration: Add block-bitmap-mapping parameter
Date: Tue, 30 Jun 2020 10:45:48 +0200
Message-Id: <20200630084552.46362-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC v1: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00912.html
RFC v2: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00915.html

Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v1
Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v1


Hi,

This new migration parameter allows mapping block node names and bitmap
names to aliases for the purpose of block dirty bitmap migration.

This way, management tools can use different node names on the source
and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).

v1 (as opposed to the RFC):
- Added an iotest
- Allow mapping of not only node names, but also of bitmap names to
  aliases
- Make this a migration parameter instead of adding a whole new QMP
  command
- Added patch 1 for good measure


Max Reitz (4):
  migration: Prevent memleak by ...params_test_apply
  migration: Add block-bitmap-mapping parameter
  iotests.py: Add wait_for_runstate()
  iotests: Test node/bitmap aliases during migration

 qapi/migration.json            |  83 +++++-
 migration/migration.h          |   3 +
 migration/block-dirty-bitmap.c | 372 +++++++++++++++++++++----
 migration/migration.c          |  33 ++-
 tests/qemu-iotests/300         | 487 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out     |   5 +
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |   4 +
 8 files changed, 931 insertions(+), 57 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

-- 
2.26.2


