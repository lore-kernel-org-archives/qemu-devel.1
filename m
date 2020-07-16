Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AEC20787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK8PwiRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AEC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4LH-0001tJ-7R
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw4KO-00012S-PC
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:53:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw4KM-00089H-5l
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594907612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R2I2EbJFqXum8rSg9eyrGzxSbb7hFQK+xZPSUpvp7qM=;
 b=hK8PwiRCLkzFlkNGEAY1Iq570oI4ARvhtKibllSAwoNjOMmbSCWbZfyc5oxg7u7dInFDyt
 f9fLr0Tu+IkC2z54sH2DGu6vXmExM9vphsx+/EJ6ZyEiPIDrsLUoHP3a4qkwejziKP4fdD
 y4hgsb+H1vKIw8/5craJkuqvUG/Oyd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Sc3toPEKOT6KzRltRZF72Q-1; Thu, 16 Jul 2020 09:53:17 -0400
X-MC-Unique: Sc3toPEKOT6KzRltRZF72Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B703488C7A6;
 Thu, 16 Jul 2020 13:53:16 +0000 (UTC)
Received: from localhost (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D57187307;
 Thu, 16 Jul 2020 13:53:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/3] migration: Add block-bitmap-mapping parameter
Date: Thu, 16 Jul 2020 15:53:00 +0200
Message-Id: <20200716135303.319502-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
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

Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v2

Based-on: <20200626130658.76498-1-vsementsov@virtuozzo.com>
          (“migration/block-dirty-bitmap: fix add_bitmaps_to_list”)


Hi,

This new migration parameter allows mapping block node names and bitmap
names to aliases for the purpose of block dirty bitmap migration.

This way, management tools can use different node names on the source
and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).


v2:
- Dropped what used to be patch 1 (the memleak fix), I see the exact
  same fix has been sent concurrently and has been merged as
  9728ebfb77f0159f4

- Patch 1:
  - Changed documentation to clarify the default behavior
  - s/5.1/5.2/
  - Dropped dead assignment
  - Fixed bitmaps_map memleak
  - Assert that the bs_name given to add_bitmaps_to_list() must be the
    BDS’s node name if an alias_map is given
  - On the source side, unmapped bitmaps are simply dropped without
    error
  - On the destination side, unmapped aliases still result in errors
    (see patch 1 for a short explanation on my reasoning)
  - Fixed a bug in qmp_query_migrate_parameters(): We have to clone
    s->parameters.block_bitmap_mapping, not
    params->block_bitmap_mapping, or the latter will just stay NULL (and
    so qmp_query_migrate_parameters() won’t return a result for the
    block-bitmap-mapping)
  - Emit the mapping through HMP’s “info migrate_parameters”
  - Return an error when trying to set the mapping through HMP (instead
    of just crashing because of an “assert(0)” signalling an unhandled
    migration parameter)

- Patch 3:
  - Type alias for BlockBitmapMapping
  - Check the result of “info migrate_parameters” whenever setting the
    block-bitmap-mapping (just to test the new formatting code)
  - Catch the qemu.machine.AbnormalShutdown exception on the destination
    VM whenever the migration is expected to fail
    (necessary since commit ef5d474472426eda6abf81)
  - Cases where we don’t set up a mapping for some bitmap on the source
    are now expected to succeed (without the bitmap being migrated)


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[0117] [FC] 'migration: Add block-bitmap-mapping parameter'
002/3:[----] [--] 'iotests.py: Add wait_for_runstate()'
003/3:[0202] [FC] 'iotests: Test node/bitmap aliases during migration'


Max Reitz (3):
  migration: Add block-bitmap-mapping parameter
  iotests.py: Add wait_for_runstate()
  iotests: Test node/bitmap aliases during migration

 qapi/migration.json            |  92 +++++-
 migration/migration.h          |   3 +
 migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++----
 migration/migration.c          |  30 ++
 monitor/hmp-cmds.c             |  30 ++
 tests/qemu-iotests/300         | 511 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out     |   5 +
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |   4 +
 9 files changed, 994 insertions(+), 55 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

-- 
2.26.2


