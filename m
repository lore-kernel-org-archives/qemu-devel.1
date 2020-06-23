Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3CEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFF720774
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/jQNGYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFF720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnAu-0001YF-7o
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnn9c-0008Bb-By
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:56:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnn9a-0007kB-IT
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592934973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgdQVUU+c96FREVYYy6jwZmKqe+mIDuQTqsn1ngJqEw=;
 b=B/jQNGYjQSPYLfb5oD3UbTrarmlRnSSI2bYwygQHVwiMV9FF4uj52eryjKyqtVgaTJVbuh
 jXLyzTcqKrWRkoKsrTUhGTaU/9wcyISolr9qDiILIKtxP8rf24FTY0kw/Rho9gcTNy1VqO
 Ck01f3Vuws1j3Bni8QkLrUqJmvQazbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-W5niruuhPbys0Amc5VqEeg-1; Tue, 23 Jun 2020 13:56:11 -0400
X-MC-Unique: W5niruuhPbys0Amc5VqEeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFF76CF640;
 Tue, 23 Jun 2020 17:55:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-115-78.ams2.redhat.com [10.36.115.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FE4E7169A;
 Tue, 23 Jun 2020 17:55:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] vvfat: Fix array_remove_slice()
Date: Tue, 23 Jun 2020 19:55:34 +0200
Message-Id: <20200623175534.38286-3-kwolf@redhat.com>
In-Reply-To: <20200623175534.38286-1-kwolf@redhat.com>
References: <20200623175534.38286-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, nhuck15@gmail.com, qemu-devel@nongnu.org,
 ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

array_remove_slice() calls array_roll() with array->next - 1 as the
destination index. This is only correct for count == 1, otherwise we're
writing past the end of the array. array->next - count would be correct.

However, this is the only place ever calling array_roll(), so this
rather complicated operation isn't even necessary.

Fix the problem and simplify the code by replacing it with a single
memmove() call. array_roll() can now be removed.

Reported-by: Nathan Huckleberry <nhuck15@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 2fab371258..d6e464c595 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -140,48 +140,16 @@ static inline void* array_insert(array_t* array,unsigned int index,unsigned int
     return array->pointer+index*array->item_size;
 }
 
-/* this performs a "roll", so that the element which was at index_from becomes
- * index_to, but the order of all other elements is preserved. */
-static inline int array_roll(array_t* array,int index_to,int index_from,int count)
-{
-    char* buf;
-    char* from;
-    char* to;
-    int is;
-
-    if(!array ||
-            index_to<0 || index_to>=array->next ||
-            index_from<0 || index_from>=array->next)
-        return -1;
-
-    if(index_to==index_from)
-        return 0;
-
-    is=array->item_size;
-    from=array->pointer+index_from*is;
-    to=array->pointer+index_to*is;
-    buf=g_malloc(is*count);
-    memcpy(buf,from,is*count);
-
-    if(index_to<index_from)
-        memmove(to+is*count,to,from-to);
-    else
-        memmove(from,from+is*count,to-from);
-
-    memcpy(to,buf,is*count);
-
-    g_free(buf);
-
-    return 0;
-}
-
 static inline int array_remove_slice(array_t* array,int index, int count)
 {
     assert(index >=0);
     assert(count > 0);
     assert(index + count <= array->next);
-    if(array_roll(array,array->next-1,index,count))
-        return -1;
+
+    memmove(array->pointer + index * array->item_size,
+            array->pointer + (index + count) * array->item_size,
+            (array->next - index - count) * array->item_size);
+
     array->next -= count;
     return 0;
 }
-- 
2.25.4


