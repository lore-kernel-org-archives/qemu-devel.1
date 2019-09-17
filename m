Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EC8C4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79FFE21852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FFE21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9lm-0000XJ-I4
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iA9eu-0001jA-2x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iA9es-0004aK-Sp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iA9eq-0004Xu-BH; Tue, 17 Sep 2019 05:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A073F3680A;
 Tue, 17 Sep 2019 09:20:23 +0000 (UTC)
Received: from localhost (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FACB5D6B2;
 Tue, 17 Sep 2019 09:20:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 11:20:00 +0200
Message-Id: <20190917092004.999-4-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-1-mreitz@redhat.com>
References: <20190917092004.999-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 09:20:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 3/7] iotests: Use case_skip() in
 skip_if_unsupported()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

skip_if_unsupported() should use the stronger variant case_skip(),
because this allows it to be used even with setUp() (in a meaningful
way).

In the process, make it explicit what we expect the first argument of
the func_wrapper to be (namely something derived of QMPTestCase).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index e46f3b6aed..427c34697a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -893,14 +893,14 @@ def skip_if_unsupported(required_formats=3D[], read=
_only=3DFalse):
     '''Skip Test Decorator
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
-        def func_wrapper(*args, **kwargs):
+        def func_wrapper(test_case: QMPTestCase, *args, **kwargs):
             usf_list =3D list(set(required_formats) -
                             set(supported_formats(read_only)))
             if usf_list:
-                case_notrun('{}: formats {} are not whitelisted'.format(
-                    args[0], usf_list))
+                test_case.case_skip('{}: formats {} are not whitelisted'=
.format(
+                    test_case, usf_list))
             else:
-                return func(*args, **kwargs)
+                return func(test_case, *args, **kwargs)
         return func_wrapper
     return skip_test_decorator
=20
--=20
2.21.0


