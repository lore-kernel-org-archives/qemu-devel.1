Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A537CC4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18646223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTavUqjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18646223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6uT-0006nr-24
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mm-00061b-VA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mi-0004ms-7h
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRs9bWy/l+OS7Dmw/otXBWJQ78D/TeE5mmlSCOg0PRA=;
 b=CTavUqjEqnR4f93Wh53JJVMUfO+zmcirk5ob7AY3IYFUgGZsQ1ArSDq4VW7wILGFv/sYqU
 R8yWZA080pRa6daDqD/p4MbqPT9u9g2ZGkoCr7eAmQBBKnTiSVRehJkvCnwc8tJI9Uywt1
 lS+ELpfWFEyq7tRwlEg5PWR4Wqbhc3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-lbBUdxKmOVCwyaYgRb2fsA-1; Tue, 03 Nov 2020 19:36:14 -0500
X-MC-Unique: lbBUdxKmOVCwyaYgRb2fsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 819366D596
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:13 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EDAA55766;
 Wed,  4 Nov 2020 00:36:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/72] python/qmp: Add qom script rewrites
Date: Tue,  3 Nov 2020 19:34:51 -0500
Message-Id: <20201104003602.1293560-2-jsnow@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Inspired by qom-set, qom-get, qom-tree and qom-list; combine all four of
those scripts into one script.

A later addition of qom-fuse necessitates that some common features are
split out and shared between them.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/qom.py        | 207 ++++++++++++++++++++++++++++++++++
 python/qemu/qmp/qom_common.py | 153 +++++++++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 python/qemu/qmp/qom.py
 create mode 100644 python/qemu/qmp/qom_common.py

diff --git a/python/qemu/qmp/qom.py b/python/qemu/qmp/qom.py
new file mode 100644
index 000000000000..912d1809e60d
--- /dev/null
+++ b/python/qemu/qmp/qom.py
@@ -0,0 +1,207 @@
+"""
+QEMU Object Model testing tools.
+
+usage: qom.py [-h] {set,get,list,tree} ...
+
+Query and manipulate QOM data
+
+optional arguments:
+  -h, --help           show this help message and exit
+
+QOM commands:
+  {set,get,list,tree,fuse}
+    set                Set a QOM property value
+    get                Get a QOM property value
+    list               List QOM properties at a given path
+    tree               Show QOM tree from a given path
+"""
+##
+# Copyright John Snow 2020, for Red Hat, Inc.
+# Copyright IBM, Corp. 2011
+#
+# Authors:
+#  John Snow <jsnow@redhat.com>
+#  Anthony Liguori <aliguori@amazon.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# Based on ./scripts/qmp/qom-[set|get|tree|list]
+##
+
+import argparse
+import sys
+
+from . import QMPResponseError
+from .qom_common import QOMCommand
+
+
+class QOMSet(QOMCommand):
+    """QOM Command - Set a property to a given value."""
+    name = 'set'
+    help = 'Set a QOM property value'
+
+    @classmethod
+    def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
+        super().configure_parser(parser)
+        cls.add_path_prop_arg(parser)
+        parser.add_argument(
+            'value',
+            metavar='<value>',
+            action='store',
+            help='new QOM property value'
+        )
+
+    def __init__(self, args: argparse.Namespace):
+        super().__init__(args)
+        self.path, self.prop = args.path_prop.rsplit('.', 1)
+        self.value = args.value
+
+    def run(self) -> int:
+        rsp = self.qmp.command(
+            'qom-set',
+            path=self.path,
+            property=self.prop,
+            value=self.value
+        )
+        print(rsp)
+        return 0
+
+
+class QOMGet(QOMCommand):
+    """QOM Command - Get a property's current value."""
+    name = 'get'
+    help = 'Get a QOM property value'
+
+    @classmethod
+    def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
+        super().configure_parser(parser)
+        cls.add_path_prop_arg(parser)
+
+    def __init__(self, args: argparse.Namespace):
+        super().__init__(args)
+        try:
+            tmp = args.path_prop.rsplit('.', 1)
+        except ValueError as err:
+            raise ValueError('Invalid format for <path>.<property>') from err
+        self.path = tmp[0]
+        self.prop = tmp[1]
+
+    def run(self) -> int:
+        rsp = self.qmp.command(
+            'qom-get',
+            path=self.path,
+            property=self.prop
+        )
+        if isinstance(rsp, dict):
+            for key, value in rsp.items():
+                print(f"{key}: {value}")
+        else:
+            print(rsp)
+        return 0
+
+
+class QOMList(QOMCommand):
+    """QOM Command - List the properties at a given path."""
+    name = 'list'
+    help = 'List QOM properties at a given path'
+
+    @classmethod
+    def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
+        super().configure_parser(parser)
+        parser.add_argument(
+            'path',
+            metavar='<path>',
+            action='store',
+            help='QOM path',
+        )
+
+    def __init__(self, args: argparse.Namespace):
+        super().__init__(args)
+        self.path = args.path
+
+    def run(self) -> int:
+        rsp = self.qom_list(self.path)
+        for item in rsp:
+            if item.child:
+                print(f"{item.name}/")
+            elif item.link:
+                print(f"@{item.name}/")
+            else:
+                print(item.name)
+        return 0
+
+
+class QOMTree(QOMCommand):
+    """QOM Command - Show the full tree below a given path."""
+    name = 'tree'
+    help = 'Show QOM tree from a given path'
+
+    @classmethod
+    def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
+        super().configure_parser(parser)
+        parser.add_argument(
+            'path',
+            metavar='<path>',
+            action='store',
+            help='QOM path',
+            nargs='?',
+            default='/'
+        )
+
+    def __init__(self, args: argparse.Namespace):
+        super().__init__(args)
+        self.path = args.path
+
+    def _list_node(self, path: str) -> None:
+        print(path)
+        items = self.qom_list(path)
+        for item in items:
+            if item.child:
+                continue
+            try:
+                rsp = self.qmp.command('qom-get', path=path,
+                                       property=item.name)
+                print(f"  {item.name}: {rsp} ({item.type})")
+            except QMPResponseError as err:
+                print(f"  {item.name}: <EXCEPTION: {err!s}> ({item.type})")
+        print('')
+        for item in items:
+            if not item.child:
+                continue
+            if path == '/':
+                path = ''
+            self._list_node(f"{path}/{item.name}")
+
+    def run(self) -> int:
+        self._list_node(self.path)
+        return 0
+
+
+def main() -> int:
+    """QOM script main entry point."""
+    parser = argparse.ArgumentParser(
+        description='Query and manipulate QOM data'
+    )
+    subparsers = parser.add_subparsers(
+        title='QOM commands',
+        dest='command'
+    )
+
+    for command in QOMCommand.__subclasses__():
+        command.register(subparsers)
+
+    args = parser.parse_args()
+
+    if args.command is None:
+        parser.error('Command not specified.')
+        return 1
+
+    assert issubclass(args.cmd_class, QOMCommand)
+    cmd = args.cmd_class(args)
+    assert isinstance(cmd, QOMCommand)
+    return cmd.run()
+
+
+if __name__ == '__main__':
+    sys.exit(main())
diff --git a/python/qemu/qmp/qom_common.py b/python/qemu/qmp/qom_common.py
new file mode 100644
index 000000000000..3890b247ae68
--- /dev/null
+++ b/python/qemu/qmp/qom_common.py
@@ -0,0 +1,153 @@
+"""
+QOM Command abstractions.
+"""
+##
+# Copyright John Snow 2020, for Red Hat, Inc.
+# Copyright IBM, Corp. 2011
+#
+# Authors:
+#  John Snow <jsnow@redhat.com>
+#  Anthony Liguori <aliguori@amazon.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# Based on ./scripts/qmp/qom-[set|get|tree|list]
+##
+
+import argparse
+import os
+from typing import (
+    Any,
+    Dict,
+    List,
+    Optional,
+)
+
+from . import QEMUMonitorProtocol
+
+
+Subparsers = argparse._SubParsersAction  # pylint: disable=protected-access
+
+
+class ObjectPropertyInfo:
+    """
+    Represents the return type from e.g. qom-list.
+    """
+    def __init__(self, name: str, type_: str,
+                 description: Optional[str] = None,
+                 default_value: Optional[object] = None):
+        self.name = name
+        self.type = type_
+        self.description = description
+        self.default_value = default_value
+
+    @classmethod
+    def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyInfo':
+        """
+        Build an ObjectPropertyInfo from a Dict with an unknown shape.
+        """
+        assert value.keys() >= {'name', 'type'}
+        assert value.keys() <= {'name', 'type', 'description', 'default-value'}
+        return cls(value['name'], value['type'],
+                   value.get('description'),
+                   value.get('default-value'))
+
+    @property
+    def child(self) -> bool:
+        """Is this property a child property?"""
+        return self.type.startswith('child<')
+
+    @property
+    def link(self) -> bool:
+        """Is this property a link property?"""
+        return self.type.startswith('link<')
+
+
+class QOMCommand:
+    """
+    Represents a QOM sub-command.
+
+    :param args: Parsed arguments, as returned from parser.parse_args.
+    """
+    name: str
+    help: str
+
+    def __init__(self, args: argparse.Namespace):
+        if args.socket is None:
+            raise Exception("No QMP socket path or address given")
+        self.qmp = QEMUMonitorProtocol(args.socket)
+        self.qmp.connect()
+
+    @classmethod
+    def register(cls, subparsers: Subparsers) -> None:
+        """
+        Register this command with the argument parser.
+
+        :param subparsers: argparse subparsers object, from "add_subparsers".
+        """
+        subparser = subparsers.add_parser(cls.name, help=cls.help,
+                                          description=cls.help)
+        cls.configure_parser(subparser)
+
+    @classmethod
+    def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
+        """
+        Configure a parser with this command's arguments.
+
+        :param parser: argparse parser or subparser object.
+        """
+        default_path = os.environ.get('QMP_SOCKET')
+        parser.add_argument(
+            '--socket', '-s',
+            dest='socket',
+            action='store',
+            help='QMP socket path or address (addr:port).'
+            ' May also be set via QMP_SOCKET environment variable.',
+            default=default_path
+        )
+        parser.set_defaults(cmd_class=cls)
+
+    @classmethod
+    def add_path_prop_arg(cls, parser: argparse.ArgumentParser) -> None:
+        """
+        Add the <path>.<proptery> positional argument to this command.
+
+        :param parser: The parser to add the argument to.
+        """
+        parser.add_argument(
+            'path_prop',
+            metavar='<path>.<property>',
+            action='store',
+            help="QOM path and property, separated by a period '.'"
+        )
+
+    def run(self) -> int:
+        """
+        Run this command.
+
+        :return: 0 on success, 1 otherwise.
+        """
+        raise NotImplementedError
+
+    def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
+        """
+        :return: a strongly typed list from the 'qom-list' command.
+        """
+        rsp = self.qmp.command('qom-list', path=path)
+        # qom-list returns List[ObjectPropertyInfo]
+        assert isinstance(rsp, list)
+        return [ObjectPropertyInfo.make(x) for x in rsp]
+
+    @classmethod
+    def entry_point(cls) -> int:
+        """
+        Build this command's parser, parse arguments, and run the command.
+
+        :return: `run`'s return code.
+        """
+        parser = argparse.ArgumentParser(description=cls.help)
+        cls.configure_parser(parser)
+        args = parser.parse_args()
+        cmd = cls(args)
+        return cmd.run()
-- 
2.26.2


