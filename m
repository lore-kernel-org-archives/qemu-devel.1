Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C008C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4970C20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cZ3SlT8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4970C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3D2-0006nO-Fe
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH3Ag-0002lj-9X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH3Ae-0001lz-1k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:22:02 -0400
Received: from mail-vi1eur05on2096.outbound.protection.outlook.com
 ([40.107.21.96]:23520 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH3AY-0001cp-D4; Wed, 25 Mar 2020 06:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvewh4OGta6eOCHsU5WaFEUMHZLCap4lYaYuXemNLIYPuukqy59o0CdjYJ7rBwFeXgQqLt/OxFTF2aZvo4qsYFjazWHwjOcQaWzwobQS3biZCN9gcTmqoOLp0Bi9toaz7XlZJ7bhiGG9xA2JBssTLpdL9sTK7Ll0rvzn4h02rCm8RAWDCuv1zcW5r8SoWR9HRWXsE9Asp0H7++cfkYZ+aHHSZpvjMn13+wIm2Hl06qzkphczv5GmMTIN6B+3oNg20MGx82JdU8OCzl9/+kYGMc9VshUbYR6snmA1+uzXAYUG7aFLJ3Dqkd4oXwBg4f+2sLEzNkwbmJRc3r0Ix9AChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75J8qW8JuVMh96Lx7fwOPUXbUZ8g6BiPejgTOQZBqrI=;
 b=BPEbGkHDiekqLN3n+yp/3WFrVeWYxexvS4usG78hEL9q8NViXUHY4iMaHIx6zbCJ/xF67VErmFE0WKDb567KfdhSQTpgLzmz9kznulbuoRKz+JT8aKIjAPYv68bGvqGr8EAaQZJpDjFz5wdrDWtbXiNHC5C2nwr+xsJmFsgo66ZMCWvSo8mnh38F0DpftjVoZ+AG3EtLtVOET5MQNXba19WyVnM21724gemZlDmqjbFezg1Ht0o68OWaK4IkvqOcrlxTJHV8HLhvg/cIkegsecuNeKMMtCRKxOhYIuk96weC3ayIyXV3oSQYNULIzXzTq+rdfd9t9mAzgvCvIYqCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75J8qW8JuVMh96Lx7fwOPUXbUZ8g6BiPejgTOQZBqrI=;
 b=cZ3SlT8gf8GngWd/06zkN9mdtWNyWHtpWDDs1K6BY97lbMcRPWagKfIg4QFWoYzoHNWX97LePgL241roGEsG/o1igM1Dhcbs8560CVljaPtRZRQH77SXnzQmc81Tl1NyQT5AJZQynx1bKhzQRyI2ilPPyl9rHjqZCqRHaJ29pi0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5303.eurprd08.prod.outlook.com (10.141.171.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 10:21:51 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:21:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/2] iotests: rework test finding
Date: Wed, 25 Mar 2020 13:21:31 +0300
Message-ID: <20200325102131.23270-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325102131.23270-1-vsementsov@virtuozzo.com>
References: <20200325102131.23270-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.39) by
 AM4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 10:21:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7f5a17-a06e-4336-0c92-08d7d0a655a2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5303BD929B7C8D005AE1E6BEC1CE0@AM7PR08MB5303.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(346002)(366004)(136003)(396003)(376002)(6666004)(6506007)(86362001)(6512007)(316002)(52116002)(5660300002)(66556008)(66476007)(66946007)(30864003)(69590400007)(2906002)(6486002)(6916009)(956004)(36756003)(8936002)(1076003)(26005)(4326008)(478600001)(186003)(16526019)(2616005)(8676002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5303;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76S3lCsBfHVRCTAJuYsTg8vIGvJajrXeKYlAhsZxx6aksgCbN+G42sQ8KuQOG8ur2VSt92P1kBPnHk888lGOyFY3OC3fNQZqgd582Y85R4lZn2rSs+3dHq/Da3tLTPDArOUPJvIMs9w9o7GQAW6mefN7b2bNZ8dmp3a07MbbDKyNONRPsAhnFtsyTFNbfxxQ5it/dur7Gwcpt9rW83By6aciArA3rkdmcKvIlRxa4r7KeuAzhzYp/J+kDXTYG5wtPX2MC9epfSoPEUol6kPGJm//tztYOFI80M6m7LEK8JHaxuLevpMSpBoxC8ZZwfmML8shc9euS58Z+WQhtNRRJ01LlyEcSUASZD1iBHt96gaNK2/sWOMGedeoxz9UdEZW8vfTQUl7/58cLTwcrOwdOpgusRy8feVd08wFa9tVDvN/s1m2ohGEeJP5lWkqndcD1gvDteCDirMAEss9QEzmUMSm+ISy6NPRVfpEnSYwWr5yv1mBFY+4pp4G9yo25xZ5
X-MS-Exchange-AntiSpam-MessageData: rdX6dtP7Z5YSYltn/7ZcrpCsyBb+msymKmVXTcETPPKD8pBIYvY5qRngJxx+0ydb0gDGiXtRof+ZVTXP3KssImnc4blDRTtEQUvcupckd8jas+9Ka1+7EEkIzEa24hbWFdL6pZVQgOJpegSVY/Q3hg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7f5a17-a06e-4336-0c92-08d7d0a655a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 10:21:51.7559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr/O0WAOLFfWISWD1e4pwxtOaWldlbkQbwY+tRryrZHT5W/Ii0K0j2mbSJtT3soPvEDkEMltDhEI7vNolJL0dWEmNK+b0E//WW7M8QeR554=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5303
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.96
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add python script with new logic of searching for tests:

Old behavior:
 - tests are named [0-9][0-9][0-9]
 - tests must be registered in group file (even if test doesn't belong
   to any group, like 142)

New behavior:
 - group file is dropped
 - tests are searched by file-name instead of group file, so it's not
   needed more to "register the test", just create it with name
   test-*. Old names like [0-9][0-9][0-9] are supported too, but not
   recommended for new tests
 - groups are parsed from '# group: ' line inside test files
 - optional file group.local may be used to define some additional
   groups for downstreams
 - 'disabled' group is used to temporary disable tests. So instead of
   commenting tests in old 'group' file you now can add them to
   disabled group with help of 'group.local' file

Benefits:
 - no rebase conflicts in group file on patch porting from branch to
   branch
 - no conflicts in upstream, when different series want to occupy same
   test number
 - meaningful names for test files
   For example, with digital number, when some person wants to add some
   test about block-stream, he most probably will just create a new
   test. But if there would be test-block-stream test already, he will
   at first look at it and may be just add a test-case into it.
   And anyway meaningful names are better and test-* notation is
   already used in tests directory.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 docs/devel/testing.rst           |  51 +++++-
 tests/qemu-iotests/check         |  20 +--
 tests/qemu-iotests/find_tests.py |  72 ++++++++
 tests/qemu-iotests/group         | 298 -------------------------------
 4 files changed, 132 insertions(+), 309 deletions(-)
 create mode 100755 tests/qemu-iotests/find_tests.py
 delete mode 100644 tests/qemu-iotests/group

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 770a987ea4..5532f1abe4 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -153,7 +153,7 @@ check-block
 -----------
=20
 ``make check-block`` runs a subset of the block layer iotests (the tests t=
hat
-are in the "auto" group in ``tests/qemu-iotests/group``).
+are in the "auto" group).
 See the "QEMU iotests" section below for more information.
=20
 GCC gcov support
@@ -267,6 +267,55 @@ another application on the host may have locked the fi=
le, possibly leading to a
 test failure.  If using such devices are explicitly desired, consider addi=
ng
 ``locking=3Doff`` option to disable image locking.
=20
+Test case groups
+----------------
+
+Test may belong to some groups, you may define it in the comment inside th=
e
+test. By convention, test groups are listed in the second line of the test
+file, after "#!/..." line, like this:
+
+.. code::
+
+  #!/usr/bin/env python3
+  # group: auto quick
+  #
+  ...
+
+Additional way of defining groups is creating tests/qemu-iotests/group.loc=
al
+file. This should be used only for downstream (this file should never appe=
ar
+in upstream). This file may be used for defining some downstream test grou=
ps
+or for temporary disable tests, like this:
+
+.. code::
+
+  # groups for some company downstream process
+  #
+  # ci - tests to run on build
+  # down - our downstream tests, not for upstream
+  #
+  # Format of each line is:
+
+  013 ci
+  210 disabled
+  215 disabled
+  test-our-ugly-workaround down ci
+
+The following groups are defined:
+
+- quick : Tests in this group should finish within some few seconds.
+
+- img : Tests in this group can be used to excercise the qemu-img tool.
+
+- auto : Tests in this group are used during "make check" and should be
+  runnable in any case. That means they should run with every QEMU binary
+  (also non-x86), with every QEMU configuration (i.e. must not fail if
+  an optional feature is not compiled in - but reporting a "skip" is ok),
+  work at least with the qcow2 file format, work with all kind of host
+  filesystems and users (e.g. "nobody" or "root") and must not take too
+  much memory and disk space (since CI pipelines tend to fail otherwise).
+
+- disabled : Tests in this group are disabled and ignored by check.
+
 .. _docker-ref:
=20
 Docker based tests
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f7a2d3d6c3..09b2ced2f0 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -168,9 +168,7 @@ do
     if $group
     then
         # arg after -g
-        group_list=3D$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[=
0-9][0-9][0-9].* $r /"'{
-s/ .*//p
-}')
+        group_list=3D$(./find_tests.py "$r")
         if [ -z "$group_list" ]
         then
             echo "Group \"$r\" is empty or not defined?"
@@ -193,10 +191,8 @@ s/ .*//p
     then
         # arg after -x
         # Populate $tmp.list with all tests
-        awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.lis=
t 2>/dev/null
-        group_list=3D$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[=
0-9][0-9][0-9].* $r /"'{
-s/ .*//p
-}')
+        ./find_tests.py > $tmp.list 2>/dev/null
+        group_list=3D$(./find_tests.py "$r")
         if [ -z "$group_list" ]
         then
             echo "Group \"$r\" is empty or not defined?"
@@ -486,10 +482,14 @@ testlist options
             fi
             ;;
=20
-        *)
+        [0-9]*)
             start=3D$r
             end=3D$r
             ;;
+        *)
+            echo $r >> $tmp.list
+            xpand=3Dfalse
+            ;;
=20
     esac
=20
@@ -504,7 +504,7 @@ testlist options
 BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",t }' \
         | while read id
         do
-            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/null
+            if (./find_tests.py | grep "$id")
             then
                 # in group file ... OK
                 echo $id >>$tmp.list
@@ -566,7 +566,7 @@ else
         touch $tmp.list
     else
         # no test numbers, do everything from group file
-        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_iote=
sts/group" >$tmp.list
+        find_tests.py > $tmp.list
     fi
 fi
=20
diff --git a/tests/qemu-iotests/find_tests.py b/tests/qemu-iotests/find_tes=
ts.py
new file mode 100755
index 0000000000..5de0615ebc
--- /dev/null
+++ b/tests/qemu-iotests/find_tests.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+
+import os
+import glob
+from collections import defaultdict
+
+
+class TestFinder:
+    def __init__(self):
+        self.groups =3D defaultdict(set)
+        self.all_tests =3D glob.glob('[0-9][0-9][0-9]')
+
+        self.all_tests +=3D [f for f in glob.iglob('test-*')
+                           if not f.endswith('.out')]
+
+        for t in self.all_tests:
+            with open(t) as f:
+                for line in f:
+                    if line.startswith('# group: '):
+                        for g in line.split()[2:]:
+                            self.groups[g].add(t)
+
+    def add_group_file(self, fname):
+        with open(fname) as f:
+            for line in f:
+                line =3D line.strip()
+
+                if (not line) or line[0] =3D=3D '#':
+                    continue
+
+                words =3D line.split()
+                test_file =3D words[0]
+                groups =3D words[1:]
+
+                if test_file not in self.all_tests:
+                    print('Warning: {}: "{}" test is not found. '
+                          'Skip.'.format(fname, test_file))
+                    continue
+
+                for g in groups:
+                    self.groups[g].add(test_file)
+
+    def find_tests(self, group=3DNone):
+        if group is None:
+            tests =3D self.all_tests
+        elif group not in self.groups:
+            tests =3D []
+        elif group !=3D 'disabled' and 'disabled' in self.groups:
+            tests =3D self.groups[group] - self.groups['disabled']
+        else:
+            tests =3D self.groups[group]
+
+        return sorted(tests)
+
+
+if __name__ =3D=3D '__main__':
+    import sys
+
+    if len(sys.argv) > 2:
+        print("Usage ./find_tests.py [group]")
+        sys.exit(1)
+
+    tf =3D TestFinder()
+    if os.path.isfile('group'):
+        tf.add_group_file('group')
+
+    if len(sys.argv) =3D=3D 2:
+        tests =3D tf.find_tests(sys.argv[1])
+    else:
+        tests =3D tf.find_tests()
+
+    print('\n'.join(tests))
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
deleted file mode 100644
index 79c6dfc85d..0000000000
--- a/tests/qemu-iotests/group
+++ /dev/null
@@ -1,298 +0,0 @@
-#
-# QA groups control file
-# Defines test groups
-#
-# Some notes about the groups:
-#
-# - do not start group names with a digit
-#
-# - quick : Tests in this group should finish within some few seconds.
-#
-# - img : Tests in this group can be used to excercise the qemu-img tool.
-#
-# - auto : Tests in this group are used during "make check" and should be
-#   runnable in any case. That means they should run with every QEMU binar=
y
-#   (also non-x86), with every QEMU configuration (i.e. must not fail if
-#   an optional feature is not compiled in - but reporting a "skip" is ok)=
,
-#   work at least with the qcow2 file format, work with all kind of host
-#   filesystems and users (e.g. "nobody" or "root") and must not take too
-#   much memory and disk space (since CI pipelines tend to fail otherwise)=
.
-#
-
-#
-# test-group association ... one line per test
-#
-001 rw auto quick
-002 rw auto quick
-003 rw auto
-004 rw auto quick
-005 img auto quick
-# 006 was removed, do not reuse
-007 snapshot auto
-008 rw auto quick
-009 rw auto quick
-010 rw auto quick
-011 rw auto quick
-012 auto quick
-013 rw auto
-014 rw
-015 rw snapshot
-# 016 was removed, do not reuse
-017 rw backing auto quick
-018 rw backing auto quick
-019 rw backing auto quick
-020 rw backing auto quick
-021 io auto quick
-022 rw snapshot auto
-023 rw
-024 rw backing auto quick
-025 rw auto quick
-026 rw blkdbg
-027 rw auto quick
-028 rw backing quick
-029 rw auto quick
-030 rw auto backing
-031 rw auto quick
-032 rw auto quick
-033 rw auto quick
-034 rw auto backing quick
-035 rw auto quick
-036 rw auto quick
-037 rw auto backing quick
-038 rw auto backing quick
-039 rw auto quick
-040 rw auto
-041 rw auto backing
-042 rw auto quick
-043 rw auto backing
-044 rw
-045 rw quick
-046 rw auto aio quick
-047 rw auto quick
-048 img auto quick
-049 rw auto
-050 rw auto backing quick
-051 rw
-052 rw auto backing quick
-053 rw auto quick
-054 rw auto quick
-055 rw
-056 rw backing
-057 rw
-058 rw quick
-059 rw quick
-060 rw auto quick
-061 rw auto
-062 rw auto quick
-063 rw auto quick
-064 rw quick
-065 rw quick
-066 rw auto quick
-067 rw quick
-068 rw quick
-069 rw auto quick
-070 rw quick
-071 rw auto quick
-072 rw auto quick
-073 rw auto quick
-074 rw auto quick
-075 rw quick
-076 io
-077 rw quick
-078 rw quick
-079 rw auto
-080 rw auto
-081 rw quick
-082 rw quick
-083 rw
-084 img quick
-085 rw
-086 rw auto quick
-087 rw quick
-088 rw quick
-089 rw auto quick
-090 rw auto quick
-091 rw migration
-092 rw quick
-093 throttle
-094 rw quick
-095 rw quick
-096 rw quick
-097 rw auto backing
-098 rw auto backing quick
-099 rw auto quick
-# 100 was removed, do not reuse
-101 rw quick
-102 rw quick
-103 rw auto quick
-104 rw auto
-105 rw auto quick
-106 rw quick
-107 rw auto quick
-108 rw auto quick
-109 rw
-110 rw auto backing quick
-111 rw auto quick
-112 rw
-113 rw quick
-114 rw auto quick
-115 rw
-116 rw quick
-117 rw auto
-118 rw
-119 rw quick
-120 rw auto quick
-121 rw
-122 rw
-123 rw quick
-124 rw backing
-125 rw
-126 rw auto backing
-127 rw auto backing quick
-128 rw quick
-129 rw quick
-130 rw quick
-131 rw quick
-132 rw quick
-133 auto quick
-134 rw auto quick
-135 rw
-136 rw
-137 rw auto
-138 rw auto quick
-139 rw quick
-140 rw auto quick
-141 rw auto quick
-142
-143 auto quick
-144 rw quick
-145 quick
-146 quick
-147 img
-148 rw quick
-149 rw sudo
-150 rw auto quick
-151 rw
-152 rw quick
-153 rw quick
-154 rw auto backing quick
-155 rw
-156 rw auto quick
-157 quick
-158 rw auto quick
-159 rw auto quick
-160 rw quick
-161 rw auto quick
-162 quick
-163 rw
-165 rw quick
-169 rw quick migration
-170 rw auto quick
-171 rw quick
-172 auto
-173 rw
-174 auto
-175 quick
-176 rw auto backing
-177 rw auto quick
-178 img
-179 rw auto quick
-181 rw auto migration
-182 rw quick
-183 rw migration
-184 rw auto quick
-185 rw
-186 rw auto
-187 rw auto
-188 rw quick
-189 rw
-190 rw auto quick
-191 rw auto
-192 rw auto quick
-194 rw migration quick
-195 rw auto quick
-196 rw quick migration
-197 rw quick
-198 rw
-199 rw migration
-200 rw
-201 rw migration
-202 rw quick
-203 rw auto migration
-204 rw quick
-205 rw quick
-206 rw
-207 rw
-208 rw quick
-209 rw quick
-210 rw
-211 rw quick
-212 rw quick
-213 rw quick
-214 rw auto
-215 rw quick
-216 rw quick
-217 rw auto quick
-218 rw quick
-219 rw
-220 rw auto
-221 rw quick
-222 rw quick
-223 rw quick
-224 rw quick
-225 rw quick
-226 auto quick
-227 quick
-228 rw quick
-229 auto quick
-231 quick
-232 quick
-233 quick
-234 quick migration
-235 quick
-236 quick
-237 rw quick
-238 quick
-239 rw quick
-240 quick
-241 rw quick
-242 rw quick
-243 rw quick
-244 rw auto quick
-245 rw
-246 rw quick
-247 rw quick
-248 rw quick
-249 rw auto quick
-250 rw quick
-251 rw auto quick
-252 rw auto backing quick
-253 rw quick
-254 rw backing quick
-255 rw quick
-256 rw auto quick
-257 rw
-258 rw quick
-259 rw auto quick
-260 rw quick
-261 rw
-262 rw quick migration
-263 rw quick
-264 rw
-265 rw auto quick
-266 rw quick
-267 rw auto quick snapshot
-268 rw auto quick
-270 rw backing quick
-272 rw
-273 backing quick
-277 rw quick
-279 rw backing quick
-280 rw migration quick
-281 rw quick
-282 rw img quick
-283 auto quick
-284 rw
-286 rw quick
-288 quick
-289 rw quick
--=20
2.21.0


