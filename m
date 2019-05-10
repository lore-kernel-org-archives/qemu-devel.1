Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26AED217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26AED217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAt2-0003Xo-AA
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:08:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPAne-0007Vk-Rw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hPAnc-0005u1-Tr
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hPAnZ-0005qB-ID; Fri, 10 May 2019 15:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31339C05681F;
	Fri, 10 May 2019 19:03:11 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-164.bos.redhat.com [10.18.17.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27B4B5ED4D;
	Fri, 10 May 2019 19:03:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 10 May 2019 15:03:03 -0400
Message-Id: <20190510190307.17647-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 10 May 2019 19:03:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/4] blockdev-backup: don't check
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See patch one's commit message for justification.

v2: added patch 4, with iotest framework adjustments in patches 2/3.

John Snow (4):
  blockdev-backup: don't check aio_context too early
  iotests.py: do not use infinite waits
  iotests.py: rewrite run_job to be pickier
  iotests: add iotest 250 for testing blockdev-backup across iothread
    contexts

 blockdev.c                    |   4 --
 tests/qemu-iotests/250        | 129 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out    | 119 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  44 ++++++------
 5 files changed, 270 insertions(+), 27 deletions(-)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

--=20
2.20.1


