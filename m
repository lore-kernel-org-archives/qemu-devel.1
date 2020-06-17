Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF3A207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 20:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R2SoPJDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF3A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jleHT-0000MP-R4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 16:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karl.heubaum@oracle.com>)
 id 1jleGc-0007yq-1h; Wed, 17 Jun 2020 16:02:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karl.heubaum@oracle.com>)
 id 1jleGZ-0006Sk-Bo; Wed, 17 Jun 2020 16:02:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05HJhROW027600;
 Wed, 17 Jun 2020 20:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=09tdP4k5kSUznGbKobSIy4939FZAB2gPbLP4WBsjv70=;
 b=R2SoPJDeEIMOtf+t1AyVGdH2ztWFl1zxrFkLfOTbE6/ifLLeNNyEYxjo8QpU2oDSpD7r
 AZnd2X+sfknS4ghGRWXmW4Id6ALSNJYqpUmZnVxIrfHwPNrHpp29gcUjrVvSPCYh0k4p
 f16fQIf3ZgMkbXouFFkU3YaCYK9iuAIxa74WFQBSD1lAvhi3gQazWm8lR2jySVKxeMQQ
 C/2EiNecuabiSnL12wlM3Qwku33C0da40ahvXB62Y3RcGnnihg+Qn4wFJ5x8dT3QsLI/
 IrpPe1TMZeZvC5JLJXCMUxAwzKMPdPlzbQh8LdukmfTwdBBngmQPUapU86v9pbmtAkwj NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 31qg353cpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jun 2020 20:02:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05HJhCYj131818;
 Wed, 17 Jun 2020 20:02:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 31q66pxnkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2020 20:02:28 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05HK2RmQ026181;
 Wed, 17 Jun 2020 20:02:27 GMT
Received: from [10.159.255.184] (/10.159.255.184)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 17 Jun 2020 13:02:27 -0700
From: "Karl Heubaum" <karl.heubaum@oracle.com>
To: "Michael Roth" <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/78] Patch Round-up for stable 4.2.1, freeze on
 2020-06-22
Date: Wed, 17 Jun 2020 15:02:25 -0500
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <7FE48C4C-F4CA-4B3D-9670-332CBCF517C5@oracle.com>
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170150
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=karl.heubaum@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 16:02:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16 Jun 2020, at 9:14, Michael Roth wrote:
> Hi everyone,
>
> The following new patches are queued for QEMU stable v4.2.1:
>
>   https://github.com/mdroth/qemu/commits/stable-4.2-staging
>
> The release is planned for 2020-06-25:
>
>   https://wiki.qemu.org/Planning/4.2
>
> Due to delays on my part this release is going out beyond the normal
> ~4 month support window. v5.0.1 is scheduled to be released as normal.
>
> Please respond here or CC qemu-stable@nongnu.org on any additional 
> patches
> you think should be included in the release.

CVE related commits:
* 693fd2acdf14 ("iscsi: Cap block count from GET LBA STATUS
(CVE-2020-1711)")
* ac2071c3791b ("ati-vga: Fix checks in ati_2d_blt() to avoid crash")
to fix CVE-2020-11869
* a98610c429d5 ("ati-vga: check mm_index before recursive call
(CVE-2020-13800)")
* 369ff955a849 ("es1370: check total frame count against current frame")
to fix CVE-2020-13361
* Advance the slirp submodule to commit 2faae0f778f8 ("Fix use-afte-free
in ip_reass()") to fix CVE-2019-15890, CVE-2020-8608, and CVE-2020-1983

Fix for a crash:
* 9b3a31c745b6 ("kvm: Reallocate dirty_bmap when we change a slot")

Thank you,
Karl

>
> Thanks!
>
>
> ----------------------------------------------------------------
> Alex Bennée (2):
>       target/arm: ensure we use current exception state after SCR 
> update
>       tcg: save vaddr temp for plugin usage
>
> Alexander Popov (2):
>       tests/ide-test: Create a single unit-test covering more PRDT 
> cases
>       ide: Fix incorrect handling of some PRDTs in ide_dma_cb()
>
> Anthony PERARD (1):
>       xen-block: Fix double qlist remove and request leak
>
> Basil Salman (2):
>       qga: Installer: Wait for installation to finish
>       qga-win: prevent crash when executing guest-file-read with large 
> count
>
> Christian Borntraeger (1):
>       s390/sclp: improve special wait psw logic
>
> Christophe de Dinechin (1):
>       scsi/qemu-pr-helper: Fix out-of-bounds access to trnptid_list[]
>
> Cornelia Huck (1):
>       compat: disable edid on correct virtio-gpu device
>
> Daniel P. Berrangé (1):
>       qapi: better document NVMe blockdev @device parameter
>
> David Hildenbrand (3):
>       virtio-balloon: fix free page hinting without an iothread
>       virtio-balloon: fix free page hinting check on unrealize
>       virtio-balloon: unref the iothread when unrealizing
>
> Denis Plotnikov (1):
>       virtio-mmio: update queue size on guest write
>
> Eduardo Habkost (1):
>       i386: Resolve CPU models to v1 by default
>
> Emilio G. Cota (1):
>       plugins/core: add missing break in cb_to_tcg_flags
>
> Eric Blake (3):
>       qga: Fix undefined C behavior
>       nbd/server: Avoid long error message assertions CVE-2020-10761
>       block: Call attention to truncation of long NBD exports
>
> Finn Thain (14):
>       dp8393x: Mask EOL bit from descriptor addresses
>       dp8393x: Always use 32-bit accesses
>       dp8393x: Clean up endianness hacks
>       dp8393x: Have dp8393x_receive() return the packet size
>       dp8393x: Update LLFA and CRDA registers from rx descriptor
>       dp8393x: Clear RRRA command register bit only when appropriate
>       dp8393x: Implement packet size limit and RBAE interrupt
>       dp8393x: Don't clobber packet checksum
>       dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
>       dp8393x: Pad frames to word or long word boundary
>       dp8393x: Clear descriptor in_use field to release packet
>       dp8393x: Always update RRA pointers and sequence numbers
>       dp8393x: Don't reset Silicon Revision register
>       dp8393x: Don't stop reception upon RBE interrupt assertion
>
> Greg Kurz (1):
>       9p: Lock directory streams with a CoMutex
>
> Igor Mammedov (3):
>       numa: remove not needed check
>       numa: properly check if numa is supported
>       hostmem: don't use mbind() if host-nodes is empty
>
> Kevin Wolf (4):
>       block: Activate recursively even for already active nodes
>       qcow2: update_refcount(): Reset old_table_index after 
> qcow2_cache_put()
>       qcow2: Fix qcow2_alloc_cluster_abort() for external data file
>       iotests: Test copy offloading with external data file
>
> Li Hangjing (1):
>       virtio-blk: fix out-of-bounds access to bitmap in 
> notify_guest_bh
>
> Liu Yi L (2):
>       intel_iommu: a fix to vtd_find_as_from_bus_num()
>       intel_iommu: add present bit check for pasid table entries
>
> Max Reitz (4):
>       backup-top: Begin drain earlier
>       qcow2: Fix alloc_cluster_abort() for pre-existing clusters
>       iotests/026: Test EIO on preallocated zero cluster
>       iotests/026: Test EIO on allocation in a data-file
>
> Michael S. Tsirkin (3):
>       virtio: update queue size on guest write
>       virtio: add ability to delete vq through a pointer
>       virtio: make virtio_delete_queue idempotent
>
> Nicholas Piggin (1):
>       target/ppc: Fix mtmsr(d) L=1 variant that loses interrupts
>
> Niek Linnenbank (2):
>       arm/arm-powerctl: set NSACR.{CP11, CP10} bits in 
> arm_set_cpu_on()
>       arm/arm-powerctl: rebuild hflags after setting CP15 bits in 
> arm_set_cpu_on()
>
> Pan Nengyuan (2):
>       block/nbd: extract the common cleanup code
>       block/nbd: fix memory leak in nbd_open()
>
> Peter Maydell (2):
>       hw/i386/amd_iommu.c: Fix corruption of log events passed to 
> guest
>       dump: Fix writing of ELF section
>
> Peter Wu (1):
>       hw/i386/pc: fix regression in parsing vga cmdline parameter
>
> Peter Xu (1):
>       vfio/pci: Don't remove irqchip notifier if not registered
>
> Philippe Mathieu-Daudé (1):
>       vhost-user-gpu: Release memory returned by vu_queue_pop() with 
> free()
>
> Raphael Pour (1):
>       qemu-nbd: Close inherited stderr
>
> Richard Henderson (3):
>       target/arm: Set ISSIs16Bit in make_issinfo
>       tcg/i386: Fix INDEX_op_dup2_vec
>       target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_*
>
> Sameeh Jubran (1):
>       qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error
>
> Stefan Hajnoczi (2):
>       virtio: gracefully handle invalid region caches
>       qemu-ga: document vsock-listen in the man page
>
> Thomas Huth (1):
>       net: Do not include a newline in the id of -nic devices
>
> Vitaly Chikunov (1):
>       target/ppc: Fix rlwinm on ppc64
>
> Vladimir Sementsov-Ogievskiy (5):
>       qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
>       block/qcow2-threads: fix qcow2_decompress
>       job: refactor progress to separate object
>       block/block-copy: fix progress calculation
>       block/io: fix bdrv_co_do_copy_on_readv
>
> Yuri Benditovich (2):
>       virtio: reset region cache when on queue deletion
>       virtio-net: delete also control queue when TX/RX deleted
>
>  backends/hostmem.c                 |   6 +-
>  block.c                            |  57 +++++------
>  block/backup-top.c                 |   4 +-
>  block/backup.c                     |  13 +--
>  block/block-copy.c                 |  16 ++-
>  block/io.c                         |   2 +-
>  block/nbd.c                        |  48 +++++----
>  block/qcow2-bitmap.c               |  41 ++++----
>  block/qcow2-cluster.c              |   7 +-
>  block/qcow2-refcount.c             |   1 +
>  block/qcow2-threads.c              |  12 ++-
>  blockjob.c                         |  16 +--
>  contrib/vhost-user-gpu/main.c      |   4 +-
>  contrib/vhost-user-gpu/virgl.c     |   2 +-
>  docs/interop/qemu-ga.rst           |   5 +-
>  dump/dump.c                        |   2 +-
>  hw/9pfs/9p.h                       |   8 +-
>  hw/arm/sbsa-ref.c                  |   1 -
>  hw/block/dataplane/virtio-blk.c    |   2 +-
>  hw/block/dataplane/xen-block.c     |  48 +++------
>  hw/core/machine.c                  |   6 +-
>  hw/core/numa.c                     |   7 +-
>  hw/i386/amd_iommu.c                |   2 +-
>  hw/i386/intel_iommu.c              |  93 +++++++++++++----
>  hw/i386/intel_iommu_internal.h     |   1 +
>  hw/i386/x86.c                      |   8 +-
>  hw/ide/core.c                      |  30 ++++--
>  hw/net/dp8393x.c                   | 200 
> ++++++++++++++++++++++++-------------
>  hw/net/virtio-net.c                |   3 +-
>  hw/vfio/pci.c                      |   4 +-
>  hw/virtio/virtio-balloon.c         |  36 +++----
>  hw/virtio/virtio-mmio.c            |   3 +-
>  hw/virtio/virtio-pci.c             |   2 +
>  hw/virtio/virtio.c                 | 116 ++++++++++++++++++---
>  include/block/block-copy.h         |  15 +--
>  include/hw/virtio/virtio.h         |   2 +
>  include/qemu/job.h                 |  11 +-
>  include/qemu/progress_meter.h      |  58 +++++++++++
>  job-qmp.c                          |   4 +-
>  job.c                              |   6 +-
>  nbd/server.c                       |  23 ++++-
>  net/net.c                          |   2 +-
>  plugins/core.c                     |   1 +
>  qapi/block-core.json               |   6 +-
>  qemu-deprecated.texi               |   8 ++
>  qemu-img.c                         |   6 +-
>  qemu-nbd.c                         |   6 +-
>  qga/commands-win32.c               |   8 +-
>  qga/commands.c                     |   9 +-
>  qga/installer/qemu-ga.wxs          |   2 +-
>  qga/main.c                         |   4 +-
>  qga/vss-win32/install.cpp          |  11 ++
>  scsi/qemu-pr-helper.c              |  17 ++--
>  target/arm/arm-powerctl.c          |   6 ++
>  target/arm/cpu.h                   |   8 +-
>  target/arm/helper.c                |  14 ++-
>  target/arm/helper.h                |   1 +
>  target/arm/translate.c             |   9 +-
>  target/arm/vec_helper.c            |   2 +
>  target/i386/cpu.c                  |   8 +-
>  target/ppc/translate.c             |  66 ++++++------
>  target/s390x/helper.c              |   2 +-
>  tcg/i386/tcg-target.inc.c          |  10 +-
>  tcg/tcg-op.c                       |  23 ++++-
>  tests/ide-test.c                   | 174 
> ++++++++++++++------------------
>  tests/qemu-iotests/026             |  53 ++++++++++
>  tests/qemu-iotests/026.out         |  16 +++
>  tests/qemu-iotests/026.out.nocache |  16 +++
>  tests/qemu-iotests/143             |   4 +
>  tests/qemu-iotests/143.out         |   2 +
>  tests/qemu-iotests/244             |  14 +++
>  tests/qemu-iotests/244.out         |   6 ++
>  72 files changed, 963 insertions(+), 476 deletions(-)
>  create mode 100644 include/qemu/progress_meter.h

