Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C48C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C990207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8pkFBjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C990207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXME-0008OI-Au
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDXLF-0006jM-Rp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDXLD-0001jb-34
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599070717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=euUt4Kf3yQt8AKxbvf4ONpjuLbUUYo6WLGT4KriOvYU=;
 b=D8pkFBjQgmXUWd5p7h/2zT3Ev9XH01CQJCO+yf2/BCRNCViOfCFcNyW41Fv3N3RuEb5S+V
 PdNal1MCl5jxaeQOVB0lMlmZU3qiapRZBcFqvJXAdMskMopBq3IfRVR8cKhXZJNx/3NQz6
 Z5QBMp7hK3Yne5I1bVc8a65c3Sv0IGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-JxJ2od-VPKuiyQqe8Xsuyg-1; Wed, 02 Sep 2020 14:18:33 -0400
X-MC-Unique: JxJ2od-VPKuiyQqe8Xsuyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E89E18BA281;
 Wed,  2 Sep 2020 18:18:32 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CBC410013BD;
 Wed,  2 Sep 2020 18:18:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/5] block: add block-dirty-bitmap-populate job
Date: Wed,  2 Sep 2020 13:18:26 -0500
Message-Id: <20200902181831.2570048-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is NOT the final version of this patch series, but I'm posting it
to revive conversation on the topic while fixing it to compile on top
of meson changes.

v3 was: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06258.html

001/5:[0025] [FC] 'block: add bitmap-populate job'
002/5:[----] [--] 'blockdev: combine DriveBackupState and BlockdevBackupState'
003/5:[0004] [FC] 'qmp: expose block-dirty-bitmap-populate'
004/5:[----] [--] 'iotests: move bitmap helpers into their own file'
005/5:[----] [-C] 'iotests: add 298 for block-dirty-bitmap-populate'

I'm still trying to find the right QAPI contract (affects patch 1 and
3 for the qapi, and 5 for invoking the command in iotests), but right
now, I'm leaning towards:

{ "execute": "block-dirty-bitmap-populate", "arguments": {
    "job-id": "job0", "node": "target_node", "name": "target_bitmap",
    "sources": [ { "pattern": "allocation", "node": "from_node" } ] } }

which allows expansion into multiple sources, so that we can combine a
populate action with a bitmap merge rather than having to do those as
separate commands, like:

{ "execute": "block-dirty-bitmap-populate", "arguments": {
    "job-id": "job0", "node": "target_node", "name": "target_bitmap",
    "sources": [ { "pattern": "allocation", "node": "from_node" },
                 { "pattern": "bitmap", "node": "from_node",
		     "bitmap": "from_bitmap" } ] } }

John Snow (5):
  block: add bitmap-populate job
  blockdev: combine DriveBackupState and BlockdevBackupState
  qmp: expose block-dirty-bitmap-populate
  iotests: move bitmap helpers into their own file
  iotests: add 298 for block-dirty-bitmap-populate

 qapi/block-core.json          |   66 +
 qapi/job.json                 |    6 +-
 qapi/transaction.json         |    2 +
 include/block/block.h         |    1 +
 include/block/block_int.h     |   21 +
 block/bitmap-populate.c       |  207 ++
 blockdev.c                    |  104 +-
 blockjob.c                    |    3 +-
 MAINTAINERS                   |    1 +
 block/meson.build             |    1 +
 tests/qemu-iotests/257        |  110 +-
 tests/qemu-iotests/298        |  232 ++
 tests/qemu-iotests/298.out    | 4544 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/bitmaps.py |  131 +
 tests/qemu-iotests/group      |    1 +
 15 files changed, 5301 insertions(+), 129 deletions(-)
 create mode 100644 block/bitmap-populate.c
 create mode 100755 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out
 create mode 100644 tests/qemu-iotests/bitmaps.py

-- 
2.28.0


