Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954E2C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632EC2084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632EC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37177 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJots-0001X6-IQ
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 20:39:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJosO-0000hn-As
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJosM-0007fM-Nh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:38:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:45647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJosM-0007dS-Dw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:38:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 17:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; d="scan'208";a="143698935"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2019 17:37:57 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 08:36:50 +0800
Message-Id: <20190426003652.32633-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: [Qemu-devel] [PATCH v15 0/2] support MAP_SYNC for
 memory-backend-file
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	richardw.yang@linux.intel.com, stefanha@redhat.com,
	imammedo@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426003650.rhNn5wt5Pl-6CebDqyzxOVEdqqD3Ll_okQMz142G-Fk@z>

Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
files on ext4/xfs file system mounted with '-o dax').

A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
    https://patchwork.kernel.org/patch/10028151/

In order to make sure that the file metadata is in sync after a fault 
while we are writing a shared DAX supporting backend files, this
patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.

As the DAX vs DMA truncated issue was solved, we refined the code and
send out this feature for the v5 version.

We will pass MAP_SYNC to mmap(2); if MAP_SYNC is supported and
'share=on' & 'pmem=on'. 
Or QEMU will not pass this flag to mmap(2)

Test with below cases:
1. pmem=on is set, shared=on is set, MAP_SYNC supported:
   a: backend is a dax supporting file.
   1) start VM1 with options:
   -object memory-backend-file,id=nv_be4,share,mem-path=${DAX_FILE_1},size=${DAX_FILE_SIZE_1},align=128M,pmem=on,share=on
   -device nvdimm,id=nv4,memdev=nv_be4,label-size=2M.
   
   2) start VM2 with options:
   -object memory-backend-file,id=nv_be4,share,mem-path=${DAX_FILE_2,size=${DAX_FILE_SIZE_2},align=128M,pmem=on,share=on
   -device nvdimm,id=nv4,memdev=nv_be4,label-size=2M.

   3) live migrate from VM1 to VM2.
   
   4) Suddenly let Host crash or power failure.

   5) check DAX_FILE_1 and DAX_FILE_2, no corrupt.

   b: backend is a regular file.
   1) start with options
   -object memory-backend-file,id=nv_be4,share,mem-path=${REG_FILE},size=${REG_FILE_SIZE},align=128M,pmem=on,share=on
   -device nvdimm,id=nv4,memdev=nv_be4,label-size=2M.

   will warning "failed to validate with mapping flags: Operation not supported"
   FILE_1 and FILE_2 random corrupt.

2. Other cases:
   FILE_1 and FILE_2 random corrupt.

Changes in V15:
 * 1/2 fix compile issue on pre-linux 4.15
 * remove silently

Changes in V14:
 * 1/2 rebase on top of current upstream and tested

Changes in V13:
 * 4/5 Micheal: move the inlcude to mmap_alloc.c.
 * 4/5 Micheal: refine the warning message.
 * 5/5 Micheal: refine the Documentations.

Changes in V12:
 * 2/5: Micheal: Update update-linux-headers.sh
 * 3/5: Micheal: Use script update add linux/mman.h
 * 4/5: Pankaj,Micheal: 1) fallback to mmap without
        MAP_SYNC & MAP_SHARED_VALIDATE if sync not supported or failed
	2) Replace the include with 3/5 added linux/mman.h
 * 5/5: Micheal: Refine the Documentations.

Changes in V11:
 * 1/3: Micheal: Change to just add a bool is_pmem in qemu_ram_mmap.
 * 2/3: Micheal: Fix the compatibility for old kernel.
 * 2/3&3/3: Micheal&Eduardo :Update the behavior below: 
   Waning at no-dax and continue without MAP_SYNC.
   Test if fails again for compatibility, then remove the MAP_VALIDATE and
   silently proceed.

Changes in V10:
 * 4/4: refine the document.
 * 3/4: Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
 * 2/4: refine the commit message, Added MAP_SHARED_VALIDATE.
 * 2/4: Fix the wrong include header

Changes in V9:
 * 1/6: Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
 * 2/6: New Added: Micheal: use sparse feature define RAM_FLAG. 
 since I don't have much knowledge about the sparse feature, @Micheal Could you 
 add some documentation/commit message on this patch? Thank you very much.
 * 3/6: from 2/5: Eduardo: updated the commit message. 
 * 4/6: from 3/5: Micheal: don't ignore MAP_SYNC failures silently.
 * 5/6: from 4/5: Eduardo: updated the commit message.
 * 6/6: from 5/5: Micheal: Drop the sync option, document the MAP_SYNC.

Changes in v8:
 * Micheal: 3/5, remove the duplicated define in the os_dep.h
 * Micheal: 2/5, make type define safety.
 * Micheal: 2/5, fixed the incorrect define MAP_SHARE on qemu_anon_ram_alloc.
 * 4/6 removed, we remove the on/off/auto define of sync,  as by now,
   MAP_SYNC only worked with pmem=on.
 * @Micheal, I still reuse the RAM_SYNC flag, it is much straightforward to parse 
   all the flags in one parameter.

Changes in v7:
 * Micheal: [3,4,6]/6 limited the "sync" flag only on a nvdimm backend.(pmem=on)

Changes in v6:
 * Pankaj: 3/7 are squashed with 2/7
 * Pankaj: 7/7 update comments to "consistent filesystem metadata".
 * Pankaj, Igor: 1/7 Added Reviewed-by in patch-1/7
 * Stefan, 4/7 move the include header from "/linux/mman.h" to "osdep.h"
 * Stefan, 5/7 Add missing "munmap"
 * Stefan, 2/7 refine the shared/flag.

Changes in v5:
 * Add patch 1 to fix a memory leak issue.
 * Refine the patch 4-6
 * Remove the patch 3 as we already change the parameter from "shared" to
   "flags"

Changes in v4:
 * Add patch 1-3 to switch some functions to a single 'flags'
   parameters. (Michael S. Tsirkin)
 * v3 patch 1-3 become v4 patch 4-6.
 * Patch 4: move definitions of MAP_SYNC and MAP_SHARED_VALIDATE to a
   new header file under include/standard-headers/linux/. (Michael S. Tsirkin)
 * Patch 6: refine the description of the 'sync' option. (Michael S. Tsirkin)

Changes in v3:
 * Patch 1: add MAP_SHARED_VALIDATE in both sync=on and sync=auto
   cases, and add back the retry mechanism. MAP_SYNC will be ignored
   by Linux kernel 4.15 if MAP_SHARED_VALIDATE is missed.
 * Patch 1: define MAP_SYNC and MAP_SHARED_VALIDATE as 0 on non-Linux
   platforms in order to make qemu_ram_mmap() compile on those platforms.
 * Patch 2&3: include more information in error messages of
   memory-backend in hope to help user to identify the error.
   (Dr. David Alan Gilbert)
 * Patch 3: fix typo in the commit message. (Dr. David Alan Gilbert)

Changes in v2:
 * Add 'sync' option to control the use of MAP_SYNC. (Eduardo Habkost)
 * Remove the unnecessary set of MAP_SHARED_VALIDATE in some cases and
   the retry mechanism in qemu_ram_mmap(). (Michael S. Tsirkin)
 * Move OS dependent definitions of MAP_SYNC and MAP_SHARED_VALIDATE
   to osdep.h. (Michael S. Tsirkin)

Zhang Yi (2):
  util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()
  docs: Added MAP_SYNC documentation

 docs/nvdimm.txt   | 22 +++++++++++++++++++---
 qemu-options.hx   |  5 +++++
 util/mmap-alloc.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 68 insertions(+), 4 deletions(-)

-- 
2.19.1


