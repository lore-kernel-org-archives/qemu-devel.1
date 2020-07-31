Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036F922B3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dok2bif7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036F922B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zg6-0003UV-8F
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeN-0001kz-S9
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeL-0005JY-1v
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:20:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIBpw6069896;
 Fri, 31 Jul 2020 18:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/HdUmbh/uFpS2vqfh+Za/6q69dGZN5wcnvZ4PjpM6v8=;
 b=dok2bif7EXPtqqrOvHWrjk2EvPcXvhUmaCN1IL6hS3AARNcwm5GTGjs/HhukKTE4wtc3
 jJ24h6JII5zvxD7h2J81zVSvDjiIu3kFdACgzPPWAILmSxyw5R2vLDog8fgd+cFvVfQf
 y3kVjKKgkwb0WRz7V/7bda5zA4PncgARmV9aN5oDDea06mzVsjuPKFF/V45EbuuHOQVn
 1YbEs9ZUvO7Q9KDasWlCBXlvlERZ0HlJjqN7Y53ava4U4A4xIS1NbkYF+Gwa5+tLGt62
 1QO2FSsiEo2jg4+tr8nmbhuBomRX7PJwnM2EF3LmYztkqyEJfJzS5J2j+uPk1bdRweJH Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 32mf702u7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIHVCT073987;
 Fri, 31 Jul 2020 18:20:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 32hu606s53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VIKaoL013127;
 Fri, 31 Jul 2020 18:20:36 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:36 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/20] Initial support for multi-process qemu
Date: Fri, 31 Jul 2020 14:20:07 -0400
Message-Id: <cover.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello

This is the v8 of the patchset. Thank you very much for the
detailed feedback for v7. We appreciate your time. We believe
we have address all the comments for v7 in the current series.

The broader items we have addressed in this series are as follows:
- Removed the main channel / control channel.
- Enabled 1:1 mapping between irqfd:PCIDevice, moving away from
  shared interrupt lines to avoid collision between irqfds
- Defined an object type named “remote-object” that connects the
  device with its fd in the remote process. This object limits the
  number of remote devices to 1 per process to alleviate security
  concerns with multiple devices per process. We are addressing the
  authentication mechanism for multiple devices in the
  VFIO-over-socket proposal.

To touch upon the brief history of this project, we posted the
Proof Of Concept patches before the BoF session in 2018.
Subsequently, we posted RFC v1 [1], RFC v2 [2], RFC v3 [3],
RFC v4 [4], v5 [5], v6 [6] and v7 [7] of the patch series.
Following people contributed to the design and
implementation of this project:

Stefan Hajnoczi <stefanha@redhat.com>
Konrad Wilk <konrad.wilk@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>
John G Johnson <john.g.johnson@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
Jagannathan Raman <jag.raman@oracle.com>


We would like to thank QEMU community for your feedback in the
design and implementation of this project.

For the full concept writeup about QEMU multi-process, please refer to
docs/devel/qemu-multiprocess.rst. Also see docs/qemu-multiprocess.txt for
usage information.


We welcome all your ideas, concerns, and questions for this patchset.

[POC]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg566538.html
[1]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg602285.html
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg624877.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg642000.html
[4]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg655118.html
[5]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg682429.html
[6]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg697484.html
[7]: https://patchew.org/QEMU/cover.1593273671.git.elena.ufimtseva@oracle.com/

Elena Ufimtseva (8):
  multi-process: add qio channel function to transmit
  multi-process: define MPQemuMsg format and transmission functions
  multi-process: add co-routines to communicate with remote
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
  multi-process: Associate fd of a PCIDevice with its object
  multi-process: setup memory manager for remote device
  multi-process: PCI BAR read/write handling for proxy & remote
    endpoints
  multi-process: Synchronize remote memory
  multi-process: create IOHUB object to handle irq
  multi-process: Retrieve PCI info from remote process

John G Johnson (1):
  multi-process: add the concept description to
    docs/devel/qemu-multiprocess

 MAINTAINERS                     |  26 ++
 backends/hostmem-memfd.c        |   2 +-
 configure                       |  11 +
 docs/devel/index.rst            |   1 +
 docs/devel/multi-process.rst    | 966 ++++++++++++++++++++++++++++++++++++++++
 docs/multi-process.rst          |  67 +++
 exec.c                          |  11 +-
 hw/Makefile.objs                |   1 +
 hw/i386/Makefile.objs           |   4 +
 hw/i386/remote-memory.c         |  58 +++
 hw/i386/remote-msg.c            | 266 +++++++++++
 hw/i386/remote-obj.c            | 127 ++++++
 hw/i386/remote.c                |  79 ++++
 hw/misc/ivshmem.c               |   3 +-
 hw/pci-host/Makefile.objs       |   1 +
 hw/pci-host/remote.c            |  76 ++++
 hw/pci/Makefile.objs            |   2 +
 hw/pci/memory-sync.c            | 211 +++++++++
 hw/pci/proxy.c                  | 417 +++++++++++++++++
 hw/remote/Makefile.objs         |   1 +
 hw/remote/iohub.c               | 123 +++++
 include/exec/memory.h           |   2 +
 include/exec/ram_addr.h         |   2 +-
 include/hw/i386/remote-memory.h |  19 +
 include/hw/i386/remote-obj.h    |  42 ++
 include/hw/i386/remote.h        |  35 ++
 include/hw/pci-host/remote.h    |  31 ++
 include/hw/pci/memory-sync.h    |  27 ++
 include/hw/pci/pci_ids.h        |   3 +
 include/hw/pci/proxy.h          |  48 ++
 include/hw/remote/iohub.h       |  42 ++
 include/io/channel.h            |  24 +
 include/io/mpqemu-link.h        | 123 +++++
 include/qemu/mmap-alloc.h       |   3 +-
 io/Makefile.objs                |   2 +
 io/channel.c                    |  45 ++
 io/mpqemu-link.c                | 303 +++++++++++++
 scripts/mpqemu-launcher.py      |  49 ++
 softmmu/memory.c                |   3 +-
 util/mmap-alloc.c               |   7 +-
 util/oslib-posix.c              |   2 +-
 41 files changed, 3252 insertions(+), 13 deletions(-)
 create mode 100644 docs/devel/multi-process.rst
 create mode 100644 docs/multi-process.rst
 create mode 100644 hw/i386/remote-memory.c
 create mode 100644 hw/i386/remote-msg.c
 create mode 100644 hw/i386/remote-obj.c
 create mode 100644 hw/i386/remote.c
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 hw/pci/memory-sync.c
 create mode 100644 hw/pci/proxy.c
 create mode 100644 hw/remote/Makefile.objs
 create mode 100644 hw/remote/iohub.c
 create mode 100644 include/hw/i386/remote-memory.h
 create mode 100644 include/hw/i386/remote-obj.h
 create mode 100644 include/hw/i386/remote.h
 create mode 100644 include/hw/pci-host/remote.h
 create mode 100644 include/hw/pci/memory-sync.h
 create mode 100644 include/hw/pci/proxy.h
 create mode 100644 include/hw/remote/iohub.h
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c
 create mode 100755 scripts/mpqemu-launcher.py

-- 
1.8.3.1


