Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C682FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91948218AE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjChTgQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91948218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkUw-0007JY-7Y
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iWkQk-0003TJ-PK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iWkQh-0002gY-SS
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:03:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iWkQh-0002eW-LZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574096590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=da4fDKwA4prJWmrg9/29KN8KpBAXT7d8UykgKQb9FxU=;
 b=LjChTgQrsT0Er45i03+LwZ+GYn8ab/4xf6G6zphuI5tUYA6WPk83RasnFgK56tSfWCzL9Q
 0S/79J2eXlU+p7cx1nhoPeX3MS9gLYwSa4VQUiyvbeRWUdbCU05J4onfAaHY3cWsHE1FZn
 0uTmmscz5EBAXHu+hxIEwJE/iNeMcnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-nmXInWj-MSaCVfLzz2rCgA-1; Mon, 18 Nov 2019 12:03:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67AAC10054C5;
 Mon, 18 Nov 2019 17:03:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-108.ams2.redhat.com
 [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAD38608B5;
 Mon, 18 Nov 2019 17:03:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/4] Block layer patches for 4.2.0-rc2
Date: Mon, 18 Nov 2019 18:02:52 +0100
Message-Id: <20191118170256.31477-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nmXInWj-MSaCVfLzz2rCgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit bbe165740a96f67f48ecd3029dc26bdd7fd5192c=
:

  Merge remote-tracking branch 'remotes/vivier2/tags/ppc-for-4.2-pull-reque=
st' into staging (2019-11-18 11:09:06 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to b1f6a8e180367c945b67c6c9bbcec5c856be3779:

  iotests: Test multiple blockdev-snapshot calls (2019-11-18 17:50:08 +0100=
)

----------------------------------------------------------------
Block layer patches:

- Fix HMP savevm with -blockdev
- Minor iotests improvements

----------------------------------------------------------------
Kevin Wolf (3):
      iotests: Fix "no qualified output" error path
      block: Remove 'backing': null from bs->{explicit_,}options
      iotests: Test multiple blockdev-snapshot calls

Vladimir Sementsov-Ogievskiy (1):
      qemu-iotests/iotests.py: improve assert_qmp message

 block.c                       |   2 +
 tests/qemu-iotests/273        |  76 ++++++++++
 tests/qemu-iotests/273.out    | 337 ++++++++++++++++++++++++++++++++++++++=
++++
 tests/qemu-iotests/check      |   2 +-
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   4 +-
 6 files changed, 419 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/273
 create mode 100644 tests/qemu-iotests/273.out


