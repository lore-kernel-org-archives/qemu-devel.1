Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30075C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4FA2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfa+YdU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4FA2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRD8-0005g4-68
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR03-000285-NA
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR01-0006n1-LA
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0yaQrYBR9fbxjrwWSMaG0y1Z8dADDvU+WXrcZtsKyw=;
 b=Rfa+YdU7VgKsc6jqlmQyTVsi0IgDH1M3+PfRO+gNcBq5DY6EQ2do5O4cpjq6ux/HJpq61n
 gi4zSm0PAa+5S4Aj7tLsQWsiOq7NBZd/YKy0QWSFY+cTkPzrzx+1z2Kw3jxzuvUs45s49z
 ityc5Ne/f79MI/YqHU+sBW7nhXWetkk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-LdHOXZacPJW4xnd6EeiDZw-1; Sun, 31 May 2020 12:39:47 -0400
X-MC-Unique: LdHOXZacPJW4xnd6EeiDZw-1
Received: by mail-wm1-f71.google.com with SMTP id p24so1919297wmc.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T0yaQrYBR9fbxjrwWSMaG0y1Z8dADDvU+WXrcZtsKyw=;
 b=KWEC3wCsaPmsNBGCGq7ogBNDETZs/VbLXmI/Be2XU1YvGsBRBKIR453ohW/5UGOn/8
 WnrIJNkRC0hOaxY23FwNeKDc8xQMhBJDLC6VmIM45R6iOdxrRxstrnMm7KOrRWVfZr4y
 uakcAk0Yfux67wyfC51QTbRVuawQr5BeZ2S+joZFZFiN0ck7cDo0QxdAEnj00KClAQxM
 ND3FpYZcewSNR4mcobSrdXvf6ZcM7c1ZcONoPve6D6IrcpPEF3QVotDa6aFDyepJhDSD
 hGhTinnnloEWUb2HUZPUCUXM8674Wh7ZRP1YqmKlBnXcLxYllp0/PiUZ+PDui6vjYb4W
 Snqg==
X-Gm-Message-State: AOAM533Ff9WU2qKkf0NmxttpdKCZPSyB+Jkk0hhaoG2xjxZF/vE0lzS2
 o5y0HZVtUCv+1GBWQXbcqn+zhAsgCWndNNQ+Y/m7QYLNNwHxf0CXxlmawE5Y6CHjOvelBdCCu7G
 vQz2Apr7HeeLP4go=
X-Received: by 2002:adf:e692:: with SMTP id r18mr17215587wrm.192.1590943186010; 
 Sun, 31 May 2020 09:39:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyzme/eJkzFKriVfDnwFDZTFh5KmHq5g1d6NkwyrSeOmFMs12wVIIfxqx+l/LdP8rud9JxpA==
X-Received: by 2002:adf:e692:: with SMTP id r18mr17215570wrm.192.1590943185775; 
 Sun, 31 May 2020 09:39:45 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h15sm17067658wrt.73.2020.05.31.09.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/25] python/qemu: delint; add flake8 config
Date: Sun, 31 May 2020 18:38:32 +0200
Message-Id: <20200531163846.25363-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Mostly, ignore the "no bare except" rule, because flake8 is not
contextual and cannot determine if we re-raise. Pylint can, though, so
always prefer pylint for that.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200528222129.23826-5-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/.flake8    |  2 ++
 python/qemu/accel.py   |  9 ++++++---
 python/qemu/machine.py | 13 +++++++++----
 python/qemu/qmp.py     |  4 ++--
 4 files changed, 19 insertions(+), 9 deletions(-)
 create mode 100644 python/qemu/.flake8

diff --git a/python/qemu/.flake8 b/python/qemu/.flake8
new file mode 100644
index 0000000000..45d8146f3f
--- /dev/null
+++ b/python/qemu/.flake8
@@ -0,0 +1,2 @@
+[flake8]
+extend-ignore = E722  # Pylint handles this, but smarter.
\ No newline at end of file
diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 36ae85791e..7fabe62920 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
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
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 8e4ecd1837..187790ce9e 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
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
@@ -185,8 +187,10 @@ def send_fd_scm(self, fd=None, file_path=None):
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
@@ -485,7 +489,8 @@ def event_wait(self, name, timeout=60.0, match=None):
 
     def events_wait(self, events, timeout=60.0):
         """
-        events_wait waits for and returns a named event from QMP with a timeout.
+        events_wait waits for and returns a named event
+        from QMP with a timeout.
 
         events: a sequence of (name, match_criteria) tuples.
                 The match criteria are optional and may be None.
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index d6c9b2f4b1..6ae7693965 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
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
2.21.3


