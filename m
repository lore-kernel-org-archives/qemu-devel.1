Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC8BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D38204EA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZSzI+5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D38204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mHV-0003J3-Q5
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8mAM-00024o-O1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:07:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8mAK-0006I0-89
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597936063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D1NU2DA9P/DICOyRFivJE0R9PelnQqpRPkAjBHZhFh0=;
 b=GZSzI+5PuKoTTyQfUC6Wg7vJQfBPmaUEI+Fxxoq4H2OZNPG24loDcGyu30/g9njUXRPumT
 v3CBPh4hHBl9rs5TDHH3hoAJEyaYTPNbnPTt7yYMpQVbEfQwpGa5uhyDnBTaalxZCya9wR
 ETZr1GacSVRt5FO9+Y4NGVILjKT5vlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-sbOXYhYuNiO0S_rl2AT2tQ-1; Thu, 20 Aug 2020 11:07:28 -0400
X-MC-Unique: sbOXYhYuNiO0S_rl2AT2tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E3C51DDFF;
 Thu, 20 Aug 2020 15:07:27 +0000 (UTC)
Received: from localhost (ovpn-113-133.ams2.redhat.com [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CB0B7A40D;
 Thu, 20 Aug 2020 15:07:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 0/3] migration: Add block-bitmap-mapping parameter
Date: Thu, 20 Aug 2020 17:07:22 +0200
Message-Id: <20200820150725.68687-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC v1: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00912.html
RFC v2: https://lists.nongnu.org/archive/html/qemu-block/2020-05/msg00915.html
v1: https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09792.html
v2: https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01179.html
v3: https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01385.html
v4: https://lists.nongnu.org/archive/html/qemu-block/2020-08/msg00566.html

Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v5
Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v5


Hi,

This new migration parameter allows mapping block node names and bitmap
names to aliases for the purpose of block dirty bitmap migration.

This way, management tools can use different node names on the source
and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).


v5:
- Patch 1:
  - QAPI documentation: On the destination, unmapped aliases are not
    just reported and that’s it – encountering one will actually lead to
    the whole rest of the bitmap migration data being discarded.

  - Use sizeof_field instead of hand-coding it

  - %s/255/UINT8_MAX/

  - s/Unable to read bitmap name string/
      Unable to read bitmap alias string/

  - Cancellation on unknown incoming bitmap aliases was handled
    improperly; it should be handled properly now

- Old patch 2: Dropped

- Patch 3 (was 4): Use discards instead of writes to dirty the bitmap


git-backport-diff against v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[0040] [FC] 'migration: Add block-bitmap-mapping parameter'
002/3:[----] [--] 'iotests.py: Let wait_migration() return on failure'
003/3:[0002] [FC] 'iotests: Test node/bitmap aliases during migration'


Max Reitz (3):
  migration: Add block-bitmap-mapping parameter
  iotests.py: Let wait_migration() return on failure
  iotests: Test node/bitmap aliases during migration

 qapi/migration.json            | 104 +++++-
 migration/migration.h          |   3 +
 migration/block-dirty-bitmap.c | 412 ++++++++++++++++++++---
 migration/migration.c          |  30 ++
 monitor/hmp-cmds.c             |  30 ++
 tests/qemu-iotests/300         | 595 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out     |   5 +
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |  18 +-
 9 files changed, 1135 insertions(+), 63 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

-- 
2.26.2


