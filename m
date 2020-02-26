Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B93C4BA11
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FD42084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmXg0BEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FD42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40651 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sma-0003ff-R5
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfF-0005yM-Dn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfB-0000Yy-MT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfB-0000Yh-Ig
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GurCHGrxIX/gaMnymLT6OLHjIK8r0mHiQmdNJWYE8J8=;
 b=cmXg0BEOM01pwwRsk3ZxuYh40ypLKYO3wNVEUMuls/HyH+81gQzUJMab68HY2DP5J0qxQ8
 N/AmJMa1g3VgGpd+YXXmPMgv8C2SfIehMKOBTmKKfshWoanWlP49DD60X9/ieP8by5Z40d
 bmjKJ4gVqDXsPeh76N8CKUP4a5xYu/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-ekhSTAi7PRCq5AMJola0nA-1; Wed, 26 Feb 2020 04:07:27 -0500
X-MC-Unique: ekhSTAi7PRCq5AMJola0nA-1
Received: by mail-wm1-f72.google.com with SMTP id p26so462236wmg.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HJYgPtUXb7oGIKTPBdg5GcKwNd69Hnwn26g3WEAmRrg=;
 b=tsnyxOLBMO48AD/u+ou4/ulxeUKXCny5PegOAJHZNe0ovVjfXKePLY2iJogYwY/qOs
 ypMKKQVAC+xCb6PCj0vwTqNMSqqERLZPuzhQ5a16YRUopE0TBoyTlsYKS+jcbtjun8RK
 IpjCAURzbPnMnC+hkKJMyamJB1suLbIlIwIlH0xYBr8ezRlVyrEhvHygLRrI1jAFd2TR
 4zl6kproZ2ybolIn3l1wIK78DlaRELZMI0hKQYbVGLKef+5+jRHWxunQgyCU1DZeyifu
 7ykR1wEs4Nq66ZokCH7GqbxoeB1Q1ke2PYwPJSWlqkP3NZ/LB1o36lvgG1CaXXIVXz+A
 j0NA==
X-Gm-Message-State: APjAAAW0UZrG/pG0oEGFwx+8pEIGJWGbp/lFi3JD0gdw7sHVYH6MAGNO
 s5JZnLjKm0qNzL896yVKmQQXYP1mGmgpk1lYIgl3hsRl1WbFaokOrFrRnHT99CwpeNiBdC2KBvv
 s7BYBHuGRkvXPId8=
X-Received: by 2002:a05:600c:2c48:: with SMTP id
 r8mr3067827wmg.183.1582708045885; 
 Wed, 26 Feb 2020 01:07:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFQykJnIH25pjtAGYCmk9oYg+p4bokpoiJUy8Vi3wY/sWHuZ1bGzjpTozRUEpmyYSfWe6JHQ==
X-Received: by 2002:a05:600c:2c48:: with SMTP id
 r8mr3067803wmg.183.1582708045619; 
 Wed, 26 Feb 2020 01:07:25 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 a62sm2088201wmh.33.2020.02.26.01.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:25 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 22/30] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_REPLY_ACK
Message-ID: <20200226090010.708934-23-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

This is really simple, since we know whether a response is
already requested or not, so we can just send a (successful)
response when there isn't one already.

Given that, it's not all _that_ useful but the master can at
least be sure the message was processed, and we can exercise
more code paths using the example code.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20200123081708.7817-2-johannes@sipsolutions.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c
index b89bf18501..533d55d82a 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1199,7 +1199,8 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMs=
g *vmsg)
                         1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
                         1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ |
                         1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER |
-                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD;
+                        1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD |
+                        1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK;
=20
     if (have_userfault()) {
         features |=3D 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
@@ -1581,13 +1582,20 @@ vu_dispatch(VuDev *dev)
 {
     VhostUserMsg vmsg =3D { 0, };
     int reply_requested;
-    bool success =3D false;
+    bool need_reply, success =3D false;
=20
     if (!vu_message_read(dev, dev->sock, &vmsg)) {
         goto end;
     }
=20
+    need_reply =3D vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
+
     reply_requested =3D vu_process_message(dev, &vmsg);
+    if (!reply_requested && need_reply) {
+        vmsg_set_reply_u64(&vmsg, 0);
+        reply_requested =3D 1;
+    }
+
     if (!reply_requested) {
         success =3D true;
         goto end;
--=20
MST


