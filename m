Received: from eggs.gnu.org ([2001:4830:134:3::10]:56458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ1hI-0003b4-HO
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ1hF-00052n-A0
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ1hF-00052h-05
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27D594ACA4
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 19:02:44 +0000 (UTC)
Date: Wed, 16 May 2018 16:02:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516190242.GL4903@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 00/11] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>


I'm queueing this version (including v8 of patches 5-7) on
numa-next.

Markus, Daniel: you were the people I remember expressing some
concerns about the new preconfig mechanism.  Do you have any
objections to this version?


On Fri, May 04, 2018 at 10:37:38AM +0200, Igor Mammedov wrote:
> 
> 
> v6->v7:
>   * fix up wording in documentation and left-overs of 'reusing' 'cont' command in v5
>   * split out preconfig runstate introduction into separate patch to make
>     series more bisection friendly and put allow-preconfig patch before
>     --preconfig CLI patch
>   * merge qapi schema tests patches into one
>   * rename allowed_in_preconfig flag to a shorter allow_preconfig
>   * rename QCO_ALLOWED_IN_PRECONFIG into shorter QCO_ALLOW_PRECONFIG to match
>     allow_preconfig flag
>   * reuse an-oob-command for allow_preconfig flag testing and rename it to
>     test-flags-command
> v5->v6:
>   * add exit-preconfig QMP command instead of overloading meaning of 'cont' command
>   * add doc text to qemu-tech.texi about -S and --preconfig
>   * add numa configuration example into commit message of 10/11
>   * limit set-numa-node QMP command to preconfig mode
> v4->v5:
>   * rebase on top of OOB changes that's now in master
>   * s/qobject_to_qdict(/qobject_to(QDict,/
>   * s/-preconfig/--preconfig/
>   * s/2.12/2.13/
>   * s/parse_NumaOptions/set_numa_options/
>   * drop if (err) guard around error_propagate()
>   * move QCO_ALLOWED_IN_PRECONFIG and do_qmp_dispatch() runstate check
>     from the later patch 'qapi: introduce new cmd option  "allowed-in-preconfig"'
>     to here for better bissectability
>   * add TODO comment to '{ RUN_STATE_PRECONFIG, RUN_STATE_INMIGRATE }' transition
>   * check for incoming && preconfig outside of option parsing loop
>   * add 'use QMP instead" to error message, suggesting user the right interface to use
>   * allow query-command-line-options in preconfig state
>   * make sure that allowed-in-preconfig could be set only to True
>   * move out QCO_ALLOWED_IN_PRECONFIG check in do_qmp_dispatch() to
>     earlier 'cli: add --preconfig option' patch
>   * 2 extra test patches
>      'tests: let qapi-schema tests detect allowed-in-preconfig'
>      'tests: add allowed-in-preconfig-test for qapi-schema'
> v3->v4:
>   * replace 'runstates' list in  QMP command with a single
>     boolean 'ption allowed-in-preconfig' like it's done with
>     'allow-oob'. Which allows to simplify intrusive QAPI
>     changes quite a lot. (Eric Blake <eblake@redhat.com>)
>   * Make sure HMP is disbled for real, v3 was just printing
>     error mesage but allowing command to be executed
>     ("Dr. David Alan Gilbert" <dgilbert@redhat.com>)
>   * Improve "cli: add -preconfig option" commit message,
>     explain a bit more on semantics of new state/option.
>   * ithe rest of minor fixups suggested at v3 review
>     (Eric Blake <eblake@redhat.com>)
>     PS:
>        havn't impl. test for new option in
>          tests/qapi-schema/qapi-schema-test.json yet,
>        can do it on top if approach is acceptable.
> v1->v3:
>   * introduce PRECONFIG runstate with -preconfig option.
>     it's cleaner to manage transitions and do checks
>     than reusing existing PRELAUNCH state.
>   * extend QAPI schema commands with 'runstates' keyword,
>     so that it would be possible to specify in command definition
>     when it is valid to execute.
>     (python changes a bit hackery, since I have little to
>      no idea how it should work)
>   * add preconfig QMP and set-numa-node tests
>   * make mutually exclusive -preconfig and -incoming options,
>     for simplicity sake. Shouldn't be problem as target can
>     be starter with pure CLI, since mapping on source is
>     already known.
>   * Drop HMP part and leave only QMP in preconfig state.
> 
> 
> Currently it's problematic to configure NUMA mapping for CPUs using "-numa cpu="
> option, without restarting QEMU, first is to query board specific CPU layout
> with query-hotpluggable-cpus QMP command (which is function of -M and -smp CLI
> options). Mgmt side isn't happy with restarting QEMU to query configuration
> parameters first and then run actual instance, so it keeps using old cpu_index
> based option '-numa cpus' instead of new socket/core/thread-id based one.
> 
> Introduce a new '--preconfig' CLI option which allows pausing QEMU before
> machine_init() is run (preconfig state). So it would be possible to query
> possible CPUs layout, configure NUMA mapping based on query result with
> set-numa-node QMP command and continue executing  without restarting QEMU.
> 
> Difference between new --preconfig pause point vs -S is that the later pauses
> QEMU after machine is constructed and ready to run guest code or in process of
> incoming migration (essentially machine is in some running state (with paused
> VCPUs) and any action on it is considered as hotplug). At this point it's hard
> to configure or reconfigure parameters that affect machine_init() and later
> stages. While the new --preconfig option pauses QEMU instance before
> machine_init() and would allow to configure parameters as if doing it from CLI
> but in interactve manner using QMP interface, which would allow introspecting
> and configuring QEMU instance without restarting it. 
> 
> Initially only limited set of commands (that are ready to work with non
> initialized machine or without it) are allowed in preconfig state:
> 
>    #existing commands:
>        qmp_capabilities
>        query-qmp-schema
>        query-commands
>        query-command-line-options
>        query-status
>        query-hotpluggable-cpus
>    #new commands
>        exit-preconfig
>        set-numa-node
> 
> Which commands are allowed at preconfig state, is defined by QAPI Schema
> with help of optional 'allowed-in-preconfig' flag in command definition,
> which allows users to get list of commands it can run with help of
> query-qmp-schema command.
> 
> Once user done with configuration at preconfig state, it could be exited with
> exit-preconfig command, in which case QEMU would proceed with VM intialization
> and either start guest execution or pause in prelaunch state if -S CLI option
> were specified along with --prelaunch on startup.
> 
> PS:
> Later we can modify other commands to run early, for example device_add. So
> that devices would be added in cold-plug context, instead of getting device
> 'hotplugged' with followed up fixups and workarounds to make it look like
> cold-plugged.
> 
> Example of configuration CPU's NUMA mapping with --preconfig:
> $QEMU -smp 2 --preconfig ...
> 
> QMP:
> # get CPUs layout for current target/machine/CLI
> -> {'execute': 'query-hotpluggable-cpus' }        
> <- {'return': [
>        {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 1}, ... },
>        {'props': {'core-id': 0, 'thread-id': 0, 'socket-id': 0}, ... }
>    ]}
> 
> # configure 1st node
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 0 } }        
> <- {'return': {}}
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',         
>        'node-id': 0, 'core-id': 0, 'thread-id': 0, 'socket-id': 1, }
>    }
> <- {'return': {}}
> 
> # configure 2nd node
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'node', 'nodeid': 1 } }
> -> {'execute': 'set-numa-node', 'arguments': { 'type': 'cpu',        
>        'node-id': 1, 'core-id': 0, 'thread-id': 0, 'socket-id': 0 }
>    }
> <- {'return': {}}
> 
> # [optional] verify configuration
> -> {'execute': 'query-hotpluggable-cpus' }        
> <- {'return': [
>        {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 0, 'socket-id': 1}, ... },
>        {'props': {'core-id': 0, 'thread-id': 0, 'node-id': 1, 'socket-id': 0}, ... }
>    ]}
> 
> 
> Git tree:
>     https://github.com/imammedo/qemu.git qmp_preconfig_v7
> 
>  
> CC: eblake@redhat.com
> CC: ehabkost@redhat.com
> CC: pkrempa@redhat.com
> CC: armbru@redhat.com
> 
> 
> Igor Mammedov (11):
>   numa: postpone options post-processing till machine_run_board_init()
>   numa: split out NumaOptions parsing into set_numa_options()
>   qapi: introduce preconfig runstate
>   hmp: disable monitor in preconfig state
>   qapi: introduce new cmd option "allowed-in-preconfig"
>   tests: qapi-schema tests for allow-preconfig
>   cli: add --preconfig option
>   tests: extend qmp test with preconfig checks
>   qmp: permit query-hotpluggable-cpus in preconfig state
>   qmp: add set-numa-node command
>   tests: functional tests for QMP command set-numa-node
> 
>  include/qapi/qmp/dispatch.h                 |  1 +
>  include/sysemu/numa.h                       |  2 +
>  include/sysemu/sysemu.h                     |  1 +
>  tests/libqtest.h                            |  9 ++++
>  docs/devel/qapi-code-gen.txt                | 10 ++++-
>  hw/core/machine.c                           |  5 ++-
>  monitor.c                                   | 11 +++--
>  numa.c                                      | 70 +++++++++++++++++++----------
>  qapi/introspect.json                        |  5 ++-
>  qapi/misc.json                              | 49 ++++++++++++++++++--
>  qapi/qmp-dispatch.c                         |  8 ++++
>  qapi/run-state.json                         |  8 +++-
>  qemu-options.hx                             | 13 ++++++
>  qemu-tech.texi                              | 40 +++++++++++++++++
>  qmp.c                                       | 10 +++++
>  scripts/qapi/commands.py                    | 11 +++--
>  scripts/qapi/common.py                      | 18 +++++---
>  scripts/qapi/doc.py                         |  4 +-
>  scripts/qapi/introspect.py                  |  7 +--
>  tests/Makefile.include                      |  1 +
>  tests/libqtest.c                            |  7 +++
>  tests/numa-test.c                           | 61 +++++++++++++++++++++++++
>  tests/qapi-schema/allow-preconfig-test.err  |  1 +
>  tests/qapi-schema/allow-preconfig-test.exit |  1 +
>  tests/qapi-schema/allow-preconfig-test.json |  2 +
>  tests/qapi-schema/allow-preconfig-test.out  |  0
>  tests/qapi-schema/doc-good.out              |  4 +-
>  tests/qapi-schema/ident-with-escape.out     |  2 +-
>  tests/qapi-schema/indented-expr.out         |  4 +-
>  tests/qapi-schema/qapi-schema-test.json     |  4 +-
>  tests/qapi-schema/qapi-schema-test.out      | 22 ++++-----
>  tests/qapi-schema/test-qapi.py              |  8 ++--
>  tests/qmp-test.c                            | 37 +++++++++++++++
>  tests/test-qmp-cmds.c                       |  2 +-
>  vl.c                                        | 35 ++++++++++++++-
>  35 files changed, 396 insertions(+), 77 deletions(-)
>  create mode 100644 tests/qapi-schema/allow-preconfig-test.err
>  create mode 100644 tests/qapi-schema/allow-preconfig-test.exit
>  create mode 100644 tests/qapi-schema/allow-preconfig-test.json
>  create mode 100644 tests/qapi-schema/allow-preconfig-test.out
> 
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
