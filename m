Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A76FC43446
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161BC206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkrYl2FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161BC206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04Dp-0000Bw-98
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Ay-0003Sq-7C
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Av-0001GK-Ey
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlYRcRi7Yo9IrPxeu+mUP+g3rj5dPNkuezWzuDEddIw=;
 b=CkrYl2FId899utNSsOiJbGlB4KXc12fmaExsskgtEbkdnRvwmjq0OXFFqmDV/PzdFBCW4Z
 tJ4Fbq4fMjdgNubJfboszF2VeHywxAXzFRYM0wy6f0PByUIxJ3fFozPgH+3i3oxx1ekrQD
 E7h2w6noodsHn+cwhRn5U3NtBVeDcoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-Imq_CHA4Mri4RbwILnd1Qg-1; Mon, 27 Jul 2020 10:32:18 -0400
X-MC-Unique: Imq_CHA4Mri4RbwILnd1Qg-1
Received: by mail-wr1-f72.google.com with SMTP id j16so4027633wrw.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SlYRcRi7Yo9IrPxeu+mUP+g3rj5dPNkuezWzuDEddIw=;
 b=Bn8lcrYoinrRUDuUnD4+Sx4LZ29IVccw7HK2TV5Fhluo73J1+dSr0ATQpj7KlpSIbw
 s1dkY70C2lPoiFRu3SKDWdjNDh04iXaQtelszu1FV8qZU11vCYFGVQtBmgA2DLISNO0N
 6TxlEsh7w3bXAZEJxK6jv2zSe0DgKJ5pJyf8/Yyja5QX0rswB7MeAX5XatS82cx2DBpy
 zKXNEeS5/uDFJ1F8ncsy4eGI+m6Iy0mGqQO9tnN/b3teIJR+kro2fgb2HdPQye3QPWbV
 VNH0fXVZBK7dvKfd5g8d3AqpGb15tPtHrWmX/aIjYEldXpDTM1hSrlWLQRI5ezEPYyMF
 mckg==
X-Gm-Message-State: AOAM533K/KnCWzVqosBdfgJZRAf3CWobupH6StDLOZxhzv5vsNDO46Pc
 HlrW7TRFDk2qL09ZFExcrESgwTs4sSuxApT1Lsw8ozfRotQECFtfDbyHfx71Bxf7UJrTWDzZ13+
 cOt02Jaj6mC4aCOo=
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr2138820wmd.72.1595860337453; 
 Mon, 27 Jul 2020 07:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHqvjim4QhRrSK1lx7mSlYHlKJSvdzsZfzNcMtb8BjuiFhBfom6VhLdx7VZfk9XQXrc4wG3g==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr2138803wmd.72.1595860337297; 
 Mon, 27 Jul 2020 07:32:17 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id h11sm13657004wrb.68.2020.07.27.07.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:16 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:32:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 4/6] libvhost-user: Report descriptor index on panic
Message-ID: <20200727143104.97776-5-mst@redhat.com>
References: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727143104.97776-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Johannes Berg <johannes.berg@intel.com>, qemu-stable@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We want to report the index of the descriptor,
not its pointer.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200723171935.18535-1-philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index d315db1396..53f16bdf08 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
 
     /* If their number is silly, that's a fatal mistake. */
     if (*head >= vq->vring.num) {
-        vu_panic(dev, "Guest says index %u is available", head);
+        vu_panic(dev, "Guest says index %u is available", *head);
         return false;
     }
 
@@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
     smp_wmb();
 
     if (*next >= max) {
-        vu_panic(dev, "Desc next is %u", next);
+        vu_panic(dev, "Desc next is %u", *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
 
-- 
MST


