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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B27C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E59320748
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA6x08ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E59320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYFv-0001Iu-Qz
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsM-0005R4-PE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXm3-0002qT-52
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:08:48 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:43244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXm2-0002qK-Va
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:08:47 -0500
Received: by mail-pj1-x1042.google.com with SMTP id a10so8054367pju.10
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Sl43iVtC4+YcjLflynrQtIj0zEs25bg62I/x2OEQu0=;
 b=rA6x08okN9S24McUdG2LHlghnPmhIHd24jmymmQaGlT2PAs6RXcIrFN4KgQ3vtEJQH
 ienFzUlPPNlyI9b9KsozGHG9jQpVMUrYON+jnaQvRyei7uhWiVfPBjDJK/c0EY88qnZp
 ZDkq7a+rI2J1MXnLhIb+/EQ22pDhhmb3BAM7x8wEHqFYQ02bE0rYvl/KjEMarmxBop+q
 p94+hXB+SsDfHHCvbR+iONGBx5fsJeIFS9XDNF/UJ7uD0+X9HjxSjqCZa8oiIpnB76Hg
 UUUoXmIcImh1gfbohC0t5i//haGFawSR5oYyXeA/IjzMZkOh/+g99F3i75HTqeit7+cx
 TveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Sl43iVtC4+YcjLflynrQtIj0zEs25bg62I/x2OEQu0=;
 b=fx3f6QLmZvbavRB7Mk90Za2/X7aYlhmnHhiaVfGPKJBhES4uQpbXepR56hRyGkKpT/
 GoaTK7ru77nbkW47JfKumtDFogU2aP1kNemjx34Q7FK3utPRCqpWIKcK8V3Pe4OY9dfX
 +ibQnY5VbqamFUJnOeHG7f9VRyGKONZNY0Tp0S13TqiehSo6dSKk3qNN58L74DTBJAO+
 DehD6zaSlyj59fI1p4UB+yfnoIn897/lUqVnQ5AIII5O2BfRCYYgwSzBTffKL7Ih5NqV
 HmUkBCXos1KmCSj26jeFy0L6SQXGhyqpWlNDfCeEC9Gz9UsqwBUVDy7yxBgtzAM2B98+
 3ksQ==
X-Gm-Message-State: APjAAAWpiXlCx9iMaP3wVzufF3wNAcXh2/LqO63ohdJjvwmPNRKQrbbr
 /fCf49Zy5I2siTSk0EiaoJI=
X-Google-Smtp-Source: APXvYqxA6tuNs0G2K7BYOi/UgwxlWXR+3qbxnD5Hrpm6hj4529qhKxDgIXplkY5qr6yeBIl6U2CJIw==
X-Received: by 2002:a17:90a:5aa3:: with SMTP id
 n32mr5651673pji.97.1574762926051; 
 Tue, 26 Nov 2019 02:08:46 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:08:45 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 01/18] bpf: introduce bpf_prog_offload_verifier_setup()
Date: Tue, 26 Nov 2019 19:07:27 +0900
Message-Id: <20191126100744.5083-2-prashantbhole.linux@gmail.com>
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

Background:
This change was initiated from virtio_net XDP offload work. As per
the implementation plan, a copy of original program with map fds from
guest replaced with map fds from host needs to be offloaded to the
host. To implement this fd replacement, insn_hook() must provide an
insn with map fd intact. bpf_map and driver specific map data can be
derived from map_fd.

Since verifier calls all the offload callbacks after replacing map
fds, it was difficult to implement virtio_net XDP offload feature.
If virtio_net gets only one callback with original bpf program, it
will get a chance to perform the fd replacement in its own copy of the
program.

Solution:
Let's introduce a setup() callback in bpf_prog_offload_ops. It will be
non mandetory. The verifier will call it just before replacing the map
fds.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/offload.c         | 14 ++++++++++++++
 kernel/bpf/verifier.c        |  6 ++++++
 4 files changed, 22 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 35903f148be5..1cdba120357c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -361,6 +361,7 @@ struct bpf_prog_offload_ops {
 			    struct bpf_insn *insn);
 	int (*remove_insns)(struct bpf_verifier_env *env, u32 off, u32 cnt);
 	/* program management callbacks */
+	int (*setup)(struct bpf_prog *prog);
 	int (*prepare)(struct bpf_prog *prog);
 	int (*translate)(struct bpf_prog *prog);
 	void (*destroy)(struct bpf_prog *prog);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 26e40de9ef55..de7028e17c0d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -418,6 +418,7 @@ static inline struct bpf_reg_state *cur_regs(struct bpf_verifier_env *env)
 	return cur_func(env)->regs;
 }
 
+int bpf_prog_offload_verifier_setup(struct bpf_prog *prog);
 int bpf_prog_offload_verifier_prep(struct bpf_prog *prog);
 int bpf_prog_offload_verify_insn(struct bpf_verifier_env *env,
 				 int insn_idx, int prev_insn_idx);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 5b9da0954a27..04ca7a31d947 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -124,6 +124,20 @@ int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr)
 	return err;
 }
 
+int bpf_prog_offload_verifier_setup(struct bpf_prog *prog)
+{
+	struct bpf_prog_offload *offload;
+	int ret = 0;
+
+	down_read(&bpf_devs_lock);
+	offload = prog->aux->offload;
+	if (offload && offload->offdev->ops->setup)
+		ret = offload->offdev->ops->setup(prog);
+	up_read(&bpf_devs_lock);
+
+	return ret;
+}
+
 int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 {
 	struct bpf_prog_offload *offload;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0482e1c4a77..94b43542439e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9737,6 +9737,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 
 	env->allow_ptr_leaks = is_priv;
 
+	if (bpf_prog_is_dev_bound(env->prog->aux)) {
+		ret = bpf_prog_offload_verifier_setup(env->prog);
+		if (ret)
+			goto skip_full_check;
+	}
+
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 
-- 
2.20.1


