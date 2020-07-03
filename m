Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1FCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2A220723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbNsrPgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2A220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHvl-0007V9-1f
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtV-0002pH-TF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:22:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtU-0000yJ-0i
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593768120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVF5KUpHWkY3Qg0PDkkb2MQ94k7vQg1CYbztYqZ3E/s=;
 b=bbNsrPgZry0pKwnEnauxzeu0bOgh2iqDFtH8VXq4mA5rKEskTDQ/FQXq3yMoq7sVbQwfeJ
 m4bHGwTrNKfWrrVZesoYIfa7XwEYGV+otiERZju4pkOTmQpibMJwcgajK8HUgP/VMJgirW
 /9po8Z4j9Trfk2sfp3MPwRg3UwM5VrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-SiLobQuyMleMxuVHlRWzmQ-1; Fri, 03 Jul 2020 05:21:58 -0400
X-MC-Unique: SiLobQuyMleMxuVHlRWzmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FA5F107ACCA;
 Fri,  3 Jul 2020 09:21:57 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD86A7AC63;
 Fri,  3 Jul 2020 09:21:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 5/7] vvfat: Fix array_remove_slice()
Date: Fri,  3 Jul 2020 11:21:41 +0200
Message-Id: <20200703092143.165594-6-kwolf@redhat.com>
In-Reply-To: <20200703092143.165594-1-kwolf@redhat.com>
References: <20200703092143.165594-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Message-Id: <20200623175534.38286-3-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 62230542e5..2eb8cbb19f 100644
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


