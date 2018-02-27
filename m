Received: from eggs.gnu.org ([2001:4830:134:3::10]:60804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqiFF-0008VB-Vw
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqiFC-0000jR-DM
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eqiFC-0000jJ-6W
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4B184040073
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 16:36:45 +0000 (UTC)
Date: Tue, 27 Feb 2018 17:36:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180227173639.7aeea5ce@redhat.com>
In-Reply-To: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Fri, 16 Feb 2018 13:37:12 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

Eric,

Adding you to CC list (git send-mail somehow haven't noticed you in cover letter).

Could you please look at QAPI/QMP parts of this series.

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
> Series allows to configure NUMA mapping at runtime using QMP
> interface. For that to happen it introduces a new '-preconfig' CLI option
> which allows to pause QEMU before machine_init() is run and
> adds new set-numa-node QMP command which in conjunction with
> query-hotpluggable-cpus allows to configure NUMA mapping for cpus.
> 
> Later we can modify other commands to run early, for example device_add.
> I recall SPAPR had problem when libvirt started QEMU with -S and, while it's
> paused, added CPUs with device_add. Intent was to coldplug CPUs (but at that
> stage it's considered hotplug already), so SPAPR had to work around the issue.
> 
> Example of configuration session:
> $QEMU -smp 2 -preconfig ...
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
>     https://github.com/imammedo/qemu.git qmp_preconfig_v3
> 
> Ref to v1:
>     https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03583.html
>     Message-Id: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
>   
> CC: eblake@redhat.com
> CC: armbru@redhat.com
> CC: ehabkost@redhat.com
> CC: pkrempa@redhat.com
> CC: david@gibson.dropbear.id.au
> CC: peter.maydell@linaro.org
> CC: pbonzini@redhat.com
> CC: cohuck@redhat.com
> 
> 
> Igor Mammedov (9):
>   numa: postpone options post-processing till machine_run_board_init()
>   numa: split out NumaOptions parsing into parse_NumaOptions()
>   CLI: add -preconfig option
>   HMP: disable monitor in preconfig state
>   QAPI: allow to specify valid runstates per command
>   tests: extend qmp test with pereconfig checks
>   QMP: permit query-hotpluggable-cpus in preconfig state
>   QMP: add set-numa-node command
>   tests: functional tests for QMP command set-numa-node
> 
>  include/qapi/qmp/dispatch.h             |  5 ++-
>  include/sysemu/numa.h                   |  2 +
>  include/sysemu/sysemu.h                 |  1 +
>  hw/core/machine.c                       |  5 ++-
>  monitor.c                               | 32 +++++++++++++--
>  numa.c                                  | 66 +++++++++++++++++++-----------
>  qapi-schema.json                        | 32 +++++++++++++--
>  qapi/qmp-dispatch.c                     | 39 ++++++++++++++++++
>  qapi/qmp-registry.c                     |  4 +-
>  qapi/run-state.json                     |  9 ++++-
>  qemu-options.hx                         | 11 +++++
>  qmp.c                                   |  5 +++
>  scripts/qapi-commands.py                | 46 ++++++++++++++++-----
>  scripts/qapi-introspect.py              |  2 +-
>  scripts/qapi.py                         | 15 ++++---
>  scripts/qapi2texi.py                    |  2 +-
>  tests/numa-test.c                       | 71 +++++++++++++++++++++++++++++++++
>  tests/qapi-schema/doc-good.out          |  4 +-
>  tests/qapi-schema/ident-with-escape.out |  2 +-
>  tests/qapi-schema/indented-expr.out     |  4 +-
>  tests/qapi-schema/qapi-schema-test.out  | 18 ++++-----
>  tests/qapi-schema/test-qapi.py          |  6 +--
>  tests/qmp-test.c                        | 56 ++++++++++++++++++++++++++
>  vl.c                                    | 35 +++++++++++++++-
>  24 files changed, 401 insertions(+), 71 deletions(-)
> 
