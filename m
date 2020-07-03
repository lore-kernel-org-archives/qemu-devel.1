Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9696420723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUEYBj63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9696420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHxV-0002dZ-LJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtZ-0002sX-Ua
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:22:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21826
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtU-0000yP-5V
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593768121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXHYq9VZV/tJ7a6JAX6lA4GzjQ3hJSx7GfnbUr6wp1I=;
 b=DUEYBj63Di2wvA9cESGBI5owq2JL+R06+C9wSoCfjmfeDcgI50/saUL0QBJiTb9hEHUsop
 h9RT4vfyb2hZh4CL91QzTI5efnmFc+DFWJ7jLKMmuqx0mn9lguKiI7u+4mPhzbPsO2/GWo
 7FKChyWYQwSlxIMWqV9gBbholuQnW/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-IlAGgAVWOnK8Hd-FZ5w2NA-1; Fri, 03 Jul 2020 05:21:57 -0400
X-MC-Unique: IlAGgAVWOnK8Hd-FZ5w2NA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65CF6107ACCD;
 Fri,  3 Jul 2020 09:21:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 732967AC71;
 Fri,  3 Jul 2020 09:21:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/7] vvfat: Check that updated filenames are valid
Date: Fri,  3 Jul 2020 11:21:40 +0200
Message-Id: <20200703092143.165594-5-kwolf@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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

FAT allows only a restricted set of characters in file names, and for
some of the illegal characters, it's actually important that we catch
them: If filenames can contain '/', the guest can construct filenames
containing "../" and escape from the assigned vvfat directory. The same
problem could arise if ".." was ever accepted as a literal filename.

Fix this by adding a check that all filenames are valid in
check_directory_consistency().

Reported-by: Nathan Huckleberry <nhuck15@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200623175534.38286-2-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index c65a98e3ee..62230542e5 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -520,12 +520,31 @@ static void set_begin_of_direntry(direntry_t* direntry, uint32_t begin)
     direntry->begin_hi = cpu_to_le16((begin >> 16) & 0xffff);
 }
 
+static bool valid_filename(const unsigned char *name)
+{
+    unsigned char c;
+    if (!strcmp((const char*)name, ".") || !strcmp((const char*)name, "..")) {
+        return false;
+    }
+    for (; (c = *name); name++) {
+        if (!((c >= '0' && c <= '9') ||
+              (c >= 'A' && c <= 'Z') ||
+              (c >= 'a' && c <= 'z') ||
+              c > 127 ||
+              strchr("$%'-_@~`!(){}^#&.+,;=[]", c) != NULL))
+        {
+            return false;
+        }
+    }
+    return true;
+}
+
 static uint8_t to_valid_short_char(gunichar c)
 {
     c = g_unichar_toupper(c);
     if ((c >= '0' && c <= '9') ||
         (c >= 'A' && c <= 'Z') ||
-        strchr("$%'-_@~`!(){}^#&", c) != 0) {
+        strchr("$%'-_@~`!(){}^#&", c) != NULL) {
         return c;
     } else {
         return 0;
@@ -2098,6 +2117,10 @@ DLOG(fprintf(stderr, "check direntry %d:\n", i); print_direntry(direntries + i))
             }
             lfn.checksum = 0x100; /* cannot use long name twice */
 
+            if (!valid_filename(lfn.name)) {
+                fprintf(stderr, "Invalid file name\n");
+                goto fail;
+            }
             if (path_len + 1 + lfn.len >= PATH_MAX) {
                 fprintf(stderr, "Name too long: %s/%s\n", path, lfn.name);
                 goto fail;
-- 
2.25.4


