Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEACC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC9120679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC9120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccrV-0000G7-HQ
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccox-0006bP-9o
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccov-0006RX-Cq
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:15 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:33757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccot-0006GA-Dm
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:12 -0400
Received: by mail-qt1-f176.google.com with SMTP id x2so8616310qtr.0
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=sOzxjaxXZhFIM4T7ykCmJFzLsbhwbAgdv3UhWRHjuOw=;
 b=l+KjJ2jgxZnKRzEM4S0uMdfHgmC7RpCmIPmPW4dHWfOsf0ZsoPy9jJCOu8qYrIy4To
 RsDdIHxMU1syiHQbKnXyTd1tDF7+16vL2F6jyit93XV3EisyJAt1R64l4xodqvjjpt6f
 igy0E2o1EFUBPPgm32vfE9LgH20tJW0d65Qg5UISth0E9sJHkFugMn6QpD8AV866A1+E
 rMT9wqGBcidTan4JbAxtpHrjPWNFPLgfOzBsA0z4tBGjh/shBCkCr/LqpJdVM7atPsyh
 2S6l/pS0CLn5RTVq04sHaV9R4F3rdxptXb6SMusivYcQEN+ihpVIcBto/J+xbpUS6pUr
 osSg==
X-Gm-Message-State: APjAAAX6PE5i5uLWERQJCcr1jnVruyPMPvbfeqkReioXQBmWd25TuiIO
 c+Tp6H/e7XQr4hyllXuH+mqpDXDzyDA=
X-Google-Smtp-Source: APXvYqwJiyMF0pB/UPwgGzQYWpfDODvogzRm4LgSkzn+KwVNtpWnYhmf6BSHUkTuo6HmihP2vm8hww==
X-Received: by 2002:a0c:fd64:: with SMTP id k4mr18321611qvs.143.1560720967151; 
 Sun, 16 Jun 2019 14:36:07 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id 47sm2541350qtw.90.2019.06.16.14.36.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:06 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605145829.7674-2-marcandre.lureau@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.176
Subject: [Qemu-devel] [PULL 01/11] vhost-user-gpu: do not send scanout
 update if no GPU socket
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213605.FhTUwrP2ONHHdCOU3ZaUuNrfojsk4XVQ359TEJ3EuJU@z>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Should fix coverity CID 1401760.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190605145829.7674-2-marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-gpu/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.c
index f9e2146b69..9614c9422c 100644
--- a/contrib/vhost-user-gpu/main.c
+++ b/contrib/vhost-user-gpu/main.c
@@ -354,7 +354,7 @@ vg_disable_scanout(VuGpu *g, int scanout_id)
     scanout->width = 0;
     scanout->height = 0;
 
-    {
+    if (g->sock_fd >= 0) {
         VhostUserGpuMsg msg = {
             .request = VHOST_USER_GPU_SCANOUT,
             .size = sizeof(VhostUserGpuScanout),
-- 
MST


