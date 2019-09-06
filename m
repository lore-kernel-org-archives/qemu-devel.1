Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91904C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6850020674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6850020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6GpU-0003yJ-Gv
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i6GgD-0002Lh-EH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i6GgB-0004zg-PI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:01:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:37868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i6Gg7-0004f7-Sr; Fri, 06 Sep 2019 12:01:40 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i6Gg2-0005vz-OE; Fri, 06 Sep 2019 19:01:34 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Fri,  6 Sep 2019 19:01:11 +0300
Message-Id: <20190906160120.70239-1-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v9 0/9] discard blockstats
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v9:
 - fixed patch 5 so the fields are actually numbered in sectors not blocks
 - fixed patch 7 accordingly
 - patch 8: make stat fields unsigned
 - qapi patches: "since 4.1" -> "since 4.2"

v8: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03709.html

----

qmp query-blockstats provides stats info for write/read/flush ops.

Patches 1-7 implement the similar for discard (unmap) command for scsi
and ide disks.
Discard stat "unmap_ops / unmap_bytes" is supposed to account the ops that
have completed without an error.

However, discard operation is advisory. Specifically,
 - common block layer ignores ENOTSUP error code.
   That might be returned if the block driver does not support discard,
   or discard has been configured to be ignored.
 - format drivers such as qcow2 may ignore discard if they were configured
   to ignore that, or if the corresponding area is already marked unused
   (unallocated / zero clusters).

And what is actually useful is the number of bytes actually discarded
down on the host filesystem.
To achieve that, driver-specific statistics has been added to blockstats
(patch 9).
With patch 8, file-posix driver accounts discard operations on its level too.

query-blockstat result:

(note the difference between blockdevice unmap and file discard stats. qcow2
sends fewer ops down to the file as the clusters are actually unallocated
on qcow2 level)

    {
      "device": "drive-scsi0-0-0-0",
      "node-name": "#block159",
      "stats": {
>       "invalid_unmap_operations": 0,
>       "failed_unmap_operations": 0,
        "wr_highest_offset": 13411688448,
        "rd_total_time_ns": 2859566315,
        "rd_bytes": 103182336,
        "rd_merged": 0,
        "flush_operations": 19,
        "invalid_wr_operations": 0,
        "flush_total_time_ns": 23111608,
        "failed_rd_operations": 0,
        "failed_flush_operations": 0,
        "invalid_flush_operations": 0,
        "timed_stats": [
          
        ],
        "wr_merged": 0,
        "wr_bytes": 1702912,
>       "unmap_bytes": 11954954240,
>       "unmap_operations": 865,
        "idle_time_ns": 2669508623,
        "account_invalid": true,
>       "unmap_total_time_ns": 19698002,
        "wr_operations": 143,
        "failed_wr_operations": 0,
        "rd_operations": 4816,
        "account_failed": true,
>       "unmap_merged": 0,
        "wr_total_time_ns": 1262686124,
        "invalid_rd_operations": 0
      },
      "parent": {
>       "driver-specific": {
>         "discard-nb-failed": 0,
>         "discard-bytes-ok": 720896,
>         "driver": "file",
>         "discard-nb-ok": 8
>       },
        "node-name": "#block009",
        "stats": {
        [..]
        }
      }
    },
    {
      "device": "floppy0",

Anton Nefedov (9):
  qapi: group BlockDeviceStats fields
  qapi: add unmap to BlockDeviceStats
  block: add empty account cookie type
  ide: account UNMAP (TRIM) operations
  scsi: store unmap offset and nb_sectors in request struct
  scsi: move unmap error checking to the complete callback
  scsi: account unmap operations
  file-posix: account discard operations
  qapi: query-blockstat: add driver specific file-posix stats

 qapi/block-core.json       | 81 ++++++++++++++++++++++++++++++++------
 include/block/accounting.h |  2 +
 include/block/block.h      |  1 +
 include/block/block_int.h  |  1 +
 block.c                    |  9 +++++
 block/accounting.c         |  6 +++
 block/file-posix.c         | 54 ++++++++++++++++++++++++-
 block/qapi.c               | 11 ++++++
 hw/ide/core.c              | 12 ++++++
 hw/scsi/scsi-disk.c        | 34 ++++++++++------
 tests/qemu-iotests/227.out | 18 +++++++++
 11 files changed, 206 insertions(+), 23 deletions(-)

-- 
2.17.1


