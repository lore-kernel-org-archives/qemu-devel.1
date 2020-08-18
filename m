Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92462C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E26B207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO6CnR8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E26B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81mU-0006mo-MR
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k81jl-0002kx-On
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k81jj-0002V9-S8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597757591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rVxI2XJOfHe0Y3eeEFhLEP6oB8/Fzt8K3Xb8sLFJw5o=;
 b=EO6CnR8e79WtPo+jPMfnWRSi9iICI3VU6VdYdysgvblUR3HUwa+QaZAvlj2idyHjoAUoiw
 KHAXUxEiYr5b3YNACiJ+73mkIc889jAleiABL8fsOey5ZWLRM/ANgpnbofS3IHi7FL5AGk
 7DdX4usbSxvAe5cHJnXl0Oui90Gx35o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-GM5D4bcQOBa9RDm11QcTpw-1; Tue, 18 Aug 2020 09:32:43 -0400
X-MC-Unique: GM5D4bcQOBa9RDm11QcTpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7003C1DDED;
 Tue, 18 Aug 2020 13:32:42 +0000 (UTC)
Received: from localhost (ovpn-112-119.ams2.redhat.com [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D68DB10098A7;
 Tue, 18 Aug 2020 13:32:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/4] migration: Add block-bitmap-mapping parameter
Date: Tue, 18 Aug 2020 15:32:36 +0200
Message-Id: <20200818133240.195840-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Branch: https://github.com/XanClic/qemu.git migration-bitmap-mapping-v4
Branch: https://git.xanclic.moe/XanClic/qemu.git migration-bitmap-mapping-v4

Hi,

This new migration parameter allows mapping block node names and bitmap
names to aliases for the purpose of block dirty bitmap migration.

This way, management tools can use different node names on the source
and destination and pass the mapping of how bitmaps are to be
transferred to qemu (on the source, the destination, or even both with
arbitrary aliases in the migration stream).


v4:
- Patch 1:
  - Rebased
  - %s/5.1/5.2/
  - The destination side will now ignore unmapped aliases, too (though
    they are reported to stderr)
  - Check that the aliases given will fit in the migration stream (i.e.
    are shorter than 256 bytes)
    - On that note, fix a pre-existing bug where a bitmap with a name
      longer than 255 bytes would make qemu_put_counted_string() fail an
      assertion

- Patch 2:
  - import time (apparently, I forgot that in v3...?)

- Patch 3:
  - Added; I need this now

- Patch 4:
  - Migration rarely ever really fails now (just one case, where a
    non-aliased bitmap name is too long, which can only be detected when
    beginning migration)

  - Thus, we have to read most error messages from the VM log now, for
    which I’ve added a new function (verify_dest_error)

  - Added tests for overly long bitmap names and node/bitmap aliases


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/4:[0167] [FC] 'migration: Add block-bitmap-mapping parameter'
002/4:[0001] [FC] 'iotests.py: Add wait_for_runstate()'
003/4:[down] 'iotests.py: Let wait_migration() return on failure'
004/4:[0232] [FC] 'iotests: Test node/bitmap aliases during migration'


Max Reitz (4):
  migration: Add block-bitmap-mapping parameter
  iotests.py: Add wait_for_runstate()
  iotests.py: Let wait_migration() return on failure
  iotests: Test node/bitmap aliases during migration

 qapi/migration.json            | 101 +++++-
 migration/migration.h          |   3 +
 migration/block-dirty-bitmap.c | 409 +++++++++++++++++++---
 migration/migration.c          |  30 ++
 monitor/hmp-cmds.c             |  30 ++
 tests/qemu-iotests/300         | 595 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out     |   5 +
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |  22 +-
 9 files changed, 1134 insertions(+), 62 deletions(-)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

-- 
2.26.2


