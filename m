Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7D5206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Dxq-0004k3-7S
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 19:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i0Dvq-0002XP-Vp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i0Dvp-00054v-Pz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i0Dvm-00050n-KO; Tue, 20 Aug 2019 19:52:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA9D37F747;
 Tue, 20 Aug 2019 23:52:49 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 443B657990;
 Tue, 20 Aug 2019 23:52:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 19:52:42 -0400
Message-Id: <20190820235243.26092-4-jsnow@redhat.com>
In-Reply-To: <20190820235243.26092-1-jsnow@redhat.com>
References: <20190820235243.26092-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 20 Aug 2019 23:52:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/4] iotests: add protocol support to
 initialization info
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will add supported_protocols and unsupported_protocols to all of
iotests.main, iotests.script_main, and iotests.script_initialize.
---
 tests/qemu-iotests/207        | 4 ++--
 tests/qemu-iotests/210        | 4 ++--
 tests/qemu-iotests/211        | 4 ++--
 tests/qemu-iotests/212        | 4 ++--
 tests/qemu-iotests/213        | 4 ++--
 tests/qemu-iotests/iotests.py | 5 ++++-
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index ab9e3b6747..35d98f2736 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -24,8 +24,8 @@ import iotests
 import subprocess
 import re
=20
-iotests.script_initialize(supported_fmts=3D['raw'])
-iotests.verify_protocol(supported=3D['ssh'])
+iotests.script_initialize(supported_fmts=3D['raw'],
+                          supported_protocols=3D['ssh'])
=20
 def filter_hash(qmsg):
     def _filter(key, value):
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 5a7013cd34..d9fe780c07 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['luks'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['luks'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 4d6aac497f..155fac4e87 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['vdi'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['vdi'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index ec35bceb11..67e5a1dbb5 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['parallels'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['parallels'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 3d2c024375..23f387ab63 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['vhdx'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['vhdx'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 2970d7304a..661d7f93bf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -925,7 +925,9 @@ def execute_unittest(debug=3DFalse):
 def execute_setup_common(supported_fmts=3D[],
                          supported_oses=3D['linux'],
                          supported_cache_modes=3D[],
-                         unsupported_fmts=3D[]):
+                         unsupported_fmts=3D[],
+                         supported_protocols=3D[],
+                         unsupported_protocols=3D[]):
     """
     Perform necessary setup for either script-style or unittest-style te=
sts.
     """
@@ -941,6 +943,7 @@ def execute_setup_common(supported_fmts=3D[],
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
+    verify_protocol(supported_protocols, unsupported_protocols)
=20
     debug =3D '-d' in sys.argv
     if debug:
--=20
2.21.0


