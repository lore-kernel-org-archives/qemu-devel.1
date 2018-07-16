Received: from eggs.gnu.org ([2001:4830:134:3::10]:33989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47r-0001ps-PY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47o-0007wA-PL
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35970 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff47o-0007vV-E7
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D5EF402347E
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9D9E111AF01
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 16:05:10 +0200
Message-Id: <20180716140514.1490-2-armbru@redhat.com>
In-Reply-To: <20180716140514.1490-1-armbru@redhat.com>
References: <20180716140514.1490-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] qapi: Do not expose "allow-preconfig" in
 query-qmp-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to commit 047f7038f58, option --preconfig

    [...] allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
    allowing the configuration of QEMU from QMP before the machine
    jumps into board initialization code of machine_run_board_init()

    The intent is to allow management to query machine state and
    additionally configure it using previous query results within one
    QEMU instance (i.e. eliminate the need to start QEMU twice, 1st to
    query board specific parameters and 2nd for actual VM start using
    query results for additional parameters).

The implementation is a bit of a hack: it splices in an additional
main loop before machine creation, in special runstate preconfig.  New
command exit-preconfig exits that main loop.  QEMU continues
initializing, creates the machine, and runs the good old main loop.
The replacement of the main loop is transparent to monitors.

Sadly, some commands expect initialization to be complete.  Running
them in --preconfig's main loop violates their preconditions.  Since
we don't really know which commands are safe, we use a whitelist.
This drags the concept of run state into the QMP core.

The whitelist is done as a command flag in the QAPI schema (commit
d6fe3d02e9a).  Drags the concept of run state further into the QAPI
language.

The command flag is exposed in query-qmp-schema (also commit
d6fe3d02e9a).  This makes it ABI.

I consider the whole thing an offensively ugly hack, but sometimes an
ugly hack is the best we can do to solve a problem people have.

The need described by the commit message quote above is genuine.  The
proper solution would be a main loop that permits complete
configuration via QMP.  This is out of reach, thus the hack.

However, even though the need is genuine, it isn't urgent: libvirt is
not going to use this anytime soon.  Baking a hack into ABI before it
has any users is a bad idea.

This commit reverts the parts of commit d6fe3d02e9a that affect ABI
via query-qmp-schema.  The commit did the following:

(1) Add command flag 'allow-preconfig' to the QAPI schema language

(2) Pass it to code generators

(3) Have the commands.py code generator pass it to the command
    registry (so commit 047f7038f58 can use it as whitelist)

(4) Add 'allow-preconfig' to SchemaInfoCommand (neglecting to update
    qapi-code-gen.txt section "Client JSON Protocol introspection")

(5) Set 'allow-preconfig': true for commands qmp_capabilities,
    query-commands, query-command-line-options, query-status

Revert exactly (4), plus a bit of documentation added to
qemu-tech.info in commit 047f7038f58.

Shrinks query-qmp-schema's output from 126.5KiB to 121.8KiB for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180705091402.26244-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
[Straightforward conflict with commit d626b6c1ae7 resolved]
---
 qapi/introspect.json       | 5 +----
 qemu-tech.texi             | 3 ---
 scripts/qapi/introspect.py | 4 ++--
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 80a0a3e656..c7f67b7d78 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -262,16 +262,13 @@
 # @allow-oob: whether the command allows out-of-band execution.
 #             (Since: 2.12)
 #
-# @allow-preconfig: command can be executed in preconfig runstate,
-#                   default: false (Since 3.0)
-#
 # TODO: @success-response (currently irrelevant, because it's QGA, not QMP)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            'allow-oob': 'bool', 'allow-preconfig': 'bool' } }
+            'allow-oob': 'bool' } }
 
 ##
 # @SchemaInfoEvent:
diff --git a/qemu-tech.texi b/qemu-tech.texi
index dcecba83cb..f843341ffa 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -350,9 +350,6 @@ depend on an initialized machine, including but not limited to:
 @item query-status
 @item exit-preconfig
 @end table
-The full list of commands is in QMP schema which could be queried with
-query-qmp-schema, where commands supported at preconfig state have option
-'allow-preconfig' set to true.
 
 @node Bibliography
 @section Bibliography
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 71d4a779ce..70ca5dd876 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -187,8 +187,8 @@ const QLitObject %(c_name)s = %(c_string)s;
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type),
-                        'allow-oob': allow_oob,
-                        'allow-preconfig': allow_preconfig}, ifcond)
+                        'allow-oob': allow_oob},
+                       ifcond)
 
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         arg_type = arg_type or self._schema.the_empty_object_type
-- 
2.17.1
