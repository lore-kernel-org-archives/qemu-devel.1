Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69833C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32A822277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX74oPrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32A822277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWUa-0002Vt-KS
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOJ-0002d1-Q1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOI-00059h-2A
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWvryq08NcB4Nl9MnYRr9FOaHhm8prTyZgfoOzlkUMs=;
 b=KX74oPrskUaMC7JeqQfwPsA7jUEOstaUEOEpUgndmkEL4irZEjLDa8BjGLwlO58Ey8AR6C
 SgH4/jLSAupFwTn/axd6gegJBpPmB7ViHNO5CBCXtFJA/Fu6Rl+MTTqg4isIebPssDO0Gk
 NDH5psz5hZuzowHZeU8OIPfHIhej6/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-_S_ZMJYEPoOHFIUQS_IHOA-1; Mon, 02 Nov 2020 04:44:39 -0500
X-MC-Unique: _S_ZMJYEPoOHFIUQS_IHOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C59331868401;
 Mon,  2 Nov 2020 09:44:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 431E35B4D6;
 Mon,  2 Nov 2020 09:44:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F27F210EE550; Mon,  2 Nov 2020 10:44:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/11] sockets: Fix default of UnixSocketAddress member
 @tight
Date: Mon,  2 Nov 2020 10:44:18 +0100
Message-Id: <20201102094422.173975-8-armbru@redhat.com>
In-Reply-To: <20201102094422.173975-1-armbru@redhat.com>
References: <20201102094422.173975-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An optional bool member of a QAPI struct can be false, true, or absent.
The previous commit demonstrated that socket_listen() and
socket_connect() are broken for absent @tight, and indeed QMP chardev-
add also defaults absent member @tight to false instead of true.

In C, QAPI members are represented by two fields, has_MEMBER and MEMBER.
We have:

            has_MEMBER    MEMBER
    false         true     false
    true          true      true
    absent       false  false/ignore

When has_MEMBER is false, MEMBER should be set to false on write, and
ignored on read.

For QMP, the QAPI visitors handle absent @tight by setting both
@has_tight and @tight to false.  unix_listen_saddr() and
unix_connect_saddr() however use @tight only, disregarding @has_tight.
This is wrong and means that absent @tight defaults to false whereas it
should default to true.

The same is true for @has_abstract, though @abstract defaults to
false and therefore has the same behavior for all of QMP, HMP and CLI.
Fix unix_listen_saddr() and unix_connect_saddr() to check
@has_abstract/@has_tight, and to default absent @tight to true.

However, this is only half of the story.  HMP chardev-add and CLI
-chardev so far correctly defaulted @tight to true, but defaults to
false again with the above fix for HMP and CLI.  In fact, the "tight"
and "abstract" options now break completely.

Digging deeper, we find that qemu_chr_parse_socket() also ignores
@has_tight, leaving it false when it sets @tight.  That is also wrong,
but the two wrongs cancelled out.  Fix qemu_chr_parse_socket() to set
@has_tight and @has_abstract; writing testcases for HMP and CLI is left
for another day.

Fixes: 776b97d3605ed0fc94443048fdf988c7725e38a9
Reported-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-socket.c     | 2 ++
 tests/test-util-sockets.c | 6 +++---
 util/qemu-sockets.c       | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 95e45812d5..1ee5a8c295 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1439,7 +1439,9 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
+        q_unix->has_tight = true;
         q_unix->tight = tight;
+        q_unix->has_abstract = true;
         q_unix->abstract = abstract;
     } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index f8b6586e70..7ecf95579b 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -294,13 +294,13 @@ static void test_socket_unix_abstract(void)
     abstract_socket_matrix_row matrix[ABSTRACT_SOCKET_VARIANTS] = {
         { &addr,
           { &addr_tight, &addr_padded, &addr },
-          { false /* BUG */, true /* BUG */, true } },
+          { true, false, true } },
         { &addr_tight,
           { &addr_padded, &addr, &addr_tight },
-          { false, false /* BUG */, true } },
+          { false, true, true } },
         { &addr_padded,
           { &addr, &addr_tight, &addr_padded },
-          { true /* BUG */, false, true } }
+          { false, false, true } }
     };
     int i;
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 38f82179b0..3ceaa81226 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -925,7 +925,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     if (saddr->abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], path, pathlen);
-        if (saddr->tight) {
+        if (!saddr->has_tight || saddr->tight) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
@@ -985,7 +985,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     if (saddr->abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], saddr->path, pathlen);
-        if (saddr->tight) {
+        if (!saddr->has_tight || saddr->tight) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
-- 
2.26.2


