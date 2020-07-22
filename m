Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB18C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7319320717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7DPxv2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7319320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9m1-0000Li-Jj
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jy9l2-00078u-AK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:05:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jy9l0-00046g-KU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595405141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xJr7dbQ0BK7NBf2M8w9q1tCcmF5IcT+kJIYj1DSPdGw=;
 b=A7DPxv2d9/qLXWKuUpJd7GOz8qOOgWHqERJzrEeIu70jdfYZnsu5p1NEJN5LlxeSbgHk/X
 +dwba1sOgpwyYjBEYYigPBY10rFsHJsKBqwQVdPuUs36Qfy8Ket6kR13DMFuscdOnghF3H
 5vyt6Fwz0d1mDAo7frsA/zxv4KXsIm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Ktvt6u2tPzuv73vhwyJm7w-1; Wed, 22 Jul 2020 04:05:20 -0400
X-MC-Unique: Ktvt6u2tPzuv73vhwyJm7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24E4419200D7;
 Wed, 22 Jul 2020 08:05:19 +0000 (UTC)
Received: from localhost (ovpn-113-86.ams2.redhat.com [10.36.113.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22A648FA44;
 Wed, 22 Jul 2020 08:05:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.2 v3 0/3] migration: Add block-bitmap-mapping parameter
Date: Wed, 22 Jul 2020 10:05:13 +0200
Message-Id: <20200722080516.126147-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v3
Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v3

Hi,

This new migration parameter allows mapping block node names and bitmap
names to aliases for the purpose of block dirty bitmap migration.

This way, management tools can use different node names on the source
and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).


v3:
- Patch 1:
  - Add notes on the fact that the destination won’t ever know about any
    bitmaps that aren’t sent, so you can freely drop what you want, and
    you’re completely free in renaming bitmaps and putting them on
    “other” nodes (whatever “other” node means in the context of
    migration, because that’s kind of one of the problems this series is
    trying to solve: The fact that you can’t trivially match nodes
    between source and destination)
  - Fix an assertion

- Patch 2: s/pass/time.sleep(0.2)/

- Patch 3:
  - Add copyright line
  - Use format string instead of %
  - s/pass/time.sleep(0.1)/
  - s/wait_for_runstate/wait_migration/ on the destination to wait for
    the migration to actually complete
  - Replace the “info migrate_parameters” parsing code by a multiline
    regex
  - Test what happens when the destination has a mapping that isn’t used
    because there are not bitmaps to be transferred (which breaks the
    assertion in patch 1 as it was in v2)
  - Let verify_dest_has_all_bitmaps() actually verify the bitmaps on the
    destination instead of the source


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[0014] [FC] 'migration: Add block-bitmap-mapping parameter'
002/3:[0003] [FC] 'iotests.py: Add wait_for_runstate()'
003/3:[0046] [FC] 'iotests: Test node/bitmap aliases during migration'


Max Reitz (3):
  migration: Add block-bitmap-mapping parameter
  iotests.py: Add wait_for_runstate()
  iotests: Test node/bitmap aliases during migration

 qapi/migration.json            | 104 ++++++-
 migration/migration.h          |   3 +
 migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++----
 migration/migration.c          |  30 ++
 monitor/hmp-cmds.c             |  30 ++
 tests/qemu-iotests/300         | 515 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out     |   5 +
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |   5 +
 9 files changed, 1011 insertions(+), 55 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

-- 
2.26.2


