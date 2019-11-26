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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A15C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4129A2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLp6iRQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4129A2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY0n-0007nx-0O
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsJ-0005e4-T9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXmn-0003OR-H4
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:34 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXmn-0003O8-BV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:33 -0500
Received: by mail-pg1-x541.google.com with SMTP id i5so479698pgj.9
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zx5Ey469MhuUUqEJoZa/8N8K8LFzbIEk0ZZ64tnsKp0=;
 b=tLp6iRQl3sTOSSAx/gYoWpZG6XJZLoT8Zsh4xTn5YujxIAIlwEJMfJD/rbDLDKunxB
 PPLhWNxdNgkLYho5QUCo4jvD2cNjRkGWG6TUcgyp8JAnzvNAS/wBqESuBabVuZ58ZXMA
 CjvxUg68D5TAnjrU3ucmi0vThEn2NdeL2t0OCC+t1mzws0+Uo2GF7nK9INOfwKCC+uvF
 8tn+hq13m8b2koupUYky/h2w8ql+9nXEVhJybe8LqphIjRZMW5HRezUzTCS/F9spcCWo
 ReC2AEI2NuSoPd4v59sHgkAEbAfWOp9Mdh5J9/gpiK41Xs5JEe0O3S4M624X2enKwNJd
 lrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zx5Ey469MhuUUqEJoZa/8N8K8LFzbIEk0ZZ64tnsKp0=;
 b=SmYc8wv3nbDlYKrBuzhzgF2A8ZapFdPfMXJH9ckSNQAd0dkzylxMjLGtTUwGA2vo0T
 7NIpa277kpCcD9Tt0m0LJoKEh70lQggUy2PMshQvqRMK5VPGyIi2A+7gxCXHiQsP+ZSM
 6hDN700Ndeam93px+QNTRMIdqOQU+3uTzJeDc/Rb0TnW4iCT7Bru7TTGI0J2Imdl/K9u
 j+wnPTpu4biiQ8gx/ejP7HdwUVLl2kpCorGMGPAL4meWDYhve+ebxyYYI94onOwWfC2C
 MFqlIJxh6DgEfqNFr3g/Vmp59ZD4I3e9ehcI6N3PUKWlQe4zeEsUo6Z065HL8JvmvdCJ
 cX8A==
X-Gm-Message-State: APjAAAUZnNgVb/19lpOjVy/mui9UT1KHXtTJPiThH8D40P0jR7G+cLjz
 AD8r+1IAtsBncT8nVndPQGA=
X-Google-Smtp-Source: APXvYqy5nSGYMuA9W/Y541xqtiKlrCKtpPV27lN87wYp1YRIe1p9W24OXy6SRFejVlg/PWYn3qdtdA==
X-Received: by 2002:a63:6b46:: with SMTP id g67mr37703871pgc.371.1574762972460; 
 Tue, 26 Nov 2019 02:09:32 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:32 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 13/18] virtio_net: use XDP attachment helpers
Date: Tue, 26 Nov 2019 19:07:39 +0900
Message-Id: <20191126100744.5083-14-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

Next patches will introduce virtio_net XDP offloading. In that case
we need to manage offloaded and non-offload program. In order to make
it consistent this patch introduces use of XDP attachment helpers.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/virtio_net.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c8bbb1b90c1c..cee5c2b15c62 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -229,6 +229,8 @@ struct virtnet_info {
 	struct failover *failover;
 
 	struct bpf_prog __rcu *xdp_prog;
+
+	struct xdp_attachment_info xdp;
 };
 
 struct padded_vnet_hdr {
@@ -2398,15 +2400,19 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 	return virtnet_set_guest_offloads(vi, offloads);
 }
 
-static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
-			   struct netlink_ext_ack *extack)
+static int virtnet_xdp_set(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	unsigned long int max_sz = PAGE_SIZE - sizeof(struct padded_vnet_hdr);
+	struct netlink_ext_ack *extack = bpf->extack;
 	struct virtnet_info *vi = netdev_priv(dev);
+	struct bpf_prog *prog = bpf->prog;
 	struct bpf_prog *old_prog;
 	u16 xdp_qp = 0, curr_qp;
 	int i, err;
 
+	if (!xdp_attachment_flags_ok(&vi->xdp, bpf))
+		return -EBUSY;
+
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
 	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
@@ -2478,8 +2484,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 	}
 
-	if (old_prog)
-		bpf_prog_put(old_prog);
+	xdp_attachment_setup(&vi->xdp, bpf);
 
 	return 0;
 
@@ -2501,26 +2506,13 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return err;
 }
 
-static u32 virtnet_xdp_query(struct net_device *dev)
-{
-	struct virtnet_info *vi = netdev_priv(dev);
-	const struct bpf_prog *xdp_prog;
-
-	xdp_prog = rtnl_dereference(vi->xdp_prog);
-	if (xdp_prog)
-		return xdp_prog->aux->id;
-
-	return 0;
-}
-
 static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
+		return virtnet_xdp_set(dev, xdp);
 	case XDP_QUERY_PROG:
-		xdp->prog_id = virtnet_xdp_query(dev);
-		return 0;
+		return xdp_attachment_query(&vi->xdp, xdp);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


