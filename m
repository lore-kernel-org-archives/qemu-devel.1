Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E0C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890632071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc9u7EWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890632071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXvh-0000aI-4S
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsK-0005R4-9X
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmf-0003Iq-NZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:26 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmf-0003IZ-IG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:25 -0500
Received: by mail-pg1-x542.google.com with SMTP id b137so6441484pga.6
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EWBtU+IlOUXhhtmkIhJ52D/yxzedCQhAg5N/fljwEYM=;
 b=mc9u7EWTbaAvtKBfR1FxVgVgSAqvpWaqH4I+At8oqCl0wPs4cfCfmxX5bUF+7APNl4
 Xmw2dKPJ0fdmby7ayXU98TCOKpU3tQ1wLifizZBS9IU8NwE5tsD4IoVzY5pYlcirUpf9
 GML0jDXsPkYpnJe+/RALaLB8XlL6sdizXEjybBT7EgZxdovS1whnnDXgS67wftULUchR
 O3p4sPYpo+nunkY6U7wrAUIFDpc4+vzXWVNuD0tkqqUfIITHpRM0zfXFvhm5VUEnlf0k
 FecGp1HqFADGdhQP1ea4gIcNAQRIySeCIanS7L8aCvBvaHue4K/B4u8Yk6YJPLPoV0QZ
 x0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EWBtU+IlOUXhhtmkIhJ52D/yxzedCQhAg5N/fljwEYM=;
 b=PVaHsPmnSaBAoIewRpmzJmfZq5fV5nLfNy93C8l+NMKvPl+z2BsS/D3j4CQwSCbm5Q
 94OCaZhqyintRtuA5iPvo00f322K5lBDvS2uttcAoUxFCRw1bPv+HzTmvEfX1h+VHxka
 ajnldUiR+2+APDxVzDDyoBE6F9reCwbgkthHMIdhRT5D+aAxQf8uIkwENPsIXGiqIh6b
 LIfhYxslH1W1TkvYFMQALClYhNT1IKp2mHBnv0Orjk1IRjPf/arLordQAIlq1S79w0Je
 ANM8OmTo6YAzo5EfDiWG+Yc05ZZdXzTaJ6/RirspYlAfY5UQ6n6xAJi9TxEgdgayA94q
 MKLQ==
X-Gm-Message-State: APjAAAW689sirDqQY+U4xOl9jjcA3M6T5zHD0A98zDdZzWpVR8G9LGiF
 qPbNt1OdHN5Ow2cQk/fWaxU=
X-Google-Smtp-Source: APXvYqz49czbgi+kYj34fPF5hK5fvqdKlFHvat1AI4Q3wYxfqfWIPNVeAlyJ9wlfZ+jcUET4SjDAZg==
X-Received: by 2002:a63:6b87:: with SMTP id
 g129mr29079841pgc.438.1574762964825; 
 Tue, 26 Nov 2019 02:09:24 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:24 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 11/18] tun: run xdp prog when tun is read from file
 interface
Date: Tue, 26 Nov 2019 19:07:37 +0900
Message-Id: <20191126100744.5083-12-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

It handles the case when qemu performs read on tun using file
operations.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/tun.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 084ca95358fe..639921c10e32 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2318,8 +2318,10 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 			   struct iov_iter *to,
 			   int noblock, void *ptr)
 {
+	struct xdp_frame *frame;
 	ssize_t ret;
 	int err;
+	u32 act;
 
 	tun_debug(KERN_INFO, tun, "tun_do_read\n");
 
@@ -2333,6 +2335,15 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 		ptr = tun_ring_recv(tfile, noblock, &err);
 		if (!ptr)
 			return err;
+
+		if (tun_is_xdp_frame(ptr)) {
+			frame = tun_ptr_to_xdp(ptr);
+			act = tun_do_xdp_offload(tun, tfile, frame);
+		} else {
+			act = tun_do_xdp_offload_generic(tun, ptr);
+		}
+		if (act != XDP_PASS)
+			return err;
 	}
 
 	if (tun_is_xdp_frame(ptr)) {
-- 
2.20.1


