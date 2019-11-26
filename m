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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A336C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA36B2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajEYLyOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA36B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY9y-00022w-FS
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsL-0005R4-He
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmY-0003FS-4J
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:19 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmX-0003FA-Ul
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:18 -0500
Received: by mail-pg1-x543.google.com with SMTP id i5so479321pgj.9
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A+zZHbHPcf2+kZRFz8qYInOcnfbpxMipg8cRARobJQk=;
 b=ajEYLyOj6rPflxN/F4j7gzmTTfjkzFiOUEnj4x/mlPjwT6HScKGEYBOt5supKzMBi7
 YBKGt62f0nlaJKL+4zEw20xBeu1qYjK6d3SjEQUAl982WY7KJ01zVqk8DP3SnV/E/4fE
 CvaL6nj6eGp7V+momNglWpxUiWUrQvkycbmynW0f+hE5TfdRhAIloHm1ZaWraGj06zkS
 pbNZdnR7LBGBbDTgO7C2YbNJOL1telar0aLkM/XV6T7hkE7/6YBVYNdFfy3Jeey0Oa37
 By6HHXTNu/fbLWGSKnYoHiZtOXRdndYXg/KtDhSuf3L0sVTRKHyC/x4qHts5RUV3kdo8
 txrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A+zZHbHPcf2+kZRFz8qYInOcnfbpxMipg8cRARobJQk=;
 b=ED0RwVLROOHKuiyISVTOLQkU4T6a/C53aIRq7LL8kL78ttgXrY6iGxeD3KwQVAuvKW
 KeGW6hIRoHWyleh2Q0K0QSbIrGEHX9grof+b4cQ1Kbk1dGj6z6NIeGVKVb+biItRLWHL
 f3qGE+LLJlV/fUASAwVZRuAn3V5K6URgNx/HnTWsoKNZrFsE9QKttA9dWlxFBwvP1b4D
 u2bnCbwA0QCLjrVpIf1j7yORUtnzvTOS4XEKilM/85CqBfQNGnIgyG80r/vhVaR3ZujT
 qaik9HmHVM8vnSEDqkAUQTfHzgKuxswQclLwoJs1YJ/Q3V5GS168wv5tEvAFaM2hcxHl
 G53g==
X-Gm-Message-State: APjAAAW3ugsu87NI7D4w7bb9SSd4iAYCaSsMxVZNdz8CzvdeIduwrcQo
 o+nIRVWBjOAt1bxOk9pBQDk=
X-Google-Smtp-Source: APXvYqza/1KXHr4vy/bIqcXkAf21DPD3YjEsUIsSGZ5/9H4FB/QXnB77j4wEUyEgpjV4ork9q/KtvA==
X-Received: by 2002:a63:b40d:: with SMTP id s13mr38800406pgf.215.1574762957081; 
 Tue, 26 Nov 2019 02:09:17 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:16 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 09/18] tun: add a way to inject Tx path packet into Rx
 path
Date: Tue, 26 Nov 2019 19:07:35 +0900
Message-Id: <20191126100744.5083-10-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

In order to support XDP_TX from offloaded XDP program, we need a way
to inject Tx path packet into Rx path. Let's modify the Rx path
function tun_xdp_one() for this purpose.

This patch adds a parameter to pass information whether packet has
virtio_net header. When header isn't present, it is considered as
XDP_TX'ed packet from offloaded program.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/tun.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 466ea69f00ee..8d6cdd3e5139 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2221,6 +2221,13 @@ static u32 tun_do_xdp_offload_generic(struct tun_struct *tun,
 	return act;
 }
 
+static int tun_xdp_one(struct tun_struct *tun,
+		       struct tun_file *tfile,
+		       struct xdp_buff *xdp, int *flush,
+		       struct tun_page *tpage, int has_hdr);
+
+static void tun_put_page(struct tun_page *tpage);
+
 static u32 tun_do_xdp_offload(struct tun_struct *tun, struct tun_file *tfile,
 			      struct xdp_frame *frame)
 {
@@ -2527,23 +2534,36 @@ static void tun_put_page(struct tun_page *tpage)
 static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
 		       struct xdp_buff *xdp, int *flush,
-		       struct tun_page *tpage)
+		       struct tun_page *tpage, int has_hdr)
 {
 	unsigned int datasize = xdp->data_end - xdp->data;
-	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
-	struct virtio_net_hdr *gso = &hdr->gso;
+	struct tun_xdp_hdr *hdr;
+	struct virtio_net_hdr *gso;
 	struct tun_pcpu_stats *stats;
 	struct bpf_prog *xdp_prog;
 	struct sk_buff *skb = NULL;
+	unsigned int headroom;
 	u32 rxhash = 0, act;
-	int buflen = hdr->buflen;
+	int buflen;
 	int err = 0;
 	bool skb_xdp = false;
 	struct page *page;
 
+	if (has_hdr) {
+		hdr = xdp->data_hard_start;
+		gso = &hdr->gso;
+		buflen = hdr->buflen;
+	} else {
+		/* came here from tun tx path */
+		xdp->data_hard_start -= sizeof(struct xdp_frame);
+		headroom = xdp->data - xdp->data_hard_start;
+		buflen = datasize + headroom +
+			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	}
+
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
-		if (gso->gso_type) {
+		if (has_hdr && gso->gso_type) {
 			skb_xdp = true;
 			goto build;
 		}
@@ -2588,7 +2608,8 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
-	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
+	if (has_hdr &&
+	    virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
 		this_cpu_inc(tun->pcpu_stats->rx_frame_errors);
 		kfree_skb(skb);
 		err = -EINVAL;
@@ -2652,7 +2673,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
-			tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
+			tun_xdp_one(tun, tfile, xdp, &flush, &tpage, true);
 		}
 
 		if (flush)
-- 
2.20.1


