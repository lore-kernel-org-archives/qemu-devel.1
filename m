Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2CC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA4B20842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA4B20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTgJ-0005uH-Hw
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtM-0002ox-Qn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtG-0003bm-2z
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRtF-00039L-Gx; Tue, 01 Oct 2019 19:49:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NmlYw004963; Tue, 1 Oct 2019 19:48:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdfxwea5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NiSkf113972;
 Tue, 1 Oct 2019 19:47:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdfxwe9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:17 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlSx022434;
 Tue, 1 Oct 2019 23:47:16 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04dal.us.ibm.com with ESMTP id 2v9y57yd54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:16 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlGla54788522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF0172805E;
 Tue,  1 Oct 2019 23:47:15 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A26B428059;
 Tue,  1 Oct 2019 23:47:15 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:15 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/97] docs/interop/bitmaps: rewrite and modernize doc
Date: Tue,  1 Oct 2019 18:44:48 -0500
Message-Id: <20191001234616.7825-10-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This just about rewrites the entirety of the bitmaps.rst document to
make it consistent with the 4.0 release. I have added new features seen
in the 4.0 release, as well as tried to clarify some points that keep
coming up when discussing this feature both in-house and upstream.

It does not yet cover pull backups or migration details, but I intend to
keep extending this document to cover those cases.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190426221528.30293-3-jsnow@redhat.com
[Adjusted commit message. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 90edef80a0852cf8a3d2668898ee40e8970e4314)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/interop/bitmaps.rst | 1573 ++++++++++++++++++++++++++++++--------
 1 file changed, 1251 insertions(+), 322 deletions(-)

diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index 7bcfe7f461..510e8809a9 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -1,5 +1,5 @@
 ..
-   Copyright 2015 John Snow <jsnow@redhat.com> and Red Hat, Inc.
+   Copyright 2019 John Snow <jsnow@redhat.com> and Red Hat, Inc.
    All rights reserved.
 
    This file is licensed via The FreeBSD Documentation License, the full
@@ -9,547 +9,1476 @@
 Dirty Bitmaps and Incremental Backup
 ====================================
 
--  Dirty Bitmaps are objects that track which data needs to be backed up
-   for the next incremental backup.
+Dirty Bitmaps are in-memory objects that track writes to block devices. They
+can be used in conjunction with various block job operations to perform
+incremental or differential backup regimens.
 
--  Dirty bitmaps can be created at any time and attached to any node
-   (not just complete drives).
+This document explains the conceptual mechanisms, as well as up-to-date,
+complete and comprehensive documentation on the API to manipulate them.
+(Hopefully, the "why", "what", and "how".)
+
+The intended audience for this document is developers who are adding QEMU
+backup features to management applications, or power users who run and
+administer QEMU directly via QMP.
 
 .. contents::
 
+Overview
+--------
+
+Bitmaps are bit vectors where each '1' bit in the vector indicates a modified
+("dirty") segment of the corresponding block device. The size of the segment
+that is tracked is the granularity of the bitmap. If the granularity of a
+bitmap is 64K, each '1' bit means that a 64K region as a whole may have
+changed in some way, possibly by as little as one byte.
+
+Smaller granularities mean more accurate tracking of modified disk data, but
+requires more computational overhead and larger bitmap sizes. Larger
+granularities mean smaller bitmap sizes, but less targeted backups.
+
+The size of a bitmap (in bytes) can be computed as such:
+    ``size`` = ceil(ceil(``image_size`` / ``granularity``) / 8)
+
+e.g. the size of a 64KiB granularity bitmap on a 2TiB image is:
+    ``size`` = ((2147483648K / 64K) / 8)
+         = 4194304B = 4MiB.
+
+QEMU uses these bitmaps when making incremental backups to know which sections
+of the file to copy out. They are not enabled by default and must be
+explicitly added in order to begin tracking writes.
+
+Bitmaps can be created at any time and can be attached to any arbitrary block
+node in the storage graph, but are most useful conceptually when attached to
+the root node attached to the guest's storage device model.
+
+That is to say: It's likely most useful to track the guest's writes to disk,
+but you could theoretically track things like qcow2 metadata changes by
+attaching the bitmap elsewhere in the storage graph. This is beyond the scope
+of this document.
+
+QEMU supports persisting these bitmaps to disk via the qcow2 image format.
+Bitmaps which are stored or loaded in this way are called "persistent",
+whereas bitmaps that are not are called "transient".
+
+QEMU also supports the migration of both transient bitmaps (tracking any
+arbitrary image format) or persistent bitmaps (qcow2) via live migration.
+
+Supported Image Formats
+-----------------------
+
+QEMU supports all documented features below on the qcow2 image format.
+
+However, qcow2 is only strictly necessary for the persistence feature, which
+writes bitmap data to disk upon close. If persistence is not required for a
+specific use case, all bitmap features excepting persistence are available for
+any arbitrary image format.
+
+For example, Dirty Bitmaps can be combined with the 'raw' image format, but
+any changes to the bitmap will be discarded upon exit.
+
+.. warning:: Transient bitmaps will not be saved on QEMU exit! Persistent
+             bitmaps are available only on qcow2 images.
+
 Dirty Bitmap Names
 ------------------
 
--  A dirty bitmap's name is unique to the node, but bitmaps attached to
-   different nodes can share the same name.
+Bitmap objects need a method to reference them in the API. All API-created and
+managed bitmaps have a human-readable name chosen by the user at creation
+time.
 
--  Dirty bitmaps created for internal use by QEMU may be anonymous and
-   have no name, but any user-created bitmaps must have a name. There
-   can be any number of anonymous bitmaps per node.
+- A bitmap's name is unique to the node, but bitmaps attached to different
+  nodes can share the same name. Therefore, all bitmaps are addressed via
+  their (node, name) pair.
 
--  The name of a user-created bitmap must not be empty ("").
+- The name of a user-created bitmap cannot be empty ("").
 
-Bitmap Modes
-------------
+- Transient bitmaps can have JSON unicode names that are effectively not
+  length limited. (QMP protocol may restrict messages to less than 64MiB.)
+
+- Persistent storage formats may impose their own requirements on bitmap names
+  and namespaces. Presently, only qcow2 supports persistent bitmaps. See
+  docs/interop/qcow2.txt for more details on restrictions. Notably:
+
+   - qcow2 bitmap names are limited to between 1 and 1023 bytes long.
+
+   - No two bitmaps saved to the same qcow2 file may share the same name.
+
+- QEMU occasionally uses bitmaps for internal use which have no name. They are
+  hidden from API query calls, cannot be manipulated by the external API, are
+  never persistent, nor ever migrated.
+
+Bitmap Status
+-------------
+
+Dirty Bitmap objects can be queried with the QMP command `query-block
+<qemu-qmp-ref.html#index-query_002dblock>`_, and are visible via the
+`BlockDirtyInfo <qemu-qmp-ref.html#index-BlockDirtyInfo>`_ QAPI structure.
+
+This struct shows the name, granularity, and dirty byte count for each bitmap.
+Additionally, it shows several boolean status indicators:
+
+- ``recording``: This bitmap is recording writes.
+- ``busy``: This bitmap is in-use by an operation.
+- ``persistent``: This bitmap is a persistent type.
+- ``inconsistent``: This bitmap is corrupted and cannot be used.
+
+The ``+busy`` status prohibits you from deleting, clearing, or otherwise
+modifying a bitmap, and happens when the bitmap is being used for a backup
+operation or is in the process of being loaded from a migration. Many of the
+commands documented below will refuse to work on such bitmaps.
+
+The ``+inconsistent`` status similarly prohibits almost all operations,
+notably allowing only the ``block-dirty-bitmap-remove`` operation.
+
+There is also a deprecated ``status`` field of type `DirtyBitmapStatus
+<qemu-qmp-ref.html#index-DirtyBitmapStatus>`_. A bitmap historically had
+five visible states:
+
+   #. ``Frozen``: This bitmap is currently in-use by an operation and is
+      immutable. It can't be deleted, renamed, reset, etc.
+
+      (This is now ``+busy``.)
+
+   #. ``Disabled``: This bitmap is not recording new writes.
+
+      (This is now ``-recording -busy``.)
+
+   #. ``Active``: This bitmap is recording new writes.
+
+      (This is now ``+recording -busy``.)
 
--  A bitmap can be "frozen," which means that it is currently in-use by
-   a backup operation and cannot be deleted, renamed, written to, reset,
-   etc.
+   #. ``Locked``: This bitmap is in-use by an operation, and is immutable.
+      The difference from "Frozen" was primarily implementation details.
 
--  The normal operating mode for a bitmap is "active."
+      (This is now ``+busy``.)
+
+   #. ``Inconsistent``: This persistent bitmap was not saved to disk
+      correctly, and can no longer be used. It remains in memory to serve as
+      an indicator of failure.
+
+      (This is now ``+inconsistent``.)
+
+These states are directly replaced by the status indicators and should not be
+used. The difference between ``Frozen`` and ``Locked`` is an implementation
+detail and should not be relevant to external users.
 
 Basic QMP Usage
 ---------------
 
+The primary interface to manipulating bitmap objects is via the QMP
+interface. If you are not familiar, see docs/interop/qmp-intro.txt for a broad
+overview, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full reference of all
+QMP commands.
+
 Supported Commands
 ~~~~~~~~~~~~~~~~~~
 
+There are six primary bitmap-management API commands:
+
 - ``block-dirty-bitmap-add``
 - ``block-dirty-bitmap-remove``
 - ``block-dirty-bitmap-clear``
+- ``block-dirty-bitmap-disable``
+- ``block-dirty-bitmap-enable``
+- ``block-dirty-bitmap-merge``
 
-Creation
-~~~~~~~~
+And one related query command:
 
--  To create a new bitmap, enabled, on the drive with id=drive0:
+- ``query-block``
 
-.. code:: json
+Creation: block-dirty-bitmap-add
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-    { "execute": "block-dirty-bitmap-add",
-      "arguments": {
-        "node": "drive0",
-        "name": "bitmap0"
-      }
-    }
+`block-dirty-bitmap-add
+<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dadd>`_:
 
--  This bitmap will have a default granularity that matches the cluster
-   size of its associated drive, if available, clamped to between [4KiB,
-   64KiB]. The current default for qcow2 is 64KiB.
+Creates a new bitmap that tracks writes to the specified node. granularity,
+persistence, and recording state can be adjusted at creation time.
 
--  To create a new bitmap that tracks changes in 32KiB segments:
+.. admonition:: Example
 
-.. code:: json
+ to create a new, actively recording persistent bitmap:
 
-    { "execute": "block-dirty-bitmap-add",
-      "arguments": {
-        "node": "drive0",
-        "name": "bitmap0",
-        "granularity": 32768
-      }
-    }
+ .. code:: json
 
-Deletion
-~~~~~~~~
+  -> { "execute": "block-dirty-bitmap-add",
+       "arguments": {
+         "node": "drive0",
+         "name": "bitmap0",
+         "persistent": true,
+       }
+     }
 
--  Bitmaps that are frozen cannot be deleted.
+  <- { "return": {} }
 
--  Deleting the bitmap does not impact any other bitmaps attached to the
-   same node, nor does it affect any backups already created from this
-   node.
+- This bitmap will have a default granularity that matches the cluster size of
+  its associated drive, if available, clamped to between [4KiB, 64KiB]. The
+  current default for qcow2 is 64KiB.
 
--  Because bitmaps are only unique to the node to which they are
-   attached, you must specify the node/drive name here, too.
+.. admonition:: Example
 
-.. code:: json
+ To create a new, disabled (``-recording``), transient bitmap that tracks
+ changes in 32KiB segments:
 
-    { "execute": "block-dirty-bitmap-remove",
-      "arguments": {
-        "node": "drive0",
-        "name": "bitmap0"
-      }
-    }
+ .. code:: json
 
-Resetting
-~~~~~~~~~
+  -> { "execute": "block-dirty-bitmap-add",
+       "arguments": {
+         "node": "drive0",
+         "name": "bitmap1",
+         "granularity": 32768,
+         "disabled": true
+       }
+     }
 
--  Resetting a bitmap will clear all information it holds.
+  <- { "return": {} }
 
--  An incremental backup created from an empty bitmap will copy no data,
-   as if nothing has changed.
+Deletion: block-dirty-bitmap-remove
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. code:: json
+`block-dirty-bitmap-remove
+<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dremove>`_:
+
+Deletes a bitmap. Bitmaps that are ``+busy`` cannot be removed.
+
+- Deleting a bitmap does not impact any other bitmaps attached to the same
+  node, nor does it affect any backups already created from this bitmap or
+  node.
+
+- Because bitmaps are only unique to the node to which they are attached, you
+  must specify the node/drive name here, too.
+
+- Deleting a persistent bitmap will remove it from the qcow2 file.
+
+.. admonition:: Example
+
+ Remove a bitmap named ``bitmap0`` from node ``drive0``:
+
+ .. code:: json
+
+  -> { "execute": "block-dirty-bitmap-remove",
+       "arguments": {
+         "node": "drive0",
+         "name": "bitmap0"
+       }
+     }
+
+  <- { "return": {} }
+
+Resetting: block-dirty-bitmap-clear
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`block-dirty-bitmap-clear
+<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dclear>`_:
+
+Clears all dirty bits from a bitmap. ``+busy`` bitmaps cannot be cleared.
+
+- An incremental backup created from an empty bitmap will copy no data, as if
+  nothing has changed.
+
+.. admonition:: Example
+
+ Clear all dirty bits from bitmap ``bitmap0`` on node ``drive0``:
+
+ .. code:: json
+
+  -> { "execute": "block-dirty-bitmap-clear",
+       "arguments": {
+         "node": "drive0",
+         "name": "bitmap0"
+       }
+     }
+
+  <- { "return": {} }
+
+Enabling: block-dirty-bitmap-enable
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`block-dirty-bitmap-enable
+<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002denable>`_:
 
-    { "execute": "block-dirty-bitmap-clear",
-      "arguments": {
-        "node": "drive0",
-        "name": "bitmap0"
-      }
-    }
+"Enables" a bitmap, setting the ``recording`` bit to true, causing writes to
+begin being recorded. ``+busy`` bitmaps cannot be enabled.
+
+- Bitmaps default to being enabled when created, unless configured otherwise.
+
+- Persistent enabled bitmaps will remember their ``+recording`` status on
+  load.
+
+.. admonition:: Example
+
+ To set ``+recording`` on bitmap ``bitmap0`` on node ``drive0``:
+
+ .. code:: json
+
+  -> { "execute": "block-dirty-bitmap-enable",
+       "arguments": {
+         "node": "drive0",
+         "name": "bitmap0"
+       }
+     }
+
+  <- { "return": {} }
+
+Enabling: block-dirty-bitmap-disable
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`block-dirty-bitmap-disable
+<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002ddisable>`_:
+
+"Disables" a bitmap, setting the ``recording`` bit to false, causing further
+writes to begin being ignored. ``+busy`` bitmaps cannot be disabled.
+
+.. warning::
+
+  This is potentially dangerous: QEMU makes no effort to stop any writes if
+  there are disabled bitmaps on a node, and will not mark any disabled bitmaps
+  as ``+inconsistent`` if any such writes do happen. Backups made from such
+  bitmaps will not be able to be used to reconstruct a coherent image.
+
+- Disabling a bitmap may be useful for examining which sectors of a disk
+  changed during a specific time period, or for explicit management of
+  differential backup windows.
+
+- Persistent disabled bitmaps will remember their ``-recording`` status on
+  load.
+
+.. admonition:: Example
+
+ To set ``-recording`` on bitmap ``bitmap0`` on node ``drive0``:
+
+ .. code:: json
+
+  -> { "execute": "block-dirty-bitmap-disable",
+       "arguments": {
+         "node": "drive0",
+         "name": "bitmap0"
+       }
+     }
+
+  <- { "return": {} }
+
+Merging, Copying: block-dirty-bitmap-merge
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`block-dirty-bitmap-merge
+<qemu-qmp-ref.html#index-block_002ddirty_002dbitmap_002dmerge>`_:
+
+Merges one or more bitmaps into a target bitmap. For any segment that is dirty
+in any one source bitmap, the target bitmap will mark that segment dirty.
+
+- Merge takes one or more bitmaps as a source and merges them together into a
+  single destination, such that any segment marked as dirty in any source
+  bitmap(s) will be marked dirty in the destination bitmap.
+
+- Merge does not create the destination bitmap if it does not exist. A blank
+  bitmap can be created beforehand to achieve the same effect.
+
+- The destination is not cleared prior to merge, so subsequent merge
+  operations will continue to cumulatively mark more segments as dirty.
+
+- If the merge operation should fail, the destination bitmap is guaranteed to
+  be unmodified. The operation may fail if the source or destination bitmaps
+  are busy, or have different granularities.
+
+- Bitmaps can only be merged on the same node. There is only one "node"
+  argument, so all bitmaps must be attached to that same node.
+
+- Copy can be achieved by merging from a single source to an empty
+  destination.
+
+.. admonition:: Example
+
+ Merge the data from ``bitmap0`` into the bitmap ``new_bitmap`` on node
+ ``drive0``. If ``new_bitmap`` was empty prior to this command, this achieves
+ a copy.
+
+ .. code:: json
+
+  -> { "execute": "block-dirty-bitmap-merge",
+       "arguments": {
+         "node": "drive0",
+         "target": "new_bitmap",
+         "bitmaps: [ "bitmap0" ]
+       }
+     }
+
+  <- { "return": {} }
+
+Querying: query-block
+~~~~~~~~~~~~~~~~~~~~~
+
+`query-block
+<qemu-qmp-ref.html#index-query_002dblock>`_:
+
+Not strictly a bitmaps command, but will return information about any bitmaps
+attached to nodes serving as the root for guest devices.
+
+- The "inconsistent" bit will not appear when it is false, appearing only when
+  the value is true to indicate there is a problem.
+
+.. admonition:: Example
+
+ Query the block sub-system of QEMU. The following json has trimmed irrelevant
+ keys from the response to highlight only the bitmap-relevant portions of the
+ API. This result highlights a bitmap ``bitmap0`` attached to the root node of
+ device ``drive0``.
+
+ .. code:: json
+
+  -> {
+       "execute": "query-block",
+       "arguments": {}
+     }
+
+  <- {
+       "return": [ {
+         "dirty-bitmaps": [ {
+           "status": "active",
+           "count": 0,
+           "busy": false,
+           "name": "bitmap0",
+           "persistent": false,
+           "recording": true,
+           "granularity": 65536
+         } ],
+         "device": "drive0",
+       } ]
+     }
+
+Bitmap Persistence
+------------------
+
+As outlined in `Supported Image Formats`_, QEMU can persist bitmaps to qcow2
+files. Demonstrated in `Creation: block-dirty-bitmap-add`_, passing
+``persistent: true`` to ``block-dirty-bitmap-add`` will persist that bitmap to
+disk.
+
+Persistent bitmaps will be automatically loaded into memory upon load, and
+will be written back to disk upon close. Their usage should be mostly
+transparent.
+
+However, if QEMU does not get a chance to close the file cleanly, the bitmap
+will be marked as ``+inconsistent`` at next load and considered unsafe to use
+for any operation. At this point, the only valid operation on such bitmaps is
+``block-dirty-bitmap-remove``.
+
+Losing a bitmap in this way does not invalidate any existing backups that have
+been made from this bitmap, but no further backups will be able to be issued
+for this chain.
 
 Transactions
 ------------
 
+Transactions are a QMP feature that allows you to submit multiple QMP commands
+at once, being guaranteed that they will all succeed or fail atomically,
+together. The interaction of bitmaps and transactions are demonstrated below.
+
+See `transaction <qemu-qmp.ref.html#index-transaction>`_ in the QMP reference
+for more details.
+
 Justification
 ~~~~~~~~~~~~~
 
-Bitmaps can be safely modified when the VM is paused or halted by using
-the basic QMP commands. For instance, you might perform the following
-actions:
+Bitmaps can generally be modified at any time, but certain operations often
+only make sense when paired directly with other commands. When a VM is paused,
+it's easy to ensure that no guest writes occur between individual QMP
+commands. When a VM is running, this is difficult to accomplish with
+individual QMP commands that may allow guest writes to occur inbetween each
+command.
 
-1. Boot the VM in a paused state.
-2. Create a full drive backup of drive0.
-3. Create a new bitmap attached to drive0.
-4. Resume execution of the VM.
-5. Incremental backups are ready to be created.
+For example, using only individual QMP commands, we could:
 
-At this point, the bitmap and drive backup would be correctly in sync,
-and incremental backups made from this point forward would be correctly
-aligned to the full drive backup.
+#. Boot the VM in a paused state.
+#. Create a full drive backup of drive0.
+#. Create a new bitmap attached to drive0, confident that nothing has been
+   written to drive0 in the meantime.
+#. Resume execution of the VM.
+#. At a later point, issue incremental backups from ``bitmap0``.
 
-This is not particularly useful if we decide we want to start
-incremental backups after the VM has been running for a while, for which
-we will need to perform actions such as the following:
+At this point, the bitmap and drive backup would be correctly in sync, and
+incremental backups made from this point forward would be correctly aligned to
+the full drive backup.
 
-1. Boot the VM and begin execution.
-2. Using a single transaction, perform the following operations:
+This is not particularly useful if we decide we want to start incremental
+backups after the VM has been running for a while, for which we would want to
+perform actions such as the following:
+
+#. Boot the VM and begin execution.
+#. Using a single transaction, perform the following operations:
 
    -  Create ``bitmap0``.
    -  Create a full drive backup of ``drive0``.
 
-3. Incremental backups are now ready to be created.
+#. At a later point, issue incremental backups from ``bitmap0``.
+
+.. note:: As a consideration, if ``bitmap0`` is created prior to the full
+          drive backup, incremental backups can still be authored from this
+          bitmap, but they will copy extra segments reflecting writes that
+          occurred prior to the backup operation. Transactions allow us to
+          narrow critical points in time to reduce waste, or, in the other
+          direction, to ensure that no segments are omitted.
 
 Supported Bitmap Transactions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 -  ``block-dirty-bitmap-add``
 -  ``block-dirty-bitmap-clear``
+-  ``block-dirty-bitmap-enable``
+-  ``block-dirty-bitmap-disable``
+-  ``block-dirty-bitmap-merge``
 
-The usages are identical to their respective QMP commands, but see below
-for examples.
+The usages for these commands are identical to their respective QMP commands,
+but see the sections below for concrete examples.
 
-Example: New Incremental Backup
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Incremental Backups - Push Model
+--------------------------------
 
-As outlined in the justification, perhaps we want to create a new
-incremental backup chain attached to a drive.
+Incremental backups are simply partial disk images that can be combined with
+other partial disk images on top of a base image to reconstruct a full backup
+from the point in time at which the incremental backup was issued.
 
-.. code:: json
+The "Push Model" here references the fact that QEMU is "pushing" the modified
+blocks out to a destination. We will be using the `drive-backup
+<qemu-qmp-ref.html#index-drive_002dbackup>`_ and `blockdev-backup
+<qemu-qmp-ref.html#index-blockdev_002dbackup>`_ QMP commands to create both
+full and incremental backups.
 
-    { "execute": "transaction",
-      "arguments": {
-        "actions": [
-          {"type": "block-dirty-bitmap-add",
-           "data": {"node": "drive0", "name": "bitmap0"} },
-          {"type": "drive-backup",
-           "data": {"device": "drive0", "target": "/path/to/full_backup.img",
-                    "sync": "full", "format": "qcow2"} }
-        ]
-      }
-    }
+Both of these commands are jobs, which have their own QMP API for querying and
+management documented in `Background jobs
+<qemu-qmp-ref.html#Background-jobs>`_.
 
 Example: New Incremental Backup Anchor Point
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Maybe we just want to create a new full backup with an existing bitmap
-and want to reset the bitmap to track the new chain.
+As outlined in the Transactions - `Justification`_ section, perhaps we want to
+create a new incremental backup chain attached to a drive.
+
+This example creates a new, full backup of "drive0" and accompanies it with a
+new, empty bitmap that records writes from this point in time forward.
+
+.. note:: Any new writes that happen after this command is issued, even while
+          the backup job runs, will be written locally and not to the backup
+          destination. These writes will be recorded in the bitmap
+          accordingly.
+
+.. code:: json
+
+  -> {
+       "execute": "transaction",
+       "arguments": {
+         "actions": [
+           {
+             "type": "block-dirty-bitmap-add",
+             "data": {
+               "node": "drive0",
+               "name": "bitmap0"
+             }
+           },
+           {
+             "type": "drive-backup",
+             "data": {
+               "device": "drive0",
+               "target": "/path/to/drive0.full.qcow2",
+               "sync": "full",
+               "format": "qcow2"
+             }
+           }
+         ]
+       }
+     }
+
+  <- { "return": {} }
+
+  <- {
+       "timestamp": {
+         "seconds": 1555436945,
+         "microseconds": 179620
+       },
+       "data": {
+         "status": "created",
+         "id": "drive0"
+       },
+       "event": "JOB_STATUS_CHANGE"
+     }
+
+  ...
+
+  <- {
+       "timestamp": {...},
+       "data": {
+         "device": "drive0",
+         "type": "backup",
+         "speed": 0,
+         "len": 68719476736,
+         "offset": 68719476736
+       },
+       "event": "BLOCK_JOB_COMPLETED"
+     }
+
+  <- {
+       "timestamp": {...},
+       "data": {
+         "status": "concluded",
+         "id": "drive0"
+       },
+       "event": "JOB_STATUS_CHANGE"
+     }
+
+  <- {
+       "timestamp": {...},
+       "data": {
+         "status": "null",
+         "id": "drive0"
+       },
+       "event": "JOB_STATUS_CHANGE"
+     }
+
+A full explanation of the job transition semantics and the JOB_STATUS_CHANGE
+event are beyond the scope of this document and will be omitted in all
+subsequent examples; above, several more events have been omitted for brevity.
+
+.. note:: Subsequent examples will omit all events except BLOCK_JOB_COMPLETED
+          except where necessary to illustrate workflow differences.
+
+          Omitted events and json objects will be represented by ellipses:
+          ``...``
+
+Example: Resetting an Incremental Backup Anchor Point
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If we want to start a new backup chain with an existing bitmap, we can also
+use a transaction to reset the bitmap while making a new full backup:
 
 .. code:: json
 
-    { "execute": "transaction",
-      "arguments": {
-        "actions": [
-          {"type": "block-dirty-bitmap-clear",
-           "data": {"node": "drive0", "name": "bitmap0"} },
-          {"type": "drive-backup",
-           "data": {"device": "drive0", "target": "/path/to/new_full_backup.img",
-                    "sync": "full", "format": "qcow2"} }
-        ]
-      }
-    }
-
-Incremental Backups
--------------------
-
-The star of the show.
-
-**Nota Bene!** Only incremental backups of entire drives are supported
-for now. So despite the fact that you can attach a bitmap to any
-arbitrary node, they are only currently useful when attached to the root
-node. This is because drive-backup only supports drives/devices instead
-of arbitrary nodes.
+  -> {
+       "execute": "transaction",
+       "arguments": {
+         "actions": [
+         {
+           "type": "block-dirty-bitmap-clear",
+           "data": {
+             "node": "drive0",
+             "name": "bitmap0"
+           }
+         },
+         {
+           "type": "drive-backup",
+           "data": {
+             "device": "drive0",
+             "target": "/path/to/drive0.new_full.qcow2",
+             "sync": "full",
+             "format": "qcow2"
+           }
+         }
+       ]
+     }
+   }
+
+  <- { "return": {} }
+
+  ...
+
+  <- {
+       "timestamp": {...},
+       "data": {
+         "device": "drive0",
+         "type": "backup",
+         "speed": 0,
+         "len": 68719476736,
+         "offset": 68719476736
+       },
+       "event": "BLOCK_JOB_COMPLETED"
+     }
+
+  ...
+
+The result of this example is identical to the first, but we clear an existing
+bitmap instead of adding a new one.
+
+.. tip:: In both of these examples, "bitmap0" is tied conceptually to the
+         creation of new, full backups. This relationship is not saved or
+         remembered by QEMU; it is up to the operator or management layer to
+         remember which bitmaps are associated with which backups.
 
 Example: First Incremental Backup
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-1. Create a full backup and sync it to the dirty bitmap, as in the
-   transactional examples above; or with the VM offline, manually create
-   a full copy and then create a new bitmap before the VM begins
-   execution.
+#. Create a full backup and sync it to a dirty bitmap using any method:
 
-   -  Let's assume the full backup is named ``full_backup.img``.
-   -  Let's assume the bitmap you created is ``bitmap0`` attached to
-      ``drive0``.
+   - Either of the two live backup method demonstrated above,
+   - Using QMP commands with the VM paused as in the `Justification`_ section,
+     or
+   - With the VM offline, manually copy the image and start the VM in a paused
+     state, careful to add a new bitmap before the VM begins execution.
 
-2. Create a destination image for the incremental backup that utilizes
-   the full backup as a backing image.
+   Whichever method is chosen, let's assume that at the end of this step:
 
-   -  Let's assume the new incremental image is named
-      ``incremental.0.img``.
+   - The full backup is named ``drive0.full.qcow2``.
+   - The bitmap we created is named ``bitmap0``, attached to ``drive0``.
+
+#. Create a destination image for the incremental backup that utilizes the
+   full backup as a backing image.
+
+   - Let's assume the new incremental image is named ``drive0.inc0.qcow2``:
 
    .. code:: bash
 
-       $ qemu-img create -f qcow2 incremental.0.img -b full_backup.img -F qcow2
+       $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
+         -b drive0.full.qcow2 -F qcow2
 
-3. Issue the incremental backup command:
+#. Issue an incremental backup command:
 
    .. code:: json
 
-       { "execute": "drive-backup",
+    -> {
+         "execute": "drive-backup",
          "arguments": {
            "device": "drive0",
            "bitmap": "bitmap0",
-           "target": "incremental.0.img",
+           "target": "drive0.inc0.qcow2",
            "format": "qcow2",
            "sync": "incremental",
            "mode": "existing"
          }
        }
 
+    <- { "return": {} }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
+
+This copies any blocks modified since the full backup was created into the
+``drive0.inc0.qcow2`` file. During the operation, ``bitmap0`` is marked
+``+busy``. If the operation is successful, ``bitmap0`` will be cleared to
+reflect the "incremental" backup regimen, which only copies out new changes
+from each incremental backup.
+
+.. note:: Any new writes that occur after the backup operation starts do not
+          get copied to the destination. The backup's "point in time" is when
+          the backup starts, not when it ends. These writes are recorded in a
+          special bitmap that gets re-added to bitmap0 when the backup ends so
+          that the next incremental backup can copy them out.
+
 Example: Second Incremental Backup
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-1. Create a new destination image for the incremental backup that points
-   to the previous one, e.g.: ``incremental.1.img``
+#. Create a new destination image for the incremental backup that points to
+   the previous one, e.g.: ``drive0.inc1.qcow2``
 
    .. code:: bash
 
-       $ qemu-img create -f qcow2 incremental.1.img -b incremental.0.img -F qcow2
+       $ qemu-img create -f qcow2 drive0.inc1.qcow2 \
+         -b drive0.inc0.qcow2 -F qcow2
 
-2. Issue a new incremental backup command. The only difference here is
-   that we have changed the target image below.
+#. Issue a new incremental backup command. The only difference here is that we
+   have changed the target image below.
 
    .. code:: json
 
-       { "execute": "drive-backup",
+    -> {
+         "execute": "drive-backup",
          "arguments": {
            "device": "drive0",
            "bitmap": "bitmap0",
-           "target": "incremental.1.img",
+           "target": "drive0.inc1.qcow2",
            "format": "qcow2",
            "sync": "incremental",
            "mode": "existing"
          }
        }
 
-Errors
-------
+    <- { "return": {} }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
+
+Because the first incremental backup from the previous example completed
+successfully, ``bitmap0`` was synchronized with ``drive0.inc0.qcow2``. Here,
+we use ``bitmap0`` again to create a new incremental backup that targets the
+previous one, creating a chain of three images:
+
+.. admonition:: Diagram
+
+ .. code:: text
+
+   +-------------------+   +-------------------+   +-------------------+
+   | drive0.full.qcow2 |<--| drive0.inc0.qcow2 |<--| drive0.inc1.qcow2 |
+   +-------------------+   +-------------------+   +-------------------+
+
+Each new incremental backup re-synchronizes the bitmap to the latest backup
+authored, allowing a user to continue to "consume" it to create new backups on
+top of an existing chain.
+
+In the above diagram, neither drive0.inc1.qcow2 nor drive0.inc0.qcow2 are
+complete images by themselves, but rely on their backing chain to reconstruct
+a full image. The dependency terminates with each full backup.
+
+Each backup in this chain remains independent, and is unchanged by new entries
+made later in the chain. For instance, drive0.inc0.qcow2 remains a perfectly
+valid backup of the disk as it was when that backup was issued.
+
+Example: Incremental Push Backups without Backing Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Backup images are best kept off-site, so we often will not have the preceding
+backups in a chain available to link against. This is not a problem at backup
+time; we simply do not set the backing image when creating the destination
+image:
+
+#. Create a new destination image with no backing file set. We will need to
+   specify the size of the base image, because the backing file isn't
+   available for QEMU to use to determine it.
+
+   .. code:: bash
+
+       $ qemu-img create -f qcow2 drive0.inc2.qcow2 64G
+
+   .. note:: Alternatively, you can omit ``mode: "existing"`` from the push
+             backup commands to have QEMU create an image without a backing
+             file for you, but you lose control over format options like
+             compatibility and preallocation presets.
+
+#. Issue a new incremental backup command. Apart from the new destination
+   image, there is no difference from the last two examples.
+
+   .. code:: json
+
+    -> {
+         "execute": "drive-backup",
+         "arguments": {
+           "device": "drive0",
+           "bitmap": "bitmap0",
+           "target": "drive0.inc2.qcow2",
+           "format": "qcow2",
+           "sync": "incremental",
+           "mode": "existing"
+         }
+       }
+
+    <- { "return": {} }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
+
+The only difference from the perspective of the user is that you will need to
+set the backing image when attempting to restore the backup:
+
+.. code:: bash
+
+    $ qemu-img rebase drive0.inc2.qcow2 \
+      -u -b drive0.inc1.qcow2
+
+This uses the "unsafe" rebase mode to simply set the backing file to a file
+that isn't present.
+
+It is also possible to use ``--image-opts`` to specify the entire backing
+chain by hand as an ephemeral property at runtime, but that is beyond the
+scope of this document.
+
+Example: Multi-drive Incremental Backup
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Assume we have a VM with two drives, "drive0" and "drive1" and we wish to back
+both of them up such that the two backups represent the same crash-consistent
+point in time.
+
+#. For each drive, create an empty image:
+
+   .. code:: bash
+
+    $ qemu-img create -f qcow2 drive0.full.qcow2 64G
+    $ qemu-img create -f qcow2 drive1.full.qcow2 64G
+
+#. Create a full (anchor) backup for each drive, with accompanying bitmaps:
+
+   .. code:: json
+
+    -> {
+         "execute": "transaction",
+         "arguments": {
+           "actions": [
+             {
+               "type": "block-dirty-bitmap-add",
+               "data": {
+                 "node": "drive0",
+                 "name": "bitmap0"
+               }
+             },
+             {
+               "type": "block-dirty-bitmap-add",
+               "data": {
+                 "node": "drive1",
+                 "name": "bitmap0"
+               }
+             },
+             {
+               "type": "drive-backup",
+               "data": {
+                 "device": "drive0",
+                 "target": "/path/to/drive0.full.qcow2",
+                 "sync": "full",
+                 "format": "qcow2"
+               }
+             },
+             {
+               "type": "drive-backup",
+               "data": {
+                 "device": "drive1",
+                 "target": "/path/to/drive1.full.qcow2",
+                 "sync": "full",
+                 "format": "qcow2"
+               }
+             }
+           ]
+         }
+       }
+
+    <- { "return": {} }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive1",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
+
+#. Later, create new destination images for each of the incremental backups
+   that point to their respective full backups:
+
+   .. code:: bash
+
+     $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
+       -b drive0.full.qcow2 -F qcow2
+     $ qemu-img create -f qcow2 drive1.inc0.qcow2 \
+       -b drive1.full.qcow2 -F qcow2
+
+#. Issue a multi-drive incremental push backup transaction:
+
+   .. code:: json
+
+    -> {
+         "execute": "transaction",
+         "arguments": {
+           "actions": [
+             {
+               "type": "drive-backup",
+               "data": {
+                 "device": "drive0",
+                 "bitmap": "bitmap0",
+                 "format": "qcow2",
+                 "mode": "existing",
+                 "sync": "incremental",
+                 "target": "drive0.inc0.qcow2"
+               }
+             },
+             {
+               "type": "drive-backup",
+               "data": {
+                 "device": "drive1",
+                 "bitmap": "bitmap0",
+                 "format": "qcow2",
+                 "mode": "existing",
+                 "sync": "incremental",
+                 "target": "drive1.inc0.qcow2"
+               }
+             },
+           ]
+         }
+       }
+
+    <- { "return": {} }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive1",
+           "type": "backup",
+           "speed": 0,
+           "len": 68719476736,
+           "offset": 68719476736
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
+
+    ...
 
--  In the event of an error that occurs after a backup job is
-   successfully launched, either by a direct QMP command or a QMP
-   transaction, the user will receive a ``BLOCK_JOB_COMPLETE`` event with
-   a failure message, accompanied by a ``BLOCK_JOB_ERROR`` event.
+Push Backup Errors & Recovery
+-----------------------------
 
--  In the case of an event being cancelled, the user will receive a
-   ``BLOCK_JOB_CANCELLED`` event instead of a pair of COMPLETE and ERROR
-   events.
+In the event of an error that occurs after a push backup job is successfully
+launched, either by an individual QMP command or a QMP transaction, the user
+will receive a ``BLOCK_JOB_COMPLETE`` event with a failure message,
+accompanied by a ``BLOCK_JOB_ERROR`` event.
 
--  In either case, the incremental backup data contained within the
-   bitmap is safely rolled back, and the data within the bitmap is not
-   lost. The image file created for the failed attempt can be safely
-   deleted.
+In the case of a job being cancelled, the user will receive a
+``BLOCK_JOB_CANCELLED`` event instead of a pair of COMPLETE and ERROR
+events.
 
--  Once the underlying problem is fixed (e.g. more storage space is
-   freed up), you can simply retry the incremental backup command with
-   the same bitmap.
+In either failure case, the bitmap used for the failed operation is not
+cleared. It will contain all of the dirty bits it did at the start of the
+operation, plus any new bits that got marked during the operation.
 
-Example
-~~~~~~~
+Effectively, the "point in time" that a bitmap is recording differences
+against is kept at the issuance of the last successful incremental backup,
+instead of being moved forward to the start of this now-failed backup.
 
-1. Create a target image:
+Once the underlying problem is addressed (e.g. more storage space is allocated
+on the destination), the incremental backup command can be retried with the
+same bitmap.
+
+Example: Individual Failures
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Incremental Push Backup jobs that fail individually behave simply as
+described above. This example demonstrates the single-job failure case:
+
+#. Create a target image:
 
    .. code:: bash
 
-       $ qemu-img create -f qcow2 incremental.0.img -b full_backup.img -F qcow2
+       $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
+         -b drive0.full.qcow2 -F qcow2
 
-2. Attempt to create an incremental backup via QMP:
+#. Attempt to create an incremental backup via QMP:
 
    .. code:: json
 
-       { "execute": "drive-backup",
+    -> {
+         "execute": "drive-backup",
          "arguments": {
            "device": "drive0",
            "bitmap": "bitmap0",
-           "target": "incremental.0.img",
+           "target": "drive0.inc0.qcow2",
            "format": "qcow2",
            "sync": "incremental",
            "mode": "existing"
          }
        }
 
-3. Receive an event notifying us of failure:
+    <- { "return": {} }
+
+#. Receive a pair of events indicating failure:
 
    .. code:: json
 
-       { "timestamp": { "seconds": 1424709442, "microseconds": 844524 },
-         "data": { "speed": 0, "offset": 0, "len": 67108864,
-                   "error": "No space left on device",
-                   "device": "drive1", "type": "backup" },
-         "event": "BLOCK_JOB_COMPLETED" }
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "action": "report",
+           "operation": "write"
+         },
+         "event": "BLOCK_JOB_ERROR"
+       }
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "speed": 0,
+           "offset": 0,
+           "len": 67108864,
+           "error": "No space left on device",
+           "device": "drive0",
+           "type": "backup"
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
 
-4. Delete the failed incremental, and re-create the image.
+#. Delete the failed image, and re-create it.
 
    .. code:: bash
 
-       $ rm incremental.0.img
-       $ qemu-img create -f qcow2 incremental.0.img -b full_backup.img -F qcow2
+       $ rm drive0.inc0.qcow2
+       $ qemu-img create -f qcow2 drive0.inc0.qcow2 \
+         -b drive0.full.qcow2 -F qcow2
 
-5. Retry the command after fixing the underlying problem, such as
+#. Retry the command after fixing the underlying problem, such as
    freeing up space on the backup volume:
 
    .. code:: json
 
-       { "execute": "drive-backup",
+    -> {
+         "execute": "drive-backup",
          "arguments": {
            "device": "drive0",
            "bitmap": "bitmap0",
-           "target": "incremental.0.img",
+           "target": "drive0.inc0.qcow2",
            "format": "qcow2",
            "sync": "incremental",
            "mode": "existing"
          }
        }
 
-6. Receive confirmation that the job completed successfully:
+    <- { "return": {} }
+
+#. Receive confirmation that the job completed successfully:
 
    .. code:: json
 
-       { "timestamp": { "seconds": 1424709668, "microseconds": 526525 },
-         "data": { "device": "drive1", "type": "backup",
-                   "speed": 0, "len": 67108864, "offset": 67108864},
-         "event": "BLOCK_JOB_COMPLETED" }
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 67108864,
+           "offset": 67108864
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
 
-Partial Transactional Failures
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Example: Partial Transactional Failures
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
--  Sometimes, a transaction will succeed in launching and return
-   success, but then later the backup jobs themselves may fail. It is
-   possible that a management application may have to deal with a
-   partial backup failure after a successful transaction.
+QMP commands like `drive-backup <qemu-qmp-ref.html#index-drive_002dbackup>`_
+conceptually only start a job, and so transactions containing these commands
+may succeed even if the job it created later fails. This might have surprising
+interactions with notions of how a "transaction" ought to behave.
 
--  If multiple backup jobs are specified in a single transaction, when
-   one of them fails, it will not interact with the other backup jobs in
-   any way.
+This distinction means that on occasion, a transaction containing such job
+launching commands may appear to succeed and return success, but later
+individual jobs associated with the transaction may fail. It is possible that
+a management application may have to deal with a partial backup failure after
+a "successful" transaction.
 
--  The job(s) that succeeded will clear the dirty bitmap associated with
-   the operation, but the job(s) that failed will not. It is not "safe"
-   to delete any incremental backups that were created successfully in
-   this scenario, even though others failed.
+If multiple backup jobs are specified in a single transaction, if one of those
+jobs fails, it will not interact with the other backup jobs in any way by
+default. The job(s) that succeeded will clear the dirty bitmap associated with
+the operation, but the job(s) that failed will not. It is therefore not safe
+to delete any incremental backups that were created successfully in this
+scenario, even though others failed.
 
-Example
-^^^^^^^
+This example illustrates a transaction with two backup jobs, where one fails
+and one succeeds:
 
--  QMP example highlighting two backup jobs:
+#. Issue the transaction to start a backup of both drives.
 
    .. code:: json
 
-       { "execute": "transaction",
+    -> {
+         "execute": "transaction",
          "arguments": {
            "actions": [
-             { "type": "drive-backup",
-               "data": { "device": "drive0", "bitmap": "bitmap0",
-                         "format": "qcow2", "mode": "existing",
-                         "sync": "incremental", "target": "d0-incr-1.qcow2" } },
-             { "type": "drive-backup",
-               "data": { "device": "drive1", "bitmap": "bitmap1",
-                         "format": "qcow2", "mode": "existing",
-                         "sync": "incremental", "target": "d1-incr-1.qcow2" } },
-           ]
+           {
+             "type": "drive-backup",
+             "data": {
+               "device": "drive0",
+               "bitmap": "bitmap0",
+               "format": "qcow2",
+               "mode": "existing",
+               "sync": "incremental",
+               "target": "drive0.inc0.qcow2"
+             }
+           },
+           {
+             "type": "drive-backup",
+             "data": {
+               "device": "drive1",
+               "bitmap": "bitmap0",
+               "format": "qcow2",
+               "mode": "existing",
+               "sync": "incremental",
+               "target": "drive1.inc0.qcow2"
+             }
+           }]
          }
        }
 
--  QMP example response, highlighting one success and one failure:
+#. Receive notice that the Transaction was accepted, and jobs were
+   launched:
 
-   -  Acknowledgement that the Transaction was accepted and jobs were
-      launched:
+   .. code:: json
 
-      .. code:: json
+    <- { "return": {} }
 
-          { "return": {} }
+#. Receive notice that the first job has completed:
 
-   -  Later, QEMU sends notice that the first job was completed:
+   .. code:: json
 
-      .. code:: json
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 67108864,
+           "offset": 67108864
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
 
-          { "timestamp": { "seconds": 1447192343, "microseconds": 615698 },
-            "data": { "device": "drive0", "type": "backup",
-                       "speed": 0, "len": 67108864, "offset": 67108864 },
-            "event": "BLOCK_JOB_COMPLETED"
-          }
+#. Receive notice that the second job has failed:
 
-   -  Later yet, QEMU sends notice that the second job has failed:
+   .. code:: json
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive1",
+           "action": "report",
+           "operation": "read"
+         },
+         "event": "BLOCK_JOB_ERROR"
+       }
+
+    ...
+
+    <- {
+         "timestamp": {...},
+         "data": {
+           "speed": 0,
+           "offset": 0,
+           "len": 67108864,
+           "error": "Input/output error",
+           "device": "drive1",
+           "type": "backup"
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
 
-      .. code:: json
+At the conclusion of the above example, ``drive0.inc0.qcow2`` is valid and
+must be kept, but ``drive1.inc0.qcow2`` is incomplete and should be
+deleted. If a VM-wide incremental backup of all drives at a point-in-time is
+to be made, new backups for both drives will need to be made, taking into
+account that a new incremental backup for drive0 needs to be based on top of
+``drive0.inc0.qcow2``.
 
-          { "timestamp": { "seconds": 1447192399, "microseconds": 683015 },
-            "data": { "device": "drive1", "action": "report",
-                      "operation": "read" },
-            "event": "BLOCK_JOB_ERROR" }
+For this example, an incremental backup for ``drive0`` was created, but not
+for ``drive1``. The last VM-wide crash-consistent backup that is available in
+this case is the full backup:
 
-      .. code:: json
+.. code:: text
 
-          { "timestamp": { "seconds": 1447192399, "microseconds":
-          685853 }, "data": { "speed": 0, "offset": 0, "len": 67108864,
-          "error": "Input/output error", "device": "drive1", "type":
-          "backup" }, "event": "BLOCK_JOB_COMPLETED" }
+          [drive0.full.qcow2] <-- [drive0.inc0.qcow2]
+          [drive1.full.qcow2]
 
--  In the above example, ``d0-incr-1.qcow2`` is valid and must be kept,
-   but ``d1-incr-1.qcow2`` is invalid and should be deleted. If a VM-wide
-   incremental backup of all drives at a point-in-time is to be made,
-   new backups for both drives will need to be made, taking into account
-   that a new incremental backup for drive0 needs to be based on top of
-   ``d0-incr-1.qcow2``.
+To repair this, issue a new incremental backup across both drives. The result
+will be backup chains that resemble the following:
 
-Grouped Completion Mode
-~~~~~~~~~~~~~~~~~~~~~~~
+.. code:: text
 
--  While jobs launched by transactions normally complete or fail on
-   their own, it is possible to instruct them to complete or fail
-   together as a group.
+          [drive0.full.qcow2] <-- [drive0.inc0.qcow2] <-- [drive0.inc1.qcow2]
+          [drive1.full.qcow2] <-------------------------- [drive1.inc1.qcow2]
 
--  QMP transactions take an optional properties structure that can
-   affect the semantics of the transaction.
+Example: Grouped Completion Mode
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
--  The "completion-mode" transaction property can be either "individual"
-   which is the default, legacy behavior described above, or "grouped,"
-   a new behavior detailed below.
+While jobs launched by transactions normally complete or fail individually,
+it's possible to instruct them to complete or fail together as a group. QMP
+transactions take an optional properties structure that can affect the
+behavior of the transaction.
 
--  Delayed Completion: In grouped completion mode, no jobs will report
-   success until all jobs are ready to report success.
+The ``completion-mode`` transaction property can be either ``individual``
+which is the default legacy behavior described above, or ``grouped``, detailed
+below.
 
--  Grouped failure: If any job fails in grouped completion mode, all
-   remaining jobs will be cancelled. Any incremental backups will
-   restore their dirty bitmap objects as if no backup command was ever
-   issued.
+In ``grouped`` completion mode, no jobs will report success until all jobs are
+ready to report success. If any job fails, all other jobs will be cancelled.
 
-   -  Regardless of if QEMU reports a particular incremental backup job
-      as CANCELLED or as an ERROR, the in-memory bitmap will be
-      restored.
+Regardless of if a participating incremental backup job failed or was
+cancelled, their associated bitmaps will all be held at their existing
+points-in-time, as in individual failure cases.
 
-Example
-^^^^^^^
+Here's the same multi-drive backup scenario from `Example: Partial
+Transactional Failures`_, but with the ``grouped`` completion-mode property
+applied:
 
--  Here's the same example scenario from above with the new property:
+#. Issue the multi-drive incremental backup transaction:
 
    .. code:: json
 
-       { "execute": "transaction",
+    -> {
+         "execute": "transaction",
          "arguments": {
-           "actions": [
-             { "type": "drive-backup",
-               "data": { "device": "drive0", "bitmap": "bitmap0",
-                         "format": "qcow2", "mode": "existing",
-                         "sync": "incremental", "target": "d0-incr-1.qcow2" } },
-             { "type": "drive-backup",
-               "data": { "device": "drive1", "bitmap": "bitmap1",
-                         "format": "qcow2", "mode": "existing",
-                         "sync": "incremental", "target": "d1-incr-1.qcow2" } },
-           ],
            "properties": {
              "completion-mode": "grouped"
-           }
+           },
+           "actions": [
+           {
+             "type": "drive-backup",
+             "data": {
+               "device": "drive0",
+               "bitmap": "bitmap0",
+               "format": "qcow2",
+               "mode": "existing",
+               "sync": "incremental",
+               "target": "drive0.inc0.qcow2"
+             }
+           },
+           {
+             "type": "drive-backup",
+             "data": {
+               "device": "drive1",
+               "bitmap": "bitmap0",
+               "format": "qcow2",
+               "mode": "existing",
+               "sync": "incremental",
+               "target": "drive1.inc0.qcow2"
+             }
+           }]
          }
        }
 
--  QMP example response, highlighting a failure for ``drive2``:
+#. Receive notice that the Transaction was accepted, and jobs were launched:
 
-   -  Acknowledgement that the Transaction was accepted and jobs were
-      launched:
+   .. code:: json
+
+    <- { "return": {} }
 
-      .. code:: json
+#. Receive notification that the backup job for ``drive1`` has failed:
 
-          { "return": {} }
+   .. code:: json
 
-   -  Later, QEMU sends notice that the second job has errored out, but
-      that the first job was also cancelled:
+    <- {
+         "timestamp": {...},
+         "data": {
+           "device": "drive1",
+           "action": "report",
+           "operation": "read"
+         },
+         "event": "BLOCK_JOB_ERROR"
+       }
 
-      .. code:: json
+    <- {
+         "timestamp": {...},
+         "data": {
+           "speed": 0,
+           "offset": 0,
+           "len": 67108864,
+           "error": "Input/output error",
+           "device": "drive1",
+           "type": "backup"
+         },
+         "event": "BLOCK_JOB_COMPLETED"
+       }
 
-          { "timestamp": { "seconds": 1447193702, "microseconds": 632377 },
-            "data": { "device": "drive1", "action": "report",
-                      "operation": "read" },
-            "event": "BLOCK_JOB_ERROR" }
+#. Receive notification that the job for ``drive0`` has been cancelled:
 
-      .. code:: json
+   .. code:: json
 
-          { "timestamp": { "seconds": 1447193702, "microseconds": 640074 },
-            "data": { "speed": 0, "offset": 0, "len": 67108864,
-                      "error": "Input/output error",
-                      "device": "drive1", "type": "backup" },
-            "event": "BLOCK_JOB_COMPLETED" }
+    <- {
+         "timestamp": {...}
+         "data": {
+           "device": "drive0",
+           "type": "backup",
+           "speed": 0,
+           "len": 67108864,
+           "offset": 16777216
+         },
+         "event": "BLOCK_JOB_CANCELLED"
+       }
 
-      .. code:: json
+At the conclusion of *this* example, both jobs have been aborted due to a
+failure. Both destination images should be deleted and are no longer of use.
 
-          { "timestamp": { "seconds": 1447193702, "microseconds": 640163 },
-            "data": { "device": "drive0", "type": "backup", "speed": 0,
-                      "len": 67108864, "offset": 16777216 },
-            "event": "BLOCK_JOB_CANCELLED" }
+The transaction as a whole can simply be re-issued at a later time.
 
 .. raw:: html
 
    <!--
    The FreeBSD Documentation License
 
-   Redistribution and use in source (Markdown) and 'compiled' forms (SGML, HTML,
-   PDF, PostScript, RTF and so forth) with or without modification, are permitted
-   provided that the following conditions are met:
-
-   Redistributions of source code (Markdown) must retain the above copyright
-   notice, this list of conditions and the following disclaimer of this file
-   unmodified.
-
-   Redistributions in compiled form (transformed to other DTDs, converted to PDF,
-   PostScript, RTF and other formats) must reproduce the above copyright notice,
-   this list of conditions and the following disclaimer in the documentation and/or
-   other materials provided with the distribution.
-
-   THIS DOCUMENTATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE
-   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS  BE LIABLE
-   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
-   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
-   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
-   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
-   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
-   THIS DOCUMENTATION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+   Redistribution and use in source (ReST) and 'compiled' forms (SGML, HTML,
+   PDF, PostScript, RTF and so forth) with or without modification, are
+   permitted provided that the following conditions are met:
+
+   Redistributions of source code (ReST) must retain the above copyright notice,
+   this list of conditions and the following disclaimer of this file unmodified.
+
+   Redistributions in compiled form (transformed to other DTDs, converted to
+   PDF, PostScript, RTF and other formats) must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+
+   THIS DOCUMENTATION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
+   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+   ARISING IN ANY WAY OUT OF THE USE OF THIS DOCUMENTATION, EVEN IF ADVISED OF
+   THE POSSIBILITY OF SUCH DAMAGE.
    -->
-- 
2.17.1


