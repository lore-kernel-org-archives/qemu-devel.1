Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D97C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF9021556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4cULFXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF9021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sl6-00016V-Ka
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfQ-0006RH-6L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfO-0000uo-Oa
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33813
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfO-0000tf-Kb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oKgHpzvvYWsVdDfIdCVEbYUj7F09lISrJlwoM5pP5g=;
 b=E4cULFXX9JLwDFPdg2ep9AuVLzKO1XQrWdi1eQkmTCd8mHBone9l6SiJnn/OcxhTGrOodt
 xqKOiJ3S2hhykAwrI3LWRJPyFLDXdEaJ6goOtZ3ERrqW4Wfd9N14xBo0KSqaZKcqeIy3ff
 21Y5PlEEfmJHTLiEuaM+lJQNrirFQSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-gTXb_iKNMEKGYNmbvAScOw-1; Wed, 26 Feb 2020 04:07:37 -0500
X-MC-Unique: gTXb_iKNMEKGYNmbvAScOw-1
Received: by mail-wm1-f69.google.com with SMTP id r19so655440wmh.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=RCsZu5eqrBUiXUZoz9bzfU4qWCKnd0BfjuIJHzusOXA=;
 b=HDxswMgXj9ZtjUbTQ2JMrzdxSoOnlTt78OFc/x7m3lzxHbp/4c6KH6KnXE2AQXuzNn
 G5r8gLCgHCUmxb5NoxibCTOe3yLY3uLh1bwlTvuCxQXCdRY2ZcvvWNjh221G47fa+Fk3
 231M8lLNf2ZlwgDKT8l44+QKZL1sZtwmTQtsDodweboNvpplu9q1VJLQ6f6T05gY+iRp
 CiCRpw/Bc0btrKjyHZ5KotgsCLal3gDMzx/1LNlcJtcZn02muSVPUDpuFReHeB1ZH6/e
 mweLytPDg9EmW28hPseSpJUces4Zdle2BL79vBLx2XaB8NqnI6uhr5Ev5uMd+hMaRHr7
 XxMQ==
X-Gm-Message-State: APjAAAXy+57iwu+m6AE9mGrM5x7UwFaIye5ORSlnXuNDkubt5W6Uq8tG
 rmyNFTpfQLIY7LJHVorwBNzj+6nH+raLjhLTyFsTONEj+tsklPri6fUjSiW1UbiX4uoRC7goDMN
 2XeL61UZfhLKyZtw=
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr4239824wrt.253.1582708055387; 
 Wed, 26 Feb 2020 01:07:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIQfWQxm1m/XuaBG3gKFFThXgSVFZxp6KSDGzjOdkOZLrjtmcEcqWOjEQMMmDMdEkBfvNhJw==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr4239800wrt.253.1582708055144; 
 Wed, 26 Feb 2020 01:07:35 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g10sm2443272wrr.13.2020.02.26.01.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:34 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 24/30] libvhost-user-glib: use
 g_main_context_get_thread_default()
Message-ID: <20200226090010.708934-25-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
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


