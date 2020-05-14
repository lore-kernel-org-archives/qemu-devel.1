Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BFFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5421A205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+uVGgvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5421A205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6tA-0006XT-Em
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6p2-0004Z9-QQ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48472
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6p2-0001b3-0Y
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eIVREeXd6nvTZkOSZ5iRHZDJSFp7tIw6PyIaTwCOjGQ=;
 b=P+uVGgvcgQRG7udCDuGzc3gJUhF24JVM5tzTnJ6Pscfs43mtzo3eJDT2y/vICbl2Z8uV1l
 r6s8gWTjxd80CdZ5WmJ8nlS8PXHJg2/VvMh0qPKxb557i3yIm0dgvuS1/nAdMMdID0KiNb
 xI05HwwknNItJs/TuTcmvetnBUESZy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-aBVQFwdkNA2zDIkkVPt0qA-1; Thu, 14 May 2020 01:54:15 -0400
X-MC-Unique: aBVQFwdkNA2zDIkkVPt0qA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEC341054F8F;
 Thu, 14 May 2020 05:54:13 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85D067D952;
 Thu, 14 May 2020 05:54:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 05/32] python/qemu/lib: delint; add flake8 config
Date: Thu, 14 May 2020 01:53:36 -0400
Message-Id: <20200514055403.18902-6-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mostly, ignore the "no bare except" rule, because flake8 is not
contextual and cannot determine if we re-raise. Pylint can, though, so
always prefer pylint for that.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/.flake8    |  2 ++
 python/qemu/lib/accel.py   |  9 ++++++---
 python/qemu/lib/machine.py | 13 +++++++++----
 python/qemu/lib/qmp.py     |  4 ++--
 4 files changed, 19 insertions(+), 9 deletions(-)
 create mode 100644 python/qemu/lib/.flake8

diff --git a/python/qemu/lib/.flake8 b/python/qemu/lib/.flake8
new file mode 100644
index 0000000000..45d8146f3f
--- /dev/null
+++ b/python/qemu/lib/.flake8
@@ -0,0 +1,2 @@
+[flake8]
+extend-ignore = E722  # Pylint handles this, but smarter.
\ No newline at end of file
diff --git a/python/qemu/lib/accel.py b/python/qemu/lib/accel.py
index 36ae85791e..7fabe62920 100644
--- a/python/qemu/lib/accel.py
+++ b/python/qemu/lib/accel.py
@@ -23,11 +23,12 @@
 # Mapping host architecture to any additional architectures it can
 # support which often includes its 32 bit cousin.
 ADDITIONAL_ARCHES = {
-    "x86_64" : "i386",
-    "aarch64" : "armhf",
-    "ppc64le" : "ppc64",
+    "x86_64": "i386",
+    "aarch64": "armhf",
+    "ppc64le": "ppc64",
 }
 
+
 def list_accel(qemu_bin):
     """
     List accelerators enabled in the QEMU binary.
@@ -47,6 +48,7 @@ def list_accel(qemu_bin):
     # Skip the first line which is the header.
     return [acc.strip() for acc in out.splitlines()[1:]]
 
+
 def kvm_available(target_arch=None, qemu_bin=None):
     """
     Check if KVM is available using the following heuristic:
@@ -69,6 +71,7 @@ def kvm_available(target_arch=None, qemu_bin=None):
         return False
     return True
 
+
 def tcg_available(qemu_bin):
     """
     Check if TCG is available.
diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index c79fc8fb89..4b260fa2cb 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -29,6 +29,7 @@
 
 LOG = logging.getLogger(__name__)
 
+
 class QEMUMachineError(Exception):
     """
     Exception called when an error in QEMUMachine happens.
@@ -62,7 +63,8 @@ class QEMUMachine:
     """
     A QEMU VM
 
-    Use this object as a context manager to ensure the QEMU process terminates::
+    Use this object as a context manager to ensure
+    the QEMU process terminates::
 
         with VM(binary) as vm:
             ...
@@ -188,8 +190,10 @@ def send_fd_scm(self, fd=None, file_path=None):
             fd_param.append(str(fd))
 
         devnull = open(os.path.devnull, 'rb')
-        proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
-                                stderr=subprocess.STDOUT, close_fds=False)
+        proc = subprocess.Popen(
+            fd_param, stdin=devnull, stdout=subprocess.PIPE,
+            stderr=subprocess.STDOUT, close_fds=False
+        )
         output = proc.communicate()[0]
         if output:
             LOG.debug(output)
@@ -491,7 +495,8 @@ def event_wait(self, name, timeout=60.0, match=None):
 
     def events_wait(self, events, timeout=60.0):
         """
-        events_wait waits for and returns a named event from QMP with a timeout.
+        events_wait waits for and returns a named event
+        from QMP with a timeout.
 
         events: a sequence of (name, match_criteria) tuples.
                 The match criteria are optional and may be None.
diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
index d6c9b2f4b1..6ae7693965 100644
--- a/python/qemu/lib/qmp.py
+++ b/python/qemu/lib/qmp.py
@@ -168,8 +168,8 @@ def accept(self, timeout=15.0):
 
         @param timeout: timeout in seconds (nonnegative float number, or
                         None). The value passed will set the behavior of the
-                        underneath QMP socket as described in [1]. Default value
-                        is set to 15.0.
+                        underneath QMP socket as described in [1].
+                        Default value is set to 15.0.
         @return QMP greeting dict
         @raise OSError on socket connection errors
         @raise QMPConnectError if the greeting is not received
-- 
2.21.1


