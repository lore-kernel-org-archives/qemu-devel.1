Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E751C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146C52175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146C52175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39455 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1eY-0003r3-9f
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:17:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hP1dF-0003CV-J2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hP1dE-0008OI-66
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hP1dA-0008Me-Ek; Fri, 10 May 2019 05:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8053030821AE;
	Fri, 10 May 2019 09:15:51 +0000 (UTC)
Received: from thuth.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF9EF58B1;
	Fri, 10 May 2019 09:15:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Date: Fri, 10 May 2019 11:15:41 +0200
Message-Id: <20190510091541.4335-1-thuth@redhat.com>
In-Reply-To: <f39169a4-3916-9d1a-b3a5-b667e8775217@redhat.com>
References: <f39169a4-3916-9d1a-b3a5-b667e8775217@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 10 May 2019 09:15:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4] tests/qemu-iotests/group: Re-use the "auto"
 group for tests that can always run
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, all tests are in the "auto" group. This is a little bit pointl=
ess.
OTOH, we need a group for the tests that we can automatically run during
"make check" each time, too. Tests in this new group are supposed to run
with every possible QEMU configuration, for example they must run with ev=
ery
QEMU binary (also non-x86), without failing when an optional features is
missing (but reporting "skip" is ok), run with qcow2 and file protocol,
run reasonable fast, and be able to run on all kind of host filesystems
and users (i.e. also as "nobody" or "root").
So let's use the "auto" group for this class of tests now. The initial
list has been determined by running the iotests with non-x86 QEMU targets
and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. including
macOS and FreeBSD).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v4:
 - Dropped the tests from the "auto" group that run longer than 5s
 - Dropped also the tests that do not support the qcow2 format

 Alex, could you replace the patch in your patch series, too, please?

 tests/qemu-iotests/group | 262 +++++++++++++++++++++------------------
 1 file changed, 138 insertions(+), 124 deletions(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7ac9a5ea4a..a2260d0899 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -1,8 +1,22 @@
 #
 # QA groups control file
 # Defines test groups
+#
+# Some notes about the groups:
+#
 # - do not start group names with a digit
 #
+# - quick : Tests in this group should finish within some few seconds.
+#
+# - img : Tests in this group can be used to excercise the qemu-img tool=
.
+#
+# - auto : Tests in this group are used during "make check" and should b=
e
+#   runnable in any case. That means they should run with every QEMU bin=
ary
+#   (also non-x86), with every QEMU configuration (i.e. must not fail if
+#   an optional feature is not compiled in - but reporting a "skip" is o=
k),
+#   work with the qcow2 format and file protocol, run reasonably fast (<=
 10s)
+#   and work all kind of host filesystems and users (e.g. "nobody" or "r=
oot").
+#
=20
 #
 # test-group association ... one line per test
@@ -20,8 +34,8 @@
 011 rw auto quick
 012 auto quick
 013 rw auto
-014 rw auto
-015 rw snapshot auto
+014 rw
+015 rw snapshot
 # 016 was removed, do not reuse
 017 rw backing auto quick
 018 rw backing auto quick
@@ -29,14 +43,14 @@
 020 rw backing auto quick
 021 io auto quick
 022 rw snapshot auto
-023 rw auto
+023 rw
 024 rw backing auto quick
 025 rw auto quick
-026 rw blkdbg auto
+026 rw blkdbg
 027 rw auto quick
-028 rw backing auto quick
+028 rw backing quick
 029 rw auto quick
-030 rw auto backing
+030 rw backing
 031 rw auto quick
 032 rw auto quick
 033 rw auto quick
@@ -46,206 +60,206 @@
 037 rw auto backing quick
 038 rw auto backing quick
 039 rw auto quick
-040 rw auto
-041 rw auto backing
+040 rw
+041 rw backing
 042 rw auto quick
 043 rw auto backing
-044 rw auto
-045 rw auto quick
+044 rw
+045 rw quick
 046 rw auto aio quick
 047 rw auto quick
 048 img auto quick
 049 rw auto
 050 rw auto backing quick
-051 rw auto
+051 rw
 052 rw auto backing quick
 053 rw auto quick
 054 rw auto quick
-055 rw auto
-056 rw auto backing
-057 rw auto
-058 rw auto quick
-059 rw auto quick
+055 rw
+056 rw backing
+057 rw
+058 rw quick
+059 rw quick
 060 rw auto quick
 061 rw auto
 062 rw auto quick
 063 rw auto quick
-064 rw auto quick
-065 rw auto quick
+064 rw quick
+065 rw quick
 066 rw auto quick
-067 rw auto quick
-068 rw auto quick
+067 rw quick
+068 rw quick
 069 rw auto quick
-070 rw auto quick
+070 rw quick
 071 rw auto quick
 072 rw auto quick
 073 rw auto quick
 074 rw auto quick
-075 rw auto quick
-076 auto
-077 rw auto quick
-078 rw auto quick
+075 rw quick
+076 io
+077 rw quick
+078 rw quick
 079 rw auto
 080 rw auto
-081 rw auto quick
+081 rw quick
 082 rw auto quick
-083 rw auto
-084 img auto quick
-085 rw auto
+083 rw
+084 img quick
+085 rw
 086 rw auto quick
-087 rw auto quick
-088 rw auto quick
+087 rw quick
+088 rw quick
 089 rw auto quick
 090 rw auto quick
 091 rw auto migration
-092 rw auto quick
-093 auto
-094 rw auto quick
-095 rw auto quick
-096 rw auto quick
+092 rw quick
+093 throttle
+094 rw quick
+095 rw quick
+096 rw quick
 097 rw auto backing
 098 rw auto backing quick
 099 rw auto quick
 # 100 was removed, do not reuse
-101 rw auto quick
+101 rw quick
 102 rw auto quick
 103 rw auto quick
 104 rw auto
 105 rw auto quick
-106 rw auto quick
+106 rw quick
 107 rw auto quick
 108 rw auto quick
-109 rw auto
+109 rw
 110 rw auto backing quick
 111 rw auto quick
-112 rw auto
-113 rw auto quick
+112 rw
+113 rw quick
 114 rw auto quick
-115 rw auto
-116 rw auto quick
+115 rw
+116 rw quick
 117 rw auto
-118 rw auto
-119 rw auto quick
+118 rw
+119 rw quick
 120 rw auto quick
-121 rw auto
+121 rw
 122 rw auto
-123 rw auto quick
-124 rw auto backing
-125 rw auto
+123 rw quick
+124 rw backing
+125 rw
 126 rw auto backing
-127 rw auto backing quick
-128 rw auto quick
-129 rw auto quick
+127 rw backing quick
+128 rw quick
+129 rw quick
 130 rw auto quick
-131 rw auto quick
-132 rw auto quick
+131 rw quick
+132 rw quick
 133 auto quick
 134 rw auto quick
-135 rw auto
-136 rw auto
+135 rw
+136 rw
 137 rw auto
 138 rw auto quick
-139 rw auto quick
+139 rw quick
 140 rw auto quick
 141 rw auto quick
 142 auto
 143 auto quick
-144 rw auto quick
-145 auto quick
-146 auto quick
-147 auto
-148 rw auto quick
-149 rw auto sudo
+144 rw quick
+145 quick
+146 quick
+147 img
+148 rw quick
+149 rw sudo
 150 rw auto quick
-151 rw auto
-152 rw auto quick
-153 rw auto quick
+151 rw
+152 rw quick
+153 rw quick
 154 rw auto backing quick
-155 rw auto
+155 rw
 156 rw auto quick
-157 auto
+157 quick
 158 rw auto quick
 159 rw auto quick
-160 rw auto quick
+160 rw quick
 161 rw auto quick
-162 auto quick
-163 rw auto
-165 rw auto quick
-169 rw auto quick migration
+162 quick
+163 rw
+165 rw quick
+169 rw quick migration
 170 rw auto quick
-171 rw auto quick
+171 rw quick
 172 auto
-173 rw auto
+173 rw
 174 auto
-175 auto quick
+175 quick
 176 rw auto backing
 177 rw auto quick
-178 auto
+178 img
 179 rw auto quick
 181 rw auto migration
-182 rw auto quick
-183 rw auto migration
+182 rw quick
+183 rw migration
 184 rw auto quick
-185 rw auto
+185 rw
 186 rw auto
 187 rw auto
-188 rw auto quick
-189 rw auto
+188 rw quick
+189 rw
 190 rw auto quick
 191 rw auto
 192 rw auto quick
-194 rw auto migration quick
+194 rw migration quick
 195 rw auto quick
-196 rw auto quick migration
+196 rw quick migration
 197 rw auto quick
-198 rw auto
-199 rw auto migration
-200 rw auto
+198 rw
+199 rw migration
+200 rw
 201 rw auto migration
-202 rw auto quick
-203 rw auto migration
-204 rw auto quick
-205 rw auto quick
-206 rw auto
-207 rw auto
-208 rw auto quick
-209 rw auto quick
-210 rw auto
-211 rw auto quick
-212 rw auto quick
-213 rw auto quick
+202 rw quick
+203 rw migration
+204 rw quick
+205 rw quick
+206 rw
+207 rw
+208 rw quick
+209 rw quick
+210 rw
+211 rw quick
+212 rw quick
+213 rw quick
 214 rw auto
 215 rw auto quick
-216 rw auto quick
+216 rw quick
 217 rw auto quick
-218 rw auto quick
-219 rw auto
+218 rw quick
+219 rw
 220 rw auto
-221 rw auto quick
-222 rw auto quick
-223 rw auto quick
-224 rw auto quick
-225 rw auto quick
+221 rw quick
+222 rw quick
+223 rw quick
+224 rw quick
+225 rw quick
 226 auto quick
-227 auto quick
-228 rw auto quick
+227 quick
+228 rw quick
 229 auto quick
-231 auto quick
-232 auto quick
+231 quick
+232 quick
 233 auto quick
-234 auto quick migration
-235 auto quick
-236 auto quick
-237 rw auto quick
-238 auto quick
-239 rw auto quick
-240 auto quick
-241 rw auto quick
-242 rw auto quick
+234 quick migration
+235 quick
+236 quick
+237 rw quick
+238 quick
+239 rw quick
+240 quick
+241 rw quick
+242 rw quick
 243 rw auto quick
 244 rw auto quick
-245 rw auto
-246 rw auto quick
-247 rw auto quick
-248 rw auto quick
+245 rw
+246 rw quick
+247 rw quick
+248 rw quick
 249 rw auto quick
--=20
2.21.0


