Received: from eggs.gnu.org ([2001:4830:134:3::10]:59140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qp-0000od-5B
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f40qn-0006YV-MG
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51490 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f40qn-0006Xs-FD
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 05:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67A094022909
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 09:06:22 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Apr 2018 11:05:02 +0200
Message-Id: <1522919113-158775-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v5 00/11] enable numa configuration
 before machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com


v4->v5:
  * rebase on top of OOB changes that's now in master
  * s/qobject_to_qdict(/qobject_to(QDict,/
  * s/-preconfig/--preconfig/
  * s/2.12/2.13/
  * s/parse_NumaOptions/set_numa_options/
  * drop if (err) guard around error_propagate()
  * move QCO_ALLOWED_IN_PRECONFIG and do_qmp_dispatch() runstate check
    from the later patch 'qapi: introduce new cmd option  "allowed-in-preconfig"'
    to here for better bissectability
  * add TODO comment to '{ RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE }' transition
  * check for incoming && preconfig outside of option parsing loop
  * add 'use QMP instead" to error message, suggesting user the right interface to use
  * allow query-command-line-options in preconfig state
  * make sure that allowed-in-preconfig could be set only to True
  * move out QCO_ALLOWED_IN_PRECONFIG check in do_qmp_dispatch() to
    earlier 'cli: add --preconfig option' patch
  * 2 extra test patches
     'tests: let qapi-schema tests detect allowed-in-preconfig'
     'tests: add allowed-in-preconfig-test for qapi-schema'
v3->v4:
  * replace 'runstates' list in  QMP command with a single
    boolean 'ption allowed-in-preconfig' like it's done with
    'allow-oob'. Which allows to simplify intrusive QAPI
    changes quite a lot. (Eric Blake <eblake@redhat.com>)
  * Make sure HMP is disbled for real, v3 was just printing
    error mesage but allowing command to be executed
    ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
  * Improve "cli: add -preconfig option" commit message,
    explain a bit more on semantics of new state/option.
  * ithe rest of minor fixups suggested at v3 review
    (Eric Blake <eblake@redhat.com>)
    PS:
       havn't impl. test for new option in
         tests/qapi-schema/qapi-schema-test.json yet,
       can do it on top if approach is acceptable.
v1->v3:
  * introduce PRECONFIG runstate with -preconfig option.
    it's cleaner to manage transitions and do checks
    than reusing existing PRELAUNCH state.
  * extend QAPI schema commands with 'runstates' keyword,
    so that it would be possible to specify in command definition
    when it is valid to execute.
    (python changes a bit hackery, since I have little to
     no idea how it should work)
  * add preconfig QMP and set-numa-node tests
  * make mutually exclusive -preconfig and -incoming options,
    for simplicity sake. Shouldn't be problem as target can
    be starter with pure CLI, since mapping on source is
    already known.
  * Drop HMP part and leave only QMP in preconfig state.


Series allows to configure NUMA mapping at runtime using QMP
interface. For that to happen it introduces a new '--preconfig' CLI option
which allows to pause QEMU before machine_init() is run and
adds new set-numa-node QMP command which in conjunction with
query-hotpluggable-cpus allows to configure NUMA mapping for cpus.

Later we can modify other commands to run early, for example device_add.
I recall SPAPR had problem when libvirt started QEMU with -S and, while it's
paused, added CPUs with device_add. Intent was to coldplug CPUs (but at that
stage it's considered hotplug already), so SPAPR had to work around the issue.

Example of configuration session:
$QEMU -smp 2 --preconfig ...

QMP:
# get CPUs layout for current target/machine/CLI
-> {'execute': 'query-hotpluggable-cpus' }    
<- {'return': [
       {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 1}, ... },
       {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 0}, ... }
   ]}

# configure 1st node
-> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 0 } }    
<- {'return': {}}
-> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',     
       'node-id': 0, 'core-id': 0, 'thread-id': 0, 'socket-id': 1, }
   }
<- {'return': {}}

# configure 2nd node
-> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 1 } }
-> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',    
       'node-id': 1, 'core-id': 0, 'thread-id': 0, 'socket-id': 0 }
   }
<- {'return': {}}

# [optional] verify configuration
-> {'execute': 'query-hotpluggable-cpus' }    
<- {'return': [
       {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 0, 'socket-id': 1}, ... },
       {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 1, 'socket-id': 0}, ... }
   ]}


Git tree:
    https://github.com/imammedo/qemu.git qmp_preconfig_v5

Ref to v1:
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg521028.html
    Message-Id: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
  
CC: eblake@redhat.com
CC: ehabkost@redhat.com
CC: pkrempa@redhat.com


Igor Mammedov (11):
  numa: postpone options post-processing till machine_run_board_init()
  numa: split out NumaOptions parsing into set_numa_options()
  cli: add --preconfig option
  hmp: disable monitor in preconfig state
  qapi: introduce new cmd option "allowed-in-preconfig"
  tests: let qapi-schema tests detect allowed-in-preconfig
  tests: add allowed-in-preconfig-test for qapi-schema
  tests: extend qmp test with preconfig checks
  qmp: permit query-hotpluggable-cpus in preconfig state
  qmp: add set-numa-node command
  tests: functional tests for QMP command set-numa-node

 include/qapi/qmp/dispatch.h                      |  1 +
 include/sysemu/numa.h                            |  2 +
 include/sysemu/sysemu.h                          |  1 +
 tests/libqtest.h                                 |  9 ++++
 docs/devel/qapi-code-gen.txt                     | 10 +++-
 hw/core/machine.c                                |  5 +-
 monitor.c                                        | 11 +++-
 numa.c                                           | 64 +++++++++++++++---------
 qapi/introspect.json                             |  5 +-
 qapi/misc.json                                   | 28 +++++++++--
 qapi/qmp-dispatch.c                              |  8 +++
 qapi/run-state.json                              |  8 ++-
 qemu-options.hx                                  | 13 +++++
 qmp.c                                            |  5 ++
 scripts/qapi/commands.py                         | 12 +++--
 scripts/qapi/common.py                           | 19 ++++---
 scripts/qapi/doc.py                              |  4 +-
 scripts/qapi/introspect.py                       |  7 +--
 tests/Makefile.include                           |  1 +
 tests/libqtest.c                                 |  7 +++
 tests/numa-test.c                                | 61 ++++++++++++++++++++++
 tests/qapi-schema/allowed-in-preconfig-test.err  |  1 +
 tests/qapi-schema/allowed-in-preconfig-test.exit |  1 +
 tests/qapi-schema/allowed-in-preconfig-test.json |  2 +
 tests/qapi-schema/allowed-in-preconfig-test.out  |  0
 tests/qapi-schema/doc-good.out                   |  4 +-
 tests/qapi-schema/ident-with-escape.out          |  2 +-
 tests/qapi-schema/indented-expr.out              |  4 +-
 tests/qapi-schema/qapi-schema-test.json          |  3 ++
 tests/qapi-schema/qapi-schema-test.out           | 22 ++++----
 tests/qapi-schema/test-qapi.py                   |  8 +--
 tests/qmp-test.c                                 | 37 ++++++++++++++
 tests/test-qmp-cmds.c                            |  4 ++
 vl.c                                             | 35 ++++++++++++-
 34 files changed, 331 insertions(+), 73 deletions(-)
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.err
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.exit
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.json
 create mode 100644 tests/qapi-schema/allowed-in-preconfig-test.out

-- 
2.7.4
