Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C37F2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beJmDInt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C37F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zWW-0002Ww-B9
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQP-0001Dj-9J
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQO-0005s3-8F
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQO-0005rl-4h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O50p9vS8lAM1KgCOESGEUWsExX65Aroq2vWKbIYHyYM=;
 b=beJmDIntki0QCRq/p+q1l1wFUMoCpRBdFJHepydra6qn4Zvr7fmRGh+MWMVNLIUmhmLApQ
 xEA0kVR5WSOx4Ra8q7USPEnTGtpekjdQoaglYJZBlr42P60+1gXL76nuu54l0OtX7FPbvc
 yJ7TRFYwlG6Enl+hKj/UlG2lxGvLtNk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-zNg3nNoNMae5v2bdTSCvNg-1; Tue, 18 Feb 2020 04:44:13 -0500
Received: by mail-wm1-f70.google.com with SMTP id f66so870728wmf.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5tYW7J9DRdD0EtwNm+zUUQ5S0X5D36o436wq58i4uWY=;
 b=BmHjyMLAkspVepH6xYkZY0dvuBFqZ6xx/6/Mue5fhklOhcoG/tNBQx5sLS9XPeTM4P
 RhJw6H3s39cEQnZZ7egRY5zF3Jmzcwiv5PqDPX2ql3GDFwgUvALwXB2L8rE/zMvjJ6iw
 svkPK5FHWPjpX+SDzkOW2I4r6HQoMG/4FNUxARAkIXqTAvxkcR8+93IHsN+vlJHSy9GQ
 hEsGQM+pW7Cgpjh99OdNCQfhulUeSjfgC8MqiLXDLrM7mAWlUz/hDACUhTRG30oQglde
 oJomJ/3zNOOwZxoKHItAtv9/C0FkSLzOpf8gTqYxoOa/+fp/niLRRXEzGjqZu1/ACYRb
 PxoA==
X-Gm-Message-State: APjAAAXH4z6lfZVDXkokJ9TZx8wg2GovVE6HLuIXVHSs0ZqIu9ROTMsM
 MoJf+9zpjNmC4g/OGGUaHcB8G7BzG7H/aED61kI9mOifW2/2iLANUshmsOQNUqfQePCq6JiVNra
 cadrTXdnd6XzTVgk=
X-Received: by 2002:adf:8b54:: with SMTP id v20mr28935345wra.390.1582019051874; 
 Tue, 18 Feb 2020 01:44:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMtdGZ9ZNI7NaaHAT7y+lFX7mMTPGE38ySlsJjVzxj2/xLbNLLthxR5dkf47Vg3kq+jdf8sg==
X-Received: by 2002:adf:8b54:: with SMTP id v20mr28935311wra.390.1582019051646; 
 Tue, 18 Feb 2020 01:44:11 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 03/13] block: Remove superfluous semicolons
Date: Tue, 18 Feb 2020 10:43:52 +0100
Message-Id: <20200218094402.26625-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: zNg3nNoNMae5v2bdTSCvNg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 132ada80c4a
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 9c810534d6..9db0b973fe 100644
--- a/block.c
+++ b/block.c
@@ -2435,13 +2435,13 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
     if (bdrv_get_aio_context(child_bs) !=3D ctx) {
         ret =3D bdrv_try_set_aio_context(child_bs, ctx, &local_err);
         if (ret < 0 && child_role->can_set_aio_ctx) {
-            GSList *ignore =3D g_slist_prepend(NULL, child);;
+            GSList *ignore =3D g_slist_prepend(NULL, child);
             ctx =3D bdrv_get_aio_context(child_bs);
             if (child_role->can_set_aio_ctx(child, ctx, &ignore, NULL)) {
                 error_free(local_err);
                 ret =3D 0;
                 g_slist_free(ignore);
-                ignore =3D g_slist_prepend(NULL, child);;
+                ignore =3D g_slist_prepend(NULL, child);
                 child_role->set_aio_ctx(child, ctx, &ignore);
             }
             g_slist_free(ignore);
--=20
2.21.1


