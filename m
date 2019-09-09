Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DDCC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D68121924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D68121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JOe-0001NY-KV
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7JNj-0000O0-NM
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7JNi-0007QV-Hq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:06:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7JNi-0007Q8-Au
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:06:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AADA467462
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 13:06:57 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-63.ams2.redhat.com
 [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F39E3D8E;
 Mon,  9 Sep 2019 13:06:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 15:06:55 +0200
Message-Id: <20190909130655.24495-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 09 Sep 2019 13:06:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] test-char: fix AddressSanitizer failure
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CharSocketServerTestConfig and CharSocketClientTestConfig
objects escape after they are passed to g_test_add_data_func,
but they cease existing after the scope that defines them is
closed.  Make them static to fix this issue.

Fixes: e7b6ba4186f243f149b0d8cddc129fe681ba3912
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-char.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index f3ebdffd87..525a476b89 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -1403,13 +1403,13 @@ int main(int argc, char **argv)
 #endif
=20
 #define SOCKET_SERVER_TEST(name, addr)                                  =
\
-    CharSocketServerTestConfig server1 ## name =3D                      =
  \
+    static CharSocketServerTestConfig server1 ## name =3D               =
  \
         { addr, false, false };                                         =
\
-    CharSocketServerTestConfig server2 ## name =3D                      =
  \
+    static CharSocketServerTestConfig server2 ## name =3D               =
  \
         { addr, true, false };                                          =
\
-    CharSocketServerTestConfig server3 ## name =3D                      =
  \
+    static CharSocketServerTestConfig server3 ## name =3D               =
  \
         { addr, false, true };                                          =
\
-    CharSocketServerTestConfig server4 ## name =3D                      =
  \
+    static CharSocketServerTestConfig server4 ## name =3D               =
  \
         { addr, true, true };                                           =
\
     g_test_add_data_func("/char/socket/server/mainloop/" # name,        =
\
                          &server1 ##name, char_socket_server_test);     =
\
@@ -1421,17 +1421,17 @@ int main(int argc, char **argv)
                          &server4 ##name, char_socket_server_test)
=20
 #define SOCKET_CLIENT_TEST(name, addr)                                  =
\
-    CharSocketClientTestConfig client1 ## name =3D                      =
  \
+    static CharSocketClientTestConfig client1 ## name =3D               =
  \
         { addr, NULL, false, false };                                   =
\
-    CharSocketClientTestConfig client2 ## name =3D                      =
  \
+    static CharSocketClientTestConfig client2 ## name =3D               =
  \
         { addr, NULL, true, false };                                    =
\
-    CharSocketClientTestConfig client3 ## name =3D                      =
  \
+    static CharSocketClientTestConfig client3 ## name =3D               =
  \
         { addr, ",reconnect=3D1", false };                              =
  \
-    CharSocketClientTestConfig client4 ## name =3D                      =
  \
+    static CharSocketClientTestConfig client4 ## name =3D               =
  \
         { addr, ",reconnect=3D1", true };                               =
  \
-    CharSocketClientTestConfig client5 ## name =3D                      =
  \
+    static CharSocketClientTestConfig client5 ## name =3D               =
  \
         { addr, NULL, false, true };                                    =
\
-    CharSocketClientTestConfig client6 ## name =3D                      =
  \
+    static CharSocketClientTestConfig client6 ## name =3D               =
  \
         { addr, NULL, true, true };                                     =
\
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        =
\
                          &client1 ##name, char_socket_client_test);     =
\
--=20
2.21.0


