Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D468EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4132074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuselYMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4132074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR2W-0006Fj-Px
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzj-0001RX-3L
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30088
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzi-0006kF-2v
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZt0ZLdOqej/uZqX1RjbopdK4bZJfrI0RxnWBLQtXiE=;
 b=OuselYMm46O+4dmTF2bjf/vy4WChrV8meRbbv/5O/5Y70H/0e6L3CvmUwCNQ2vM0VH4YH3
 3PEW++eYcXE5vt/FDtJBlMgx4JKKnLvWcANY+zcoP9oetsS/emXNPenmaYbY5WypdUQPR2
 oXex4YM1d3gs+bFyKrFFJz5XqwOTbwo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-wVKKWPf1Mw28g6SYqmprDg-1; Sun, 31 May 2020 12:39:27 -0400
X-MC-Unique: wVKKWPf1Mw28g6SYqmprDg-1
Received: by mail-wr1-f71.google.com with SMTP id d6so3623144wrn.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VZt0ZLdOqej/uZqX1RjbopdK4bZJfrI0RxnWBLQtXiE=;
 b=dPCHXuGh7/X7FBzrXGW9eRq5VyAILIPLAir6veHeWDyineR9aIZ0agqG/MEGereHTL
 VdsTIXg5kmy/OFdDltATApvtPDla+jyj297ACZLiKo4tzeIzpCdh3B0ZCWwXWzGj83FR
 cbhYIMRYY515N/DJMi498N0vy4RY81kaqKyqL71Hd96N9DgJK9NbKg65L61Ty7MVWtj3
 EymcW1IGNfTTqk/dxkM3R+hKfQSsl+LRopKmU4Ebva0xJu4Xxsej8m1pAJkpuaUeUlKV
 TuN/SRUM1Q71+gxzwT+N71ZV8csoB7xLjIJ8VbdYxPVY+/Y3hRts5Q58Oa8sUxK3ECU6
 0AIQ==
X-Gm-Message-State: AOAM532GoEol1Xe/xkF2Hq+biaqcsfQthRxlqwyFcXYUyatZNYMs6ehH
 digbIbj5+epwToDphlAcpw+oWNqoNE+TAnc+0bnah5VcXJWCM0AP9GL/TLI2vhqcfNDcptfsgMq
 9HgECwLdReNuF2PY=
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr17434900wmj.164.1590943165706; 
 Sun, 31 May 2020 09:39:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIDhiif77BD+2zEWATjb7OO4Dc+CJOan/ZMSwN3fOg17GLcrYigbcO8xtgQZm9pifBoM5w8w==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr17434886wmj.164.1590943165498; 
 Sun, 31 May 2020 09:39:25 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d18sm17660706wrn.34.2020.05.31.09.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/25] python: remove more instances of sys.version_info
Date: Sun, 31 May 2020 18:38:28 +0200
Message-Id: <20200531163846.25363-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

We guarantee 3.5+ everywhere; remove more dead checks. In general, try
to avoid using version checks and instead prefer to attempt behavior
when possible.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514035230.25756-1-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/analyze-migration.py             |  5 -----
 scripts/decodetree.py                    | 25 +++++++++---------------
 scripts/qmp/qmp-shell                    |  3 ---
 tests/docker/docker.py                   |  5 +++--
 tests/qemu-iotests/nbd-fault-injector.py |  5 +----
 5 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 96a31d3974..95838cbff3 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -25,11 +25,6 @@
 import sys
 
 
-MIN_PYTHON = (3, 2)
-if sys.version_info < MIN_PYTHON:
-    sys.exit("Python %s.%s or later is required.\n" % MIN_PYTHON)
-
-
 def mkdir_p(path):
     try:
         os.makedirs(path)
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 46ab917807..f9d204aa36 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -75,13 +75,6 @@ def output(*args):
         output_fd.write(a)
 
 
-if sys.version_info >= (3, 4):
-    re_fullmatch = re.fullmatch
-else:
-    def re_fullmatch(pat, str):
-        return re.match('^' + pat + '$', str)
-
-
 def output_autogen():
     output('/* This file is autogenerated by scripts/decodetree.py.  */\n\n')
 
@@ -428,18 +421,18 @@ def parse_field(lineno, name, toks):
     width = 0
     func = None
     for t in toks:
-        if re_fullmatch('!function=' + re_ident, t):
+        if re.fullmatch('!function=' + re_ident, t):
             if func:
                 error(lineno, 'duplicate function')
             func = t.split('=')
             func = func[1]
             continue
 
-        if re_fullmatch('[0-9]+:s[0-9]+', t):
+        if re.fullmatch('[0-9]+:s[0-9]+', t):
             # Signed field extract
             subtoks = t.split(':s')
             sign = True
-        elif re_fullmatch('[0-9]+:[0-9]+', t):
+        elif re.fullmatch('[0-9]+:[0-9]+', t):
             # Unsigned field extract
             subtoks = t.split(':')
             sign = False
@@ -488,11 +481,11 @@ def parse_arguments(lineno, name, toks):
     flds = []
     extern = False
     for t in toks:
-        if re_fullmatch('!extern', t):
+        if re.fullmatch('!extern', t):
             extern = True
             anyextern = True
             continue
-        if not re_fullmatch(re_ident, t):
+        if not re.fullmatch(re_ident, t):
             error(lineno, 'invalid argument set token "{0}"'.format(t))
         if t in flds:
             error(lineno, 'duplicate argument "{0}"'.format(t))
@@ -621,13 +614,13 @@ def parse_generic(lineno, is_format, name, toks):
             continue
 
         # 'Foo=%Bar' imports a field with a different name.
-        if re_fullmatch(re_ident + '=%' + re_ident, t):
+        if re.fullmatch(re_ident + '=%' + re_ident, t):
             (fname, iname) = t.split('=%')
             flds = add_field_byname(lineno, flds, fname, iname)
             continue
 
         # 'Foo=number' sets an argument field to a constant value
-        if re_fullmatch(re_ident + '=[+-]?[0-9]+', t):
+        if re.fullmatch(re_ident + '=[+-]?[0-9]+', t):
             (fname, value) = t.split('=')
             value = int(value)
             flds = add_field(lineno, flds, fname, ConstField(value))
@@ -635,7 +628,7 @@ def parse_generic(lineno, is_format, name, toks):
 
         # Pattern of 0s, 1s, dots and dashes indicate required zeros,
         # required ones, or dont-cares.
-        if re_fullmatch('[01.-]+', t):
+        if re.fullmatch('[01.-]+', t):
             shift = len(t)
             fms = t.replace('0', '1')
             fms = fms.replace('.', '0')
@@ -652,7 +645,7 @@ def parse_generic(lineno, is_format, name, toks):
             fixedmask = (fixedmask << shift) | fms
             undefmask = (undefmask << shift) | ubm
         # Otherwise, fieldname:fieldwidth
-        elif re_fullmatch(re_ident + ':s?[0-9]+', t):
+        elif re.fullmatch(re_ident + ':s?[0-9]+', t):
             (fname, flen) = t.split(':')
             sign = False
             if flen[0] == 's':
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index a01d31de1e..c5eef06f3f 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -77,9 +77,6 @@ import re
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qmp
 
-if sys.version_info[0] == 2:
-    input = raw_input
-
 class QMPCompleter(list):
     def complete(self, text, state):
         for cmd in self:
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d8268c1111..5a9735db78 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -258,12 +258,13 @@ def _kill_instances(self, *args, **kwargs):
         return self._do_kill_instances(True)
 
     def _output(self, cmd, **kwargs):
-        if sys.version_info[1] >= 6:
+        try:
             return subprocess.check_output(self._command + cmd,
                                            stderr=subprocess.STDOUT,
                                            encoding='utf-8',
                                            **kwargs)
-        else:
+        except TypeError:
+            # 'encoding' argument was added in 3.6+
             return subprocess.check_output(self._command + cmd,
                                            stderr=subprocess.STDOUT,
                                            **kwargs).decode('utf-8')
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index 588d62aebf..78f42c4214 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -47,10 +47,7 @@
 import socket
 import struct
 import collections
-if sys.version_info.major >= 3:
-    import configparser
-else:
-    import ConfigParser as configparser
+import configparser
 
 FAKE_DISK_SIZE = 8 * 1024 * 1024 * 1024 # 8 GB
 
-- 
2.21.3


