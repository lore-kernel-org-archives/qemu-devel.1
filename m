Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C805C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DB42084D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qy5dQ+1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DB42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnXh-0005nZ-4S
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSe-0006TD-CR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSc-0007WB-Th
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:52 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com
 ([40.107.20.136]:58816 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSV-00073m-SM; Tue, 21 Apr 2020 03:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Yx1lnBL/l7aKc+oVWt7BMIR//kNAZRsG1HLL35U+kCHSvHpeDOUHIpnNX9elPxE/HaJupBDmf71xDdnJc4k30n+Q7efqcBbp8uwMzAXQX4K1v2JQhhar6JBG35zN5noMkVdMkL9waecISp1PrCcP0NSVdFRI6Rfeore/aVWoAVra5tuAd+GsJYhs3Pz90/LoXzW6KFH5QMvdQ9DugdiAnmBxKeTdrBB2S+SBLvRGaJyFkJlGNWzbgb/EkiKNxR+S5rgQZLE58gfmqAFvx1mq7tXaD1Gz2/LLxDs+DTm8LLNm1cCGNzc1neSEYOkaZjFaKZk1IFEyKIWMFuQjvvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqmcm+6C8aRnE8QN4csrd3KC2TSVAgQSiNqec//Qs5U=;
 b=gpH20xM1hvY3MueGUFkshDd5KcvD83P7y19OVjbaJ4ZRovPJkV189KLltqgMVczztCq+xfPj5bT86nAt1If48vxqsaFrciQ3zSbEj/58hsvLJeJNivactyL8j0L97cWYuExHlOBRbCNv4APhPc1XLF39UhxR35H5UkVZIWEld4tUXTZRN3d75QiVFFJcPMzVH2krsQrtwt4KZpS+4lnADeWSChGVv5s5bn+gtIS0JXovSr6AhJCTnd1qShMh/hOoQ6OqeSKUkw70k0l5YCjr4aSnuqke+8tRV8fk46KK7e7Yhyrl2DjQQXXajhLzSvtDUxJpQy/UrOi8WwswxHpy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqmcm+6C8aRnE8QN4csrd3KC2TSVAgQSiNqec//Qs5U=;
 b=qy5dQ+1FdcGQYZskbaIGGqaU2wyfzthDi3biXUOxyK3gX5GcDN7DWYvk87SzO0X+spWnII9HhzTXojVTmt9UcN1g5IFpQSuFsNcCuxabMkSQ1TE3Wmb0lcL48Tm+M9ob4LwGT7BcagI1Z08F+BtYbBEnc7c1Pc7l2Kz27riLzbQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 07/10] iotests: add testenv.py
Date: Tue, 21 Apr 2020 10:35:58 +0300
Message-Id: <20200421073601.28710-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421073601.28710-1-vsementsov@virtuozzo.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.142) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:40 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cfbd752-3bfa-4577-97e2-08d7e5c6bb5c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53970661ECB5542287D8F4B9C1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(346002)(396003)(376002)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(30864003)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olUFlbDMaswz6QfQnE5JBabFJc1Ze8OcrcW0DshTlSVFEYaXDfP8LHLKFEHPUN6MKxLHGdengKTIFbAkE6xsrCTuJAjmZLkWMWe4x56ZTl67CoBvy2/3TVhiQDnTFigvIdBh+oLGi2BkdZVb3xpYbAjIwrWVcLT4mkuXaJ1sR4P2rLT2UyIbdEJNj/uO8+8bZiHdlyWbzdEgVLG/5k7aJXJDB/fiOeMoTEvVgbZx0x3RKn5qlb4/vkUCaFC1opH1UfV52kOi1byikl3b6/VMI0RXTbydfJauSPplkWod4PuNDKc6E1eJ3y2p1MUZGNP2z8TfnR+fzUrxBFYRIQzsER4cJxB6LkKBbsy9KFKUAMmVTL0BGZErBBNQyEs3DH3T7wBeRXD2VcvgGYlSgzKICcc1nYXSUgnjwUuAOzMFz1IHeq9iHfl8GjSm9R/fL+CTrLydNO7vAzJTdqCE4tRUxt4ohtoqiq/aLVXDLsDrwxC4JB+FqyTB+JldWFhLqVlCLoQ7fzU0Uy0L8ly7wb0v6jqjckue3N/SRMTW80wt2uCn+4CBDizFax8YZWeGUY5/iI87wHe7niHCNcIFJwMnUjXP6rmpKV7zTSbfWAHmtEo=
X-MS-Exchange-AntiSpam-MessageData: t+HmsL8MEJZJZTabImNF+mDd0CaozVdCTTLdAxCAEbu8cJ/BdDwgHwgTmNNvPPeSSLp4wtwIqrOA5Y0TD+uthlbPfQ9VQA6H9FFynAkx3C9xIAflBZe4JbYd8J1/cJ0GiNA0dp2LW7OPVr0OzeAB4A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfbd752-3bfa-4577-97e2-08d7e5c6bb5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:40.8884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6IsrEnlp8Jtr+BU6RQfpgCTyv7U574NSaA8bCjBkG6Y1EdWcCnwR/lCC3JT13yMrR6whFJlDfa1sCgUBKtfSFihBFUVgLFTRJ3FwLtQCgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.136
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

Add TestEnv class, which will handle test environment in a new python
iotests running framework.

Difference with current ./check interface:
- -v (verbose) option dropped, as it is unused

- -xdiff option is dropped, until somebody complains that it is needed
- same for -n option

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

RFC question here:

What about moving to classic double-dash long options (and short
one-dash-one-letter options)?

So, to convert

-qcow2  --> -f qcow2
-misalign  -->  --misalign
etc.

This may be done later, or I can do it in next version, if all agree
that it's good idea.

 tests/qemu-iotests/testenv.py | 332 ++++++++++++++++++++++++++++++++++
 1 file changed, 332 insertions(+)
 create mode 100755 tests/qemu-iotests/testenv.py

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
new file mode 100755
index 0000000000..d1c2d41974
--- /dev/null
+++ b/tests/qemu-iotests/testenv.py
@@ -0,0 +1,332 @@
+#!/usr/bin/env python3
+#
+# Parse command line options to manage test environment variables.
+#
+# Copyright (c) 2020 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import sys
+import tempfile
+from pathlib import Path
+import shutil
+import collections
+import subprocess
+import argparse
+
+
+def get_default_machine(qemu_prog):
+    outp = subprocess.run([qemu_prog, '-machine', 'help'], check=True,
+                          text=True, stdout=subprocess.PIPE).stdout
+
+    machines = outp.split('\n')
+    default_machine = next(m for m in machines if m.endswith(' (default)'))
+    default_machine = default_machine.split(' ', 1)[0]
+
+    alias_suf = ' (alias of {})'.format(default_machine)
+    alias = next((m for m in machines if m.endswith(alias_suf)), None)
+    if alias is not None:
+        default_machine = alias.split(' ', 1)[0]
+
+    return default_machine
+
+
+""" EnvVarDescriptor
+name - variable name in upper case.
+inherit - variable defaults to same variable from os.environ.
+default - default value for the variable. None means absence by default.
+help - description. Unused now, just in-place documentation. May take place in
+       help message at some point.
+"""
+EnvVarDescriptor = collections.namedtuple('EnvVarDescriptor',
+                                          ('name', 'inherit', 'default',
+                                           'help'))
+
+
+class TestEnv:
+    """
+    Manage system environment for running tests
+
+    The following variables are supported/provided. They are represented by
+    lower-cased TestEnv attributes.
+    """
+    env_descriptors = [EnvVarDescriptor(*d) for d in (
+        # name, inherit, default, description
+
+        # Directories
+        ('TEST_DIR', True, os.path.join(os.getcwd(), 'scratch'),
+         'directory for all intermediate test files'),
+        ('SOCK_DIR', True, None, 'directory for unix sockets'),
+        ('SAMPLE_IMG_DIR', True, None, 'TODO: ???'),
+        ('OUTPUT_DIR', False, os.getcwd(), 'TODO: ???'),
+
+        # Binaries
+        ('PYTHON', False, '/usr/bin/python3 -B', 'python3 for bash tests'),
+        ('QEMU_PROG', True, None, 'qemu binary'),
+        ('QEMU_IMG_PROG', True, None, 'qemu-img binary'),
+        ('QEMU_IO_PROG', True, None, 'qemu-io binary'),
+        ('QEMU_NBD_PROG', True, None, 'qemu-nbd binary'),
+        ('SOCKET_SCM_HELPER', False, None, 'socket_scm_helper binary'),
+
+        # Options for binaries
+        # RFC: Interesting, that only IMG and NBD options may be passed by
+        # user, QEMU and IO options are only calculated. Looks inconsistent.
+        ('QEMU_OPTIONS', False, None, 'qemu command line arguments'),
+        ('QEMU_IMG_OPTIONS', True, None, 'qemu command line arguments'),
+        ('QEMU_IO_OPTIONS', False, None, 'qemu command line arguments'),
+        ('QEMU_NBD_OPTIONS', True, None, 'qemu command line arguments'),
+
+        ('IMGOPTS', False, None, 'options to pass to qemu-img create/convert'),
+
+        ('IMGFMT', False, 'raw', 'image format, set by cmdline'),
+        ('IMGPROTO', False, 'file', 'image protocol, set by cmdline'),
+        ('AIOMODE', False, 'threads', 'image protocol, set by cmdline'),
+        ('CACHEMODE', False, 'writeback', 'cache mode, set by cmdline'),
+
+        ('VALGRIND_QEMU', False, None, 'use valgrind, set by cmdline'),
+
+        # Helping variables, not passed by user, only calculated
+        ('CACHEMODE_IS_DEFAULT', False, None,
+         'cache mode was not set by user'),
+        ('IMGFMT_GENERIC', False, None, 'TODO: ???'),
+        ('IMGOPTSSYNTAX', False, None, 'TODO: ???'),
+        ('IMGKEYSECRET', False, None, 'TODO: ???'),
+        ('QEMU_DEFAULT_MACHINE', False, None, 'TODO: ???'),
+    )]
+
+    @staticmethod
+    def create_argparser():
+        p = argparse.ArgumentParser(description="Test environment preparation",
+                                    add_help=False, usage=argparse.SUPPRESS)
+
+        p.add_argument('-d', dest='debug', action='store_true', help='debug')
+        p.add_argument('-misalign', action='store_true',
+                       help='misalign memory allocations')
+
+        format_list = ['raw', 'bochs', 'parallels', 'qcow', 'qcow2', 'qed',
+                       'vdi', 'vpc', 'vhdx', 'vmdk', 'luks', 'dmg']
+        g = p.add_argument_group(
+            'image format options',
+            'The following options sets IMGFMT environment variable. '
+            'At most one chose is allowed, default is "raw"')
+        g = g.add_mutually_exclusive_group()
+        for fmt in format_list:
+            g.add_argument('-' + fmt, dest='imgfmt', action='store_const',
+                           const=fmt)
+
+        protocol_list = ['file', 'rbd', 'sheepdoc', 'nbd', 'ssh', 'nfs',
+                         'vxhs']
+        g = p.add_argument_group(
+            'image protocol options',
+            'The following options sets IMGPROTO environment variably. '
+            'At most one chose is allowed, default is "file"')
+        g = g.add_mutually_exclusive_group()
+        for prt in protocol_list:
+            g.add_argument('-' + prt, dest='imgproto', action='store_const',
+                           const=prt)
+
+        g = p.add_mutually_exclusive_group()
+        g.add_argument('-nocache', dest='cachemode', action='store_const',
+                       const='none', help='set cache mode "none" (O_DIRECT), '
+                       'sets CACHEMODE environment variable')
+        g.add_argument('-c', dest='cachemode',
+                       help='sets CACHEMODE environment variable')
+
+        p.add_argument('-i', dest='aiomode', default='threads',
+                       help='sets AIOMODE environment variable')
+
+        g = p.add_argument_group('bash tests options',
+                                 'The following options are ignored by '
+                                 'python tests. TODO: support them in '
+                                 'iotests.py')
+        g.add_argument('-o', dest='imgopts',
+                       help='options to pass to qemu-img create/convert, sets '
+                       'IMGOPTS environment variable')
+        p.add_argument('-valgrind', dest='VALGRIND_QEMU', action='store_const',
+                       const='y', help='use valgrind, sets VALGRIND_QEMU '
+                       'environment variable')
+
+        return p
+
+    argparser = create_argparser.__func__()
+
+    def __contains__(self, item):
+        return hasattr(self, item)
+
+    def __setitem__(self, key, value):
+        setattr(self, key, value)
+
+    def __getitem__(self, key):
+        return getattr(self, key)
+
+    def setdefault(self, attr, value):
+        if attr not in self:
+            self[attr] = value
+
+    def init_paths(self):
+        self.build_iotests = os.getcwd()
+
+        if os.path.islink(sys.argv[0]):
+            # called from the build tree
+            self.source_iotests = os.path.dirname(os.readlink(sys.argv[0]))
+        else:
+            self.source_iotests = self.build_iotests
+
+        self.build_root = os.path.join(self.build_iotests, '..', '..')
+
+    def init_handle_argv(self, argv):
+        self.args, self.remaining_argv = self.argparser.parse_known_args(argv)
+
+        for k, v in vars(self.args).items():
+            if v is not None:
+                self[k] = v
+
+    def init_handle_env_descriptors(self):
+        for d in self.env_descriptors:
+            if d.name.lower() in self:
+                continue  # set by command line argument
+
+            if d.inherit and d.name in os.environ:
+                self[d.name.lower()] = os.environ[d.name]
+            elif d.default is not None:
+                self[d.name.lower()] = d.default
+
+    def init_find_binaries(self):
+        self.setdefault('qemu_img_prog',
+                        os.path.join(self.build_root, 'qemu-img'))
+        self.setdefault('qemu_io_prog',
+                        os.path.join(self.build_root, 'qemu-io'))
+        self.setdefault('qemu_nbd_prog',
+                        os.path.join(self.build_root, 'qemu-nbd'))
+
+        if 'qemu_prog' not in self:
+            arch = os.uname().machine
+            if 'ppc64' in arch:
+                arch = 'ppc64'
+            self.qemu_prog = os.path.join(self.build_root, arch + '-softmmu',
+                                          'qemu-system-' + arch)
+
+        for b in [self.qemu_img_prog, self.qemu_io_prog, self.qemu_nbd_prog,
+                  self.qemu_prog]:
+            if not os.path.exists(b):
+                exit('Not such file: ' + b)
+            if not os.access(b, os.X_OK):
+                exit('Not executable: ' + b)
+
+        helper_path = os.path.join(self.build_iotests, 'socket_scm_helper')
+        if os.access(helper_path, os.X_OK):
+            self.socket_scm_helper = helper_path
+
+    def __init__(self, argv):
+        """ Parse args and environment """
+
+        self.init_paths()
+        self.init_handle_argv(argv)
+
+        self.cachemode_is_default = 'false' if 'cachemode' in self else 'true'
+
+        self.init_handle_env_descriptors()
+        self.init_find_binaries()
+
+        self.imgfmt_generic = self.imgfmt not in ['bochs', 'cloop', 'dmg']
+        self.imgfmt_generic = 'true' if self.imgfmt_generic else 'false'
+
+        self.qemu_io_options = f'--cache {self.cachemode} --aio {self.aiomode}'
+        if self.misalign:
+            self.qemu_io_options += ' --misalign'
+
+        self.qemu_io_options_no_fmt = self.qemu_io_options
+
+        if self.imgfmt == 'luks':
+            self.imgoptssyntax = 'true'
+            self.imgkeysecret = '123456'
+            if 'imgopts' not in self:
+                self.imgopts = 'iter-time=10'
+            elif 'iter-time=' not in self.imgopts:
+                self.imgopts += ',iter-time=10'
+        else:
+            self.imgoptssyntax = 'false'
+            self.qemu_io_options += ' -f ' + self.imgfmt
+
+        self.qemu_options = '-nodefaults -display none -accel qtest'
+        if self.qemu_prog.endswith(('qemu-system-arm', 'qemu-system-aarch64')):
+            self.qemu_options += ' -machine virt'
+        elif self.qemu_prog.endswith('qemu-system-tricore'):
+            self.qemu_options += ' -machine tricore_testboard'
+
+        self.setdefault('sample_img_dir',
+                        os.path.join(self.source_iotests, 'sample_images'))
+
+        self.qemu_default_machine = get_default_machine(self.qemu_prog)
+
+        self.tmp_sock_dir = False
+        if 'sock_dir' not in self:
+            self.sock_dir = tempfile.mkdtemp()
+            self.tmp_sock_dir = True
+
+        for d in (self.test_dir, self.sock_dir):
+            Path(d).mkdir(parents=True, exist_ok=True)
+
+    def close(self):
+        if self.tmp_sock_dir:
+            shutil.rmtree(self.sock_dir)
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, *args):
+        self.close()
+
+    def get_env(self):
+        env = {}
+        for d in self.env_descriptors:
+            if d.name.lower() in self:
+                env[d.name] = self[d.name.lower()]
+
+        return env
+
+    def print_env(self):
+        template = """\
+QEMU          -- "{QEMU_PROG}" {QEMU_OPTIONS}
+QEMU_IMG      -- "{QEMU_IMG_PROG}" {QEMU_IMG_OPTIONS}
+QEMU_IO       -- "{QEMU_IO_PROG}" {QEMU_IO_OPTIONS}
+QEMU_NBD      -- "{QEMU_NBD_PROG}" {QEMU_NBD_OPTIONS}
+IMGFMT        -- {IMGFMT}{imgopts}
+IMGPROTO      -- {IMGPROTO}
+PLATFORM      -- {platform}
+TEST_DIR      -- {TEST_DIR}
+SOCK_DIR      -- {SOCK_DIR}
+SOCKET_SCM_HELPER -- {SOCKET_SCM_HELPER}"""
+
+        args = collections.defaultdict(str, self.get_env())
+
+        if 'IMGOPTS' in args:
+            args['imgopts'] = ' (' + args['IMGOPTS'] + ')'
+
+        u = os.uname()
+        args['platform'] = f'{u.sysname}/{u.machine} {u.nodename} {u.release}'
+
+        print(template.format_map(args))
+
+
+if __name__ == '__main__':
+    if len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help']:
+        TestEnv.argparser.print_help()
+        exit()
+
+    with TestEnv(sys.argv) as te:
+        te.print_env()
+        print('\nUnhandled options: ', te.remaining_argv)
-- 
2.21.0


