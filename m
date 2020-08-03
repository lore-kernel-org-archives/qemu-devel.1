Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8186022B45
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzqhdHnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8186022B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2fx1-0003Ls-Qr
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2fvp-0001zP-D7
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:15:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23926
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k2fvn-0001Ir-Gm
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596482130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPumnZ/bwZNrMiQqcF7tSFL/9SfKTDkvT5OZGQE3spU=;
 b=RzqhdHnpzv1JOzpPCAb/bAZrZiO/vPIahfkJcsBJCZGZMzPES6iNhObtE+qnL/tp8ygqAR
 18+ehLrMPbHlzsjNgYDLQLskFFF/5gqlyLiULB5K0jX8lbXiVEZlf28x9kcVlFAUZ6vwes
 QHW83JMku01BD3LOfXOuVJlTHlWurtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-JuGR5WsFNJiNX0UhsW5rzA-1; Mon, 03 Aug 2020 15:15:27 -0400
X-MC-Unique: JuGR5WsFNJiNX0UhsW5rzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4EEC100CCC1
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 19:15:25 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-35.ams2.redhat.com
 [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73AC517150;
 Mon,  3 Aug 2020 19:15:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vgoyal@redhat.com, stefanha@redhat.com,
 virtio-fs@redhat.com
Subject: [PATCH 3/3] tools/virtiofsd: xattr name mappings: Map host xattr names
Date: Mon,  3 Aug 2020 20:15:11 +0100
Message-Id: <20200803191511.45261-4-dgilbert@redhat.com>
In-Reply-To: <20200803191511.45261-1-dgilbert@redhat.com>
References: <20200803191511.45261-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 13:51:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Map xattr names coming from the host, i.e. listxattr.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 68d2407a37..3af4cfb0e3 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2195,6 +2195,42 @@ static int xattr_map_client(const char *client_name, char **out_name)
     abort();
 }
 
+/*
+ * For use with listxattr where the host fs gives us a name and we may need
+ * to sanitize this for the client.
+ * Returns a pointer to the result in *out_name
+ *   This is always the original string or the current string with some prefix
+ *   removed; no reallocation is done.
+ * Returns 0 on success
+ * Can return -ENODATA to indicate the name should be dropped from the list.
+ */
+static int xattr_map_host(const char *host_name, const char **out_name)
+{
+    const XattrMapEntry *cur_entry;
+    for (cur_entry = xattr_map_list; ; cur_entry++) {
+        if ((cur_entry->flags & XATTR_MAP_FLAG_HOST) &&
+            (!strncmp(cur_entry->prepend,
+                      host_name,
+                      strlen(cur_entry->prepend)))) {
+            if (cur_entry->flags & XATTR_MAP_FLAG_END_BAD) {
+                return -ENODATA;
+            }
+            if (cur_entry->flags & XATTR_MAP_FLAG_END_OK) {
+                *out_name = host_name;
+                return 0;
+            }
+            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
+                /* Remove prefix */
+                *out_name = host_name + strlen(cur_entry->prepend);
+                return 0;
+            }
+        }
+    }
+
+    /* Shouldn't get here - rules should have an END_* */
+    abort();
+}
+
 static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *in_name,
                         size_t size)
 {
@@ -2349,8 +2385,60 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
         if (ret == 0) {
             goto out;
         }
+
+        if (lo->xattrmap) {
+            /*
+             * Map the names back, some attributes might be dropped,
+             * some shortened, but not increased, so we shouldn't
+             * run out of room.
+             */
+            size_t out_index, in_index;
+            out_index = 0;
+            in_index = 0;
+            while (in_index < ret) {
+                const char *map_out;
+                char *in_ptr = value + in_index;
+                /* Length of current attribute name */
+                size_t in_len = strlen(value + in_index) + 1;
+
+                int mapret = xattr_map_host(in_ptr, &map_out);
+                if (mapret != -ENODATA && mapret != 0) {
+                    /* Shouldn't happen */
+                    saverr = -mapret;
+                    goto out;
+                }
+                if (mapret == 0) {
+                    /* Either unchanged, or truncated */
+                    size_t out_len;
+                    if (map_out != in_ptr) {
+                        /* +1 copies the NIL */
+                        out_len = strlen(map_out) + 1;
+                    } else {
+                        /* No change */
+                        out_len = in_len;
+                    }
+                    /*
+                     * Move result along, may still be needed for an unchanged
+                     * entry if a previous entry was changed.
+                     */
+                    memmove(value + out_index, map_out, out_len);
+
+                    out_index += out_len;
+                }
+                in_index += in_len;
+            }
+            ret = out_index;
+            if (ret == 0) {
+                goto out;
+            }
+        }
         fuse_reply_buf(req, value, ret);
     } else {
+        /*
+         * xattrmap only ever shortens the result,
+         * so we don't need to do anything clever with the
+         * allocation length here.
+         */
         fuse_reply_xattr(req, ret);
     }
 out_free:
-- 
2.26.2


