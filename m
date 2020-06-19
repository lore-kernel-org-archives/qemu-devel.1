Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD6FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A94E20C09
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COBwYd/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A94E20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmN8c-0005VU-Dw
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7k-0004BU-4X
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7i-0007cb-Dm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592596585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p5mtZP/hx5YXv0cvBgbDwE6rgsFhTf80FSer8uCLjus=;
 b=COBwYd/uyoomlE1Ibq6+2CNuLTDkr5clP8IQbXABz3V7dX7JhTdJonmJhCdfdkgRZePeBb
 XRRsO2srQI3Vo94gHiFUh0QD77z7wCJZJaoDxaM0y3PEFbezijgBhUwvxYcJwH2YsgeRur
 uJXV+K12wslZai6f1RvyCVBGncGLX7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-Vg9LxtNiOLCtFCxEjAZ9Fg-1; Fri, 19 Jun 2020 15:56:23 -0400
X-MC-Unique: Vg9LxtNiOLCtFCxEjAZ9Fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4340056B9C;
 Fri, 19 Jun 2020 19:56:22 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6CB7166C;
 Fri, 19 Jun 2020 19:56:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/6] block: add block-dirty-bitmap-populate job
Date: Fri, 19 Jun 2020 14:56:15 -0500
Message-Id: <20200619195621.58740-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 15:56:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[From John's original cover letter:]
This is a new (very small) block job that writes a pattern into a
bitmap. The only pattern implemented is the top allocation information.

This can be used to "recover" an incremental bitmap chain if an external
snapshot was taken without creating a new bitmap first: any writes made
to the image will be reflected by the allocation status and can be
written back into a bitmap.

This is useful for e.g. libvirt managing backup chains if a user creates
an external snapshot outside of libvirt.

v3:
 - Addressed a bit more feedback
 - Make it easier to decide if we want an x- prefix if we think there
 are more tweaks to be made to the interface
 - Drop dependency on John's JobRunner iotest series
 - Renumber the new iotest

I know there was a lot of discussion about whether there are
optimizations to be made with populating directly into the target
bitmap rather than into a temporary that then gets merged in at the
completion of the job, but the QMP aspect seems fairly stable.  Even
so, we may still want to consider using an x- prefix until we know for
sure whether libvirt can make decent use of the interface.

Eric Blake (1):
  bitmaps: Use x- prefix for block-dirty-bitmap-popluate

John Snow (5):
  block: add bitmap-populate job
  blockdev: combine DriveBackupState and BlockdevBackupState
  qmp: expose block-dirty-bitmap-populate
  iotests: move bitmap helpers into their own file
  iotests: add 298 for block-dirty-bitmap-populate

 qapi/block-core.json          |   66 +
 qapi/job.json                 |    6 +-
 qapi/transaction.json         |    2 +
 include/block/block_int.h     |   21 +
 block/bitmap-populate.c       |  207 ++
 blockdev.c                    |  104 +-
 blockjob.c                    |    3 +-
 MAINTAINERS                   |    1 +
 block/Makefile.objs           |    1 +
 tests/qemu-iotests/257        |  110 +-
 tests/qemu-iotests/298        |  232 ++
 tests/qemu-iotests/298.out    | 4544 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/bitmaps.py |  131 +
 tests/qemu-iotests/group      |    1 +
 14 files changed, 5300 insertions(+), 129 deletions(-)
 create mode 100644 block/bitmap-populate.c
 create mode 100755 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out
 create mode 100644 tests/qemu-iotests/bitmaps.py

-- 
2.27.0


