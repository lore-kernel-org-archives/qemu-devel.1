Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1DCC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67852067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbhpu5QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67852067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sfX-0002xU-9b
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCt-0006Pv-E5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCr-0007SE-Fh
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCr-0007RY-13
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id t3so93308wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F4wjmLu6wuZ6WJhZD7UWKZMQnvS2jTIE8u3K4MLhVWQ=;
 b=mbhpu5QAHOCssMBDfqtlJziMfjn25KRIhVkTsnl0O2ncaYjFteTZ9UEGgWShkr5fPj
 9wzLSc94alTmmlxxhMKpCcdOJ1sghI/0q1fkdJJN21t1I45kXQwPzL7v9LHjqRYey62G
 RyzavzUz7G4QwY5ApIh7mO42Z7LKj6l1d4TEEBX5+aBCzDkfTDMdW9aLbobdN+Pwb4f7
 WT0kiDZGph3sF150qo6BMuGCjI6mMTvZ+bRn+gsbdebjcLbapj3/+okmIdqn4COgKZoh
 U+o69p6kUVqCeSU+rnAilhbqywDLz/Gk/JPRqKiMjJvbiatWBwlYA+pyba7Swf2F5sU6
 C9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=F4wjmLu6wuZ6WJhZD7UWKZMQnvS2jTIE8u3K4MLhVWQ=;
 b=m+ImBUMmutLiyXXXXWkIXplSSVHnw6hJAeeC8xSCPCmBd+9bDJlDUerlteCRM+EPQG
 fevIYxFcyrrikh4P6YOJJRYuSDSUKySo5+SEsbA9kyQklh7RJN2+X098Fw8vIc07b7PD
 lqdeSgpfbaj2O5rDzB1q8kCBHF6kGmzpDy8HroH6KGBAYpMJ+7aLnNvutYNY5i0do9dr
 4rLXxwJUC25Li2/jrbnazcoZEYmo7WtJ9XHqP/0VvRfVGwOmDHgJaLx1R6++VA29y95F
 vczCWjRVRqFbBu1rkWwvQ/ysbXRqP4951aZ5EScoTmY1Q/9vANH7SerVfeK35yPLjjAn
 k5vw==
X-Gm-Message-State: APjAAAVLVk7n+bScZEUfAQpcLPAvAkJKhK9C7z+G7F4gA9utLlQA7ab+
 hsuRSoClDO49aizOW/hBqOK8xYFY
X-Google-Smtp-Source: APXvYqz2wAhyVT/GjPs4CsjHxDaX5hCvcviCu6f1dAsPMOPEPl4c1/XhZPppaIVDqI3RJUpuItZZnQ==
X-Received: by 2002:a1c:c104:: with SMTP id r4mr73645wmf.64.1568644939165;
 Mon, 16 Sep 2019 07:42:19 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:48 +0200
Message-Id: <1568644929-9124-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 08/29] test-char: fix AddressSanitizer failure
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

The CharSocketServerTestConfig and CharSocketClientTestConfig
objects escape after they are passed to g_test_add_data_func,
but they cease existing after the scope that defines them is
closed.  Make them static to fix this issue.

Fixes: e7b6ba4186f243f149b0d8cddc129fe681ba3912
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index f3ebdff..d62de1b 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1355,6 +1355,18 @@ static void char_hotswap_test(void)
     g_free(chr_args);
 }
 
+static SocketAddress tcpaddr = {
+    .type = SOCKET_ADDRESS_TYPE_INET,
+    .u.inet.host = (char *)"127.0.0.1",
+    .u.inet.port = (char *)"0",
+};
+#ifndef WIN32
+static SocketAddress unixaddr = {
+    .type = SOCKET_ADDRESS_TYPE_UNIX,
+    .u.q_unix.path = (char *)"test-char.sock",
+};
+#endif
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -1390,26 +1402,14 @@ int main(int argc, char **argv)
     g_test_add_func("/char/file-fifo", char_file_fifo_test);
 #endif
 
-    SocketAddress tcpaddr = {
-        .type = SOCKET_ADDRESS_TYPE_INET,
-        .u.inet.host = (char *)"127.0.0.1",
-        .u.inet.port = (char *)"0",
-    };
-#ifndef WIN32
-    SocketAddress unixaddr = {
-        .type = SOCKET_ADDRESS_TYPE_UNIX,
-        .u.q_unix.path = (char *)"test-char.sock",
-    };
-#endif
-
 #define SOCKET_SERVER_TEST(name, addr)                                  \
-    CharSocketServerTestConfig server1 ## name =                        \
+    static CharSocketServerTestConfig server1 ## name =                 \
         { addr, false, false };                                         \
-    CharSocketServerTestConfig server2 ## name =                        \
+    static CharSocketServerTestConfig server2 ## name =                 \
         { addr, true, false };                                          \
-    CharSocketServerTestConfig server3 ## name =                        \
+    static CharSocketServerTestConfig server3 ## name =                 \
         { addr, false, true };                                          \
-    CharSocketServerTestConfig server4 ## name =                        \
+    static CharSocketServerTestConfig server4 ## name =                 \
         { addr, true, true };                                           \
     g_test_add_data_func("/char/socket/server/mainloop/" # name,        \
                          &server1 ##name, char_socket_server_test);     \
@@ -1421,17 +1421,17 @@ int main(int argc, char **argv)
                          &server4 ##name, char_socket_server_test)
 
 #define SOCKET_CLIENT_TEST(name, addr)                                  \
-    CharSocketClientTestConfig client1 ## name =                        \
+    static CharSocketClientTestConfig client1 ## name =                 \
         { addr, NULL, false, false };                                   \
-    CharSocketClientTestConfig client2 ## name =                        \
+    static CharSocketClientTestConfig client2 ## name =                 \
         { addr, NULL, true, false };                                    \
-    CharSocketClientTestConfig client3 ## name =                        \
+    static CharSocketClientTestConfig client3 ## name =                 \
         { addr, ",reconnect=1", false };                                \
-    CharSocketClientTestConfig client4 ## name =                        \
+    static CharSocketClientTestConfig client4 ## name =                 \
         { addr, ",reconnect=1", true };                                 \
-    CharSocketClientTestConfig client5 ## name =                        \
+    static CharSocketClientTestConfig client5 ## name =                 \
         { addr, NULL, false, true };                                    \
-    CharSocketClientTestConfig client6 ## name =                        \
+    static CharSocketClientTestConfig client6 ## name =                 \
         { addr, NULL, true, true };                                     \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
-- 
1.8.3.1



