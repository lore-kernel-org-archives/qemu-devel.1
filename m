Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C62C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138502222B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ERwKG+s3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138502222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeT9-0003J1-St
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeR0-0001Wi-GW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:04 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeQs-0006hc-84
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:02 -0500
Received: by mail-lf1-x142.google.com with SMTP id 141so18658544lfn.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zZvFse3oqHhuPCkivJ8Tz4pHGWRjZvWGfQDergDm21A=;
 b=ERwKG+s3W00tHZ68lWQPt8K6vtXzZv9cAnR9J4haXllUqSsnGCT/VTztPYhqXv4z0A
 XI9cCNMPrLkXNoSo162e7jCeiCqXqHJFOZX5utcKVy1MWta2aSRs0AOwaK1hZydzF6j8
 pF7xpscQ1OW1HNOZo6nNwFSTIbY9R/5U6RLsIbe6JtT5wknzw0Wzsf20xYC7scizqwn7
 ktyVXAyqJRImfpnK3JPjFv/s1mvHGuhVe5q8yQv4CnOo/WyN0UFP5S9dE1JXcIrOSSx7
 rh1UjGn2iKzW7uO1ezUdBjxVfqoanMyf4JiTv3bqF5H9bAYZFhfVQNs8tzoAXqpu9EZ7
 wxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zZvFse3oqHhuPCkivJ8Tz4pHGWRjZvWGfQDergDm21A=;
 b=HwN3oZTvgB9mgOYq3glcLIlUcqB+jrdo+9/uJE5BqBsUjiqibZwrHfg7mxxuMnexwc
 vVH3e/WPhXPfNaOC1OuwbMuxI5bx34eRanTb/EmnaO+4QhVasaM2vxOo8bWdWth7t37r
 yI1MOPHI0qqWDTBC7AraM6E7ZoOJZKXkzjkJP5Ag+CcgElGDW0LUYK162RfCkJ4VHjw/
 QzK3xdBs/EsOsipY7wMZgy5hIckL30ro9D9bhYGohMFzfiBcnNXvZ1wzlCMexlsXPOIO
 YlEsSsnjynsk3wANIfTwbe4GjAgf2xmdZqbauQgmha8BJBU4j4fQxbnIORYZnakMamSj
 tC4A==
X-Gm-Message-State: AOAM533dFUFXhs1LZVqax8HcW/3GKrOBAOTLROSf81ZLY3AZ34uMXxu8
 TvCSNYCcV1glbMqOR9rdKr9uXg==
X-Google-Smtp-Source: ABdhPJxTtWH4sA5v9GvGaINC4EwhEIae0lw+9gsTkNjf92azqomY4q7IyfERfnUJDrHkE4aoN4r0EQ==
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr3782788lfl.282.1604341191910; 
 Mon, 02 Nov 2020 10:19:51 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c6sm2527007lfm.226.2020.11.02.10.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 10:19:51 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [RFC PATCH 1/6] net: Added SetSteeringEBPF method for NetClientState.
Date: Mon,  2 Nov 2020 20:51:11 +0200
Message-Id: <20201102185115.7425-2-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102185115.7425-1-andrew@daynix.com>
References: <20201102185115.7425-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::142;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, Andrew <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

For now, that method supported only by Linux TAP.
Linux TAP uses TUNSETSTEERINGEBPF ioctl.
TUNSETSTEERINGBPF was added 3 years ago.
Qemu checks if it was defined before using.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/net/net.h |  2 ++
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 19 +++++++++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap.c         |  9 +++++++++
 net/tap_int.h     |  1 +
 7 files changed, 46 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 897b2d7595..d8a41fb010 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -60,6 +60,7 @@ typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
 typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
+typedef bool (SetSteeringEBPF)(NetClientState *, int);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -81,6 +82,7 @@ typedef struct NetClientInfo {
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
     NetAnnounce *announce;
+    SetSteeringEBPF *set_steering_ebpf;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 77aaf674b1..4f64f31e98 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -259,3 +259,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
 {
     return -1;
 }
+
+int tap_fd_set_steering_ebpf(int fd, int prog_fd)
+{
+    return -1;
+}
diff --git a/net/tap-linux.c b/net/tap-linux.c
index b0635e9e32..196373019f 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -31,6 +31,7 @@
 
 #include <net/if.h>
 #include <sys/ioctl.h>
+#include <linux/if_tun.h> /* TUNSETSTEERINGEBPF */
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -316,3 +317,21 @@ int tap_fd_get_ifname(int fd, char *ifname)
     pstrcpy(ifname, sizeof(ifr.ifr_name), ifr.ifr_name);
     return 0;
 }
+
+int tap_fd_set_steering_ebpf(int fd, int prog_fd)
+{
+#ifdef TUNSETSTEERINGEBPF
+    if (ioctl(fd, TUNSETSTEERINGEBPF, (void *) &prog_fd) != 0) {
+        error_report("Issue while setting TUNSETSTEERINGEBPF:"
+                    " %s with fd: %d, prog_fd: %d",
+                    strerror(errno), fd, prog_fd);
+
+       return -1;
+    }
+
+    return 0;
+#else
+    error_report("TUNSETSTEERINGEBPF is not supported");
+    return -1;
+#endif
+}
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 0475a58207..d85224242b 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -255,3 +255,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
 {
     return -1;
 }
+
+int tap_fd_set_steering_ebpf(int fd, int prog_fd)
+{
+    return -1;
+}
diff --git a/net/tap-stub.c b/net/tap-stub.c
index de525a2e69..a0fa25804b 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -85,3 +85,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
 {
     return -1;
 }
+
+int tap_fd_set_steering_ebpf(int fd, int prog_fd)
+{
+    return -1;
+}
diff --git a/net/tap.c b/net/tap.c
index c46ff66184..81f50017bd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -337,6 +337,14 @@ static void tap_poll(NetClientState *nc, bool enable)
     tap_write_poll(s, enable);
 }
 
+static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+
+    return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
+}
+
 int tap_get_fd(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -362,6 +370,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
+    .set_steering_ebpf = tap_set_steering_ebpf,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
diff --git a/net/tap_int.h b/net/tap_int.h
index 225a49ea48..547f8a5a28 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -44,5 +44,6 @@ int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
 int tap_fd_disable(int fd);
 int tap_fd_get_ifname(int fd, char *ifname);
+int tap_fd_set_steering_ebpf(int fd, int prog_fd);
 
 #endif /* NET_TAP_INT_H */
-- 
2.28.0


