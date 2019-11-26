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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08EEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC792071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcQUjhhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC792071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY9G-00015m-9r
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsL-0005fI-4T
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmU-0003Ar-E0
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:19 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmU-0003AV-8L
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:14 -0500
Received: by mail-pf1-x443.google.com with SMTP id s5so8932875pfh.9
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B6QMMXb6Lc0tWH98wR58tzl2/7IOcJXsAUoOf1rCNto=;
 b=TcQUjhhkWtAHHBo7BGhoPxdH+OkQBuhIxzcHX5EgouRjPkgbXzarm0y1vo1NhR8gDf
 eG2Lo7ddCpKcjSeJMFMlcP8tJQ/55Jt0TGNgznW4/XjmDldCe92mvnBxFGEghuAeWujG
 7zNia4tH4IGRLOy70KvJXM+j82tbJ8nUIicPouLS6TjkV6HD27P/W/h6R5O7MmSu2k+V
 143iMJdLR6+6bv9luW2P50ryb4MAyiIUafw49CErl7oj+EMEJ7fXiv42whVv9WX7vO8P
 re3ksZIi50XxOCmuXJZr+0KLAm6i5NuOZT8Bux4mTYLARNU4OGVu3EBoIPihOhj+s8jc
 e7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B6QMMXb6Lc0tWH98wR58tzl2/7IOcJXsAUoOf1rCNto=;
 b=Ou/qi6Tm5KlbSiFyCYVj2d31mz5Bk8lNyFoT0zYQbLT4vmp0pG1ADfCXBU+jqZCCnv
 Ci53P6dIGawn5ZWAicwE3VCzAunvkiMUSYztRqU6JqnmxXH5fbd7XhaS5Ah1QaSh4Vvv
 9vw3WOoyEViZ9lZ8DICVCVOphs13GHkYy89bnAFmVNdqzBf7kFGbq1GAxoLbMQSBJcnO
 zf4j47A0CGarx2JFXxVNUavnxLi7U+0fT8bbG635+/NJ8FbdQWrD3nKTh9/rasOrnzO9
 HtN+xXLIta+YMlrJT5RTdogfxQJxJg8GRT9GDxettg9iA8Y2tuZcUpm2ygr7ab4sspoM
 fYpw==
X-Gm-Message-State: APjAAAUmqlpIbBqGZgQI8CVrEfP5hm93vv6wkjy0dR9YeEKdyoxUYM7+
 tV2y/T1nf1NtWoDe5Hs1lU4=
X-Google-Smtp-Source: APXvYqzpyS68KcI5oBdWBrSJfaGRRiRmODA4vA4zTy1YjkKqKqQWp2z/hxWs5tczO+UmDNsD9QUaSw==
X-Received: by 2002:a63:d14d:: with SMTP id c13mr18566161pgj.227.1574762953032; 
 Tue, 26 Nov 2019 02:09:13 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:12 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 08/18] tun: run offloaded XDP program in Tx path
Date: Tue, 26 Nov 2019 19:07:34 +0900
Message-Id: <20191126100744.5083-9-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

run offloaded XDP program as soon as packet is removed from the ptr
ring. Since this is XDP in Tx path, the traditional handling of
XDP actions XDP_TX/REDIRECT isn't valid. For this reason we call
do_xdp_generic_core instead of do_xdp_generic. do_xdp_generic_core
just runs the program and leaves the action handling to us.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/tun.c | 149 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ecb49101b0b5..466ea69f00ee 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -131,6 +131,7 @@ struct tap_filter {
 /* MAX_TAP_QUEUES 256 is chosen to allow rx/tx queues to be equal
  * to max number of VCPUs in guest. */
 #define MAX_TAP_QUEUES 256
+#define MAX_TAP_BATCH 64
 #define MAX_TAP_FLOWS  4096
 
 #define TUN_FLOW_EXPIRE (3 * HZ)
@@ -2156,6 +2157,109 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
+static struct sk_buff *tun_prepare_xdp_skb(struct sk_buff *skb)
+{
+	struct sk_buff *nskb;
+
+	if (skb_shared(skb) || skb_cloned(skb)) {
+		nskb = skb_copy(skb, GFP_ATOMIC);
+		consume_skb(skb);
+		return nskb;
+	}
+
+	return skb;
+}
+
+static u32 tun_do_xdp_offload_generic(struct tun_struct *tun,
+				      struct sk_buff *skb)
+{
+	struct tun_prog *xdp_prog;
+	struct xdp_buff xdp;
+	u32 act = XDP_PASS;
+
+	xdp_prog = rcu_dereference(tun->offloaded_xdp_prog);
+	if (xdp_prog) {
+		skb = tun_prepare_xdp_skb(skb);
+		if (!skb) {
+			act = XDP_DROP;
+			kfree_skb(skb);
+			goto drop;
+		}
+
+		act = do_xdp_generic_core(skb, &xdp, xdp_prog->prog);
+		switch (act) {
+		case XDP_TX:
+			/*
+			 * Rx path generic XDP will be called in this path
+			 */
+			netif_receive_skb(skb);
+			break;
+		case XDP_PASS:
+			break;
+		case XDP_REDIRECT:
+			/*
+			 * Since we are not handling this case yet, let's free
+			 * skb here. In case of XDP_DROP/XDP_ABORTED, the skb
+			 * was already freed in do_xdp_generic_core()
+			 */
+			kfree_skb(skb);
+			/* fall through */
+		default:
+			bpf_warn_invalid_xdp_action(act);
+			/* fall through */
+		case XDP_ABORTED:
+			trace_xdp_exception(tun->dev, xdp_prog->prog, act);
+			/* fall through */
+		case XDP_DROP:
+			goto drop;
+		}
+	}
+
+	return act;
+drop:
+	this_cpu_inc(tun->pcpu_stats->tx_dropped);
+	return act;
+}
+
+static u32 tun_do_xdp_offload(struct tun_struct *tun, struct tun_file *tfile,
+			      struct xdp_frame *frame)
+{
+	struct tun_prog *xdp_prog;
+	struct tun_page tpage;
+	struct xdp_buff xdp;
+	u32 act = XDP_PASS;
+	int flush = 0;
+
+	xdp_prog = rcu_dereference(tun->offloaded_xdp_prog);
+	if (xdp_prog) {
+		xdp.data_hard_start = frame->data - frame->headroom;
+		xdp.data = frame->data;
+		xdp.data_end = xdp.data + frame->len;
+		xdp.data_meta = xdp.data - frame->metasize;
+
+		act = bpf_prog_run_xdp(xdp_prog->prog, &xdp);
+		switch (act) {
+		case XDP_PASS:
+			break;
+		case XDP_TX:
+			/* fall through */
+		case XDP_REDIRECT:
+			/* fall through */
+		default:
+			bpf_warn_invalid_xdp_action(act);
+			/* fall through */
+		case XDP_ABORTED:
+			trace_xdp_exception(tun->dev, xdp_prog->prog, act);
+			/* fall through */
+		case XDP_DROP:
+			xdp_return_frame_rx_napi(frame);
+			break;
+		}
+	}
+
+	return act;
+}
+
 static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -2574,6 +2678,47 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	return ret;
 }
 
+static int tun_consume_packets(struct tun_file *tfile, void **ptr_array, int n)
+{
+	struct tun_prog *xdp_prog;
+	struct xdp_frame *frame;
+	struct tun_struct *tun;
+	int i, num_ptrs;
+	int pkt_cnt = 0;
+	void *pkts[MAX_TAP_BATCH];
+	void *ptr;
+	u32 act;
+
+	if (unlikely(!tfile))
+		return 0;
+
+	if (n > MAX_TAP_BATCH)
+		n = MAX_TAP_BATCH;
+
+	rcu_read_lock();
+	tun = rcu_dereference(tfile->tun);
+	if (unlikely(!tun))
+		return 0;
+	xdp_prog = rcu_dereference(tun->offloaded_xdp_prog);
+
+	num_ptrs = ptr_ring_consume_batched(&tfile->tx_ring, pkts, n);
+	for (i = 0; i < num_ptrs; i++) {
+		ptr = pkts[i];
+		if (tun_is_xdp_frame(ptr)) {
+			frame = tun_ptr_to_xdp(ptr);
+			act = tun_do_xdp_offload(tun, tfile, frame);
+		} else {
+			act = tun_do_xdp_offload_generic(tun, ptr);
+		}
+
+		if (act == XDP_PASS)
+			ptr_array[pkt_cnt++] = ptr;
+	}
+
+	rcu_read_unlock();
+	return pkt_cnt;
+}
+
 static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
 		       int flags)
 {
@@ -2594,9 +2739,7 @@ static int tun_recvmsg(struct socket *sock, struct msghdr *m, size_t total_len,
 			ptr = ctl->ptr;
 			break;
 		case TUN_MSG_CONSUME_PKTS:
-			ret = ptr_ring_consume_batched(&tfile->tx_ring,
-						       ctl->ptr,
-						       ctl->num);
+			ret = tun_consume_packets(tfile, ctl->ptr, ctl->num);
 			goto out;
 		case TUN_MSG_UNCONSUME_PKTS:
 			ptr_ring_unconsume(&tfile->tx_ring, ctl->ptr,
-- 
2.20.1


