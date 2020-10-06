Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104BC3279D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AC1212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9QO+1qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AC1212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPwt1-0001Dr-Fz
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqm-0007mj-5p
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwqg-0002IB-CQ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13f7ZcwyL2HoUTVislrZE9zDCzpag0gsSKlPXvDs438=;
 b=f9QO+1qPp1ig6ZdFGg2PdQ6YHZbyeC/6mTdR38Ju8EENkS+smLv8D4aajT8STEq8E2WULb
 KEDLzt8C9TZN31WNglQtDoQphHRyOnXg8KaJ/nLONcP8VtoC1A2m4Kov3mWg4wRJF/r9oc
 oeT0MUm6Z21+aCMdHHqDQNa7ya70huE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-sNm8QWVuMRasK3lIABCKYw-1; Tue, 06 Oct 2020 19:58:23 -0400
X-MC-Unique: sNm8QWVuMRasK3lIABCKYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A4C11084D64;
 Tue,  6 Oct 2020 23:58:22 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D80160BFA;
 Tue,  6 Oct 2020 23:58:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/20] python/machine.py: reorder __init__
Date: Tue,  6 Oct 2020 19:58:00 -0400
Message-Id: <20201006235817.3280413-4-jsnow@redhat.com>
In-Reply-To: <20201006235817.3280413-1-jsnow@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Put the init arg handling all at the top, and mostly in order (deviating
when one is dependent on another), and put what is effectively runtime
state declaration at the bottom.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 3017ec072df..71fe58be050 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -84,42 +84,54 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()
         @param sock_dir: where to create socket (overrides test_dir for sock)
-        @param console_log: (optional) path to console log file
         @param drain_console: (optional) True to drain console socket to buffer
+        @param console_log: (optional) path to console log file
         @note: Qemu process is not started until launch() is used.
         '''
+        # Direct user configuration
+
+        self._binary = binary
+
         if args is None:
             args = []
+        # Copy mutable input: we will be modifying our copy
+        self._args = list(args)
+
         if wrapper is None:
             wrapper = []
-        if name is None:
-            name = "qemu-%d" % os.getpid()
-        if sock_dir is None:
-            sock_dir = test_dir
-        self._name = name
+        self._wrapper = wrapper
+
+        self._name = name or "qemu-%d" % os.getpid()
+        self._test_dir = test_dir
+        self._sock_dir = sock_dir or self._test_dir
+        self._socket_scm_helper = socket_scm_helper
+
         if monitor_address is not None:
             self._monitor_address = monitor_address
             self._remove_monitor_sockfile = False
         else:
             self._monitor_address = os.path.join(
-                sock_dir, f"{name}-monitor.sock"
+                self._sock_dir, f"{self._name}-monitor.sock"
             )
             self._remove_monitor_sockfile = True
+
+        self._console_log_path = console_log
+        if self._console_log_path:
+            # In order to log the console, buffering needs to be enabled.
+            self._drain_console = True
+        else:
+            self._drain_console = drain_console
+
+        # Runstate
         self._qemu_log_path = None
         self._qemu_log_file = None
         self._popen = None
-        self._binary = binary
-        self._args = list(args)     # Force copy args in case we modify them
-        self._wrapper = wrapper
         self._events = []
         self._iolog = None
-        self._socket_scm_helper = socket_scm_helper
         self._qmp_set = True   # Enable QMP monitor by default.
         self._qmp = None
         self._qemu_full_args = None
-        self._test_dir = test_dir
         self._temp_dir = None
-        self._sock_dir = sock_dir
         self._launched = False
         self._machine = None
         self._console_index = 0
@@ -129,12 +141,6 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._console_socket = None
         self._remove_files = []
         self._user_killed = False
-        self._console_log_path = console_log
-        if self._console_log_path:
-            # In order to log the console, buffering needs to be enabled.
-            self._drain_console = True
-        else:
-            self._drain_console = drain_console
 
     def __enter__(self):
         return self
-- 
2.26.2


