Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB6C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E2420880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E2420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMZu-0001KA-CJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hnMZb-0000V4-Si
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hnMZb-000308-0J
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hnMZZ-0002z5-0O; Tue, 16 Jul 2019 08:28:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B792309174E;
 Tue, 16 Jul 2019 12:28:44 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05EE860C05;
 Tue, 16 Jul 2019 12:28:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Date: Tue, 16 Jul 2019 14:28:32 +0200
Message-Id: <20190716122836.31187-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 12:28:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/4] Enable iotests during "make check"
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's enable the block iotests during "make check" again, to avoid that
they get broken so easily by accident (like we've seen many times in the
past).

v2:
 - Added new patch to allow tests without groups, removed the "o_direct"
   group again.
 - Removed some more tests from the "auto" group, like 197 and 215 which
   were sometimes causing the CI pipelines to fail on gitlab
 - Added a patch to remove the "duplicated" tests from the gitlab-ci.yml
   file.

Thomas Huth (4):
  tests/qemu-iotests/check: Allow tests without groups
  tests/qemu-iotests/group: Remove some more tests from the "auto" group
  tests: Run the iotests during "make check" again
  gitlab-ci: Remove qcow2 tests that are handled by "make check" already

 .gitlab-ci.yml              |  12 +---
 tests/Makefile.include      |   8 +--
 tests/check-block.sh        |  44 ++++++++++----
 tests/qemu-iotests-quick.sh |   8 ---
 tests/qemu-iotests/check    |   4 +-
 tests/qemu-iotests/group    | 114 ++++++++++++++++++------------------
 6 files changed, 101 insertions(+), 89 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

--=20
2.21.0


