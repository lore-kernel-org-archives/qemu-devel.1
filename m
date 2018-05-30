Received: from eggs.gnu.org ([2001:4830:134:3::10]:46102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9v-0004To-7V
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9s-0008Rx-08
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOA9r-0008RT-Oa
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:16 -0300
Message-Id: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/12] NUMA queue, 2018-05-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The following changes since commit e609fa71e89c81fbe2670411be62da95dfb093e0:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-05-29-v1.for-upstream' into staging (2018-05-29 13:01:11 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/numa-next-pull-request

for you to fetch changes up to c35665e1ee3d4344cd5156430ebc92310635f9bd:

  tests: functional tests for QMP command set-numa-node (2018-05-30 13:19:14 -0300)

----------------------------------------------------------------
NUMA queue, 2018-05-30

* New command-line option: --preconfig
  This option allows pausing QEMU and allow the configuration
  using QMP commands before running board initialization code.
* New QMP set-numa-node, now made possible because of --preconfig
* Small update on -numa error messages

----------------------------------------------------------------

Igor Mammedov (12):
  numa: clarify error message when node index is out of range in -numa
    dist, ...
  numa: postpone options post-processing till machine_run_board_init()
  numa: split out NumaOptions parsing into set_numa_options()
  qapi: introduce preconfig runstate
  hmp: disable monitor in preconfig state
  qapi: introduce new cmd option "allow-preconfig"
  tests: qapi-schema tests for allow-preconfig
  cli: add --preconfig option
  tests: extend qmp test with preconfig checks
  qmp: permit query-hotpluggable-cpus in preconfig state
  qmp: add set-numa-node command
  tests: functional tests for QMP command set-numa-node

 docs/devel/qapi-code-gen.txt                | 11 ++-
 qapi/introspect.json                        |  5 +-
 qapi/misc.json                              | 49 ++++++++++++--
 qapi/run-state.json                         |  8 ++-
 scripts/qapi/commands.py                    | 11 +--
 scripts/qapi/common.py                      | 18 +++--
 scripts/qapi/doc.py                         |  4 +-
 scripts/qapi/introspect.py                  |  7 +-
 include/qapi/qmp/dispatch.h                 |  1 +
 include/sysemu/numa.h                       |  2 +
 include/sysemu/sysemu.h                     |  1 +
 tests/libqtest.h                            |  9 +++
 hw/core/machine.c                           |  5 +-
 monitor.c                                   | 11 ++-
 numa.c                                      | 75 +++++++++++++--------
 qapi/qmp-dispatch.c                         |  8 +++
 qmp.c                                       | 10 +++
 tests/libqtest.c                            |  7 ++
 tests/numa-test.c                           | 61 +++++++++++++++++
 tests/qmp-test.c                            | 40 +++++++++++
 tests/test-qmp-cmds.c                       |  2 +-
 vl.c                                        | 35 +++++++++-
 qemu-options.hx                             | 13 ++++
 qemu-tech.texi                              | 40 +++++++++++
 tests/Makefile.include                      |  1 +
 tests/qapi-schema/allow-preconfig-test.err  |  1 +
 tests/qapi-schema/allow-preconfig-test.exit |  1 +
 tests/qapi-schema/allow-preconfig-test.json |  2 +
 tests/qapi-schema/allow-preconfig-test.out  |  0
 tests/qapi-schema/doc-good.out              |  4 +-
 tests/qapi-schema/ident-with-escape.out     |  2 +-
 tests/qapi-schema/indented-expr.out         |  4 +-
 tests/qapi-schema/qapi-schema-test.json     |  4 +-
 tests/qapi-schema/qapi-schema-test.out      | 22 +++---
 tests/qapi-schema/test-qapi.py              |  8 +--
 35 files changed, 402 insertions(+), 80 deletions(-)
 create mode 100644 tests/qapi-schema/allow-preconfig-test.err
 create mode 100644 tests/qapi-schema/allow-preconfig-test.exit
 create mode 100644 tests/qapi-schema/allow-preconfig-test.json
 create mode 100644 tests/qapi-schema/allow-preconfig-test.out

-- 
2.17.1
