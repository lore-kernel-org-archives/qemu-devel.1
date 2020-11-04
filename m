Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A4EC4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE1E22409
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUIMzYRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1E22409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7ZZ-00059a-Ll
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nv-0007MT-E5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nn-0004wz-Ni
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLH3MBije1XSDJtFct1JQ4vpdKKI3TcUrJV5Rs/2+1g=;
 b=iUIMzYRwN3xmfH2eo4sjnAlCEy1oAfh5OvlDQDdYsIUqx31lNqLVHcoiz7jPeW9dGxyEpi
 tYUCoE+8FvOQh7bYqQwxrEB7C+YzuZkvS8rxlWP5OuGsKImvGKyhBQpV7UKSzCG8ZTBMXv
 BNYGh+Gdr2+wpS0PhWqghkVXxXbrzw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-8INIGRaCM962WlzJLTuEVA-1; Tue, 03 Nov 2020 19:37:23 -0500
X-MC-Unique: 8INIGRaCM962WlzJLTuEVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FB231891E87
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:22 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D123655766;
 Wed,  4 Nov 2020 00:37:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 57/72] scripts/qmp-shell: add mypy types
Date: Tue,  3 Nov 2020 19:35:47 -0500
Message-Id: <20201104003602.1293560-58-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As per my usual, this patch is annotations only. Any changes with side
effects are done elsewhere.

Note: pylint does not understand the subscripts for Collection in Python 3.6,
so use the stronger Sequence type as a workaround.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 67 ++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 670361322c51..2d0e85b5f723 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -72,10 +72,18 @@ import os
 import re
 import readline
 import sys
+from typing import (
+    Iterator,
+    List,
+    NoReturn,
+    Optional,
+    Sequence,
+)
 
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qmp
+from qemu.qmp import QMPMessage
 
 
 class QMPCompleter:
@@ -122,25 +130,26 @@ class FuzzyJSON(ast.NodeTransformer):
 # TODO: QMPShell's interface is a bit ugly (eg. _fill_completion() and
 #       _execute_cmd()). Let's design a better one.
 class QMPShell(qmp.QEMUMonitorProtocol):
-    def __init__(self, address, pretty=False, verbose=False):
+    def __init__(self, address: str, pretty: bool = False,
+                 verbose: bool = False):
         super().__init__(self.parse_address(address))
-        self._greeting = None
+        self._greeting: Optional[QMPMessage] = None
         self._completer = QMPCompleter()
         self._pretty = pretty
         self._transmode = False
-        self._actions = list()
+        self._actions: List[QMPMessage] = []
         self._histfile = os.path.join(os.path.expanduser('~'),
                                       '.qmp-shell_history')
         self.verbose = verbose
 
-    def _fill_completion(self):
+    def _fill_completion(self) -> None:
         cmds = self.cmd('query-commands')
         if 'error' in cmds:
             return
         for cmd in cmds['return']:
             self._completer.append(cmd['name'])
 
-    def __completer_setup(self):
+    def __completer_setup(self) -> None:
         self._completer = QMPCompleter()
         self._fill_completion()
         readline.set_history_length(1024)
@@ -157,14 +166,14 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             print(f"Failed to read history '{self._histfile}': {err!s}")
         atexit.register(self.__save_history)
 
-    def __save_history(self):
+    def __save_history(self) -> None:
         try:
             readline.write_history_file(self._histfile)
         except IOError as err:
             print(f"Failed to save history file '{self._histfile}': {err!s}")
 
     @classmethod
-    def __parse_value(cls, val):
+    def __parse_value(cls, val: str) -> object:
         try:
             return int(val)
         except ValueError:
@@ -189,7 +198,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 pass
         return val
 
-    def __cli_expr(self, tokens, parent):
+    def __cli_expr(self,
+                   tokens: Sequence[str],
+                   parent: qmp.QMPObject) -> None:
         for arg in tokens:
             (key, sep, val) = arg.partition('=')
             if sep != '=':
@@ -215,7 +226,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 raise QMPShellError(f'Cannot set "{key}" multiple times')
             parent[optpath[-1]] = value
 
-    def __build_cmd(self, cmdline):
+    def __build_cmd(self, cmdline: str) -> Optional[QMPMessage]:
         """
         Build a QMP input object from a user provided command-line in the
         following format:
@@ -224,6 +235,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         """
         argument_regex = r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+'''
         cmdargs = re.findall(argument_regex, cmdline)
+        qmpcmd: QMPMessage
 
         # Transactional CLI entry/exit:
         if cmdargs[0] == 'transaction(':
@@ -261,14 +273,14 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self.__cli_expr(cmdargs[1:], qmpcmd['arguments'])
         return qmpcmd
 
-    def _print(self, qmp_message):
+    def _print(self, qmp_message: object) -> None:
         indent = None
         if self._pretty:
             indent = 4
         jsobj = json.dumps(qmp_message, indent=indent, sort_keys=self._pretty)
         print(str(jsobj))
 
-    def _execute_cmd(self, cmdline):
+    def _execute_cmd(self, cmdline: str) -> bool:
         try:
             qmpcmd = self.__build_cmd(cmdline)
         except Exception as err:
@@ -288,11 +300,12 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self._print(resp)
         return True
 
-    def connect(self, negotiate: bool = True):
+    def connect(self, negotiate: bool = True) -> None:
         self._greeting = super().connect(negotiate)
         self.__completer_setup()
 
-    def show_banner(self, msg='Welcome to the QMP low-level shell!'):
+    def show_banner(self,
+                    msg: str = 'Welcome to the QMP low-level shell!') -> None:
         print(msg)
         if not self._greeting:
             print('Connected')
@@ -301,12 +314,12 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         print("Connected to QEMU {major}.{minor}.{micro}\n".format(**version))
 
     @property
-    def prompt(self):
+    def prompt(self) -> str:
         if self._transmode:
             return 'TRANS> '
         return '(QEMU) '
 
-    def read_exec_command(self):
+    def read_exec_command(self) -> bool:
         """
         Read and execute a command.
 
@@ -326,7 +339,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
         return self._execute_cmd(cmdline)
 
-    def repl(self):
+    def repl(self) -> Iterator[None]:
         self.show_banner()
         while self.read_exec_command():
             yield
@@ -334,11 +347,12 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
 
 class HMPShell(QMPShell):
-    def __init__(self, address, pretty=False, verbose=False):
+    def __init__(self, address: str,
+                 pretty: bool = False, verbose: bool = False):
         super().__init__(address, pretty, verbose)
         self.__cpu_index = 0
 
-    def __cmd_completion(self):
+    def __cmd_completion(self) -> None:
         for cmd in self.__cmd_passthrough('help')['return'].split('\r\n'):
             if cmd and cmd[0] != '[' and cmd[0] != '\t':
                 name = cmd.split()[0]  # drop help text
@@ -355,21 +369,22 @@ class HMPShell(QMPShell):
                 self._completer.append(name)
                 self._completer.append('help ' + name)  # help completion
 
-    def __info_completion(self):
+    def __info_completion(self) -> None:
         for cmd in self.__cmd_passthrough('info')['return'].split('\r\n'):
             if cmd:
                 self._completer.append('info ' + cmd.split()[1])
 
-    def __other_completion(self):
+    def __other_completion(self) -> None:
         # special cases
         self._completer.append('help info')
 
-    def _fill_completion(self):
+    def _fill_completion(self) -> None:
         self.__cmd_completion()
         self.__info_completion()
         self.__other_completion()
 
-    def __cmd_passthrough(self, cmdline, cpu_index=0):
+    def __cmd_passthrough(self, cmdline: str,
+                          cpu_index: int = 0) -> QMPMessage:
         return self.cmd_obj({
             'execute': 'human-monitor-command',
             'arguments': {
@@ -378,7 +393,7 @@ class HMPShell(QMPShell):
             }
         })
 
-    def _execute_cmd(self, cmdline):
+    def _execute_cmd(self, cmdline: str) -> bool:
         if cmdline.split()[0] == "cpu":
             # trap the cpu command, it requires special setting
             try:
@@ -404,16 +419,16 @@ class HMPShell(QMPShell):
             print('%s: %s' % (resp['error']['class'], resp['error']['desc']))
         return True
 
-    def show_banner(self, msg='Welcome to the HMP shell!'):
+    def show_banner(self, msg: str = 'Welcome to the HMP shell!') -> None:
         QMPShell.show_banner(self, msg)
 
 
-def die(msg):
+def die(msg: str) -> NoReturn:
     sys.stderr.write('ERROR: %s\n' % msg)
     sys.exit(1)
 
 
-def main():
+def main() -> None:
     parser = argparse.ArgumentParser()
     parser.add_argument('-H', '--hmp', action='store_true',
                         help='Use HMP interface')
-- 
2.26.2


