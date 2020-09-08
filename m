Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636ACC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086F32067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6OFu2dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086F32067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFilh-0003Y0-5I
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFih7-0002nL-HJ; Tue, 08 Sep 2020 14:50:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:39436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFih4-0002h9-CG; Tue, 08 Sep 2020 14:50:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id n14so3776126pff.6;
 Tue, 08 Sep 2020 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFEZh3+xvAfqz2f0h/nVnmxCipA8eA9k8U4UHOk894U=;
 b=V6OFu2dg6CZvLJjbfgWJjGtZFKLFtNuLZXNc1L3aFXCcKG/2ZpUzCIy8KSpTu+6+sd
 NcQjFfA27TxpZISu5N8PGBte5xj1A6DgMM7+nrp5hAhRO4Pi/EgZ3UadkDe9BH5ps/iR
 op14hBtrLxq+nKPNyWj6NVD+3Kvl/YH3eABMKDcF7uYq09GXh+5HjJi+cM990LkXI6QR
 SIx44jMPCsgoums1CY0CpG8LIXlh8cDmSnwuRbZTi2LffQaX5q2uQDDQhEyf/DkNCzVH
 GwkQ+SoO80Fwl/KJ+bb3lTBStzyHKZC/vi/aBNx0QFAIMKuEIFg0RedxtBTPchuf1MUr
 FJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFEZh3+xvAfqz2f0h/nVnmxCipA8eA9k8U4UHOk894U=;
 b=PuXDC+zSMX8+n8aY3k4rsBS8TNp7eQUmeFeA69azP3J4XAMminuKOIHOT/iBLnB73H
 KhNgmwI+Wxz/rImMO8ue3QcGsLvlGnbt4+gob6WzTF+gflWnxW2sNJ+HEVNjILad1gTF
 VJYaUQw3Lne7E1arfsE3OQJ8lyWJXbKkOZkmH9kMzw1Wv5feosUDNx4DPMSWg2p/yv2c
 9O+6Q1+eXKOfaCSJcx4z/sPRCfVACgLL0I/KMTwoljAFWeQmmNjJanZt89om3JpIczLO
 lC8+aNAILkJyG3nZPx54rpbXm/9KIn7KIWr6uIcl60qApLrWSq6iNa93h572YTnASU2R
 p0Nw==
X-Gm-Message-State: AOAM533wPpy6xDk1Df8fRWUCBWJ8Sqqd2tlK8ppJu6xzC7NePO2fGAiv
 t312BPHFA8KYa8DDlGBobvXAdCtoGzw3ljV6
X-Google-Smtp-Source: ABdhPJxltAQNJQpjpo6QySn0Om5mVDidGep+Vu7ytVk+Z9fksOba0nhu8czLC/wAi8SNPDfgLTQ4Bg==
X-Received: by 2002:a17:902:b786:: with SMTP id e6mr63063pls.5.1599591010601; 
 Tue, 08 Sep 2020 11:50:10 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] osdep: These function are only available on Non-Win32
 system.
Date: Wed,  9 Sep 2020 02:49:11 +0800
Message-Id: <20200908184918.1085-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
int qemu_unlock_fd(int fd, int64_t start, int64_t len);
int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
bool qemu_has_ofd_lock(void);

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 412962d91a..e80fddd1e8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -502,11 +502,11 @@ int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
-#endif
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
 bool qemu_has_ofd_lock(void);
+#endif
 
 #if defined(__HAIKU__) && defined(__i386__)
 #define FMT_pid "%ld"
-- 
2.28.0.windows.1


