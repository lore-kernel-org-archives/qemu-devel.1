Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F03F2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F03F2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42849 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsC4-0002Yx-F8
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:57:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAv-0001ur-In
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDsAu-0006mH-Mo
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:56:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:39712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDsAu-0006lM-BM; Tue, 09 Apr 2019 10:56:36 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDsAq-0007rL-TL; Tue, 09 Apr 2019 17:56:33 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  9 Apr 2019 17:56:30 +0300
Message-Id:
 <1554821792-968307-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 0/2] qemu-img convert: ignore read errors
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
	andrey.shinkevich@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409145630.y7aIDOR-tOciR9gminpAvmhIH8-MpwZLrnOy793-1HI@z>

The 'qemu-img convert' new command option 'force read' with the key '-R'
allows converting a damaged image to get all the available information
in case of the read errors. The program reports read errors and continue
the image conversion. The users should keep in their minds that the
resulting image is inconsistent.

Andrey Shinkevich (2):
  qemu-img convert: ignore read errors
  iotests: new test 253 check qemu-img convert force read

 qemu-img-cmds.hx           |  4 +--
 qemu-img.c                 | 18 ++++++++++--
 qemu-img.texi              |  2 +-
 tests/qemu-iotests/253     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out |  4 +++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 93 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

-- 
1.8.3.1


