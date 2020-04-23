Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E04FC55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286462075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9ruP4/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286462075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35229 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTHN-0001bv-7q
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTG0-0007ru-KI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTFx-0006BL-6R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTFw-00061e-Lw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CxVR131686;
 Thu, 23 Apr 2020 04:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=0OSuwiSQ0zoJd4yBn7C2OmweJRh5l80x9QLIRxd3QDI=;
 b=X9ruP4/IVb5HH67TSTG2Z02hGv4lbUgH6cRZQI1e2O7LD3GZrQfTLKasO78q0T9DS6ol
 8TMKV0X7RvW0OintqgBm0Gf7BvEQGeP0wQVwq5jDiV/SWDGn1Vv1V5LgHEmITcwck6fs
 sVOPXjRZiMZ4EeT/xOIOo5xi9U0TId6M1Wjk6fKNbTcCwy3eO1W/iZAc7cYw+9fX1cLO
 c6V7cwt52rjlpsCnYcqw8taaQrxnMV1HiF7qBr0JwLNucfLsa8F6LX+UnI312TJPZ2gB
 h86HQzNpVR4zjSNyBWj7Fq727IESRMkRUoUKSH5iWQHCJGUCzNkcMkFQ10nx2nP4HuDC Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 30jvq4s8xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CaP5157055;
 Thu, 23 Apr 2020 04:14:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 30gbbjtvnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EFQP017518;
 Thu, 23 Apr 2020 04:14:15 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:14 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Date: Wed, 22 Apr 2020 21:13:35 -0700
Message-Id: <cover.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Hello

This is a resend of v6 patchset since we regrettably omitted few comments
from v5 review in the previously sent series 
(see in https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00828.html).
We also run more tests and fixed the build errors that were found in v6.

Started with the presentation in October 2017 made by Marc-Andre (Red Hat)
and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 2018,
the multi-process project is now available and presented in this patchset.
This first series enables the emulation of lsi53c895a in a separate process.

We posted the Proof Of Concept patches [2] before the BoF session in 2018.
Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5], RFC v4 [6]
and v5 [7] of the patch series.

This is v6 of the patch series and it addresses the previous feedback from
the community.
To make easier to review of the series, we have separated out some of the
patches and will send them in the separate series. As per conversation we
had during the last community call, the live migration support is taken out
from this series as well as asynchronous communication.
The changes include the elimination of fork/exec of the remote process
and instead using the orchestrator which is implemented in this series as
a python script.

Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>
Konrad Wilk <konrad.wilk@oracle.com>

For full concept writeup about QEMU disaggregation, refer to
docs/devel/qemu-multiprocess.rst. Please refer to
docs/qemu-multiprocess.txt for usage information.

We will post separate patchsets for the following improvements for
the experimental Qemu multi-process:
 - Live migration;
 - Asynchronous communication channel;
 - Libvirt support;

We welcome all your ideas, concerns, and questions for this patchset.

Testing results

There is an error in travis-ci build test which does not get reproduced.

 TEST    iotest-qcow2: 041 [fail]
QEMU          -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/../../qemu-img" 
QEMU_IO       -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/../../qemu-nbd" 
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 travis-job-fc4e2553-b470-4a8b-812e-a4fcf8ba094f 5.0.0-1031-gcp
TEST_DIR      -- /home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.LOmYANt5Od
SOCKET_SCM_HELPER -- /home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/socket_scm_helper
--- /home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotests/041.out	2020-04-22 00:17:23.701844698 +0000
+++ /home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/041.out.bad	2020-04-22 00:24:39.234343858 +0000
@@ -1,5 +1,29 @@
-..............................................................................................
+........................FF....................................................................
+======================================================================
+FAIL: test_with_other_parent (__main__.TestRepairQuorum)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1049, in test_with_other_parent
+    self.assert_qmp(result, 'return', {})
+  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotests/iotests.py", line 821, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotests/iotests.py", line 797, in dictpath
+    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
+AssertionError: failed path traversal for "return" in "{'error': {'class': 'GenericError', 'desc': "UNIX socket path '/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/scratch/nbd.sock' is too long"}}"
a
+
Not run: 220 259
Failures: 041
Failed 1 of 116 iotests
/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/Makefile.include:848: recipe for target 'check-tests/check-block.sh' failed
make: *** [check-tests/check-block.sh] Error 1
The command "if [ "$BUILD_RC" -eq 0 ] ; then
    ${TEST_CMD} ;
else
    $(exit $BUILD_RC);
fi


Thank you!

[1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf
[1]: https://www.youtube.com/watch?v=Kq1-coHh7lg
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
[5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
[6]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg655118.html
[7]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg682429.html

 -- 
2.25.GIT


Elena Ufimtseva (18):
  multi-process: Refactor machine_init and exit notifiers
  command-line: refractor parser code
  multi-process: Refactor chardev functions out of vl.c
  multi-process: Refactor monitor functions out of vl.c
  multi-process: add a command line option for debug file
  multi-process: introduce proxy object
  multi-process: Forward PCI config space acceses to the remote process
  multi-process: Introduce build flags to separate remote process code
  multi-process: add parse_cmdline in remote process
  multi-process: add support to parse device option
  multi-process: send heartbeat messages to remote
  multi-process: handle heartbeat messages in remote process
  multi-process: perform device reset in the remote process
  multi-process/mon: choose HMP commands based on target
  multi-process/mon: stub functions to enable QMP module for remote
    process
  multi-process/mon: enable QMP module support in the remote process
  multi-process/mon: Initialize QMP module for remote processes
  multi-process: add configure and usage information

Jagannathan Raman (17):
  memory: alloc RAM from file at offset
  monitor: destaticize HMP commands
  multi-process: Add stub functions to facilitate build of multi-process
  multi-process: Add config option for multi-process QEMU
  multi-process: build system for remote device process
  multi-process: define mpqemu-link object
  multi-process: add functions to synchronize proxy and remote endpoints
  multi-process: setup PCI host bridge for remote device
  multi-process: setup a machine object for remote device process
  multi-process: setup memory manager for remote device
  multi-process: remote process initialization
  multi-process: Initialize Proxy Object's communication channel
  multi-process: Connect Proxy Object with device in the remote process
  multi-process: PCI BAR read/write handling for proxy & remote
    endpoints
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Retrieve PCI info from remote process

John G Johnson (1):
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess

 MAINTAINERS                          |  39 ++
 Makefile                             |   2 +
 Makefile.objs                        |  41 ++
 Makefile.target                      | 104 ++-
 accel/Makefile.objs                  |   2 +
 accel/stubs/kvm-stub.c               |   5 +
 accel/stubs/tcg-stub.c               | 108 +++
 backends/Makefile.objs               |   2 +
 block/Makefile.objs                  |   5 +
 block/monitor/Makefile.objs          |   2 +
 chardev/char.c                       |  14 +
 configure                            |  15 +
 docs/devel/index.rst                 |   1 +
 docs/devel/multi-process.rst         | 957 +++++++++++++++++++++++++++
 docs/multi-process.rst               |  85 +++
 exec.c                               |  31 +-
 hmp-commands-info.hx                 |  10 +
 hmp-commands.hx                      |  25 +-
 hw/Makefile.objs                     |   7 +
 hw/block/Makefile.objs               |   2 +
 hw/core/Makefile.objs                |  19 +
 hw/nvram/Makefile.objs               |   2 +
 hw/pci/Makefile.objs                 |   4 +
 hw/proxy/memory-sync.c               | 217 ++++++
 hw/proxy/qemu-proxy.c                | 488 ++++++++++++++
 hw/scsi/Makefile.objs                |   2 +
 include/chardev/char.h               |   2 +
 include/exec/address-spaces.h        |   2 +
 include/exec/ram_addr.h              |   4 +-
 include/hw/pci/pci_ids.h             |   3 +
 include/hw/proxy/memory-sync.h       |  37 ++
 include/hw/proxy/qemu-proxy.h        |  79 +++
 include/io/mpqemu-link.h             | 192 ++++++
 include/monitor/monitor.h            |   3 +
 include/qemu-common.h                |   8 +
 include/qemu-parse.h                 |  42 ++
 include/qemu/log.h                   |   1 +
 include/qemu/mmap-alloc.h            |   3 +-
 include/remote/iohub.h               |  50 ++
 include/remote/machine.h             |  32 +
 include/remote/memory.h              |  20 +
 include/remote/pcihost.h             |  45 ++
 include/sysemu/sysemu.h              |   2 +
 io/Makefile.objs                     |   2 +
 io/mpqemu-link.c                     | 407 ++++++++++++
 memory.c                             |   2 +-
 migration/Makefile.objs              |   2 +
 monitor/Makefile.objs                |   4 +
 monitor/misc.c                       |  84 +--
 monitor/monitor-internal.h           |  38 ++
 monitor/monitor.c                    |  37 ++
 qapi/Makefile.objs                   |   2 +
 qemu-parse.c                         |  93 +++
 qom/Makefile.objs                    |   4 +
 remote/Makefile.objs                 |   6 +
 remote/iohub.c                       | 148 +++++
 remote/machine.c                     |  99 +++
 remote/memory.c                      |  63 ++
 remote/pcihost.c                     |  64 ++
 remote/remote-common.h               |  21 +
 remote/remote-main.c                 | 379 +++++++++++
 remote/remote-opts.c                 |  96 +++
 remote/remote-opts.h                 |  15 +
 rules.mak                            |   2 +-
 scripts/hxtool                       |  35 +-
 scripts/mpqemu-launcher-perf-mode.py |  92 +++
 scripts/mpqemu-launcher.py           |  53 ++
 softmmu/vl.c                         | 175 +----
 stubs/Makefile.objs                  |   3 +
 stubs/audio.c                        |  12 +
 stubs/gdbstub.c                      |  23 +
 stubs/get-fd.c                       |  10 +
 stubs/machine-init-add.c             |   7 +
 stubs/machine-init-done.c            |   5 +-
 stubs/machine-init-remove.c          |   8 +
 stubs/migration.c                    | 162 +++++
 stubs/monitor.c                      |  85 ++-
 stubs/net-stub.c                     | 100 +++
 stubs/qapi-misc.c                    |  41 ++
 stubs/qapi-target.c                  |  56 ++
 stubs/replay.c                       |  18 +
 stubs/ui-stub.c                      | 130 ++++
 stubs/vl-stub.c                      | 171 +++++
 stubs/vmstate.c                      |  19 +
 stubs/xen-mapcache.c                 |  22 +
 ui/Makefile.objs                     |   2 +
 util/Makefile.objs                   |   2 +
 util/log.c                           |   2 +
 util/machine-notify.c                |  69 ++
 util/mmap-alloc.c                    |   7 +-
 util/oslib-posix.c                   |   2 +-
 91 files changed, 5356 insertions(+), 237 deletions(-)
 create mode 100644 docs/devel/multi-process.rst
 create mode 100644 docs/multi-process.rst
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/memory-sync.h
 create mode 100644 include/hw/proxy/qemu-proxy.h
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 include/qemu-parse.h
 create mode 100644 include/remote/iohub.h
 create mode 100644 include/remote/machine.h
 create mode 100644 include/remote/memory.h
 create mode 100644 include/remote/pcihost.h
 create mode 100644 io/mpqemu-link.c
 create mode 100644 qemu-parse.c
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/iohub.c
 create mode 100644 remote/machine.c
 create mode 100644 remote/memory.c
 create mode 100644 remote/pcihost.c
 create mode 100644 remote/remote-common.h
 create mode 100644 remote/remote-main.c
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h
 mode change 100644 => 100755 scripts/hxtool
 create mode 100755 scripts/mpqemu-launcher-perf-mode.py
 create mode 100755 scripts/mpqemu-launcher.py
 create mode 100644 stubs/audio.c
 create mode 100644 stubs/get-fd.c
 create mode 100644 stubs/machine-init-add.c
 create mode 100644 stubs/machine-init-remove.c
 create mode 100644 stubs/migration.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/qapi-misc.c
 create mode 100644 stubs/qapi-target.c
 create mode 100644 stubs/ui-stub.c
 create mode 100644 stubs/vl-stub.c
 create mode 100644 stubs/xen-mapcache.c
 create mode 100644 util/machine-notify.c

-- 
2.25.GIT


