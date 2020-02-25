Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E4AC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A1E20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0R7wRgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A1E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6byo-00082c-Ev
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6buy-0001rj-Gy
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6buv-0001f4-D4
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31175
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6buv-0001ei-8f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oKgHpzvvYWsVdDfIdCVEbYUj7F09lISrJlwoM5pP5g=;
 b=L0R7wRgjShi1lPhbDbAswQlFNRQ3gYAcIBKdsAre9V3Bvrjcn+thlcf6ceLFeKw4ujlo7u
 zZP/rKCPLw/k/7pttQFJn8Qv85CFxpgvcOv53bO/v9qazPG9X/7AtlEOwRAEPQMBFM0ISk
 LNiu9y7Gm0W8UsyEJgeUBCPP6v/K+3M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-0KQlMvgEOy6gFc45Je7Ffw-1; Tue, 25 Feb 2020 10:14:31 -0500
X-MC-Unique: 0KQlMvgEOy6gFc45Je7Ffw-1
Received: by mail-qk1-f199.google.com with SMTP id d2so1489145qko.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RCsZu5eqrBUiXUZoz9bzfU4qWCKnd0BfjuIJHzusOXA=;
 b=qS/Adh6WGiCA0VNiYdEqQRK74N5fQ0+DgCpH7zSokzH2FQUQ0El5iqx9VjlxfImWnB
 MEXp+xl/j/FzHVoZay4mKov+bDPrrc79yEWGnvT6O26Gb9FAVVtIw6zjNDrMLJAGQl59
 Nxw1Uql4R0OQGIxQVOxxWZsurGuJfoiGrZJj2qOhky0Vvi8NxJcz+hc4uA7Sv5YL85In
 89ajf8YbriKmkzc2KRvopspT+QFBdWWbGL+4i7WvEO6ZklRMD9hybGHZX6E6XZ6UMWlf
 w+BcEM7asK4zQsxfvxQ+xa8x/3mzoG3+/ggV6yr0wnZEVj9z6WPOY7Z8jBMwhWJkLeNs
 tyVw==
X-Gm-Message-State: APjAAAUGo/O9QlQ+JsmWQn4p18UaDm9hZGO/BxgvXpYMypCWDdzuehzA
 mLmLTyhZ2fh4dKlBookgxiB1wGVRmmPealGtK1EO4QYUAsiqkC0qrqh+aR7YCuiGXBRA2xfW78Y
 wzqTCHhPEVJfDUV8=
X-Received: by 2002:ac8:f37:: with SMTP id e52mr3529468qtk.49.1582643670482;
 Tue, 25 Feb 2020 07:14:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6xNEIOQlp5/EPHVlPP/kQa4td64+IBH267Xv0OhSFhvLzNCasv5uo7xhtodZTr3VQoo5Gjg==
X-Received: by 2002:ac8:f37:: with SMTP id e52mr3529442qtk.49.1582643670273;
 Tue, 25 Feb 2020 07:14:30 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 11sm3942764qkr.101.2020.02.25.07.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:29 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] libvhost-user-glib: use
 g_main_context_get_thread_default()
Message-ID: <20200225151210.647797-25-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Johannes Berg <johannes.berg@intel.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

If we use NULL, we just get the main program default mainloop
here. Using g_main_context_get_thread_default() has basically
the same effect, but it lets us start different devices in
different threads with different mainloops, which can be useful.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20200123081708.7817-4-johannes@sipsolutions.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user-glib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-=
user/libvhost-user-glib.c
index 824c7780de..53f1ca4cdd 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -89,7 +89,7 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
     src->gfd.events =3D cond;
=20
     g_source_add_poll(gsrc, &src->gfd);
-    id =3D g_source_attach(gsrc, NULL);
+    id =3D g_source_attach(gsrc, g_main_context_get_thread_default());
     g_assert(id);
=20
     return gsrc;
--=20
MST


