Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB1BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BDE2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7FBjsEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BDE2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR86-0006aG-PM
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzd-0001FN-3Q
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31789
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzc-0006hx-5Y
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zavZXRcfF4vEsC1fffibsH2BOyGQjn9n39JGbmxfN4M=;
 b=J7FBjsEuqJGCNiVywnTludXQmhNW49CgPNNcddc/wtlJWm9AtqWnskaCqyumA4nXNE6F7j
 Ktco+NaVBjzvsySaizILI+z6JUqrb9f9mf4zoGnO0UQB1rk6ts4WC3AtV7CDWlGL+qhBbs
 dHJQlu01YEaH1jKschnFPIgjukziDbc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-4Bd8vHAHNOO04F7Sv0LS-w-1; Sun, 31 May 2020 12:39:22 -0400
X-MC-Unique: 4Bd8vHAHNOO04F7Sv0LS-w-1
Received: by mail-wr1-f71.google.com with SMTP id w16so3601491wru.18
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zavZXRcfF4vEsC1fffibsH2BOyGQjn9n39JGbmxfN4M=;
 b=ZHYc1YLasMRZh9tx3fTkuKtzdMvUH3SDRe6d8x8FDdbMYWjK7OimwXIkdlhkXUuvPS
 RHc1bOP5nKI35i+DOw+aaqTPxVN8teRdW531qymB0VnsCHGz/Ce5u4CyRSApXMcZSem/
 YmsS4IU4N5OVkcayzHwRUTbIdZakOJRFFaYH3ykdiEfrQ050zNPifT1U+78Z0hh/76C+
 xgor/LcfMfvd6kMn1taOr44WcKt5hAyAFiwzbpwlI3q9Ula8V551iLECronbnbDDzpaE
 iv2hu11DoFBjmM9SrAOI/tJsyVs5aRlXXUfDRn7YwJZpcjQCeVuLKUh/7k32fZG5Ur9v
 7XWw==
X-Gm-Message-State: AOAM5313IShS5qBgx46HPFtyM218Vs3MRiMrWnxBN8ILEj6iZ9r+eC7D
 GL0PitL6ySvK21qCQESguSLo3B5AGJyuzXwtPMuaqFBApXQoZh6cQon/XYfhQ7IT9CN8yNDxbp0
 ztWv7IeqvjYvZdpA=
X-Received: by 2002:a05:600c:4410:: with SMTP id
 u16mr17583861wmn.88.1590943160624; 
 Sun, 31 May 2020 09:39:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxly3Ew6xb8Z2VBdFKMDEhwnRILeq2GKU98Tl7lrJZyURsFrFEvr8EmgNXNr/Rk3c8TXuUC7w==
X-Received: by 2002:a05:600c:4410:: with SMTP id
 u16mr17583850wmn.88.1590943160429; 
 Sun, 31 May 2020 09:39:20 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id w10sm18093502wrp.16.2020.05.31.09.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/25] scripts/qmp: Fix shebang and imports
Date: Sun, 31 May 2020 18:38:27 +0200
Message-Id: <20200531163846.25363-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

There's more wrong with these scripts; They are in various stages of
disrepair. That's beyond the scope of this current patchset.

This just mechanically corrects the imports and the shebangs, as part of
ensuring that the python/qemu/lib refactoring didn't break anything
needlessly.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20200528222129.23826-2-jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/qmp/qmp      | 4 +++-
 scripts/qmp/qom-fuse | 4 +++-
 scripts/qmp/qom-get  | 4 +++-
 scripts/qmp/qom-list | 4 +++-
 scripts/qmp/qom-set  | 4 +++-
 scripts/qmp/qom-tree | 4 +++-
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 0625fc2aba..8e52e4a54d 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -11,7 +11,9 @@
 # See the COPYING file in the top-level directory.
 
 import sys, os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 def print_response(rsp, prefix=[]):
     if type(rsp) == list:
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 6bada2c33d..5fa6b3bf64 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -15,7 +15,9 @@ import fuse, stat
 from fuse import Fuse
 import os, posix
 from errno import *
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 fuse.fuse_python_api = (0, 2)
 
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 7c5ede91bb..666df71832 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -13,7 +13,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index bb68fd65d4..5074fd939f 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -13,7 +13,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 19881d85e9..240a78187f 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -13,7 +13,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index fa91147a03..25b0781323 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -15,7 +15,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
-- 
2.21.3


