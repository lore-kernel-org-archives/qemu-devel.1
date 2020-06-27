Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA70EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A21720781
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gm2cMMdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A21720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpEOe-0004eD-PZ
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELK-0007kz-W3
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpELH-00070t-IF
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:10:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH23Yf156267;
 Sat, 27 Jun 2020 17:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=O3KrEYe5UkGPUGGhs7rr8EcXQfJfDXd5DMHibEJug0M=;
 b=Gm2cMMdGZS2ny5NCE4JtChIyyCDWZgoNExfXglulQ6h5F+ES18SktLRgSdD9EL9NYTu4
 widCzFVXgw5Hqv1PypuapQKDzc+zSmIygNycVck54IxhHHDOFhViKgL41LRQCB67WoY+
 PHkkcVJjOBIdrzhRVoMWIHFPMkYN1M7cdns4SJ2Yk8PPyT0wFc+JjJvR/l5SD/OIsWkR
 KcpzSOcR1WXFx371dApVw3D3ozWMLBYtEucUDoxizFnWlkOVV9E6AqUaeEgVsDymMZpP
 nTaoTzcUSIvz5q4f1fZWjy2wEIAkNmvQhrsa77iapVKJQcjKJfZaFDY1nz6k0QMxpDWH 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 31wx2m9awt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:09:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8Pl2102150;
 Sat, 27 Jun 2020 17:09:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 31wwx17sa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:09:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RH9kuS030503;
 Sat, 27 Jun 2020 17:09:46 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:09:45 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/21] Initial support for multi-process qemu
Date: Sat, 27 Jun 2020 10:09:22 -0700
Message-Id: <cover.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 impostorscore=0 cotscore=-2147483648 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006270123
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This is the v7 of the patchset.
Thank you very much for the detailed feedback for v6. We appreciate your time.

We have addressed the latest comments and suggestions that were
provided on v6 patch series and incorporated to this patchset.

This is the list of changes for v7:
 - QEMU & remote process share the same binary.
   This allowed us to reduce the number of patches as well.

 - We introduced the machine type "remote" that drives the remote process
   initialization.

 - v7 now uses QIOChannel for communication and descriptors management.

 - The remote process uses the main loop instead of a separate loop.

 - Co-routines support in the QEMU Proxy-remote process communication
   The communication model based on co-routines needs some more work and
   we would like to hear your take on it.
   Stefan has shared some ideas how we can proceed and we will take this
   to the next version after additional discussion.
   We did not implement the protocol to listen and accept new connections.

There are other changes that were incorporated from the feedback we have
received on v6.

We posted the Proof Of Concept patches [2] before the BoF session in 2018.
Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5], RFC v4 [6],
v5 [7] and v6 [8] of the patch series.
Following people contributed to this patchset:

John G Johnson <john.g.johnson@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>
Konrad Wilk <konrad.wilk@oracle.com>

Also we would like to thank QEMU community for your help, suggestions
and reviewing this large series of patches.

For the full concept writeup about QEMU multi-process, please refer to
docs/devel/qemu-multiprocess.rst. Also see docs/qemu-multiprocess.txt for
usage information.

We will post separate patchsets for the following improvements for
the experimental Qemu multi-process:
 - Live migration;
 - communication channel improvements;

We welcome all your ideas, concerns, and questions for this patchset.

[1]: http://events17.linuxfoundation.org/sites/events/files/slides/KVM%20FORUM%20multi-process.pdf
[1]: https://www.youtube.com/watch?v=Kq1-coHh7lg
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
[5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
[6]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg655118.html
[7]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg682429.html
[8]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg697484.html

Elena Ufimtseva (9):
  multi-process: add qio channel function to transmit
  multi-process: define MPQemuMsg format and transmission functions
  multi-process: add co-routines to communicate with remote
  multi-process: Initialize communication channel at the remote end
  multi-process: introduce proxy object
  multi-process: Forward PCI config space acceses to the remote process
  multi-process: heartbeat messages to remote
  multi-process: perform device reset in the remote process
  multi-process: add configure and usage information

Jagannathan Raman (11):
  memory: alloc RAM from file at offset
  multi-process: Add config option for multi-process QEMU
  multi-process: setup PCI host bridge for remote device
  multi-process: setup a machine object for remote device process
  multi-process: Initialize message handler in remote device
  multi-process: setup memory manager for remote device
  multi-process: Connect Proxy Object with device in the remote process
  multi-process: PCI BAR read/write handling for proxy & remote
    endpoints
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Retrieve PCI info from remote process

John G Johnson (1):
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess

 MAINTAINERS                          |  24 +
 backends/hostmem-memfd.c             |   2 +-
 configure                            |  11 +
 docs/devel/index.rst                 |   1 +
 docs/devel/multi-process.rst         | 957 +++++++++++++++++++++++++++
 docs/multi-process.rst               |  71 ++
 exec.c                               |  11 +-
 hw/Makefile.objs                     |   1 +
 hw/i386/Makefile.objs                |   3 +
 hw/i386/remote-memory.c              |  58 ++
 hw/i386/remote-msg.c                 | 301 +++++++++
 hw/i386/remote.c                     |  99 +++
 hw/misc/ivshmem.c                    |   3 +-
 hw/pci-host/Makefile.objs            |   1 +
 hw/pci-host/remote.c                 |  63 ++
 hw/pci/Makefile.objs                 |   2 +
 hw/pci/memory-sync.c                 | 214 ++++++
 hw/pci/proxy.c                       | 436 ++++++++++++
 hw/remote/Makefile.objs              |   1 +
 hw/remote/iohub.c                    | 153 +++++
 include/exec/memory.h                |   2 +
 include/exec/ram_addr.h              |   2 +-
 include/hw/i386/remote-memory.h      |  20 +
 include/hw/i386/remote.h             |  38 ++
 include/hw/pci-host/remote.h         |  34 +
 include/hw/pci/memory-sync.h         |  30 +
 include/hw/pci/pci_ids.h             |   3 +
 include/hw/pci/proxy.h               |  69 ++
 include/hw/remote/iohub.h            |  50 ++
 include/io/channel.h                 |  24 +
 include/io/mpqemu-link.h             | 140 ++++
 include/qemu/mmap-alloc.h            |   3 +-
 io/Makefile.objs                     |   2 +
 io/channel.c                         |  45 ++
 io/mpqemu-link.c                     | 277 ++++++++
 memory.c                             |   3 +-
 scripts/mpqemu-launcher-perf-mode.py |  67 ++
 scripts/mpqemu-launcher.py           |  47 ++
 util/mmap-alloc.c                    |   7 +-
 util/oslib-posix.c                   |   2 +-
 40 files changed, 3264 insertions(+), 13 deletions(-)
 create mode 100644 docs/devel/multi-process.rst
 create mode 100644 docs/multi-process.rst
 create mode 100644 hw/i386/remote-memory.c
 create mode 100644 hw/i386/remote-msg.c
 create mode 100644 hw/i386/remote.c
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 hw/pci/memory-sync.c
 create mode 100644 hw/pci/proxy.c
 create mode 100644 hw/remote/Makefile.objs
 create mode 100644 hw/remote/iohub.c
 create mode 100644 include/hw/i386/remote-memory.h
 create mode 100644 include/hw/i386/remote.h
 create mode 100644 include/hw/pci-host/remote.h
 create mode 100644 include/hw/pci/memory-sync.h
 create mode 100644 include/hw/pci/proxy.h
 create mode 100644 include/hw/remote/iohub.h
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c
 create mode 100644 scripts/mpqemu-launcher-perf-mode.py
 create mode 100755 scripts/mpqemu-launcher.py

-- 
2.25.GIT


