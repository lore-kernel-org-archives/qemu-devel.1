Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED0C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB1020838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3LXNBVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB1020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46861 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OYJ-0004J1-Ez
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OWr-00024H-9j
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWq-0007st-6G
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWq-0007rd-37
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PpB3Kb7mqPMHKkyi0v6SRrqTGWFNkrLOCQ02rj4Ntl4=;
 b=a3LXNBVzSUTrReVjb9WC7C7bZYSe0aFxWN/H68D7Tx00pmAJkPLm0pn/gQWGgEfliI9gEC
 xELpftwm3SaqLXyJuZYUjo0fWpJDyxsDxeAbhx0kCiqW1POMcwmDve9kwCgC/EAU3BLtz5
 t/hyM7Jzh2TO/ob6AjDloo/+ur7KieY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-SQBsA-_0Ov-Zf-DvAtvjCQ-1; Mon, 24 Feb 2020 19:56:44 -0500
X-MC-Unique: SQBsA-_0Ov-Zf-DvAtvjCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422FE800D53;
 Tue, 25 Feb 2020 00:56:43 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC4889F30;
 Tue, 25 Feb 2020 00:56:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] block: add block-dirty-bitmap-populate job
Date: Mon, 24 Feb 2020 19:56:35 -0500
Message-Id: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
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

Patches 1-2: The new job.
Patch 3: iotest prerequisite
Patch 4-5: completely optional cleanup.
Patch 6: Test.

John Snow (6):
  block: add bitmap-populate job
  qmp: expose block-dirty-bitmap-populate
  iotests: move bitmap helpers into their own file
  iotests: add hmp helper with logging
  qmp.py: change event_wait to use a dict
  iotests: add 287 for block-dirty-bitmap-populate

 qapi/block-core.json          |   66 +
 qapi/job.json                 |    2 +-
 qapi/transaction.json         |    2 +
 include/block/block_int.h     |   21 +
 block/bitmap-alloc.c          |  207 ++
 blockdev.c                    |   78 +
 blockjob.c                    |    3 +-
 block/Makefile.objs           |    1 +
 python/qemu/machine.py        |   10 +-
 tests/qemu-iotests/040        |   12 +-
 tests/qemu-iotests/257        |  110 +-
 tests/qemu-iotests/260        |    5 +-
 tests/qemu-iotests/287        |  233 ++
 tests/qemu-iotests/287.out    | 4544 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/bitmaps.py |  131 +
 tests/qemu-iotests/group      |    1 +
 tests/qemu-iotests/iotests.py |   34 +-
 17 files changed, 5321 insertions(+), 139 deletions(-)
 create mode 100644 block/bitmap-alloc.c
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out
 create mode 100644 tests/qemu-iotests/bitmaps.py

--=20
2.21.1


