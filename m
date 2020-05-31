Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02962074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeHl9HsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02962074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR4Z-0001ZC-Qt
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzx-0001sh-K4
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzw-0006mJ-CI
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OcgS+8uizQs2BB2jjqHl6ry4DnKvgwh0XUrC24oYQg=;
 b=MeHl9HsJQKSCyXDBtBMb4Xh+LB2x5Z9jkrvWZx/2FX+HEF0v5RlmqMM/s3uO0lOd/X+1ny
 GVI3EMHNKextxy4l5WikNSWVDXyIty6wKJx3YlDa4IqjYO5watSBunqx/brWEa23oAupAE
 OUFEEfYi/kD02mUEWzfJn0jGJGJePyk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-r2IoNabbOGKz6D0bsQpiCg-1; Sun, 31 May 2020 12:39:42 -0400
X-MC-Unique: r2IoNabbOGKz6D0bsQpiCg-1
Received: by mail-wr1-f69.google.com with SMTP id c14so3603547wrm.15
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3OcgS+8uizQs2BB2jjqHl6ry4DnKvgwh0XUrC24oYQg=;
 b=LzBm9OQFSUf4hRdH7RwPLLauhnO1ltgBoNp4Ua5rTIQWuzqbTKTag/pwPScJxvXmBQ
 cHWSXga4x9cd21S8j5vUqorPKfIp72k72G6TKv/mg62BrRPQme5/YkF5o8GcpTWPlTyn
 o/sCENLI91jIygaoF0t0QcnC+EvBJXsfEQKks/A+dI8jyizohb0VHShh5v0/2P3zv5BQ
 E6y4Hpml7gbou44ivB9e31bGO1vdlNBRkn4MgTM0ylNkkas+b+l51auZkBXsUmLUuc3E
 vk3iB+RVozshMhO8nF/QvHFAhTRGW1a0Mmhz+8Zgs7HI0EF7rqZO0jEwBaEfxyA6FU2z
 Euhg==
X-Gm-Message-State: AOAM533kisDSXwAAROgRmHHavXzL0yIityaq4UK3AVTLGlpq4JvZrNAy
 EtxqdWU+/0pQ8kDVBI8lMDL74y4/ADsEDv278ZgheYQjt7DSfGBXcwzamRktfK1QdAEQi+7SrlO
 ZZqxxPX3gzcq/Pyo=
X-Received: by 2002:a1c:230a:: with SMTP id j10mr17544796wmj.124.1590943180768; 
 Sun, 31 May 2020 09:39:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwjt9ib7xJBDUlj2i2d+LbU8yd4lrgg9+eyZSY61K4oGbjGUzzZ/w68ViV2DfDZ4MNSeL8Yw==
X-Received: by 2002:a1c:230a:: with SMTP id j10mr17544774wmj.124.1590943180526; 
 Sun, 31 May 2020 09:39:40 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 23sm8942553wmo.18.2020.05.31.09.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/25] python/qemu: delint and add pylintrc
Date: Sun, 31 May 2020 18:38:31 +0200
Message-Id: <20200531163846.25363-11-philmd@redhat.com>
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
 helo=us-smtp-delivery-1.mimecast.com
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

Bring our these files up to speed with pylint 2.5.0.
Add a pylintrc file to formalize which pylint subset
we are targeting.

The similarity ignore is there to suppress similarity
reports across imports, which for typing constants,
are going to trigger this report erroneously.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200528222129.23826-4-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py |  6 ++---
 python/qemu/pylintrc   | 58 ++++++++++++++++++++++++++++++++++++++++++
 python/qemu/qtest.py   | 42 +++++++++++++++++++-----------
 3 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 python/qemu/pylintrc

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 41554de533..8e4ecd1837 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -58,7 +58,7 @@ def __init__(self, reply):
         self.reply = reply
 
 
-class QEMUMachine(object):
+class QEMUMachine:
     """
     A QEMU VM
 
@@ -239,7 +239,7 @@ def _base_args(self):
                          'chardev=mon,mode=control'])
         if self._machine is not None:
             args.extend(['-machine', self._machine])
-        for i in range(self._console_index):
+        for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
             self._console_address = os.path.join(self._sock_dir,
@@ -374,7 +374,7 @@ def shutdown(self, has_quit=False, hard=False):
                 command = ' '.join(self._qemu_full_args)
             else:
                 command = ''
-            LOG.warning(msg, -exitcode, command)
+            LOG.warning(msg, -int(exitcode), command)
 
         self._launched = False
 
diff --git a/python/qemu/pylintrc b/python/qemu/pylintrc
new file mode 100644
index 0000000000..5d6ae7367d
--- /dev/null
+++ b/python/qemu/pylintrc
@@ -0,0 +1,58 @@
+[MASTER]
+
+[MESSAGES CONTROL]
+
+# Disable the message, report, category or checker with the given id(s). You
+# can either give multiple identifiers separated by comma (,) or put this
+# option multiple times (only on the command line, not in the configuration
+# file where it should appear only once). You can also use "--disable=all" to
+# disable everything first and then reenable specific checks. For example, if
+# you want to run only the similarities checker, you can use "--disable=all
+# --enable=similarities". If you want to run only the classes checker, but have
+# no Warning level messages displayed, use "--disable=all --enable=classes
+# --disable=W".
+disable=too-many-arguments,
+        too-many-instance-attributes,
+        too-many-public-methods,
+
+[REPORTS]
+
+[REFACTORING]
+
+[MISCELLANEOUS]
+
+[LOGGING]
+
+[BASIC]
+
+# Good variable names which should always be accepted, separated by a comma.
+good-names=i,
+           j,
+           k,
+           ex,
+           Run,
+           _,
+           fd,
+
+[VARIABLES]
+
+[STRING]
+
+[SPELLING]
+
+[FORMAT]
+
+[SIMILARITIES]
+
+# Ignore imports when computing similarities.
+ignore-imports=yes
+
+[TYPECHECK]
+
+[CLASSES]
+
+[IMPORTS]
+
+[DESIGN]
+
+[EXCEPTIONS]
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index d24ad04256..53d814c064 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -1,5 +1,11 @@
-# QEMU qtest library
-#
+"""
+QEMU qtest library
+
+qtest offers the QEMUQtestProtocol and QEMUQTestMachine classes, which
+offer a connection to QEMU's qtest protocol socket, and a qtest-enabled
+subclass of QEMUMachine, respectively.
+"""
+
 # Copyright (C) 2015 Red Hat Inc.
 #
 # Authors:
@@ -17,19 +23,21 @@
 from .machine import QEMUMachine
 
 
-class QEMUQtestProtocol(object):
-    def __init__(self, address, server=False):
-        """
-        Create a QEMUQtestProtocol object.
+class QEMUQtestProtocol:
+    """
+    QEMUQtestProtocol implements a connection to a qtest socket.
 
-        @param address: QEMU address, can be either a unix socket path (string)
-                        or a tuple in the form ( address, port ) for a TCP
-                        connection
-        @param server: server mode, listens on the socket (bool)
-        @raise socket.error on socket connection errors
-        @note No connection is established, this is done by the connect() or
-              accept() methods
-        """
+    :param address: QEMU address, can be either a unix socket path (string)
+                    or a tuple in the form ( address, port ) for a TCP
+                    connection
+    :param server: server mode, listens on the socket (bool)
+    :raise socket.error: on socket connection errors
+
+    .. note::
+       No conection is estabalished by __init__(), this is done
+       by the connect() or accept() methods.
+    """
+    def __init__(self, address, server=False):
         self._address = address
         self._sock = self._get_sock()
         self._sockfile = None
@@ -73,15 +81,19 @@ def cmd(self, qtest_cmd):
         return resp
 
     def close(self):
+        """Close this socket."""
         self._sock.close()
         self._sockfile.close()
 
     def settimeout(self, timeout):
+        """Set a timeout, in seconds."""
         self._sock.settimeout(timeout)
 
 
 class QEMUQtestMachine(QEMUMachine):
-    '''A QEMU VM'''
+    """
+    A QEMU VM, with a qtest socket available.
+    """
 
     def __init__(self, binary, args=None, name=None, test_dir="/var/tmp",
                  socket_scm_helper=None, sock_dir=None):
-- 
2.21.3


