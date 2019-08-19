Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75A6C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A032E2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A032E2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhi8-0004WQ-Rh
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hck-ci@localhost>) id 1hzhbS-0006xR-8v
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hck-ci@localhost>) id 1hzhbP-0005bV-Tx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:21:41 -0400
Received: from [141.226.163.173] (port=51533 helo=groan)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <hck-ci@localhost>) id 1hzhbD-0005UO-PR
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:21:36 -0400
Received: by groan (Postfix, from userid 1000)
 id 88EC5208531AE; Mon, 19 Aug 2019 16:16:20 +0300 (IDT)
From: Bishara AbuHattoum <bishara@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2019 16:16:20 +0300
Message-Id: <20190819131620.1302-2-bishara@daynix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190819131620.1302-1-bishara@daynix.com>
References: <20190819131620.1302-1-bishara@daynix.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 141.226.163.173
Subject: [Qemu-devel] [PATCH 1/1] qga-win: network-get-interfaces command
 name field bug fix
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Network interface name is fetched as an encoded WCHAR array, (wide
character), then it is decoded using the guest's CP_ACP Windows code
page, which is the default code page as configure in the guest's
Windows, then it is returned as a byte array, (char array).

As stated in the BZ#1733165, when renaming a network interface to a
Chinese name and invoking this command, the returned name field has
the (\ufffd) value for each Chinese character the name had, this
value is an indication that the code page does not have the decoding
information for the given character.

This bug is a result of using the CP_ACP code page for decoding which
is an interchangeable code page, instead CP_UTF8 code page should be
used for decoding the network interface's name.

https://bugzilla.redhat.com/show_bug.cgi?id=1733165

Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
---
 qga/commands-win32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6b67f16faf..64b1c754b0 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1387,12 +1387,12 @@ static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
 static char *guest_wctomb_dup(WCHAR *wstr)
 {
     char *str;
-    size_t i;
+    size_t str_size;
 
-    i = wcslen(wstr) + 1;
-    str = g_malloc(i);
-    WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK,
-                        wstr, -1, str, i, NULL, NULL);
+    str_size = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL, NULL);
+    /* add 1 to str_size for NULL terminator */
+    str = g_malloc(str_size + 1);
+    WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, str_size, NULL, NULL);
     return str;
 }
 
-- 
2.17.2


