Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81009C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FF2206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOffvLPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FF2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8G9-0006iU-Ov
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88q-0005yt-4f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88k-0008Ll-Cw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603978732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apIX88BZzBufVjJ+xtCiEP6x1ttOWXyYdBbCiC51M3E=;
 b=SOffvLPDryE/V0X0C5Bx4m13fRrmDCgmobc5anIDmtDv5hGTIJxCHuYabL0w8EvZZWcUj0
 u1bNai51km1Zw6AtfWckoNVjzzoZNz1mjnf2pJvxNqJPNPoFkEqIEzLSzqblBZ0mWhMdwC
 zbjSTDXO2GO5wieWKYxkyn1UshR81v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Siio049xMDu2CP8UhBKaiA-1; Thu, 29 Oct 2020 09:38:49 -0400
X-MC-Unique: Siio049xMDu2CP8UhBKaiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E220D10E219E;
 Thu, 29 Oct 2020 13:38:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 794F35C1D0;
 Thu, 29 Oct 2020 13:38:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC74E11329B3; Thu, 29 Oct 2020 14:38:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] sockets: Fix default of UnixSocketAddress member @tight
Date: Thu, 29 Oct 2020 14:38:29 +0100
Message-Id: <20201029133833.3450220-8-armbru@redhat.com>
In-Reply-To: <20201029133833.3450220-1-armbru@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QMP chardev-add defaults absent member @tight to false instead of
true.  HMP chardev-add and CLI -chardev correctly default to true.

The previous commit demonstrated that socket_listen() and
socket_connect() are broken for absent @tight.  That explains why QMP
is broken, but not why HMP and CLI work.  We need to dig deeper.

An optional bool member of a QAPI struct can be false, true, or
absent.  In C, we have:

	    has_MEMBER    MEMBER
    false         true	   false
    true	  true	   false
    absent	 false	false/ignore

When has_MEMBER is false, MEMBER should be set to false on write, and
ignored on read.

unix_listen_saddr() and unix_connect_saddr() use member @tight without
checking @has_tight.  This is wrong.

When @tight was set to false as it should be, absent @tight defaults
to false.  Wrong, it should default to true.  This is what breaks QMP.

There is one exception: qemu_chr_parse_socket() leaves @has_tight
false when it sets @tight.  Wrong, but the wrongs cancel out.  This is
why HMP and CLI work.  Same for @has_abstract.

Fix unix_listen_saddr() and unix_connect_saddr() to default absent
@tight to true.

Fix qemu_chr_parse_socket() to set @has_tight and @has_abstract.

Fixes: 776b97d3605ed0fc94443048fdf988c7725e38a9
Reported-by: Kevin Wolf <kwolf@redhat.com>
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
index 05e5c73f9d..c802d5aa0a 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -919,7 +919,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     if (saddr->abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], path, pathlen);
-        if (saddr->tight) {
+        if (!saddr->has_tight || saddr->tight) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
@@ -979,7 +979,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
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


