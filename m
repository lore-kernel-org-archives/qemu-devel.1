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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F65C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 735372073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olv12Gp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735372073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY37-0002y5-A2
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsM-0005fI-IF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXm6-0002re-Nx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:08:51 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXm6-0002rZ-Ig
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:08:50 -0500
Received: by mail-pj1-x1042.google.com with SMTP id bo14so8069590pjb.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TORKveKiyyu6m2oHodE9IBcjkbwEar3Vt5jDpzgDylY=;
 b=olv12Gp3grnekpbckL4cgsuKfI3uibM/xyKgxKaXAgysBCG0gD1zfwzI4bdTig2QPa
 bYj2KhBwBQCyeYdYx2+f9ANR6ntDY1QlasYD6qxyDMTFGZj2uvm7ko8kE58GZXl1Gx83
 yxZQsAPqwNrJ0vcBYS7ybC0BFUlHVtzRy09jDp4McRhur9+hRM3WTEt+lbKHstbWmP9z
 At4RGyUZXvbnGh/bg5mBCIRT9jJzXZ/XyUpQTxrGKC9T6fcorgnyhMn8Hm9GLjMjBr2J
 pd/ik9nqYGr+vwPtpw0IYIaT05AfrD53fQBnlXT6YI9axZ6zErZc8n6ZW5g2ZslzHp5l
 2UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TORKveKiyyu6m2oHodE9IBcjkbwEar3Vt5jDpzgDylY=;
 b=Tn1DFshuUTrhfJLWiab+IittF8NmIHLYNURZsYVt2vW1tZaEqVVxBQf7Vk+rKoSqt5
 MNUkiDc6CpRLxsgoW0ANmWF0xGWEpQBkbAOnIPG2LExYK5cIBVSWmbVBW1hNcocN96dV
 k1Ix9D+OC0umb8vF0/NOiL1CS27wfSR5QZT4w1Ca1HdtWEckl5G5Cah/i466iECeDceo
 VO99Y/VRy9scL9LY5/JJydQSRnNceeRCBphuWsaoIeISStZ38kPc7+LgiBpBu26N5tKx
 pFfDxERqSUEPjthn934HGstXt4b8p0YSs8MNatgzyxlQ+Ql8gh+L4GvWFyUNEHwOyFUy
 ipcg==
X-Gm-Message-State: APjAAAUoi1OcaxCW2/fjoRUXssZbv4SAjy6bZHaheiqCuTlxxNXjVHKD
 8J6wZfdDlDJBAHvJEHEVums=
X-Google-Smtp-Source: APXvYqy7uBDP8l0aXZ/j5b2P/uoXgigesp5vSEQ3UrSFY/YqyNb+UCqonnG8Y2jEb1rpt6g0c9YHbg==
X-Received: by 2002:a17:90a:c789:: with SMTP id
 gn9mr5574668pjb.99.1574762929845; 
 Tue, 26 Nov 2019 02:08:49 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:08:49 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 02/18] net: core: rename netif_receive_generic_xdp() to
 do_generic_xdp_core()
Date: Tue, 26 Nov 2019 19:07:28 +0900
Message-Id: <20191126100744.5083-3-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

From: Jason Wang <jasowang@redhat.com>

In skb generic path, we need a way to run XDP program on skb but
to have customized handling of XDP actions. netif_receive_generic_xdp
will be more helpful in such cases than do_xdp_generic.

This patch prepares netif_receive_generic_xdp() to be used as general
purpose function by renaming it.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c7fc902ccbdc..5ae647b9914f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4461,9 +4461,9 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 	return rxqueue;
 }
 
-static u32 netif_receive_generic_xdp(struct sk_buff *skb,
-				     struct xdp_buff *xdp,
-				     struct bpf_prog *xdp_prog)
+static u32 do_xdp_generic_core(struct sk_buff *skb,
+			       struct xdp_buff *xdp,
+			       struct bpf_prog *xdp_prog)
 {
 	struct netdev_rx_queue *rxqueue;
 	void *orig_data, *orig_data_end;
@@ -4610,7 +4610,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 		u32 act;
 		int err;
 
-		act = netif_receive_generic_xdp(skb, &xdp, xdp_prog);
+		act = do_xdp_generic_core(skb, &xdp, xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
 			case XDP_REDIRECT:
-- 
2.20.1


