Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE23C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E722080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGC/kaU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E722080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionln-0000OK-3Q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iomyc-0001vp-NB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iomyb-0006SB-5L
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:24:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43023
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iomyb-0006Rr-1b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LZaehhwnm5cEFqqWuj5gsjbWKlzGOEjtaCN2sNyD9Tg=;
 b=MGC/kaU6f3ZsSVvjWuksw8OrUVXfB6Vq8plUXBDwXSDP+XX9Auyo3ynHrwa+J9pvbO++e2
 w89a6zCrR/lFLVbLM+sILCINudy8TTLIM+DcldceZPsehsbZoFDQKm97KOgs8YyqoreXrf
 TRUh8kgJ2D78fXktMHgSBuvpdU/DFlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-gzegDAJSM76S09SbsCEWGA-1; Tue, 07 Jan 2020 06:24:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787F72EDA
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:24:42 +0000 (UTC)
Received: from localhost (unknown [10.36.118.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED215D9CA;
 Tue,  7 Jan 2020 11:24:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] trace: update qemu-trace-stap to Python 3
Date: Tue,  7 Jan 2020 11:24:38 +0000
Message-Id: <20200107112438.383958-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gzegDAJSM76S09SbsCEWGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Daniel Berrange <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-trace-stap does not support Python 3 yet:

  $ scripts/qemu-trace-stap list path/to/qemu-system-x86_64
  Traceback (most recent call last):
    File "scripts/qemu-trace-stap", line 175, in <module>
      main()
    File "scripts/qemu-trace-stap", line 171, in main
      args.func(args)
    File "scripts/qemu-trace-stap", line 118, in cmd_list
      print_probes(args.verbose, "*")
    File "scripts/qemu-trace-stap", line 114, in print_probes
      if line.startswith(prefix):
  TypeError: startswith first arg must be bytes or a tuple of bytes, not st=
r

Now that QEMU requires Python 3.5 or later we can switch to pure Python
3.  Use Popen()'s universal_newlines=3DTrue argument to treat stdout as
text instead of binary.

Fixes: 62dd1048c0bd ("trace: add ability to do simple printf logging via sy=
stemtap")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1787395
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemu-trace-stap | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qemu-trace-stap b/scripts/qemu-trace-stap
index 91d1051cdc..90527eb974 100755
--- a/scripts/qemu-trace-stap
+++ b/scripts/qemu-trace-stap
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 # -*- python -*-
 #
 # Copyright (C) 2019 Red Hat, Inc
@@ -18,8 +18,6 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
=20
-from __future__ import print_function
-
 import argparse
 import copy
 import os.path
@@ -104,7 +102,9 @@ def cmd_list(args):
         if verbose:
             print("Listing probes with name '%s'" % script)
         proc =3D subprocess.Popen(["stap", "-l", script],
-                                stdout=3Dsubprocess.PIPE, env=3Dtapset_env=
(tapsets))
+                                stdout=3Dsubprocess.PIPE,
+                                universal_newlines=3DTrue,
+                                env=3Dtapset_env(tapsets))
         out, err =3D proc.communicate()
         if proc.returncode !=3D 0:
             print("No probes found, are the tapsets installed in %s" % tap=
set_dir(args.binary))
--=20
2.24.1


