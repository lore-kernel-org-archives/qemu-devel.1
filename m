Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF8520675
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF8520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrD5-0004tx-2A
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:08:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTrBK-0003jl-7Y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTrBF-0001fw-4k
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hTrB7-0001Zq-Mb; Thu, 23 May 2019 13:06:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0CE181F0D;
	Thu, 23 May 2019 17:06:48 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3ACFF1001DEF;
	Thu, 23 May 2019 17:06:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 23 May 2019 13:06:38 -0400
Message-Id: <20190523170643.20794-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 23 May 2019 17:06:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/5] blockdev-backup: don't check
 aio_context too early
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See patch one's commit message for justification.
Patches 2-5 are for testing, because that's always how these things go.

001/5:[----] [--] 'blockdev-backup: don't check aio_context too early'
002/5:[0004] [FC] 'iotests.py: do not use infinite waits'
003/5:[down]      'QEMUMachine: add events_wait method'
004/5:[0022] [FC] 'iotests.py: rewrite run_job to be pickier'
005/5:[0017] [FC] 'iotests: add iotest 250 for testing blockdev-backup
                   across iothread contexts'

v3: Rebased on Max's staging branch:
    Rebase patch 2
    added patch 3, to add events_wait.
    Rework patch 4 to make run_job consume legacy events, too
    Minorly edit patch 5 due to the two above.
v2: added patch 4, with iotest framework adjustments in patches 2/3.

John Snow (5):
  blockdev-backup: don't check aio_context too early
  iotests.py: do not use infinite waits
  QEMUMachine: add events_wait method
  iotests.py: rewrite run_job to be pickier
  iotests: add iotest 250 for testing blockdev-backup across iothread
    contexts

 blockdev.c                    |   4 --
 python/qemu/__init__.py       |  69 +++++++++++++------
 tests/qemu-iotests/250        | 122 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out    | 119 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  60 ++++++++++-------
 6 files changed, 326 insertions(+), 49 deletions(-)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

--=20
2.20.1


