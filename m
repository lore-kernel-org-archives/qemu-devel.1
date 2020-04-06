Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF4CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCE02051A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qC9nLO7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCE02051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOHN-00038j-CN
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGP-0001Pl-Ba
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGN-00020Y-69
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGL-0001uM-US
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:41:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369djkY069588;
 Mon, 6 Apr 2020 09:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=1vG8nPadPXCYa5SLbvgM/jZSpaQqX017seb/POgr24c=;
 b=qC9nLO7rt+FYH6/zOjwEaha4QKxcZwVTFEa+GhhNsEmZuCJXCuUXw0w9dsSn09Ku6+Mi
 QJnnlZ61dAfcx5PxRZp3iBUG+pR5WvYDVjKe2rZRCEhHjm0PFp6qDcTctv4cHud7UPQV
 mhy1XAsefKx3yZiBHS/y+fX9NIkn0AcNa7pubFq3ldBtvtDlbnaGraNQD5Sc9MEt5AZL
 gPqd12kuC/Q73bVxgzMAD2mgM2T34rJPJaDD+4EdavUGblDE2ag6HgOsyERFrsQRwWeO
 vE++aqokCJBy5xa3wR3I7eTDCs5xXF4xq9WA44NtY5Oru1DYZilgYHRA2jJ6+0r7XRsl kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 306j6m5t9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369ciqI092283;
 Mon, 6 Apr 2020 09:41:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073spk5bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369fUs3031623;
 Mon, 6 Apr 2020 09:41:30 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:29 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/36] Initial support for multi-process qemu
Date: Mon,  6 Apr 2020 02:40:50 -0700
Message-Id: <cover.1586165555.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
patches and will send them in the separate series. As per converstaion we
had during the last community call, the live migration support is taken out
from this series as well as asynchronous communication.
The changes include the elimination of fork/exec of the remote process
and instead using the launcher which is implemented in this series as
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

Thank you!

[1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf
[1]: https://www.youtube.com/watch?v=Kq1-coHh7lg
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
[5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
[6]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg655118.html
[7]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg682429.html

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
  multi-process: Add stub functions to facilate build of multi-process
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

 MAINTAINERS                          |   35 +
 Makefile                             |    2 +
 Makefile.objs                        |   41 +
 Makefile.target                      |  104 ++-
 accel/Makefile.objs                  |    2 +
 accel/stubs/kvm-stub.c               |    5 +
 accel/stubs/tcg-stub.c               |  108 +++
 backends/Makefile.objs               |    2 +
 block/Makefile.objs                  |    5 +
 block/monitor/Makefile.objs          |    2 +
 chardev/char.c                       |   14 +
 configure                            |   15 +
 docs/devel/index.rst                 |    1 +
 docs/devel/multi-process.rst         | 1102 ++++++++++++++++++++++++++
 docs/multi-process.rst               |   85 ++
 exec.c                               |   31 +-
 hmp-commands-info.hx                 |   10 +
 hmp-commands.hx                      |   25 +-
 hw/Makefile.objs                     |    7 +
 hw/block/Makefile.objs               |    2 +
 hw/core/Makefile.objs                |   19 +
 hw/nvram/Makefile.objs               |    2 +
 hw/pci/Makefile.objs                 |    4 +
 hw/proxy/memory-sync.c               |  212 +++++
 hw/proxy/qemu-proxy.c                |  488 ++++++++++++
 hw/scsi/Makefile.objs                |    2 +
 include/chardev/char.h               |    2 +
 include/exec/address-spaces.h        |    2 +
 include/exec/ram_addr.h              |    4 +-
 include/hw/pci/pci_ids.h             |    3 +
 include/hw/proxy/memory-sync.h       |   37 +
 include/hw/proxy/qemu-proxy.h        |   79 ++
 include/io/mpqemu-link.h             |  192 +++++
 include/monitor/monitor.h            |    3 +
 include/qemu-common.h                |    8 +
 include/qemu-parse.h                 |   42 +
 include/qemu/log.h                   |    1 +
 include/qemu/mmap-alloc.h            |    3 +-
 include/remote/iohub.h               |   50 ++
 include/remote/machine.h             |   32 +
 include/remote/memory.h              |   20 +
 include/remote/pcihost.h             |   45 ++
 include/sysemu/sysemu.h              |    2 +
 io/Makefile.objs                     |    2 +
 io/mpqemu-link.c                     |  387 +++++++++
 memory.c                             |    2 +-
 migration/Makefile.objs              |    2 +
 monitor/Makefile.objs                |    4 +
 monitor/misc.c                       |   84 +-
 monitor/monitor-internal.h           |   38 +
 monitor/monitor.c                    |   37 +
 qapi/Makefile.objs                   |    2 +
 qemu-parse.c                         |   93 +++
 qom/Makefile.objs                    |    4 +
 remote/Makefile.objs                 |    5 +
 remote/iohub.c                       |  148 ++++
 remote/machine.c                     |   99 +++
 remote/memory.c                      |   63 ++
 remote/pcihost.c                     |   64 ++
 remote/remote-main.c                 |  350 ++++++++
 remote/remote-opts.c                 |   96 +++
 remote/remote-opts.h                 |   15 +
 rules.mak                            |    2 +-
 scripts/hxtool                       |   35 +-
 scripts/mpqemu-launcher-perf-mode.py |   93 +++
 scripts/mpqemu-launcher.py           |   54 ++
 softmmu/vl.c                         |  173 +---
 stubs/audio.c                        |   12 +
 stubs/gdbstub.c                      |   23 +
 stubs/machine-init-done.c            |   12 +
 stubs/migration.c                    |  162 ++++
 stubs/monitor.c                      |   85 ++
 stubs/net-stub.c                     |  100 +++
 stubs/qapi-misc.c                    |   41 +
 stubs/qapi-target.c                  |   56 ++
 stubs/replay.c                       |   18 +
 stubs/ui-stub.c                      |  130 +++
 stubs/vl-stub.c                      |  171 ++++
 stubs/vmstate.c                      |   19 +
 stubs/xen-mapcache.c                 |   22 +
 ui/Makefile.objs                     |    2 +
 util/Makefile.objs                   |    2 +
 util/log.c                           |    2 +
 util/machine-notify.c                |   67 ++
 util/mmap-alloc.c                    |    7 +-
 util/oslib-posix.c                   |    2 +-
 86 files changed, 5406 insertions(+), 229 deletions(-)
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
 create mode 100644 remote/remote-main.c
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h
 mode change 100644 => 100755 scripts/hxtool
 create mode 100755 scripts/mpqemu-launcher-perf-mode.py
 create mode 100755 scripts/mpqemu-launcher.py
 create mode 100644 stubs/audio.c
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


