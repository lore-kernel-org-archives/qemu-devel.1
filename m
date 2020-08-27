Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E53C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA512177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jnCrmK+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA512177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMVH-0000w9-KD
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOa-0000nf-6Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOX-0007Ak-Eg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5RLT096727;
 Thu, 27 Aug 2020 18:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=yw0Xgb8Ymyq0rykx9aQrdQHG6z9qSei2GPhvlOlo4Mo=;
 b=jnCrmK+EwVb3/A/H0PTnQuR8/VaIrd+75jrXKbYu/fKysI47nBa5r0++7BtcDRjKmvCE
 XDCee8UrUMTbeCeGnZlUqqZF+SkLfNYikdYKEFZQBPEyuNbL/mWtHEtjbkEl9T17zwxA
 0oL4mrO9Ys2Si7vA7OtFAATbhktnouhcKGZwtQgLfqaO2ywtVGqj+P7VAW2/DjjPp/Z0
 nq530rwxkncHBR2dTFY0jJfC9grEi5+De7d+d30sjyJhgQgHlQ9RpHNoyc0VrnAU4/Ww
 GvWhzcFP4AKiyoK/El5lpKx3TYn7t4gIjtvb+8ixD0SQOasOKp1My3Ik/uWtRuhGBrx+ fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 336ht3g15e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:12:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI5P9r187482;
 Thu, 27 Aug 2020 18:12:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 333r9njwm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:12:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07RICZJ3020917;
 Thu, 27 Aug 2020 18:12:35 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:12:34 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 00/20] Initial support for multi-process Qemu
Date: Thu, 27 Aug 2020 11:12:11 -0700
Message-Id: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 13:54:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Hello

This is the v9 of the patchset. Thank you very much for the
detailed feedback for v8. We appreciate your time. We believe
we have address all the comments for v8 in the current series.
Special thanks to Stefan Hajnoczi.

The v9 has the following changes:
- Communication channel. Qemu side uses blocking call to send
  and receive the message from the remote and cannot progress
  further until the remote side replies. Enhanced the
  communication channel by dropping iothread lock before blocking
  on Qemu end. Use the co-routines on the remote end to avoid
  blocking QMP monitor;
- removed the heartbeat functionality, it will be added later
  in a full extent;
- fixed leaked errors and similar fixes;
- eliminated bytestream passing over the channel;
- The build system had to be changed in order to accomodate the
  latest changes in Qemu to use Kconfig/mason.

To touch upon the history of this project, we posted the
Proof Of Concept patches before the BoF session in 2018.
Subsequently, we posted 8 versions on the qemu-devel mailist.
You can find them by following the links below ([1] - [8]).

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

Elena Ufimtseva (8):
  multi-process: add qio channel function to transmit
  multi-process: define MPQemuMsg format and transmission functions
  multi-process: define transmission functions in remote
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

 MAINTAINERS                     |  26 +
 backends/hostmem-memfd.c        |   2 +-
 configure                       |  10 +
 docs/devel/index.rst            |   1 +
 docs/devel/multi-process.rst    | 966 ++++++++++++++++++++++++++++++++
 docs/multi-process.rst          |  67 +++
 exec.c                          |  11 +-
 hw/i386/meson.build             |   5 +
 hw/i386/remote-iohub.c          | 123 ++++
 hw/i386/remote-memory.c         |  58 ++
 hw/i386/remote-msg.c            | 263 +++++++++
 hw/i386/remote-obj.c            | 140 +++++
 hw/i386/remote.c                |  79 +++
 hw/misc/ivshmem.c               |   3 +-
 hw/pci-host/meson.build         |   1 +
 hw/pci-host/remote.c            |  75 +++
 hw/pci/memory-sync.c            | 210 +++++++
 hw/pci/meson.build              |   3 +
 hw/pci/proxy.c                  | 363 ++++++++++++
 include/exec/memory.h           |   2 +
 include/exec/ram_addr.h         |   2 +-
 include/hw/i386/remote-iohub.h  |  42 ++
 include/hw/i386/remote-memory.h |  19 +
 include/hw/i386/remote-obj.h    |  42 ++
 include/hw/i386/remote.h        |  35 ++
 include/hw/pci-host/remote.h    |  31 +
 include/hw/pci/memory-sync.h    |  27 +
 include/hw/pci/pci_ids.h        |   3 +
 include/hw/pci/proxy.h          |  54 ++
 include/io/channel.h            |  24 +
 include/io/mpqemu-link.h        | 110 ++++
 include/qemu/mmap-alloc.h       |   3 +-
 io/channel.c                    |  45 ++
 io/meson.build                  |   2 +
 io/mpqemu-link.c                | 347 ++++++++++++
 meson.build                     |   1 +
 scripts/mpqemu-launcher.py      |  49 ++
 softmmu/memory.c                |   3 +-
 util/mmap-alloc.c               |   7 +-
 util/oslib-posix.c              |   2 +-
 40 files changed, 3243 insertions(+), 13 deletions(-)
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
2.25.GIT


