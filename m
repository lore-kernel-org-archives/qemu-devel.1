Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6988C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F5820B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWef3dvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F5820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQafO-0004v0-Gc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQabk-0007UM-6I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:27 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQabg-0004xV-Pk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41087
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQabf-0004we-Nh
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587405199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4ofxEhdp2LKF3VnjVWmK4rtE3cwGs/aI9dibt/RcMI=;
 b=ZWef3dvG1JXjF6tq2hSlxtmR1DZLBoqPE++VNJU3iPm4yJXApiMlhIRczy2C6YE8XNoA94
 g7l+zfCM4ICfmK3gBzX5mKoYqxopNjfJECIhzKKBcAGFqmQEIpUsN3okR2tqUMnTtcZ80O
 +6I/9WDIGGwqo4i2kUIz5uP5MMSv6us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-wtAowj7mOXO-BHX1fCvbtw-1; Mon, 20 Apr 2020 13:53:15 -0400
X-MC-Unique: wtAowj7mOXO-BHX1fCvbtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F67F8017F6;
 Mon, 20 Apr 2020 17:53:14 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9187A103F;
 Mon, 20 Apr 2020 17:53:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tools: Fix use of fcntl(F_SETFD) during socket activation
Date: Mon, 20 Apr 2020 12:53:08 -0500
Message-Id: <20200420175309.75894-3-eblake@redhat.com>
In-Reply-To: <20200420175309.75894-1-eblake@redhat.com>
References: <20200420175309.75894-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Blindly setting FD_CLOEXEC without a read-modify-write will
inadvertently clear any other intentionally-set bits, such as a
proposed new bit for designating a fd that must behave in 32-bit mode.
However, we cannot use our wrapper qemu_set_cloexec(), because that
wrapper intentionally abort()s on failure, whereas the probe here
intentionally tolerates failure to deal with incorrect socket
activation gracefully.  Instead, fix the code to do the proper
read-modify-write.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 util/systemd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/systemd.c b/util/systemd.c
index 1dd0367d9a84..5bcac9b40169 100644
--- a/util/systemd.c
+++ b/util/systemd.c
@@ -23,6 +23,7 @@ unsigned int check_socket_activation(void)
     unsigned long nr_fds;
     unsigned int i;
     int fd;
+    int f;
     int err;

     s =3D getenv("LISTEN_PID");
@@ -54,7 +55,8 @@ unsigned int check_socket_activation(void)
     /* So the file descriptors don't leak into child processes. */
     for (i =3D 0; i < nr_fds; ++i) {
         fd =3D FIRST_SOCKET_ACTIVATION_FD + i;
-        if (fcntl(fd, F_SETFD, FD_CLOEXEC) =3D=3D -1) {
+        f =3D fcntl(fd, F_GETFD);
+        if (f =3D=3D -1 || fcntl(fd, F_SETFD, f | FD_CLOEXEC) =3D=3D -1) {
             /* If we cannot set FD_CLOEXEC then it probably means the file
              * descriptor is invalid, so socket activation has gone wrong
              * and we should exit.
--=20
2.26.1


