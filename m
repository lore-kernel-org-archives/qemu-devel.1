Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31753C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB2A208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNwG9hvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB2A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwDM-0006WB-Pn
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcw9t-0004jR-9b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcw9r-0000eo-FY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcw9r-0000bU-6m
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8wY5149305;
 Mon, 17 Jun 2019 18:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=QbSk5s4aisCoGCx8YyArJszy8dygKFQnsVU6YOirmf8=;
 b=oNwG9hvEQuC6TjeR+CYaPwiSV3wtqypozcxiNq9BwVTtfsk6oiekj5Dz/B0/nj0MheAs
 s3GHnGijMW4Ck47C6BXK9N9IijjY75+h/hMtci8dh3ozTI0oL81X1dd2On02wgIQ7zti
 4NYYQ722H5YgEohsVX17O04MIyULBDpqDZRq8UT3fNoessclVxQ7MwcvpwKDj0vdYmIV
 1ZrcYM6WevU8CziHvHZIHcB+/aDeoHJiS8xHp4a1gj4RdaOREKX/HoHbFv+KuSxOMivl
 C6oIyczvLgK8Q9oLyPxtmceNfkqdcN0KXlKeuDaY0Lo4EM8GXl2lp5ZUNEZmLIFWJT2t tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIEQ1b175589;
 Mon, 17 Jun 2019 18:15:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2t5mgbga5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIExRY014090;
 Mon, 17 Jun 2019 18:14:59 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:14:59 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:14:50 -0700
Message-Id: <20190617181450.29092-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 00/35] Initial support of multi-process
 qemu
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Initial support of multi-process qemu

Started with the presentation in October 2017 made by
Marc-Andre (Red Hat) and Konrad Wilk (Oracle)
(http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf,
https://www.youtube.com/watch?v=Kq1-coHh7lg) and
continued in the BoF session at the KVM forum in 2018 with Jag leading
the discussion, the multi-process project is now in the prototype version
and presented by this patchset.

The proof of the concept patches were posted on the qemu-devel mailing
list before the BoF session at the KVM forum and can be found here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html

This series presents the initial support for QEMU that can
launch some of the devices in the remote processes.

Thanks to a v1 review and some of the question Stefan and Daniel asked, we
were able to incorporate your ideas into our goals.

We would like to present version 2 of the patchset.
This version has addressed comments made during the review of v1 and includes:

- support for libvirt fork/exec of remote processes;
  QEMU is still capable of fork/execing the remote processes unless its disabled
  by seccomp.
  When using libvirt, the daemon will spawn remote processes and pass the communication
  file descriptors to main QEMU process and the remote processes.
  The libvirt patches are in the making and will be sent out shortly;
- using existing -device/-drive command line options to specify remote devices with
  additional suboptons;
- refractor message sending code;
- remove specific HMP/QMP commands and use the one that exist now;
- extend existing QMP commands;
- added timeout to communication channel;

Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>

For full concept writeup about QEMU disaggregation refer to
docs/devel/qemu-multiprocess.txt.

This series has a limited scope and allows QEMU to launch
LSI SCSI controller emulation in the separate process and
execute HMP commands to manipulate the devices.
This series with appropriate libvirt patches allows to
launch a guest with remote processes using libvirt.
(libvirt patches will be posted and will be reflected in the reply to
this patch).

Please refer to the docs/qemu-multiprocess.txt for usage
information.

his series is based on qemu upstream commit
3284aa128153750f14a61e8a96fd085e6f2999b6.

TODO items:
  - bus support for remote process (non-default);
  - live migration;
  - performance improvements;
  - support for more devices;
  - support for seccomp for remote processes;
  - support for CPU disaggregated emulation;

We would like to welcome all your ideas, concerns and questions
for this patchset.

Thank you!

Elena Ufimtseva (13):
  multi-process: add a command line option for debug file
  multi-process: introduce proxy object
  multi-process: store info about the remote process
  multi-process: configure remote side devices
  multi-process: add qdev_proxy_add to create proxy devices
  multi-process: remote: add setup_devices and setup_drive msg
    processing
  multi-process: remote: use fd for socket from parent process
  multi-process: remote: add create_done condition
  multi-process: add processing of remote drive and device command line
  multi-process: add heartbeat timer and signal handler
  multi-process: handle heartbit messages in remote process
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess
  multi-process: add configure and usage information

Jagannathan Raman (22):
  multi-process: memory: alloc RAM from file at offset
  multi-process: util: Add qemu_thread_cancel() to cancel running thread
  multi-process: Add stub functions to facilate build of multi-process
  multi-process: Add config option for multi-process QEMU
  multi-process: build system for remote device process
  multi-process: define proxy-link object
  multi-process: add functions to synchronize proxy and remote endpoints
  multi-process: setup PCI host bridge for remote device
  multi-process: setup a machine object for remote device process
  multi-process: setup memory manager for remote device
  multi-process: remote process initialization
  multi-process: PCI BAR write handling for proxy & remote endpoints
  multi-process: PCI BAR read handling for proxy & remote endpoints
  multi-process: Add LSI device proxy object
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Add QMP & extend HMP commands to list remote info
  multi-process: Extend monitor commands to add a device to remote
    process
  multi-process: Extend monitor commands to remove device from remote
    process
  multi-process: Extend drive_add to add drive to remote device
  multi-process: Extend drive_del command to delete drive from remote
    process
  multi-process: Extend block_resize command to support remote block
    device

 Makefile                            |    5 +-
 Makefile.objs                       |   22 +
 Makefile.target                     |   55 +-
 accel/stubs/kvm-stub.c              |    5 +
 accel/stubs/tcg-stub.c              |   85 ++
 backends/Makefile.objs              |    2 +
 block/Makefile.objs                 |    2 +
 blockdev.c                          |   24 +
 configure                           |   11 +
 device-hotplug.c                    |    7 +
 docs/devel/qemu-multiprocess.txt    | 1137 +++++++++++++++++++++++++++
 docs/qemu-multiprocess.txt          |   59 ++
 exec.c                              |   12 +-
 hmp-commands-info.hx                |   16 +
 hmp-commands.hx                     |    9 +-
 hmp.c                               |   25 +
 hmp.h                               |    2 +
 hw/Makefile.objs                    |    9 +
 hw/block/Makefile.objs              |    2 +
 hw/core/Makefile.objs               |   14 +
 hw/core/machine.c                   |   12 +
 hw/nvram/Makefile.objs              |    2 +
 hw/pci/Makefile.objs                |    4 +
 hw/proxy/Makefile.objs              |    3 +
 hw/proxy/memory-sync.c              |  214 +++++
 hw/proxy/monitor.c                  |  296 +++++++
 hw/proxy/proxy-lsi53c895a.c         |  162 ++++
 hw/proxy/qemu-proxy.c               |  509 ++++++++++++
 hw/scsi/Makefile.objs               |    2 +
 include/exec/address-spaces.h       |    2 +
 include/exec/ram_addr.h             |    2 +-
 include/glib-compat.h               |    4 +
 include/hw/boards.h                 |    4 +
 include/hw/pci/pci_ids.h            |    3 +
 include/hw/proxy/memory-sync.h      |   51 ++
 include/hw/proxy/proxy-lsi53c895a.h |   42 +
 include/hw/proxy/qemu-proxy.h       |  101 +++
 include/hw/qdev-core.h              |    1 +
 include/io/proxy-link.h             |  189 +++++
 include/monitor/qdev.h              |    8 +
 include/qemu/log.h                  |    1 +
 include/qemu/mmap-alloc.h           |    2 +-
 include/qemu/thread.h               |    1 +
 include/remote/iohub.h              |   63 ++
 include/remote/machine.h            |   48 ++
 include/remote/memory.h             |   34 +
 include/remote/pcihost.h            |   58 ++
 include/sysemu/blockdev.h           |    5 +
 include/sysemu/sysemu.h             |    1 +
 io/Makefile.objs                    |    2 +
 io/proxy-link.c                     |  317 ++++++++
 memory.c                            |    2 +-
 migration/Makefile.objs             |    2 +
 qapi/block-core.json                |   29 +
 qdev-monitor.c                      |  188 ++++-
 qom/Makefile.objs                   |    4 +
 remote/Makefile.objs                |    4 +
 remote/iohub.c                      |  159 ++++
 remote/machine.c                    |  141 ++++
 remote/memory.c                     |   98 +++
 remote/pcihost.c                    |   84 ++
 remote/remote-main.c                |  582 ++++++++++++++
 stubs/machine-init-done.c           |    4 +
 stubs/monitor.c                     |   41 +
 stubs/net-stub.c                    |   31 +
 stubs/replay.c                      |   14 +
 stubs/vl-stub.c                     |   75 ++
 stubs/vmstate.c                     |   20 +
 stubs/xen-mapcache.c                |   22 +
 util/log.c                          |    2 +
 util/mmap-alloc.c                   |    5 +-
 util/oslib-posix.c                  |    2 +-
 util/qemu-thread-posix.c            |   10 +
 vl.c                                |   68 +-
 74 files changed, 5211 insertions(+), 22 deletions(-)
 create mode 100644 docs/devel/qemu-multiprocess.txt
 create mode 100644 docs/qemu-multiprocess.txt
 create mode 100644 hw/proxy/Makefile.objs
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 hw/proxy/monitor.c
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 hw/proxy/qemu-proxy.c
 create mode 100644 include/hw/proxy/memory-sync.h
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h
 create mode 100644 include/hw/proxy/qemu-proxy.h
 create mode 100644 include/io/proxy-link.h
 create mode 100644 include/remote/iohub.h
 create mode 100644 include/remote/machine.h
 create mode 100644 include/remote/memory.h
 create mode 100644 include/remote/pcihost.h
 create mode 100644 io/proxy-link.c
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/iohub.c
 create mode 100644 remote/machine.c
 create mode 100644 remote/memory.c
 create mode 100644 remote/pcihost.c
 create mode 100644 remote/remote-main.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/vl-stub.c
 create mode 100644 stubs/xen-mapcache.c

-- 
2.17.1


