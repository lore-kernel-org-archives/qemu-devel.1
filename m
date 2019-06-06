Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57F4C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEA220657
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEA220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYzve-0007lR-Jd
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu5-0005bq-H6
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziZ-00087T-Ga
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziZ-00086O-9Z
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A463C0624A1;
 Thu,  6 Jun 2019 21:14:25 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83634108F832;
 Thu,  6 Jun 2019 21:14:24 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:09 -0400
Message-Id: <20190606211414.8681-3-crosa@redhat.com>
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
References: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 06 Jun 2019 21:14:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 2/7] Acceptance tests: keep a stable
 reference to the QEMU build dir
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is related to the the differences in in-tree and out-of-tree
builds in QEMU.  For simplification, <BLD> means my build directory.

Currently, by running a `make check-acceptance` one gets (in
tests/acceptance/avocado_qemu/__init__.py):

   SRC_ROOT_DIR: <BLD>/tests/acceptance/avocado_qemu/../../..

This in itself is problematic, because after the parent directories
are applied, one may be left not with a pointer to the build directory
as intended, but with the location of the source tree (assuming they
differ). Built binaries, such as qemu-img, are of course not there and
can't be found.

Given that a Python '__file__' will contain the absolute path to the
file backing the module, say:

   __file__: <BLD>/tests/acceptance/avocado_qemu/__init__.py

                  |  4  |     3    |      2     |     1     |

A solution is to not "evaluate" the third parent dir (marked as 4
here) because that ends up following the "tests" directory symlink to
the source tree.  In fact, there's no need to keep or evaluate any of
the parent directories, we can just drop the rightmost 4 components,
and we'll keep a stable reference to the build directory (with no
symlink being followed).  This works for either a dedicated build
directory or also a combined source and build tree.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 2b236a1cf0..ac59d36a4c 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -14,7 +14,7 @@ import uuid
=20
 import avocado
=20
-SRC_ROOT_DIR =3D os.path.join(os.path.dirname(__file__), '..', '..', '..=
')
+SRC_ROOT_DIR =3D os.path.dirname(os.path.dirname(os.path.dirname(os.path=
.dirname(__file__))))
 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
=20
 from qemu import QEMUMachine
--=20
2.21.0


