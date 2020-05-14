Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A93C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5298020575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9fgNwjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5298020575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ4tI-00010b-C8
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 23:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ4sH-0008BJ-PO
 for qemu-devel@nongnu.org; Wed, 13 May 2020 23:49:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46361
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ4sF-0008Oa-Pj
 for qemu-devel@nongnu.org; Wed, 13 May 2020 23:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589428170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rWNCUlSJQKzyzQBkJWNjrTBfCQAQ3RBbSU5PzxC620k=;
 b=D9fgNwjwh/752F+PjVz1EwmdkXl7xc0+dGv+BBLBy9f5Y7APZcE/Wgqxm9iJ9ridkU/edR
 KxsuJZ90k3DfPFfSty3Q7IHwysMRBmNaYwDl/2KGSA8BTTs44LF1iAZarqLh96wQdrj+s7
 QrlS4A0BUz6d5mKFoXVYp8JiRuINMWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-nrb-fFVuMJyX9wkaVKa6HA-1; Wed, 13 May 2020 23:49:28 -0400
X-MC-Unique: nrb-fFVuMJyX9wkaVKa6HA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D559BFC3;
 Thu, 14 May 2020 03:49:27 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38FE67049C;
 Thu, 14 May 2020 03:49:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 0/5] block: add block-dirty-bitmap-populate job
Date: Wed, 13 May 2020 23:49:17 -0400
Message-Id: <20200514034922.24834-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is a new (very small) block job that writes a pattern into a
bitmap. The only pattern implemented is the top allocation information.

This can be used to "recover" an incremental bitmap chain if an external
snapshot was taken without creating a new bitmap first: any writes made
to the image will be reflected by the allocation status and can be
written back into a bitmap.

This is useful for e.g. libvirt managing backup chains if a user creates
an external snapshot outside of libvirt.

v2:
 - Addressed some, but not all feedback
 - Rebased on latest 'job-runner' series; but it's not clear if it
   should be kept.
 - This version doesn't address all of the feedback from v1,
   but I am posting it to the list as an RFC.

John Snow (5):
  block: add bitmap-populate job
  blockdev: combine DriveBackupState and BlockdevBackupState
  qmp: expose block-dirty-bitmap-populate
  iotests: move bitmap helpers into their own file
  iotests: add 287 for block-dirty-bitmap-populate

 qapi/block-core.json          |   66 +
 qapi/job.json                 |    2 +-
 qapi/transaction.json         |    2 +
 include/block/block_int.h     |   21 +
 block/bitmap-alloc.c          |  207 ++
 blockdev.c                    |  104 +-
 blockjob.c                    |    3 +-
 block/Makefile.objs           |    1 +
 tests/qemu-iotests/257        |  110 +-
 tests/qemu-iotests/287        |  242 ++
 tests/qemu-iotests/287.out    | 4544 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/bitmaps.py |  131 +
 tests/qemu-iotests/group      |    1 +
 13 files changed, 5305 insertions(+), 129 deletions(-)
 create mode 100644 block/bitmap-alloc.c
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out
 create mode 100644 tests/qemu-iotests/bitmaps.py

-- 
2.21.1


