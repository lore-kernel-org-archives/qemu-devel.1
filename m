Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3FC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB58207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="R8Jv4Gqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB58207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irAGa-0000q3-Ib
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <49ff399635ccfd21858b15417a398df362ff0b90@lizzy.crudebyte.com>)
 id 1irAFS-0007Qf-7r
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <49ff399635ccfd21858b15417a398df362ff0b90@lizzy.crudebyte.com>)
 id 1irAFR-0004ax-4B
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:39:58 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:58501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <49ff399635ccfd21858b15417a398df362ff0b90@lizzy.crudebyte.com>)
 id 1irAFQ-0003nl-UA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=+Myfkq98Clr2ORtfWNQein9mN5wHBp4bIQMl85shDKw=; b=R8Jv4
 GqnRIHxyFLv+BjMrQnD054U+toPSm2aqHP0bgsO2m7C8QVmy4XErA80rxYZxAgoZuyVrgFpz8oMY+
 Y67fxwEdKIXjJSERfAmNyamAQjdIL1vuwr63psK2togayyCoJXBO1arm53nzGUHo4INxT+afglLMK
 f4kYYDeAGafaW6FNofxkPOU6ZfWzj9kLZfLBJEwLBVPxCszkjSvLP0z9nHoHxrtGn6hHVXmRLBARu
 PD7VNHmte081vFOi/OK60ixiHQVbv1lXXnDQuf+FcA0VScCL862ky5NWr5a7yGoCiGoFjNxwke0rt
 iAPwRiC2LgkVg4jhXCR1vCfT5/pCw==;
Message-Id: <49ff399635ccfd21858b15417a398df362ff0b90.1578957500.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1578957500.git.qemu_oss@crudebyte.com>
References: <cover.1578957500.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 13 Jan 2020 23:21:04 +0100
Subject: [PATCH v3 02/11] 9pfs: require msize >= 4096
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

A client establishes a session by sending a Tversion request along with
a 'msize' parameter which client uses to suggest server a maximum
message size ever to be used for communication (for both requests and
replies) between client and server during that session. If client
suggests a 'msize' smaller than 4096 then deny session by server
immediately with an error response (Rlerror for "9P2000.L" clients or
Rerror for "9P2000.u" clients) instead of replying with Rversion.

Introduction of a minimum msize is required to prevent issues in
responses to numerous individual request types. For instance with a
msize of < P9_IOHDRSZ no useful operations would be possible at all.
Furthermore there are some responses which are not allowed by the 9p
protocol to be truncated like e.g. Rreadlink which may yield up to
a size of PATH_MAX which is usually 4096. Hence this size was chosen
as min. msize for server, which is already the minimum msize of the
Linux kernel's 9pfs client. By forcing a min. msize already at
session start (when handling Tversion) we don't have to check for a
minimum msize on a per request type basis later on during session,
which would be much harder and more error prone to maintain.

This is a user visible change which should be documented as such
(i.e. in public QEMU release changelog).

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
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


