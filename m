Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 22:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E6420873
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 22:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO1UzOkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E6420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbWpP-0002pK-It
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 18:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbWmN-0005G0-PM
 for qemu-devel@nongnu.org; Wed, 20 May 2020 18:01:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbWmM-0005kL-P1
 for qemu-devel@nongnu.org; Wed, 20 May 2020 18:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590012093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zdEj+iO4Ja0lQkfxzafSeWcrY9kIsFL5NMxKIbVphVg=;
 b=cO1UzOkGSk1dtUYYILKP97bCBVQ3GsnygLJ6a/Zf8Ypf91ctUdpiqYyiLwRbJIDL2EKTrx
 lts0HsNUSjvYCBpPK1SWiwLzsLJ67XjPQQAGfrwb6ar48lYVVeENy04/wgO3NYWOIH0MRP
 2XsrGlT4NM9SmD5zOatD/4iTmcM/5qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-P_cxHLiXNvO1Q1itPK6vtA-1; Wed, 20 May 2020 18:01:20 -0400
X-MC-Unique: P_cxHLiXNvO1Q1itPK6vtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CF22474;
 Wed, 20 May 2020 22:01:19 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC096EA19;
 Wed, 20 May 2020 22:01:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/5] qemu-img: Add convert --bitmaps
Date: Wed, 20 May 2020 17:01:13 -0500
Message-Id: <20200520220118.1037094-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 17:32:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v4 was here:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03182.html
original cover letter here:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03464.html

Based-on: <20200519175707.815782-1-eblake@redhat.com>
[pull v3 bitmaps patches for 2020-05-18]

Since then:
- patch 1 is new (fixes regression from recent NBD pull)
- patch 2, 4: include fixes suggested by Vladimir; biggest is that
bitmaps computation is now in qcow2-bitmaps.c instead of qcow2.c
- patch 3: split out from patch 4 (was v4 8/9)
- patch 5: rebase to master

001/5:[down] 'iotests: Fix test 178'
002/5:[0106] [FC] 'qcow2: Expose bitmaps' size during measure'
003/5:[down] 'qemu-img: Factor out code for merging bitmaps'
004/5:[0012] [FC] 'qemu-img: Add convert --bitmaps option'
005/5:[0002] [FC] 'iotests: Add test 291 to for qemu-img bitmap coverage'

Series can also be downloaded at:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/qemu-img-bitmaps-v5

Eric Blake (5):
  iotests: Fix test 178
  qcow2: Expose bitmaps' size during measure
  qemu-img: Factor out code for merging bitmaps
  qemu-img: Add convert --bitmaps option
  iotests: Add test 291 to for qemu-img bitmap coverage

 docs/tools/qemu-img.rst          |  18 ++++-
 qapi/block-core.json             |  15 ++--
 block/qcow2.h                    |   2 +
 block/crypto.c                   |   2 +-
 block/qcow2-bitmap.c             |  36 +++++++++
 block/qcow2.c                    |  14 +++-
 block/raw-format.c               |   2 +-
 qemu-img.c                       | 135 +++++++++++++++++++++++++++----
 qemu-img-cmds.hx                 |   8 +-
 tests/qemu-iotests/178.out.qcow2 |  18 ++++-
 tests/qemu-iotests/178.out.raw   |   2 +-
 tests/qemu-iotests/190           |  58 ++++++++++++-
 tests/qemu-iotests/190.out       |  35 +++++++-
 tests/qemu-iotests/291           | 112 +++++++++++++++++++++++++
 tests/qemu-iotests/291.out       |  80 ++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 16 files changed, 501 insertions(+), 37 deletions(-)
 create mode 100755 tests/qemu-iotests/291
 create mode 100644 tests/qemu-iotests/291.out

-- 
2.26.2


