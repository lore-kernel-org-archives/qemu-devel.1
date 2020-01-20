Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECA3C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CA122522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="VGgTO905"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CA122522
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itieI-0001qp-GO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <8ceecb7fb9fdbeabbe55c04339349a36929fb8e3@lizzy.crudebyte.com>)
 id 1itiXW-00054f-8d
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <8ceecb7fb9fdbeabbe55c04339349a36929fb8e3@lizzy.crudebyte.com>)
 id 1itiXU-00053G-0w
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:41:10 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:58389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <8ceecb7fb9fdbeabbe55c04339349a36929fb8e3@lizzy.crudebyte.com>)
 id 1itiXT-0004d4-QH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=2x0ZydsVJ4Ap2fAzZA1fnedlQZ3cYiQg8EXdEK+d7NE=; b=VGgTO
 905PI8JhpovVnxLoVeGhZQGGhrbyoFSFvoFetbHNV+9nSL/frR7D5r53hFaBZrx8MDZzMqO1SDhko
 3U/DG8ZwrUVJp8J4N9VbcC1OvmIOkzjEOFyTZeyUMnlIMyHcP+gLtRI6zkSBSdlPBB94creuASk6P
 SxQCZFqe3oV7tje+zg8OoxR0dZHpokkFCqD+mJlOaKTEigiuXmpMmq8TnOcrqv6RKxJVob8mxU5PO
 reEkyizlgTqDYT5lR4Ik7jEVZxUPJB7nj9IDmmII6VBUG9LOUvFfIExQu0IBrCfIU1FtR1O8m7X2O
 FFTKrUY6qJxnua59twpqf2LUQxK4A==;
Message-Id: <8ceecb7fb9fdbeabbe55c04339349a36929fb8e3.1579567019.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1579567019.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 20 Jan 2020 23:47:55 +0100
Subject: [PATCH v4 02/11] 9pfs: require msize >= 4096
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A client establishes a session by sending a Tversion request along with a
'msize' parameter which client uses to suggest server a maximum message
size ever to be used for communication (for both requests and replies)
between client and server during that session. If client suggests a 'msize'
smaller than 4096 then deny session by server immediately with an error
response (Rlerror for "9P2000.L" clients or Rerror for "9P2000.u" clients)
instead of replying with Rversion.

So far any msize submitted by client with Tversion was simply accepted by
server without any check. Introduction of some minimum msize makes sense,
because e.g. a msize < 7 would not allow any subsequent 9p operation at
all, because 7 is the size of the header section common by all 9p message
types.

A substantial higher value of 4096 was chosen though to prevent potential
issues with some message types. E.g. Rreadlink may yield up to a size of
PATH_MAX which is usually 4096, and like almost all 9p message types,
Rreadlink is not allowed to be truncated by the 9p protocol. This chosen
size also prevents a similar issue with Rreaddir responses (provided client
always sends adequate 'count' parameter with Treaddir), because even though
directory entries retrieval may be split up over several T/Rreaddir
messages; a Rreaddir response must not truncate individual directory entries
though. So msize should be large enough to return at least one directory
entry with the longest possible file name supported by host. Most file
systems support a max. file name length of 255. Largest known file name
lenght limit would be currently ReiserFS with max. 4032 bytes, which is
also covered by this min. msize value because 4032 + 35 < 4096.

Furthermore 4096 is already the minimum msize of the Linux kernel's 9pfs
client.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 12 ++++++++++++
 hw/9pfs/9p.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 520177f40c..a5fbe821d4 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1363,8 +1363,20 @@ static void coroutine_fn v9fs_version(void *opaque)
         s->proto_version = V9FS_PROTO_2000L;
     } else {
         v9fs_string_sprintf(&version, "unknown");
+        /* skip min. msize check, reporting invalid version has priority */
+        goto marshal;
     }
 
+    if (s->msize < P9_MIN_MSIZE) {
+        err = -EMSGSIZE;
+        error_report(
+            "9pfs: Client requested msize < minimum msize ("
+            stringify(P9_MIN_MSIZE) ") supported by this server."
+        );
+        goto out;
+    }
+
+marshal:
     err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
     if (err < 0) {
         goto out;
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 3904f82901..6fffe44f5a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -100,6 +100,17 @@ typedef enum P9ProtoVersion {
     V9FS_PROTO_2000L = 0x02,
 } P9ProtoVersion;
 
+/**
+ * @brief Minimum message size supported by this 9pfs server.
+ *
+ * A client establishes a session by sending a Tversion request along with a
+ * 'msize' parameter which suggests the server a maximum message size ever to be
+ * used for communication (for both requests and replies) between client and
+ * server during that session. If client suggests a 'msize' smaller than this
+ * value then session is denied by server with an error response.
+ */
+#define P9_MIN_MSIZE    4096
+
 #define P9_NOTAG    UINT16_MAX
 #define P9_NOFID    UINT32_MAX
 #define P9_MAXWELEM 16
-- 
2.20.1


