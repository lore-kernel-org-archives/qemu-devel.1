Received: from eggs.gnu.org ([2001:4830:134:3::10]:57835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBIH-0008Rw-6W
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBIF-0000W5-Rj
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:40:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfBIF-0000VX-J8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D2ADCAA72
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  8 Aug 2017 17:39:35 -0300
Message-Id: <20170808203935.30021-6-ehabkost@redhat.com>
In-Reply-To: <20170808203935.30021-1-ehabkost@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 5/5] Remove scripts/qmp/qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>

The only purpose of scripts/qmp/qmp was the ability to run QMP
commands non-interactively.  Now it is possible to run qmp-shell
non-interactively by providing a QMP command a command-line
argument, making scripts/qmp/qmp obsolete.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 scripts/qmp/qmp | 126 --------------------------------------------------------
 1 file changed, 126 deletions(-)
 delete mode 100755 scripts/qmp/qmp

diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
deleted file mode 100755
index 514b539..0000000
--- a/scripts/qmp/qmp
+++ /dev/null
@@ -1,126 +0,0 @@
-#!/usr/bin/python
-#
-# QMP command line tool
-#
-# Copyright IBM, Corp. 2011
-#
-# Authors:
-#  Anthony Liguori <aliguori@us.ibm.com>
-#
-# This work is licensed under the terms of the GNU GPLv2 or later.
-# See the COPYING file in the top-level directory.
-
-import sys, os
-from qmp import QEMUMonitorProtocol
-
-def print_response(rsp, prefix=[]):
-    if type(rsp) == list:
-        i = 0
-        for item in rsp:
-            if prefix == []:
-                prefix = ['item']
-            print_response(item, prefix[:-1] + ['%s[%d]' % (prefix[-1], i)])
-            i += 1
-    elif type(rsp) == dict:
-        for key in rsp.keys():
-            print_response(rsp[key], prefix + [key])
-    else:
-        if len(prefix):
-            print '%s: %s' % ('.'.join(prefix), rsp)
-        else:
-            print '%s' % (rsp)
-
-def main(args):
-    path = None
-
-    # Use QMP_PATH if it's set
-    if os.environ.has_key('QMP_PATH'):
-        path = os.environ['QMP_PATH']
-
-    while len(args):
-        arg = args[0]
-
-        if arg.startswith('--'):
-            arg = arg[2:]
-            if arg.find('=') == -1:
-                value = True
-            else:
-                arg, value = arg.split('=', 1)
-
-            if arg in ['path']:
-                if type(value) == str:
-                    path = value
-            elif arg in ['help']:
-                os.execlp('man', 'man', 'qmp')
-            else:
-                print 'Unknown argument "%s"' % arg
-
-            args = args[1:]
-        else:
-            break
-
-    if not path:
-        print "QMP path isn't set, use --path=qmp-monitor-address or set QMP_PATH"
-        return 1
-
-    if len(args):
-        command, args = args[0], args[1:]
-    else:
-        print 'No command found'
-        print 'Usage: "qmp [--path=qmp-monitor-address] qmp-cmd arguments"'
-        return 1
-
-    if command in ['help']:
-        os.execlp('man', 'man', 'qmp')
-
-    srv = QEMUMonitorProtocol(path)
-    srv.connect()
-
-    def do_command(srv, cmd, **kwds):
-        rsp = srv.cmd(cmd, kwds)
-        if rsp.has_key('error'):
-            raise Exception(rsp['error']['desc'])
-        return rsp['return']
-
-    commands = map(lambda x: x['name'], do_command(srv, 'query-commands'))
-
-    srv.close()
-
-    if command not in commands:
-        fullcmd = 'qmp-%s' % command
-        try:
-            os.environ['QMP_PATH'] = path
-            os.execvp(fullcmd, [fullcmd] + args)
-        except OSError as exc:
-            if exc.errno == 2:
-                print 'Command "%s" not found.' % (fullcmd)
-                return 1
-            raise
-        return 0
-
-    srv = QEMUMonitorProtocol(path)
-    srv.connect()
-
-    arguments = {}
-    for arg in args:
-        if not arg.startswith('--'):
-            print 'Unknown argument "%s"' % arg
-            return 1
-
-        arg = arg[2:]
-        if arg.find('=') == -1:
-            value = True
-        else:
-            arg, value = arg.split('=', 1)
-
-        if arg in ['help']:
-            os.execlp('man', 'man', 'qmp-%s' % command)
-            return 1
-
-        arguments[arg] = value
-
-    rsp = do_command(srv, command, **arguments)
-    print_response(rsp)
-
-if __name__ == '__main__':
-    sys.exit(main(sys.argv[1:]))
-- 
2.9.4
