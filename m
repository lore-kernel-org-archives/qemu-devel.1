Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ADC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DFF2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DFF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhz3-00082r-Vu
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hnhyY-0006ge-Fv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hnhyX-00081L-5y
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hnhyV-0007yM-05; Wed, 17 Jul 2019 07:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 04A333D95A;
 Wed, 17 Jul 2019 11:19:54 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7E9319C68;
 Wed, 17 Jul 2019 11:19:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Date: Wed, 17 Jul 2019 13:19:43 +0200
Message-Id: <20190717111947.30356-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 17 Jul 2019 11:19:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/4] Enable iotests during "make check"
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

v3:
 - Added dependency for "check-block" so that the *-softmmu targets are
   now built first
 - Added 197 and 215 back to gitlab-ci.yml (there is no problem if they
   do not run in parallel with the qtests)
 - Removed 122 from the "auto" group (does not work on ZFS according to
   Alex)
 - Removed 181 and 201 from the "auto" group (they do not work if the
   default machine of QEMU does not support migration)

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

 .gitlab-ci.yml              |  13 ++--
 tests/Makefile.include      |  10 +--
 tests/check-block.sh        |  44 ++++++++++---
 tests/qemu-iotests-quick.sh |   8 ---
 tests/qemu-iotests/check    |   4 +-
 tests/qemu-iotests/group    | 120 ++++++++++++++++++------------------
 6 files changed, 107 insertions(+), 92 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

--=20
2.21.0


