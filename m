Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E7C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06AA20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06AA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEWe-0006mM-V0
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVL-0004p3-Nw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVK-0007I2-5b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53213)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVJ-0007Cz-RT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:51:42 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8XHb-1jIeTi0gkb-014PdF; Tue, 17 Mar 2020 16:51:31 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/37] linux-user: fix socket() strace
Date: Tue, 17 Mar 2020 16:50:47 +0100
Message-Id: <20200317155116.1227513-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EWgirKQ5Nau73P3h26c8IFSt2bZDOeBwwekd8WB1ezCMJaEWZWz
 sodKbGRiJDNnQuqukjlgUL3C8afPISHrbfmaFsnSItC9FA/7vpf1fWiD4mdfoGuAAoJY93L
 9pgsvZY5ttshBPnvx4fqvbzRylvGk2k9YEu121AWAqLSHdHgIQoh8gJ3o/l/efQDRTQuDfu
 MHtnWV8q86mws+GUkmeDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NrGki+CH0nY=:KqgKOY1fut76t0X7c1+mwH
 +pNnDr7DR0gRKtN3hisGcd6R+xBqqUqguS+IiVIn8HdG0w4hGlriEkeOWNwB4QFVBA6cOD5Qs
 UWnHku4vk17iurxTkdlUjmGRxYElfeVzFzX1f/e3ImjVSwuj9eBvO/sCk1ZYeRER2m17fvswz
 rWJRfOGudPIlt+Z5qCOBdRpU6tcfOIltKk148DLJa+Y31ZEK8DgS25wWm+wQniVh6y4uj3DL5
 FNX7HaJj+UiA7apmW2mPtaUdzfoPAXCuN1rGz6U/LwCT9+M8EA448Ph+qBfQmcyZRaawRFhP0
 LYhyiKYkPtdh3SuMEESJajUeFwB/D0Z511iN1zrnRGawW2RVmEHkasmLomnr7z5xfX1yGidmd
 y/ishvYe/I5iT6iRuFW9Th6J2mxicjjrrvy8T59D4IKHvJrXUtHPrfB0QmGwtZ0HdBCzJgzWp
 Y3guc7fpYHLqVUBYScojQj46Fix4Jq7q9GMS1aD34lwqgwysbJ4t4J+uKkzefLMqyJKRzOSHc
 xL+4bC/I1fOsfanWi6uTPFLwiMNmK210Exu33ENKFDGK8oSVOMx6gxGQ1eqvtappLit9eupjj
 f86wQ+TaDmH1T1yPQg2e7EnWqwVSTg5i6KJ/Dr5zswys8knh2GPC1l7K0QBi0Hr3z5+/yqOTd
 yNsk0XbVOWsV5ANEggLG6doCkTNvi5AM3KbTdnnZirO/g1aGxaEI0oLDU+ybK186CTaadK6m/
 N1qbNsOvMmnRGShvE32CS9w5O2i9Ia7lohe57U8xZ3OrequHqC+2S3qZYmNTb4s2Hn6JS/6LG
 cJclJIfS8mSxM6ZB61CD45F9OzGVF79hXtYLqZji7Ly5RaW7anH+3xnEAECZCd/BAD62ej4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

print_socket_type() doesn't manage flags and the correct type cannot
be displayed

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200312165530.53450-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f7130b2ff63..69232f7e27b8 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -444,7 +444,7 @@ print_socket_domain(int domain)
 static void
 print_socket_type(int type)
 {
-    switch (type) {
+    switch (type & TARGET_SOCK_TYPE_MASK) {
     case TARGET_SOCK_DGRAM:
         qemu_log("SOCK_DGRAM");
         break;
@@ -464,6 +464,12 @@ print_socket_type(int type)
         qemu_log("SOCK_PACKET");
         break;
     }
+    if (type & TARGET_SOCK_CLOEXEC) {
+        qemu_log("|SOCK_CLOEXEC");
+    }
+    if (type & TARGET_SOCK_NONBLOCK) {
+        qemu_log("|SOCK_NONBLOCK");
+    }
 }
 
 static void
-- 
2.24.1


