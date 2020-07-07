Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACAFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 00:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849AB2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 00:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUPwI22+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849AB2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsbCj-0007d4-Iy
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 20:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gL0DXwMKCgkst8pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jkz.bounces.google.com>)
 id 1jsbC9-0007CM-2W
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 20:10:45 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:46303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gL0DXwMKCgkst8pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jkz.bounces.google.com>)
 id 1jsbC7-0004O7-4P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 20:10:44 -0400
Received: by mail-pg1-x549.google.com with SMTP id i1so31136696pgn.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=3bCb/DeLvR1Wu8wYoDZvL77E4HEM0tMKEKQsIpLt8xE=;
 b=SUPwI22+XCIyYK3OtwvWcotNDZl05MnWGPvt627Q3VHciScXhsDLQyk4ks+qt5uoX9
 cpVybZZ3tf5m241mHN/29PmMSDK0r9VGfNF0DHNvvERuvh1zyRwXdYxL2+xGRsQtMqRV
 H0l6QvUznBHKfURRS9cHGF1QPzHkZlJYAcJ/OIlumh24DbpXSbcZ29Ai3/hjvISjp8tG
 NP9voEUcPRzCwramWOXTqVrAyV5sRNlegYybC+hyBppKaTmGLcmGyqNuLNMRKOTG0C54
 +lIBoU1xumZ1JX1KuOGkbyTBO2fG/UCr+PoJDRUo4+f7Lv0c879xhfRwjEd0xKCdjJJT
 SD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=3bCb/DeLvR1Wu8wYoDZvL77E4HEM0tMKEKQsIpLt8xE=;
 b=o4LL3icLGXsyHJZM2dKLO0RY2art+3kjcvj9x/lSnGWcQ6YGHZAqpySq67ReEnxbkE
 KTmzSrNFjznLtHJInqEKFTFuf6NJkhGoWNdlD+V8cOA3XJOB13WmwNl1JZIF75ijsVUL
 YEt3Bk1Ti2y3kZ7+VcwP+8cnxACWEq9omASnz1oNgf6mxWUO7zJdhZl8N25hp6HhkHBV
 +VurbDd7ebenGhXbg9LZoz+G4SsVqUP5/rE+XR11V7stSDWxymvxs3itW+0t5s0dl00o
 7PLaXcB1K5dBMuIxryeIfynWbdEnzcK2YFltFU73H59OEipbA1GMdrDn3QgUZqH8BA8r
 rPxQ==
X-Gm-Message-State: AOAM533Q2JcAK50Hjw6Gt2JAlgPf/Pk25OaX7jv7kFh7Wna72LTfNgpT
 gh+9+Cea4K98/5Xo1QN+YSI5bv/AHPTLWkmejyal8psVOL69bDgVjKtWO8yXmuAbt+oIPQdy1r9
 JjalkH0q6wYx14M7M6dR9gxIc5qg2yaIIPTp+21jHCjJXxO9UqlgN
X-Google-Smtp-Source: ABdhPJxnA2Km8lcu1rh/t4wCikE26un8VSmSBMS7Z3s7NoC+A1aky3CsBWP2y75idJ/DvwrTrE2g6Z8=
X-Received: by 2002:a17:90a:266f:: with SMTP id
 l102mr1549506pje.144.1594080640525; 
 Mon, 06 Jul 2020 17:10:40 -0700 (PDT)
Date: Mon,  6 Jul 2020 17:10:36 -0700
Message-Id: <20200707001036.1671982-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] linux-user: Use EPROTONOSUPPORT for unimplemented netlink
 protocols
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3gL0DXwMKCgkst8pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jkz.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux uses the EPROTONOSUPPORT error code[1] if the users requests a
netlink socket with an unsupported netlink protocol. This change
switches linux-user to use the same code as Linux, instead of
EPFNOSUPPORT (which AFAIK is just an anachronistic version of
EAFNOSUPPORT).

Tested by compiling all linux-user targets on x86.

[1]:
https://github.com/torvalds/linux/blob/bfe91da29bfad9941d5d703d45e29f0812a20724/net/netlink/af_netlink.c#L683

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 97de9fb5c9..4ab9852600 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int protocol)
 #endif
          protocol == NETLINK_KOBJECT_UEVENT ||
          protocol == NETLINK_AUDIT)) {
-        return -TARGET_EPFNOSUPPORT;
+        return -TARGET_EPROTONOSUPPORT;
     }
 
     if (domain == AF_PACKET ||
-- 
2.27.0.212.ge8ba1cc988-goog


