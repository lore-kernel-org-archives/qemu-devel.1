Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69202C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BD020727
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fru48dzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BD020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXyG-00043F-SM
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsK-0005g9-Mw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmb-0003HF-WE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:22 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmb-0003Gl-Qx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:21 -0500
Received: by mail-pf1-x444.google.com with SMTP id i187so4767844pfc.7
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=svo/DJZyqQpUo02aclcCc0QABc66WKSHZ6zQKD7a+Ow=;
 b=fru48dzlPmxdsRDObkYQrHO7JapBQH3c9E855CQRNtWbayYXM0dPryQmi5/whFOlpS
 GH/fVBCqvL0AWAPenfff2xRlbHbJeyN0FRY1MhHhuPk2ZlwRT9JdOfr9u4eKWjej1HTC
 q8G8loaTXtCX8EcOlrVw8hLTEh4GJrvM6aVuqV67oJNuisl5NmKblB7E+689x4Qa7LIa
 4SQq9JNWkXDoaqj5RJYNpcE68Ha/YC5zbmY6IAUN1+QQ+4kJDzhyh+LTm5ZfOUaLxAhM
 sWkA++CI/tDwSaPETlK0YUOCfMRpR+0Q+b9L8Xpbo+zpd9pTLP+X50M8f7aw4NZ0ZvnG
 QC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=svo/DJZyqQpUo02aclcCc0QABc66WKSHZ6zQKD7a+Ow=;
 b=Pw+/VHpewCCUoDqew8WBcgQ4L7QEunkTa5Yai/wYfhFJBwln7Csb7TdUjo+DouwXvh
 tDEiCJCpzVMZhBF3xkj1QwurUUDOUVEpwCwYE0ZJMYWpyqRXgmKvLBFOJSM1kvdcCUp8
 lV4fEiLJFJzQ/Wkm16avy7S+GVBhkGYyCjUE5a4wc7VACyyi4Hfry1X+gfxtcbIfSMn9
 ujGVM0CP9ZiXwlp0uq+ShzW7+RN0uKNqaYLH4o5uTDGbChNSoFf4eiyZp/t18qzLSd49
 183r4i6SNDhnUtcyZxFm+Em/h0Zdi9Fv494k0DFjZLYP7lkjvMmsY2954MkFMpvY3f0W
 Xqvw==
X-Gm-Message-State: APjAAAVqleTR2agp6cWBjH33aMpIIvmIfeTWJdotIHOpVRm88Q0i9oxg
 FGbGOy+Spdan9zDa5zrnWO8=
X-Google-Smtp-Source: APXvYqx1KJySu2VSUlGFNdx7ooxLmUOdCiiNdkl+RVxrLvkON5zLWT+2U/MjtFSUA7MS5Y/R8paLmg==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr39206249pgi.128.1574762960938; 
 Tue, 26 Nov 2019 02:09:20 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:20 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 10/18] tun: handle XDP_TX action of offloaded program
Date: Tue, 26 Nov 2019 19:07:36 +0900
Message-Id: <20191126100744.5083-11-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When offloaded program returns XDP_TX, we need to inject the packet in
Rx path of tun. This patch injects such packets in Rx path using
tun_xdp_one.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/tun.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8d6cdd3e5139..084ca95358fe 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2249,7 +2249,13 @@ static u32 tun_do_xdp_offload(struct tun_struct *tun, struct tun_file *tfile,
 		case XDP_PASS:
 			break;
 		case XDP_TX:
-			/* fall through */
+			tpage.page = NULL;
+			tpage.count = 0;
+			tun_xdp_one(tun, tfile, &xdp, &flush, &tpage, false);
+			tun_put_page(&tpage);
+			if (flush)
+				xdp_do_flush_map();
+			break;
 		case XDP_REDIRECT:
 			/* fall through */
 		default:
-- 
2.20.1


