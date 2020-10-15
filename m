Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D6C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E246A22240
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MRyZm6d1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E246A22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7eh-0001Ij-Ne
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dE-0007zg-PB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dB-0002It-Dg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4nJ8127949;
 Thu, 15 Oct 2020 18:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=VkUdPko8AbuIOsevwKqllAeyKYh2XpdwH5LG65eJJDs=;
 b=MRyZm6d1xhbwe5euKQnZ5q3tva7ioedemSwaqUgNvbHLaHx7/vxv1Bp8OunEQy5AZ8Hw
 XAdxsdviRHNPyBvzzgnLeXqVtbI3ph4SmnsGLILUMl1YqlgQ5EEwQWRPy1tgot7Vz1zr
 c50yZh8pwTpC9iulhkl3LYchODs/hjJ/Q1/WvHyoPZM9S/bafm+eATkp7g45n7PCzjDA
 vI8k0gB8FtkaD1hSQUM+zpNPiXIYSxy548dIVzYA5EGigVdx59TfVy/OwNh0PeeA0oS2
 YirLWdo2r6vatdNUyutPWp1m1I8xmyH6eti2hvwx2Bh1Bu6rLVMrQvD1yD9lCyZzabxH Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 346g8gkcc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4ekk184611;
 Thu, 15 Oct 2020 18:05:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 343pw0qh31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:25 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FI5LDD026156;
 Thu, 15 Oct 2020 18:05:21 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:21 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 00/19] Initial support for multi-process Qemu
Date: Thu, 15 Oct 2020 14:04:53 -0400
Message-Id: <cover.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.79; envelope-from=jag.raman@oracle.com;
 helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 11:04:16
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hello,

This is the v11 of the patchset. Thank you very much for the
review of the v10 of the series. We are glad to hear the
patchset is getting in a better shape.

We made changes to the following patches in this series.

[PATCH v10 06/19] multi-process: define MPQemuMsg format and transmission functions
[PATCH v10 08/19] multi-process: Associate fd of a PCIDevice with its object
[PATCH v10 10/19] multi-process: introduce proxy object

To touch upon the history of this project, we posted the
Proof Of Concept patches before the BoF session in 2018.
Subsequently, we posted 9 versions on the qemu-devel mailist.
You can find them by following the links below ([1] - [9]).

Following people contributed to the design and
implementation of this project:
Jagannathan Raman <jag.raman@oracle.com>
Elena Ufimtseva <elena.ufimtseva@oracle.com>
John G Johnson <john.g.johnson@oracle.com>
Stefan Hajnoczi <stefanha@redhat.com>
Konrad Wilk <konrad.wilk@oracle.com>
Kanth Ghatraju <kanth.ghatraju@oracle.com>

We would like to thank QEMU community for your feedback in the
design and implementation of this project.

Qemu wiki page:
https://wiki.qemu.org/Features/MultiProcessQEMU

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
[8]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg727007.html
[9]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg734275.html
[10]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg747638.html

Elena Ufimtseva (7):
  multi-process: add qio channel function to transmit
  multi-process: define MPQemuMsg format and transmission functions
  multi-process: introduce proxy object
  multi-process: add proxy communication functions
  multi-process: Forward PCI config space acceses to the remote process
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
 configure                       |  10 +
 docs/devel/index.rst            |   1 +
 docs/devel/multi-process.rst    | 966 ++++++++++++++++++++++++++++++++++++++++
 docs/multi-process.rst          |  67 +++
 hw/i386/meson.build             |   5 +
 hw/i386/remote-iohub.c          | 123 +++++
 hw/i386/remote-memory.c         |  58 +++
 hw/i386/remote-msg.c            | 241 ++++++++++
 hw/i386/remote-obj.c            | 154 +++++++
 hw/i386/remote.c                |  79 ++++
 hw/misc/ivshmem.c               |   3 +-
 hw/pci-host/meson.build         |   1 +
 hw/pci-host/remote.c            |  75 ++++
 hw/pci/memory-sync.c            | 210 +++++++++
 hw/pci/meson.build              |   3 +
 hw/pci/proxy.c                  | 377 ++++++++++++++++
 include/exec/memory.h           |   2 +
 include/exec/ram_addr.h         |   2 +-
 include/hw/i386/remote-iohub.h  |  42 ++
 include/hw/i386/remote-memory.h |  19 +
 include/hw/i386/remote-obj.h    |  42 ++
 include/hw/i386/remote.h        |  40 ++
 include/hw/pci-host/remote.h    |  31 ++
 include/hw/pci/memory-sync.h    |  27 ++
 include/hw/pci/pci_ids.h        |   3 +
 include/hw/pci/proxy.h          |  53 +++
 include/io/channel.h            |  24 +
 include/io/mpqemu-link.h        |  98 ++++
 include/qemu/mmap-alloc.h       |   3 +-
 io/channel.c                    |  45 ++
 io/meson.build                  |   2 +
 io/mpqemu-link.c                | 303 +++++++++++++
 meson.build                     |   1 +
 scripts/mpqemu-launcher.py      |  49 ++
 softmmu/memory.c                |   3 +-
 softmmu/physmem.c               |  11 +-
 util/mmap-alloc.c               |   7 +-
 util/oslib-posix.c              |   2 +-
 40 files changed, 3197 insertions(+), 13 deletions(-)
 create mode 100644 docs/devel/multi-process.rst
 create mode 100644 docs/multi-process.rst
 create mode 100644 hw/i386/remote-iohub.c
 create mode 100644 hw/i386/remote-memory.c
 create mode 100644 hw/i386/remote-msg.c
 create mode 100644 hw/i386/remote-obj.c
 create mode 100644 hw/i386/remote.c
 create mode 100644 hw/pci-host/remote.c
 create mode 100644 hw/pci/memory-sync.c
 create mode 100644 hw/pci/proxy.c
 create mode 100644 include/hw/i386/remote-iohub.h
 create mode 100644 include/hw/i386/remote-memory.h
 create mode 100644 include/hw/i386/remote-obj.h
 create mode 100644 include/hw/i386/remote.h
 create mode 100644 include/hw/pci-host/remote.h
 create mode 100644 include/hw/pci/memory-sync.h
 create mode 100644 include/hw/pci/proxy.h
 create mode 100644 include/io/mpqemu-link.h
 create mode 100644 io/mpqemu-link.c
 create mode 100755 scripts/mpqemu-launcher.py

-- 
1.8.3.1


