Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BECC388F2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE182224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4a9fZ1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE182224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvf7-0004tk-1q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQX-0002im-Cu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQS-00006c-GP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqMp9SIDmS6N1wbREy83KHaWbJw6kbjUjR8MYlYbK2s=;
 b=W4a9fZ1cLpFMaCFIvlQ/DwxbvAnExflbaQQG2ubUEdwNiNlVB61UfxVlVaJnXqvOgPeyfU
 dGKVavgOmxBjRqyF1DkXeHkibL8HGZsCuBPua4f5v2Kt1RqdBDmzfH6W5G4nidjv8tu/Xu
 gexUZoWfYUZBnt6z1UMQkGkSggvWxEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-SkqEj2fJPierEcv282oRsg-1; Tue, 20 Oct 2020 13:27:53 -0400
X-MC-Unique: SkqEj2fJPierEcv282oRsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09D2C64082;
 Tue, 20 Oct 2020 17:27:52 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 026381992D;
 Tue, 20 Oct 2020 17:27:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] python/machine.py: reorder __init__
Date: Tue, 20 Oct 2020 13:27:25 -0400
Message-Id: <20201020172742.1483258-5-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Put the init arg handling all at the top, and mostly in order (deviating
when one is dependent on another), and put what is effectively runtime
state declaration at the bottom.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20201006235817.3280413-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 44 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 3017ec072d..71fe58be05 100644
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


