Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D8A20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDJyJbpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D8A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlW7-0001Zf-KE
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUa-0007Qt-Gz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUY-0008E9-SR
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDeIb5SRNPn8WgLeXBTh8+TANZemdHM931YQ7Wu79yQ=;
 b=RDJyJbpAA2dpcvN67cNZ4IROJ1+B5lMk8pT6zdH0Z2hWJiGFEsBZf84R8D7C9llEDk/S/l
 bN29pGcueeX2a3/BvDtOgOvdQ1n8Hbuufa9VF4tsZ6N+lMoI6Rw3Rp/AqOhkNs3dOfVD+W
 VFWaVTUoMGjZmC6ks1K1O8Uu3pyHiVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-HpV5whmONlWWumSSCvfSMA-1; Fri, 10 Jul 2020 01:22:32 -0400
X-MC-Unique: HpV5whmONlWWumSSCvfSMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AFC51009440;
 Fri, 10 Jul 2020 05:22:31 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BF8C920C2;
 Fri, 10 Jul 2020 05:22:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/16] python/machine.py: reorder __init__
Date: Fri, 10 Jul 2020 01:22:12 -0400
Message-Id: <20200710052220.3306-9-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Put the init arg handling all at the top, and mostly in order (deviating
when one is dependent on another), and put what is effectively runtime
state declaration at the bottom.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index bab1b1921f..0f7ec095cb 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -87,38 +87,43 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         @param socket_scm_helper: helper program, required for send_fd_scm()
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
-- 
2.21.3


