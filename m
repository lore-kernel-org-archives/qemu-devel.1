Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F01C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 08:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CC3217BA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 08:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CC3217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irHUU-0003u1-Av
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 03:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1irHT2-00022W-N6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1irHT1-0006lW-9o
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:22:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:36838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1irHSy-0006jm-In; Tue, 14 Jan 2020 03:22:24 -0500
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1irHSr-0005Ix-KN; Tue, 14 Jan 2020 11:22:17 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/3] Dump QCOW2 metadata
Date: Tue, 14 Jan 2020 11:22:14 +0300
Message-Id: <1578990137-308222-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The information about QCOW2 metadata allocations in an image ELF-file is
helpful for finding issues with the image data integrity.

v3: Descriptions of the new key option were added. The names of identifiers
    were amended. The QEMU-IMG key options were put in the sorted order in
    the code. All suggested by Eric. Discussed in the email thread with ID
    <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Snapshots dump example:

$ sudo ./qemu-img check /.../.../harddisk.hdd -M --output=json
{
    "image-end-offset": 24820842496,
    "total-clusters": 153600,
    "check-errors": 0,
    "viscera": {
        "refcount-table": {
            "location": {
                "offset": 3845128192,
                "size": 1048576
            }
        },
        "active-l1": {
            "name": "L1 active table",
            "location": {
                "offset": 4194304,
                "size": 16
            },
            "l2-list": [
                {
                    "offset": 619708416,
                    "size": 1048576
                },
                {
                    "offset": 1156579328,
                    "size": 1048576
                }
            ]
        },
        "qcow2-header": {
            "location": {
                "offset": 0,
                "size": 1048576
            },
            "version": 3
        },
        "snapshot-table": {
            "location": {
                "offset": 648019968,
                "size": 191
            },
            "l1-list": [
                {
                    "name": "{3036f6c5-3a1f-44cb-af1f-653cc87fba04}",
                    "location": {
                        "offset": 14680064,
                        "size": 16
                    },
                    "l2-list": [
                        {
                            "offset": 3957325824,
                            "size": 1048576
                        },
                        {
                            "offset": 7025459200,
                            "size": 1048576
                        }
                    ]
                },
                {
                    "name": "{0aa1a7d6-16ee-4b44-a515-b5ecc571c959}",
                    "location": {
                        "offset": 638582784,
                        "size": 16
                    },
                    "l2-list": [
                        {
                            "offset": 3957325824,
                            "size": 1048576
                        },
                        {
                            "offset": 7025459200,
                            "size": 1048576
                        }
                    ]
                }
            ]
        }
    },
    "allocated-clusters": 22485,
    "filename": "/.../.../harddisk.hdd",
    "format": "qcow2",
    "fragmented-clusters": 3549
}

Bitmaps dump example:

$ ./qemu-img check /home/disk -M --output=json
{
    "image-end-offset": 1441792,
    "total-clusters": 16,
    "check-errors": 0,
    "viscera": {
        "refcount-table": {
            "location": {
                "offset": 65536,
                "size": 65536
            }
        },
        "active-l1": {
            "name": "L1 active table",
            "location": {
                "offset": 196608,
                "size": 8
            },
            "l2-list": [
                {
                    "offset": 262144,
                    "size": 65536
                }
            ]
        },
        "bitmaps": {
            "bitmap-dir": {
                "location": {
                    "offset": 1048576,
                    "size": 64
                },
                "dir-entries": [
                    {
                        "bitmap-table": {
                            "location": {
                                "offset": 589824,
                                "size": 8
                            },
                            "table-entries": [
                                {
                                    "type": "all-zeros"
                                }
                            ]
                        },
                        "bitmap-name": "bitmap-1"
                    },
                    {
                        "bitmap-table": {
                            "location": {
                                "offset": 983040,
                                "size": 8
                            },
                            "table-entries": [
                                {
                                    "cluster": {
                                        "offset": 655360,
                                        "size": 65536
                                    },
                                    "type": "serialized"
                                }
                            ]
                        },
                        "bitmap-name": "bitmap-2"
                    }
                ]
            },
            "nb-bitmaps": 2
        },
        "qcow2-header": {
            "location": {
                "offset": 0,
                "size": 65536
            },
            "version": 3
        }
    },
    "allocated-clusters": 12,
    "filename": "/home/disk",
    "format": "qcow2",
    "fragmented-clusters": 2
}

Andrey Shinkevich (3):
  qcow2: introduce Qcow2Metadata structure
  qemu-img: sort key options alphabetically
  qcow2: dump QCOW2 metadata

 block/qcow2-bitmap.c   |  54 ++++++++++++-
 block/qcow2-refcount.c |  84 ++++++++++++++++----
 block/qcow2.c          |  30 +++++++
 block/qcow2.h          |   6 +-
 include/block/block.h  |   3 +-
 qapi/block-core.json   | 209 ++++++++++++++++++++++++++++++++++++++++++++++++-
 qemu-img.c             |  50 +++++++++---
 qemu-img.texi          |   7 +-
 8 files changed, 408 insertions(+), 35 deletions(-)

-- 
1.8.3.1


